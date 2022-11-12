Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1A626C06
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiKLVpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiKLVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:45:52 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F478165BF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:45:50 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y203so7811900pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 13:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mg/T96hXvi1JGLriaTwlSFAkCkkKwoJJgOdgFFCl5Rk=;
        b=ztxPp7M76LM0QT2xbS4B/Iy5c78Ymq+vffMKREZf6C5aAKMgaOOZ1wsKrsqTASxkwp
         r1Iqsgb77ZsOGsGZRgV4jJiLVVmAKHb9eL/TuxSalMhXW00Ee+xvH98qbIil6lv0fMxP
         0mMa85Dfj65iV4ZjLNB26LW6LMPHnMvpB2HKusuLidwbJp8Yr7OeckHEAaFd/hgqlGhb
         cJ+6GSivVFuCgZcePOyW+oR0zHn6BggBujj3eg2rppimV9tPgR2a0weiiotHN5nD0n5Z
         CX1W8ik3emlTQsP9XhrOzyN09N5ShX8D8mI+2xXwEzmo9erM37aQjydRRKXRxvqSK8b2
         sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg/T96hXvi1JGLriaTwlSFAkCkkKwoJJgOdgFFCl5Rk=;
        b=dweHRfYVll4vNn1Nyb1h+icdNrJGsLknoJWhCDvHvXE9dDJH4PLpNXd2ukoKg2bkQX
         198MuWnfvv5qXO+S1aV7o1jHC29+syHGKcZILyxtUxLLKTkkpz0II9oN0MISW8hFk23h
         4F4at+V1AfKykgheUZyTIpaUpt12rEYt16HN0turhzG39eCPH39kxnNg/O0xpg9thlmU
         /Z3RnBtIDPqu0F8xGzn7xyB6h2xkoYNiWveAk3YpmmVYJVXWvAFyg/j2WcUXIWRc+KZF
         +K9nCUjVDPCJ/nchAP9jAulD/7XNA+RT1XLbeUHZtBWjaCvpQM5H3Xp9s4SWs+pNI6L+
         msuQ==
X-Gm-Message-State: ANoB5pkPMeZaZkawLcU1wWocY+hSxiAa2/ipLp5TtH/PaC4UqYzmVoxd
        NcaI7C0BZea9Ve6h/pNQ30ek9g==
X-Google-Smtp-Source: AA0mqf4Cpx+u0k+pNbqXP36rrPPrPvw8cuVO1723NCheQPL9tiYqPYVDaY4on4waqHWlCps/TF8hAw==
X-Received: by 2002:a65:6497:0:b0:439:3ca0:5a29 with SMTP id e23-20020a656497000000b004393ca05a29mr6459179pgv.443.1668289549984;
        Sat, 12 Nov 2022 13:45:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b0018691ce1696sm4134735plh.131.2022.11.12.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:45:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1otyJt-00DTZC-97; Sun, 13 Nov 2022 08:45:45 +1100
Date:   Sun, 13 Nov 2022 08:45:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <20221112214545.GQ3600936@dread.disaster.area>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
 <Y27e2U155YvH9et4@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y27e2U155YvH9et4@debian>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 07:46:33AM +0800, Gao Xiang wrote:
> Hi Dave,
> 
> On Sat, Nov 12, 2022 at 07:39:05AM +1100, Dave Chinner wrote:
> > On Wed, Nov 09, 2022 at 11:48:02AM +0800, Gao Xiang wrote:
> > > There is a long standing issue which could cause fs shutdown due to
> > > inode extent-to-btree conversion failure right after an extent
> > > allocation in the same AG, which is absolutely unexpected due to the
> > > proper minleft reservation in the previous allocation.  Brian once
> > > addressed one of the root cause [1], however, such symptom can still
> > > occur after the commit is merged as reported [2], and our cloud
> > > environment is also suffering from this issue.
> > > 
> > > From the description of the commit [1], I found that Zirong has an
> > > in-house stress test reproducer for this issue, therefore I asked him
> > > to reproduce again and he confirmed that such issue can still be
> > > reproduced on RHEL 9 in several days.
> > > 
> > > Thanks to him, after adding some debugging code to dump the current
> > > transaction log items, I think the root cause is as below:
> > > 
> > >   1. xfs_bmapi_allocate() with the following condition:
> > >      freeblks: 18304 pagf_flcount: 6
> > >      reservation: 18276 need (min_free): 6
> > >      args->minleft: 1
> > >      available = freeblks + agflcount - reservation - need - minleft
> > >                = 18304 + min(6, 6) - 18276 - 6 - 1 = 27
> > >      The first allocation check itself is ok, and args->maxlen = 27
> > >      here
> > > 
> > >      At this time, AG 3 also has the following state:
> > >      1st:64  last:69  cnt:6  longest:6395
> > > 
> > >      AGFL has the following state:
> > >      64:547 65:167 66:1651 67:2040807 68:783 69:604
> > > 
> > >   2. Tried to get 27 blocks from this AG, but in order to finish such
> > >      allocation, it had to need a new btree block for cntbt (so take
> > >      another free block from agfl).  It can be seen with a new AGF
> > >      recorded in the transaction:
> > >       blkno 62914177, len 1, map_size 1
> > >       00000000: 58 41 47 46 00 00 00 01 00 00 00 03 00 27 ff f0  XAGF.........'..
> > >       00000010: 00 00 00 09 00 00 00 07 00 00 00 00 00 00 00 02  ................
> > >       00000020: 00 00 00 02 00 00 00 00 00 00 00 41 00 00 00 45  ...........A...E
> > >       00000030: 00 00 00 05 00 00 47 65 00 00 18 fb 00 00 00 09  ......Ge........
> > >       00000040: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> > > 
> > >       It can be parsed as:
> > >       agf 3  flfirst: 65 (0x41) fllast: 69 (0x45) cnt: 5
> > >       freeblks 18277
> > > 
> > >   3. agfl 64 (agbno 547, daddr 62918552) was then written as a cntbt
> > >      block, which can also be seen in a log item as below:
> > >        type#011= 0x123c
> > >        flags#011= 0x8
> > >       blkno 62918552, len 8, map_size 1
> > >       00000000: 41 42 33 43 00 00 00 fd 00 1f 23 e4 ff ff ff ff  AB3C......#.....
> > >       00000010: 00 00 00 00 03 c0 0f 98 00 00 00 00 00 00 00 00  ................
> > >       00000020: 75 dc c1 b5 1a 45 40 2a 80 50 72 f0 59 6e 62 66  u....E@*.Pr.Ynbf
> > >       ...
> > > 
> > >   4. Finally, the following inode extent to btree allocation fails
> > >      as below:
> > >      kernel: ------------[ cut here ]------------
> > >      WARNING: CPU: 15 PID: 49290 at fs/xfs/libxfs/xfs_bmap.c:717 xfs_bmap_extents_to_btree+0xc51/0x1050 [xfs]
> > >      ...
> > >      XFS (sda2): agno 3 agflcount 5 freeblks 18277 reservation 18276 6
> > > 
> > >      since freeblks = 18304 - 27 = 18277, but with another agfl
> > >      block allocated (pagf_flcount from 6 to 5), the inequality will
> > >      not be satisfied:
> > > 
> > >      available = freeblks + agflcount - reservation - need - minleft
> > >                = 18277 + min(5, 6) - 18276 - 6 - 0 = 0   < 1
> > > 
> > >   Full current transaction log item dump can be fetched from [3].
> > > 
> > > As a short-term solution, the following allocations (e.g. allocation
> > > for inode extent-to-btree conversion) can be recorded in order to count
> > > more blocks to reserve for safely freespace btree splits so that it
> > > will shorten available and args->maxlen to
> > >      available = freeblks + agflcount - reservation - need - minleft
> > >                = 18304 + min(6, 6) - 18276 - 6*2 - 1 = 21
> > >      args->maxlen = 21
> > > in the first allocation, and the following conversion should then
> > > succeed.  At least, it's easy to be backported and do hotfix.
> > > 
> > > In the long term, args->total and args->minleft have be revisited
> > > although it could cause more refactoring.
> > > 
> > > [1] commit 1ca89fbc48e1 ("xfs: don't account extra agfl blocks as available")
> > >     https://lore.kernel.org/r/20190327145000.10756-1-bfoster@redhat.com
> > > [2] https://lore.kernel.org/r/20220105071052.GD20464@templeofstupid.com
> > > [3] https://lore.kernel.org/linux-xfs/Y2RevDyoeJZSpiat@B-P7TQMD6M-0146.local/2-dmesg.log.xz
> > > Reported-by: Zirong Lang <zlang@redhat.com>
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > > Previous discussion is at:
> > > https://lore.kernel.org/linux-xfs/202211040048.FeUQMLE6-lkp@intel.com/T/#mfcfac181079ddaa5a22eecb74db56534fc4ff918
> > > 
> > >  fs/xfs/libxfs/xfs_alloc.c | 9 +++++++--
> > >  fs/xfs/libxfs/xfs_alloc.h | 1 +
> > >  fs/xfs/libxfs/xfs_bmap.c  | 2 ++
> > >  3 files changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > > index 6261599bb389..684c67310175 100644
> > > --- a/fs/xfs/libxfs/xfs_alloc.c
> > > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > > @@ -2630,7 +2630,12 @@ xfs_alloc_fix_freelist(
> > >  		goto out_agbp_relse;
> > >  	}
> > >  
> > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > +	/
> > > +	 * Also need to fulfill freespace btree splits by reservaing more
> > > +	 * blocks to perform multiple allocations from a single AG and
> > > +	 * transaction if needed.
> > > +	 */
> > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > >  	if (!xfs_alloc_space_available(args, need, flags |
> > >  			XFS_ALLOC_FLAG_CHECK))
> > >  		goto out_agbp_relse;
> > > @@ -2654,7 +2659,7 @@ xfs_alloc_fix_freelist(
> > >  		xfs_agfl_reset(tp, agbp, pag);
> > >  
> > >  	/* If there isn't enough total space or single-extent, reject it. */
> > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > >  	if (!xfs_alloc_space_available(args, need, flags))
> > >  		goto out_agbp_relse;
> > >  
> > > diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> > > index 2c3f762dfb58..be7f15d6a40d 100644
> > > --- a/fs/xfs/libxfs/xfs_alloc.h
> > > +++ b/fs/xfs/libxfs/xfs_alloc.h
> > > @@ -73,6 +73,7 @@ typedef struct xfs_alloc_arg {
> > >  	int		datatype;	/* mask defining data type treatment */
> > >  	char		wasdel;		/* set if allocation was prev delayed */
> > >  	char		wasfromfl;	/* set if allocation is from freelist */
> > > +	bool		postallocs;	/* number of post-allocations */
> > >  	struct xfs_owner_info	oinfo;	/* owner of blocks being allocated */
> > >  	enum xfs_ag_resv_type	resv;	/* block reservation to use */
> > >  #ifdef DEBUG
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 49d0d4ea63fc..ed92c6a314b6 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -3497,6 +3497,7 @@ xfs_bmap_exact_minlen_extent_alloc(
> > >  	args.alignment = 1;
> > >  	args.minalignslop = 0;
> > >  
> > > +	args.postallocs = 1;
> > >  	args.minleft = ap->minleft;
> > >  	args.wasdel = ap->wasdel;
> > >  	args.resv = XFS_AG_RESV_NONE;
> > > @@ -3658,6 +3659,7 @@ xfs_bmap_btalloc(
> > >  		args.alignment = 1;
> > >  		args.minalignslop = 0;
> > >  	}
> > > +	args.postallocs = 1;
> > >  	args.minleft = ap->minleft;
> > >  	args.wasdel = ap->wasdel;
> > >  	args.resv = XFS_AG_RESV_NONE;
> > 
> > That's not going to work. What happens when we do a full bno
> > split? Or we do both a bno and a cnt split in the same allocation?
> 
> I'm not sure if I got your point or not. I think it reserves another
> full splits in the first allocation by doing:
> 
> 	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> 
> as I wrote above.

You're changing the BMBT reservation code. If the first "post-extent
BMBT block allocation" does a full split of both the bno/cnt trees,
then this uses all the AGFL reservations made.

How many blocks does a BMBT split need to allocate?

> > Regardless, I don't see anything wrong with the allocation setup -
> > it's telling the allocation code exactly what it needs for
> > subsequent BMBT block allocations to succeed (i.e. args->minleft).
> 
> In the long term, I think the main point is that args->minleft doesn't
> have the exact meaning.  I don't know how many blocks should be counted
> by args->minleft or other ways.

args->minleft has an *exact* meaning - that the AG must have that
many blocks left available for potential btree record insertion
allocations after the initial extent is allocated. For inode fork
allocations, the BMBT blocks required is defined by
xfs_bmapi_minleft(). For inode chunk extent allocation and inobt
record insertion, it is defined by the pre-calculated
igeo->inobt_maxlevels variable.

IOWs, this "postalloc" concept is redundant - minleft already
provides the maximum number of single block allocations that need to
have space reserved in the AG for the initial extent allocation to
succeed. i.e.  the allocation setup is already taking into account
blocks needed for extra allocations within the AG, but that's not
being handled correctly by the AG allocation code.

On review, it is quite possible that args->minleft is not being
handled by the BMBT and inobt block allocation code correctly.
Shouldn't btree block allocation drop args->minleft by 1 for
each block that is allocated?

> > The problem here is that the internal allocation code is failing to
> > handle the corner case where space is just about gone correctly.
> > 
> > As I pointed out previously - we have a huge amount of reserve space
> > available in the AG here, so why not use some of the reserve space
> > to get out of this temporary deficit corner case? We can argue that
> > it's not really a deficit, either, because moving free blocks to the
> > free list still accounts them as unused and free, so could still
> > make up part of the unused reservation....
> > 
> > i.e. is the problem here simply that we don't allow AGFL blocks to
> > be considered part of the reserved free space?
> 
> I don't know how to simply reuse per-AG reservation blocks for this,

I don't know either, which is *why I asked the question*. i.e. I'm
asking for you to investigate a potential alternative solution that
challenges a design assumption this code makes. i.e. AGBNO and AGCNT
btree blocks are considered free space because when we are at ENOSPC
they are empty.

However, with this ag reservation code, we can be at ENOSPC when
there are still tens of thousands of free extents, and hence the
AGBNO and AGCNT btree blocks are used space, not free space. The
AGFL accounting is based on AGFL blocks being considered free space,
which matches the AG btree blocks being considered free space, and
so maybe the root of the problem here is the assumption that AG
btree blocks and AGFL blocks are accounted as free space rather than
part of this new "reserved space"....

> and I think it could another corner case for this if it designs without
> careful thinking.  For the moment, I'd like to have a quick fix for
> our all old kernels, and if it's possible, we'd like to upstream it
> first.

Slapping expedient bandaids into upstream kernels because some
vendor production kernel needs a quick fix is bad process and bad
policy.

"Upstream first" as a policy was originally intended for major
changes (e.g new features, design changes, on-disk format changes,
etc) to ensure that there is consensus on the changes and they've
been adequately reviewed before they get deployed to production
environments.

Over time, this has morphed into vendors defining "upstream first"
as "we can't ship any code unless it is upstream first". That's a
much different policy, and while the intention is good it is being
used more and more frequently as a big hammer to try to force
upstream to take poor code. i.e. it encourages vendor engineers to
"hack on a problem until it goes away, then get it merged upstream
because *urgent for production* and upstream first!!!!".

IOWs, "upstream first" is not intended as a mechanism to enable
band-aids to be applied so some random production system can avoid
an issue right now. "upstream first" as a policy is intended to get
the *right fix to production systems* as quickly as possible.

If anyone wants upstream to merge a band-aid that is easy to back
port, then it should be provided as the first patch in the series
that fixes the problem properly. The series that is merged needs to
effectively remove the technical debt the "easy to backport"
band-aid adds to the kernel. The end result in the upstream kernel
should always be "we fixed the problem to the best of our
abilities", not "we fixed the problem as quickly as possible"....

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
