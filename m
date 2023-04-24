Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232C6ED393
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDXRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjDXRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:35:26 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA74A729A;
        Mon, 24 Apr 2023 10:35:21 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 33OHT2fU012355;
        Mon, 24 Apr 2023 12:29:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 33OHT1xM012351;
        Mon, 24 Apr 2023 12:29:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 24 Apr 2023 12:29:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <20230424172900.GR19790@gate.crashing.org>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com> <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com> <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia> <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEagN1jJwg+rUzX4@boqun-archlinux>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:28:55AM -0700, Boqun Feng wrote:
> On Mon, Apr 24, 2023 at 10:13:51AM -0500, Segher Boessenkool wrote:
> > At what points can r13 change?  Only when some particular functions are
> > called?
> 
> r13 is the local paca:
> 
> 	register struct paca_struct *local_paca asm("r13");
> 
> , which is a pointer to percpu data.

Yes, it is a global register variable.

> So if a task schedule from one CPU to anotehr CPU, the value gets
> changed.

But the compiler does not see that something else changes local_paca (or
r13 some other way, via assembler code perhaps)?  Or is there a compiler
bug?

If the latter is true:

Can you make a reproducer and open a GCC PR?  <https://gcc.gnu.org/bugs/>
for how to get started doing that.  We need *exact* code that shows the
problem, together with a compiler command line.  So that we can
reproduce the problem.  That is step 0 in figuring out what is going on,
and then maybe fixing the problem :-)


Segher
