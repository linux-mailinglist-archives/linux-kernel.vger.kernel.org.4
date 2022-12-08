Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD10647814
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLHVho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLHVhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:37:41 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1890E10B6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:37:36 -0800 (PST)
Received: (qmail 744325 invoked by uid 1000); 8 Dec 2022 16:37:35 -0500
Date:   Thu, 8 Dec 2022 16:37:35 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Message-ID: <Y5JZH0GGiqA53Ozf@rowland.harvard.edu>
References: <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <43c7ea9ebdd14497b85633950b014240@huawei.com>
 <Y4xbQmnDEbFTvgQ/@Boquns-Mac-mini.local>
 <d86295788ad14a02874ab030ddb8a6f8@huawei.com>
 <Y44ZxWYQkMN60a1E@rowland.harvard.edu>
 <Y4+qQrhxrcqOUolZ@boqun-archlinux>
 <Y4+rn0lsrdCB3pMj@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+rn0lsrdCB3pMj@boqun-archlinux>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 12:52:47PM -0800, Boqun Feng wrote:
> On Tue, Dec 06, 2022 at 12:46:58PM -0800, Boqun Feng wrote:
> > Thank you, Alan! One question though, can a "smart" compiler optimize
> > out the case below, with the same logic?
> > 
> > 	void P0(int *x, int *y, int *a)
> > 	{
> > 		int r1, r2;
> > 
> > 		r1 = READ_ONCE(*x); // A
> > 
> > 		*a = r1 & 0xffff; // B
> > 
> > 		r2 = *a & 0xffff0000; // C
> > 
> > 		WRITE_ONCE(*y, r2); // D
> > 
> > 	}
> > 
> > I think we have A ->data B ->rfi C ->data D, however a "smart" compiler
> > can figure out that r2 is actually zero, right? And the code get
> > optimized to:
> > 
> > 	r1 = READ_ONCE(*x);
> > 	r2 = 0;
> > 	WRITE_ONCE(*y, r2);
> > 	*a = r1 & 0xffff;
> > 
> > and break the dependency.

Yes, that could happen.

> > I know that our memory model is actually unware of the differences of
> > syntatics dependencies vs semantics syntatics, so one may argue that in
> > the (data; rfi) example above the compiler optimization is outside the
> > scope of LKMM, but won't the same reasoning apply to the (addr; rfi)
> > example from you? The WRITE_ONCE() _syntatically_ depends on load of
> > a[r1], therefore even a "smart" compiler can figure out the value, LKMM
> 
> I guess it should be that r2 (i.e. the load of a[r1]) _syntatically_
> depends on the value of r1.

Yes.  But more to the point, the LKMM already has this problem for 
ordinary dependencies.  If you do:

	r1 = READ_ONCE(*x);
	r2 = r1 & 0x0000ffff;
	r3 = r2 & 0xffff0000;
	WRITE_ONCE(*y, r3);

then the LKMM will think there is a dependency (because there is a 
_syntactic_ dependency), but the compiler is likely to realize that 
there isn't a _semantic_ dependency and will destroy the ordering.

We warn people about this possibility, and the same warning applies to 
dependencies carried by plain accesses.  So I don't think this is a 
reason to object to Jonas's carries-dep relation.

Alan
