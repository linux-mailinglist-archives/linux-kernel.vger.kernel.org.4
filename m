Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5B05EFCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiI2SIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiI2SHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDE1BB6F6;
        Thu, 29 Sep 2022 11:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00ABDB8264D;
        Thu, 29 Sep 2022 18:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A156C43147;
        Thu, 29 Sep 2022 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474853;
        bh=mHU3BGDi2Cn8CMLUz7jhHsHdIi9mfBYwtnqDAVqotcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YaSKjYPOn+yz8mSVCMGYX2izTptjHX5/GeAd+POE96U3AFswPR89dUD4dUQMuVukB
         HHzOP8f6Eqmu7efu0J7mk7WawsMBmeSs/6mEi8YF81nlsHSUVtssRwyXbCWH2LUyns
         QcSVy8HEpFH8Ov/bdQ64uxt4vpmc3nS4Rega5HlBfdxQ/ePtCaaUEqZ5jaQ6HPDGQ7
         MUFxb2+WKrGexy3PRTKeolYJzAqON0A2sBaxE18yjfOqPmXmhGyDdDEhALJO4cMYgp
         bL+n/B0p5I2N2PcqkVfB8EMiqhRyaZH4Uft+avQyr38nlCgirtbV1cVrY4bdRf99HF
         y0CXX2x6a2ZFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B4B285C0ED4; Thu, 29 Sep 2022 11:07:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC v2 rcu 6/8] arch/arm64: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Date:   Thu, 29 Sep 2022 11:07:29 -0700
Message-Id: <20220929180731.2875722-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 architecture uses either an LL/SC loop (old systems) or an LSE
stadd instruction (new systems) to implement this_cpu_add(), both of which
are NMI safe.  This means that the old and more-efficient srcu_read_lock()
may be used in NMI context, without the need for srcu_read_lock_nmisafe().
Therefore, add the new Kconfig option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to
arch/arm64/Kconfig, which will cause NEED_SRCU_NMI_SAFE to be deselected,
thus preserving the current srcu_read_lock() behavior.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..664725a0b5dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -31,6 +31,7 @@ config ARM64
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
-- 
2.31.1.189.g2e36527f23

