Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F976B46FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjCJOr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjCJOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:25 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31092118BF4;
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id s41so4363134oiw.13;
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU4f74//gf53K1vpd3AhvqfwdLrPYxnig4GEUDiaPjU=;
        b=sgIw3I4KZrC2qCwuXgNUJAT1O4oACzywPksAUV/EMvC0uESFR9ynLvbNOAeY/Ckzzi
         u6Fiylcx7Rja3voqKo/RYv7BFotQNX93goARzSiHU9bkHMfVYYpfcvUep7WmBAYywBqd
         mfiatcCKTO3v0vYOsPtwGNsWrWf2wK/YiIj9fdBy3lRVlG2L7EGNdFwHxxgai5nNbJpN
         QCWZHtmxf7SooTjXAtu0Bj1q2PMhH6TgLSfH1CNx+Bh89voz750TljhCOs5tvSf0bi1U
         Y4wyJ6i+oMY9/Ql0hJFRn3jbgVagtla8/OJdSt6a3HXaZgKDA+yTP6YuM0PGej28xxDk
         u3hg==
X-Gm-Message-State: AO0yUKW9BVJOJAWsHg/SjYb4mBAE1zGp+iRn07iyEWBVRDgBrmD9+Kk9
        LFyofyWf9AysiV8gTlaPAw==
X-Google-Smtp-Source: AK7set8g5ChVrvUrZVHWfS/XFQBwmKXT9a/z9iAqAnF49+v0LC/ZY5BRlngv8dMqE01moV4WJ/Ypwg==
X-Received: by 2002:a05:6808:357:b0:378:9fca:e5da with SMTP id j23-20020a056808035700b003789fcae5damr12060606oie.53.1678459623345;
        Fri, 10 Mar 2023 06:47:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bl14-20020a056808308e00b00383e12bedebsm961933oib.9.2023.03.10.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:02 -0800 (PST)
Received: (nullmailer pid 1541066 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:46:56 -0600
Message-Id: <20230310144657.1541039-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/legacy_serial.c          | 8 ++++----
 arch/powerpc/platforms/44x/iss4xx.c          | 2 +-
 arch/powerpc/platforms/44x/ppc476.c          | 2 +-
 arch/powerpc/platforms/4xx/pci.c             | 2 +-
 arch/powerpc/platforms/cell/spu_manage.c     | 2 +-
 arch/powerpc/platforms/powermac/pic.c        | 2 +-
 arch/powerpc/platforms/powernv/opal-lpc.c    | 2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 arch/powerpc/platforms/pseries/vio.c         | 2 +-
 arch/powerpc/sysdev/mpic_msgr.c              | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index f048c424c525..1a3b7f3513b4 100644
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
index c5f82591408c..812765cf0632 100644
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
index 7c91ac5a5241..70556fd10f6b 100644
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
diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index ca5dd7a5842a..70a055f76e5a 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -348,7 +348,7 @@ static void __init ppc4xx_probe_pci_bridge(struct device_node *np)
 	}
 
 	/* Check if primary bridge */
-	if (of_get_property(np, "primary", NULL))
+	if (of_property_present(np, "primary"))
 		primary = 1;
 
 	/* Get bus range if any */
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index f1ac4c742069..74567b32c48c 100644
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
index 8c8d8e0a7d13..3425065ab22e 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -476,7 +476,7 @@ static int __init pmac_pic_probe_mpic(void)
 	/* We can have up to 2 MPICs cascaded */
 	for_each_node_by_type(np, "open-pic") {
 		if (master == NULL &&
-		    of_get_property(np, "interrupts", NULL) == NULL)
+		    !of_property_present(np, "interrupts"))
 			master = of_node_get(np);
 		else if (slave == NULL)
 			slave = of_node_get(np);
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index d129d6d45a50..a16f07cdab26 100644
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
index 982e5e4b5e06..1a3cb313976a 100644
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
index 770df9351aaa..d54306a936d5 100644
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
index d75064fb7d12..1a3ac0b5dd89 100644
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

