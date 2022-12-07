Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAA6459D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLGM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:29:15 -0500
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33FF2A258;
        Wed,  7 Dec 2022 04:29:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=cuibixuan@linux.alibaba.com;NM=0;PH=DS;RN=18;SR=0;TI=SMTPD_---0VWm2QMY_1670416146;
Received: from 30.221.148.76(mailfrom:cuibixuan@linux.alibaba.com fp:SMTPD_---0VWm2QMY_1670416146)
          by smtp.aliyun-inc.com;
          Wed, 07 Dec 2022 20:29:07 +0800
Message-ID: <ddc81946-8b76-ea49-ebf5-f2de2e30540d@linux.alibaba.com>
Date:   Wed, 7 Dec 2022 20:29:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC 2/2] ACPI: APEI: fix reboot caused by synchronous error loop
 because of memory_failure() failed
Content-Language: en-US
To:     Lv Ying <lvying6@huawei.com>, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, xueshuai@linux.alibaba.com,
        ashish.kalra@amd.com
Cc:     xiezhipeng1@huawei.com, wangkefeng.wang@huawei.com,
        xiexiuqi@huawei.com, tanxiaofei@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221205115111.131568-1-lvying6@huawei.com>
 <20221205115111.131568-3-lvying6@huawei.com>
From:   Bixuan Cui <cuibixuan@linux.alibaba.com>
In-Reply-To: <20221205115111.131568-3-lvying6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/5 19:51, Lv Ying 写道:
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3b6ac3694b8d..4c1c558f7161 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2266,7 +2266,11 @@ static void __memory_failure_work_func(struct work_struct *work, bool sync)
>   			break;
>   		if (entry.flags & MF_SOFT_OFFLINE)
>   			soft_offline_page(entry.pfn, entry.flags);
> -		else if (!sync || (entry.flags & MF_ACTION_REQUIRED))
> +		else if (sync) {
> +			if ((entry.flags & MF_ACTION_REQUIRED) &&
> +					memory_failure(entry.pfn, entry.flags))
> +				force_sig_mceerr(BUS_MCEERR_AR, 0, 0);
> +		} else
>   			memory_failure(entry.pfn, entry.flags);
Hi,

Some of the ideas in this patch are wrong :-(

1. As Shuai Xue said, it is wrong to judge synchronization error and 
asynchronization error through functions such as 
memory_failure_queue_kick()/ghes_proc()/ghes_proc_in_irq(), because both 
synchronization error and asynchronization error may go to the same 
notification.

2. There is no need to pass 'sync' to __memory_failure_work_func(), 
because memory_failure() can directly handle synchronous and 
asynchronous errors according to entry.flags & MF_ACTION_REQUIRED:

entry.flags & MF_ACTION_REQUIRED == 1: Action: poison page and kill task 
for synchronous error
entry.flags & MF_ACTION_REQUIRED == 0: Action: poison page for 
asynchronous error

Reference x86:
do_machine_check # MCE, synchronous
    ->kill_me_maybe
      ->memory_failure(p->mce_addr >> PAGE_SHIFT, MF_ACTION_REQUIRED);

uc_decode_notifier # CMCI, asynchronous
    ->memory_failure(pfn, 0)

At the same time, the modification here is repeated with your patch 01
  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = 0;
+		flags = sync ? MF_ACTION_REQUIRED : 0;

3. Why add 'force_sig_mceerr(BUS_MCEERR_AR, 0, 0)' after 
memory_failure(pfn, MF_ACTION_REQUIRED)?
The task will be killed in memory_failure():
if poisoned, kill_accessing_process()->kill_proc()
if not poisoned, hwpoison_user_mappings()->collect_procs()->kill_procs()

Reference x86 to handle synchronous error:
kill_me_maybe()
{
     int flags = MF_ACTION_REQUIRED;
     ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
     if (!ret) {
	...
         return;
     }
     if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
         return;

     pr_err("Memory error not recovered");
     kill_me_now(cb);
}


Thanks,
Bixuan Cui

