Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901D26292CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKOH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOH6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:58:04 -0500
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AE118397;
        Mon, 14 Nov 2022 23:57:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VUsYk62_1668499074;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUsYk62_1668499074)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 15:57:56 +0800
Date:   Tue, 15 Nov 2022 15:57:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y3NGghqFDEoMPojt@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
 <Y27e2U155YvH9et4@debian>
 <20221112214545.GQ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221112214545.GQ3600936@dread.disaster.area>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sun, Nov 13, 2022 at 08:45:45AM +1100, Dave Chinner wrote:
> On Sat, Nov 12, 2022 at 07:46:33AM +0800, Gao Xiang wrote:
> > Hi Dave,
> > 
> > On Sat, Nov 12, 2022 at 07:39:05AM +1100, Dave Chinner wrote:
> > > On Wed, Nov 09, 2022 at 11:48:02AM +0800, Gao Xiang wrote:
> > > > There is a long standing issue which could cause fs shutdown due to
> > > > inode extent-to-btree conversion failure right after an extent
> > > > allocation in the same AG, which is absolutely unexpected due to the
> > > > proper minleft reservation in the previous allocation.  Brian once
> > > > addressed one of the root cause [1], however, such symptom can still
> > > > occur after the commit is merged as reported [2], and our cloud
> > > > environment is also suffering from this issue.
> > > > 
> > > > From the description of the commit [1], I found that Zirong has an
> > > > in-house stress test reproducer for this issue, therefore I asked him
> > > > to reproduce again and he confirmed that such issue can still be
> > > > reproduced on RHEL 9 in several days.
> > > > 
> > > > Thanks to him, after adding some debugging code to dump the current
> > > > transaction log items, I think the root cause is as below:
> > > > 
> > > >   1. xfs_bmapi_allocate() with the following condition:
> > > >      freeblks: 18304 pagf_flcount: 6
> > > >      reservation: 18276 need (min_free): 6
> > > >      args->minleft: 1
> > > >      available = freeblks + agflcount - reservation - need - minleft
> > > >                = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> > > >      The first allocation check itself is ok, and args->maxlen = 27
> > > >      here
> > > > 
> > > >      At this time, AG 3 also has the following state:
> > > >      1st:64  last:69  cnt:6  longest:6395
> > > > 
> > > >      AGFL has the following state:
> > > >      64:547 65:167 66:1651 67:2040807 68:783 69:604
> > > > 
> > > >   2. Tried to get 27 blocks from this AG, but in order to finish such
> > > >      allocation, it had to need a new btree block for cntbt (so take
> > > >      another free block from agfl).  It can be seen with a new AGF
> > > >      recorded in the transaction:
> > > >       blkno 62914177, len 1, map_size 1
> > > >       00000000: 58 41 47 46 00 00 00 01 00 00 00 03 00 27 ff f0  XAGF.........'..
> > > >       00000010: 00 00 00 09 00 00 00 07 00 00 00 00 00 00 00 02  ................
> > > >       00000020: 00 00 00 02 00 00 00 00 00 00 00 41 00 00 00 45  ...........A...E
> > > >       00000030: 00 00 00 05 00 00 47 65 00 00 18 fb 00 00 00 09  ......Ge........
> > > >       00000040: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> > > > 
> > > >       It can be parsed as:
> > > >       agf 3  flfirst: 65 (0x41) fllast: 69 (0x45) cnt: 5
> > > >       freeblks 18277
> > > > 
> > > >   3. agfl 64 (agbno 547, daddr 62918552) was then written as a cntbt
> > > >      block, which can also be seen in a log item as below:
> > > >        type#011= 0x123c
> > > >        flags#011= 0x8
> > > >       blkno 62918552, len 8, map_size 1
> > > >       00000000: 41 42 33 43 00 00 00 fd 00 1f 23 e4 ff ff ff ff  AB3C......#.....
> > > >       00000010: 00 00 00 00 03 c0 0f 98 00 00 00 00 00 00 00 00  ................
> > > >       00000020: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> > > >       ...
> > > > 
> > > >   4. Finally, the following inode extent to btree allocation fails
> > > >      as below:
> > > >      kernel: ------------[ cut here ]------------
> > > >      WARNING: CPU: 15 PID: 49290 at fs/xfs/libxfs/xfs_bmap.c:717 xfs_bmap_extents_to_btree+0xc51/0x1050 [xfs]
> > > >      ...
> > > >      XFS (sda2): agno 3 agflcount 5 freeblks 18277 reservation 18276 6
> > > > 
> > > >      since freeblks = 18304 - 27 = 18277, but with another agfl
> > > >      block allocated (pagf_flcount from 6 to 5), the inequality will
> > > >      not be satisfied:
> > > > 
> > > >      available = freeblks + agflcount - reservation - need - minleft
> > > >                = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
> > > > 
> > > >   Full current transaction log item dump can be fetched from [3].
> > > > 
> > > > As a short-term solution, the following allocations (e.g. allocation
> > > > for inode extent-to-btree conversion) can be recorded in order to count
> > > > more blocks to reserve for safely freespace btree splits so that it
> > > > will shorten available and args->maxlen to
> > > >      available = freeblks + agflcount - reservation - need - minleft
> > > >                = 18304 + min(6, 6) - 18276 - 6*2 - 1 = 21
> > > >      args->maxlen = 21
> > > > in the first allocation, and the following conversion should then
> > > > succeed.  At least, it's easy to be backported and do hotfix.
> > > > 
> > > > In the long term, args->total and args->minleft have be revisited
> > > > although it could cause more refactoring.
> > > > 
> > > > [1] commit 1ca89fbc48e1 ("xfs: don't account extra agfl blocks as available")
> > > >     https://lore.kernel.org/r/20190327145000.10756-1-bfoster@redhat.com
> > > > [2] https://lore.kernel.org/r/20220105071052.GD20464@templeofstupid.com
> > > > [3] https://lore.kernel.org/linux-xfs/Y2RevDyoeJZSpiat@B-P7TQMD6M-0146.local/2-dmesg.log.xz
> > > > Reported-by: Zirong Lang <zlang@redhat.com>
> > > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > > ---
> > > > Previous discussion is at:
> > > > https://lore.kernel.org/linux-xfs/202211040048.FeUQMLE6-lkp@intel.com/T/#mfcfac181079ddaa5a22eecb74db56534fc4ff918
> > > > 
> > > >  fs/xfs/libxfs/xfs_alloc.c | 9 +++++++--
> > > >  fs/xfs/libxfs/xfs_alloc.h | 1 +
> > > >  fs/xfs/libxfs/xfs_bmap.c  | 2 ++
> > > >  3 files changed, 10 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > > > index 6261599bb389..684c67310175 100644
> > > > --- a/fs/xfs/libxfs/xfs_alloc.c
> > > > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > > > @@ -2630,7 +2630,12 @@ xfs_alloc_fix_freelist(
> > > >  		goto out_agbp_relse;
> > > >  	}
> > > >  
> > > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > > +	/
> > > > +	 * Also need to fulfill freespace btree splits by reservaing more
> > > > +	 * blocks to perform multiple allocations from a single AG and
> > > > +	 * transaction if needed.
> > > > +	 */
> > > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > > >  	if (!xfs_alloc_space_available(args, need, flags |
> > > >  			XFS_ALLOC_FLAG_CHECK))
> > > >  		goto out_agbp_relse;
> > > > @@ -2654,7 +2659,7 @@ xfs_alloc_fix_freelist(
> > > >  		xfs_agfl_reset(tp, agbp, pag);
> > > >  
> > > >  	/* If there isn't enough total space or single-extent, reject it. */
> > > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > > >  	if (!xfs_alloc_space_available(args, need, flags))
> > > >  		goto out_agbp_relse;
> > > >  
> > > > diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> > > > index 2c3f762dfb58..be7f15d6a40d 100644
> > > > --- a/fs/xfs/libxfs/xfs_alloc.h
> > > > +++ b/fs/xfs/libxfs/xfs_alloc.h
> > > > @@ -73,6 +73,7 @@ typedef struct xfs_alloc_arg {
> > > >  	int		datatype;	/* mask defining data type treatment */
> > > >  	char		wasdel;		/* set if allocation was prev delayed */
> > > >  	char		wasfromfl;	/* set if allocation is from freelist */
> > > > +	bool		postallocs;	/* number of post-allocations */
> > > >  	struct xfs_owner_info	oinfo;	/* owner of blocks being allocated */
> > > >  	enum xfs_ag_resv_type	resv;	/* block reservation to use */
> > > >  #ifdef DEBUG
> > > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > > index 49d0d4ea63fc..ed92c6a314b6 100644
> > > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > > @@ -3497,6 +3497,7 @@ xfs_bmap_exact_minlen_extent_alloc(
> > > >  	args.alignment = 1;
> > > >  	args.minalignslop = 0;
> > > >  
> > > > +	args.postallocs = 1;
> > > >  	args.minleft = ap->minleft;
> > > >  	args.wasdel = ap->wasdel;
> > > >  	args.resv = XFS_AG_RESV_NONE;
> > > > @@ -3658,6 +3659,7 @@ xfs_bmap_btalloc(
> > > >  		args.alignment = 1;
> > > >  		args.minalignslop = 0;
> > > >  	}
> > > > +	args.postallocs = 1;
> > > >  	args.minleft = ap->minleft;
> > > >  	args.wasdel = ap->wasdel;
> > > >  	args.resv = XFS_AG_RESV_NONE;
> > > 
> > > That's not going to work. What happens when we do a full bno
> > > split? Or we do both a bno and a cnt split in the same allocation?
> > 
> > I'm not sure if I got your point or not. I think it reserves another
> > full splits in the first allocation by doing:
> > 
> > 	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > 
> > as I wrote above.
> 
> You're changing the BMBT reservation code. If the first "post-extent
> BMBT block allocation" does a full split of both the bno/cnt trees,
> then this uses all the AGFL reservations made.

Emmm... I have to align my understanding of this first, I think one
example of what you meant is
  1. allocate an extent for an inode with minleft = 1;
  2. then do extents-to-btree allocation with one block, even minleft
     was reserved as 1 in the previous allocation but such one-block
     allocation from non-AGFL can cause full bno/cnt splits, which
     could takes xfs_alloc_min_freelist() blocks from AGFL and could
     take up all AGFL blocks?

If my understanding above is like what you said, I think the current
codebase may also have a chance to eat up all AGFL blocks in the first
allocation since more agfl blocks are only filled in
xfs_alloc_fix_freelist(), but later xfs_alloc_ag_vextent() could
cause full bno/cnt splits as well?

Please help correct me if my understanding about your ask is wrong.

> 
> How many blocks does a BMBT split need to allocate?

IMO, a full bmbt split can allocate btree level blocks at maximum,
but if these block allocation cause bno/cnt btree splits, that
needs more than such blocks.  So I think that's why AGFL is needed
for XFS.  IOWs, that is to prepare enough blocks for bno/cnt splits
to avoid cyclic dependency.

But I'm not sure if the current AGFL reservation works properly
if multiple allocations must be succeeded in the same AG, see below..)

> 
> > > Regardless, I don't see anything wrong with the allocation setup -
> > > it's telling the allocation code exactly what it needs for
> > > subsequent BMBT block allocations to succeed (i.e. args->minleft).
> > 
> > In the long term, I think the main point is that args->minleft doesn't
> > have the exact meaning.  I don't know how many blocks should be counted
> > by args->minleft or other ways.
> 
> args->minleft has an *exact* meaning - that the AG must have that
> many blocks left available for potential btree record insertion
> allocations after the initial extent is allocated. For inode fork
> allocations, the BMBT blocks required is defined by
> xfs_bmapi_minleft(). For inode chunk extent allocation and inobt
> record insertion, it is defined by the pre-calculated
> igeo->inobt_maxlevels variable.
> 
> IOWs, this "postalloc" concept is redundant - minleft already
> provides the maximum number of single block allocations that need to
> have space reserved in the AG for the initial extent allocation to
> succeed. i.e.  the allocation setup is already taking into account
> blocks needed for extra allocations within the AG, but that's not
> being handled correctly by the AG allocation code.

I don't think it's the case as I described in the patch commit message,
if we go over the words at the top, the main point is
 
 In the first allocation, minleft = 1, the current allocator assumes
 it can allocate an extent with 27 blocks (the remaining blocks are
 18276 per-AG reservation, 6 for AGFL reservation, 1 for inode extents
 -to-btree for the following allocation).

 But here in order to finish this allocation with 27 blocks, it splits
 cntbt so that it takes another unexpected block from AGFL, and
 that wasn't accounted in minleft (or with any other fields) before.

 I don't think it can be directly described by minleft because
 such extra bno/cntbt reservation needs more knowledge of bno/cntbt
 internals (such as current bno/cnt btree levels), so I don't think
 it should belong to BMBT allocation code at least.

 So here I introduced another variable to describe the total number
 of post-allocations, I think it's just enough to resolve the inode
 extents-to-btree bno/cntbt reservation issue.

> 
> On review, it is quite possible that args->minleft is not being
> handled by the BMBT and inobt block allocation code correctly.
> Shouldn't btree block allocation drop args->minleft by 1 for
> each block that is allocated?

At least, in order to convert from inode extents-to-btree, we need
another block for the following allocation, so minleft = 1 here.

	if (ifp->if_format != XFS_DINODE_FMT_BTREE)
		return 1;

So I guess what you meant is
	return be16_to_cpu(ifp->if_broot->bb_level) + 1; ?

I don't know why it has another 1 here, yet even if we account an
extra block here, I think it doesn't have some critical result
since the worst case is that it just returns -ENOSPC in advance.

But in principle, most users use terabytes XFS, so I think such
one extra block doesn't matter too much.  I will update this if
such 1 is meaningless, but it doesn't actually contribute to the
real shutdown issue.

> 
> > > The problem here is that the internal allocation code is failing to
> > > handle the corner case where space is just about gone correctly.
> > > 
> > > As I pointed out previously - we have a huge amount of reserve space
> > > available in the AG here, so why not use some of the reserve space
> > > to get out of this temporary deficit corner case? We can argue that
> > > it's not really a deficit, either, because moving free blocks to the
> > > free list still accounts them as unused and free, so could still
> > > make up part of the unused reservation....
> > > 
> > > i.e. is the problem here simply that we don't allow AGFL blocks to
> > > be considered part of the reserved free space?
> > 
> > I don't know how to simply reuse per-AG reservation blocks for this,
> 
> I don't know either, which is *why I asked the question*. i.e. I'm
> asking for you to investigate a potential alternative solution that
> challenges a design assumption this code makes. i.e. AGBNO and AGCNT
> btree blocks are considered free space because when we are at ENOSPC
> they are empty.
> 
> However, with this ag reservation code, we can be at ENOSPC when
> there are still tens of thousands of free extents, and hence the
> AGBNO and AGCNT btree blocks are used space, not free space. The
> AGFL accounting is based on AGFL blocks being considered free space,
> which matches the AG btree blocks being considered free space, and
> so maybe the root of the problem here is the assumption that AG
> btree blocks and AGFL blocks are accounted as free space rather than
> part of this new "reserved space"....

I have strong feeling that the current per-AG reservation code (or
AGFL reservation as in xfs_alloc_min_freelist() ) doesn't work
properly for multiple allocations in the same AG in order to make
sure such multiple allocations all succeed.

Also, a wilder question is that I'm not sure why such multiple
allocations in oneshot _cannot_ be handled with a defer ops as
some new log intent, so that we don't need to care about minleft
messy anymore.

> 
> > and I think it could another corner case for this if it designs without
> > careful thinking.  For the moment, I'd like to have a quick fix for
> > our all old kernels, and if it's possible, we'd like to upstream it
> > first.
> 
> Slapping expedient bandaids into upstream kernels because some
> vendor production kernel needs a quick fix is bad process and bad
> policy.
> 
> "Upstream first" as a policy was originally intended for major
> changes (e.g new features, design changes, on-disk format changes,
> etc) to ensure that there is consensus on the changes and they've
> been adequately reviewed before they get deployed to production
> environments.
> 
> Over time, this has morphed into vendors defining "upstream first"
> as "we can't ship any code unless it is upstream first". That's a
> much different policy, and while the intention is good it is being
> used more and more frequently as a big hammer to try to force
> upstream to take poor code. i.e. it encourages vendor engineers to
> "hack on a problem until it goes away, then get it merged upstream
> because *urgent for production* and upstream first!!!!".
> 
> IOWs, "upstream first" is not intended as a mechanism to enable
> band-aids to be applied so some random production system can avoid
> an issue right now. "upstream first" as a policy is intended to get
> the *right fix to production systems* as quickly as possible.
> 
> If anyone wants upstream to merge a band-aid that is easy to back
> port, then it should be provided as the first patch in the series
> that fixes the problem properly. The series that is merged needs to
> effectively remove the technical debt the "easy to backport"
> band-aid adds to the kernel. The end result in the upstream kernel
> should always be "we fixed the problem to the best of our
> abilities", not "we fixed the problem as quickly as possible"....
> 

One request, could we discuss further about how to resolve this
issue properly on IRC?  I really would like to take time to resolve
this issue formally and I can imagine it's not a easy fix.
Yet I think I need your/Darrick more inputs/tendency about this.

For now, I have to apply this patch to our production, otherwise,
it has very bad impacts to our cloud business by using XFS...
since user workloads could be shut down without any sign before.

Thanks,
Gao Xiang


> Cheers,
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
