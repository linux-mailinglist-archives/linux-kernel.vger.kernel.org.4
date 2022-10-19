Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783CB605386
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJSW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJSW6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB851CA5A8;
        Wed, 19 Oct 2022 15:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F7D1B82565;
        Wed, 19 Oct 2022 22:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D36C433C1;
        Wed, 19 Oct 2022 22:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220318;
        bh=Mh9ezMM/tIFWw3JVOz7+hv2YrMBmNextlCaUDvsDd+s=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RM34ePOKnAZAib6uT7KxGKcPYkZre+LnmRGG8uUpXsDFPv8jALMULh2vkE2zJLVRS
         vPMJYiP/PtdGnZRLYAjvf+lo1kXGHQFy6g4CRTTQpIM2sDWfFDBnWU28axjP2+7TwX
         MJBNgX6MQEYS2T8b7dRI/p44xBXEWb9rtV3zTaFdXh08QOMQvFkPNcMYu3pbf5gDrT
         +9cwe3OWRYrP5QzkXZihxHXaAQskfgLwmJDzcfl3qLC9MBrdUTlF48uuqDIo84E4IC
         8zC8/cM3Kne+orSmpCReMtKpJ2sV436rAROTJCbvohOU+oAsa5MlY1rlgttDpBetaZ
         IpLz76ZAfM88w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 151495C06B4; Wed, 19 Oct 2022 15:58:38 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:58:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/11] NMI-safe SRCU readers for v6.2
Message-ID: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides the second version of an NMI-safe SRCU reader API in
the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
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

The series is as follows:

1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.

2.	Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().

3.	Check for consistent per-CPU per-srcu_struct NMI safety.

4.	Check for consistent global per-srcu_struct NMI safety.

5.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

6.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

7.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

8.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.

9.	Warn when NMI-unsafe API is used in NMI, courtesy of Frederic
	Weisbecker.

10.	Explain the reason behind the read side critical section on GP
	start, courtesy of Frederic Weisbecker.

11.	Debug NMI safety even on archs that don't require it, courtesy
	of Frederic Weisbecker.

Changes since v2:

1.	Added ability for architectures having implicitly NMI-safe
	SRCU readers to warn about uses that cause trouble for other
	architectures.

Changes since v1:

1.	Added enabling patches for arm64, loongarch, s390, and x86.
	These have what appear to me to be NMI-safe this_cpu_inc()
	implementations.

2.	Fix a build error on !SMP kernels built without SRCU.

3.	Fix a build error on !SMP kernels.

						Thanx, Paul

------------------------------------------------------------------------

 b/arch/Kconfig             |    3 +
 b/arch/arm64/Kconfig       |    1 
 b/arch/loongarch/Kconfig   |    1 
 b/arch/s390/Kconfig        |    1 
 b/arch/x86/Kconfig         |    1 
 b/include/linux/srcu.h     |   39 ++++++++++++++
 b/include/linux/srcutiny.h |   11 ++++
 b/include/linux/srcutree.h |    4 -
 b/kernel/rcu/Kconfig       |    3 +
 b/kernel/rcu/rcutorture.c  |   11 +++-
 b/kernel/rcu/srcutree.c    |   24 ++++-----
 include/linux/srcu.h       |   48 +++++++++++++-----
 include/linux/srcutiny.h   |   16 ------
 include/linux/srcutree.h   |   19 +++----
 kernel/rcu/srcutree.c      |  118 +++++++++++++++++++++++++++++++++++----------
 15 files changed, 224 insertions(+), 76 deletions(-)
