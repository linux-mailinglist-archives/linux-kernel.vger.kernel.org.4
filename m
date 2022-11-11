Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6206265B6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiKKXqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiKKXqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:46:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF76EB56;
        Fri, 11 Nov 2022 15:46:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E802DCE2A9B;
        Fri, 11 Nov 2022 23:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A26AC433D6;
        Fri, 11 Nov 2022 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668210399;
        bh=FMxDx9vdYxaC+YLkxxp9+/gAdETHLLJQJw00JOxJxCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkmde2dO5GvtNpXFcgY2rJe5J5/ZZypekbFgFW+kpfLExpTS0Cwbyy8xmHHCgotar
         xoe/xVHLni+AFnRiKCS1/17ZNSXkSOZGzZRfheEzoBrh8ptkDRp1G1dacKMTRjGouc
         vVsbRTu3dRJ4EmZFncExOxq5arXfpv3OxfsmgZrERabzGzzyO0qCPXxTzz02eGHhnX
         bHrZIVDa0C77wrwkhHQeHzSAiqcobu5OudAvUHQv09x5YCFm66EfWhTIocHLaEfPQZ
         cszwExgCuEbyFI7SdLNYm8wXBX6zohqEV6HXfAgfE2IWJXPOf8+QsGmO1VKBTxKOAq
         sUEKLkJc/nC0w==
Date:   Sat, 12 Nov 2022 07:46:33 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y27e2U155YvH9et4@debian>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221111203905.GN3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sat, Nov 12, 2022 at 07:39:05AM +1100, Dave Chinner wrote:
> On Wed, Nov 09, 2022 at 11:48:02AM +0800, Gao Xiang wrote:
> > There is a long standing issue which could cause fs shutdown due to
> > inode extent-to-btree conversion failure right after an extent
> > allocation in the same AG, which is absolutely unexpected due to the
> > proper minleft reservation in the previous allocation.  Brian once
> > addressed one of the root cause [1], however, such symptom can still
> > occur after the commit is merged as reported [2], and our cloud
> > environment is also suffering from this issue.
> > 
> > From the description of the commit [1], I found that Zirong has an
> > in-house stress test reproducer for this issue, therefore I asked him
> > to reproduce again and he confirmed that such issue can still be
> > reproduced on RHEL 9 in several days.
> > 
> > Thanks to him, after adding some debugging code to dump the current
> > transaction log items, I think the root cause is as below:
> > 
> >   1. xfs_bmapi_allocate() with the following condition:
> >      freeblks: 18304 pagf_flcount: 6
> >      reservation: 18276 need (min_free): 6
> >      args->minleft: 1
> >      available = freeblks + agflcount - reservation - need - minleft
> >                = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> >      The first allocation check itself is ok, and args->maxlen = 27
> >      here
> > 
> >      At this time, AG 3 also has the following state:
> >      1st:64  last:69  cnt:6  longest:6395
> > 
> >      AGFL has the following state:
> >      64:547 65:167 66:1651 67:2040807 68:783 69:604
> > 
> >   2. Tried to get 27 blocks from this AG, but in order to finish such
> >      allocation, it had to need a new btree block for cntbt (so take
> >      another free block from agfl).  It can be seen with a new AGF
> >      recorded in the transaction:
> >       blkno 62914177, len 1, map_size 1
> >       00000000: 58 41 47 46 00 00 00 01 00 00 00 03 00 27 ff f0  XAGF.........'..
> >       00000010: 00 00 00 09 00 00 00 07 00 00 00 00 00 00 00 02  ................
> >       00000020: 00 00 00 02 00 00 00 00 00 00 00 41 00 00 00 45  ...........A...E
> >       00000030: 00 00 00 05 00 00 47 65 00 00 18 fb 00 00 00 09  ......Ge........
> >       00000040: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> > 
> >       It can be parsed as:
> >       agf 3  flfirst: 65 (0x41) fllast: 69 (0x45) cnt: 5
> >       freeblks 18277
> > 
> >   3. agfl 64 (agbno 547, daddr 62918552) was then written as a cntbt
> >      block, which can also be seen in a log item as below:
> >        type#011= 0x123c
> >        flags#011= 0x8
> >       blkno 62918552, len 8, map_size 1
> >       00000000: 41 42 33 43 00 00 00 fd 00 1f 23 e4 ff ff ff ff  AB3C......#.....
> >       00000010: 00 00 00 00 03 c0 0f 98 00 00 00 00 00 00 00 00  ................
> >       00000020: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> >       ...
> > 
> >   4. Finally, the following inode extent to btree allocation fails
> >      as below:
> >      kernel: ------------[ cut here ]------------
> >      WARNING: CPU: 15 PID: 49290 at fs/xfs/libxfs/xfs_bmap.c:717 xfs_bmap_extents_to_btree+0xc51/0x1050 [xfs]
> >      ...
> >      XFS (sda2): agno 3 agflcount 5 freeblks 18277 reservation 18276 6
> > 
> >      since freeblks = 18304 - 27 = 18277, but with another agfl
> >      block allocated (pagf_flcount from 6 to 5), the inequality will
> >      not be satisfied:
> > 
> >      available = freeblks + agflcount - reservation - need - minleft
> >                = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
> > 
> >   Full current transaction log item dump can be fetched from [3].
> > 
> > As a short-term solution, the following allocations (e.g. allocation
> > for inode extent-to-btree conversion) can be recorded in order to count
> > more blocks to reserve for safely freespace btree splits so that it
> > will shorten available and args->maxlen to
> >      available = freeblks + agflcount - reservation - need - minleft
> >                = 18304 + min(6, 6) - 18276 - 6*2 - 1 = 21
> >      args->maxlen = 21
> > in the first allocation, and the following conversion should then
> > succeed.  At least, it's easy to be backported and do hotfix.
> > 
> > In the long term, args->total and args->minleft have be revisited
> > although it could cause more refactoring.
> > 
> > [1] commit 1ca89fbc48e1 ("xfs: don't account extra agfl blocks as available")
> >     https://lore.kernel.org/r/20190327145000.10756-1-bfoster@redhat.com
> > [2] https://lore.kernel.org/r/20220105071052.GD20464@templeofstupid.com
> > [3] https://lore.kernel.org/linux-xfs/Y2RevDyoeJZSpiat@B-P7TQMD6M-0146.local/2-dmesg.log.xz
> > Reported-by: Zirong Lang <zlang@redhat.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > Previous discussion is at:
> > https://lore.kernel.org/linux-xfs/202211040048.FeUQMLE6-lkp@intel.com/T/#mfcfac181079ddaa5a22eecb74db56534fc4ff918
> > 
> >  fs/xfs/libxfs/xfs_alloc.c | 9 +++++++--
> >  fs/xfs/libxfs/xfs_alloc.h | 1 +
> >  fs/xfs/libxfs/xfs_bmap.c  | 2 ++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > index 6261599bb389..684c67310175 100644
> > --- a/fs/xfs/libxfs/xfs_alloc.c
> > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > @@ -2630,7 +2630,12 @@ xfs_alloc_fix_freelist(
> >  		goto out_agbp_relse;
> >  	}
> >  
> > -	need = xfs_alloc_min_freelist(mp, pag);
> > +	/*
> > +	 * Also need to fulfill freespace btree splits by reservaing more
> > +	 * blocks to perform multiple allocations from a single AG and
> > +	 * transaction if needed.
> > +	 */
> > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> >  	if (!xfs_alloc_space_available(args, need, flags |
> >  			XFS_ALLOC_FLAG_CHECK))
> >  		goto out_agbp_relse;
> > @@ -2654,7 +2659,7 @@ xfs_alloc_fix_freelist(
> >  		xfs_agfl_reset(tp, agbp, pag);
> >  
> >  	/* If there isn't enough total space or single-extent, reject it. */
> > -	need = xfs_alloc_min_freelist(mp, pag);
> > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> >  	if (!xfs_alloc_space_available(args, need, flags))
> >  		goto out_agbp_relse;
> >  
> > diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> > index 2c3f762dfb58..be7f15d6a40d 100644
> > --- a/fs/xfs/libxfs/xfs_alloc.h
> > +++ b/fs/xfs/libxfs/xfs_alloc.h
> > @@ -73,6 +73,7 @@ typedef struct xfs_alloc_arg {
> >  	int		datatype;	/* mask defining data type treatment */
> >  	char		wasdel;		/* set if allocation was prev delayed */
> >  	char		wasfromfl;	/* set if allocation is from freelist */
> > +	bool		postallocs;	/* number of post-allocations */
> >  	struct xfs_owner_info	oinfo;	/* owner of blocks being allocated */
> >  	enum xfs_ag_resv_type	resv;	/* block reservation to use */
> >  #ifdef DEBUG
> > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > index 49d0d4ea63fc..ed92c6a314b6 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -3497,6 +3497,7 @@ xfs_bmap_exact_minlen_extent_alloc(
> >  	args.alignment = 1;
> >  	args.minalignslop = 0;
> >  
> > +	args.postallocs = 1;
> >  	args.minleft = ap->minleft;
> >  	args.wasdel = ap->wasdel;
> >  	args.resv = XFS_AG_RESV_NONE;
> > @@ -3658,6 +3659,7 @@ xfs_bmap_btalloc(
> >  		args.alignment = 1;
> >  		args.minalignslop = 0;
> >  	}
> > +	args.postallocs = 1;
> >  	args.minleft = ap->minleft;
> >  	args.wasdel = ap->wasdel;
> >  	args.resv = XFS_AG_RESV_NONE;
> 
> That's not going to work. What happens when we do a full bno
> split? Or we do both a bno and a cnt split in the same allocation?

I'm not sure if I got your point or not. I think it reserves another
full splits in the first allocation by doing:

	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);

as I wrote above.

> 
> Regardless, I don't see anything wrong with the allocation setup -
> it's telling the allocation code exactly what it needs for
> subsequent BMBT block allocations to succeed (i.e. args->minleft).

In the long term, I think the main point is that args->minleft doesn't
have the exact meaning.  I don't know how many blocks should be counted
by args->minleft or other ways.

> The problem here is that the internal allocation code is failing to
> handle the corner case where space is just about gone correctly.
> 
> As I pointed out previously - we have a huge amount of reserve space
> available in the AG here, so why not use some of the reserve space
> to get out of this temporary deficit corner case? We can argue that
> it's not really a deficit, either, because moving free blocks to the
> free list still accounts them as unused and free, so could still
> make up part of the unused reservation....
> 
> i.e. is the problem here simply that we don't allow AGFL blocks to
> be considered part of the reserved free space?

I don't know how to simply reuse per-AG reservation blocks for this,
and I think it could another corner case for this if it designs without
careful thinking.  For the moment, I'd like to have a quick fix for
our all old kernels, and if it's possible, we'd like to upstream it
first.

Thanks,
Gao Xiang

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
