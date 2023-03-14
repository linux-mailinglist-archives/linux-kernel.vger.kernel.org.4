Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D16B96EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCNNzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjCNNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:54:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA4A29176;
        Tue, 14 Mar 2023 06:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOUobB9nQvgIAX/kANwBSQBP2OIRMFK/b9N5IbTO4BP8GloWHMpzhpSCQrTGRqXN/NV0AGU7QKmlBa+KhzVtTqzyVVR5wp3ADqKAkKlaZd2ByBOC37dHr5uy3RleZz65gtokj3G5bhUoCJKgzpgpVfkwsyr2Usjv33SwlyIyyIsF1p/Wh5InPVCsrAViBLJ9EtiIijB4JXVe+cfHmhHcgtEJGG19Hi2Mym93Ls5ujlHC734mI6wNCbgyKEmrWJpn7spLwn12tANtbLal413bTQiCUNRTmkU4Dtdcgs3jnnY+0F8qWgf7UXuvuGh0qSbTmggQVIZpBEA37JbUM/yp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk+RF9YBWD44P/n3kM08nDCAgnDJOO784WN82RYWLcw=;
 b=V4Svrgn4tyc2nrEOSHigEEf+oo8cgkedDdPbxiwcfG52qOfM173taY9r3h5x4OaMIq95c8EUyA+9Q6WwV81B+odf7ekCg8/pG7moN89UFnC8KSLT/zUOACtBJGwjbS1TcViLGgJRdFxqjtqpEqVS0gLe3ScCIY5SvOFB/CFuesC1NtioElJzT61APKkte7TgmU7eZI1ZihfC4t2tE9m/Eos0kJj3tiNpMCDLU6nveccpHvtrlhSWVf/yvceKiOsVMRRtCkxIYlcnnRrlgn8S/p79w3+Yazm0OLgI/SOG8Gok6XTR0ULQk/HXiH/8HQp289ZSXOn7dLV7K+8UNcTpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk+RF9YBWD44P/n3kM08nDCAgnDJOO784WN82RYWLcw=;
 b=MpTe+rXPffPR2XpPHe0k4ZM/aaskrClZVjKt9nZvEp+w+azaSCD/cSqx3lZDC+f52h64K4B4NKv+vMcbEdtvfCffJXtGZcUpaItiD55uXVPr6UsWvSnjcLMHf0j8bXs2SuFZOoT8Cf2DIbfQ/6kIcn2FXGqtylrQk1eyuluFivHVRkokmEKcWwQYwBRGsv3Crd/YLRT+AlKzvi/NRDrc1P37wxsxhkm+dcyStUqFqXuLyCXzB2EJfsjn8JV1WE16e55DPvq+Xkz4Q/WiEhABTEv98aukBzc+oIIo+pp3uOnzRflF0FZArnE3ELXoqDbv8H1Ptbdou5QfXk5PubTM9w==
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 13:52:06 +0000
Received: from DS1PEPF0000B075.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::ab) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 13:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B075.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26 via Frontend Transport; Tue, 14 Mar 2023 13:52:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 14 Mar 2023
 06:51:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 14 Mar
 2023 06:51:55 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Tue, 14 Mar 2023 06:51:54 -0700
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
Date:   Tue, 14 Mar 2023 08:51:28 -0500
Message-ID: <20230314135128.2930580-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B075:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe397f4-2c2e-42b9-7bf1-08db24934c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ2DwPIsq4YfewU4dZw263ykqSgE7m8zJIV+hcFFGNhmrt1NFFq8eHWYx+q9mE4XmOMVDwtdrx6SJ0c04p+PnlXsMBHdBRhxoGQKSLM8oDvV9K/QLgNR5oEdjrEGgkrmiwBATr3Nzu91Eux5ftLAdQeyM6NmqgVSmE2bfcTigqDtWbqd4ZTo72sH6slH9Me21HLAUlhVt1DUEnCrlgtZfTsaJjt8TTaPd8o3iOndr67p2jYuUqBBXJbYM0QwzERETkauockWb+1MhE7kps0KjHN9apEdlAL+eeIDxV1QnSLYLuoAsPONXMwM/DRIy5ZhGhE8SeYuuAkeUxl9+UP2caSKr9n6U0ECLoyJIweYQObrcCZmCgSJvZyFIxl/W8FmxOK4/6H9KG1+dM4UiViUd1/FlgGJh8KihFU9jb8dOY1SDt+LMA0QRfd55NQ7tMt/PhQUCx+VLIe2o7N6LmHcQL0LqBm8p3iSMOkvmmhj9f2A0FjdEmrNrgHFyDkMps1npHYYdmgyrjspDFsP4RFhBHpH9X8TGcPWy+1Voyvia3IAHMZA59MfC3J4WBvNppW0CdI4t2aX8aa4iAXrf022CwxnmpN6FhrvqkkwZA80Bqe3haS4QI1uAPuc7Zre17QT6GIC3PGZZrWH3QWhI5cpH/wv7X+H++f0/BDdBco1vlo1XE9hpTn8wQ8cPuKqBGgWuhz8F/AzC2wDdxNUEKJ65dn4RPBRqeXkwrA849RJlpmg+i3Ep0DMA0U/uGvdIX9kPYFKvdLeDYWvoJ2DXax9aHzIRz1TOxHPK+/RPJ7f10hWIA9k7ej4qEmKvlRgq+QcvZPLZ7wMRFVXsWEtfLaj5LUEAW/gWJ/X/M0mOomOqJQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(336012)(2616005)(7416002)(186003)(1076003)(26005)(8936002)(83380400001)(107886003)(6666004)(82310400005)(36860700001)(921005)(356005)(82740400003)(426003)(30864003)(47076005)(966005)(5660300002)(40460700003)(40480700001)(2906002)(7696005)(70586007)(8676002)(70206006)(41300700001)(7636003)(110136005)(36756003)(478600001)(54906003)(4326008)(86362001)(316002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:52:05.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe397f4-2c2e-42b9-7bf1-08db24934c28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B075.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T241 platform suffers from the T241-FABRIC-4 erratum which causes
unexpected behavior in the GIC when multiple transactions are received
simultaneously from different sources. This hardware issue impacts
NVIDIA server platforms that use more than two T241 chips
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

Link: https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf

Writing to the chip alias region of the GICD_In{E} registers except
GICD_ICENABLERn has an equivalent effect as writing to the global
distributor. The SPI interrupt deactivate path is not impacted by
the erratum.

To fix this problem, implement a workaround that ensures read accesses
to the GICD_In{E} registers are directed to the chip that owns the
SPI, and disables GICv4.x features for KVM. To simplify code changes,
the gic_configure_irq() function uses the same alias region for both
read and write operations to GICD_ICFGR.

Co-developed-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v1:
 - Use SMCCC SOC-ID API for detecting the T241 chip
 - Implement Marc's suggestions
 - Edit commit text

 Documentation/arm64/silicon-errata.rst |   2 +
 drivers/firmware/smccc/smccc.c         |  13 +++
 drivers/irqchip/irq-gic-v3.c           | 116 +++++++++++++++++++++++--
 include/linux/arm-smccc.h              |   1 +
 4 files changed, 123 insertions(+), 9 deletions(-)

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
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e90d7de..cb688121270b8 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,12 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
 u64 __ro_after_init smccc_has_sve_hint = false;
+s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
+	struct arm_smccc_res res;
+
 	smccc_version = version;
 	smccc_conduit = conduit;
 
@@ -27,6 +30,16 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    smccc_version >= ARM_SMCCC_VERSION_1_3)
 		smccc_has_sve_hint = true;
+
+	if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
+	    (smccc_conduit != SMCCC_CONDUIT_NONE)) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				     ARM_SMCCC_ARCH_SOC_ID, &res);
+		if ((s32)res.a0 >= 0) {
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
+			smccc_soc_id_version = (s32)res.a0;
+		}
+	}
 }
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d4338e7..02c699ce92b12 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/arm-smccc.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -57,8 +58,14 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+	phys_addr_t		dist_phys_base;
 };
 
+
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX];
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -188,6 +195,34 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
 
+static inline void __iomem *gic_dist_base_alias(irq_hw_number_t intid)
+{
+	u32 chip;
+
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		/**
+		 *  {E}SPI mappings for all 4 chips
+		 *    Chip0 = 32-351
+		 *    Chip1 = 352-671
+		 *    Chip2 = 672-991
+		 *    Chip3 = 4096-4415
+		 */
+		switch (__get_intid_range(intid)) {
+		case SPI_RANGE:
+			chip = (intid - 32) / 320;
+			break;
+		case ESPI_RANGE:
+			chip = 3;
+			break;
+		default:
+			unreachable();
+		}
+		return t241_dist_base_alias[chip];
+	}
+
+	return gic_data.dist_base;
+}
+
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -343,10 +378,14 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	offset = convert_offset_index(d, offset, &index);
 	mask = 1 << (index % 32);
 
+	/**
+	 * For the erratum T241-FABRIC-4, read accesses to the GICD_In{E}
+	 * registers are directed to the chip that owns the SPI.
+	 */
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(irqd_to_hwirq(d));
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -594,13 +633,17 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
+	/**
+	 * For the erratum T241-FABRIC-4, read accesses to the GICD_In{E}
+	 * registers are directed to the chip that owns the SPI. Use the
+	 * same alias region for GICD_ICFGR writes to simplify code.
+	 */
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(irqd_to_hwirq(d));
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
-
 	ret = gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
@@ -1719,6 +1762,45 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
 
+#define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
+#define T241_CHIP_GICDA_OFFSET	0x1580000
+#define SMCCC_SOC_ID_MASK	0x7f7fffff
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+	unsigned long chip_bmask = 0;
+	phys_addr_t phys;
+	u32 i;
+
+	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
+	if ((smccc_soc_id_version < 0) ||
+	    ((smccc_soc_id_version & SMCCC_SOC_ID_MASK) != SMCCC_SOC_ID_T241)) {
+		return false;
+	}
+
+	/* Find the chips based on GICR regions PHYS addr */
+	for (i = 0; i < gic_data.nr_redist_regions; i++) {
+		chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
+				  gic_data.redist_regions[i].phys_base));
+	}
+
+	if (hweight32(chip_bmask) < 3)
+		return false;
+
+	/* Setup GICD alias regions */
+	for (i = 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
+		if (chip_bmask & BIT(i)) {
+			phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
+			phys |= FIELD_PREP(T241_CHIPN_MASK, i);
+			t241_dist_base_alias[i] = ioremap(phys, SZ_64K);
+			WARN_ON_ONCE(!t241_dist_base_alias[i]);
+		}
+	}
+	static_branch_enable(&gic_nvidia_t241_erratum);
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] = {
 	{
 		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1750,6 +1832,12 @@ static const struct gic_quirk gic_quirks[] = {
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
@@ -1821,7 +1909,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
-				 struct fwnode_handle *handle)
+				 struct fwnode_handle *handle,
+				 phys_addr_t dist_phys_base)
 {
 	u32 typer;
 	int err;
@@ -1834,6 +1923,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.fwnode = handle;
 	gic_data.dist_base = dist_base;
+	gic_data.dist_phys_base = dist_phys_base;
 	gic_data.redist_regions = rdist_regs;
 	gic_data.nr_redist_regions = nr_redist_regions;
 	gic_data.redist_stride = redist_stride;
@@ -2072,11 +2162,12 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	struct resource res;
+	struct resource dist_res;
 	u64 redist_stride;
 	u32 nr_redist_regions;
 	int err, i;
 
-	dist_base = gic_of_iomap(node, 0, "GICD", &res);
+	dist_base = gic_of_iomap(node, 0, "GICD", &dist_res);
 	if (IS_ERR(dist_base)) {
 		pr_err("%pOF: unable to map gic dist registers\n", node);
 		return PTR_ERR(dist_base);
@@ -2114,7 +2205,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
 
 	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+			     redist_stride, &node->fwnode, dist_res.start);
 	if (err)
 		goto out_unmap_rdist;
 
@@ -2377,8 +2468,14 @@ static void __init gic_acpi_setup_kvm_info(void)
 		vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
 	}
 
-	gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
-	gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	/* Disable GICv4.x features for the erratum T241-FABRIC-4 */
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		gic_v3_kvm_info.has_v4 = false;
+		gic_v3_kvm_info.has_v4_1 = false;
+	} else {
+		gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
+		gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
+	}
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
 
@@ -2431,7 +2528,8 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 	}
 
 	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+			     acpi_data.nr_redist_regions, 0, gsi_domain_handle,
+			     dist->base_address);
 	if (err)
 		goto out_fwhandle_free;
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021a..f74e13938693e 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -225,6 +225,7 @@ u32 arm_smccc_get_version(void);
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 
 extern u64 smccc_has_sve_hint;
+extern s32 smccc_soc_id_version;
 
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
-- 
2.25.1

