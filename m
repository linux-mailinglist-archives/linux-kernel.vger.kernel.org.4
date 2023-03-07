Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDBD6AE1AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCGOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjCGOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:06:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3B84F4E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:06:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 821566143F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBACC433A4;
        Tue,  7 Mar 2023 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198007;
        bh=P/Q6t7rGGrSXbvlzWrWnoJP4iB2HWpKfFqCADdc1lgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwp2La2iddTcaO5BMNNOPuVAT9WS4dmHFjHNfde5f+XzIcIDDocQ6b7xeVV/BTkm2
         GpNCceBhgGyKYYDxDYcPHUM2yrdunOFUem7nz21/sxRscXFDPb+BG2A7fKawAhuepa
         po5n3+EWTmDlLXGwlavOftOm2dcOfe4C+TtFe9bAE8VZj81URGR9F6Vr6FQdLOERjd
         LuRel6uISFFS8Rs/C9XeSmUpH0DSHc8awSSTfOLUTYCjSrMXMgbjD5IsBefSWXybYT
         kbcq5jlHopdeuXXX5C43JmyrMKpYQawMQb2EJaqjcTAi+MlcdXlyPavNItmx7vO/b+
         rU9DWdgh/T62g==
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
Subject: [PATCH v3 04/60] arm64: mm: Move PCI I/O emulation region above the vmemmap region
Date:   Tue,  7 Mar 2023 15:04:26 +0100
Message-Id: <20230307140522.2311461-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=ardb@kernel.org; h=from:subject; bh=P/Q6t7rGGrSXbvlzWrWnoJP4iB2HWpKfFqCADdc1lgE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdhW3uwg7zyGrTWq2OPMntRVtTlS6qmjxWaKxpKQ6f9 XvR0fSOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJFlvIwM13YKMulFrT+lrqrw blGp2iZ1j2Vc9SFW4aJsfLfObr/5i5FhW4ablmzFbSWN3SdCtHfu0v//PcO4wHqCwp472yR4pJn 4AQ==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PCI I/O region above the vmemmap region in the kernel's VA
space. This will permit us to reclaim the lower part of the vmemmap
region for vmalloc/vmap allocations when running a 52-bit VA capable
build on a 48-bit VA capable system.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/memory.h | 4 ++--
 arch/arm64/mm/ptdump.c          | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a4e1d832a15a2d7a..6e321cc06a3c30f0 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -49,8 +49,8 @@
 #define MODULES_VSIZE		(SZ_128M)
 #define VMEMMAP_START		(-(UL(1) << (VA_BITS - VMEMMAP_SHIFT)))
 #define VMEMMAP_END		(VMEMMAP_START + VMEMMAP_SIZE)
-#define PCI_IO_END		(VMEMMAP_START - SZ_8M)
-#define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
+#define PCI_IO_START		(VMEMMAP_END + SZ_8M)
+#define PCI_IO_END		(PCI_IO_START + PCI_IO_SIZE)
 #define FIXADDR_TOP		(VMEMMAP_START - SZ_32M)
 
 #if VA_BITS > 48
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 9bc4066c5bf33a72..9d1f4cdc6672ed5f 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -47,10 +47,10 @@ static struct addr_marker address_markers[] = {
 	{ VMALLOC_END,			"vmalloc() end" },
 	{ FIXADDR_START,		"Fixmap start" },
 	{ FIXADDR_TOP,			"Fixmap end" },
-	{ PCI_IO_START,			"PCI I/O start" },
-	{ PCI_IO_END,			"PCI I/O end" },
 	{ VMEMMAP_START,		"vmemmap start" },
 	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
+	{ PCI_IO_START,			"PCI I/O start" },
+	{ PCI_IO_END,			"PCI I/O end" },
 	{ -1,				NULL },
 };
 
-- 
2.39.2

