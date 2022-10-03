Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E05F33B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJCQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJCQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCED252AE;
        Mon,  3 Oct 2022 09:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBA5DB80E64;
        Mon,  3 Oct 2022 16:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B960C433D6;
        Mon,  3 Oct 2022 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664815130;
        bh=bVtcCxKvxNTlQPiCRxKMcyMjy/SmMdCn+3d9pLBCBr0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y2an+hGza8JQVlOR4W4xLN0+LU9Zofrtxrx9jqxHnBmyNIy0IS0bGZGX+kEFyaiDy
         T5jJrEeKuL+zlTcjtqqHBF+4s6BNDUGVBSBO3jc/gVzK/za3b2jfl+mdPdscXY1471
         n4+MopgsfUX62fffYhHnw3kl+g/f6ND09NErX7/q+Fe7uL81s4H37tCpprO1uT75P/
         pXYYUNCDtwidF5hkT6BRdV3P8qLbYuHJ37j8liRdA4YcyA78k6iyl6luBnR2YitXtG
         c6RAfIr3BulO/AtRdeSvs13L4IdaGzgBayp7YWchWuFVDS31A2tCU5YZJVD9hwiD0n
         32s3w0R8KpqCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 310175C0B03; Mon,  3 Oct 2022 09:38:50 -0700 (PDT)
Date:   Mon, 3 Oct 2022 09:38:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        john.ogness@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221003163850.GB4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20221003141141.GB306466@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003141141.GB306466@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 04:11:41PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 29, 2022 at 11:07:14AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This RFC series provides the second version of an NMI-safe SRCU reader API
> > in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> > A given srcu_struct structure must use either the traditional
> > srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
> > Mixing and matching is not permitted.  So much so that kernels built
> > with CONFIG_PROVE_RCU=y will complain if you try it.
> > 
> > The reason for this restriction is that I have yet to find a use case
> > that is not a accident waiting to happen.  And if free intermixing
> > were permitted, it is pretty much a given that someone somewhere will
> > get confused and use srcu_read_lock_nmisafe() within NMI handlers and
> > srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
> > safety.
> > 
> > I do not expect to push this into the v6.1 merge window.  However, if
> > the printk() series that needs it goes in, then I will push it as a fix
> > for the resulting regression.
> > 
> > The series is as follows:
> > 
> > 1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.
> > 
> > 2.	Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> > 
> > 3.	Check for consistent per-CPU per-srcu_struct NMI safety.
> > 
> > 4.	Check for consistent global per-srcu_struct NMI safety.
> > 
> > 5.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> > 
> > 6.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> > 
> > 7.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> > 
> > 8.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> > 
> > Changes since v1 RFC:
> > 
> > 1.	Added enabling patches for arm64, loongarch, s390, and x86.
> > 	These have what appear to me to be NMI-safe this_cpu_inc()
> > 	implementations.
> > 
> > 2.	Fix a build error on !SMP kernels built without SRCU.
> > 
> > 3.	Fix a build error on !SMP kernels.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/arch/arm64/Kconfig       |    1 
> >  b/arch/loongarch/Kconfig   |    1 
> >  b/arch/s390/Kconfig        |    1 
> >  b/arch/x86/Kconfig         |    1 
> >  b/include/linux/srcu.h     |   39 +++++++++++++++++++++
> >  b/include/linux/srcutiny.h |   11 ++++++
> >  b/include/linux/srcutree.h |    4 +-
> >  b/kernel/rcu/Kconfig       |    3 +
> >  b/kernel/rcu/rcutorture.c  |   11 ++++--
> >  b/kernel/rcu/srcutree.c    |   24 ++++++-------
> >  include/linux/srcu.h       |    4 +-
> >  include/linux/srcutiny.h   |    4 +-
> >  include/linux/srcutree.h   |   12 +++++-
> >  kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
> >  14 files changed, 166 insertions(+), 32 deletions(-)
> 
> Except for patches 6/7/8, for which I may miss subtle things:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Applied, thank you!

The new -rcu branch is srcunmisafe.2022.10.03a.

							Thanx, Paul
