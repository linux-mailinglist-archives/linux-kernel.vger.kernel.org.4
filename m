Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9E5BD9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiITByf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiITByb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:54:31 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1692FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:54:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQGZuw6_1663638864;
Received: from 30.240.98.170(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQGZuw6_1663638864)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 09:54:25 +0800
Message-ID: <ff9f1b54-5d50-a43d-62a7-3e1adadf1974@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 09:54:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/2] mm/damon/sysfs: remove unnecessary variables
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220919170305.61335-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220919170305.61335-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/20 上午1:03, SeongJae Park 写道:
> On Mon, 19 Sep 2022 23:12:00 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> Just do a little change here, the 'err' variable really no need to stay
>> here.
>>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   mm/damon/sysfs.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
>> index 0cca1909bf67..b852a75b9f39 100644
>> --- a/mm/damon/sysfs.c
>> +++ b/mm/damon/sysfs.c
>> @@ -1109,9 +1109,8 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>   	struct damon_sysfs_region *region = container_of(kobj,
>>   			struct damon_sysfs_region, kobj);
>> -	int err = kstrtoul(buf, 0, &region->start);
>>
>> -	if (err)
>> +	if (kstrtoul(buf, 0, &region->start))
>>   		return -EINVAL;
> Good finding.  But, I'd like to let the user know why it really fails by giving
> them the error code that returned by 'kstrtoul()' here.  Let's keep the 'err'
> but return 'err' here.
Ok,  it make sense.
>
>>   	return count;
>>   }
>> @@ -1130,9 +1129,8 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   {
>>   	struct damon_sysfs_region *region = container_of(kobj,
>>   			struct damon_sysfs_region, kobj);
>> -	int err = kstrtoul(buf, 0, &region->end);
>>
>> -	if (err)
>> +	if (kstrtoul(buf, 0, &region->end))
>>   		return -EINVAL;
> ditto.
>
>>   	return count;
>>   }
>> --
>> 2.31.0
>
> Thanks,
> SJ
