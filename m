Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EEB65DDEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjADU67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjADU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:58:57 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC39015FCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:58:53 -0800 (PST)
Received: (qmail 481624 invoked by uid 1000); 4 Jan 2023 15:58:52 -0500
Date:   Wed, 4 Jan 2023 15:58:52 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
Message-ID: <Y7XojCwWskMDEkRS@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <YzSAnclenTz7KQyt@rowland.harvard.edu>
 <f763bd5ff835458d8750b61da47fe316@huawei.com>
 <Y7R6SPHGS9U/T6IC@rowland.harvard.edu>
 <Y7WdKog5K/UV4JhZ@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WdKog5K/UV4JhZ@andrea>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:37:14PM +0100, Andrea Parri wrote:
> Sounds good to me too.  I'm trying to remember why we went for the LKW
> event to model smp_mb__after_unlock_lock() (as opposed to the LKR event,
> as suggested above/in po-unlock-lock-po).

I don't remember either, but with the LKR event it would be awkward to 
include the co part of (co | po) in the smp_mb__after_unlock_lock() 
definition.  You'd have to write something like ((co? ; rf) | po).

Aside from that, I don't think using LKR vs. LKW makes any difference.

>  Anyway, I currently see no 
> issue with the above (we know that LKW and LKR come paired), and I think
> it's good to merge the two notions of "unlock-lock pair" if possible.

Indeed.  It also would eliminate questions about why po-unlock-lock-po 
doesn't include the co term.

Alan
