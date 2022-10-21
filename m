Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E3606FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJUGLl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Oct 2022 02:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJUGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:11:39 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E36109D64;
        Thu, 20 Oct 2022 23:11:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VSi31.b_1666332694;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VSi31.b_1666332694)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 14:11:35 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/1] cpufreq: Fix show()/store() issue for hotplugging
 offline CPU
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <CAJZ5v0h=tPw8K30_yTh6rq3Pbnvx2MzQH5+kiMq3UAeUFXGWRA@mail.gmail.com>
Date:   Fri, 21 Oct 2022 14:11:33 +0800
Cc:     schspa@gmail.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "zelin.deng@linux.alibaba.com" <zelin.deng@linux.alibaba.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <149754EC-1CD5-4D6C-90C6-6F13AB319C00@linux.alibaba.com>
References: <1666168845-67690-1-git-send-email-guanjun@linux.alibaba.com>
 <1666168845-67690-2-git-send-email-guanjun@linux.alibaba.com>
 <CAJZ5v0h=tPw8K30_yTh6rq3Pbnvx2MzQH5+kiMq3UAeUFXGWRA@mail.gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

> 2022年10月19日 下午7:47，Rafael J. Wysocki <rafael@kernel.org> 写道：
> 
> On Wed, Oct 19, 2022 at 10:40 AM Guanjun <guanjun@linux.alibaba.com> wrote:
>> 
>> From: Zelin Deng <zelin.deng@linux.alibaba.com>
>> 
>> After brought one CPU offline, lscpu returned failure:
>> 
>> lscpu: cannot read /sys/devices/system/cpu/cpu64/cpufreq/cpuinfo_max_freq: Device or resource busy
>> 
>> which had blocked all outputs of lscpu.
> 
> OK, so the policy->cpus mask is empty and -EBUSY is returned.
> 
> What's wrong?

Here is all right.
The problem is that when I offline one cpu manually and lscpu will fail.
The reproduce process is as follows:
1. lscpu （success）
2. echo 0 > /sys/devices/system/cpu/cpu63/online （offline cpu63）
3. lscpu （fail， and print the error message, “lscpu: cannot read /sys/devices/system/cpu/cpu64/cpufreq/cpuinfo_max_freq: Device or resource busy”）

I think this failure doesn’t make sense.

Maybe I should make the commit message more readable.

Thanks,
Guanjun

> 
>> This is not the case mentioned in commit d4627a287e251, as the policy
>> had been created successfully but is inactive due to CPU gets offline.
> 
> Yes, that's when policy_is_inactive(policy) returns "true" IIUC.
> 
>> To fix this issue, just add an addtional check whether CPU is online or
>> not.
> 
> Which is racy.
> 
> Please explain the problem in the first place.
> 
>> Fixes: d4627a287e251 ("cpufreq: Abort show()/store() for half-initialized policies")
>> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
>> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
>> ---
>> drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>> 1 file changed, 12 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 69b3d61852ac..aa238ba7d2fe 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -956,8 +956,12 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
>>                return -EIO;
>> 
>>        down_read(&policy->rwsem);
>> -       if (likely(!policy_is_inactive(policy)))
>> -               ret = fattr->show(policy, buf);
>> +       if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
>> +               goto err;
>> +
>> +       ret = fattr->show(policy, buf);
>> +
>> +err:
>>        up_read(&policy->rwsem);
>> 
>>        return ret;
>> @@ -974,8 +978,12 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>>                return -EIO;
>> 
>>        down_write(&policy->rwsem);
>> -       if (likely(!policy_is_inactive(policy)))
>> -               ret = fattr->store(policy, buf, count);
>> +       if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
>> +               goto err;
>> +
>> +       ret = fattr->store(policy, buf, count);
>> +
>> +err:
>>        up_write(&policy->rwsem);
>> 
>>        return ret;
>> --
>> 2.32.0.GIT

