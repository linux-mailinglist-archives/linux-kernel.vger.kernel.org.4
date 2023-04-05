Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A436D723F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjDECCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDECCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144092708
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A726963AD1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA21C433D2;
        Wed,  5 Apr 2023 02:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680660141;
        bh=ZeFr2GyRTnTuTL7d6gy/Q0vHZiCuLFauR+rwD51DYIE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=O3DExJC8FfSm9sm3ey9rcoXjBXQ85dhCo/TweEc6mGHSzuYojcRrMUZHUs8Zobrcy
         Uehg9BJcLLxUPpP5GAwpJo0ALGqQyXO8Ju7AUTtGI44dj+kk0xQE8p3QbNc5BfcIv/
         S37teI0e7fgNQMRAxW5mYblRXtMHPGpPLOf/T5pbOos50qP6yNhuwhljuwnHbXbdd1
         OPcH+aDhxRrAkGpmTrcsGlU2NEJi+Cy4pPOmnduqhJ1h6vAYjApEp8KCVQ6Nhgb9lD
         niZFXsV/z7db07EekFhDk0iZ+VCSuNjhlDWs6kMAICbIfYoPkmT2TW77U8HgE3bN0B
         LmQTpa4C7n0Pw==
Message-ID: <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
Date:   Wed, 5 Apr 2023 10:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCyZGgf4RSEjyHTF@google.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
In-Reply-To: <ZCyZGgf4RSEjyHTF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/5 5:39, Jaegeuk Kim wrote:
> Can we do like this?
> 
>  From 9a58f0e59364241aa31b555cfe793d278e39b0dc Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 4 Apr 2023 14:36:00 -0700
> Subject: [PATCH] f2fs: do checkpoint when there's not enough free sections
> 
> We didn't do checkpoint in FG_GC case, which may cause losing to reclaim prefree
> sctions in time.
> 
> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
> Signed-off-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/gc.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 56c53dbe05c9..f1d0dd9c5a6c 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1806,6 +1806,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   	};
>   	unsigned int skipped_round = 0, round = 0;
>   	unsigned int upper_secs;
> +	bool stop_gc = false;
>   
>   	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
>   				gc_control->nr_free_secs,
> @@ -1876,19 +1877,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
>   		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
>   			goto go_gc_more;
> -		goto stop;
> -	}
> -
> -	/* FG_GC stops GC by skip_count */
> -	if (gc_type == FG_GC) {
> +		stop_gc = true;

I guess below condition is for emergency recycle of prefree segments during
foreground GC, in order to avoid exhausting free sections due to to many
metadata allocation during CP.

	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
				prefree_segments(sbi)) {

But for common case, free_sections() is close to reserved_segments(), and
upper_secs + NR_GC_CHECKPOINT_SECS value may be far smaller than free_sections(),
so checkpoint may not be trggered as expected, IIUC.

So it's fine to just trigger CP in the end of foreground garbage collection?

One other concern is for those path as below:
- disable_checkpoint
- ioc_gc
- ioc_gc_range
- ioc_resize
...

We've passed gc_type as FG_GC, but the demand here is to migrate block in time,
rather than dirtying blocks, and callers don't expect checkpoint in f2fs_gc(),
instead the callers will do the checkpoit as it needs.

That means it's better to decouple FG_GC and write_checkpoint behavior, so I
added another parameter .reclaim_space to just let f2fs_balance_fs() to trigger
checkpoit in the end of f2fs_gc().

Thanks,

> +	} else if (gc_type == FG_GC) {
> +		/* FG_GC stops GC by skip_count */
>   		if (sbi->skipped_gc_rwsem)
>   			skipped_round++;
>   		round++;
>   		if (skipped_round > MAX_SKIP_GC_COUNT &&
> -				skipped_round * 2 >= round) {
> -			ret = f2fs_write_checkpoint(sbi, &cpc);
> -			goto stop;
> -		}
> +				skipped_round * 2 >= round)
> +			stop_gc = true;
>   	}
>   
>   	__get_secs_required(sbi, NULL, &upper_secs, NULL);
> @@ -1901,12 +1898,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   				prefree_segments(sbi)) {
>   		ret = f2fs_write_checkpoint(sbi, &cpc);
>   		if (ret)
> -			goto stop;
> +			stop_gc = true;
>   	}
>   go_gc_more:
> -	segno = NULL_SEGNO;
> -	goto gc_more;
> -
> +	if (!stop_gc) {
> +		segno = NULL_SEGNO;
> +		goto gc_more;
> +	}
>   stop:
>   	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
>   	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
