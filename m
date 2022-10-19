Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2182B605390
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJSW7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiJSW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9821CC762;
        Wed, 19 Oct 2022 15:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E0CAB82625;
        Wed, 19 Oct 2022 22:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2CFC43158;
        Wed, 19 Oct 2022 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=q+Nh2vqtEVu5d5wW0RvHG/vkrFq6MOVxBevrDf1eSrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uN2Y657PIuHGDtEfThRsABBfDWmMY2nPkfEzviDg/z53XUHh45lsuuSSilpTZJSpz
         3NHYNYSreQ/zQyMhpaYFRd684T2E8r+C4cuCUGN8buVHW+bgLaKsVO5niw4BheQgfv
         oI5CKDeCHTWd2QrYmZc51KrYDFFP33b8kAwHeXne1pIAaKFfwlxGCJq7Uzo7gTSBRC
         lXUSAqY6VVWYmet5AZvswNsazH0XCr6W2/y4lIkcQ/XP8gY6a5SvaeLcOPBmnkRYcq
         /qOtDVcglyW/+UqM11sLKetAjdUp4xjzvBGSdoE0dPfB32hce9PNR70MKY34hCpHgA
         t5I0+l6rN+eLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B781A5C0AC5; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, loongarch@lists.linux.dev
Subject: [PATCH v3 rcu 07/11] arch/loongarch: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Date:   Wed, 19 Oct 2022 15:58:42 -0700
Message-Id: <20221019225846.2501109-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loongarch architecture uses the atomic read-modify-write amadd
instruction to implement this_cpu_add(), which is NMI safe.  This means
that the old and more-efficient srcu_read_lock() may be used in NMI
context, without the need for srcu_read_lock_nmisafe().  Therefore, add
the new Kconfig option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/x86/Kconfig,
which will cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving
the current srcu_read_lock() behavior.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <loongarch@lists.linux.dev>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 903096bd87f88..386adde2feffb 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
-- 
2.31.1.189.g2e36527f23

