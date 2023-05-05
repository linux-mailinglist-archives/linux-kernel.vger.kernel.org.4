Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253F46F824A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjEELtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjEELtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE11A12A;
        Fri,  5 May 2023 04:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF71E63D81;
        Fri,  5 May 2023 11:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C5C433D2;
        Fri,  5 May 2023 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683287359;
        bh=0pvNDiOgxzfoBpuvGE5ML1BEAkGH0HeXy85ykEK6SPw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=srv8SG5HfdHY96IFLxCwepDMFgxbKg/Np4ofZtajhTA3AchZO9b2KEG1PBjHXW524
         9o+oLTJcoTuDHLk1emxYm5JfK/BfEaIcvpkf+vRXTELKHHHetFIxbKU5lKq9pTV/xE
         +ph1tnYb2DAuWEluwvTibpT4tnaG6j8grs7HIZuUi8mEfRbg3sBGupL9vQ428jArBb
         f8zLdho/9MZr2zhmwGgq1jzqY+Fq5yLkTVPDTwxT7DYppxbLtepHmzgp08mNT8JKIg
         1eB2qjMIkZkD+IERC4KpOFRSmjXTr7p+fjVS1ruawrPF/n/QS4EPjbD58DHZZU9uX0
         zd5y96SG8kyEg==
Message-ID: <6bb7a39f-75ae-0d68-8912-ed46b49632e7@kernel.org>
Date:   Fri, 5 May 2023 19:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5] f2fs: add async reset zone command support
Content-Language: en-US
To:     daejun7.park@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Cc:     Seokhwan Kim <sukka.kim@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        beomsu kim <beomsu7.kim@samsung.com>
References: <CGME20230504032618epcms2p78719fc50d05943b26ae47d74fd14438c@epcms2p7>
 <20230504032618epcms2p78719fc50d05943b26ae47d74fd14438c@epcms2p7>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230504032618epcms2p78719fc50d05943b26ae47d74fd14438c@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/4 11:26, Daejun Park wrote:
> v4 -> v5
> Added f2fs iostat for zone reset command.
> 
> v3 -> v4
> Fixed build error caused by unused function.
> 
> v2 -> v3
> Modified arguments to be correct for ftrace parameter.
> Changed __submit_zone_reset_cmd to void return.
> Refactored the f2fs_wait_discard_bio function.
> Fixed code that was previously incorrectly merged.
> 
> v1 -> v2
> Changed to apply the optional async reset write pointer by default.
> 
> This patch enables submit reset zone command asynchornously. It helps
> decrease average latency of write IOs in high utilization scenario by
> faster checkpointing.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/f2fs.h              |  1 +
>   fs/f2fs/iostat.c            |  1 +
>   fs/f2fs/segment.c           | 84 +++++++++++++++++++++++++++++++++++--
>   include/trace/events/f2fs.h | 18 +++++++-
>   4 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d211ee89c158..15518206cb31 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1175,6 +1175,7 @@ enum iostat_type {
>   	/* other */
>   	FS_DISCARD_IO,			/* discard */
>   	FS_FLUSH_IO,			/* flush */
> +	FS_ZONE_RESET_IO,		/* zone reset*/
>   	NR_IO_TYPE,
>   };
>   
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index 3d5bfb1ad585..f8703038e1d8 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -80,6 +80,7 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>   	seq_puts(seq, "[OTHER]\n");
>   	IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
>   	IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
> +	IOSTAT_INFO_SHOW("fs zone reset", FS_ZONE_RESET_IO);
>   
>   	return 0;
>   }
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6db410f1bb8c..4802b05a795b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1196,6 +1196,45 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>   static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>   				struct block_device *bdev, block_t lstart,
>   				block_t start, block_t len);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
> +				   struct discard_cmd *dc, blk_opf_t flag,
> +				   struct list_head *wait_list,
> +				   unsigned int *issued)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct block_device *bdev = dc->bdev;
> +	struct bio *bio = bio_alloc(bdev, 0, REQ_OP_ZONE_RESET | flag, GFP_NOFS);
> +	unsigned long flags;
> +
> +	trace_f2fs_issue_reset_zone(bdev, dc->di.start);
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
> +	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO, dc->di.len * F2FS_BLKSIZE);

It should update trace_f2fs_iostat() to show zone_reset_io stat?

Thanks,

> +}
> +#endif
> +
>   /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
>   static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   				struct discard_policy *dpolicy,
> @@ -1217,6 +1256,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>   		return 0;
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev)) {
> +		__submit_zone_reset_cmd(sbi, dc, flag, wait_list, issued);
> +		return 0;
> +	}
> +#endif
> +
>   	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
>   
>   	lstart = dc->di.lstart;
> @@ -1461,6 +1507,19 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>   	}
>   }
>   
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void __queue_zone_reset_cmd(struct f2fs_sb_info *sbi,
> +		struct block_device *bdev, block_t blkstart, block_t lblkstart,
> +		block_t blklen)
> +{
> +	trace_f2fs_queue_reset_zone(bdev, blkstart);
> +
> +	mutex_lock(&SM_I(sbi)->dcc_info->cmd_lock);
> +	__insert_discard_cmd(sbi, bdev, lblkstart, blkstart, blklen);
> +	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
> +}
> +#endif
> +
>   static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
>   		struct block_device *bdev, block_t blkstart, block_t blklen)
>   {
> @@ -1724,6 +1783,19 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>   
>   	mutex_lock(&dcc->cmd_lock);
>   	dc = __lookup_discard_cmd(sbi, blkaddr);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (dc && f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
> +		/* force submit zone reset */
> +		if (dc->state == D_PREP)
> +			__submit_zone_reset_cmd(sbi, dc, REQ_SYNC,
> +						&dcc->wait_list, NULL);
> +		dc->ref++;
> +		mutex_unlock(&dcc->cmd_lock);
> +		/* wait zone reset */
> +		__wait_one_discard_bio(sbi, dc);
> +		return;
> +	}
> +#endif
>   	if (dc) {
>   		if (dc->state == D_PREP) {
>   			__punch_discard_cmd(sbi, dc, blkaddr);
> @@ -1876,9 +1948,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>   				 blkstart, blklen);
>   			return -EIO;
>   		}
> -		trace_f2fs_issue_reset_zone(bdev, blkstart);
> -		return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
> -					sector, nr_sects, GFP_NOFS);
> +
> +		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING))) {
> +			trace_f2fs_issue_reset_zone(bdev, blkstart);
> +			return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
> +						sector, nr_sects, GFP_NOFS);
> +		}
> +
> +		__queue_zone_reset_cmd(sbi, bdev, blkstart, lblkstart, blklen);
> +		return 0;
>   	}
>   
>   	/* For conventional zones, use regular discard if supported */
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 99cbc5949e3c..ee1477de8324 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1512,7 +1512,7 @@ DEFINE_EVENT(f2fs_discard, f2fs_remove_discard,
>   	TP_ARGS(dev, blkstart, blklen)
>   );
>   
> -TRACE_EVENT(f2fs_issue_reset_zone,
> +DECLARE_EVENT_CLASS(f2fs_reset_zone,
>   
>   	TP_PROTO(struct block_device *dev, block_t blkstart),
>   
> @@ -1528,11 +1528,25 @@ TRACE_EVENT(f2fs_issue_reset_zone,
>   		__entry->blkstart = blkstart;
>   	),
>   
> -	TP_printk("dev = (%d,%d), reset zone at block = 0x%llx",
> +	TP_printk("dev = (%d,%d), zone at block = 0x%llx",
>   		show_dev(__entry->dev),
>   		(unsigned long long)__entry->blkstart)
>   );
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
>   TRACE_EVENT(f2fs_issue_flush,
>   
>   	TP_PROTO(struct block_device *dev, unsigned int nobarrier,
