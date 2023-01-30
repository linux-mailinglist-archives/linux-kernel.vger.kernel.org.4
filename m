Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE4C6803C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjA3CS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjA3CS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:18:26 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 84D5C166D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:18:25 -0800 (PST)
Received: (qmail 388213 invoked by uid 1000); 29 Jan 2023 21:18:24 -0500
Date:   Sun, 29 Jan 2023 21:18:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9co8OxyRehs8mob@rowland.harvard.edu>
References: <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9asu0CswZZ3yyls@andrea>
 <20230129184403.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9bomciHJ/6WGYM0@boqun-archlinux>
 <20230129230900.GK2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129230900.GK2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 03:09:00PM -0800, Paul E. McKenney wrote:
> On Sun, Jan 29, 2023 at 01:43:53PM -0800, Boqun Feng wrote:
> > in lock.cat: 
> > 
> > 	(* Allow up to one unmatched LKW per location; more must deadlock *)
> > 	let UNMATCHED-LKW = LKW \ domain(critical)
> > 	empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
> > 
> > we rule out deadlocks from the execution candidates we care about.
> 
> Thank you, Boqun!

Actually that's only part of it.  The other part is rather obscure:

(* Generate all co relations, including LKW events but not UL *)
let co0 = co0 | ([IW] ; loc ; [LKW]) |
	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])

Implicitly this says that any lock with no corresponding unlock must 
come last in the coherence order, which implies the unmatched-locks rule 
(since only one lock event can be last).  By itself, the unmatched-locks 
rule would not prevent P3 from executing before P1, provided P1 executes 
both its lock and unlock.

Alan

