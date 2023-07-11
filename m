Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2E74E9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGKJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGKJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:05:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88CBA94
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:05:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8D42B;
        Tue, 11 Jul 2023 02:05:49 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.47.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 627AF3F67D;
        Tue, 11 Jul 2023 02:05:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Replace an open coding with ID_AA64MMFR1_EL1_HAFDBS_MASK
Date:   Tue, 11 Jul 2023 14:34:58 +0530
Message-Id: <20230711090458.238346-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace '0xf' with ID_AA64MMFR1_EL1_HAFDBS_MASK while evaluating if the cpu
supports implicit page table entry access flag update in HW.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on 6.5-rc1

 arch/arm64/mm/proc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2baeec419f62..14fdf645edc8 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -447,7 +447,7 @@ SYM_FUNC_START(__cpu_setup)
 	 * via capabilities.
 	 */
 	mrs	x9, ID_AA64MMFR1_EL1
-	and	x9, x9, #0xf
+	and	x9, x9, ID_AA64MMFR1_EL1_HAFDBS_MASK
 	cbz	x9, 1f
 	orr	tcr, tcr, #TCR_HA		// hardware Access flag update
 1:
-- 
2.30.2

