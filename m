Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC473E63A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjFZRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFZRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:15:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBAFE10D5;
        Mon, 26 Jun 2023 10:15:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C111215A1;
        Mon, 26 Jun 2023 10:15:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7EBC3F663;
        Mon, 26 Jun 2023 10:15:05 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: [PATCH v1 09/10] arm64: mm: Declare support for large anonymous folios
Date:   Mon, 26 Jun 2023 18:14:29 +0100
Message-Id: <20230626171430.3167004-10-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626171430.3167004-1-ryan.roberts@arm.com>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
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

For the unhinted case, when THP is not permitted for the vma, don't
allow anything bigger than 64K. This means we don't waste too much
memory. Additionally, for 4K pages this is the contpte size, and for
16K, this is (usually) the HPA size when the uarch feature is
implemented. For the hinted case, when THP is permitted for the vma,
allow the contpte size for all page size configurations; 64K for 4K, 2M
for 16K and 2M for 64K.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 343e1e1cae10..0e91b5bc8cd9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -243,6 +243,7 @@ config ARM64
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select ARCH_SUPPORTS_LARGE_ANON_FOLIO
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -281,6 +282,18 @@ config ARM64_CONT_PMD_SHIFT
 	default 5 if ARM64_16K_PAGES
 	default 4
 
+config ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
+	int
+	default 0 if ARM64_64K_PAGES	# 64K (1 page)
+	default 2 if ARM64_16K_PAGES	# 64K (4 pages; benefits from HPA where HW supports it)
+	default 4 if ARM64_4K_PAGES	# 64K (16 pages; eligible for contpte-mapping)
+
+config ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
+	int
+	default 5 if ARM64_64K_PAGES	# 2M  (32 page; eligible for contpte-mapping)
+	default 7 if ARM64_16K_PAGES	# 2M  (128 pages; eligible for contpte-mapping)
+	default 4 if ARM64_4K_PAGES	# 64K (16 pages; eligible for contpte-mapping)
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 14 if ARM64_64K_PAGES
 	default 16 if ARM64_16K_PAGES
-- 
2.25.1

