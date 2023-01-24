Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD4678E24
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjAXCSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAXCSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:18:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 31033C66A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:18:14 -0800 (PST)
Received: (qmail 148042 invoked by uid 1000); 23 Jan 2023 21:18:14 -0500
Date:   Mon, 23 Jan 2023 21:18:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <Y88/5ib7zYl67mcE@rowland.harvard.edu>
References: <Y8hclxuhpGm+krkz@rowland.harvard.edu>
 <20230119000214.GM2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8q6v3BZ8dlyoTxo@rowland.harvard.edu>
 <20230120175804.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8rff3HJ2o9wUyGT@rowland.harvard.edu>
 <20230120192032.GR2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8r7SBdfuZX/y1cd@rowland.harvard.edu>
 <20230120212037.GW2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y82dWEW4RwclDTGM@rowland.harvard.edu>
 <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123201659.GA3754540@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:16:59PM -0800, Paul E. McKenney wrote:
> One twist is that the design of both SRCU and RCU are stronger than LKMM
> requires, as illustrated by the litmus test at the end of this email.
> 
> I believe that your proof outline above also covers this case, but I
> figure that I should ask.

This test is full of typos, and I guess that one of them seriously 
affects the meaning, because as far as I can tell the corrected test is 
allowed.

> C C-srcu-observed-2
> 
> (*
>  * Result: Sometimes
>  *
>  * But please note that the Linux-kernel SRCU implementation is designed
>  * to provide Never.
>  *)
> 
> {}
> 
> P0(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 	int r2;

r2 is never used.

> 
> 	r1 = srcu_read_lock(s);
> 	WRITE_ONCE(*y, 1);
> 	WRITE_ONCE(*x, 1);
> 	srcu_read_unlock(s, r3);

There is no r3; this should be r1.

> }
> 
> P1(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;
> 	int r2;

r2 is never used.

> 
> 	r1 = READ_ONCE(*y);
> 	synchronize_srcu(s);
> 	WRITE_ONCE(*z, 1);
> }
> 
> P2(int *x, int *y, int *z, struct srcu_struct *s)
> {
> 	int r1;

r1 is never used; it should be r2.

> 
> 	WRITE_ONCE(*z, 2);
> 	smp_mb();
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r1=1 /\ 1:r2=0 /\ z=1)

1:r2 is never used.  Apparently this should 2:r2.

Given those changes, the test can run as follows: P2 runs to completion, 
writing z=2 and reading x=0.  Then P0 runs to completion, writing y=1 
and x=1.  Then P1 runs to completion, reading y=1 and overwriting z=1.

Alan
