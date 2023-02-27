Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907166A4DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjB0WV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjB0WVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:21:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4A1C7DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3615DB80DBB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DABC433D2;
        Mon, 27 Feb 2023 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677536480;
        bh=b4/7pc/VLG61Cjb9qJmB8byPSO426YQA2k/rSS6hMi4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XkzhNjRjaXWPV9jbFW4eTBsdWy4qgfPdMsmiUyN4pasgxibWs0FvpIyVG2mh3d11/
         CMrsp6T9luhfDpB2cdx+ELRUs1FpfVAmhtsDmf1sfLyKD4Pi451o7bU5lAOq53Nk4E
         e9wqkabpwiwAM6SUCy/xl/zetLTZYnwQKkTJNBhDWaz9oc/UD5ESqIcHtkiHdV1OOl
         bDvhnyBp7OU3nKMSlTHoDX2ieVtgb8BcMNdOXh25PnZqU/BvHLGuckAosMv5X6ynLj
         A4hyoI22gTfejD6cJbqt0jLSxM2EO3vC+IpfD/wRnoLrImLvzYzr4A42o0Fbm7wLdX
         WcFoL5v+DhrQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AB6F5C0267; Mon, 27 Feb 2023 14:21:20 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:21:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
Message-ID: <20230227222120.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu>
 <Y/0HEESX2wDWtPS1@andrea>
 <bf2881fb-039b-06ab-68f9-806b29a84188@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2881fb-039b-06ab-68f9-806b29a84188@huaweicloud.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 09:13:01PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 2/27/2023 8:40 PM, Andrea Parri wrote:
> > > The LKMM doesn't believe that a control or data dependency orders a
> > > plain write after a marked read.  Hence in this test it thinks that P1's
> > > store to u0 can happen before the load of x1.  I don't remember why we
> > > did it this way -- probably we just wanted to minimize the restrictions
> > > on when plain accesses can execute.  (I do remember the reason for
> > > making address dependencies induce order; it was so RCU would work.)
> > > 
> > > The patch below will change what the LKMM believes.  It eliminates the
> > > positive outcome of the litmus test and the data race.  Should it be
> > > adopted into the memory model?
> > (Unpopular opinion I know,) it should drop dependencies ordering, not
> > add/promote it.
> > 
> >    Andrea
> 
> Maybe not as unpopular as you think... :)
> But either way IMHO it should be consistent; either take all the
> dependencies that are true and add them, or drop them all.
> In the latter case, RCU should change to an acquire barrier. (also, one
> would have to deal with OOTA in some yet different way).
> 
> Generally my position is that unless there's a real-world benchmark with
> proven performance benefits of relying on dependency ordering, one should
> use an acquire barrier. I haven't yet met such a case, but maybe one of you
> has...

https://www.msully.net/thesis/thesis.pdf page 128 (PDF page 141).

Though this is admittedly for ARMv7 and PowerPC.

							Thanx, Paul
