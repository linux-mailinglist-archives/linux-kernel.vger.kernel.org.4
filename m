Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38B6AE1B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCGOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCGOGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572C848DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B256145C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB8C433A0;
        Tue,  7 Mar 2023 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198010;
        bh=8ouA8Mhr3C7XfVU8ngz8EZDrejuiodn55YE1KadufeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hd9/VBgk9NJvRDq6RUK+jbr33uWwgSWL7Z2sMsvjMCGWKtaEF7wwPVx7AwJx1jPZG
         +oNKTb3na926drLq1jcY/lSVENGZFGaQGZnZUjbw7VcymUUPEjwv1yRUraOx3LlTUK
         psYhWxSNZjX84Dj5B+DOLH3m5L8e5paB5Bp9tBo83V2HoaALaxjnYJ9MSv+YW7gw1X
         ioRTxJ9T6Wo9andEzTsIwvTWuBGgWgKJOvZ0gvxuj3CuNIT8usV4fEAuybERvgGtV+
         cOkkuFRb2AeOYmp80YeBbDUiCngbzjQRYJwIeCa6+xFsfXik272RpkAOhh6g0/GF8d
         74ms3rGX4bOog==
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
Subject: [PATCH v3 05/60] arm64: mm: Move fixmap region above vmemmap region
Date:   Tue,  7 Mar 2023 15:04:27 +0100
Message-Id: <20230307140522.2311461-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=ardb@kernel.org; h=from:subject; bh=8ouA8Mhr3C7XfVU8ngz8EZDrejuiodn55YE1KadufeU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhcNR7sNjKYZbhT4M/9T8r06doHveU+vhprsP7h9bf n/+zSe3OkpZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBE2tsY/heuu9/7ll/w4fGc fSI/vb5++dTxW/r8Jq0DEdqbDsResJ3DyPBii/aRJQss1urfnvRh+XVF1bU71mnduMutsMrpyLu 95nasAA==
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

Move the fixmap region above the vmemmap region, so that the start of
the vmemmap delineates the end of the region available for vmalloc and
vmap allocations and the randomized placement of the kernel and modules.

In a subsequent patch, we will take advantage of this to reclaim most of
the vmemmap area when running a 52-bit VA capable build with 52-bit
virtual addressing disabled at runtime.

Note that the existing guard region of 256 MiB covers the fixmap and PCI
I/O regions as well, so we can reduce it 8 MiB, which is what we use in
other places too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h  | 2 +-
 arch/arm64/include/asm/pgtable.h | 2 +-
 arch/arm64/mm/ptdump.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6e321cc06a3c30f0..9b9e52d823beccc6 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -51,7 +51,7 @@
 #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
 #define PCI_IO_START		(VMEMMAP_END + SZ_8M)
 #define PCI_IO_END		(PCI_IO_START + PCI_IO_SIZE)
-#define FIXADDR_TOP		(VMEMMAP_START - SZ_32M)
+#define FIXADDR_TOP		(ULONG_MAX - SZ_8M + 1)
 
 #if VA_BITS > 48
 #define VA_BITS_MIN		(48)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b6ba466e2e8a3fc7..3eff06c5d0eb73c7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -22,7 +22,7 @@
  *	and fixed mappings
  */
 #define VMALLOC_START		(MODULES_END)
-#define VMALLOC_END		(VMEMMAP_START - SZ_256M)
+#define VMALLOC_END		(VMEMMAP_START - SZ_8M)
 
 #define vmemmap			((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
 
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 9d1f4cdc6672ed5f..76d28056bd14920a 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -45,12 +45,12 @@ static struct addr_marker address_markers[] = {
 	{ MODULES_END,			"Modules end" },
 	{ VMALLOC_START,		"vmalloc() area" },
 	{ VMALLOC_END,			"vmalloc() end" },
-	{ FIXADDR_START,		"Fixmap start" },
-	{ FIXADDR_TOP,			"Fixmap end" },
 	{ VMEMMAP_START,		"vmemmap start" },
 	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
 	{ PCI_IO_START,			"PCI I/O start" },
 	{ PCI_IO_END,			"PCI I/O end" },
+	{ FIXADDR_START,		"Fixmap start" },
+	{ FIXADDR_TOP,			"Fixmap end" },
 	{ -1,				NULL },
 };
 
-- 
2.39.2

