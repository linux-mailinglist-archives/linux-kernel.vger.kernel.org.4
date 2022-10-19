Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDF60503D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiJSTO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJSTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B776304;
        Wed, 19 Oct 2022 12:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F46FB81E62;
        Wed, 19 Oct 2022 19:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F30C433D6;
        Wed, 19 Oct 2022 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666206858;
        bh=ZnaNNe4+IYDPSjHEvFMiErBoP5l71S+0Eij3ayOtFl0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SDNsL1/j6RZ1QROiYf/v+ERgbVDQU/eheiZDuXxsJ75L9RWgZwyu8amGBysSIAj3O
         prvImTPP4afi7jtRxEFxTVCIM1lMNnobsgZsfB08JY+Yp2GfCwuxa9fPiWI6SQhSn+
         zmNbZrshfgZKdtISBLzxApm1sJVZtM+MXe/2CllCKTpfn7xlhBf4UaQUBCP3bROFx4
         5UhIfeU4S7NHiIrHbjNZHOfjFseh4VyKm7BGJtEFRIO8FjxErnmhCEeSK3alWog8/H
         ISf6TQqcWl5ZJ3YnGwO4O0lT6xISZkYQ4WlOkASwBIWg8G9nbXoyNQ3DjLQiimo7jc
         SL+TtW69P10lA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E90E5C06B4; Wed, 19 Oct 2022 12:14:18 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:14:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221019191418.GF5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
 <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
 <87ilkh0y52.fsf@jogness.linutronix.de>
 <20221018185936.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018215721.GA1716567@paulmck-ThinkPad-P17-Gen-1>
 <87pmeoawwe.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmeoawwe.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:19:53PM +0206, John Ogness wrote:
> On 2022-10-18, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > And the v6.1-rc1 stack is now at srcunmisafe.2022.10.18b.
> 
> Thanks!
> 
> I guess the kernel test robot will catch this, but if you checkout
> commit 79c95dc428ad ("arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> Kconfig option") and build for x86_64, you will get:
> 
> x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_gp_start_if_needed':
> srcutree.c:(.text+0x133a): undefined reference to `__srcu_read_lock_nmisafe'
> x86_64-linux-gnu-ld: srcutree.c:(.text+0x1490): undefined reference to `__srcu_read_unlock_nmisafe'
> x86_64-linux-gnu-ld: kernel/rcu/srcutree.o: in function `srcu_barrier':
> srcutree.c:(.text+0x1b03): undefined reference to `__srcu_read_lock_nmisafe'
> x86_64-linux-gnu-ld: srcutree.c:(.text+0x1b38): undefined reference to `__srcu_read_unlock_nmisafe'
> 
> Note that this error is fixed with a later commit:
> 
> commit c2d158a284ab ("srcu: Debug NMI safety even on archs that don't
> require it").
> 
> This does not affect what I am working on, so feel free to take care of
> it whenever it fits your schedule.

Good catch, thank you!

It looks like the first two hunks in include/linux/srcu.h from that
later commit need to be in that earlier commit.

Frederic, does this make sense, or am I off in the weeds?

If so, my thought is to make this change in the name of bisectability,
then produce a new srcunmisafe branch.  The printk() series would
then need to rebase or remerge this new series.

John, would that work for you?

							Thanx, Paul
