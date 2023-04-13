Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48106E09E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDMJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EE9975A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FAC63CB7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45994C433D2;
        Thu, 13 Apr 2023 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681377349;
        bh=yvu+LldXJrLBPxrSdY63YC5/guSRhjJdIzg4/OHP/P0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OyNeI8+5L8xkAbYU6xSKs0OaSv8rdj0nKzfMPpxHo8cBA5HJ1tCedu2eleeoxcYaY
         0UffZNl+ycUA4bhyM+bD4X2lB7vVfOMYq1R+Am/ekQBeL/Ocr6uteqbVJ6ARAvCjqK
         XfTmz8q2EhXDQb1ST4oxUltjO79NaNNoAkxA7nGZX/1a0dI8cDw2jSwXeUEEBObSUe
         E0yKQ3/FDJP3Z09Ij+qDOql5lsfeCZmad8qpsCiO+ZIafM2rwG0BzmXFY3QPQElCMa
         MQQ5TeZxjOSbhJGth5WUqnnBnwqdZ2BaTTuMeDSwo1wncrAtwxs+7Hno0xuKbRY0NR
         8Yo2kU+Ze1vmQ==
Message-ID: <6c9abd05-297a-ea4f-fd5c-9f4d9fb488ab@kernel.org>
Date:   Thu, 13 Apr 2023 17:15:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCyZGgf4RSEjyHTF@google.com>
 <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
 <ZC2aA+i5+HpdJ6M2@google.com>
 <f4ae2b3a-0aff-8941-4081-9dc53334c590@kernel.org>
 <ZDSaCsLSYLyzUxBQ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDSaCsLSYLyzUxBQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/11 7:21, Jaegeuk Kim wrote:
> On 04/10, Chao Yu wrote:
>> On 2023/4/5 23:55, Jaegeuk Kim wrote:
>>> On 04/05, Chao Yu wrote:
>>>> On 2023/4/5 5:39, Jaegeuk Kim wrote:
>>>>> Can we do like this?
>>>>>
>>>>>    From 9a58f0e59364241aa31b555cfe793d278e39b0dc Mon Sep 17 00:00:00 2001
>>>>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> Date: Tue, 4 Apr 2023 14:36:00 -0700
>>>>> Subject: [PATCH] f2fs: do checkpoint when there's not enough free sections
>>>>>
>>>>> We didn't do checkpoint in FG_GC case, which may cause losing to reclaim prefree
>>>>> sctions in time.
>>>>>
>>>>> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>     fs/f2fs/gc.c | 24 +++++++++++-------------
>>>>>     1 file changed, 11 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index 56c53dbe05c9..f1d0dd9c5a6c 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -1806,6 +1806,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>>>>     	};
>>>>>     	unsigned int skipped_round = 0, round = 0;
>>>>>     	unsigned int upper_secs;
>>>>> +	bool stop_gc = false;
>>>>>     	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
>>>>>     				gc_control->nr_free_secs,
>>>>> @@ -1876,19 +1877,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>>>>>     				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
>>>>>     		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
>>>>>     			goto go_gc_more;
>>>>> -		goto stop;
>>>>> -	}
>>>>> -
>>>>> -	/* FG_GC stops GC by skip_count */
>>>>> -	if (gc_type == FG_GC) {
>>>>> +		stop_gc = true;
>>>>
>>>> I guess below condition is for emergency recycle of prefree segments during
>>>> foreground GC, in order to avoid exhausting free sections due to to many
>>>> metadata allocation during CP.
>>>>
>>>> 	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
>>>> 				prefree_segments(sbi)) {
>>>>
>>>> But for common case, free_sections() is close to reserved_segments(), and
>>>> upper_secs + NR_GC_CHECKPOINT_SECS value may be far smaller than free_sections(),
>>>> so checkpoint may not be trggered as expected, IIUC.
>>>>
>>>> So it's fine to just trigger CP in the end of foreground garbage collection?
>>>
>>> My major concern is to avoid unnecessary checkpointing given multiple FG_GC
>>> requests were pending in parallel. And, I don't want to add so many combination
>>> which gives so many corner cases, and feel f2fs_gc() needs to call checkpoint
>>> automatically in the worst case scenario only.
>>
>> Alright.
>>
>>>
>>> By the way, do we just need to call checkpoint here including FG_GC as well?
>>
>> I didn't get it, do you mean?
>>
>> - f2fs_balance_fs()
>>   - f2fs_gc() creates prefree segments but not call checkpoint to reclaim
>>
>> - f2fs_balance_fs()
>>   - f2fs_gc()
>>    - detect prefree segments created by last f2fs_balance_fs, then call
>> f2fs_write_checkpoint to reclaim
>>
>> Or could you please provide a draft patch? :-P
> 
> Testing this.
> 
>  From ec5f37bbe33110257c04e0ec97a80b0111465b52 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 10 Apr 2023 14:48:50 -0700
> Subject: [PATCH] f2fs: refactor f2fs_gc to call checkpoint in urgent condition
> 
> The major change is to call checkpoint, if there's not enough space while having
> some prefree segments in FG_GC case.

I found generic/269 will hang w/ this patch.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index c748cdfb0501..0a823d2e8b9d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1829,7 +1829,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   		goto stop;
>   	}
>   
> -	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
> +	/* Let's run FG_GC, if we don't have enough space. */
> +	if (has_not_enough_free_secs(sbi, 0, 0)) {
> +		gc_type = FG_GC;
> +
>   		/*
>   		 * For example, if there are many prefree_segments below given
>   		 * threshold, we can make them free by checkpoint. Then, we
> @@ -1840,8 +1843,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   			if (ret)
>   				goto stop;
>   		}
> -		if (has_not_enough_free_secs(sbi, 0, 0))
> -			gc_type = FG_GC;
>   	}
>   
>   	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> @@ -1868,19 +1869,14 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   	if (seg_freed == f2fs_usable_segs_in_sec(sbi, segno))
>   		sec_freed++;
>   
> -	if (gc_type == FG_GC)
> +	if (gc_type == FG_GC) {
>   		sbi->cur_victim_sec = NULL_SEGNO;
>   
> -	if (gc_control->init_gc_type == FG_GC ||
> -	    !has_not_enough_free_secs(sbi,
> -				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
> -		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
> -			goto go_gc_more;
> -		goto stop;
> -	}
> -
> -	/* FG_GC stops GC by skip_count */
> -	if (gc_type == FG_GC) {
> +		if (!has_not_enough_free_secs(sbi, sec_freed, 0)) {
> +			if (sec_freed < gc_control->nr_free_secs)
> +				goto go_gc_more;
> +			goto stop;
> +		}
>   		if (sbi->skipped_gc_rwsem)
>   			skipped_round++;
>   		round++;
> @@ -1889,6 +1885,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   			ret = f2fs_write_checkpoint(sbi, &cpc);
>   			goto stop;
>   		}
> +	} else if (!has_not_enough_free_secs(sbi, 0, 0)) {
> +		goto stop;
>   	}
>   
>   	__get_secs_required(sbi, NULL, &upper_secs, NULL);
