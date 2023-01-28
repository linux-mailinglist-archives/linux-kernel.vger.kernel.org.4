Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1E67F81F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjA1Ng3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjA1Ng0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40814EAF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1361060C03
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B03CC4339B;
        Sat, 28 Jan 2023 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674912984;
        bh=CxsGwxondKYbEH8oAkJtUvwrFSvm/Rfl3p6vmW1mWVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBbNprxWWv62MZNa2aRCFAtqYR+f0DdnMWqffMNVBJvKd8EpIwKGXCw3EISJfkJ4y
         NxqkInP0g+ARTJdXYOFAokV2FHz0uut6vxsM6415+nPQKtj69SD6vr6nyCNdaK6w4N
         CGQpGL5w8lA406XVjumWIcWSJHo3pbwgTvtw9+8PcvHr/vsL6JGwfbxOogJn7MPIzz
         1M6Max7PgF+0wIvylK+/jhPgPwMG8DyZkXioLw8rkvB+loz6yeS2Ffuqp6y0PX0TJ8
         ST+3V2FBd0SvIOoQx1ojxWKMf1iGOPW/a0qmfqA4iMeymlZ09hNrHk4ISECLT7hZOO
         77pp3HOlGO3Yw==
Received: by pali.im (Postfix)
        id D8098639; Sat, 28 Jan 2023 14:36:23 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/pci: Allow to disable filling deprecated pci-OF-bus-map
Date:   Sat, 28 Jan 2023 14:34:59 +0100
Message-Id: <20230128133459.32123-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230128133459.32123-1-pali@kernel.org>
References: <20220817163927.24453-1-pali@kernel.org>
 <20230128133459.32123-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating or filling pci-OF-bus-map property in the device-tree is
deprecated since May 2006 [1]. Allow to disable filling this property by
unsetting config option CONFIG_PPC_PCI_OF_BUS_MAP_FILL for remaining chrp
and powermac code.

Disabling of pci-OF-bus-map property allows to enable new option
CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT also for chrp and powermac.

[1] - https://lore.kernel.org/linuxppc-dev/1148016268.13249.14.camel@localhost.localdomain/

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v2:
* Provide stripped version of pci_device_from_OF_node() without
  pci_to_OF_bus_map when compiling with CONFIG_PPC_PCI_OF_BUS_MAP_FILL=n
---
 arch/powerpc/Kconfig         | 12 +++++++++++-
 arch/powerpc/kernel/pci_32.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fad25aa602c8..3f8499faa88a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -388,9 +388,19 @@ config PPC_DCR
 	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
 	default y
 
+config PPC_PCI_OF_BUS_MAP_FILL
+	bool "Fill pci-OF-bus-map property in the device-tree"
+	depends on PPC32
+	depends on PPC_PMAC || PPC_CHRP
+	default y
+	help
+	  This option creates and fills pci-OF-bus-map property in the
+	  device-tree which is deprecated and is needed only for old
+	  platforms.
+
 config PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
 	depends on PPC32
-	depends on !PPC_PMAC && !PPC_CHRP
+	depends on !PPC_PCI_OF_BUS_MAP_FILL
 	bool "Assign PCI bus numbers from zero individually for each PCI domain"
 	default y
 	help
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 855b59892c5c..82a8981d4c47 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -64,6 +64,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixu
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
 
+#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
+
 static u8* pci_to_OF_bus_map;
 static int pci_bus_count;
 
@@ -223,6 +225,32 @@ pci_create_OF_bus_map(void)
 }
 #endif
 
+#else /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
+
+/*
+ * Returns the PCI device matching a given OF node without pci_to_OF_bus_map
+ */
+int pci_device_from_OF_node(struct device_node *node, u8 *bus, u8 *devfn)
+{
+	const __be32 *reg;
+	int size;
+
+	/* Check if it might have a chance to be a PCI device */
+	if (!pci_find_hose_for_OF_device(node))
+		return -ENODEV;
+
+	reg = of_get_property(node, "reg", &size);
+	if (!reg || size < 5 * sizeof(u32))
+		return -ENODEV;
+
+	*bus = (be32_to_cpup(&reg[0]) >> 16) & 0xff;
+	*devfn = (be32_to_cpup(&reg[0]) >> 8) & 0xff;
+
+	return 0;
+}
+
+#endif /* CONFIG_PPC_PCI_OF_BUS_MAP_FILL */
+
 #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP) */
 
 void pcibios_setup_phb_io_space(struct pci_controller *hose)
@@ -273,6 +301,7 @@ static int __init pcibios_init(void)
 	}
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_CHRP)
+#ifdef CONFIG_PPC_PCI_OF_BUS_MAP_FILL
 	pci_bus_count = next_busno;
 
 	/* OpenFirmware based machines need a map of OF bus
@@ -281,6 +310,7 @@ static int __init pcibios_init(void)
 	 */
 	if (pci_assign_all_buses)
 		pcibios_make_OF_bus_map();
+#endif
 #endif
 
 	/* Call common code to handle resource allocation */
-- 
2.20.1

