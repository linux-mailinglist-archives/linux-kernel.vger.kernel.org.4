Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3EC74EA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjGKJZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjGKJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:25:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EA111AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:21:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7897B2B;
        Tue, 11 Jul 2023 02:21:44 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.47.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61B123F67D;
        Tue, 11 Jul 2023 02:21:00 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Directly use ID_AA64MMFR2_EL1_VARange_MASK
Date:   Tue, 11 Jul 2023 14:50:55 +0530
Message-Id: <20230711092055.245756-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tools generated register fields have in place mask macros which can be used
directly instead of shifting the older right end sided masks.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.5-rc1

 arch/arm64/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 757a0de07f91..7b236994f0e1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -113,7 +113,7 @@ SYM_CODE_START(primary_entry)
 	 */
 #if VA_BITS > 48
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
-	tst	x0, #0xf << ID_AA64MMFR2_EL1_VARange_SHIFT
+	tst	x0, ID_AA64MMFR2_EL1_VARange_MASK
 	mov	x0, #VA_BITS
 	mov	x25, #VA_BITS_MIN
 	csel	x25, x25, x0, eq
@@ -756,7 +756,7 @@ SYM_FUNC_START(__cpu_secondary_check52bitva)
 	b.ne	2f
 
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
-	and	x0, x0, #(0xf << ID_AA64MMFR2_EL1_VARange_SHIFT)
+	and	x0, x0, ID_AA64MMFR2_EL1_VARange_MASK
 	cbnz	x0, 2f
 
 	update_early_cpu_boot_status \
-- 
2.30.2

