Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0C63B4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiK1WKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiK1WKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D961DDF9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E107B80F79
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B987C433D7;
        Mon, 28 Nov 2022 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669673397;
        bh=bqj9g+jLTDji4I+GdGiDgNX5c3aziUxLgv0yWrH7unI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIla2H6y76Y5sfcMxSJteSS74PM6efM3vqzdoeThZYkS2QkzWX4vbIz+ZXNYwXkth
         NxX/nLO94jKO0kATGgYeozLSM9F5yv1yK5WpkWlcTTiQMy12JZ8nce8qesA4i2q2ff
         y4jlI82UN+C4TfTed8RIwjqkIC5vAmIFKt106yKrRlDUyNB9uh/FT5gdIc7IBNDsn5
         xx8vPG5mgZBbvNwteX+78mJB0O7dVRZH4imrk0pR5giAxqaAkMxMaSB0zuPjQOV2WZ
         IssGnrdT+PvLd0MJXe5P06SkvgqOAoHIHZsWUTqQHvoXq2iJ2qK/6pFSmZWI4CmCGd
         NOiYzLr1lR8DA==
Date:   Mon, 28 Nov 2022 14:09:55 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add support for counting the average time of
 submit discard cmd
Message-ID: <Y4UxswxCt/Ew/X/X@google.com>
References: <20221123132502.72078-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123132502.72078-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to run checkpatch?

On 11/23, Yangtao Li wrote:
> This patch adds support for counting the average time of submit discard
> command, and we can see its value in debugfs.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/debug.c   |  7 +++++--
>  fs/f2fs/f2fs.h    |  5 +++++
>  fs/f2fs/segment.c | 17 +++++++++++++++--
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index a216dcdf6941..ede862cb178d 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -109,6 +109,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
>  	}
>  	if (SM_I(sbi)->dcc_info) {
> +		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +		si->discard_avg = dcc->discard_time_avg;
>  		si->nr_discarded =
>  			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
>  		si->nr_discarding =
> @@ -506,11 +509,11 @@ static int stat_show(struct seq_file *s, void *v)
>  		seq_printf(s, "  - IO_R (Data: %4d, Node: %4d, Meta: %4d\n",
>  			   si->nr_rd_data, si->nr_rd_node, si->nr_rd_meta);
>  		seq_printf(s, "  - IO_W (CP: %4d, Data: %4d, Flush: (%4d %4d %4d), "
> -			"Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
> +					  "Discard: (%4d %4d avg:%4lldns)) cmd: %4d undiscard:%4u\n",
>  			   si->nr_wb_cp_data, si->nr_wb_data,
>  			   si->nr_flushing, si->nr_flushed,
>  			   si->flush_list_empty,
> -			   si->nr_discarding, si->nr_discarded,
> +			   si->nr_discarding, si->nr_discarded, ktime_to_us(si->discard_avg),
>  			   si->nr_discard_cmd, si->undiscard_blks);
>  		seq_printf(s, "  - atomic IO: %4d (Max. %4d)\n",
>  			   si->aw_cnt, si->max_aw_cnt);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f0833638f59e..6891467fdb6a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -372,6 +372,8 @@ struct discard_cmd {
>  	int error;			/* bio error */
>  	spinlock_t lock;		/* for state/bio_ref updating */
>  	unsigned short bio_ref;		/* bio reference count */
> +	struct discard_cmd_control *dcc; /* global discard cmd control */
> +	ktime_t submit_start;		/* submit start time */
>  };
>  
>  enum {
> @@ -415,6 +417,8 @@ struct discard_cmd_control {
>  	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
>  	unsigned int undiscard_blks;		/* # of undiscard blocks */
>  	unsigned int next_pos;			/* next discard position */
> +	spinlock_t discard_time_lock;	/* for discard time statistics */
> +	ktime_t discard_time_avg;		/* issued discard cmd avg time */
>  	atomic_t issued_discard;		/* # of issued discard */
>  	atomic_t queued_discard;		/* # of queued discard */
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
> @@ -3883,6 +3887,7 @@ struct f2fs_stat_info {
>  	int nr_dio_read, nr_dio_write;
>  	unsigned int io_skip_bggc, other_skip_bggc;
>  	int nr_flushing, nr_flushed, flush_list_empty;
> +	ktime_t	discard_avg;
>  	int nr_discarding, nr_discarded;
>  	int nr_discard_cmd;
>  	unsigned int undiscard_blks;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b0b76550578..dd67e936615a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -936,6 +936,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
>  	list_add_tail(&dc->list, pend_list);
>  	spin_lock_init(&dc->lock);
>  	dc->bio_ref = 0;
> +	dc->dcc = dcc;
>  	atomic_inc(&dcc->discard_cmd_cnt);
>  	dcc->undiscard_blks += len;
>  
> @@ -1005,9 +1006,13 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
>  static void f2fs_submit_discard_endio(struct bio *bio)
>  {
>  	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> +	struct discard_cmd_control *dcc = dc->dcc;
>  	unsigned long flags;
> +	ktime_t submit_time;
> +	int nr_discarded;
>  
>  	spin_lock_irqsave(&dc->lock, flags);
> +	submit_time = ktime_sub(ktime_get(), dc->submit_start);
>  	if (!dc->error)
>  		dc->error = blk_status_to_errno(bio->bi_status);
>  	dc->bio_ref--;
> @@ -1017,6 +1022,13 @@ static void f2fs_submit_discard_endio(struct bio *bio)
>  	}
>  	spin_unlock_irqrestore(&dc->lock, flags);
>  	bio_put(bio);
> +
> +	spin_lock_irqsave(&dcc->discard_time_lock, flags);
> +	nr_discarded = atomic_read(&dcc->issued_discard);
> +	dcc->discard_time_avg = div_u64(ktime_add(nr_discarded * dcc->discard_time_avg, submit_time),
> +									nr_discarded + 1);
> +	atomic_inc(&dcc->issued_discard);
> +	spin_unlock_irqrestore(&dcc->discard_time_lock, flags);
>  }
>  
>  static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> @@ -1165,6 +1177,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		 * right away
>  		 */
>  		spin_lock_irqsave(&dc->lock, flags);
> +		dc->submit_start = ktime_get();
>  		if (last)
>  			dc->state = D_SUBMIT;
>  		else
> @@ -1184,8 +1197,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		bio->bi_opf |= flag;
>  		submit_bio(bio);
>  
> -		atomic_inc(&dcc->issued_discard);
> -
>  		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
>  
>  		lstart += len;
> @@ -2076,9 +2087,11 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	INIT_LIST_HEAD(&dcc->wait_list);
>  	INIT_LIST_HEAD(&dcc->fstrim_list);
>  	mutex_init(&dcc->cmd_lock);
> +	spin_lock_init(&dcc->discard_time_lock);
>  	atomic_set(&dcc->issued_discard, 0);
>  	atomic_set(&dcc->queued_discard, 0);
>  	atomic_set(&dcc->discard_cmd_cnt, 0);
> +	dcc->discard_time_avg = 0;
>  	dcc->nr_discards = 0;
>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>  	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
> -- 
> 2.25.1
