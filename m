Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209D62B17E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKPCvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKPCvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:51:12 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6511EAE7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:51:10 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n17so7774110pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/20hT1zOIY/n/ujE1Jylz4l0j44xAuJADztSQpK+Xv0=;
        b=YNd4gDxKgWIJ0WsWH5qoQlEfLimjWCp++eoOMy4rFJWPEzXv+9RtbcHWuXXrLijqZu
         ceRNHdvhEyqR74I/QJMG62yoR9ausYN2FZOXOgD+1bbAxi6OjjXYN4noXS13ULOH9SMX
         KlJw9QnlDCGVXZV6KCc5HP/PWJDQo9TVb+lGTltIdSXOLQveJL+T1o0le0v5lKZ2Wbp/
         MaulQVGZ32oYUIxoC1YQFwJl4zRH1iK7LILh6oBZChJxJkbA57ZhgYl69mYEJAJZi2+3
         RL0FG5KNMDWKMzFftm5JLcLGuCMIRhWMeBGgH0m2MYdrupUIqwPUJkSPwo+UsswFWBv0
         ajKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/20hT1zOIY/n/ujE1Jylz4l0j44xAuJADztSQpK+Xv0=;
        b=LnQa+61Z4aLBb4E5o6cSeRUGmpwLn+uLXDX0MskMdwzs7vDwH6osfPCo68w5Foq7Gm
         TyV1MZi2hW9us2eoblPsxoqu8m5DuWC0VAbr/vh5wgUUIUWfCbF+nu5OU53u96SoFA/G
         6D9Z+AKHhfvkdQu4L9oLliixp8DuajE65Uxkmb1PmmZDZI4ua/yW154wkspY5C61Y1eB
         kEM/OaEJM711dyjd6LTNiqkBLjRi18mELne+1qvPy83jSApUbf3byt3Te1F9a5JOZT+j
         lAB7HmBz6Fcw0w6mvnTaQ0kiOVavcA4r2Y1alwt7UG8S7hdFGY4YjEzJKHchmvwGgBpL
         oLdg==
X-Gm-Message-State: ANoB5pmWd/RlbfFVeHmlCSDw1SfLpZfFKYL4sUiF9KRvBJAtnfOX4Wwg
        zN103WRyx/w7ZEuHHm6C8O2zPQ==
X-Google-Smtp-Source: AA0mqf69ACTqzY3lEvSApEs3DTSK64/44ncGcNMB88FaXLPiAu5mlh1NIS/OtAwRng9nJPsd+XPH2A==
X-Received: by 2002:a63:1223:0:b0:476:95a8:de78 with SMTP id h35-20020a631223000000b0047695a8de78mr9237272pgl.66.1668567070227;
        Tue, 15 Nov 2022 18:51:10 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902868300b00186ac812ab0sm10654940plo.83.2022.11.15.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:51:09 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ov8W2-00EjxM-39; Wed, 16 Nov 2022 13:51:06 +1100
Date:   Wed, 16 Nov 2022 13:51:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <20221116025106.GB3600936@dread.disaster.area>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
 <Y27e2U155YvH9et4@debian>
 <20221112214545.GQ3600936@dread.disaster.area>
 <Y3NGghqFDEoMPojt@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NGghqFDEoMPojt@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:57:54PM +0800, Gao Xiang wrote:
> On Sun, Nov 13, 2022 at 08:45:45AM +1100, Dave Chinner wrote:
> > On Sat, Nov 12, 2022 at 07:46:33AM +0800, Gao Xiang wrote:
> > > On Sat, Nov 12, 2022 at 07:39:05AM +1100, Dave Chinner wrote:
> > > > On Wed, Nov 09, 2022 at 11:48:02AM +0800, Gao Xiang wrote:
> > > > > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > > > > index 6261599bb389..684c67310175 100644
> > > > > --- a/fs/xfs/libxfs/xfs_alloc.c
> > > > > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > > > > @@ -2630,7 +2630,12 @@ xfs_alloc_fix_freelist(
> > > > >  		goto out_agbp_relse;
> > > > >  	}
> > > > >  
> > > > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > > > +	/
> > > > > +	 * Also need to fulfill freespace btree splits by reservaing more
> > > > > +	 * blocks to perform multiple allocations from a single AG and
> > > > > +	 * transaction if needed.
> > > > > +	 */
> > > > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > > > >  	if (!xfs_alloc_space_available(args, need, flags |
> > > > >  			XFS_ALLOC_FLAG_CHECK))
> > > > >  		goto out_agbp_relse;
> > > > > @@ -2654,7 +2659,7 @@ xfs_alloc_fix_freelist(
> > > > >  		xfs_agfl_reset(tp, agbp, pag);
> > > > >  
> > > > >  	/* If there isn't enough total space or single-extent, reject it. */
> > > > > -	need = xfs_alloc_min_freelist(mp, pag);
> > > > > +	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > > > >  	if (!xfs_alloc_space_available(args, need, flags))
> > > > >  		goto out_agbp_relse;
> > > > >  
> > > > > diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
> > > > > index 2c3f762dfb58..be7f15d6a40d 100644
> > > > > --- a/fs/xfs/libxfs/xfs_alloc.h
> > > > > +++ b/fs/xfs/libxfs/xfs_alloc.h
> > > > > @@ -73,6 +73,7 @@ typedef struct xfs_alloc_arg {
> > > > >  	int		datatype;	/* mask defining data type treatment */
> > > > >  	char		wasdel;		/* set if allocation was prev delayed */
> > > > >  	char		wasfromfl;	/* set if allocation is from freelist */
> > > > > +	bool		postallocs;	/* number of post-allocations */
> > > > >  	struct xfs_owner_info	oinfo;	/* owner of blocks being allocated */
> > > > >  	enum xfs_ag_resv_type	resv;	/* block reservation to use */
> > > > >  #ifdef DEBUG
> > > > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > > > index 49d0d4ea63fc..ed92c6a314b6 100644
> > > > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > > > @@ -3497,6 +3497,7 @@ xfs_bmap_exact_minlen_extent_alloc(
> > > > >  	args.alignment = 1;
> > > > >  	args.minalignslop = 0;
> > > > >  
> > > > > +	args.postallocs = 1;
> > > > >  	args.minleft = ap->minleft;
> > > > >  	args.wasdel = ap->wasdel;
> > > > >  	args.resv = XFS_AG_RESV_NONE;
> > > > > @@ -3658,6 +3659,7 @@ xfs_bmap_btalloc(
> > > > >  		args.alignment = 1;
> > > > >  		args.minalignslop = 0;
> > > > >  	}
> > > > > +	args.postallocs = 1;
> > > > >  	args.minleft = ap->minleft;
> > > > >  	args.wasdel = ap->wasdel;
> > > > >  	args.resv = XFS_AG_RESV_NONE;
> > > > 
> > > > That's not going to work. What happens when we do a full bno
> > > > split? Or we do both a bno and a cnt split in the same allocation?
> > > 
> > > I'm not sure if I got your point or not. I think it reserves another
> > > full splits in the first allocation by doing:
> > > 
> > > 	need = xfs_alloc_min_freelist(mp, pag) * (1 + args->postallocs);
> > > 
> > > as I wrote above.
> > 
> > You're changing the BMBT reservation code. If the first "post-extent
> > BMBT block allocation" does a full split of both the bno/cnt trees,
> > then this uses all the AGFL reservations made.
> 
> Emmm... I have to align my understanding of this first, I think one
> example of what you meant is
>   1. allocate an extent for an inode with minleft = 1;
>   2. then do extents-to-btree allocation with one block, even minleft
>      was reserved as 1 in the previous allocation but such one-block
>      allocation from non-AGFL can cause full bno/cnt splits, which
>      could takes xfs_alloc_min_freelist() blocks from AGFL and could
>      take up all AGFL blocks?
>
> If my understanding above is like what you said, I think the current
> codebase may also have a chance to eat up all AGFL blocks in the first
> allocation since more agfl blocks are only filled in
> xfs_alloc_fix_freelist(), but later xfs_alloc_ag_vextent() could
> cause full bno/cnt splits as well?

Yes, the second allocation here might only require 1 block, which is
what args->minleft says. But the problem is that nothing is
reserving AGFL blocks for those nested extent allocations...

..... because the assumption is that AGFL blocks come from free
space and so when we are at ENOSPC bno/cnt btrees *do no require
splits* so will not consume extra space. Hence allocation at ENOSPC
doesn't need to take into account AGFL block usage because the AGFL
will not be consumed.

Similarly, if we have enough free space records to split a free
space btree block, we have enough free space to refill the AGFL
multiple times and we don't have to reserve space for them.

IOWs, the allocation code has, historically, never had to care about
AGFL refilling when the AG is near ENOSPC as nothing will consume
AGFL blocks when the AG is near empty.

This is the design assumption that AG reservations broke. This is
why I'm asking you to look into taking blocks that are supposedly
reserved for the AGFL, because as reserved space is used, the
bno/cnt btrees will shrink and return those blocks to free space and
hence they are still available for reserved allocations to use as
the real physical ENOSPC condition approaches.

The more I look at this, the more I think overall answer to this
problem is to allow AGFL refilling to ignore AG reserves rather than
causing ENOSPC....

----

Regardless of the above, answers to the rest of you questions follow.

> Please help correct me if my understanding about your ask is wrong.
> 
> > 
> > How many blocks does a BMBT split need to allocate?
> 
> IMO, a full bmbt split can allocate btree level blocks at maximum,
> but if these block allocation cause bno/cnt btree splits, that
> needs more than such blocks.

And how many individual allocations does that require?

> So I think that's why AGFL is needed
> for XFS.  IOWs, that is to prepare enough blocks for bno/cnt splits
> to avoid cyclic dependency.

The AGFL is there to ensure any *one* space allocation succeeds.

> But I'm not sure if the current AGFL reservation works properly
> if multiple allocations must be succeeded in the same AG, see below..)

Right, it does not provide any guarantees across mutliple successive
allocations like an extent + BMBT split chain. That's what
args->minleft is supposed to provide.

However, it does provide the guarantee that when near ENOSPC,
bno/cnt splits and hence AGFL consumption will not occur, thereby
ensuring that if args->minleft is reserved correctly, operation
right up to ENOSPC will work correctly without AGFL reservations
because the AGFL will not be consumed.

Hence my comments above about the problem being the way AG
reservations moved ENOSPC from "AG physically empty" to "AG still
has thousands of free extents but remaining space unavailable to
user data allocation".

> > > > Regardless, I don't see anything wrong with the allocation setup -
> > > > it's telling the allocation code exactly what it needs for
> > > > subsequent BMBT block allocations to succeed (i.e. args->minleft).
> > > 
> > > In the long term, I think the main point is that args->minleft doesn't
> > > have the exact meaning.  I don't know how many blocks should be counted
> > > by args->minleft or other ways.
> > 
> > args->minleft has an *exact* meaning - that the AG must have that
> > many blocks left available for potential btree record insertion
> > allocations after the initial extent is allocated. For inode fork
> > allocations, the BMBT blocks required is defined by
> > xfs_bmapi_minleft(). For inode chunk extent allocation and inobt
> > record insertion, it is defined by the pre-calculated
> > igeo->inobt_maxlevels variable.
> > 
> > IOWs, this "postalloc" concept is redundant - minleft already
> > provides the maximum number of single block allocations that need to
> > have space reserved in the AG for the initial extent allocation to
> > succeed. i.e.  the allocation setup is already taking into account
> > blocks needed for extra allocations within the AG, but that's not
> > being handled correctly by the AG allocation code.
> 
> I don't think it's the case as I described in the patch commit message,
> if we go over the words at the top, the main point is
>  
>  In the first allocation, minleft = 1, the current allocator assumes
>  it can allocate an extent with 27 blocks (the remaining blocks are
>  18276 per-AG reservation, 6 for AGFL reservation, 1 for inode extents
>  -to-btree for the following allocation).
> 
>  But here in order to finish this allocation with 27 blocks, it splits
>  cntbt so that it takes another unexpected block from AGFL, and
>  that wasn't accounted in minleft (or with any other fields) before.
> 
>  I don't think it can be directly described by minleft because
>  such extra bno/cntbt reservation needs more knowledge of bno/cntbt
>  internals (such as current bno/cnt btree levels), so I don't think
>  it should belong to BMBT allocation code at least.
> 
>  So here I introduced another variable to describe the total number
>  of post-allocations, I think it's just enough to resolve the inode
>  extents-to-btree bno/cntbt reservation issue.

extents-to-btree is the degenerate case of a btree split. It's
moving the in-inode extent block to a single btree root block - it's
the same case as having a multi-level BMBT and splitting a single
leaf block during an xfs_btree_insert() call. Both require a second
discrete allocation to be made in the same transaction from the same
AG.

But if that xfs_btree_insert() call triggers a multi-level btree
split, we've now got more than 1 "post allocation" allocation being
done - there's one allocation for every level that needs to have a
block split. To handle this, we'd need to set up this args.postalloc
variable with the number of allocations a btree split might require.

What I'm trying to tell you is that args->minleft is already
configured with exactly this number of blocks/post-allocations that
the btree split might require, and hence allow the allocation code
to select an AG with the right amount of space needed before it
starts.


> > On review, it is quite possible that args->minleft is not being
> > handled by the BMBT and inobt block allocation code correctly.
> > Shouldn't btree block allocation drop args->minleft by 1 for
> > each block that is allocated?
> 
> At least, in order to convert from inode extents-to-btree, we need
> another block for the following allocation, so minleft = 1 here.
> 
> 	if (ifp->if_format != XFS_DINODE_FMT_BTREE)
> 		return 1;

Yes, as I said above, that's the degenerate case where we only need
to allocate a root block and set the btree level to 1.

> So I guess what you meant is
> 	return be16_to_cpu(ifp->if_broot->bb_level) + 1; ?
> 
> I don't know why it has another 1 here,

It's a btree. What does a full height btree split do?

It adds a block to each existing level, and splits the root block
into two. Which means we need to increase the tree height by 1 and
allocate a new root block. IOWs, the number of allocations/blocks
needed by a full split is (current height + 1).

> yet even if we account an
> extra block here, I think it doesn't have some critical result
> since the worst case is that it just returns -ENOSPC in advance.
> 
> But in principle, most users use terabytes XFS, so I think such
> one extra block doesn't matter too much.  I will update this if
> such 1 is meaningless, but it doesn't actually contribute to the
> real shutdown issue.

I think you misunderstood what I was asking. Let's unroll the
extent allocation/BMBT record insert loop:

extent allocation
 args.minleft = bb_level + 1
 xfs_alloc_vextent(args)
bmbt record insert
  xfs_btree_insert()
    leaf split
      xfs_bmbt_alloc_block()
        args.minleft = ???
        xfs_alloc_vextent(args)
    level 1 node split
      xfs_bmbt_alloc_block()
        args.minleft = ???
        xfs_alloc_vextent(args)
    level 2 node split
      xfs_bmbt_alloc_block()
        args.minleft = ???
        xfs_alloc_vextent(args)
    ....
    root split
      xfs_bmbt_alloc_block()
        args.minleft = ???
        xfs_alloc_vextent(args)

A BMBT split results in a chain of individual allocations. What
should args.minleft be set to on each of these allocations, and
what context do we have to ensure it is set correctly? 
So the question I was asking was whether what we are doing with
args->minleft for each allocation in the chain is correct, and
whether they need modification if we have to take into account the
AGFL block refilling that may need to occur after each BMBT block
allocation?

Indeed, if we get the initial extent allocation reservation correct,
does minleft even matter for the rest of the allocations in the
chain?

Looking at xfs_bmbt_alloc_block(), it sets args.minleft = 0 if there
was a previous allocation in the transaction (i.e. args.fsbno !=
NULLFSBLOCK). It assumes that the original extent reservation set
args.minleft appropriately to reserve enough space for all
subsequent calls to xfs_bmbt_alloc_block() in this transaction to
succeed.

Hence, given the way it is implemented right now, all we need to do
is ensure that the initial allocation has all the space reservation
the entire operation may need and the rest is good, yes?

xfs_bmap_extents_to_btree() also sets args->minleft = 0, so as long
as the first allocation in the transaction has reserved enough
blocks in args->minleft it doesn't need any special help, either.

So, yes, you are right that avoiding ENOSPC when running multiple
allocations in a single transaction is all based on the initial
allocation ensuring there is enough space in the AG for all
subsequent allocations to succeed. But there's a lot more to it than
that....

> > > > The problem here is that the internal allocation code is failing to
> > > > handle the corner case where space is just about gone correctly.
> > > > 
> > > > As I pointed out previously - we have a huge amount of reserve space
> > > > available in the AG here, so why not use some of the reserve space
> > > > to get out of this temporary deficit corner case? We can argue that
> > > > it's not really a deficit, either, because moving free blocks to the
> > > > free list still accounts them as unused and free, so could still
> > > > make up part of the unused reservation....
> > > > 
> > > > i.e. is the problem here simply that we don't allow AGFL blocks to
> > > > be considered part of the reserved free space?
> > > 
> > > I don't know how to simply reuse per-AG reservation blocks for this,
> > 
> > I don't know either, which is *why I asked the question*. i.e. I'm
> > asking for you to investigate a potential alternative solution that
> > challenges a design assumption this code makes. i.e. AGBNO and AGCNT
> > btree blocks are considered free space because when we are at ENOSPC
> > they are empty.
> > 
> > However, with this ag reservation code, we can be at ENOSPC when
> > there are still tens of thousands of free extents, and hence the
> > AGBNO and AGCNT btree blocks are used space, not free space. The
> > AGFL accounting is based on AGFL blocks being considered free space,
> > which matches the AG btree blocks being considered free space, and
> > so maybe the root of the problem here is the assumption that AG
> > btree blocks and AGFL blocks are accounted as free space rather than
> > part of this new "reserved space"....
> 
> I have strong feeling that the current per-AG reservation code (or
> AGFL reservation as in xfs_alloc_min_freelist() ) doesn't work
> properly for multiple allocations in the same AG in order to make
> sure such multiple allocations all succeed.
> 
> Also, a wilder question is that I'm not sure why such multiple
> allocations in oneshot _cannot_ be handled with a defer ops as
> some new log intent, so that we don't need to care about minleft
> messy anymore.

We do use intents and deferred ops for BMBT freeing and reflink
based insertion, but those only log changes to individual records in
the btree. They do not record internal btree shape changes at all.
Yes, we could convert normal extent allocation to use these intents
as well, but that doesn't solve the problem of chained allocations
within a single AG.

IOWs, the chain of allocations for a BMBT split I mention above
still exists for record level intents. To handle the btree split
case as a chain of intents involves a whole new level of complexity
and overhead in the btree code, and likely introduces more problems
at ENOSPC than it solves...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
