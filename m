Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2741967A5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjAXWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjAXWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:37:04 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 23087658C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:36:32 -0800 (PST)
Received: (qmail 187252 invoked by uid 1000); 24 Jan 2023 17:35:33 -0500
Date:   Tue, 24 Jan 2023 17:35:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
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
Message-ID: <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
References: <Y88/5ib7zYl67mcE@rowland.harvard.edu>
 <20230124040611.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8+8fH52iqQABYs2@andrea>
 <20230124145423.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <8cc799ab-ffa1-47f7-6e1d-97488a210f14@huaweicloud.com>
 <20230124162253.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <3e5020c2-0dd3-68a6-9b98-5a7f57ed7733@huaweicloud.com>
 <20230124172647.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <2788294a-972e-acbc-84ce-25d2bb4d26d6@huaweicloud.com>
 <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124221524.GV2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:15:24PM -0800, Paul E. McKenney wrote:
> > Ah, looking at the model now. Indeed it's forbidden, because in order to say
> > that something is in co, there must not be a (resulting) cycle of co and
> > barriers. But you'd get that here.  In the axiomatic model, this corresponds
> > to saying Power's "prop | co" is acyclic. The same isn't true in LKMM. So
> > that's probably why.
> 
> Which means that the RCU and SRCU implementations need to make (admittedly
> small) guarantees that cannot be expressed in LKMM.  Which is in fact
> what I was remembering, so I feel better now.
> 
> Not sure about the rest of you, though.  ;-)

Can you be more explicit?  Exactly what guarantees does the kernel 
implementation make that can't be expressed in LKMM?

And are these anything the memory model needs to worry about?

Alan
