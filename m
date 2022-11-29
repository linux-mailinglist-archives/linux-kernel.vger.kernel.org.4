Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE88763B89C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiK2DM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiK2DMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:12:54 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA8637A;
        Mon, 28 Nov 2022 19:12:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VVym171_1669691567;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VVym171_1669691567)
          by smtp.aliyun-inc.com;
          Tue, 29 Nov 2022 11:12:49 +0800
Date:   Tue, 29 Nov 2022 11:12:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <Y4V4rlPZ/p6dgISy@B-P7TQMD6M-0146.local>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Zirong Lang <zlang@redhat.com>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
 <Y27e2U155YvH9et4@debian>
 <20221112214545.GQ3600936@dread.disaster.area>
 <Y3NGghqFDEoMPojt@B-P7TQMD6M-0146.local>
 <20221116025106.GB3600936@dread.disaster.area>
 <Y3qrEIy3DgGyhjli@debian>
 <20221122011757.GP3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122011757.GP3600936@dread.disaster.area>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Sorry for some delay again (I was applying some workaround to our
production to mitigate this and some other stuffs around there.)

On Tue, Nov 22, 2022 at 12:17:57PM +1100, Dave Chinner wrote:
> On Mon, Nov 21, 2022 at 06:32:48AM +0800, Gao Xiang wrote:
> > On Wed, Nov 16, 2022 at 01:51:06PM +1100, Dave Chinner wrote:
> > > On Tue, Nov 15, 2022 at 03:57:54PM +0800, Gao Xiang wrote:
> > > > On Sun, Nov 13, 2022 at 08:45:45AM +1100, Dave Chinner wrote:
> > > ..... because the assumption is that AGFL blocks come from free
> > > space and so when we are at ENOSPC bno/cnt btrees *do no require
> > > splits* so will not consume extra space. Hence allocation at ENOSPC
> > > doesn't need to take into account AGFL block usage because the AGFL
> > > will not be consumed.
> > 
> > I noticed another thing.  I think the reason why the first allocation
> > in this case caused a cntbt split is that Zorro's workload set
> > sunit/swidth.  Therefore, due to align requirement, I assume it
> > called xfs_alloc_fix_len() to fix up agbno and len.
> > 
> > Actually I found our workload has the similar sunit/swidth setup and
> > I am thinking about this these days.  One thing is that why we need
> > freespace btree splits when consuming free blocks.
> 
> stripe alignment does not affect AGFL behaviour, not free space
> btree allocation requirements. stripe alignment only affects the
> initial user data allocations from xfs_bmap_btalloc() where the
> stripe alignment variables (e.g. min align, align slop, etc). None
> of these parameters are set for AGFL or btree block allocations, so
> they ignore all alignment constraints.
> 
> > Another thing is that considering we're near ENOSPC, and bno/cnt
> > btrees has only a few records.  If we allocates without alignment,
> > I also think bno/cnt btrees do no require splits so it will not
> > consume extra space since the overall extents only decrease.
> > 
> > Yet how about allocating with alignment? It seems that it can add
> > another free extent in order to fulfill the alignment.  I'm not sure
> > if it can cause some corner cases here.
> 
> Alignment never requires an extra allocation - it reserves extra
> space to select a larger freespace that an aligned extent can be
> carved out of. If an aligned extent cannot be found, we fall back to
> unaligned allocation....

As we talked on IRC, I skip this part now.  In brief, I think stripe
allocation can make it reproduce more frequently.

> 
> > > Similarly, if we have enough free space records to split a free
> > > space btree block, we have enough free space to refill the AGFL
> > > multiple times and we don't have to reserve space for them.
> > > 
> > > IOWs, the allocation code has, historically, never had to care about
> > > AGFL refilling when the AG is near ENOSPC as nothing will consume
> > > AGFL blocks when the AG is near empty.
> > > 
> > > This is the design assumption that AG reservations broke. This is
> > > why I'm asking you to look into taking blocks that are supposedly
> > > reserved for the AGFL, because as reserved space is used, the
> > > bno/cnt btrees will shrink and return those blocks to free space and
> > > hence they are still available for reserved allocations to use as
> > > the real physical ENOSPC condition approaches.
> > 
> > Yeah, intuitively I also imagine like what you said.  However, does it
> > have strictly monotonicity, especially with stripe alignment setup?
> > 
> > > 
> > > The more I look at this, the more I think overall answer to this
> > > problem is to allow AGFL refilling to ignore AG reserves rather than
> > > causing ENOSPC....
> > 
> > Could you give more details how to fit this case?  Also we have a
> > short talk last Wednesday (sorry that I had an urgent thing at that
> > time).  You mentioned "the simple solution is something like
> > min(ag reservation blocks, needed AGFL blocks) instead of accounting
> > them separately", could you give an example for this case as well?
> 
> Go read the head comment in xfs_ag_resv.c. Specifically, this bit:
> 
>  * Reserved blocks can be managed by passing one of the enum xfs_ag_resv_type
>  * values via struct xfs_alloc_arg or directly to the xfs_free_extent
>  * function.  It might seem a little funny to maintain a reservoir of blocks
>  * to feed another reservoir, but the AGFL only holds enough blocks to get
>  * through the next transaction.  The per-AG reservation is to ensure (we
>  * hope) that each AG never runs out of blocks.  Each data structure wanting
>  * to use the reservation system should update ask/used in xfs_ag_resv_init.
> 
> This was originally written with RMAPBT updates in mind (rmap btree
> blocks come from the AGFL, just like the bno/cnt btrees). SInce this
> was written, AGFL blocks have been carved out of this reservation by
> XFS_AG_RESV_AGFL, and so this reservation space no longer reserves
> or accounts for refilling the AGFL for non-RMAPBT operations.
> 
> My point is, however, that the reservation space was intended for
> ensuring the AGFL could be refilled without triggering ENOSPC in
> certain circumstances. And here we are with a situation where
> refilling the AGFL triggers ENOSPC because of the reservation
> space.
> 
> The "available" calculation in xfs_alloc_space_available() does:
> 
> 	available = (int)(pag->pagf_freeblks + agflcount -
>                           reservation - min_free - args->minleft);
> 
> 
> Which is effectively:
> 
> 	available =	(free space) -
> 			(reserved space) -
> 			(minimum AG requires to be left free) -
> 			(minimum allocation requires to left free)
> 
> But what we have to consider is that three of these parameters have
> a component of "AGFL blocks" in them:
> 
> free space	= indexed free space + current AGFL blocks
> reserved space	= space reserved for future AGFL block allocation
> minimum AG free = AGFL blocks needed for this allocation
> 
> Looked at a different way (as a timeline):
> 
> free space	= Previously allocated AGFL blocks
> reserved space  = future allocation AGFL block pool
> minimum free	= present allocation AGFL needs
> 
> So the problem you are seeing is that on the second allocation of a
> chain, the AGFL blocks previously allocated by the initial
> allocation in the chain are not sufficient for present AGFL needs
> and we do not allow the present allocation to use space from the
> future AGFL block pool to fill the AGFL....

I agree with your word here.

> 
> Also, we need to keep in mind that the initial allocation uses
> args->resv = XFS_AG_RESV_NONE, so the reservation space returned for
> the initial allocation is the full metadata (finobt) + reserved
> (RMAPBT) reservation that is being made.
> 
> The second allocation in the chain (where minleft is zero) really
> needs to have a reserve pool for AGFL filling. But we don't have a
> reserve pool for general AGFL allocations anymore, and this looks
> like we need it. i.e. instead of XFS_AG_RESV_AGFL just being used to
> avoid accounting AGFL block usage, perhaps it should actually manage
> a reserve pool for ensuring the AGFL can be refilled near ENOSPC
> (due to outstanding RMAP/FINOBT reservations) in a single
> transaction allocation chain....
> 
> i.e. so long as the pool has more blocks in it than the current
> allocation requires to refill the AGFL, the allocation can
> proceed...

Ok, let me think out a way to use ag_resv framework to resolve this
issue now.

Thanks,
Gao Xiang

