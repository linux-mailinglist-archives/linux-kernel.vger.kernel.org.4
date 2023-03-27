Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C978D6CB064
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjC0VJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC0VJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:09:40 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D42119
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:09:39 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id i4-20020a056820138400b0053e3ccf739cso675079oow.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfOn32C10OnLMDPKfBd9GhbVkNrypbtF2Ph3uvU4wmQ=;
        b=C2oIwz01STAOi3TQR7uc/ONAo7qvqMaEhdzAItdxYoeUK0gal6T0tlMZGiZTX6oxpI
         hT4YWxnJXYtJuqzimlM6DO+orakVgGIkXAvIPa3V5CMXK2vS7n18YMJzrR8ZGryfSuAr
         MUn+gpCvmNd2658qva1HKzoCXgTGD68zXEUBtCrzW8PLzipv4cjIb5nkL15XGxohVCgt
         eWfwOoA6cTIFBX/jy+9qjZBi3HbNTruHrkDqhKpgK4pdNVSCNr/a8sD3CGYd5EuckwB3
         GY+NI4Wymb/YMqVuPTswPcMkphDxIFY91Hcmrp4oHhSVV5p1JgwfZSEWWYFeGaD4JC36
         jZxw==
X-Gm-Message-State: AO0yUKWvqwTM3fABCbwAtOo9RGjYPsiYoCKMDitKCu+MtWD9XGXacjb0
        Q/JDMxMSXc/9GeHjTayJ0BLKnlI0Zg==
X-Google-Smtp-Source: AK7set+LJSlGuloOzOTQnZG27e0vTxZs5DbZdqinqZKBpidciiFIPx3xkgyz61CbC+i0w9wJH00rGQ==
X-Received: by 2002:a4a:3316:0:b0:538:c408:45cb with SMTP id q22-20020a4a3316000000b00538c40845cbmr6159785ooq.8.1679951378819;
        Mon, 27 Mar 2023 14:09:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a056808098e00b00383ef58c15bsm1410684oic.28.2023.03.27.14.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:09:37 -0700 (PDT)
Received: (nullmailer pid 666529 invoked by uid 1000);
        Mon, 27 Mar 2023 21:09:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: Use of_address_to_resource()
Date:   Mon, 27 Mar 2023 16:09:28 -0500
Message-Id: <20230327210929.664737-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded reading of "reg" or of_get_address()/
of_translate_address() calls with a single call to
of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix compile in tsi108_dev.c
---
 arch/powerpc/mm/numa.c                        | 21 +++------
 arch/powerpc/platforms/52xx/lite5200_pm.c     |  9 ++--
 arch/powerpc/platforms/cell/axon_msi.c        |  9 ++--
 arch/powerpc/platforms/embedded6xx/holly.c    |  7 ++-
 arch/powerpc/platforms/embedded6xx/ls_uart.c  | 16 ++++---
 arch/powerpc/platforms/powermac/feature.c     | 16 +++----
 .../platforms/pseries/hotplug-memory.c        | 45 +++++--------------
 arch/powerpc/platforms/pseries/iommu.c        | 20 +++------
 arch/powerpc/sysdev/tsi108_dev.c              |  6 +--
 9 files changed, 50 insertions(+), 99 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b44ce71917d7..3a5c0d56b1ad 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/pfn.h>
 #include <linux/cpuset.h>
 #include <linux/node.h>
@@ -1288,23 +1289,15 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 	int nid = NUMA_NO_NODE;
 
 	for_each_node_by_type(memory, "memory") {
-		unsigned long start, size;
-		int ranges;
-		const __be32 *memcell_buf;
-		unsigned int len;
-
-		memcell_buf = of_get_property(memory, "reg", &len);
-		if (!memcell_buf || len <= 0)
-			continue;
+		int i = 0;
 
-		/* ranges in cell */
-		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+		while (1) {
+			struct resource res;
 
-		while (ranges--) {
-			start = read_n_cells(n_mem_addr_cells, &memcell_buf);
-			size = read_n_cells(n_mem_size_cells, &memcell_buf);
+			if (of_address_to_resource(memory, i++, &res))
+				break;
 
-			if ((scn_addr < start) || (scn_addr >= (start + size)))
+			if ((scn_addr < res.start) || (scn_addr > res.end))
 				continue;
 
 			nid = of_node_to_nid_single(memory);
diff --git a/arch/powerpc/platforms/52xx/lite5200_pm.c b/arch/powerpc/platforms/52xx/lite5200_pm.c
index 129313b1d021..ee29b63fca16 100644
--- a/arch/powerpc/platforms/52xx/lite5200_pm.c
+++ b/arch/powerpc/platforms/52xx/lite5200_pm.c
@@ -54,8 +54,7 @@ static int lite5200_pm_prepare(void)
 		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
 		{}
 	};
-	u64 regaddr64 = 0;
-	const u32 *regaddr_p;
+	struct resource res;
 
 	/* deep sleep? let mpc52xx code handle that */
 	if (lite5200_pm_target_state == PM_SUSPEND_STANDBY)
@@ -66,12 +65,10 @@ static int lite5200_pm_prepare(void)
 
 	/* map registers */
 	np = of_find_matching_node(NULL, immr_ids);
-	regaddr_p = of_get_address(np, 0, NULL, NULL);
-	if (regaddr_p)
-		regaddr64 = of_translate_address(np, regaddr_p);
+	of_address_to_resource(np, 0, &res);
 	of_node_put(np);
 
-	mbar = ioremap((u32) regaddr64, 0xC000);
+	mbar = ioremap(res.start, 0xC000);
 	if (!mbar) {
 		printk(KERN_ERR "%s:%i Error mapping registers\n", __func__, __LINE__);
 		return -ENOSYS;
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 0c11aad896c7..106000449d3b 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -460,15 +460,14 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
 void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 {
 	char name[8];
-	u64 addr;
+	struct resource res;
 
-	addr = of_translate_address(dn, of_get_property(dn, "reg", NULL));
-	if (addr == OF_BAD_ADDR) {
-		pr_devel("axon_msi: couldn't translate reg property\n");
+	if (of_address_to_resource(dn, 0, &res)) {
+		pr_devel("axon_msi: couldn't get reg property\n");
 		return;
 	}
 
-	msic->trigger = ioremap(addr, 0x4);
+	msic->trigger = ioremap(res.start, 0x4);
 	if (!msic->trigger) {
 		pr_devel("axon_msi: ioremap failed\n");
 		return;
diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index bebc5a972694..f7a17a6e2718 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -205,16 +205,15 @@ static void __noreturn holly_restart(char *cmd)
 	__be32 __iomem *ocn_bar1 = NULL;
 	unsigned long bar;
 	struct device_node *bridge = NULL;
-	const void *prop;
-	int size;
+	struct resource res;
 	phys_addr_t addr = 0xc0000000;
 
 	local_irq_disable();
 
 	bridge = of_find_node_by_type(NULL, "tsi-bridge");
 	if (bridge) {
-		prop = of_get_property(bridge, "reg", &size);
-		addr = of_translate_address(bridge, prop);
+		of_address_to_resource(bridge, 0, &res);
+		addr = res.start;
 		of_node_put(bridge);
 	}
 	addr += (TSI108_PB_OFFSET + 0x414);
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index 4ecbc55b37c0..36e4d2f85d5d 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -114,22 +114,24 @@ static void __init ls_uart_init(void)
 static int __init ls_uarts_init(void)
 {
 	struct device_node *avr;
-	phys_addr_t phys_addr;
-	int len;
+	struct resource res;
+	int len, ret;
 
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
 
 	avr_clock = *(u32*)of_get_property(avr, "clock-frequency", &len);
-	phys_addr = ((u32*)of_get_property(avr, "reg", &len))[0];
+	if (!avr_clock)
+		return -EINVAL;
 
-	of_node_put(avr);
+	ret = of_address_to_resource(avr, 0, &res);
+	if (ret)
+		return ret;
 
-	if (!avr_clock || !phys_addr)
-		return -EINVAL;
+	of_node_put(avr);
 
-	avr_addr = ioremap(phys_addr, 32);
+	avr_addr = ioremap(res.start, 32);
 	if (!avr_addr)
 		return -EFAULT;
 
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index dd508c2fcb5a..307548f20c1d 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2545,8 +2545,7 @@ static int __init probe_motherboard(void)
  */
 static void __init probe_uninorth(void)
 {
-	const u32 *addrp;
-	phys_addr_t address;
+	struct resource res;
 	unsigned long actrl;
 
 	/* Locate core99 Uni-N */
@@ -2568,18 +2567,15 @@ static void __init probe_uninorth(void)
 		return;
 	}
 
-	addrp = of_get_property(uninorth_node, "reg", NULL);
-	if (addrp == NULL)
+	if (of_address_to_resource(uninorth_node, 0, &res))
 		return;
-	address = of_translate_address(uninorth_node, addrp);
-	if (address == 0)
-		return;
-	uninorth_base = ioremap(address, 0x40000);
+
+	uninorth_base = ioremap(res.start, 0x40000);
 	if (uninorth_base == NULL)
 		return;
 	uninorth_rev = in_be32(UN_REG(UNI_N_VERSION));
 	if (uninorth_maj == 3 || uninorth_maj == 4) {
-		u3_ht_base = ioremap(address + U3_HT_CONFIG_BASE, 0x1000);
+		u3_ht_base = ioremap(res.start + U3_HT_CONFIG_BASE, 0x1000);
 		if (u3_ht_base == NULL) {
 			iounmap(uninorth_base);
 			return;
@@ -2589,7 +2585,7 @@ static void __init probe_uninorth(void)
 	printk(KERN_INFO "Found %s memory controller & host bridge"
 	       " @ 0x%08x revision: 0x%02x\n", uninorth_maj == 3 ? "U3" :
 	       uninorth_maj == 4 ? "U4" : "UniNorth",
-	       (unsigned int)address, uninorth_rev);
+	       (unsigned int)res.start, uninorth_rev);
 	printk(KERN_INFO "Mapped at 0x%08lx\n", (unsigned long)uninorth_base);
 
 	/* Set the arbitrer QAck delay according to what Apple does
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2e3a317722a8..9c62c2c3b3d0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -311,11 +311,8 @@ static int pseries_remove_memblock(unsigned long base, unsigned long memblock_si
 
 static int pseries_remove_mem_node(struct device_node *np)
 {
-	const __be32 *prop;
-	unsigned long base;
-	unsigned long lmb_size;
-	int ret = -EINVAL;
-	int addr_cells, size_cells;
+	int ret;
+	struct resource res;
 
 	/*
 	 * Check to see if we are actually removing memory
@@ -326,21 +323,11 @@ static int pseries_remove_mem_node(struct device_node *np)
 	/*
 	 * Find the base address and size of the memblock
 	 */
-	prop = of_get_property(np, "reg", NULL);
-	if (!prop)
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
 		return ret;
 
-	addr_cells = of_n_addr_cells(np);
-	size_cells = of_n_size_cells(np);
-
-	/*
-	 * "reg" property represents (addr,size) tuple.
-	 */
-	base = of_read_number(prop, addr_cells);
-	prop += addr_cells;
-	lmb_size = of_read_number(prop, size_cells);
-
-	pseries_remove_memblock(base, lmb_size);
+	pseries_remove_memblock(res.start, resource_size(&res));
 	return 0;
 }
 
@@ -929,11 +916,8 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 
 static int pseries_add_mem_node(struct device_node *np)
 {
-	const __be32 *prop;
-	unsigned long base;
-	unsigned long lmb_size;
-	int ret = -EINVAL;
-	int addr_cells, size_cells;
+	int ret;
+	struct resource res;
 
 	/*
 	 * Check to see if we are actually adding memory
@@ -944,23 +928,14 @@ static int pseries_add_mem_node(struct device_node *np)
 	/*
 	 * Find the base and size of the memblock
 	 */
-	prop = of_get_property(np, "reg", NULL);
-	if (!prop)
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
 		return ret;
 
-	addr_cells = of_n_addr_cells(np);
-	size_cells = of_n_size_cells(np);
-	/*
-	 * "reg" property represents (addr,size) tuple.
-	 */
-	base = of_read_number(prop, addr_cells);
-	prop += addr_cells;
-	lmb_size = of_read_number(prop, size_cells);
-
 	/*
 	 * Update memory region to represent the memory add
 	 */
-	ret = memblock_add(base, lmb_size);
+	ret = memblock_add(res.start, resource_size(&res));
 	return (ret < 0) ? -EINVAL : 0;
 }
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c74b71d4733d..f94c78a7bddc 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -22,6 +22,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memory.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
 #include <asm/io.h>
@@ -1111,27 +1112,16 @@ static LIST_HEAD(failed_ddw_pdn_list);
 
 static phys_addr_t ddw_memory_hotplug_max(void)
 {
-	phys_addr_t max_addr = memory_hotplug_max();
+	resource_size_t max_addr = memory_hotplug_max();
 	struct device_node *memory;
 
 	for_each_node_by_type(memory, "memory") {
-		unsigned long start, size;
-		int n_mem_addr_cells, n_mem_size_cells, len;
-		const __be32 *memcell_buf;
+		struct resource res;
 
-		memcell_buf = of_get_property(memory, "reg", &len);
-		if (!memcell_buf || len <= 0)
+		if (of_address_to_resource(memory, 0, &res))
 			continue;
 
-		n_mem_addr_cells = of_n_addr_cells(memory);
-		n_mem_size_cells = of_n_size_cells(memory);
-
-		start = of_read_number(memcell_buf, n_mem_addr_cells);
-		memcell_buf += n_mem_addr_cells;
-		size = of_read_number(memcell_buf, n_mem_size_cells);
-		memcell_buf += n_mem_size_cells;
-
-		max_addr = max_t(phys_addr_t, max_addr, start + size);
+		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
 	}
 
 	return max_addr;
diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 30051397292f..679bd5061201 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -45,9 +45,9 @@ phys_addr_t get_csrbase(void)
 
 	tsi = of_find_node_by_type(NULL, "tsi-bridge");
 	if (tsi) {
-		unsigned int size;
-		const void *prop = of_get_property(tsi, "reg", &size);
-		tsi108_csr_base = of_translate_address(tsi, prop);
+		struct resource res;
+		of_address_to_resource(tsi, 0, &res);
+		tsi108_csr_base = res.start;
 		of_node_put(tsi);
 	}
 	return tsi108_csr_base;
-- 
2.39.2

