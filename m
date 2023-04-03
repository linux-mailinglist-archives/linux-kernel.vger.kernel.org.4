Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62A6D5012
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjDCSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjDCSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BB1BC1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D3962474
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C59AC4339B;
        Mon,  3 Apr 2023 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680545608;
        bh=k9UIDDogZc/t03m0KagHDvNc4egLIHvQ4Q7UQzVp8s4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHmWyod6H+DC5CakKf8PnWaJKQzHAudnn6MCqiAo2bnHdwbkIZy8Gvfnu1h79y3w6
         jz4GTodQpFR5RJMogzpPC3cHFYbYCF3b12EaHyqAOHmNIYVg1Kj3vAsINEgYUsycvY
         nqvZWDUCgVHCHl8HVHVW6yj3W2p0nn2HF6WD5kiDDspZE1pBydrvTXLdrZBLG9ZWwT
         vz13zToyR0xjOZ3rr1cVSKQPd/pyMTml7gctBY/QLsLJ7cJU6c6d6l2xpk2ynMjAwy
         qiRQKwsrBpbW0uDk5e/rAXiOW2/hyJLbHNxyz+l6ubYk6rzm+hP6qECfUC0AOu0aRU
         VSqBeYhHTk9CQ==
Date:   Mon, 3 Apr 2023 11:13:26 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
Message-ID: <ZCsXRin7symPxIrn@google.com>
References: <20230324071028.336982-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324071028.336982-1-chao@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24, Chao Yu wrote:
> In order to reclaim free blocks in prefree sections before latter use.

We were supposed to do checkpoint as is?

> 
> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    | 1 +
>  fs/f2fs/gc.c      | 8 ++++++++
>  fs/f2fs/segment.c | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 53a005b420cf..b1515375cb4c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1269,6 +1269,7 @@ struct f2fs_gc_control {
>  	unsigned int victim_segno;	/* target victim segment number */
>  	int init_gc_type;		/* FG_GC or BG_GC */
>  	bool no_bg_gc;			/* check the space and stop bg_gc */
> +	bool reclaim_space;		/* trigger checkpoint to reclaim space */
>  	bool should_migrate_blocks;	/* should migrate blocks */
>  	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
>  	unsigned int nr_free_secs;	/* # of free sections to do GC */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 2996d38aa89c..5a451d3d512d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -132,6 +132,7 @@ static int gc_thread_func(void *data)
>  
>  		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
>  		gc_control.no_bg_gc = foreground;
> +		gc_control.reclaim_space = foreground;
>  		gc_control.nr_free_secs = foreground ? 1 : 0;
>  
>  		/* if return value is not zero, no victim was selected */
> @@ -1880,6 +1881,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>  				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
>  		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
>  			goto go_gc_more;
> +
> +		/*
> +		 * trigger a checkpoint in the end of foreground garbage
> +		 * collection.
> +		 */
> +		if (gc_control->reclaim_space)
> +			ret = f2fs_write_checkpoint(sbi, &cpc);
>  		goto stop;
>  	}
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6c11789da884..b62af2ae1685 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -421,6 +421,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  				.victim_segno = NULL_SEGNO,
>  				.init_gc_type = BG_GC,
>  				.no_bg_gc = true,
> +				.reclaim_space = true,
>  				.should_migrate_blocks = false,
>  				.err_gc_skipped = false,
>  				.nr_free_secs = 1 };
> -- 
> 2.25.1
