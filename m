Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AB64AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiLLWrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiLLWrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:47:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82B1C106
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:47:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4347A61267
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8897FC433F0;
        Mon, 12 Dec 2022 22:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670885236;
        bh=4/6SuCNcBrCMb/LiBQ8O3Kf5f2TLbj+uxIKFNs10M08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtsJNDNYtTaS7ugd/RUtYb1IRNMuwxpI1uxMVPgWcVH8jzD6VKz/RFks0gYXS9jSr
         MQKQIOUpwXq5vWFdJgSz6maWW1plOp6YboLgsIHJzpu7BQHnSHVHT8DEqlLBKuGTGz
         Ae6tCf4nPw2LP82hOvZmUtkOpgGyplUGHy3yioBWkoMBWDUc6KR1HEuY6UylV2BOTk
         oZp4MWN07gub0vEG/hZle1ALG7/GRY+tItwwh6P9h4WHtG8OmYpYsd0YTNvPqBc1aW
         lVZKkoMeHGztuD7FBu+P8IgaGoq00UCh4tb8Yg9s94mFBKYiuioBTT0Fj++TJgg6KX
         SHkSMUklTq0yg==
Date:   Mon, 12 Dec 2022 14:47:15 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard
 cmd
Message-ID: <Y5evc3D8eZlOjTjI@google.com>
References: <20221212125137.77187-1-frank.li@vivo.com>
 <b76428f8-fd9e-7c4e-52ea-0eeb1ea443af@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b76428f8-fd9e-7c4e-52ea-0eeb1ea443af@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12, Chao Yu wrote:
> On 2022/12/12 20:51, Yangtao Li wrote:
> > This patch adds support for counting the average time and
> > peak time of submit discard command, and we can see its
> > value in debugfs.
> > 
> > It is not sure whether the block layer has recorded these
> > data, and these data are allowed to be accessed by fs,
> > or they are only exported to user space.
> > 
> > On the one hand, I added these data to better understand
> > the current device operating status, and to further control
> > the discard process in a more detailed manner based on the
> > discard submit time in the future.
> 
> Again, w'd better to consider this functionality only when DEBUG_FS is
> enabled.

BTW, why can't we use iostat to get the discard latencies?

> 
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   fs/f2fs/debug.c   | 10 +++++++---
> >   fs/f2fs/f2fs.h    |  6 ++++++
> >   fs/f2fs/segment.c | 21 +++++++++++++++++++--
> >   3 files changed, 32 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > index 32af4f0c5735..142c256b89d9 100644
> > --- a/fs/f2fs/debug.c
> > +++ b/fs/f2fs/debug.c
> > @@ -120,6 +120,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> >   			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
> >   	}
> >   	if (SM_I(sbi)->dcc_info) {
> > +		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> > +
> > +		si->discard_avg = dcc->discard_time_avg;
> > +		si->discard_peak = dcc->discard_time_peak;
> >   		si->nr_discarded =
> >   			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
> >   		si->nr_discarding =
> > @@ -545,9 +549,9 @@ static int stat_show(struct seq_file *s, void *v)
> >   			   si->nr_wb_cp_data, si->nr_wb_data,
> >   			   si->nr_flushing, si->nr_flushed,
> >   			   si->flush_list_empty);
> > -		seq_printf(s, "Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
> > -			   si->nr_discarding, si->nr_discarded,
> > -			   si->nr_discard_cmd, si->undiscard_blks);
> > +		seq_printf(s, "Discard: (%4d %4d, avg:%4lldns, peak:%4lldns)) cmd: %4d undiscard:%4u\n",
> > +			   si->nr_discarding, si->nr_discarded, ktime_to_us(si->discard_avg),
> > +			   ktime_to_us(si->discard_peak), si->nr_discard_cmd, si->undiscard_blks);
> >   		seq_printf(s, "  - atomic IO: %4d (Max. %4d)\n",
> >   			   si->aw_cnt, si->max_aw_cnt);
> >   		seq_printf(s, "  - compress: %4d, hit:%8d\n", si->compress_pages, si->compress_page_hit);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e8953c3dc81a..2cd55cb981ff 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -371,6 +371,8 @@ struct discard_cmd {
> >   	int error;			/* bio error */
> >   	spinlock_t lock;		/* for state/bio_ref updating */
> >   	unsigned short bio_ref;		/* bio reference count */
> > +	struct discard_cmd_control *dcc;	/* global discard cmd control */
> > +	ktime_t submit_start;	/* submit start time */
> >   };
> >   enum {
> > @@ -415,6 +417,9 @@ struct discard_cmd_control {
> >   	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
> >   	unsigned int undiscard_blks;		/* # of undiscard blocks */
> >   	unsigned int next_pos;			/* next discard position */
> > +	spinlock_t discard_time_lock;	/* for discard time statistics */
> > +	ktime_t discard_time_avg;		/* issued discard cmd avg time */
> > +	ktime_t discard_time_peak;		/* issued discard cmd peak time */
> >   	atomic_t issued_discard;		/* # of issued discard */
> >   	atomic_t queued_discard;		/* # of queued discard */
> >   	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
> > @@ -3896,6 +3901,7 @@ struct f2fs_stat_info {
> >   	int nr_dio_read, nr_dio_write;
> >   	unsigned int io_skip_bggc, other_skip_bggc;
> >   	int nr_flushing, nr_flushed, flush_list_empty;
> > +	ktime_t discard_avg, discard_peak;
> >   	int nr_discarding, nr_discarded;
> >   	int nr_discard_cmd;
> >   	unsigned int undiscard_blks;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a9099a754dd2..73cd05bb3f4a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -937,6 +937,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
> >   	list_add_tail(&dc->list, pend_list);
> >   	spin_lock_init(&dc->lock);
> >   	dc->bio_ref = 0;
> > +	dc->dcc = dcc;
> >   	atomic_inc(&dcc->discard_cmd_cnt);
> >   	dcc->undiscard_blks += len;
> > @@ -1006,9 +1007,13 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
> >   static void f2fs_submit_discard_endio(struct bio *bio)
> >   {
> >   	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
> > +	struct discard_cmd_control *dcc = dc->dcc;
> >   	unsigned long flags;
> > +	ktime_t submit_time;
> > +	int nr_discarded;
> >   	spin_lock_irqsave(&dc->lock, flags);
> > +	submit_time = ktime_sub(ktime_get(), dc->submit_start);
> >   	if (!dc->error)
> >   		dc->error = blk_status_to_errno(bio->bi_status);
> >   	dc->bio_ref--;
> > @@ -1018,6 +1023,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
> >   	}
> >   	spin_unlock_irqrestore(&dc->lock, flags);
> >   	bio_put(bio);
> > +
> > +	spin_lock_irqsave(&dcc->discard_time_lock, flags);
> > +	nr_discarded = atomic_read(&dcc->issued_discard);
> > +	dcc->discard_time_avg = div_u64(ktime_add(nr_discarded * dcc->discard_time_avg,
> > +										submit_time),
> > +									nr_discarded + 1);
> > +	if (dcc->discard_time_avg > dcc->discard_time_peak)
> > +		dcc->discard_time_peak = dcc->discard_time_avg;
> > +	atomic_inc(&dcc->issued_discard);
> > +	spin_unlock_irqrestore(&dcc->discard_time_lock, flags);
> 
> Why not calculating average time only in update_general_status()? and here,
> we just need to account total_{discard_time, discard_count} w/o additional
> spinlock.
> 
> Thanks,
> 
> >   }
> >   static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> > @@ -1166,6 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >   		 * right away
> >   		 */
> >   		spin_lock_irqsave(&dc->lock, flags);
> > +		dc->submit_start = ktime_get();
> >   		if (last)
> >   			dc->state = D_SUBMIT;
> >   		else
> > @@ -1185,8 +1201,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
> >   		bio->bi_opf |= flag;
> >   		submit_bio(bio);
> > -		atomic_inc(&dcc->issued_discard);
> > -
> >   		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);
> >   		lstart += len;
> > @@ -2079,9 +2093,12 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> >   	INIT_LIST_HEAD(&dcc->wait_list);
> >   	INIT_LIST_HEAD(&dcc->fstrim_list);
> >   	mutex_init(&dcc->cmd_lock);
> > +	spin_lock_init(&dcc->discard_time_lock);
> >   	atomic_set(&dcc->issued_discard, 0);
> >   	atomic_set(&dcc->queued_discard, 0);
> >   	atomic_set(&dcc->discard_cmd_cnt, 0);
> > +	dcc->discard_time_avg = 0;
> > +	dcc->discard_time_peak = 0;
> >   	dcc->nr_discards = 0;
> >   	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> >   	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
