Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73874AA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGGFeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjGGFeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:34:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DADB210B;
        Thu,  6 Jul 2023 22:34:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B029112FC;
        Thu,  6 Jul 2023 22:34:45 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 114983F740;
        Thu,  6 Jul 2023 22:33:59 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 4/4] docs: arm64: Add help document for pte dirty state management
Date:   Fri,  7 Jul 2023 11:03:31 +0530
Message-Id: <20230707053331.510041-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707053331.510041-1-anshuman.khandual@arm.com>
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
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

PTE dirty state management is non-trivial on arm64 platform. This document
explains how both software and hardware come together in correctly tracking
PTE ditry state across various page table transactions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/index.rst     |  1 +
 Documentation/arch/arm64/pte-dirty.rst | 95 ++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/arch/arm64/pte-dirty.rst

diff --git a/Documentation/arch/arm64/index.rst b/Documentation/arch/arm64/index.rst
index d08e924204bf..522f887f2a60 100644
--- a/Documentation/arch/arm64/index.rst
+++ b/Documentation/arch/arm64/index.rst
@@ -22,6 +22,7 @@ ARM64 Architecture
     perf
     pointer-authentication
     ptdump
+    pte-dirty
     silicon-errata
     sme
     sve
diff --git a/Documentation/arch/arm64/pte-dirty.rst b/Documentation/arch/arm64/pte-dirty.rst
new file mode 100644
index 000000000000..a6401696f6a3
--- /dev/null
+++ b/Documentation/arch/arm64/pte-dirty.rst
@@ -0,0 +1,95 @@
+.. SPDX-License-Identifier: GPL-2.0
+=========================================
+Page Table Entry - Dirty State Management
+=========================================
+
+1. Introduction
+---------------
+
+arm64 platform defines pte_dirty() to determine if the pte has been dirtied
+i.e pte has been written info after the previous clean procedure. The dirty
+state tracking could be achieved, either via software or hardware pte dirty
+bit mechanism. On arm64 platform, pte_dirty() is implemented utilizing both
+software and hardware dirty bits, making it non intuitive unlike many other
+platforms.
+
+2. PTE Dirty Bits (SW and HW)
+-----------------------------
+Following are relevant PTE bit positions for dirty state tracking.
+
+- PTE_DIRTY is a software bit (55) in the PTE
+- PTE_RDONLY is a hardware bit (7) in the PTE
+- PTE_DBM is a hardware bit (51) in the PTE
+- PTE_WRITE is a hardware bit (51) in the PTE - share position with PTE_DBM
+
+3. PTE Dirty State Tracking
+---------------------------
+Without ARM64_HW_AFDBM enabled, PTE dirty state is tracked only in the SW.
+PTE is marked read-only in HW, subsequent write access generates page fault
+which can update the SW dirty bit and clear the read-only access in HW.
+
+With ARM64_HW_AFDBM enabled, PTE dirty state is tracked both in SW and HW.
+PTE is marked read-only in HW while also enabling DBM tracking. Any write
+access will clear the read-only bit while also preventing a page fault. As
+PTE_DBM and PTE_WRITE share the same bit position, a dirty non-writable PTE
+state cannot be tracked in hardware. This in turn necessitates dirty state
+tracking (ARM64_HW_AFDBM enabled) to accommodate both software and hardware
+PTE bits. This helps in avoiding a runtime check for ARM64_HW_AFDBM feature
+being enabled on a given implementation.
+
+Testing and clearing PTE dirty state is relatively simple -
+
+#define pte_hw_dirty(pte)	(pte_write(pte) && !pte_rdonly(pte))
+#define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
+#define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
+
+static inline pte_t pte_mkclean(pte_t pte)
+{
+	/*
+	 * Subsequent call to pte_hw_clr_dirty() is not required
+	 * because pte_sw_clr_dirty() in turn does that as well.
+	 */
+	return pte_sw_clr_dirty(pte);
+}
+
+But marking a dirty state, creating a write protected entry etc now becomes
+bit non-trivial in hardware. as PTE_RDONLY bit could only be cleared if the
+write bit is also set.
+
+static inline pte_t pte_hw_mkdirty(pte_t pte)
+{
+	if (pte_write(pte))
+		return clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+
+	return pte;
+}
+
+Hence marking a dirty state triggers marking both SW and HW dirty bits, so
+that if the HW suppoprt is unavailable or insufficient (dirty non-writable)
+, SW mechanism would still put it in a dirty state.
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	pte = pte_sw_mkdirty(pte);
+	pte = pte_hw_mkdirty(pte);
+	return pte;
+}
+
+4. Preserving PTE HW Dirty State
+--------------------------------
+If for some reason HW dirty bits (PTE_WRITE, PTE_RDONLY) need to be cleared
+the dirty state must be transferred as SW dirty bit ensuring persistence of
+the dirty state across the operation.
+
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+        .....
+        pte = pte_preserve_hw_dirty(pte_t pte);
+        .....
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte = pte_preserve_hw_dirty(pte_t pte);
+        .....
+}
-- 
2.30.2

