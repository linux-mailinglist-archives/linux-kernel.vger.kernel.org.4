Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A26274E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiKNDYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKNDYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7378114D0A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668396190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YajMo4B0I3p8JOZ3Oj+xiOqIVqTDMArnK1/2A+Qqzfs=;
        b=R/7809C+wVbE/YB1Hivu80dCh4w8fzV3X2xuh33LfKfu3X5nokdhb5Xk/OtulC5nhrSi57
        7xNBkmW/9EhPErFnRtO5z8bsb5SkSwH8+4bwDhtCBsGXaAXhzflSVDbBWmxfoNWZ3/rBGj
        oIONb9nNkBD/PNoEsnLoXtFmPAJSd7M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-lF5Ce2LgMRKhS0Er1EhD3g-1; Sun, 13 Nov 2022 22:23:09 -0500
X-MC-Unique: lF5Ce2LgMRKhS0Er1EhD3g-1
Received: by mail-qk1-f197.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso10075112qkb.19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YajMo4B0I3p8JOZ3Oj+xiOqIVqTDMArnK1/2A+Qqzfs=;
        b=kPbZhaRmLSV6EPDK3gQeeHtporEGWOrMk+kwLPWCulL0kZKE0EpGHW8569vSzwFdtT
         6S6mTP/FWS+6o2s5CuaOvUwpOJS1MxnoTnV3NLkuMCoViyhufoRw5sZrhCJ1g2aONVXn
         Rze18cEqVE2UUpd+A9agQcKbiD1IxF93EfEqrQM9Zf/6QgqfRl8K0x0Fl/t4/QJIE5Eb
         9hzHzh9SI60YONRL+X+/lsiXgSX6/j4RHQuSQJ2Cq+rzrc3F9maqBgvaEBwky11xY78n
         NNCWTmHLf+tTJZZM7Nj7ai1FhywtFevjs7BQ+vGXPxvIMhWsn5+X0OGmGBnvrfQSf+zb
         x7pQ==
X-Gm-Message-State: ANoB5pmSvIttzfdElD/UsI1+Lb5tZ+ccOHZN+fXhA0aMPL9/s8VFWa4c
        4xcmnooJfoU8T4Fl53Vzhk31PkbKmDHbdYCdgsFJk3c05g8ssQplFvqyw7pSHzzHFin2CISBJQm
        0LX5qfH422hSr17C1O5eeathT
X-Received: by 2002:a37:b1c5:0:b0:6fa:3cfd:8cf0 with SMTP id a188-20020a37b1c5000000b006fa3cfd8cf0mr9688635qkf.248.1668396186189;
        Sun, 13 Nov 2022 19:23:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5577CZ1W67XXbEwNYl/HvpOSb6xyF+Vg+D1MDnJm68hNHMPpaxqCcLE9tx6AUG1wHWS6s/Tw==
X-Received: by 2002:a37:b1c5:0:b0:6fa:3cfd:8cf0 with SMTP id a188-20020a37b1c5000000b006fa3cfd8cf0mr9688622qkf.248.1668396185850;
        Sun, 13 Nov 2022 19:23:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fu33-20020a05622a5da100b003a5172220dbsm5098211qtb.8.2022.11.13.19.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:23:05 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:22:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: account extra freespace btree splits for multiple
 allocations
Message-ID: <20221114032259.vdpdd44ybvl4hwzr@zlang-mailbox>
References: <20221109034802.40322-1-hsiangkao@linux.alibaba.com>
 <20221111060450.nojzqvcalwowov4l@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111060450.nojzqvcalwowov4l@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:04:50PM +0800, Zorro Lang wrote:
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
> 
> FYI, I've tested this bug, with the original reproducer I hit this bug. Although
> the reproducer is a big long time (3days) stress test, and can't reproduce
> this bug 100%, but generally with about 1/5 chance.
> 
> So I submitted 6 testing jobs, all test passed today, didn't this bug, so I
> think this patch works for me. (This testing can't replace regression test)
> 
> Anway, for more convince, I just submitted more 6 testing jobs again. They'll
> be done on next Monday (11-14). I'll feedback if there're any problems, or
> nothing wrong.

FYI, 6 more testing jobs test passed today.

> 
> Thanks,
> Zorro
> 
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
> > -- 
> > 2.24.4
> > 

