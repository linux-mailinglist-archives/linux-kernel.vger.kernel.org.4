Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0EE6AE1B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCGOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCGOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD685B10
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20C8861453
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91483C433EF;
        Tue,  7 Mar 2023 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198017;
        bh=ywYQ7UcqIIS79iv7ntjeEpAqcLnJP0A5n4rXQJWafZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St+QY/UycgrASh5ECehIA8iTtJ4dKOYbVOY8uHJHxUSm0HuG6ndhv3ZJB7fsQV+0p
         LkCvojMp+3BBJYeZ3ZTWnlM8G7OH/D2zkJ1idMJ8xQfGv13xtMOX4qpCuLux4Ux3Ul
         PZ0iNYxHSrXuEuLVHalp6ew5iV3EtAI80dxE2YlOVYGiGN50Up6PO+JUcdTOfL+hfW
         GX8wbMhaO6Hm2x8J1XoO2iLqf9YksC5kpb4cBtQsYxACwegWde/3bpSzwXAr0l2zhV
         1HMf/ffHCOrxY7CnNRxBl8dYg6jfIo0ChjdZMy20bTMEHZn/SwFkapn3VgCyQL2CKQ
         WhzpvnnTXRpaQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 08/60] arm64: vmemmap: Avoid base2 order of struct page size to dimension region
Date:   Tue,  7 Mar 2023 15:04:30 +0100
Message-Id: <20230307140522.2311461-9-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=ardb@kernel.org; h=from:subject; bh=ywYQ7UcqIIS79iv7ntjeEpAqcLnJP0A5n4rXQJWafZ8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhS/0ZUuZrrTL9d0HdLbuj/IRLz0876vtuZwymSN+S 9okv0h3lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk02DEyPBBp8Z6/++iHaIH6 315yubsVruxxDveqPRlwZ53THYEZrgz/zCcxnrzfd5+/t0PMUrmpedXJDcuTVPcZanz/wC+36NB JTgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The placement and size of the vmemmap region in the kernel virtual
address space is currently derived from the base2 order of the size of a
struct page. This makes for nicely aligned constants with lots of
leading 0xf and trailing 0x0 digits, but given that the actual struct
pages are indexed as an ordinary array, this resulting region is
severely overdimensioned when the size of a struct page is just over a
power of 2.

This doesn't matter today, but once we enable 52-bit virtual addressing
for 4k pages configurations, the vmemmap region may take up almost half
of the upper VA region with the current struct page upper bound at 64
bytes. And once we enable KMSAN or other features that push the size of
a struct page over 64 bytes, we will run out of VMALLOC space entirely.

So instead, let's derive the region size from the actual size of a
struct page, and place the entire region 1 GB from the top of the VA
space, where it still doesn't share any lower level translation table
entries with the fixmap.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 9b9e52d823beccc6..830740ff79bab902 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -30,8 +30,8 @@
  * keep a constant PAGE_OFFSET and "fallback" to using the higher end
  * of the VMEMMAP where 52-bit support is not available in hardware.
  */
-#define VMEMMAP_SHIFT	(PAGE_SHIFT - STRUCT_PAGE_MAX_SHIFT)
-#define VMEMMAP_SIZE	((_PAGE_END(VA_BITS_MIN) - PAGE_OFFSET) >> VMEMMAP_SHIFT)
+#define VMEMMAP_RANGE	(_PAGE_END(VA_BITS_MIN) - PAGE_OFFSET)
+#define VMEMMAP_SIZE	((VMEMMAP_RANGE >> PAGE_SHIFT) * sizeof(struct page))
 
 /*
  * PAGE_OFFSET - the virtual address of the start of the linear map, at the
@@ -47,8 +47,8 @@
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(_PAGE_END(VA_BITS_MIN))
 #define MODULES_VSIZE		(SZ_128M)
-#define VMEMMAP_START		(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
-#define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
+#define VMEMMAP_START		(VMEMMAP_END - VMEMMAP_SIZE)
+#define VMEMMAP_END		(ULONG_MAX - SZ_1G + 1)
 #define PCI_IO_START		(VMEMMAP_END + SZ_8M)
 #define PCI_IO_END		(PCI_IO_START + PCI_IO_SIZE)
 #define FIXADDR_TOP		(ULONG_MAX - SZ_8M + 1)
-- 
2.39.2

