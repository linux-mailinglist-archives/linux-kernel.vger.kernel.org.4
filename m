Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30EF628D25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiKNXG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiKNXGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642871C423
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:04:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD17C613F9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088ACC433D6;
        Mon, 14 Nov 2022 23:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668467047;
        bh=2cCl0d0X5lX4NyOcKC03ekrQxlEEtlWIMktN+6wfhGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5UDekhFXY3RNOQNPnk3IvUjt6maPNGK+bfTKS7NT71+TB/hAbdaAPHpASDP4VLKN
         NrvEjiczoJu3+9BG7rGkXEbVKevxjas2+AwLZhKOHW0NXioa2ZkqVHuGW4P1qQwnj/
         CkJea26p+rBQahQqWmtybMubg0iNz3tBho5vAz2it90EwH/AdmUqGw8/WFftAd6gGB
         1Z0H+HQVnFavk0j4YP39o7sS+5k952j2AqrYFLD7whSW+YKnROBtXAgk8jdnyLkL+4
         FaOS4yJKWa0XpGbsemejhYdKMDQNwTxPsdaMXmumhTtvFv4uXPb1IrDFbbac/Evrch
         IBrn4etskqfhQ==
Date:   Mon, 14 Nov 2022 15:04:05 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add proc entry to show discard_plist info
Message-ID: <Y3LJZZjKgxzq9ZU8@google.com>
References: <20221111153921.55694-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111153921.55694-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11, Yangtao Li wrote:
> This patch adds a new proc entry to show discard_plist
> information in more detail, which is very helpful to
> know the discard pend list count clearly.
> 
> Such as:
> 
> Discard pending list(Show diacrd command count on each entry):
> 0                4943         138          66          29          21           9           8          12
> 8                   4           7           4           6           3           2           0           1
> 16                  1           2           2           0           0           1           0           0
> 24                  0           1           1           0           0           1           1           0
> 32                  0           1           0           0           0           0           0           0
> ......
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 22 ++++++++++++++++------
>  fs/f2fs/sysfs.c   | 29 +++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 04ef4cce3d7f..a0226c970cbc 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -405,6 +405,7 @@ struct discard_cmd_control {
>  	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
>  	unsigned int discard_wake;		/* to wake up discard thread */
>  	struct mutex cmd_lock;
> +	unsigned int nr_pending[MAX_PLIST_NUM];	/* # of pending discards */
>  	unsigned int nr_discards;		/* # of discards in the list */
>  	unsigned int max_discards;		/* max. discards to be issued */
>  	unsigned int max_discard_request;	/* max. discard request per round */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index aa4be7f25963..72e60d5ee70f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -921,6 +921,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
>  	dc->bio_ref = 0;
>  	atomic_inc(&dcc->discard_cmd_cnt);
>  	dcc->undiscard_blks += len;
> +	dcc->nr_pending[plist_idx(len)]++;
>  
>  	return dc;
>  }
> @@ -1169,6 +1170,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		submit_bio(bio);
>  
>  		atomic_inc(&dcc->issued_discard);
> +		dcc->nr_pending[plist_idx(len)]--;
>  
>  		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
>  
> @@ -1210,9 +1212,11 @@ static void __insert_discard_tree(struct f2fs_sb_info *sbi,
>  }
>  
>  static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
> -						struct discard_cmd *dc)
> +						struct discard_cmd *dc, unsigned int index)

How about getting all the info?

static void __relocate_discard_cmd(dcc, dc, new_lstart, new_start, new_len)
{
	dcc->nr_pending[plist_idx(dc->len)]--;

	if (new_lstart)
		dc->lstart = new_lstart;
	if (new_start)
		dc->start = new_start;
	dc->len = new_len;
	dcc->undiscard_blks += dc->len;
	dcc->nr_pending[plist_idx(dc->len)]++;
  	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
}

>  {
>  	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
> +	dcc->nr_pending[plist_idx(dc->len)]++;
> +	dcc->nr_pending[index]--;
>  }
>  
>  static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
> @@ -1230,9 +1234,10 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
>  	dcc->undiscard_blks -= di.len;
>  
>  	if (blkaddr > di.lstart) {
> +		block_t old_len = dc->len;
>  		dc->len = blkaddr - dc->lstart;
>  		dcc->undiscard_blks += dc->len;
> -		__relocate_discard_cmd(dcc, dc);
> +		__relocate_discard_cmd(dcc, dc, plist_idx(old_len));

		__relocate_discard_cmd(dcc, dc, 0, 0, blkaddr - dc->lstart);

>  		modified = true;
>  	}
>  
> @@ -1243,11 +1248,12 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
>  					di.lstart + di.len - 1 - blkaddr,
>  					NULL, NULL);
>  		} else {
> +			block_t old_len = dc->len;
>  			dc->lstart++;
>  			dc->len--;
>  			dc->start++;
>  			dcc->undiscard_blks += dc->len;
> -			__relocate_discard_cmd(dcc, dc);
> +			__relocate_discard_cmd(dcc, dc, plist_idx(old_len));

		__relocate_discard_cmd(dcc, dc, dc->lstart + 1, dc->start + 1, dc->len - 1);

>  		}
>  	}
>  }
> @@ -1306,9 +1312,10 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  			prev_dc->bdev == bdev &&
>  			__is_discard_back_mergeable(&di, &prev_dc->di,
>  							max_discard_blocks)) {
> +			block_t old_len = prev_dc->di.len;
>  			prev_dc->di.len += di.len;
>  			dcc->undiscard_blks += di.len;
> -			__relocate_discard_cmd(dcc, prev_dc);
> +			__relocate_discard_cmd(dcc, prev_dc, plist_idx(old_len));

			__relocate_discard_cmd(dcc, prev_dc, 0, 0, di.len);

>  			di = prev_dc->di;
>  			tdc = prev_dc;
>  			merged = true;
> @@ -1318,13 +1325,16 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>  			next_dc->bdev == bdev &&
>  			__is_discard_front_mergeable(&di, &next_dc->di,
>  							max_discard_blocks)) {
> +			block_t old_len = next_dc->di.len;
>  			next_dc->di.lstart = di.lstart;
>  			next_dc->di.len += di.len;
>  			next_dc->di.start = di.start;
>  			dcc->undiscard_blks += di.len;
> -			__relocate_discard_cmd(dcc, next_dc);

			__relocate_discard_cmd(dcc, next_dc, di.lstart, di.start, di.len);

> -			if (tdc)
> +			__relocate_discard_cmd(dcc, next_dc, plist_idx(old_len));
> +			if (tdc) {
> +				dcc->nr_pending[plist_idx(tdc->len)]--;
>  				__remove_discard_cmd(sbi, tdc);
> +			}
>  			merged = true;
>  		}
>  
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 032c03e09580..2176553f97c9 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1252,6 +1252,32 @@ static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
>  	return 0;
>  }
>  
> +static int __maybe_unused discard_plist_seq_show(struct seq_file *seq,
> +						void *offset)
> +{
> +	struct super_block *sb = seq->private;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	int i;
> +
> +	seq_puts(seq, "Discard pending list(Show diacrd command count on each entry):\n");
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return 0;
> +
> +	for (i = 0; i < MAX_PLIST_NUM; i++) {
> +		if (i % 8 == 0)
> +			seq_printf(seq, "%-10d", i);
> +		seq_printf(seq, " %10d", dcc->nr_pending[i]);
> +		if (i % 8 == 7)
> +			seq_putc(seq, '\n');
> +		else
> +			seq_putc(seq, ' ');
> +	}
> +	seq_putc(seq, '\n');
> +
> +	return 0;
> +}
> +
>  int __init f2fs_init_sysfs(void)
>  {
>  	int ret;
> @@ -1322,6 +1348,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>  #endif
>  		proc_create_single_data("victim_bits", 0444, sbi->s_proc,
>  				victim_bits_seq_show, sb);
> +		proc_create_single_data("discard_plist", 0444, sbi->s_proc,
> +				discard_plist_seq_show, sb);
>  	}
>  	return 0;
>  put_feature_list_kobj:
> @@ -1345,6 +1373,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>  		remove_proc_entry("segment_info", sbi->s_proc);
>  		remove_proc_entry("segment_bits", sbi->s_proc);
>  		remove_proc_entry("victim_bits", sbi->s_proc);
> +		remove_proc_entry("discard_plist", sbi->s_proc);
>  		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>  	}
>  
> -- 
> 2.25.1
