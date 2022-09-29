Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC715EFCA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiI2SHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiI2SHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7191BA39E;
        Thu, 29 Sep 2022 11:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B536211B;
        Thu, 29 Sep 2022 18:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23480C433D6;
        Thu, 29 Sep 2022 18:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474835;
        bh=nvFDhSBR//2+iM+rstMUrS7ExKQETVpR8U6umvx4m+w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DicRSEOyC/GCD+r1zve9NSHtCxaia+HNtOK5/0XxA21xI/KG/9CsOdMo98TvYcqg2
         2skPBMjFb7Q/69J3ZjJICG+PnThc2s3iwvZSE8SFB+sFV/jxh3S6mmAXn021WlOsX1
         zAiSgKHbWf5lnYDG7BkuOYN4aOHKP/2x4jNCY3FdfE0OZKioAKrlQgXrEr5xZ+TiG7
         0StbuLPuCDrtMqga7BhDh9VwtC5+LnYHUOu2c72n5xsToPiE8gnpJ87kVSwGQyYrdn
         eo3cOYjVKARJwwdBD+kW52zfda+AyWkoCyIOTsUTxZ9h9Uzc2L6g6iwsBBRt5ohwTk
         9Y+ZiAPmmb/lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B10835C0691; Thu, 29 Sep 2022 11:07:14 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:07:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, john.ogness@linutronix.de,
        pmladek@suse.com
Subject: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This RFC series provides the second version of an NMI-safe SRCU reader API
in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
A given srcu_struct structure must use either the traditional
srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
Mixing and matching is not permitted.  So much so that kernels built
with CONFIG_PROVE_RCU=y will complain if you try it.

The reason for this restriction is that I have yet to find a use case
that is not a accident waiting to happen.  And if free intermixing
were permitted, it is pretty much a given that someone somewhere will
get confused and use srcu_read_lock_nmisafe() within NMI handlers and
srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
safety.

I do not expect to push this into the v6.1 merge window.  However, if
the printk() series that needs it goes in, then I will push it as a fix
for the resulting regression.

The series is as follows:

1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.

2.	Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().

3.	Check for consistent per-CPU per-srcu_struct NMI safety.

4.	Check for consistent global per-srcu_struct NMI safety.

5.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

6.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

7.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

8.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

Changes since v1 RFC:

1.	Added enabling patches for arm64, loongarch, s390, and x86.
	These have what appear to me to be NMI-safe this_cpu_inc()
	implementations.

2.	Fix a build error on !SMP kernels built without SRCU.

3.	Fix a build error on !SMP kernels.

						Thanx, Paul

------------------------------------------------------------------------

 b/arch/arm64/Kconfig       |    1 
 b/arch/loongarch/Kconfig   |    1 
 b/arch/s390/Kconfig        |    1 
 b/arch/x86/Kconfig         |    1 
 b/include/linux/srcu.h     |   39 +++++++++++++++++++++
 b/include/linux/srcutiny.h |   11 ++++++
 b/include/linux/srcutree.h |    4 +-
 b/kernel/rcu/Kconfig       |    3 +
 b/kernel/rcu/rcutorture.c  |   11 ++++--
 b/kernel/rcu/srcutree.c    |   24 ++++++-------
 include/linux/srcu.h       |    4 +-
 include/linux/srcutiny.h   |    4 +-
 include/linux/srcutree.h   |   12 +++++-
 kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
 14 files changed, 166 insertions(+), 32 deletions(-)
