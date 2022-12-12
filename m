Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DA3649C65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiLLKlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiLLKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:40:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FDB4A9;
        Mon, 12 Dec 2022 02:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFB560F40;
        Mon, 12 Dec 2022 10:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A48CC433EF;
        Mon, 12 Dec 2022 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670841288;
        bh=d83TxHN9oztaLU1gt+Fi+GU5ce7VMeB1SwmpA2UXsIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GlRg1ZklbUlADjU40uhGLTH3HINyulcwz3kNsqM/HYCxmZCRM6Jx3jUjosf0boNG3
         ayQS4y0Wc7kZYzrCdJJ0eCLvvUhi5tuNTO1Meq6q68JQtoMaNPvUnGWfEkbjrudG1T
         fIRxRe63FSpKVTMkKLvTj+XfmliO3DvB0gu6rFggrCvvuiCWaWv/5xxSfZ1uliB6ZJ
         W1kzTJg1dqvegeugr3N7MY+B18fJs41GMwGIORqjOlL1xpyefIaoDOjWRE6Aqk5FjS
         V5H7d2bZMkwJYw1i+b4QPgSRlzY59TXpO5Kjr/5C/sROJjN874lVg/+4AMPutJrs55
         jWcu52z8fvaiQ==
Message-ID: <e257526b-6199-6ff4-8eae-59a8dc8377a2@kernel.org>
Date:   Mon, 12 Dec 2022 18:34:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] f2fs: add support for counting the average time of
 submit discard cmd
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20221129041524.81235-1-frank.li@vivo.com>
 <20221129041524.81235-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221129041524.81235-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/29 12:15, Yangtao Li wrote:
> This patch adds support for counting the average time of submit discard
> command, and we can see its value in debugfs.

How about enabling this only when CONFIG_DEBUG_FS is on?

+Cc block mailing list

Not sure block layer has similar stats? if it hasn't, can such stat
be accounted in block layer, and then all filesystem can be benefited.

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/debug.c   |  7 +++++--
>   fs/f2fs/f2fs.h    |  5 +++++
>   fs/f2fs/segment.c | 18 ++++++++++++++++--
>   3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 733b1bd37404..eed3edfc5faf 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -109,6 +109,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>   			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
>   	}
>   	if (SM_I(sbi)->dcc_info) {
> +		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +		si->discard_avg = dcc->discard_time_avg;
>   		si->nr_discarded =
>   			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
>   		si->nr_discarding =
> @@ -510,8 +513,8 @@ static int stat_show(struct seq_file *s, void *v)
>   			   si->nr_wb_cp_data, si->nr_wb_data,
>   			   si->nr_flushing, si->nr_flushed,
>   			   si->flush_list_empty);
> -		seq_printf(s, "Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
> -			   si->nr_discarding, si->nr_discarded,
> +		seq_printf(s, "Discard: (%4d %4d, avg:%4lldns)) cmd: %4d undiscard:%4u\n",
> +			   si->nr_discarding, si->nr_discarded, ktime_to_us(si->discard_avg),
>   			   si->nr_discard_cmd, si->undiscard_blks);
>   		seq_printf(s, "  - atomic IO: %4d (Max. %4d)\n",
>   			   si->aw_cnt, si->max_aw_cnt);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eb8c27c4e5fc..5a99759d10ac 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -370,6 +370,8 @@ struct discard_cmd {
>   	int error;			/* bio error */
>   	spinlock_t lock;		/* for state/bio_ref updating */
>   	unsigned short bio_ref;		/* bio reference count */
> +	struct discard_cmd_control *dcc; /* global discard cmd control */
> +	ktime_t submit_start;		/* submit start time */
>   };
>   
>   enum {
> @@ -414,6 +416,8 @@ struct discard_cmd_control {
>   	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
>   	unsigned int undiscard_blks;		/* # of undiscard blocks */
>   	unsigned int next_pos;			/* next discard position */
> +	spinlock_t discard_time_lock;	/* for discard time statistics */
> +	ktime_t discard_time_avg;		/* issued discard cmd avg time */
>   	atomic_t issued_discard;		/* # of issued discard */
>   	atomic_t queued_discard;		/* # of queued discard */
>   	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
> @@ -3882,6 +3886,7 @@ struct f2fs_stat_info {
>   	int nr_dio_read, nr_dio_write;
>   	unsigned int io_skip_bggc, other_skip_bggc;
>   	int nr_flushing, nr_flushed, flush_list_empty;
> +	ktime_t	discard_avg;
>   	int nr_discarding, nr_discarded;
>   	int nr_discard_cmd;
>   	unsigned int undiscard_blks;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9486ca49ecb1..bc96b1afb308 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -931,6 +931,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
>   	list_add_tail(&dc->list, pend_list);
>   	spin_lock_init(&dc->lock);
>   	dc->bio_ref = 0;
> +	dc->dcc = dcc;
>   	atomic_inc(&dcc->discard_cmd_cnt);
>   	dcc->undiscard_blks += len;
>   
> @@ -1000,9 +1001,13 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
>   static void f2fs_submit_discard_endio(struct bio *bio)
>   {
>   	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> +	struct discard_cmd_control *dcc = dc->dcc;
>   	unsigned long flags;
> +	ktime_t submit_time;
> +	int nr_discarded;
>   
>   	spin_lock_irqsave(&dc->lock, flags);
> +	submit_time = ktime_sub(ktime_get(), dc->submit_start);
>   	if (!dc->error)
>   		dc->error = blk_status_to_errno(bio->bi_status);
>   	dc->bio_ref--;
> @@ -1012,6 +1017,14 @@ static void f2fs_submit_discard_endio(struct bio *bio)
>   	}
>   	spin_unlock_irqrestore(&dc->lock, flags);
>   	bio_put(bio);
> +
> +	spin_lock_irqsave(&dcc->discard_time_lock, flags);
> +	nr_discarded = atomic_read(&dcc->issued_discard);
> +	dcc->discard_time_avg = div_u64(ktime_add(nr_discarded * dcc->discard_time_avg,
> +										submit_time),
> +									nr_discarded + 1);
> +	atomic_inc(&dcc->issued_discard);
> +	spin_unlock_irqrestore(&dcc->discard_time_lock, flags);
>   }
>   
>   static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> @@ -1160,6 +1173,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   		 * right away
>   		 */
>   		spin_lock_irqsave(&dc->lock, flags);
> +		dc->submit_start = ktime_get();
>   		if (last)
>   			dc->state = D_SUBMIT;
>   		else
> @@ -1179,8 +1193,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>   		bio->bi_opf |= flag;
>   		submit_bio(bio);
>   
> -		atomic_inc(&dcc->issued_discard);
> -
>   		f2fs_update_iostat(sbi, NULL, FS_DISCARD, 1);
>   
>   		lstart += len;
> @@ -2070,9 +2082,11 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	INIT_LIST_HEAD(&dcc->wait_list);
>   	INIT_LIST_HEAD(&dcc->fstrim_list);
>   	mutex_init(&dcc->cmd_lock);
> +	spin_lock_init(&dcc->discard_time_lock);
>   	atomic_set(&dcc->issued_discard, 0);
>   	atomic_set(&dcc->queued_discard, 0);
>   	atomic_set(&dcc->discard_cmd_cnt, 0);
> +	dcc->discard_time_avg = 0;
>   	dcc->nr_discards = 0;
>   	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>   	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
