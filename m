Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405D5C0038
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiIUOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71983BE4;
        Wed, 21 Sep 2022 07:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0728EB81A73;
        Wed, 21 Sep 2022 14:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD63C433D6;
        Wed, 21 Sep 2022 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663771580;
        bh=HATBQ0LpiaUjynQ0ce9PLBK2pIPKrRwoKlfyhQ1IDIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aBsYnLVQulIyoPutJzPjFQznHM+fLPIpXMFj+S7R2WMMSMlOVZ219qPjSxZLVU8c6
         pW3wlX/2kLhUwrkU5tOZwn+v7fGUhRFniwX9Yh3r2usIcvIM5eTq91i8kVEzK/lNEz
         Uc0kYtT+/ZY3jixCfgrSOtEDp2ttCXZ/4FimYlLb+p0n6E8EmMVHolG36bxWc/vJOv
         zK4kwiI/N4D4ku3sCtEepF7vDd1g5ZqWSP9RTW9Mx8XHh6GIcmyAVIVr2xIlK7Loby
         SC6prARP057q129K35EQVY9PUBDaoCCyZl5Wq6COEtunmCcMKupzQIB7Dt2bZN7tgJ
         J0tcYk26SeL/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D96B5C0849; Wed, 21 Sep 2022 07:46:20 -0700 (PDT)
Date:   Wed, 21 Sep 2022 07:46:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, tglx@linutronix.de, john.ogness@linutronix.de,
        pmladek@suse.com
Subject: [PATCH rcu 0/4] NMI-safe SRCU reader API
Message-ID: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This RFC series provides an NMI-safe SRCU reader API in the guise
of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().  A given
srcu_struct structure must use either the traditional srcu_read_lock()
and srcu_read_unlock() API or the new _nmisafe() API:  Mixing and matching
is not permitted.  So much so that kernels built with CONFIG_PROVE_RCU=y
will complain if you try it.

The reason for this restriction is that I have yet to find a use case
that is not a accident waiting to happen.  And if free intermixing
were permitted, it is pretty much a given that someone somewhere will
get confused and use srcu_read_lock_nmisafe() within NMI handlers and
srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
safety.

The series is as follows:

1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.

2.	Create and srcu_read_lock_nmisafe() and
	srcu_read_unlock_nmisafe().

3.	Check for consistent per-CPU per-srcu_struct NMI safety.

4.	Check for consistent global per-srcu_struct NMI safety.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h     |   37 ++++++++++++++++++++
 b/include/linux/srcutiny.h |   11 ++++++
 b/include/linux/srcutree.h |    4 +-
 b/kernel/rcu/Kconfig       |    3 +
 b/kernel/rcu/rcutorture.c  |   11 ++++--
 b/kernel/rcu/srcutree.c    |   24 ++++++-------
 include/linux/srcu.h       |    4 +-
 include/linux/srcutiny.h   |    4 +-
 include/linux/srcutree.h   |   12 +++++-
 kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
 10 files changed, 160 insertions(+), 32 deletions(-)
