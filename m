Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6E6BEE20
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCQQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCQQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:26:53 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD11DCA49;
        Fri, 17 Mar 2023 09:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVolzjnGuEiRENWLaeY4zaKlZOpP0Q0XzXOIr5YZQ7Sd2SDIfzVNd6XaXroQsVHYp12CfQfIjVadZ+URwTnIcXQ0orfi5Eb9xDP4kW2GEa3BnC0NGIbrSs6uUo7GbYIV3eT68HL6n0B2cQt1PYt+vonBd2DjsGLCh+Jlv4t+g2ddiuM3Z2Vf3CPEuG/g/7Yv2v/AfaxMXVFSSPP+qvLzCeY3T1s51QRgjhGlQLE/C4DEf3TNydqZwnlSQsKKHlGZyA30r7CAX7cANZMR1WF1OTb/sotEHv4VWiOngh8257Wo+3ne8KEaH2Okc9DycyKdWoT35Dz5wuiawsZ44IE1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mkqBTPfG3nC3f8UxolyVeaAc57c3OAav5NHh3GQCa0=;
 b=WuiXIV/2fEl9wpW9VXjRS7nWhnhJ4D8LwioAJ504XRQ3ZbJRvc5nYSjo7L0Kq/XRQK5XkyGq0x7yuw2OBveTykvcBJzb3yRmCIY0K9X9vRwK6HGjJH30HhcJvk+C6ylSOpm95H8i7AEgqZS3xvOAoQ9Kny7k+K3gupZaoKiKvo1p4+pGYqF8A4sg2ovffWOwynw7zlt+qOLuiA5HPozpumOx5LcVQK3VR3PpznhEKpc3Tj5lFfBpTJ2ZbkVLc16QaJYDVL0jA81kjO7j5H1WvuH2s7B0GobXVC7faVIsIWzK6q56GDpvL19FV15Mo7XJ2S6P7/5/RKEnUejCTLxlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mkqBTPfG3nC3f8UxolyVeaAc57c3OAav5NHh3GQCa0=;
 b=krNx6R/ukIjoCwhsmGvuwiPB5Kb1lxWxJMnEKRIatkEmBYRh01r95mq5dOp+0/8l3j65S5kqS5HgWZsRuDwlJEXD9nJilxoG9wKMYBth4R6I7WUPa8x4MC1ECa5maJ16Hp5AoakAY3Jp/vqaYDidAnA5xmaIbKZLE+3nI0lEuPJyt3hJoS0N2d0qi0hzrc8DyyTI0ItLOZ36QmxqFD+/Rgjg0LUoiKjkZV6WWoikfON1OSZuNqpNhzk9F0NjTepuqsoNr8pTg5GYC0HrTRFd6uXhUgCA8KUw/4BCRSazgVpcUHVdsFwMFCS6PIdKJ/B3ScIM7GWKrIp2ITqu6P5Shg==
Received: from MW2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:907:1::24)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 16:26:48 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e5) by MW2PR16CA0047.outlook.office365.com
 (2603:10b6:907:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Fri, 17 Mar 2023 16:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.20 via Frontend Transport; Fri, 17 Mar 2023 16:26:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 17 Mar 2023
 09:26:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 17 Mar 2023 09:26:41 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 17 Mar 2023 09:26:40 -0700
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
Subject: [PATCH v3] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
Date:   Fri, 17 Mar 2023 11:26:36 -0500
Message-ID: <20230317162636.851085-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 810dfd8b-8ff3-4a62-eb56-08db27046863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPbrIb3/NV9lDLI4EKTDU8Ov2Yav/YBLaDzk6UjBVYoNmAiwF6f9p8RQiOMk6kF7qCZuYeWM1UF/8AFSd1S5UJzKplUwM2EXjiuXaHT/0U7yNA2+AKt6QQUbQgzu08wNBojT+b6M6dnqa8Z7hXf6ZD8QhwaJGQJpnEkgvr7iu0n4S/e/gxQA60gv4Sl1QbSRiTJ5vu1+kXdudCjCAnDdPORbe+J8tU9GCAHVRITf4ljiTvd9H5L+JOCmG2KEUeyZ+10t5PiWEiuK04ZMrSDMvJCqBxjvdPy+obWfNycb+Mwcodp9h01NJWS9yzDzy18ik1sH4RvPjXhDHBd6msjEH91T83DFSHOVRFPknr7zFbZxW+/KcoeAUm7k/Ditgj3b+zHZYXzysT0C2eBb4CRCmVclH8L5Zsetw6evC85xPhidwbQP6PGAPi04Rnm46bgFe4RUa5GE2irpoPuNYZcFA4L7kE10DdenD+2RmGS83r4cdzckYYklHuzpKGMOG4mRp3K+txLEwyAlxWgX3OxSOBpA3VVCUUPmgMMMLgLnYaUlzOn5gXJxQuQll5DFYXBF+9fEzfwWdhsv3PyQ5umNfkySL6GdtTvWhqGSwtjdYYVtYOM5UGMzRRAx/3hBfI+tkZXR5ScCvMMEMcoY0egWcwCuDzm78GV7KXfaZcnUM9Nc99ldAf1eCR36P0FSZ8Rw4jAXcxEa2tQDA1qxeOcsluFH/9+NeRmZZM7yY+86FMnkQRw9qi3feY075cDAmyLSK7l/w5PrOZXIkFHg1azDU2+0UJmfbTw87nypABXJR13WrRhYk/uJPlR+pJZV5A5wBjF9esZfG2Lje7XF3EHvTdVQKLpCly/ntMoKyoBcqAE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(36840700001)(46966006)(86362001)(7636003)(36756003)(82740400003)(921005)(356005)(82310400005)(47076005)(8936002)(2906002)(30864003)(5660300002)(7416002)(966005)(110136005)(40480700001)(41300700001)(316002)(7696005)(4326008)(478600001)(8676002)(70206006)(70586007)(83380400001)(36860700001)(26005)(186003)(107886003)(1076003)(6666004)(40460700003)(2616005)(426003)(336012)(54906003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 16:26:48.6850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810dfd8b-8ff3-4a62-eb56-08db27046863
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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
  including VMOVP, VMOVI, VMAPP, and 64-bit register accesses."

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
Changes since v2:
 - Add accessors for the SOC-ID version & revision
 - Include "linux/bitfield.h" and "linux/bits.h" in irq-gic-v3.c
Changes since v1:
 - Use SMCCC SOC-ID API for detecting the T241 chip
 - Implement Marc's suggestions
 - Edit commit text

 Documentation/arm64/silicon-errata.rst |   2 +
 drivers/firmware/smccc/smccc.c         |  26 ++++++
 drivers/firmware/smccc/soc_id.c        |  28 ++----
 drivers/irqchip/Kconfig                |   1 +
 drivers/irqchip/irq-gic-v3.c           | 115 +++++++++++++++++++++++--
 include/linux/arm-smccc.h              |  18 ++++
 6 files changed, 158 insertions(+), 32 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 808ade4cc008..55492fea4427 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -170,6 +170,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 60ccf3e90d7d..db818f9dcb8e 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
 bool __ro_after_init smccc_trng_available = false;
 u64 __ro_after_init smccc_has_sve_hint = false;
+s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
+s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
 
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
+	struct arm_smccc_res res;
+
 	smccc_version = version;
 	smccc_conduit = conduit;
 
@@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
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
+			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
+			smccc_soc_id_revision = (s32)res.a0;
+		}
+	}
 }
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
@@ -44,6 +60,16 @@ u32 arm_smccc_get_version(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_version);
 
+s32 arm_smccc_get_soc_id_version(void)
+{
+	return smccc_soc_id_version;
+}
+
+s32 arm_smccc_get_soc_id_revision(void)
+{
+	return smccc_soc_id_revision;
+}
+
 static int __init smccc_devices_init(void)
 {
 	struct platform_device *pdev;
diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
index dd7c3d5e8b0b..890eb454599a 100644
--- a/drivers/firmware/smccc/soc_id.c
+++ b/drivers/firmware/smccc/soc_id.c
@@ -42,41 +42,23 @@ static int __init smccc_soc_init(void)
 	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
 		return 0;
 
-	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
-		pr_err("%s: invalid SMCCC conduit\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
-			     ARM_SMCCC_ARCH_SOC_ID, &res);
-
-	if ((int)res.a0 == SMCCC_RET_NOT_SUPPORTED) {
+	soc_id_version = arm_smccc_get_soc_id_version();
+	if (soc_id_version == SMCCC_RET_NOT_SUPPORTED) {
 		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
 		return 0;
 	}
 
-	if ((int)res.a0 < 0) {
-		pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
-			res.a0);
-		return -EINVAL;
-	}
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
-	if ((int)res.a0 < 0) {
+	if (soc_id_version < 0) {
 		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
 
-	soc_id_version = res.a0;
-
-	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
-	if ((int)res.a0 < 0) {
+	soc_id_rev = arm_smccc_get_soc_id_revision();
+	if (soc_id_rev < 0) {
 		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
 		return -EINVAL;
 	}
 
-	soc_id_rev = res.a0;
-
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index caa952c40ff9..08505fdf890c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -35,6 +35,7 @@ config ARM_GIC_V3
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
+	select HAVE_ARM_SMCCC_DISCOVERY
 
 config ARM_GIC_V3_ITS
 	bool
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3779836737c8..606775dab6eb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -24,6 +24,9 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/irq-partition-percpu.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/arm-smccc.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -57,8 +60,13 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+	phys_addr_t		dist_phys_base;
 };
 
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX];
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -179,6 +187,34 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
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
@@ -334,10 +370,14 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
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
@@ -585,13 +625,17 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
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
@@ -1710,6 +1754,43 @@ static bool gic_enable_quirk_hip06_07(void *data)
 	return false;
 }
 
+#define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
+#define T241_CHIP_GICDA_OFFSET	0x1580000
+#define SMCCC_SOC_ID_T241	0x036b0241
+
+static bool gic_enable_quirk_nvidia_t241(void *data)
+{
+	s32 soc_id = arm_smccc_get_soc_id_version();
+	unsigned long chip_bmask = 0;
+	phys_addr_t phys;
+	u32 i;
+
+	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
+	if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
+		return false;
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
@@ -1741,6 +1822,12 @@ static const struct gic_quirk gic_quirks[] = {
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
@@ -1804,7 +1891,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
-				 struct fwnode_handle *handle)
+				 struct fwnode_handle *handle,
+				 phys_addr_t dist_phys_base)
 {
 	u32 typer;
 	int err;
@@ -1817,6 +1905,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.fwnode = handle;
 	gic_data.dist_base = dist_base;
+	gic_data.dist_phys_base = dist_phys_base;
 	gic_data.redist_regions = rdist_regs;
 	gic_data.nr_redist_regions = nr_redist_regions;
 	gic_data.redist_stride = redist_stride;
@@ -2055,11 +2144,12 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
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
@@ -2097,7 +2187,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
 
 	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+			     redist_stride, &node->fwnode, dist_res.start);
 	if (err)
 		goto out_unmap_rdist;
 
@@ -2360,8 +2450,14 @@ static void __init gic_acpi_setup_kvm_info(void)
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
 
@@ -2414,7 +2510,8 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 	}
 
 	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+			     acpi_data.nr_redist_regions, 0, gsi_domain_handle,
+			     dist->base_address);
 	if (err)
 		goto out_fwhandle_free;
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 220c8c60e021..f196c19f8e55 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -226,6 +226,24 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
 
 extern u64 smccc_has_sve_hint;
 
+/**
+ * arm_smccc_get_soc_id_version()
+ *
+ * Returns the SOC ID version.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_version(void);
+
+/**
+ * arm_smccc_get_soc_id_revision()
+ *
+ * Returns the SOC ID revision.
+ *
+ * When ARM_SMCCC_ARCH_SOC_ID is not present, returns SMCCC_RET_NOT_SUPPORTED.
+ */
+s32 arm_smccc_get_soc_id_revision(void);
+
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
  * @a0-a3 result values from registers 0 to 3
-- 
2.25.1

