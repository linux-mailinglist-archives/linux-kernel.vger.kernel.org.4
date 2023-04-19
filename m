Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67D6E82B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjDSU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDSU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA41B7D9A;
        Wed, 19 Apr 2023 13:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34D3463875;
        Wed, 19 Apr 2023 20:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CEC433EF;
        Wed, 19 Apr 2023 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681936124;
        bh=MSsSheeg5fGf437QacQci3glGSqLc1kiU4gOJI2sAtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnoj4+N+sye7VKuYWb7LXqDKB+f0FwQCzzCzrOUGmB6Xi8SNq199ziBXI4sCahXKh
         63ErzGOvZ/BwAUvBQqd6UEOHUXzGWAclaAkTxaLNJdIV2Th3229JTc5QQ3y7BdjueY
         XuT4CW5cE23vEGu9Q4nsEdqkHd4r4ue82QAFD5Gvl8zTusx9qNmYRoe4C/kpLEUtnh
         CEl9L/bMnYJNq7c8556C2pnQmenllgBcaPHFPxeCf2p2Fwr8Rz5ePdBBP87T8vGJ5v
         4hmJgZCSO526xn9PvcVv72mddSAW0PLAun0W/KVdtZon1/uNk363lj4z+vru8bTCKX
         BO4fFk6oXiKVw==
Date:   Wed, 19 Apr 2023 13:28:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>
Subject: Re: [PATCH] f2fs: add async reset zone command support
Message-ID: <ZEBO+qOLXbnYusw5@google.com>
References: <CGME20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a@epcms2p5>
 <20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414025921epcms2p5736ebf6a215201e0c2a2c1a3f73ee06a@epcms2p5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Daejun Park wrote:
> This patch enables submit reset zone command asynchornously. It helps
> decrease average latency of write IOs in high utilization scenario by
> faster checkpointing.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  Documentation/filesystems/f2fs.rst |  4 ++
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/segment.c                  | 92 +++++++++++++++++++++++++++++-
>  fs/f2fs/super.c                    |  8 +++
>  include/trace/events/f2fs.h        | 18 +++++-
>  5 files changed, 119 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 2055e72871fe..4cfabf831a79 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -342,6 +342,10 @@ discard_unit=%s		 Control discard unit, the argument can be "block", "segment"
>  			 default, it is helpful for large sized SMR or ZNS devices to
>  			 reduce memory cost by getting rid of fs metadata supports small
>  			 discard.
> +async_reset_zone         Enable the RESET WRITE POINTER command to be submitted asynchronously.
> +                         With this option, the RESET WRITE POINTER command can be processed by
> +                         the discard thread like a discard command. It can reduce checkpoint
> +                         latency by asynchronously checking for completion of the RESET WRITE POINTER command.

Do we need to set this by default instead of mount option?

>  memory=%s		 Control memory mode. This supports "normal" and "low" modes.
>  			 "low" mode is introduced to support low memory devices.
>  			 Because of the nature of low memory devices, in this mode, f2fs
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4e2596dacbf1..021e55c5d1a8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -167,6 +167,7 @@ struct f2fs_mount_info {
>  					 * be aligned to this unit: block,
>  					 * segment or section
>  					 */
> +	bool async_zone_reset;          /* async zone reset */
>  	struct fscrypt_dummy_policy dummy_enc_policy; /* test dummy encryption */
>  	block_t unusable_cap_perc;	/* percentage for cap */
>  	block_t unusable_cap;		/* Amount of space allowed to be
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 45128694eefa..60cfe97c9dbd 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1189,6 +1189,46 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  				struct block_device *bdev, block_t lstart,
>  				block_t start, block_t len);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static int __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
> +				   struct discard_cmd *dc, blk_opf_t flag,
> +				   struct list_head *wait_list,
> +				   unsigned int *issued)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct block_device *bdev = dc->bdev;
> +	struct bio *bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET | flag, GFP_NOFS);
> +	unsigned long flags;
> +
> +	trace_f2fs_issue_reset_zone(bdev, SECTOR_FROM_BLOCK(dc->di.start));
> +
> +	spin_lock_irqsave(&dc->lock, flags);
> +	dc->state = D_SUBMIT;
> +	dc->bio_ref++;
> +	spin_unlock_irqrestore(&dc->lock, flags);
> +
> +	if (issued)
> +		(*issued)++;
> +
> +	atomic_inc(&dcc->queued_discard);
> +	dc->queued++;
> +	list_move_tail(&dc->list, wait_list);
> +
> +	/* sanity check on discard range */
> +	__check_sit_bitmap(sbi, dc->di.lstart, dc->di.lstart + dc->di.len);
> +
> +	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(dc->di.start);
> +	bio->bi_private = dc;
> +	bio->bi_end_io = f2fs_submit_discard_endio;
> +	submit_bio(bio);
> +
> +	atomic_inc(&dcc->issued_discard);
> +
> +	return 0;
> +}
> +#endif
> +
>  /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
>  static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  				struct discard_policy *dpolicy,
> @@ -1210,6 +1250,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		return 0;
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev))
> +		return __submit_zone_reset_cmd(sbi, dc, flag, wait_list, issued);
> +#endif
> +
>  	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
>  
>  	lstart = dc->di.lstart;
> @@ -1454,21 +1499,42 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  	}
>  }
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void __queue_zone_reset_cmd(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t blklen)
> +{
> +	block_t lblkstart = blkstart;
> +
> +	if (f2fs_is_multi_device(sbi)) {
> +		int devi = f2fs_target_device_index(sbi, blkstart);
> +
> +		blkstart -= FDEV(devi).start_blk;
> +	}
> +
> +	trace_f2fs_queue_reset_zone(bdev, blkstart);
> +
> +	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
> +	__insert_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
> +	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
> +}
> +#endif
> +
>  static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
>  		struct block_device *bdev, block_t blkstart, block_t blklen)
>  {
>  	block_t lblkstart = blkstart;
>  
> +	trace_f2fs_queue_discard(bdev, blkstart, blklen);
> +
>  	if (!f2fs_bdev_support_discard(bdev))
>  		return;
>  
> -	trace_f2fs_queue_discard(bdev, blkstart, blklen);
> -
>  	if (f2fs_is_multi_device(sbi)) {
>  		int devi = f2fs_target_device_index(sbi, blkstart);
>  
>  		blkstart -= FDEV(devi).start_blk;
>  	}
> +
>  	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
>  	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
>  	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
> @@ -1719,7 +1785,22 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  	dc = __lookup_discard_cmd(sbi, blkaddr);
>  	if (dc) {
>  		if (dc->state == D_PREP) {
> +#ifdef CONFIG_BLK_DEV_ZONED
> +			if (f2fs_sb_has_blkzoned(sbi) &&
> +			    bdev_is_zoned(dc->bdev)) {
> +				struct discard_policy dpolicy;
> +				/* force submit zone reset */
> +				__init_discard_policy(sbi, &dpolicy,
> +						      DPOLICY_FORCE, 1);
> +				__submit_discard_cmd(sbi, &dpolicy, dc, NULL);
> +				dc->ref++;
> +				need_wait = true;
> +			} else {
> +				__punch_discard_cmd(sbi, dc, blkaddr);

Can be consolidated in both cases below.

> +			}
> +#else
>  			__punch_discard_cmd(sbi, dc, blkaddr);
> +#endif
>  		} else {
>  			dc->ref++;
>  			need_wait = true;
> @@ -1869,6 +1950,13 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>  				 blkstart, blklen);
>  			return -EIO;
>  		}
> +
> +		if (likely(!is_sbi_flag_set(sbi, SBI_POR_DOING)) &&
> +			   F2FS_OPTION(sbi).async_zone_reset) {
> +			__queue_zone_reset_cmd(sbi, bdev, lblkstart, blklen);
> +			return 0;
> +		}

Can make a sigle case above and below, if we set this by default.

> +
>  		trace_f2fs_issue_reset_zone(bdev, blkstart);
>  		return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
>  					sector, nr_sects, GFP_NOFS);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7d0202f7b317..48198112cbbc 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -162,6 +162,7 @@ enum {
>  	Opt_gc_merge,
>  	Opt_nogc_merge,
>  	Opt_discard_unit,
> +	Opt_async_zone_reset,
>  	Opt_memory_mode,
>  	Opt_age_extent_cache,
>  	Opt_err,
> @@ -241,6 +242,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_gc_merge, "gc_merge"},
>  	{Opt_nogc_merge, "nogc_merge"},
>  	{Opt_discard_unit, "discard_unit=%s"},
> +	{Opt_async_zone_reset, "async_zone_reset"},
>  	{Opt_memory_mode, "memory=%s"},
>  	{Opt_age_extent_cache, "age_extent_cache"},
>  	{Opt_err, NULL},
> @@ -1249,6 +1251,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			}
>  			kfree(name);
>  			break;
> +		case Opt_async_zone_reset:
> +			F2FS_OPTION(sbi).async_zone_reset = true;
> +			break;
>  		case Opt_memory_mode:
>  			name = match_strdup(&args[0]);
>  			if (!name)
> @@ -2047,6 +2052,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	if (test_opt(sbi, ATGC))
>  		seq_puts(seq, ",atgc");
>  
> +	if (F2FS_OPTION(sbi).async_zone_reset)
> +		seq_puts(seq, ",async_zone_reset");
> +
>  	if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_NORMAL)
>  		seq_printf(seq, ",memory=%s", "normal");
>  	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 99cbc5949e3c..ee1477de8324 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1512,7 +1512,7 @@ DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
>  	TP_ARGS(dev, blkstart, blklen)
>  );
>  
> -TRACE_EVENT(f2fs_issue_reset_zone,
> +DECLARE_EVENT_CLASS(f2fs_reset_zone,
>  
>  	TP_PROTO(struct block_device *dev, block_t blkstart),
>  
> @@ -1528,11 +1528,25 @@ TRACE_EVENT(f2fs_issue_reset_zone,
>  		__entry->blkstart = blkstart;
>  	),
>  
> -	TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
> +	TP_printk("dev = (%d,%d), zone at block = 0x%llx",
>  		show_dev(__entry->dev),
>  		(unsigned long long)__entry->blkstart)
>  );
>  
> +DEFINE_EVENT(f2fs_reset_zone, f2fs_queue_reset_zone,
> +
> +	TP_PROTO(struct block_device *dev, block_t blkstart),
> +
> +	TP_ARGS(dev, blkstart)
> +);
> +
> +DEFINE_EVENT(f2fs_reset_zone, f2fs_issue_reset_zone,
> +
> +	TP_PROTO(struct block_device *dev, block_t blkstart),
> +
> +	TP_ARGS(dev, blkstart)
> +);
> +
>  TRACE_EVENT(f2fs_issue_flush,
>  
>  	TP_PROTO(struct block_device *dev, unsigned int nobarrier,
> -- 
> 2.25.1
