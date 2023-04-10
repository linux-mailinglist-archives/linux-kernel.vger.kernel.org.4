Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9916DCA49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjDJR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:59:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809C173F;
        Mon, 10 Apr 2023 10:59:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FFB61B4C;
        Mon, 10 Apr 2023 17:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EECC433D2;
        Mon, 10 Apr 2023 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681149587;
        bh=Ku1zx3A7RxvGkqCRghJdFHiTNADgifG+1p6GZNJN9TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXqfhbyuJAJlTn4a+5upyTSWnNs4gVHnkDHtHysREJj8xrAA/m8DEAb44KmYM5Bwf
         kQZ35Azvj7of7dVUpbDIvXi7G+mx4095hyDIonQNJ0Otg3ONLuNynUNz97wdZHiqIk
         JhA0Z1852+Cuz7SFHyEfPltFm9CifAdF/nyyjv1dG9qaT+udmoVp2GAtXaA+5pZnpG
         1TsVslVxOcKHNHarsZk8CXgP2P6FJSX/zeI/YLZ1sYhCJCYXL4XkbdH+Ztk1fLKdhB
         YxtG3RWT+CL8i2BxFvluKuC8oJR4DP5ByVpjtIekuJnAS8cJaq5Tubkcih/gXdh1BC
         Zc5Xrw1jmQDKQ==
Date:   Mon, 10 Apr 2023 10:59:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, david@fromorbit.com
Subject: Re: [PATCH v2] xfs: Use for_each_perag_from() to iterate all
 available AGs
Message-ID: <20230410175946.GD360889@frogsfrogsfrogs>
References: <20230410160727.3748239-1-ryasuoka@redhat.com>
 <20230410163029.GC360889@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410163029.GC360889@frogsfrogsfrogs>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 09:30:29AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 11, 2023 at 01:07:27AM +0900, Ryosuke Yasuoka wrote:
> > xfs_filestream_pick_ag() iterates all the available AGs when no
> > unassociated AGs are available by using for_each_perag_wrap().
> > To iterate all the available AGs, just use for_each_perag_from() instead.
> > 
> > 
> > This patch cleans up a code where xfs_filestream_pick_ag() iterates 
> > all the available AGs when no unassociated AGs are available.
> > Current implementation is using a for_each_perag_wrap() macro which
> > iterates all AGs from start_agno through wrap_agno, wraps to
> > restart_agno, and then iterates again toward to (start_agno - 1).
> > In this case, xfs_filestream_pick_ag() start to iterate from 0 and
> > does't need to wrap. Although passing 0 as start_agno to
> > for_each_perag_wrap() 
> > is not problematic, we have already a for_each_perag() macro family
> > which just iterates all AGs from 0 and doesn't wrap. Hense, I propose
> > to use for_each_perag() family simply.
> > 
> > 
> > Changes since v1 [1]:
> > Use for_each_perag_from() instead of for_each_perag() to clarify
> > where we are iterating from.
> > 
> > [1]:
> > https://lore.kernel.org/linux-xfs/CAHpthZrvhqh8O1HO7U_jVnaq9R9Ur=Yq2eWzjWfNx3ryDbnGPA@mail.gmail.com/T/#m5704d0409bec1ce5273be0d3860e8ad60e9886fd
> > 
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  fs/xfs/xfs_filestream.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
> > index 22c13933c8f8..29acd9f7d422 100644
> > --- a/fs/xfs/xfs_filestream.c
> > +++ b/fs/xfs/xfs_filestream.c
> > @@ -151,7 +151,8 @@ xfs_filestream_pick_ag(

Oh, also -- I ran the whole codebase through smatch this morning.
Could you please set @err to zero in its declaration above?  If the
first for_each_perag_wrap never manages to get any perag structures
(currently impossible with the codebase) then err will be undefined and
probably nonzero.

  CHECK  fs/xfs/xfs_filestream.c
fs/xfs/xfs_filestream.c:120
xfs_filestream_pick_ag() error: uninitialized symbol 'err'.

--D

> >  		 * grab.
> >  		 */
> >  		if (!max_pag) {
> > -			for_each_perag_wrap(args->mp, 0, start_agno, args->pag)
> > +			start_agno = 0;
> > +			for_each_perag_from(args->mp, start_agno, args->pag)
> 
> IDGI.  for_each_perag initializes the loop variable and calls
> for_each_perag_from, so this is open-coding an existing macro.
> 
> If people are confused by the reuse of the function call parameter
> variable for the second loop, then either declare a new variable and let
> the compiler notice that we never use start_agno ever again and reuse
> a cpu register:
> 
> 	if (!max_pag) {
> 		xfs_agnumber_t	agno;
> 
> 		for_each_perag(args->mp, agno, args->pag)
> 			break;
> 		...
> 	}
> 
> Or reuse it explicitly and leave a comment:
> 
> 	if (!max_pag) {
> 		/*
> 		 * Use any AG that we can grab.  start_agno is no longer
> 		 * pertinent here so we can reuse the variable.
> 		 */
> 		for_each_perag(args->mp, start_agno, args->pag)
> 			break;
> 		...
> 	}
> 
> As a third alternative, I suppose you could encapsulate all of that into
> a dorky helper since I bet this isn't the first or the last time we're
> going to need something like this:
> 
> static inline struct xfs_perag *
> xfs_perag_get_first_avail(
> 	struct xfs_mount	*mp)
> {
> 	struct xfs_perag	*pag;
> 	xfs_agnumber_t		agno;
> 
> 	for_each_perag(mp, agno, pag)
> 		return pag;
> 
> 	ASSERT(0);
> 	return NULL;
> }
> 
> 	if (!max_pag) {
> 		args->pag = xfs_perag_get_first_avail(mp);
> 		...
> 	}
> 
> --D
> 
> >  				break;
> >  			atomic_inc(&args->pag->pagf_fstrms);
> >  			*longest = 0;
> > -- 
> > 2.39.2
> > 
