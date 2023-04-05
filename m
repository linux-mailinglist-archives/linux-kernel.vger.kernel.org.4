Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56626D82BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjDEPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjDEPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66853271C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017C763F21
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAD5C433D2;
        Wed,  5 Apr 2023 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680710149;
        bh=YYDw0RuzTK3iw0hXHKgSXbk0yvOIgNiO+TT8XJvU7GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdPH2fhPJz3vAlXSaoPyW4UTbkLVVi0H+IHUaXTmwThxRofluxBVBnt6znjjFPdyw
         BAeI/YwpID3g6RgSFB8OU3ex7XFGFhMb3rg2Moohn1ycWtnnMpXBmiNnNEtjrYPfW/
         qZSFrcxzHMndvVpivUYnhcJS/j8T2togNsRgifYybAuAHt8xYHnBRWzL5JpeU3PMlM
         BEixxAdul0D9ZDJekcLRatv7T1mJAsA2vjAyybts0YyvK4m6rW/Aql8VlxPtJWUcy7
         5As/QtByH5ioBC7dfARZ0RSwE46tftdu92jN7Sj3vFV1n9UHQq/N+q1TOxTcI40rvf
         CgWKsB5ICqjLA==
Date:   Wed, 5 Apr 2023 08:55:47 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
Message-ID: <ZC2aA+i5+HpdJ6M2@google.com>
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCyZGgf4RSEjyHTF@google.com>
 <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Chao Yu wrote:
> On 2023/4/5 5:39, Jaegeuk Kim wrote:
> > Can we do like this?
> > 
> >  From 9a58f0e59364241aa31b555cfe793d278e39b0dc Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Tue, 4 Apr 2023 14:36:00 -0700
> > Subject: [PATCH] f2fs: do checkpoint when there's not enough free sections
> > 
> > We didn't do checkpoint in FG_GC case, which may cause losing to reclaim prefree
> > sctions in time.
> > 
> > Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/gc.c | 24 +++++++++++-------------
> >   1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 56c53dbe05c9..f1d0dd9c5a6c 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1806,6 +1806,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   	};
> >   	unsigned int skipped_round = 0, round = 0;
> >   	unsigned int upper_secs;
> > +	bool stop_gc = false;
> >   	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
> >   				gc_control->nr_free_secs,
> > @@ -1876,19 +1877,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
> >   		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
> >   			goto go_gc_more;
> > -		goto stop;
> > -	}
> > -
> > -	/* FG_GC stops GC by skip_count */
> > -	if (gc_type == FG_GC) {
> > +		stop_gc = true;
> 
> I guess below condition is for emergency recycle of prefree segments during
> foreground GC, in order to avoid exhausting free sections due to to many
> metadata allocation during CP.
> 
> 	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
> 				prefree_segments(sbi)) {
> 
> But for common case, free_sections() is close to reserved_segments(), and
> upper_secs + NR_GC_CHECKPOINT_SECS value may be far smaller than free_sections(),
> so checkpoint may not be trggered as expected, IIUC.
> 
> So it's fine to just trigger CP in the end of foreground garbage collection?

My major concern is to avoid unnecessary checkpointing given multiple FG_GC
requests were pending in parallel. And, I don't want to add so many combination
which gives so many corner cases, and feel f2fs_gc() needs to call checkpoint
automatically in the worst case scenario only.

By the way, do we just need to call checkpoint here including FG_GC as well?

1832
1833         if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
1834                 /*
1835                  * For example, if there are many prefree_segments below given
1836                  * threshold, we can make them free by checkpoint. Then, we
1837                  * secure free segments which doesn't need fggc any more.
1838                  */
1839                 if (prefree_segments(sbi)) {
1840                         ret = f2fs_write_checkpoint(sbi, &cpc);
1841                         if (ret)
1842                                 goto stop;
1843                 }
1844                 if (has_not_enough_free_secs(sbi, 0, 0))
1845                         gc_type = FG_GC;
1846         }

> 
> One other concern is for those path as below:
> - disable_checkpoint
> - ioc_gc
> - ioc_gc_range
> - ioc_resize
> ...

I think the upper caller should decide to call checkpoint, if they want to
reclaim the prefree likewise f2fs_disable_checkpoint.

> 
> We've passed gc_type as FG_GC, but the demand here is to migrate block in time,
> rather than dirtying blocks, and callers don't expect checkpoint in f2fs_gc(),
> instead the callers will do the checkpoit as it needs.
> 
> That means it's better to decouple FG_GC and write_checkpoint behavior, so I
> added another parameter .reclaim_space to just let f2fs_balance_fs() to trigger
> checkpoit in the end of f2fs_gc().

> 
> Thanks,
> 
> > +	} else if (gc_type == FG_GC) {
> > +		/* FG_GC stops GC by skip_count */
> >   		if (sbi->skipped_gc_rwsem)
> >   			skipped_round++;
> >   		round++;
> >   		if (skipped_round > MAX_SKIP_GC_COUNT &&
> > -				skipped_round * 2 >= round) {
> > -			ret = f2fs_write_checkpoint(sbi, &cpc);
> > -			goto stop;
> > -		}
> > +				skipped_round * 2 >= round)
> > +			stop_gc = true;
> >   	}
> >   	__get_secs_required(sbi, NULL, &upper_secs, NULL);
> > @@ -1901,12 +1898,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   				prefree_segments(sbi)) {
> >   		ret = f2fs_write_checkpoint(sbi, &cpc);
> >   		if (ret)
> > -			goto stop;
> > +			stop_gc = true;
> >   	}
> >   go_gc_more:
> > -	segno = NULL_SEGNO;
> > -	goto gc_more;
> > -
> > +	if (!stop_gc) {
> > +		segno = NULL_SEGNO;
> > +		goto gc_more;
> > +	}
> >   stop:
> >   	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
> >   	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
