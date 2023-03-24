Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B579F6C7784
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCXFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXFvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:51:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87107DBE8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:51:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 476A411FB;
        Thu, 23 Mar 2023 22:52:20 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E58253F766;
        Thu, 23 Mar 2023 22:51:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed in EL1
Date:   Fri, 24 Mar 2023 11:21:27 +0530
Message-Id: <20230324055127.2228330-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This disables EL2 traps for BRBE instructions executed in EL1. This would
enable BRBE to be configured and used successfully in the guest kernel.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.3-rc3, after the following patch series from Mark

https://lore.kernel.org/all/20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org/

 arch/arm64/include/asm/el2_setup.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..06bf321a17be 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -161,6 +161,16 @@
 	msr_s	SYS_HFGWTR_EL2, x0
 	msr_s	SYS_HFGITR_EL2, xzr
 
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_\@
+
+	mov	x0, xzr
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

