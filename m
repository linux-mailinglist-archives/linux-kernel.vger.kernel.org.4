Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2D6FBDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjEIDzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEIDzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD640C8;
        Mon,  8 May 2023 20:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E21161011;
        Tue,  9 May 2023 03:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4C7C433EF;
        Tue,  9 May 2023 03:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683604496;
        bh=EU+89lF6beMctRec6bim/8TjBP/TWUjhkRKihbeImeo=;
        h=From:To:Cc:Subject:Date:From;
        b=WfoXDIGRubOTsmRgSBGSbufeclYzoUXFQ5+oA3L0u3ZPovzCkSg4EcUd97Id8uD8r
         ZY94fK/qxDBQ+7CnYeIrWG6iVOHpiNeiCcjuseJpBvEEx9lAxrKXM6buxdG2uLTyW4
         e91pWMHfdEgc4BCewjVdQyY2bcqrcn8AJNlMFftN1tTRM2XIQlvPm4CsZ1z87vPKHr
         K6aiIduPQmW9zXKs89ASlTog5McirIhEY8YXorIAEqFVefYzhd/UmMztZINfARy94S
         e/p1AWqSbDgECS3DPn0fvyq8r3g0yY3bR55vW/007iy/wpJW5Hb0lHeF8SDalPDt1B
         nXbCy/um+2m2w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, benh@kernel.crashing.org,
        windhl@126.com, christophe.leroy@csgroup.eu, krzk@kernel.org,
        nathanl@linux.ibm.com, srikar@linux.vnet.ibm.com,
        ldufour@linux.ibm.com, osalvador@suse.de,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        alexs@kernel.org, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.3 1/7] powerpc: Use of_property_present() for testing DT property presence
Date:   Mon,  8 May 2023 23:54:24 -0400
Message-Id: <20230509035455.59524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 857d423c74228cfa064f79ff3a16b163fdb8d542 ]

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
[mpe: Drop change in ppc4xx_probe_pci_bridge(), formatting]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230310144657.1541039-1-robh@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/legacy_serial.c          | 8 ++++----
 arch/powerpc/platforms/44x/iss4xx.c          | 2 +-
 arch/powerpc/platforms/44x/ppc476.c          | 2 +-
 arch/powerpc/platforms/cell/spu_manage.c     | 2 +-
 arch/powerpc/platforms/powermac/pic.c        | 3 +--
 arch/powerpc/platforms/powernv/opal-lpc.c    | 2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 arch/powerpc/platforms/pseries/vio.c         | 2 +-
 arch/powerpc/sysdev/mpic_msgr.c              | 2 +-
 9 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index f048c424c525b..1a3b7f3513b40 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -171,11 +171,11 @@ static int __init add_legacy_soc_port(struct device_node *np,
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
 	 */
-	if (of_get_property(np, "clock-frequency", NULL) == NULL)
+	if (!of_property_present(np, "clock-frequency"))
 		return -1;
 
 	/* if reg-offset don't try to use it */
-	if ((of_get_property(np, "reg-offset", NULL) != NULL))
+	if (of_property_present(np, "reg-offset"))
 		return -1;
 
 	/* if rtas uses this device, don't try to use it as well */
@@ -237,7 +237,7 @@ static int __init add_legacy_isa_port(struct device_node *np,
 	 * Note: Don't even try on P8 lpc, we know it's not directly mapped
 	 */
 	if (!of_device_is_compatible(isa_brg, "ibm,power8-lpc") ||
-	    of_get_property(isa_brg, "ranges", NULL)) {
+	    of_property_present(isa_brg, "ranges")) {
 		taddr = of_translate_address(np, reg);
 		if (taddr == OF_BAD_ADDR)
 			taddr = 0;
@@ -268,7 +268,7 @@ static int __init add_legacy_pci_port(struct device_node *np,
 	 * compatible UARTs on PCI need all sort of quirks (port offsets
 	 * etc...) that this code doesn't know about
 	 */
-	if (of_get_property(np, "clock-frequency", NULL) == NULL)
+	if (!of_property_present(np, "clock-frequency"))
 		return -1;
 
 	/* Get the PCI address. Assume BAR 0 */
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
index c5f82591408c1..812765cf06324 100644
--- a/arch/powerpc/platforms/44x/iss4xx.c
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -52,7 +52,7 @@ static void __init iss4xx_init_irq(void)
 
 	/* Find top level interrupt controller */
 	for_each_node_with_property(np, "interrupt-controller") {
-		if (of_get_property(np, "interrupts", NULL) == NULL)
+		if (!of_property_present(np, "interrupts"))
 			break;
 	}
 	if (np == NULL)
diff --git a/arch/powerpc/platforms/44x/ppc476.c b/arch/powerpc/platforms/44x/ppc476.c
index 7c91ac5a5241b..70556fd10f6b4 100644
--- a/arch/powerpc/platforms/44x/ppc476.c
+++ b/arch/powerpc/platforms/44x/ppc476.c
@@ -122,7 +122,7 @@ static void __init ppc47x_init_irq(void)
 
 	/* Find top level interrupt controller */
 	for_each_node_with_property(np, "interrupt-controller") {
-		if (of_get_property(np, "interrupts", NULL) == NULL)
+		if (!of_property_present(np, "interrupts"))
 			break;
 	}
 	if (np == NULL)
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index f1ac4c7420690..74567b32c48c2 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -402,7 +402,7 @@ static int __init of_has_vicinity(void)
 	struct device_node *dn;
 
 	for_each_node_by_type(dn, "spe") {
-		if (of_find_property(dn, "vicinity", NULL))  {
+		if (of_property_present(dn, "vicinity"))  {
 			of_node_put(dn);
 			return 1;
 		}
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 8c8d8e0a7d137..7425f94e271e5 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -475,8 +475,7 @@ static int __init pmac_pic_probe_mpic(void)
 
 	/* We can have up to 2 MPICs cascaded */
 	for_each_node_by_type(np, "open-pic") {
-		if (master == NULL &&
-		    of_get_property(np, "interrupts", NULL) == NULL)
+		if (master == NULL && !of_property_present(np, "interrupts"))
 			master = of_node_get(np);
 		else if (slave == NULL)
 			slave = of_node_get(np);
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index d129d6d45a500..a16f07cdab267 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -403,7 +403,7 @@ void __init opal_lpc_init(void)
 		return;
 
 	/* Does it support direct mapping ? */
-	if (of_get_property(np, "ranges", NULL)) {
+	if (of_property_present(np, "ranges")) {
 		pr_info("OPAL: Found memory mapped LPC bus on chip %d\n",
 			opal_lpc_chip_id);
 		isa_bridge_init_non_pci(np);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 982e5e4b5e065..1a3cb313976a4 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -493,7 +493,7 @@ static bool valid_cpu_drc_index(struct device_node *parent, u32 drc_index)
 	bool found = false;
 	int rc, index;
 
-	if (of_find_property(parent, "ibm,drc-info", NULL))
+	if (of_property_present(parent, "ibm,drc-info"))
 		return drc_info_valid_index(parent, drc_index);
 
 	/* Note that the format of the ibm,drc-indexes array is
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 770df9351aaa9..d54306a936d55 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1440,7 +1440,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	viodev->dev.bus = &vio_bus_type;
 	viodev->dev.release = vio_dev_release;
 
-	if (of_get_property(viodev->dev.of_node, "ibm,my-dma-window", NULL)) {
+	if (of_property_present(viodev->dev.of_node, "ibm,my-dma-window")) {
 		if (firmware_has_feature(FW_FEATURE_CMO))
 			vio_cmo_set_dma_ops(viodev);
 		else
diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index d75064fb7d12f..1a3ac0b5dd89c 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -116,7 +116,7 @@ static unsigned int mpic_msgr_number_of_blocks(void)
 
 		for (;;) {
 			snprintf(buf, sizeof(buf), "mpic-msgr-block%d", count);
-			if (!of_find_property(aliases, buf, NULL))
+			if (!of_property_present(aliases, buf))
 				break;
 
 			count += 1;
-- 
2.39.2

