Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2956F390B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjEAUOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEAUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:14:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868B30C5
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 13:14:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8aea2a654so28395351fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682972073; x=1685564073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F36MPH23paVmBGSmxmn9RmQiUOeoap4Sfmdw21UVa9w=;
        b=hk0WDqikTg2XGL+FpwM+aTOKR4jbi/roZyK5FgLMu/jJ50UrMvaTMwVhRZumNVwh7m
         1WoLymy7oFg400Vbv7Sq9g3KlnpBaz/HaSozcpgKnQ0EB/31+q0iLmOJa9sIc4iFEbHf
         H2r/tDKzpWljf/pWgi+9tlWaoZnPCiBVvxs7Mm4A/sLi835BqyQvHFHhJ31e/iP6ER/r
         AhfGGpPMj/Zztden6TuiR4lZM6YifLa/b4zFDGl6swRh7K72Wef98mBUzoudJ8ypTwOq
         Pp6zD1RskqO5gr6X3Ps9LrepQNOgKQIdo5cFTnoNchg0RPTgehIlBYVIpPjUzEbTgR4r
         CTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682972073; x=1685564073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F36MPH23paVmBGSmxmn9RmQiUOeoap4Sfmdw21UVa9w=;
        b=g4+Jl5MtjzeWBZ4OEfd8xZ1oSMu4Ajspj8n7yXsZlLrip5/SMdFg7f07osIi1yyLdG
         SB/2ZUeRyH3v/6ILUBkqYXmwndxOI+W4BhPApNsTMQw27VewPKbEeGN14LpWPmtufffa
         JbNc9NkDGSTb/7moGVmNBdKQ7zZiO0ARKu9vUpmOwUO5p+lkokQrsMMIPn71pWTtvDZP
         C33YQexvWE4B5l8+Rs8rBQAl9pNt5czP5e81NK64+v5f7U32LYABlz1N/77FROJXJQVA
         a7EltO3/5ttETpoRVULRC1tZhI4+Uzqh/uSZP4FJKF7CqMEghmudz6HKrtwOVqeDYnA8
         5iIw==
X-Gm-Message-State: AC+VfDyxTZTHyrUUbJ5x194GT1fD/+IquR27RPJ6bKHEkPsP/jkvK4I2
        NC/5gJdK5xApNW1oGXpeJCydOxbd0iFL7FHf
X-Google-Smtp-Source: ACHHUZ42hKW3WLegKTjJHohYj65AW8/to+vWy6xwVxsg+RIq9U/FylkCWoQ6ielBpCOCWBv1yIGzaw==
X-Received: by 2002:a05:651c:10c:b0:2a7:6b95:1d62 with SMTP id a12-20020a05651c010c00b002a76b951d62mr3689434ljb.52.1682972073208;
        Mon, 01 May 2023 13:14:33 -0700 (PDT)
Received: from localhost.localdomain ([165.231.178.21])
        by smtp.gmail.com with ESMTPSA id f22-20020a2e9196000000b002a483f01d9csm4868041ljg.85.2023.05.01.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:14:32 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shawn.lin@rock-chips.com, lpieralisi@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Dan Johansen <strit@manjaro.org>
Subject: [PATCH v1] drivers: pci: introduce configurable delay for Rockchip PCIe bus scan
Date:   Mon,  1 May 2023 22:14:26 +0200
Message-Id: <20230501201426.1214125-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable delay to the Rockchip PCIe driver to address
crashes that occur on some old devices, such as the Pine64 RockPro64.

This issue is affecting the ARM community, but there is no
upstream solution for it yet.

The crash I worked on is described below.

Co-Developed-by: Dan Johansen <strit@manjaro.org>
Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Crash dump (customized Manjaro kernel before this patch):
[    1.229856] SError Interrupt on CPU4, code 0xbf000002 -- SError
[    1.229860] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJARO-ARM #1
[    1.229862] Hardware name: Pine64 RockPro64 v2.1 (DT)
[    1.229864] pstate: 60000085 (nZCv daIf -PAN -UAO BTYPE=--)
[    1.229866] pc : rockchip_pcie_rd_conf+0xb4/0x270
[    1.229868] lr : rockchip_pcie_rd_conf+0x1b4/0x270
[    1.229870] sp : ffff80001004b850
[    1.229872] x29: ffff80001004b850 x28: 0000000000000001
[    1.229877] x27: 0000000000000000 x26: ffff00007a795000
[    1.229882] x25: ffff00007a7910b0 x24: 0000000000000000
[    1.229887] x23: 0000000000000000 x22: ffff00007b3a4380
[    1.229891] x21: ffff80001004b8c4 x20: 0000000000000004
[    1.229895] x19: 0000000000100000 x18: 0000000000000020
[    1.229900] x17: 0000000000000001 x16: 0000000000000019
[    1.229904] x15: ffff00007b222fd8 x14: ffffffffffffffff
[    1.229908] x13: ffff00007a79ba1c x12: ffff00007a79b290
[    1.229912] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[    1.229917] x9 : ff72646268756463 x8 : 0000000000000391
[    1.229921] x7 : ffff80001004b880 x6 : 0000000000000001
[    1.229925] x5 : 0000000000000000 x4 : 0000000000000000
[    1.229930] x3 : 0000000000c00008 x2 : 000000000080000a
[    1.229934] x1 : 0000000000000000 x0 : ffff800014000000
[    1.229939] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.229942] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.9.9-2.0-MANJARO-ARM #1
[    1.229944] Hardware name: Pine64 RockPro64 v2.1 (DT)
[    1.229946] Call trace:
[    1.229948]  dump_backtrace+0x0/0x1d0
[    1.229949]  show_stack+0x18/0x24
[    1.229951]  dump_stack+0xc0/0x118
[    1.229953]  panic+0x148/0x320
[    1.229955]  nmi_panic+0x8c/0x90
[    1.229956]  arm64_serror_panic+0x78/0x84
[    1.229958]  do_serror+0x15c/0x160
[    1.229960]  el1_error+0x84/0x100
[    1.229962]  rockchip_pcie_rd_conf+0xb4/0x270
[    1.229964]  pci_bus_read_config_dword+0x6c/0xd0
[    1.229966]  pci_bus_generic_read_dev_vendor_id+0x34/0x1b0
[    1.229968]  pci_scan_single_device+0xa4/0x144
[    1.229970]  pci_scan_slot+0x40/0x12c
[    1.229972]  pci_scan_child_bus_extend+0x58/0x34c
[    1.229974]  pci_scan_bridge_extend+0x310/0x590
[    1.229976]  pci_scan_child_bus_extend+0x210/0x34c
[    1.229978]  pci_scan_root_bus_bridge+0x68/0xdc
[    1.229980]  pci_host_probe+0x18/0xc4
[    1.229981]  rockchip_pcie_probe+0x204/0x330
[    1.229984]  platform_drv_probe+0x54/0xb0
[    1.229985]  really_probe+0xe8/0x500
[    1.229987]  driver_probe_device+0xd8/0xf0
[    1.229989]  device_driver_attach+0xc0/0xcc
[    1.229991]  __driver_attach+0xa4/0x170
[    1.229993]  bus_for_each_dev+0x70/0xc0
[    1.229994]  driver_attach+0x24/0x30
[    1.229996]  bus_add_driver+0x140/0x234
[    1.229998]  driver_register+0x78/0x130
[    1.230000]  __platform_driver_register+0x4c/0x60
[    1.230002]  rockchip_pcie_driver_init+0x1c/0x28
[    1.230004]  do_one_initcall+0x54/0x1c0
[    1.230005]  do_initcalls+0xf4/0x130
[    1.230007]  kernel_init_freeable+0x144/0x19c
[    1.230009]  kernel_init+0x14/0x11c
[    1.230011]  ret_from_fork+0x10/0x34
[    1.230035] SMP: stopping secondary CPUs
[    1.230037] Kernel Offset: disabled
[    1.230039] CPU features: 0x0240022,2100200c
[    1.230041] Memory Limit: none
---
 .../admin-guide/kernel-parameters.txt         |  8 +++++
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  3 +-
 drivers/pci/controller/pcie-rockchip-host.c   | 31 +++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.c        |  5 +++
 drivers/pci/controller/pcie-rockchip.h        | 10 ++++++
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7016cb12dc4e..3f0e0d670126 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4286,6 +4286,14 @@
 				any pair of devices, possibly at the cost of
 				reduced performance.  This also guarantees
 				that hot-added devices will work.
+		pcie_rockchip_host.bus_scan_delay=	[PCIE] Delay in ms before
+			scanning PCIe bus in Rockchip PCIe host driver. Some PCIe
+			cards seem to need delays that can be several hundred ms.
+			If set to greater than or equal to 0 this parameter will
+			override delay that can be set in device tree.
+			Values less than 0 the module will hit an assertion
+			during the init.
+			The default value is 0.
 		cbiosize=nn[KMG]	The fixed amount of bus space which is
 				reserved for the CardBus bridge's IO window.
 				The default value is 256 bytes.
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index bca2b50e0a93..95a4623b8c18 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -663,7 +663,8 @@ &pcie0 {
 	pinctrl-0 = <&pcie_perst>;
 	vpcie12v-supply = <&vcc12v_dcin>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
-	status = "okay";
+    bus-scan-delay-ms = <0>;
+    status = "okay";
 };
 
 &pcie_phy {
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index c96c0f454570..b97f3102a628 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -38,6 +38,10 @@
 #include "../pci.h"
 #include "pcie-rockchip.h"
 
+/* bus_scan_delay - module parameter to override the
+ * device tree value, which is 0 by default. */
+static int bus_scan_delay = -1;
+
 static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
@@ -931,6 +935,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
+	/* It seems that the driver crashes on some
+	 * older devices. To work around this, we
+	 * should add a sleep delay before probing.
+	 **/
+	u32 prob_delay;
 	int err;
 
 	if (!dev->of_node)
@@ -987,6 +996,23 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	rockchip_pcie_enable_interrupts(rockchip);
 
+	prob_delay = rockchip->bus_scan_delay;
+	if (bus_scan_delay)
+		prob_delay = bus_scan_delay;
+
+	/*
+	 * FIXME: This is a workaround for some devices that crash on calls to pci_host_probe()
+	 * or pci_scan_root_bus_bridge(). We add a delay before bus scanning to avoid the crash.
+	 * The call trace reaches rockchip_pcie_rd_conf() while attempting to read the vendor ID
+	 * (pci_bus_generic_read_dev_vendor_id() is in the call stack) before panicking.
+	 *
+	 * I'm not sure why this workaround is effective or what causes the panic. It may be related
+	 * to the cansleep value.
+	 */
+	dev_info(dev, "wait %u ms before bus scan\n", prob_delay);
+	if (prob_delay > 0)
+		msleep(prob_delay);
+
 	err = pci_host_probe(bridge);
 	if (err < 0)
 		goto err_remove_irq_domain;
@@ -1055,6 +1081,11 @@ static struct platform_driver rockchip_pcie_driver = {
 };
 module_platform_driver(rockchip_pcie_driver);
 
+/** Allow to override the device tree default configuration with
+ * a command line argument.
+ **/
+module_param_named(bus_scan_delay, bus_scan_delay, int, S_IRUGO);
+
 MODULE_AUTHOR("Rockchip Inc");
 MODULE_DESCRIPTION("Rockchip AXI PCIe driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 990a00e08bc5..7350be04f662 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -149,6 +149,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->clk_pcie_pm);
 	}
 
+	err = of_property_read_u32(node, "bus-scan-delay-ms", &rockchip->bus_scan_delay);
+	if (err) {
+		dev_info(dev, "no bus scan delay, default to 0 ms\n");
+		rockchip->bus_scan_delay = 0;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 32c3a859c26b..76503dde6099 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -299,6 +299,16 @@ struct rockchip_pcie {
 	phys_addr_t msg_bus_addr;
 	bool is_rc;
 	struct resource *mem_res;
+
+	/* It seems that the driver crashes on some
+	 * older devices. To work around this, we
+	 * should add a sleep delay before probing.
+	 *
+	 * FIXME: need more investigated with an,
+	 * but looks like the problem can be related with
+	 * the cansleep value?
+	 **/
+	u32 bus_scan_delay;
 };
 
 static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
-- 
2.40.1

