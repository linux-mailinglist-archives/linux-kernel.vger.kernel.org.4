Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA805F9B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiJJItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:49:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60785EDE3;
        Mon, 10 Oct 2022 01:49:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E73F106F;
        Mon, 10 Oct 2022 01:49:34 -0700 (PDT)
Received: from [10.57.5.39] (unknown [10.57.5.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48B523F792;
        Mon, 10 Oct 2022 01:49:27 -0700 (PDT)
Message-ID: <2bc19b09-ea9b-46f6-dd11-27eadb7cd5da@arm.com>
Date:   Mon, 10 Oct 2022 09:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] cpufreq: Change macro for store scaling min/max
 frequency
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com
References: <20220930094821.31665-1-lukasz.luba@arm.com>
 <20221010053614.zu2f3btjlh7woxbj@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221010053614.zu2f3btjlh7woxbj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,


On 10/10/22 06:36, Viresh Kumar wrote:
> On 30-09-22, 10:48, Lukasz Luba wrote:
>> In order to prepare extension to the store_scaling_max_freq() remove
>> the macro and use two normal functions. The set value for max frequency
>> is important for the task scheduler.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 47 ++++++++++++++++++++++-----------------
>>   1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 69b3d61852ac..1f8b93f42c76 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -715,26 +715,33 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>>   	return ret;
>>   }
>>   
>> -/*
>> - * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
>> - */
>> -#define store_one(file_name, object)			\
>> -static ssize_t store_##file_name					\
>> -(struct cpufreq_policy *policy, const char *buf, size_t count)		\
>> -{									\
>> -	unsigned long val;						\
>> -	int ret;							\
>> -									\
>> -	ret = sscanf(buf, "%lu", &val);					\
>> -	if (ret != 1)							\
>> -		return -EINVAL;						\
>> -									\
>> -	ret = freq_qos_update_request(policy->object##_freq_req, val);\
>> -	return ret >= 0 ? count : ret;					\
>> -}
>> -
>> -store_one(scaling_min_freq, min);
>> -store_one(scaling_max_freq, max);
>> +static ssize_t store_scaling_max_freq
>> +(struct cpufreq_policy *policy, const char *buf, size_t count)
> 
> I thought we can't break right after function's name according to
> kernel's coding guidelines. Did you run checkpatch on this ?

The checkpatch didn't capture this, but you are right. I'll change this.

-----------------------------------------------
/tmp/cpufreq//0001-cpufreq-Change-macro-for-store-scaling-min-max-frequ.patch
WARNING: Prefer kstrto<type> to single variable sscanf
#49: FILE: drivers/cpufreq/cpufreq.c:724:
+	ret = sscanf(buf, "%lu", &val);

WARNING: Prefer kstrto<type> to single variable sscanf
#63: FILE: drivers/cpufreq/cpufreq.c:738:
+	ret = sscanf(buf, "%lu", &val);

total: 0 errors, 2 warnings, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

/tmp/cpufreq//0001-cpufreq-Change-macro-for-store-scaling-min-max-frequ.patch 
has style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
==============================================================
/tmp/cpufreq//0002-cpufreq-Update-CPU-capacity-reduction-in-store_scali.patch
total: 0 errors, 0 warnings, 36 lines checked

/tmp/cpufreq//0002-cpufreq-Update-CPU-capacity-reduction-in-store_scali.patch 
has no obvious style problems and is ready for submission.
==============================================================

-----------------------------------------------
