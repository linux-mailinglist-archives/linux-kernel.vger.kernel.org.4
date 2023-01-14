Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D264266ACAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjANQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjANQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:42:35 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EF17E8A54
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:42:33 -0800 (PST)
Received: (qmail 65591 invoked by uid 1000); 14 Jan 2023 11:42:32 -0500
Date:   Sat, 14 Jan 2023 11:42:32 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
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
Message-ID: <Y8LbeLflWLyivOz9@rowland.harvard.edu>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7>
 <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
 <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
 <e51c82a113484b6bb62354a49376f248@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51c82a113484b6bb62354a49376f248@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:55:34PM +0000, Jonas Oberhauser wrote:
> I think the whole rcu-order topic can be summarized as the 'one rule': "if a grace period happens before a rcsc-unlock, it must also happen before the rcsc -lock, and analogously if  rcsc-lock happens before a grace period, the rcsc-unlock also happens before the grace period" . 

There is more to it than that, as I mentioned earlier.  A complete
description can be found the explanation.txt document; it says:

	For any critical section C and any grace period G, at least
	one of the following statements must hold:

(1)	C ends before G does, and in addition, every store that
	propagates to C's CPU before the end of C must propagate to
	every CPU before G ends.

(2)	G starts before C does, and in addition, every store that
	propagates to G's CPU before the start of G must propagate
	to every CPU before C starts.

Alan
