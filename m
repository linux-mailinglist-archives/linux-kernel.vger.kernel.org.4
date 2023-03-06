Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE51D6AB457
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCFBdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:32:59 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0935A1;
        Sun,  5 Mar 2023 17:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDwkThkELRWHbMjCSbFctwhqv+CsUnTl1oE9R1kSl44kv57g22nCz2lpU6oQyyQJw4BKFUov7UqlfCYhhumP5lUIEtqdrx1wbLr8S57Ou+j+C5bbYpuzWTAzBuQdSVdB8ir2C1jg7nCsPMxSW1WCHjtqua4d3VGtU1suaWFbpaEkof++mIhbZTTsb91BXYAReEOMgSpBM7vxnQzy3uGVGXTim4fQBy7Vnp9nnqnxCKsCjU+GY8jm1kIxOwKcf3R8JpWvWLg5l0GcD0cpFCzUkU+Nte2N5Bj2lMMGrxAEFTlEzBGZAC6Tk5+f9gD+Cr8HcYGM3uOaa/2yKZbOAl55TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO42unP8OkNW0TNes6UkYnxHK+u9CDmjMEALbAkpbrQ=;
 b=S8eDnwmZxKcs/DnMIjWDaudTkA4IZS5O15LhFIq8ACZ0p73w4gYSq/T2J3DOmbiB5CFtTicH26ooabvCc6Ua81IyH+FiSyuEEZJF7IQ9CKIlUPzV1GfNZnbdNlgqcGXxP0PSEMDHqgwGbe58DLDkRawX5chnQWbrzGFHtWk7ojzW0dAaFG1FMYog8Y1tQHoUP6tA+/SD7qH9//gYAgQUhq0Ghq7J84mPG85Okm4JtDqJ4eaFRL0a2InZseyq3o+Kjl8LTh7RG4n12CPGhlo7OCC3YmYJkEVo80j3xexerXbbcm0wpA8utfvbJhQueT8UYqP3ehriOQj9kuO7SJptiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO42unP8OkNW0TNes6UkYnxHK+u9CDmjMEALbAkpbrQ=;
 b=PKmnIpLVV8kVsD19WXzLzXHw0L59HEcYKU7HFSEG52WNWxjLejwDsN7b4UoSBtmjsrKH61HmpLQ1fs2EJvVKRA9cfzaqQmFRXAx60yND30Y8fG+QJsHKTmJ4qnVXVJHHw1gbkJwWJRnLS034CqicWwtEvOQ/jycV7wQubPoz1lEYDSO0wyoMsm+kn0MSZL3uwzdnpDWzZBAD4bC0ZXTFrypCl/vBFGdFFg85JYkfaqNSnxci1HF+y603A+3bsYMmODwC9mKEP1WJMHRz/ujRSa2JfsKZ3sJw+kIR9ygTtoTbR4TyO3HmKwtlVIdKL0wYi4viCFlo2njiHD3YaqEzZA==
Received: from CY8PR11CA0011.namprd11.prod.outlook.com (2603:10b6:930:48::16)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 01:32:55 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::46) by CY8PR11CA0011.outlook.office365.com
 (2603:10b6:930:48::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 01:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.4 via Frontend Transport; Mon, 6 Mar 2023 01:32:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 5 Mar 2023
 17:32:42 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 5 Mar 2023
 17:32:41 -0800
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sun, 5 Mar 2023 17:32:41 -0800
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
Date:   Sun, 5 Mar 2023 19:31:48 -0600
Message-ID: <20230306013148.3483335-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|SA1PR12MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 113fbd35-dc2e-4464-195d-08db1de2b56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rn0tzr7OyAU7k9i+AuDE3oik8KyvDs5Zh9R1at6Py5uUwN500dngtTCUAHAWzO1jQMR71ucly/Jv7Gc65PeZGLhpvy1rXIAc6UzAjwLaK0omv/XZFeUmBfYczBIOupcrvMPIQMzXNE2Tc2fo0p6Zp96WjIZHqAUFCiPFTJC6LTKCqeNKi1kuNfqiEVZXjK5HrMrIORzRwjmebjoK/oXTA1ssWXLfUgLSxfEYUeRM6V+UWvelwX22XFgr43gAkilw3GsvUXZkjgE+yiXtPc9atxkc/903gGzMrQBtI0G98AIQwFD6I4AIyDjnEMhU7R0750b63E5YQQq5e6MkFf4w/exm+58bMN15NBg2PTK/f0bSYuEhNBXm5vGqjRlLUrlzWZYDHzIGyM3yzNQ/g0D/bnSe4OxrwCrMeh4nXfhF7SjAX120AJaqxWL8hQIaGkHzYQMG8C16sdx5LCYR9qhESIfIRxv9Bl2lMXuo5sX3zlb2P12hkUTkAnkZBTqTteDQWC14RJ3LKC5F0fdtmtwWT9hC6o3yDygsJgxzeAZTtqkmGsO8btH7SqqnDewq+iACxlQDVsyJuK/XMgwA9q6i670Dm62fTtp38c+4/uIIfSL6PD9hSBdDG/7K+ztaSMgX8LrArH1sAO9nPe7ehfRTvrJ9oS1MzhL/ZeP8Uyy+R/ODrXo1O1CUU1W2xEck8+T4OGK6T3tq0qxOTzH5GO+0xA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(86362001)(82740400003)(7636003)(356005)(36756003)(2906002)(30864003)(5660300002)(4326008)(70586007)(70206006)(40480700001)(8676002)(8936002)(41300700001)(82310400005)(40460700003)(2616005)(336012)(26005)(186003)(83380400001)(47076005)(426003)(110136005)(54906003)(478600001)(316002)(1076003)(107886003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 01:32:54.5108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113fbd35-dc2e-4464-195d-08db1de2b56f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch is to address the T241 erratum T241-FABRIC-4,
which causes unexpected behavior in the GIC when multiple transactions
are received simultaneously from different sources. This hardware issue
impacts NVIDIA server platforms that use more than two T241 chips
interconnected. Each chip has support for 320 {E}SPIs.

This issue occurs when multiple packets from different GICs are
incorrectly interleaved at the target chip. The erratum text below
specifies exactly what can cause multiple transfer packets susceptible
to interleaving and GIC state corruption. GIC state corruption can
lead to a range of problems, including kernel panics, and unexpected
behavior.

From the erratum text:
  "In some cases, inter-socket AXI4 Stream packets with multiple
  transfers, may be interleaved by the fabric when presented to ARM
  Generic Interrupt Controller. GIC expects all transfers of a packet
  to be delivered without any interleaving.

  The following GICv3 commands may result in multiple transfer packets
  over inter-socket AXI4 Stream interface:
   - Register reads from GICD_I* and GICD_N*
   - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
   - ITS command MOVALL

  Multiple commands in GICv4+ utilize multiple transfer packets,
  including VMOVP, VMOVI and VMAPP.

  This issue impacts system configurations with more than 2 sockets,
  that require multi-transfer packets to be sent over inter-socket
  AXI4 Stream interface between GIC instances on different sockets.
  GICv4 cannot be supported. GICv3 SW model can only be supported
  with the workaround. Single and Dual socket configurations are not
  impacted by this issue and support GICv3 and GICv4."

To fix this problem, the patch implements a workaround that ensures
read accesses to the GICD_In{E} registers are directed to the chip
that owns the SPI, and disables GICv4.x features for KVM.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
---
 Documentation/arm64/silicon-errata.rst |   2 +
 drivers/irqchip/irq-gic-common.c       |  10 +-
 drivers/irqchip/irq-gic-common.h       |   3 +-
 drivers/irqchip/irq-gic-v3.c           | 124 +++++++++++++++++++++++--
 drivers/irqchip/irq-gic.c              |   3 +-
 drivers/irqchip/irq-hip04.c            |   2 +-
 6 files changed, 131 insertions(+), 13 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index ec5f889d76819..e31f6c0687041 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -172,6 +172,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index a610821c8ff2a..83b2187d342af 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -39,7 +39,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 }
 
 int gic_configure_irq(unsigned int irq, unsigned int type,
-		       void __iomem *base, void (*sync_access)(void))
+		      void __iomem *base, void (*sync_access)(void),
+		      void __iomem *base_read_alias)
 {
 	u32 confmask = 0x2 << ((irq % 16) * 2);
 	u32 confoff = (irq / 16) * 4;
@@ -52,7 +53,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * for "irq", depending on "type".
 	 */
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-	val = oldval = readl_relaxed(base + confoff);
+	if (base_read_alias == NULL)
+		base_read_alias = base;
+
+	val = oldval = readl_relaxed(base_read_alias + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
 	else if (type & IRQ_TYPE_EDGE_BOTH)
@@ -73,7 +77,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * non-secure mode, and hence it may not be catastrophic.
 	 */
 	writel_relaxed(val, base + confoff);
-	if (readl_relaxed(base + confoff) != val)
+	if (readl_relaxed(base_read_alias + confoff) != val)
 		ret = -EINVAL;
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 27e3d4ed4f328..c955f83d1f8f2 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -19,7 +19,8 @@ struct gic_quirk {
 };
 
 int gic_configure_irq(unsigned int irq, unsigned int type,
-                       void __iomem *base, void (*sync_access)(void));
+		      void __iomem *base, void (*sync_access)(void),
+		      void __iomem *base_read_alias);
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
 void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d4338e7..f460f832c87e6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -45,6 +45,13 @@ struct redist_region {
 	bool			single_redist;
 };
 
+/* Distributor alias region for {E}SPIs registers */
+struct dist_base_alias {
+	u32		intid_start;
+	u32		intid_end;
+	void __iomem	*base;
+};
+
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
 	void __iomem		*dist_base;
@@ -57,8 +64,12 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+	struct dist_base_alias	*base_read_aliases;
+	u32			nr_dist_base_aliases;
 };
 
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -188,6 +199,26 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
 
+static inline void __iomem *gic_dist_base_read_alias(irq_hw_number_t intid)
+{
+	struct dist_base_alias *base_alias;
+	int i;
+
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		base_alias = gic_data.base_read_aliases;
+		for (i = 0; i < gic_data.nr_dist_base_aliases; i++) {
+			if (base_alias->base &&
+			   (intid >= base_alias->intid_start) &&
+			   (intid <= base_alias->intid_end)) {
+				return base_alias->base;
+			}
+			base_alias++;
+		}
+	}
+
+	return gic_data.dist_base;
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -346,7 +377,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_read_alias(irqd_to_hwirq(d));
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -580,6 +611,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	enum gic_intid_range range;
 	unsigned int irq = gic_irq(d);
 	void __iomem *base;
+	void __iomem *base_read_alias;
 	u32 offset, index;
 	int ret;
 
@@ -594,14 +626,17 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	if (gic_irq_in_rdist(d))
+	if (gic_irq_in_rdist(d)) {
 		base = gic_data_rdist_sgi_base();
-	else
+		base_read_alias = base;
+	} else {
 		base = gic_data.dist_base;
+		base_read_alias = gic_dist_base_read_alias(irqd_to_hwirq(d));
+	}
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
-
-	ret = gic_configure_irq(index, type, base + offset, NULL);
+	ret = gic_configure_irq(index, type, base + offset, NULL,
+				base_read_alias + offset);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
@@ -1719,6 +1754,70 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
 
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+#ifdef CONFIG_ACPI
+	struct dist_base_alias *base_alias;
+	struct acpi_table_header *madt;
+	int i, intid, nchips = 0;
+	acpi_status status;
+	phys_addr_t phys;
+
+	status = acpi_get_table(ACPI_SIG_MADT, 0, &madt);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	/* Check NVIDIA OEM ID */
+	if (memcmp(madt->oem_id, "NVIDIA", 6)) {
+		acpi_put_table(madt);
+		return false;
+	}
+
+	/* Find the number of chips based on OEM_TABLE_ID */
+	if ((!memcmp(madt->oem_table_id, "T241x3", 6)) ||
+	    (!memcmp(madt->oem_table_id, "T241c3", 6))) {
+		nchips = 3;
+	} else if ((!memcmp(madt->oem_table_id, "T241x4", 6)) ||
+		   (!memcmp(madt->oem_table_id, "T241c4", 6))) {
+		nchips = 4;
+	}
+
+	acpi_put_table(madt);
+	if (nchips < 3)
+		return false;
+
+	base_alias = kmalloc_array(nchips, sizeof(*base_alias),
+				   GFP_KERNEL | __GFP_ZERO);
+	if (!base_alias)
+		return false;
+
+	gic_data.base_read_aliases = base_alias;
+	gic_data.nr_dist_base_aliases = nchips;
+
+	/**
+	 * Setup GICD alias and {E}SPIs range for each chip
+	 * {E}SPI blocks mappings:
+	 *    Chip0 = 00-09
+	 *    Chip1 = 10-19
+	 *    Chip2 = 20-29
+	 *    Chip3 = 30-39
+	 */
+	for (i = 0; i < nchips; i++, base_alias++) {
+		phys = ((1ULL << 44) * i) | 0x23580000;
+		base_alias->base = ioremap(phys, SZ_64K);
+		WARN_ON(!base_alias->base);
+
+		intid = i < 3 ? 32 + i * 10 * 32 : ESPI_BASE_INTID;
+		base_alias->intid_start = intid;
+		base_alias->intid_end = intid + 10 * 32 - 1;
+	}
+	static_branch_enable(&gic_nvidia_t241_erratum);
+	return true;
+#else
+	return false;
+#endif
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1750,6 +1849,12 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xe8f00fff,
 		.init	= gic_enable_quirk_cavium_38539,
 	},
+	{
+		.desc	= "GICv3: NVIDIA erratum T241-FABRIC-4",
+		.iidr	= 0x0402043b,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_nvidia_t241,
+	},
 	{
 	}
 };
@@ -2377,8 +2482,13 @@ static void __init gic_acpi_setup_kvm_info(void)
 		vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
 	}
 
-	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
-	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		gic_v3_kvm_info.has_v4 = false;
+		gic_v3_kvm_info.has_v4_1 = false;
+	} else {
+		gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
+		gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	}
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 210bc2f4d5550..73575bbf4df67 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -306,7 +306,8 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL,
+				NULL);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 46161f6ff289d..dc19f48d6f5a5 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -130,7 +130,7 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
+	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL, NULL);
 	if (ret && irq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
 		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
-- 
2.25.1

