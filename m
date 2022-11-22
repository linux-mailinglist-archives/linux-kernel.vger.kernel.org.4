Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4040633213
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiKVBSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiKVBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:18:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4083D12628
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:18:02 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mv18so4278820pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXUXu09vEJkgXZ40nAvWtY2oQA1N7U9i3sjU0PlpdeY=;
        b=fM/cEtkodNsQgJNohvYj06QMR98UhWW8IJspTB9KI9U/J2hY6OZr9R9qlkbarUMurR
         yBaYqpo9N8hA1mioF0/Hvr+W3LCG36dK6Ke8RmrqRpE8p2kEpuibhUF7bLL8KilfTLu9
         9UZeSOPgFupVbnOb1GEO0/Rmj7W2HE95wdpVEJN1bpy/pZ1HKSpzwvZa6Ni7kTDieuPO
         nrJuHuxJDhfwm8y3NxeL56y/287zAbGunRmgq4OnrhumTEnmKZMELMHrq27shmCzgm63
         GdXKxv+nQJufnrhgSS2M8ftMjO4KqK46ghgH9dDray2RS1ZUeJP2cE0rhmMDAu91up1f
         rFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXUXu09vEJkgXZ40nAvWtY2oQA1N7U9i3sjU0PlpdeY=;
        b=DJWhOuYlYBeIa/WvaGRd2WT/4i9dwYxqFgZBHFzvsWM/Xj3Rd54qbMGPU4n3V0vnfF
         F+P4q1/Ks42bEI6EVCWx1sSDc9NEccWZMbX95sEQERr5BCtH8IBua8pntG28JgC08hUN
         BmqPnPRllTMRds6hit4JxdWyl1HfQ9IkUM8CcIlrAUXvbZu3MkedLGj8dByxxlakWCmo
         vORaZWUwNXbXozZ/DMleDb3hoR6GIaJZzDgGyc/Zzi4L9KZeOMH2absVG/6Ghjhe3k8y
         JVsoQCRka/4RHTocizYCOoUo+X1s1sTtTKwFMmCtUrCTAn9DjhLAgs4ooOBALuFUr5au
         1+pQ==
X-Gm-Message-State: ANoB5plRGk98unIEcwE1xHb5crXWPJBO9AtOYOhE/xp+yg72b52Ybyxs
        FtTcHIROl9hEVUL9vnjxOd2ZrEnIXIi8/g==
X-Google-Smtp-Source: AA0mqf5jQ/bpAwlyjRRRfq2D7YvHXsGjbJWDS74GWhTup68Ad6MyukMAcNHmVE0xkF/vnt9GOwL6vQ==
X-Received: by 2002:a17:90a:7c43:b0:213:ecb5:c4fe with SMTP id e3-20020a17090a7c4300b00213ecb5c4femr22983659pjl.179.1669079881617;
        Mon, 21 Nov 2022 17:18:01 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b00189299218e2sm2141869pla.182.2022.11.21.17.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:18:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxHvB-00H573-W0; Tue, 22 Nov 2022 12:17:58 +1100
Date:   Tue, 22 Nov 2022 12:17:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zirong Lang <zlang@redhat.com>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <20221122011757.GP3600936@dread.disaster.area>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111203905.GN3600936@dread.disaster.area>
 <Y27e2U155YvH9et4@debian>
 <20221112214545.GQ3600936@dread.disaster.area>
 <Y3NGghqFDEoMPojt@B-P7TQMD6M-0146.local>
 <20221116025106.GB3600936@dread.disaster.area>
 <Y3qrEIy3DgGyhjli@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3qrEIy3DgGyhjli@debian>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:32:48AM +0800, Gao Xiang wrote:
> On Wed, Nov 16, 2022 at 01:51:06PM +1100, Dave Chinner wrote:
> > On Tue, Nov 15, 2022 at 03:57:54PM +0800, Gao Xiang wrote:
> > > On Sun, Nov 13, 2022 at 08:45:45AM +1100, Dave Chinner wrote:
> > ..... because the assumption is that AGFL blocks come from free
> > space and so when we are at ENOSPC bno/cnt btrees *do no require
> > splits* so will not consume extra space. Hence allocation at ENOSPC
> > doesn't need to take into account AGFL block usage because the AGFL
> > will not be consumed.
> 
> I noticed another thing.  I think the reason why the first allocation
> in this case caused a cntbt split is that Zorro's workload set
> sunit/swidth.  Therefore, due to align requirement, I assume it
> called xfs_alloc_fix_len() to fix up agbno and len.
> 
> Actually I found our workload has the similar sunit/swidth setup and
> I am thinking about this these days.  One thing is that why we need
> freespace btree splits when consuming free blocks.

stripe alignment does not affect AGFL behaviour, not free space
btree allocation requirements. stripe alignment only affects the
initial user data allocations from xfs_bmap_btalloc() where the
stripe alignment variables (e.g. min align, align slop, etc). None
of these parameters are set for AGFL or btree block allocations, so
they ignore all alignment constraints.

> Another thing is that considering we're near ENOSPC, and bno/cnt
> btrees has only a few records.  If we allocates without alignment,
> I also think bno/cnt btrees do no require splits so it will not
> consume extra space since the overall extents only decrease.
> 
> Yet how about allocating with alignment? It seems that it can add
> another free extent in order to fulfill the alignment.  I'm not sure
> if it can cause some corner cases here.

Alignment never requires an extra allocation - it reserves extra
space to select a larger freespace that an aligned extent can be
carved out of. If an aligned extent cannot be found, we fall back to
unaligned allocation....

> > Similarly, if we have enough free space records to split a free
> > space btree block, we have enough free space to refill the AGFL
> > multiple times and we don't have to reserve space for them.
> > 
> > IOWs, the allocation code has, historically, never had to care about
> > AGFL refilling when the AG is near ENOSPC as nothing will consume
> > AGFL blocks when the AG is near empty.
> > 
> > This is the design assumption that AG reservations broke. This is
> > why I'm asking you to look into taking blocks that are supposedly
> > reserved for the AGFL, because as reserved space is used, the
> > bno/cnt btrees will shrink and return those blocks to free space and
> > hence they are still available for reserved allocations to use as
> > the real physical ENOSPC condition approaches.
> 
> Yeah, intuitively I also imagine like what you said.  However, does it
> have strictly monotonicity, especially with stripe alignment setup?
> 
> > 
> > The more I look at this, the more I think overall answer to this
> > problem is to allow AGFL refilling to ignore AG reserves rather than
> > causing ENOSPC....
> 
> Could you give more details how to fit this case?  Also we have a
> short talk last Wednesday (sorry that I had an urgent thing at that
> time).  You mentioned "the simple solution is something like
> min(ag reservation blocks, needed AGFL blocks) instead of accounting
> them separately", could you give an example for this case as well?

Go read the head comment in xfs_ag_resv.c. Specifically, this bit:

 * Reserved blocks can be managed by passing one of the enum xfs_ag_resv_type
 * values via struct xfs_alloc_arg or directly to the xfs_free_extent
 * function.  It might seem a little funny to maintain a reservoir of blocks
 * to feed another reservoir, but the AGFL only holds enough blocks to get
 * through the next transaction.  The per-AG reservation is to ensure (we
 * hope) that each AG never runs out of blocks.  Each data structure wanting
 * to use the reservation system should update ask/used in xfs_ag_resv_init.

This was originally written with RMAPBT updates in mind (rmap btree
blocks come from the AGFL, just like the bno/cnt btrees). SInce this
was written, AGFL blocks have been carved out of this reservation by
XFS_AG_RESV_AGFL, and so this reservation space no longer reserves
or accounts for refilling the AGFL for non-RMAPBT operations.

My point is, however, that the reservation space was intended for
ensuring the AGFL could be refilled without triggering ENOSPC in
certain circumstances. And here we are with a situation where
refilling the AGFL triggers ENOSPC because of the reservation
space.

The "available" calculation in xfs_alloc_space_available() does:

	available = (int)(pag->pagf_freeblks + agflcount -
                          reservation - min_free - args->minleft);


Which is effectively:

	available =	(free space) -
			(reserved space) -
			(minimum AG requires to be left free) -
			(minimum allocation requires to left free)

But what we have to consider is that three of these parameters have
a component of "AGFL blocks" in them:

free space	= indexed free space + current AGFL blocks
reserved space	= space reserved for future AGFL block allocation
minimum AG free = AGFL blocks needed for this allocation

Looked at a different way (as a timeline):

free space	= Previously allocated AGFL blocks
reserved space  = future allocation AGFL block pool
minimum free	= present allocation AGFL needs

So the problem you are seeing is that on the second allocation of a
chain, the AGFL blocks previously allocated by the initial
allocation in the chain are not sufficient for present AGFL needs
and we do not allow the present allocation to use space from the
future AGFL block pool to fill the AGFL....

Also, we need to keep in mind that the initial allocation uses
args->resv = XFS_AG_RESV_NONE, so the reservation space returned for
the initial allocation is the full metadata (finobt) + reserved
(RMAPBT) reservation that is being made.

The second allocation in the chain (where minleft is zero) really
needs to have a reserve pool for AGFL filling. But we don't have a
reserve pool for general AGFL allocations anymore, and this looks
like we need it. i.e. instead of XFS_AG_RESV_AGFL just being used to
avoid accounting AGFL block usage, perhaps it should actually manage
a reserve pool for ensuring the AGFL can be refilled near ENOSPC
(due to outstanding RMAP/FINOBT reservations) in a single
transaction allocation chain....

i.e. so long as the pool has more blocks in it than the current
allocation requires to refill the AGFL, the allocation can
proceed...

> > > I have strong feeling that the current per-AG reservation code (or
> > > AGFL reservation as in xfs_alloc_min_freelist() ) doesn't work
> > > properly for multiple allocations in the same AG in order to make
> > > sure such multiple allocations all succeed.
> > > 
> > > Also, a wilder question is that I'm not sure why such multiple
> > > allocations in oneshot _cannot_ be handled with a defer ops as
> > > some new log intent, so that we don't need to care about minleft
> > > messy anymore.
> > 
> > We do use intents and deferred ops for BMBT freeing and reflink
> > based insertion, but those only log changes to individual records in
> > the btree. They do not record internal btree shape changes at all.
> > Yes, we could convert normal extent allocation to use these intents
> > as well, but that doesn't solve the problem of chained allocations
> > within a single AG.
> > 
> > IOWs, the chain of allocations for a BMBT split I mention above
> > still exists for record level intents. To handle the btree split
> > case as a chain of intents involves a whole new level of complexity
> > and overhead in the btree code, and likely introduces more problems
> > at ENOSPC than it solves...
> 
> My question was that if we convert some allocations into dfops, does
> inode extents-to-btree needs to be strictly allocated in this AG
> anymore? ... Does that tend to be a long-term plan?

It's not in any of my plans.

The problem with moving to "any AG" allocation is that BMBT block
allocation is now subject to AGF locking rules and availability.
Say, for example, we have 4 AGs and we just allocated the initial
extent in AG 3 (the last AG) - we only have one safe choice of AG we
can allocate from due to AGF lock ordering.  If we don't ensure that
the BMBT blocks can be allocated from the same AG as the initial
allocation, we lose the ability to guarantee that the BMBT blocks
(and INOBT blocks) will be allocated without an ENOSPC condition
occurring.

If we get ENOSPC part way through a BMBT or INOBT update regardless
of whether we are rolling the transaction via deferops or just a
single transaction allocation change, we have to cancel the
currently running transaction. The transaction will be dirty at this
point, and cancelling a dirty transaciton shuts down the filesystem.
IOWs, failing to guarantee that the entire allocation chain will
succeed results in turning a simple ENOSPC error being reported to
userspace into a full filesystem shutdown....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
