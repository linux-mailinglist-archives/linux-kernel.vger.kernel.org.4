Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24627047D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEPIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjEPIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:30:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1C041BFD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:30:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355C22F4;
        Tue, 16 May 2023 01:31:11 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.70.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99DE63F7BD;
        Tue, 16 May 2023 01:30:23 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64: Disable EL2 traps for BRBE instructions executed in EL1
Date:   Tue, 16 May 2023 14:00:15 +0530
Message-Id: <20230516083015.569248-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This disables EL2 traps for BRBE instructions executed in EL1. This would
enable BRBE to be configured and used successfully in the guest kernel.
While here, this updates Documentation/arm64/booting.rst as well.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.4-rc2

Changes in V3:

- Updated with RMW pattern as per Marc

Changes in V2:

https://lore.kernel.org/all/20230515105328.239204-1-anshuman.khandual@arm.com/

- Updated Documentation/arm64/booting.rst

Changes in V1:

https://lore.kernel.org/all/20230324055127.2228330-1-anshuman.khandual@arm.com/

 Documentation/arm64/booting.rst    |  8 ++++++++
 arch/arm64/include/asm/el2_setup.h | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index ffeccdd6bdac..cb9e151f6928 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -379,6 +379,14 @@ Before jumping into the kernel, the following conditions must be met:
 
     - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
 
+  For CPUs with the Branch Record Buffer Extension (FEAT_BRBE):
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - HFGITR_EL2.nBRBINJ (bit 55) must be initialised to 0b1.
+
+    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..bfaf41ad9c4e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -161,6 +161,16 @@
 	msr_s	SYS_HFGWTR_EL2, x0
 	msr_s	SYS_HFGITR_EL2, xzr
 
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_\@
+
+	mrs_s	x0, SYS_HFGITR_EL2
+	orr	x0, x0, #HFGITR_EL2_nBRBIALL
+	orr	x0, x0, #HFGITR_EL2_nBRBINJ
+	msr_s	SYS_HFGITR_EL2, x0
+
+.Lskip_brbe_\@:
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
 	cbz	x1, .Lskip_fgt_\@
-- 
2.25.1

