Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532D5EFCAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiI2SHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiI2SHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB31BEA55;
        Thu, 29 Sep 2022 11:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ED36B82643;
        Thu, 29 Sep 2022 18:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14238C43470;
        Thu, 29 Sep 2022 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474853;
        bh=ngiy42v1jAmn2gtQrSvCJSPS7F9XoJDfjE9vMtSui1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5/DUILQkSvnoRthJ6xnXz11AbPVfjVdJTyWh9g3b0ai50uMKDknpbFt0TJB+sU65
         plKrwfDqhp6z2tXa4+TQg+RaWS5y/r4Hf+sUUDfNBasetOvBjY5EHflaU5CyfHog5U
         yPt8GHMoufErHzelv96yf4IxtmyVPvMw2Qpo4bhM2W4uGtOj0E8O9Wl+CK1SuZM+dg
         raX1qmHOCPiADfzoeg/Suj/CE6sEw7OdeonMnOtDz1In5Vr1psX8MjxcwNHi+f4XYt
         5W0bu0ji1GyR7cd6bJLm61LHazEuxuy9gu5zhHliDvQbDV4YtLFK+1/wB0wbzFGkCb
         dKPtZIqUVTuDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2D195C0DE5; Thu, 29 Sep 2022 11:07:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, x86@kernel.org
Subject: [PATCH RFC v2 rcu 5/8] arch/x86: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option
Date:   Thu, 29 Sep 2022 11:07:28 -0700
Message-Id: <20220929180731.2875722-5-paulmck@kernel.org>
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

The x86 architecture uses an add-to-memory instruction to implement
this_cpu_add(), which is NMI safe.  This means that the old and
more-efficient srcu_read_lock() may be used in NMI context, without
the need for srcu_read_lock_nmisafe().  Therefore, add the new Kconfig
option ARCH_HAS_NMI_SAFE_THIS_CPU_OPS to arch/x86/Kconfig, which will
cause NEED_SRCU_NMI_SAFE to be deselected, thus preserving the current
srcu_read_lock() behavior.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <x86@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..ee5783d8ec71 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
-- 
2.31.1.189.g2e36527f23

