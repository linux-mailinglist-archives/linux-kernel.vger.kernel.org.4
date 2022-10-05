Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E45F532B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiJELMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJELMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:12:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BA8452FC6;
        Wed,  5 Oct 2022 04:12:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81643106F;
        Wed,  5 Oct 2022 04:12:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 781673F73B;
        Wed,  5 Oct 2022 04:12:34 -0700 (PDT)
Date:   Wed, 5 Oct 2022 12:12:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v2 rcu 6/8] arch/arm64: Add
 ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Message-ID: <Yz1mneessxDSN8V7@FVFF77S0Q05N>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929180731.2875722-6-paulmck@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Sep 29, 2022 at 11:07:29AM -0700, Paul E. McKenney wrote:
> The arm64 architecture uses either an LL/SC loop (old systems) or an LSE
> stadd instruction (new systems) to implement this_cpu_add(), both of which
> are NMI safe.

IIUC "NMI safe" here just means atomic w.r.t. an NMI being taken and modfying
the same location the atomic was targetting (i.e. just like
ARCH_HAVE_NMI_SAFE_CMPXCHG, which arm64 selects today).

Assuming so:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Only this patch went to LAKML, so maybe an earlier patch made that clear, but
I didn't spot it.

As one minor nit, it would be nice to align the naming with
ARCH_HAVE_NMI_SAFE_CMPXCHG and select them next to each other in the Kconfig
file is possible, but the Ack stands regardless.

Thanks,
Mark.

> This means that the old and more-efficient srcu_read_lock()
> may be used in NMI context, without the need for srcu_read_lock_nmisafe().
> Therefore, add the new Kconfig option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to
> arch/arm64/Kconfig, which will cause NEED_SRCU_NMI_SAFE to be deselected,
> thus preserving the current srcu_read_lock() behavior.
> 
> Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
> 
> Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 571cc234d0b3..664725a0b5dd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -31,6 +31,7 @@ config ARM64
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> +	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>  	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>  	select ARCH_HAS_PTE_DEVMAP
>  	select ARCH_HAS_PTE_SPECIAL
> -- 
> 2.31.1.189.g2e36527f23
> 
