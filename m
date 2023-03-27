Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2AA6CB1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC0Wa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjC0Wa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:30:56 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8823D1997
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:30:55 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id f17so7577956oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679956255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaM8q8QF+IQ6nWYjMCRw/gvGqbSwmBUlsgKxklFnTd4=;
        b=Mjkz6bhxPyu9j1QEXEQiwWPGLYUU1wtjg/syikLA5LesYpH7+RNJ31SrlEK2hoK7Wh
         6Ayb2z+oURJgnY3GAi+oTSiRjmqwNdyN9Au4k+rAS4amRYHcEKiHdFy6HV5oepqIOuJ+
         tcTiiNVXy4KdnGRT2mZjneP5hmQsfZrwlZLs80bC5qtaIPhPRq9d54Ps8cUyb4iC1CKR
         rh1ljM8qeeLfmc6GJyZHueHgb5cQRa0l8i/yuRBHem8TQttkMIogRdE2cm3VSMseaDZX
         hoCM4revNsn33yttuHbtnxZj5oembGd0e8kEEBm+6x5FPGvDgkzRMEi3XPq6aZQew8om
         sRAA==
X-Gm-Message-State: AO0yUKUmGBw0iuJN2D/UlhwtP4M8D5y+D/y8AdkR5pOIVKhzTiGX7ir0
        9Ykc5qwK811+EfCJThY1zg==
X-Google-Smtp-Source: AK7set/1miGgLn0ymy+7VSFsPmHFvN9Y36ZA0WMc3bkqnmG77aBzAjHJgPqJMDiFTxWo0Dk8xMgWQQ==
X-Received: by 2002:a54:4418:0:b0:378:6ca0:11e9 with SMTP id k24-20020a544418000000b003786ca011e9mr5643146oiw.28.1679956254438;
        Mon, 27 Mar 2023 15:30:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y184-20020aca32c1000000b0037841fb9a65sm11730984oiy.5.2023.03.27.15.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:30:53 -0700 (PDT)
Received: (nullmailer pid 820043 invoked by uid 1000);
        Mon, 27 Mar 2023 22:30:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: isa-bridge: Remove open coded "ranges" parsing
Date:   Mon, 27 Mar 2023 17:30:45 -0500
Message-Id: <20230327223045.819852-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property with common parsing functions. Users
shouldn't be implementing their own parsing of it. Reimplement the
ISA brige "ranges" parsing using the common ranges iterator functions.

The common routines are flexible enough to work on PCI and non-PCI to
ISA bridges, so refactor pci_process_ISA_OF_ranges() and
isa_bridge_init_non_pci() into a single implementation.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!
---
 arch/powerpc/kernel/isa-bridge.c | 169 ++++++++-----------------------
 1 file changed, 40 insertions(+), 129 deletions(-)

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index dc746611ebc0..438605395cd4 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -55,80 +55,52 @@ static void remap_isa_base(phys_addr_t pa, unsigned long size)
 	}
 }
 
-static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
-				      unsigned long phb_io_base_phys)
+static int process_ISA_OF_ranges(struct device_node *isa_node,
+				  unsigned long phb_io_base_phys)
 {
-	/* We should get some saner parsing here and remove these structs */
-	struct pci_address {
-		u32 a_hi;
-		u32 a_mid;
-		u32 a_lo;
-	};
-
-	struct isa_address {
-		u32 a_hi;
-		u32 a_lo;
-	};
-
-	struct isa_range {
-		struct isa_address isa_addr;
-		struct pci_address pci_addr;
-		unsigned int size;
-	};
-
-	const struct isa_range *range;
-	unsigned long pci_addr;
-	unsigned int isa_addr;
 	unsigned int size;
-	int rlen = 0;
+	struct of_range_parser parser;
+	struct of_range range;
 
-	range = of_get_property(isa_node, "ranges", &rlen);
-	if (range == NULL || (rlen < sizeof(struct isa_range)))
+	if (of_range_parser_init(&parser, isa_node))
 		goto inval_range;
 
-	/* From "ISA Binding to 1275"
-	 * The ranges property is laid out as an array of elements,
-	 * each of which comprises:
-	 *   cells 0 - 1:	an ISA address
-	 *   cells 2 - 4:	a PCI address
-	 *			(size depending on dev->n_addr_cells)
-	 *   cell 5:		the size of the range
-	 */
-	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO) {
-		range++;
-		rlen -= sizeof(struct isa_range);
-		if (rlen < sizeof(struct isa_range))
-			goto inval_range;
-	}
-	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO)
-		goto inval_range;
+	for_each_of_range(&parser, &range) {
+		if ((range.flags & ISA_SPACE_MASK) != ISA_SPACE_IO)
+			continue;
 
-	isa_addr = range->isa_addr.a_lo;
-	pci_addr = (unsigned long) range->pci_addr.a_mid << 32 |
-		range->pci_addr.a_lo;
+		if (range.cpu_addr == OF_BAD_ADDR) {
+			printk(KERN_ERR "ISA: Bad CPU mapping: %s\n",
+			__func__);
+			return -EINVAL;
+		}
 
-	/* Assume these are both zero. Note: We could fix that and
-	 * do a proper parsing instead ... oh well, that will do for
-	 * now as nobody uses fancy mappings for ISA bridges
-	 */
-	if ((pci_addr != 0) || (isa_addr != 0)) {
-		printk(KERN_ERR "unexpected isa to pci mapping: %s\n",
-		       __func__);
-		return;
-	}
+		/* We need page alignment */
+		if ((range.bus_addr & ~PAGE_MASK) || (range.cpu_addr & ~PAGE_MASK)) {
+			pr_warn("ISA: bridge %pOF has non aligned IO range\n",
+				isa_node);
+			return -EINVAL;
+		}
 
-	/* Align size and make sure it's cropped to 64K */
-	size = PAGE_ALIGN(range->size);
-	if (size > 0x10000)
-		size = 0x10000;
+		/* Align size and make sure it's cropped to 64K */
+		size = PAGE_ALIGN(range.size);
+		if (size > 0x10000)
+			size = 0x10000;
 
-	remap_isa_base(phb_io_base_phys, size);
-	return;
+		if (!phb_io_base_phys)
+			phb_io_base_phys = range.cpu_addr;
+
+		remap_isa_base(phb_io_base_phys, size);
+		return 0;
+	}
 
 inval_range:
-	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
-	       "mapping 64k\n");
-	remap_isa_base(phb_io_base_phys, 0x10000);
+	if (!phb_io_base_phys) {
+		printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
+		       "mapping 64k\n");
+		remap_isa_base(phb_io_base_phys, 0x10000);
+	}
+	return 0;
 }
 
 
@@ -170,7 +142,7 @@ void __init isa_bridge_find_early(struct pci_controller *hose)
 	isa_bridge_devnode = np;
 
 	/* Now parse the "ranges" property and setup the ISA mapping */
-	pci_process_ISA_OF_ranges(np, hose->io_base_phys);
+	process_ISA_OF_ranges(np, hose->io_base_phys);
 
 	/* Set the global ISA io base to indicate we have an ISA bridge */
 	isa_io_base = ISA_IO_BASE;
@@ -186,75 +158,15 @@ void __init isa_bridge_find_early(struct pci_controller *hose)
  */
 void __init isa_bridge_init_non_pci(struct device_node *np)
 {
-	const __be32 *ranges, *pbasep = NULL;
-	int rlen, i, rs;
-	u32 na, ns, pna;
-	u64 cbase, pbase, size = 0;
+	int ret;
 
 	/* If we already have an ISA bridge, bail off */
 	if (isa_bridge_devnode != NULL)
 		return;
 
-	pna = of_n_addr_cells(np);
-	if (of_property_read_u32(np, "#address-cells", &na) ||
-	    of_property_read_u32(np, "#size-cells", &ns)) {
-		pr_warn("ISA: Non-PCI bridge %pOF is missing address format\n",
-			np);
-		return;
-	}
-
-	/* Check it's a supported address format */
-	if (na != 2 || ns != 1) {
-		pr_warn("ISA: Non-PCI bridge %pOF has unsupported address format\n",
-			np);
-		return;
-	}
-	rs = na + ns + pna;
-
-	/* Grab the ranges property */
-	ranges = of_get_property(np, "ranges", &rlen);
-	if (ranges == NULL || rlen < rs) {
-		pr_warn("ISA: Non-PCI bridge %pOF has absent or invalid ranges\n",
-			np);
-		return;
-	}
-
-	/* Parse it. We are only looking for IO space */
-	for (i = 0; (i + rs - 1) < rlen; i += rs) {
-		if (be32_to_cpup(ranges + i) != 1)
-			continue;
-		cbase = be32_to_cpup(ranges + i + 1);
-		size = of_read_number(ranges + i + na + pna, ns);
-		pbasep = ranges + i + na;
-		break;
-	}
-
-	/* Got something ? */
-	if (!size || !pbasep) {
-		pr_warn("ISA: Non-PCI bridge %pOF has no usable IO range\n",
-			np);
+	ret = process_ISA_OF_ranges(np, 0);
+	if (ret)
 		return;
-	}
-
-	/* Align size and make sure it's cropped to 64K */
-	size = PAGE_ALIGN(size);
-	if (size > 0x10000)
-		size = 0x10000;
-
-	/* Map pbase */
-	pbase = of_translate_address(np, pbasep);
-	if (pbase == OF_BAD_ADDR) {
-		pr_warn("ISA: Non-PCI bridge %pOF failed to translate IO base\n",
-			np);
-		return;
-	}
-
-	/* We need page alignment */
-	if ((cbase & ~PAGE_MASK) || (pbase & ~PAGE_MASK)) {
-		pr_warn("ISA: Non-PCI bridge %pOF has non aligned IO range\n",
-			np);
-		return;
-	}
 
 	/* Got it */
 	isa_bridge_devnode = np;
@@ -263,7 +175,6 @@ void __init isa_bridge_init_non_pci(struct device_node *np)
 	 * and map it
 	 */
 	isa_io_base = ISA_IO_BASE;
-	remap_isa_base(pbase, size);
 
 	pr_debug("ISA: Non-PCI bridge is %pOF\n", np);
 }
@@ -282,7 +193,7 @@ static void isa_bridge_find_late(struct pci_dev *pdev,
 	isa_bridge_pcidev = pdev;
 
 	/* Now parse the "ranges" property and setup the ISA mapping */
-	pci_process_ISA_OF_ranges(devnode, hose->io_base_phys);
+	process_ISA_OF_ranges(devnode, hose->io_base_phys);
 
 	/* Set the global ISA io base to indicate we have an ISA bridge */
 	isa_io_base = ISA_IO_BASE;
-- 
2.39.2

