Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9695B5F0369
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiI3Dqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3Dqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:46:35 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB31D929B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:46:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VR0KQ4u_1664509589;
Received: from 30.240.98.80(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VR0KQ4u_1664509589)
          by smtp.aliyun-inc.com;
          Fri, 30 Sep 2022 11:46:31 +0800
Message-ID: <61df199f-5579-933e-3f11-35f204f93bf4@linux.alibaba.com>
Date:   Fri, 30 Sep 2022 11:46:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v1] mm/damon: add DAMON_OBJ macro
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220921164143.59971-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220921164143.59971-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SJ,

在 2022/9/22 上午12:41, SeongJae Park 写道:
> Hi Xin,
>
> On Wed, 21 Sep 2022 11:49:42 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon/sysfs.c file, we use 'container_of' macro to get
>> damon_sysfs_xxx struct instances, but i think it has a little
>> inconvenience, because we have to pass three arguments to
>> 'container_of', and the codes also look a bit long, so there i add a
>> 'DAMON_OBJ' macro, you just need to pass one arguments, then you can get
>> the right damon_sysfs_xxx struct instance.
> Thank you always for your helps and efforts, but I have some comments below.
>
>> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
>> ---
>>   include/linux/damon.h |   7 ++
>>   mm/damon/sysfs.c      | 230 +++++++++++++++++-------------------------
>>   2 files changed, 102 insertions(+), 135 deletions(-)
>>
>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>> index e7808a84675f..a3b577677caa 100644
>> --- a/include/linux/damon.h
>> +++ b/include/linux/damon.h
>> @@ -24,6 +24,13 @@ static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>>   	return l + prandom_u32_max(r - l);
>>   }
>>   
>> +/*
>> + * Get damon_sysfs_xxx relative struct instance.
>> + */
>> +#define DAMON_OBJ(_type) ({						\
>> +	const typeof(((struct _type *)0)->kobj)*__mptr = (kobj);	\
>> +	(struct _type *)((char *)__mptr - offsetof(struct _type, kobj)); })
>> +
> So, this macro assumes two implicit rules.
> 1. The caller would have a relevant 'struct kobject *' variable called 'kobj',
>     and
> 2. The '_type' would have the field 'kobj'.
>
> I think the implicit rules could make some people confused, so would be better
> to be well documented.  Even though those are well documented, I think it
> cannot intuitively read by everyone.  Making the name better self-explaining
> might help, but then the length of the code would be not so different.
>
> So IMHO, this change makes the code a little bit shorter but unclear to
> understand what it does.  And at least to my humble eyes, use of
> 'container_of()' makes the code a little bit more verbose, but clear to
> understand.  I have no idea how we can make this code shorter while keeping it
> still easily understandable, and I think the level of verboseness is acceptable
> for the readability.  So Nack at the moment, sorry.

I really feel the need to do that， how about keep it in the sysfs.c 
file, and change it like this：

#define DAMON_OBJ(_struct) container_of(kobj, struct _struct, kobj)

it will feel easy to understand and made sense.

>
>
> Thanks,
> SJ
>
> [...]
