Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472886C6F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCWRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjCWRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:36:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9AB26C28;
        Thu, 23 Mar 2023 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679592965; x=1711128965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpHE2fMg8kec8Dg0J6kxCepndOofEkKDEHEEamRzDGU=;
  b=GzGSjsSD3EA0o+EAfkQKtvsZ7JIFNc1MxQDrAvzJo4bvrUHTHwISZGcI
   R7NphjuZ9BL6xEV4n7IZLY+EdQCl4a5IwZTvKsYr8bp6AyW0TXyC5xZgL
   zqSnJg1LeIgSp7O4gGQZSaCUITBXRWLu7+ns0x2pYXBxAi0qHLIwM353P
   nyHImLnafguwDl49JhDKyv+c6ffHUNtf/kNm+5Iv5hVkQy/C13c7rffAz
   bTNI29aDK2vuvRhTXznr3sv1fxIokEB3n9c6o5WeIHj4nThpbIl0/5XyY
   hW4B9EDKf0Byi1DnRhs5xZfbiK0ouhN/oWCjvdoSp3o20h6N4oZoT2B/9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="327969675"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="327969675"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="675794213"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="675794213"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2023 10:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8EA329D; Thu, 23 Mar 2023 19:36:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v7 2/6] PCI: Introduce pci_dev_for_each_resource()
Date:   Thu, 23 Mar 2023 19:36:06 +0200
Message-Id: <20230323173610.60442-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230323173610.60442-1-andriy.shevchenko@linux.intel.com>
References: <20230323173610.60442-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

Instead of open-coding it everywhere introduce a tiny helper that can be
used to iterate over each resource of a PCI device, and convert the most
obvious users into it.

While at it drop doubled empty line before pdev_sort_resources().

No functional changes intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---
 .clang-format                             |  1 +
 arch/alpha/kernel/pci.c                   |  5 ++--
 arch/arm/kernel/bios32.c                  | 16 ++++++-------
 arch/arm/mach-dove/pcie.c                 | 10 ++++----
 arch/arm/mach-mv78xx0/pcie.c              | 10 ++++----
 arch/arm/mach-orion5x/pci.c               | 10 ++++----
 arch/mips/pci/ops-bcm63xx.c               |  8 +++----
 arch/mips/pci/pci-legacy.c                |  3 +--
 arch/powerpc/kernel/pci-common.c          | 21 ++++++++--------
 arch/powerpc/platforms/4xx/pci.c          |  8 +++----
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |  5 ++--
 arch/powerpc/platforms/pseries/pci.c      | 16 ++++++-------
 arch/sh/drivers/pci/pcie-sh7786.c         | 10 ++++----
 arch/sparc/kernel/leon_pci.c              |  5 ++--
 arch/sparc/kernel/pci.c                   | 10 ++++----
 arch/sparc/kernel/pcic.c                  |  5 ++--
 drivers/pci/remove.c                      |  5 ++--
 drivers/pci/setup-bus.c                   | 27 ++++++++-------------
 drivers/pci/setup-res.c                   |  4 +---
 drivers/pci/vgaarb.c                      | 17 ++++---------
 drivers/pci/xen-pcifront.c                |  4 +---
 drivers/pnp/quirks.c                      | 29 ++++++++---------------
 include/linux/pci.h                       | 16 +++++++++++++
 23 files changed, 113 insertions(+), 132 deletions(-)

diff --git a/.clang-format b/.clang-format
index d988e9fa9b26..2048b0296d76 100644
--- a/.clang-format
+++ b/.clang-format
@@ -520,6 +520,7 @@ ForEachMacros:
   - 'of_property_for_each_string'
   - 'of_property_for_each_u32'
   - 'pci_bus_for_each_resource'
+  - 'pci_dev_for_each_resource'
   - 'pci_doe_for_each_off'
   - 'pcl_for_each_chunk'
   - 'pcl_for_each_segment'
diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 64fbfb0763b2..4458eb7f44f0 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -288,11 +288,10 @@ pcibios_claim_one_bus(struct pci_bus *b)
 	struct pci_bus *child_bus;
 
 	list_for_each_entry(dev, &b->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 			if (pci_has_flag(PCI_PROBE_ONLY) ||
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e7ef2b5bea9c..d334c7fb672b 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -142,15 +142,15 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND2, PCI_DEVICE_ID_WINBOND2_89C940F,
  */
 static void pci_fixup_dec21285(struct pci_dev *dev)
 {
-	int i;
-
 	if (dev->devfn == 0) {
+		struct resource *r;
+
 		dev->class &= 0xff;
 		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start = 0;
+			r->end = 0;
+			r->flags = 0;
 		}
 	}
 }
@@ -162,13 +162,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, pci_fixup_d
 static void pci_fixup_ide_bases(struct pci_dev *dev)
 {
 	struct resource *r;
-	int i;
 
 	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = dev->resource + i;
+	pci_dev_for_each_resource(dev, r) {
 		if ((r->start & ~0x80) == 0x374) {
 			r->start |= 2;
 			r->end = r->start;
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 754ca381f600..3044b7e03890 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -142,14 +142,14 @@ static struct pci_ops pcie_ops = {
 static void rc_pci_fixup(struct pci_dev *dev)
 {
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
-		int i;
+		struct resource *r;
 
 		dev->class &= 0xff;
 		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start = 0;
+			r->end   = 0;
+			r->flags = 0;
 		}
 	}
 }
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 6190f538a124..0ebc909ea273 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -186,14 +186,14 @@ static struct pci_ops pcie_ops = {
 static void rc_pci_fixup(struct pci_dev *dev)
 {
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
-		int i;
+		struct resource *r;
 
 		dev->class &= 0xff;
 		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start = 0;
+			r->end   = 0;
+			r->flags = 0;
 		}
 	}
 }
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 888fdc9099c5..3313bc5a63ea 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -522,14 +522,14 @@ static int __init pci_setup(struct pci_sys_data *sys)
 static void rc_pci_fixup(struct pci_dev *dev)
 {
 	if (dev->bus->parent == NULL && dev->devfn == 0) {
-		int i;
+		struct resource *r;
 
 		dev->class &= 0xff;
 		dev->class |= PCI_CLASS_BRIDGE_HOST << 8;
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end   = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start	= 0;
+			r->end		= 0;
+			r->flags	= 0;
 		}
 	}
 }
diff --git a/arch/mips/pci/ops-bcm63xx.c b/arch/mips/pci/ops-bcm63xx.c
index dc6dc2741272..b0ea023c47c0 100644
--- a/arch/mips/pci/ops-bcm63xx.c
+++ b/arch/mips/pci/ops-bcm63xx.c
@@ -413,18 +413,18 @@ struct pci_ops bcm63xx_cb_ops = {
 static void bcm63xx_fixup(struct pci_dev *dev)
 {
 	static int io_window = -1;
-	int i, found, new_io_window;
+	int found, new_io_window;
+	struct resource *r;
 	u32 val;
 
 	/* look for any io resource */
 	found = 0;
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
+	pci_dev_for_each_resource(dev, r) {
+		if (resource_type(r) == IORESOURCE_IO) {
 			found = 1;
 			break;
 		}
 	}
-
 	if (!found)
 		return;
 
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 468722c8a5c6..ec2567f8efd8 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -249,12 +249,11 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
-	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+	pci_dev_for_each_resource(dev, r, idx) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<idx)))
 			continue;
 
-		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((idx == PCI_ROM_RESOURCE) &&
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d67cf79bf5d0..e88d7c9feeec 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -880,6 +880,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 static void pcibios_fixup_resources(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct resource *res;
 	int i;
 
 	if (!hose) {
@@ -891,9 +892,9 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 	if (dev->is_virtfn)
 		return;
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		struct resource *res = dev->resource + i;
+	pci_dev_for_each_resource(dev, res, i) {
 		struct pci_bus_region reg;
+
 		if (!res->flags)
 			continue;
 
@@ -1452,11 +1453,10 @@ void pcibios_claim_one_bus(struct pci_bus *bus)
 	struct pci_bus *child_bus;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 
@@ -1705,19 +1705,20 @@ EXPORT_SYMBOL_GPL(pcibios_scan_phb);
 
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
-	int i, class = dev->class >> 8;
+	int class = dev->class >> 8;
 	/* When configured as agent, programming interface = 1 */
 	int prog_if = dev->class & 0xf;
+	struct resource *r;
 
 	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
 	     class == PCI_CLASS_BRIDGE_OTHER) &&
 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
 		(prog_if == 0) &&
 		(dev->bus->parent == NULL)) {
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start = 0;
-			dev->resource[i].end = 0;
-			dev->resource[i].flags = 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start = 0;
+			r->end = 0;
+			r->flags = 0;
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index ca5dd7a5842a..07dcc2b8007f 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -57,7 +57,7 @@ static inline int ppc440spe_revA(void)
 static void fixup_ppc4xx_pci_bridge(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
-	int i;
+	struct resource *r;
 
 	if (dev->devfn != 0 || dev->bus->self != NULL)
 		return;
@@ -79,9 +79,9 @@ static void fixup_ppc4xx_pci_bridge(struct pci_dev *dev)
 	/* Hide the PCI host BARs from the kernel as their content doesn't
 	 * fit well in the resource management
 	 */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		dev->resource[i].start = dev->resource[i].end = 0;
-		dev->resource[i].flags = 0;
+	pci_dev_for_each_resource(dev, r) {
+		r->start = r->end = 0;
+		r->flags = 0;
 	}
 
 	printk(KERN_INFO "PCI: Hiding 4xx host bridge resources %s\n",
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 859e2818c43d..0ca4401ba781 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -327,14 +327,13 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 static void
 mpc52xx_pci_fixup_resources(struct pci_dev *dev)
 {
-	int i;
+	struct resource *res;
 
 	pr_debug("%s() %.4x:%.4x\n", __func__, dev->vendor, dev->device);
 
 	/* We don't rely on boot loader for PCI and resets all
 	   devices */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		struct resource *res = &dev->resource[i];
+	pci_dev_for_each_resource(dev, res) {
 		if (res->end > res->start) {	/* Only valid resources */
 			res->end -= res->start;
 			res->start = 0;
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 60e0a58928ef..1772ae3d193d 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -240,7 +240,7 @@ void __init pSeries_final_fixup(void)
  */
 static void fixup_winbond_82c105(struct pci_dev* dev)
 {
-	int i;
+	struct resource *r;
 	unsigned int reg;
 
 	if (!machine_is(pseries))
@@ -251,14 +251,14 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
 	/* Enable LEGIRQ to use INTC instead of ISA interrupts */
 	pci_write_config_dword(dev, 0x40, reg | (1<<11));
 
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
+	pci_dev_for_each_resource(dev, r) {
 		/* zap the 2nd function of the winbond chip */
-		if (dev->resource[i].flags & IORESOURCE_IO
-		    && dev->bus->number == 0 && dev->devfn == 0x81)
-			dev->resource[i].flags &= ~IORESOURCE_IO;
-		if (dev->resource[i].start == 0 && dev->resource[i].end) {
-			dev->resource[i].flags = 0;
-			dev->resource[i].end = 0;
+		if (dev->bus->number == 0 && dev->devfn == 0x81 &&
+		    r->flags & IORESOURCE_IO)
+			r->flags &= ~IORESOURCE_IO;
+		if (r->start == 0 && r->end) {
+			r->flags = 0;
+			r->end = 0;
 		}
 	}
 }
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index b0c2a5238d04..4f5e49f10805 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -140,12 +140,12 @@ static void sh7786_pci_fixup(struct pci_dev *dev)
 	 * Prevent enumeration of root complex resources.
 	 */
 	if (pci_is_root_bus(dev->bus) && dev->devfn == 0) {
-		int i;
+		struct resource *r;
 
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			dev->resource[i].start	= 0;
-			dev->resource[i].end	= 0;
-			dev->resource[i].flags	= 0;
+		pci_dev_for_each_resource(dev, r) {
+			r->start	= 0;
+			r->end		= 0;
+			r->flags	= 0;
 		}
 	}
 }
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index e5e5ff6b9a5c..b6663a3fbae9 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -62,15 +62,14 @@ void leon_pci_init(struct platform_device *ofdev, struct leon_pci_info *info)
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cb1ef25116e9..a948a49817c7 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -663,11 +663,10 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
-
+		pci_dev_for_each_resource(dev, r, i) {
 			if (r->parent || !r->start || !r->flags)
 				continue;
 
@@ -724,15 +723,14 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index ee4c9a9a171c..25fe0a061732 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -643,15 +643,14 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	struct resource *res;
 	u16 cmd, oldcmd;
 	int i;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	oldcmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, res, i) {
 		/* Only set up the requested stuff */
 		if (!(mask & (1<<i)))
 			continue;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 0145aef1b930..c049eddc1e2f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -5,10 +5,9 @@
 
 static void pci_free_resources(struct pci_dev *dev)
 {
-	int i;
+	struct resource *res;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
+	pci_dev_for_each_resource(dev, res) {
 		if (res->parent)
 			release_resource(res);
 	}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c690572b10ce..027b985dd1ee 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -124,20 +124,17 @@ static resource_size_t get_res_add_align(struct list_head *head,
 	return dev_res ? dev_res->min_align : 0;
 }
 
-
 /* Sort resources by alignment */
 static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
+	struct resource *r;
 	int i;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *r;
+	pci_dev_for_each_resource(dev, r, i) {
 		struct pci_dev_resource *dev_res, *tmp;
 		resource_size_t r_align;
 		struct list_head *n;
 
-		r = &dev->resource[i];
-
 		if (r->flags & IORESOURCE_PCI_FIXED)
 			continue;
 
@@ -895,10 +892,9 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		int i;
+		struct resource *r;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
+		pci_dev_for_each_resource(dev, r) {
 			unsigned long r_size;
 
 			if (r->parent || !(r->flags & IORESOURCE_IO))
@@ -1014,10 +1010,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	size = 0;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
 		int i;
 
-		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-			struct resource *r = &dev->resource[i];
+		pci_dev_for_each_resource(dev, r, i) {
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
@@ -1358,11 +1354,10 @@ static void assign_fixed_resource_on_bus(struct pci_bus *b, struct resource *r)
  */
 static void pdev_assign_fixed_resources(struct pci_dev *dev)
 {
-	int i;
+	struct resource *r;
 
-	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
+	pci_dev_for_each_resource(dev, r) {
 		struct pci_bus *b;
-		struct resource *r = &dev->resource[i];
 
 		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
 		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
@@ -1795,11 +1790,9 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
 				 struct resource *mmio,
 				 struct resource *mmio_pref)
 {
-	int i;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
+	struct resource *res;
 
+	pci_dev_for_each_resource(dev, res) {
 		if (resource_type(res) == IORESOURCE_IO) {
 			remove_dev_resource(io, dev, res);
 		} else if (resource_type(res) == IORESOURCE_MEM) {
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index b492e67c3d87..967f9a758923 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -484,12 +484,10 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+	pci_dev_for_each_resource(dev, r, i) {
 		if (!(mask & (1 << i)))
 			continue;
 
-		r = &dev->resource[i];
-
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
 		if ((i == PCI_ROM_RESOURCE) &&
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index f80b6ec88dc3..5a696078b382 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -548,10 +548,8 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 #if defined(CONFIG_X86) || defined(CONFIG_IA64)
 	u64 base = screen_info.lfb_base;
 	u64 size = screen_info.lfb_size;
+	struct resource *r;
 	u64 limit;
-	resource_size_t start, end;
-	unsigned long flags;
-	int i;
 
 	/* Select the device owning the boot framebuffer if there is one */
 
@@ -561,19 +559,14 @@ static bool vga_is_firmware_default(struct pci_dev *pdev)
 	limit = base + size;
 
 	/* Does firmware framebuffer belong to us? */
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		flags = pci_resource_flags(pdev, i);
-
-		if ((flags & IORESOURCE_MEM) == 0)
+	pci_dev_for_each_resource(pdev, r) {
+		if (resource_type(r) != IORESOURCE_MEM)
 			continue;
 
-		start = pci_resource_start(pdev, i);
-		end  = pci_resource_end(pdev, i);
-
-		if (!start || !end)
+		if (!r->start || !r->end)
 			continue;
 
-		if (base < start || limit >= end)
+		if (base < r->start || limit >= r->end)
 			continue;
 
 		return true;
diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index fcd029ca2eb1..83c0ab50676d 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -390,9 +390,7 @@ static int pcifront_claim_resource(struct pci_dev *dev, void *data)
 	int i;
 	struct resource *r;
 
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		r = &dev->resource[i];
-
+	pci_dev_for_each_resource(dev, r, i) {
 		if (!r->parent && r->start && r->flags) {
 			dev_info(&pdev->xdev->dev, "claiming resource %s/%d\n",
 				pci_name(dev), i);
diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index ac98b9919029..6085a1471de2 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -229,8 +229,7 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 static void quirk_system_pci_resources(struct pnp_dev *dev)
 {
 	struct pci_dev *pdev = NULL;
-	struct resource *res;
-	resource_size_t pnp_start, pnp_end, pci_start, pci_end;
+	struct resource *res, *r;
 	int i, j;
 
 	/*
@@ -243,32 +242,26 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 	 * so they won't be claimed by the PNP system driver.
 	 */
 	for_each_pci_dev(pdev) {
-		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-			unsigned long flags, type;
+		pci_dev_for_each_resource(pdev, r, i) {
+			unsigned long type = resource_type(r);
 
-			flags = pci_resource_flags(pdev, i);
-			type = flags & (IORESOURCE_IO | IORESOURCE_MEM);
-			if (!type || pci_resource_len(pdev, i) == 0)
+			if (!(type == IORESOURCE_IO || type == IORESOURCE_MEM) ||
+			    resource_size(r) == 0)
 				continue;
 
-			if (flags & IORESOURCE_UNSET)
+			if (r->flags & IORESOURCE_UNSET)
 				continue;
 
-			pci_start = pci_resource_start(pdev, i);
-			pci_end = pci_resource_end(pdev, i);
 			for (j = 0;
 			     (res = pnp_get_resource(dev, type, j)); j++) {
 				if (res->start == 0 && res->end == 0)
 					continue;
 
-				pnp_start = res->start;
-				pnp_end = res->end;
-
 				/*
 				 * If the PNP region doesn't overlap the PCI
 				 * region at all, there's no problem.
 				 */
-				if (pnp_end < pci_start || pnp_start > pci_end)
+				if (!resource_overlaps(res, r))
 					continue;
 
 				/*
@@ -278,8 +271,7 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 				 * PNP device describes a bridge with PCI
 				 * behind it.
 				 */
-				if (pnp_start <= pci_start &&
-				    pnp_end >= pci_end)
+				if (res->start <= r->start && res->end >= r->end)
 					continue;
 
 				/*
@@ -288,9 +280,8 @@ static void quirk_system_pci_resources(struct pnp_dev *dev)
 				 * driver from requesting its resources.
 				 */
 				dev_warn(&dev->dev,
-					 "disabling %pR because it overlaps "
-					 "%s BAR %d %pR\n", res,
-					 pci_name(pdev), i, &pdev->resource[i]);
+					 "disabling %pR because it overlaps %s BAR %d %pR\n",
+					 res, pci_name(pdev), i, r);
 				res->flags |= IORESOURCE_DISABLED;
 			}
 		}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b50e5c79f7e3..e1277a2bb645 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -26,6 +26,7 @@
 
 #include <linux/mod_devicetable.h>
 
+#include <linux/args.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -1995,6 +1996,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
  * These helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info
  */
+#define pci_resource_n(dev, bar)	(&(dev)->resource[(bar)])
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
 #define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
 #define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
@@ -2004,6 +2006,20 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 	 (pci_resource_end((dev), (bar)) -		\
 	  pci_resource_start((dev), (bar)) + 1))
 
+#define __pci_dev_for_each_resource_0(dev, res, ...)			\
+	for (unsigned int __b = 0;					\
+	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
+	     __b++)
+
+#define __pci_dev_for_each_resource_1(dev, res, __b)			\
+	for (__b = 0;							\
+	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
+	     __b++)
+
+#define pci_dev_for_each_resource(dev, res, ...)			   \
+	CONCATENATE(__pci_dev_for_each_resource_, COUNT_ARGS(__VA_ARGS__)) \
+		    (dev, res, __VA_ARGS__)
+
 /*
  * Similar to the helpers above, these manipulate per-pci_dev
  * driver-specific data.  They are really just a wrapper around
-- 
2.40.0.1.gaa8946217a0b

