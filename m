Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FF6BFF21
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 03:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCSCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 22:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCSCno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:43:44 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069241A956;
        Sat, 18 Mar 2023 19:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgErTPUb7HN9A5mDudZg0J0IzkweL/8748F/Kv9XAF7enCQMF2cxnHhuxUDr9v8ktBeGDZrdJwbuqFAewrz+VRLCFle2vH+u4lFTP1WFwA/wL460ChIVNrMWueU5S4lkhUT6qYGbvP1eNjy3YeYQICEzQ2fMvjc4oOHt2S2YIkj+9S72Ejkk1XFdFTJ9C9J6344yjwRgZNTPGkyIgyAue1h9GvhZANJEcUppBzpumSCCTBAjQ34MQoowUUTapfkn/9Yhjj3McoEWt1VxK21oNc4D1Vxa8f5IziJKuqhShlNDvzmTKU1l34CcXjacmM6HdUis1jL6aurrCcEDbxYZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnEVKSrHptZeatmJKnwavjDVC2hxAhZcgYZ9wU0QtKY=;
 b=aGPBV1zK4gT9wp/pa/sNMVfJzqbEF45GhZq803DMbPknlrw9Py38H1L/DGoBlxknq/OcyZMrYte6oHjcob+6g/Si598DH83FuPOmXaRpsOsHFwTWpO5CuW85mWwqygk4hgyqrZfDfmMrp3jBr0bvlpPKhj/KkVDTB0rvaWCgjF+IaWm/iwbacoyY28L1fdwiCOxS+WSCNZCojmFxtuFwm1jaxw540z8MqsoU0LA2Ftq1mK37Hyach+EYaJd3CpvsEWJAM53CQutweHiAG3WVdGHNYWTkTyJ5LGISztbj91yPRsGTmtlIMq7VFvqClVCk5AjVAdQWM3osttYW+kz7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnEVKSrHptZeatmJKnwavjDVC2hxAhZcgYZ9wU0QtKY=;
 b=jwgZwFe+p3AZSrTgP2gCruRbynaDbRimqf8sFzRhTXElIR0uGyIlLQdeCPKNl78erKX0D4nEcblB+/vC5apCxojiC2Xsil+ErqP0t3SziIjImHX1Bokv9p1XqCpk0iakE4ac4mcZUqlhi6VI+PFktV0iJBn61yANsyTalzrHC4nCcFRc+/cOUmTpfoIrUi5ywFEMISemrqZBu+IpgGem0IOn8BBTr1MQRY5lmBV7iIsHaElFJV9AquYv4RGMJgUcRFMTLV7kWRsK8cZ15w+mOjHUUZ9Uht3HwKeuPp7kXA6zFvMoMHesvypdfXZ1EjIYPZ/L5vHZItXi1fbrKR64RA==
Received: from MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 02:43:35 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::1b) by MN2PR08CA0028.outlook.office365.com
 (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Sun, 19 Mar 2023 02:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Sun, 19 Mar 2023 02:43:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 18 Mar 2023
 19:43:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 18 Mar
 2023 19:43:18 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 18 Mar 2023 19:43:17 -0700
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
Subject: [PATCH v5] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
Date:   Sat, 18 Mar 2023 21:43:14 -0500
Message-ID: <20230319024314.3540573-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230319024314.3540573-1-sdonthineni@nvidia.com>
References: <20230319024314.3540573-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: aa075dd5-1fdc-4dca-41da-08db2823bc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAcfaToHyoFfXYXCpLduUN7G8bze2g57gkFhOI1OteamZcjDcbWR71aL6Te0rOdHFaHDGh/jTZnyYSze7gGMLhDnYhxr+VBaBM4YSnSxDbXQYOKpbYQsT6UuTFa8jAvgATvcX2wa9vz1H+1+zDbeHcpOb9tlZYm0hJP4+7EZCOEgbyw4iP+AIDUknYEqtogSkg6fx8ix+CzqR01T9lRr/iivc0yNBmEjRDUF+VOjXuuUrvLNnZ4zEa5DbQadhZxv3erO8ucFc4X0XWJF64g9VAc7YsF6kY2xM6240KhTS+j4CItt/9u3rXoDmNV+niGI0gNlOdHq/FbTzEWVMNZbgQ3zQlrZFEWKT5Tk7rQWkGk/KLO5Ta7/koQbMH4yC5zRgsnAd3oB96wI82vPtb0L+ar+wJqvC61K0pW5S/snq1L7lmahIYMF5OUNF+cuQ41jjW+3gu+TN244f5TMFBQIjTAqkPsterC2y+0O+Orr8tGbYFTcIDchEDGizhDeSndntzWxdOLa94HegmvpuJ03gs0Ez9LGfdrsfjKJhmYQiDKfFsIItW8M4Q/g9bfKROkl8eXZRzd5QWJBUcFsvo3hgX8X/Fdtmhv37CvUX6DQKyNmE5fbRIRCzBOZ+ZSVrgqamgLKOuC5RcBwV7NNfMI2CnK9+rRtoj+dh6Exg4HRF/jzm+LGsXSlrf2S0/kCdWrl2T3aOG5VOEjyYGzbX2KxtpOMB6K9mzXwBaB7J9Eg88OMP4s1o2UaCQVp0TcK4CDziUgCnCh4kxHGCUqQG65egsrdMaRc5TxcswjeT0pzdVmesja7fjyjnZ8cXrm2vXOmoPyEETWYpZd3UdXj4cRWUbE7HVdduRX/djtxi6d1DnU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39850400004)(346002)(136003)(376002)(451199018)(46966006)(36840700001)(82310400005)(83380400001)(2616005)(426003)(47076005)(336012)(86362001)(356005)(921005)(36860700001)(7636003)(40480700001)(82740400003)(4326008)(41300700001)(36756003)(8676002)(70206006)(2906002)(70586007)(8936002)(30864003)(5660300002)(6666004)(107886003)(26005)(186003)(1076003)(110136005)(316002)(478600001)(966005)(54906003)(7696005)(7416002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 02:43:34.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa075dd5-1fdc-4dca-41da-08db2823bc0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
SPI, and disable GICv4.x features. To simplify code changes, the
gic_configure_irq() function uses the same alias region for both read
and write operations to GICD_ICFGR.

Co-developed-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
Changes since v4:
 - Resolve Marc's comments https://lore.kernel.org/all/871qlqif9v.wl-maz@kernel.org/
Changes since v3:
 - Fix the build issue for the 32bit arch
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
 drivers/irqchip/irq-gic-v3.c           | 115 ++++++++++++++++++++++---
 include/linux/arm-smccc.h              |  18 ++++
 6 files changed, 156 insertions(+), 34 deletions(-)

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
index 3779836737c8..5f973086903e 100644
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
@@ -47,6 +50,7 @@ struct redist_region {
 
 struct gic_chip_data {
 	struct fwnode_handle	*fwnode;
+	phys_addr_t		dist_phys_base;
 	void __iomem		*dist_base;
 	struct redist_region	*redist_regions;
 	struct rdists		rdists;
@@ -59,6 +63,10 @@ struct gic_chip_data {
 	struct partition_desc	**ppi_descs;
 };
 
+#define T241_CHIPS_MAX		4
+static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
+static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -179,6 +187,39 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
 	}
 }
 
+static inline void __iomem *gic_dist_base_alias(struct irq_data *d)
+{
+	if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		irq_hw_number_t hwirq = irqd_to_hwirq(d);
+		u32 chip;
+
+		/*
+		 * For the erratum T241-FABRIC-4, read accesses to GICD_In{E}
+		 * registers are directed to the chip that owns the SPI. The
+		 * the alias region can also be used for writes to the
+		 * GICD_In{E} except GICD_ICENABLERn. Each chip has support
+		 * for 320 {E}SPIs. Mappings for all 4 chips:
+		 *    Chip0 = 32-351
+		 *    Chip1 = 352-671
+		 *    Chip2 = 672-991
+		 *    Chip3 = 4096-4415
+		 */
+		switch (__get_intid_range(hwirq)) {
+		case SPI_RANGE:
+			chip = (hwirq - 32) / 320;
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
@@ -337,7 +378,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
@@ -588,7 +629,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
-		base = gic_data.dist_base;
+		base = gic_dist_base_alias(d);
 
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
@@ -1710,6 +1751,43 @@ static bool gic_enable_quirk_hip06_07(void *data)
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
+				  (u64)gic_data.redist_regions[i].phys_base));
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
@@ -1741,6 +1819,12 @@ static const struct gic_quirk gic_quirks[] = {
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
@@ -1800,7 +1884,8 @@ static void gic_enable_nmi_support(void)
 		gic_chip.flags |= IRQCHIP_SUPPORTS_NMI;
 }
 
-static int __init gic_init_bases(void __iomem *dist_base,
+static int __init gic_init_bases(phys_addr_t dist_phys_base,
+				 void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
 				 u64 redist_stride,
@@ -1816,6 +1901,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
 	gic_data.fwnode = handle;
+	gic_data.dist_phys_base = dist_phys_base;
 	gic_data.dist_base = dist_base;
 	gic_data.redist_regions = rdist_regs;
 	gic_data.nr_redist_regions = nr_redist_regions;
@@ -1843,10 +1929,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
-	gic_data.rdists.has_rvpeid = true;
-	gic_data.rdists.has_vlpis = true;
-	gic_data.rdists.has_direct_lpi = true;
-	gic_data.rdists.has_vpend_valid_dirty = true;
+	if (!static_branch_unlikely(&gic_nvidia_t241_erratum)) {
+		/* Disable GICv4.x features for the erratum T241-FABRIC-4 */
+		gic_data.rdists.has_rvpeid = true;
+		gic_data.rdists.has_vlpis = true;
+		gic_data.rdists.has_direct_lpi = true;
+		gic_data.rdists.has_vpend_valid_dirty = true;
+	}
 
 	if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
 		err = -ENOMEM;
@@ -2052,6 +2141,7 @@ static void __iomem *gic_of_iomap(struct device_node *node, int idx,
 
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
+	phys_addr_t dist_phys_base;
 	void __iomem *dist_base;
 	struct redist_region *rdist_regs;
 	struct resource res;
@@ -2065,6 +2155,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 		return PTR_ERR(dist_base);
 	}
 
+	dist_phys_base = res.start;
+
 	err = gic_validate_dist_version(dist_base);
 	if (err) {
 		pr_err("%pOF: no distributor detected, giving up\n", node);
@@ -2096,8 +2188,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_enable_of_quirks(node, gic_quirks, &gic_data);
 
-	err = gic_init_bases(dist_base, rdist_regs, nr_redist_regions,
-			     redist_stride, &node->fwnode);
+	err = gic_init_bases(dist_phys_base, dist_base, rdist_regs,
+			     nr_redist_regions, redist_stride, &node->fwnode);
 	if (err)
 		goto out_unmap_rdist;
 
@@ -2413,8 +2505,9 @@ gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 		goto out_redist_unmap;
 	}
 
-	err = gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
+	err = gic_init_bases(dist->base_address, acpi_data.dist_base,
+			     acpi_data.redist_regs, acpi_data.nr_redist_regions,
+			     0, gsi_domain_handle);
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

