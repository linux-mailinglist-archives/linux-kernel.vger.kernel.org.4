Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA406BFF20
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 03:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCSCnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 22:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCSCnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:43:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684C13D71;
        Sat, 18 Mar 2023 19:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL+8lCmyb/cT1DJTn+r0wE51HTzdGbshHU90Y+WitR93fN6Vy+/0bhWGQpFQCiW7XSFP1Vbl5nXbZ6VfhOegP75v/gXEfOzqNyWPqpNUo3bRNV39VSSnYSXDl7ywF3Yfg4mGi4wXfK+Ao5+5MfcvmqAPtIvn0zPLdajfT4hpKWHyfmOvNa64c3Roe+rQBKpuI1SvWI9orG7OGvCMJbuO9FMSYYNHrRcMV7nrE3yaY3kmOYpNBuYnT/pvT4gXzc9x7I0m+nInu/l2u2sidGwHWjd9q4jxZa0Pdnjeu96AQf/ccYBms32uqfvMn1FZiRi9LPkszz0O1VnB1VGY76n8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnEVKSrHptZeatmJKnwavjDVC2hxAhZcgYZ9wU0QtKY=;
 b=URZ7vOAOgbnxi3RZomW/kzqS76lqw3asE1Boz96VdZd0KbFlJnwByTEA3VxoXS2A3vzjIjeLTD850f2hESu6MU5h0OCuEDyAYz0+dMSIEHM76YS0ejnPX9fdDlLAW+Auvw2UERFA9FCbPJ34B9R9sPkXJS4NJgb/dO0JZBMeaoP9QIbM6p9lDcx1uvkxrXLh5jv8BFAq5mhGP7Kzq/aQbHv28iTgS34wLBtifuQVOaahvlqZ33dQK3K7tu26i+ChyqAcou8ETXlrPblrql7HMM+bqwzYNKvSsicf0L/frHdtFGA/51rKQvJ9RVnlBYuqqK0QrkhExXO5CoPoUrMmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnEVKSrHptZeatmJKnwavjDVC2hxAhZcgYZ9wU0QtKY=;
 b=K/i7Cv8zRY0FOPp20l/vIZxw3ZWMT5vpkzjRPwi7rWUfvXrySy3/pI+zwZvG6ei7I4tdnZlD0JRnU6l+0am0nfiJUw2eGASyT2zIzQ3dsUPKbGKKr+8+4vLdOrtsdXR+LCUBW5jPjQzLOvz/8c9xrvl+GmzfdoC56Rwb0ebi8aAg0FvpJPb4cmgyac8Fjs7MyDouFPUim5vmsqNwPGT9IIpmHl42IryYokS3ccE5NRYoFMc2AKhftfvuYBU+XtlhXh1Jd8xkXmDegkjsJigWOtUCQ/5NOyvwO7oeZqy6URaGk61qDI+LQx9AcdKu5/Oe+xjecQ2oFu4dBPJzWWF/AQ==
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 02:43:32 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::6) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Sun, 19 Mar 2023 02:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.11 via Frontend Transport; Sun, 19 Mar 2023 02:43:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 18 Mar 2023
 19:43:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 18 Mar
 2023 19:43:17 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 18 Mar 2023 19:43:16 -0700
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
Date:   Sat, 18 Mar 2023 21:43:13 -0500
Message-ID: <20230319024314.3540573-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e660ec-ae71-45a0-bfe9-08db2823ba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xual1V7p3geGA1qAbbG9DNf8xgF2YfRalhye3HmwG9Aq/RjL9/aySs/X+01mzJc6oeGQRBQeJalcb8y/1gpYFsnNKhl2a4JoYMKeys2qOE7K4PScUWiR2WhUj2SPOJHW4j1Ka/471DJrwrMYO6eVb6XtAJC+kWtRMzZStOlALnjJWraL2fKlZr9Y5sKW8WzDDSwSMC4knDiJERz6rvsLShdTzmDV81hhojnhPQuecjNN9jsTAbl3goW1Qa57W9M8dcdveXxL9RhfUly+yPhmsnyIdCWxsDgoaHMM6N0wLAQk5aj+h0Dr0VHI7tPrFEFMMX+w1GphG66v8H9UwGDPH+4SU1IKiTZoK7ncnf/Z4qLtNzfpHfXvwu7D51GPScTgQbDjtBP7Vypxnpf37TUwr8rDSZP0jtIexHmm2ApX3jSHx30ISp/puNIFlFZRCt6O4euLcQ3FXFTDfXDyH8JnLk5cNHbZCcXXsw1lgMdYdLLJ9A6nGGufXIdZAb7xlM66OyFmTUzUS6rHWFcPwNXKn85rS1609F6ePPAx7CCsBH5zpEZ/t1Uh+za5U26ObSt0dxoVW5E2fRdgsIO8tBlt3Ny0VGexFSi4TKMtElcp5vNSM9dyo0ypYizvmzupeLYYOfkTP+XL8YBKufwI/hRsy3BOU2pnZ8kV6LFXRdP5D3HIxgqY7FXywKI1Pydb9m8xgd/sMTqSoFZwMuORjqwrjeGMPy/0gTp+Ze+4fpDPKxxfPnxkEDKhnOKIkCVuzqCFzrigaoPb2gltLL3y4Zd5zwKXovOAs/nUEDwfgghtf0pmy60KudZeKCu3ft2m4RHkzXJAX6KsXqEqO1nXqGfRnhR0WMgbZ1f465k5cgI1fW1SJl9hyK7i62yf8x0Mova836pkZ/RW7RaRywEJJYxfcw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(110136005)(4326008)(54906003)(8676002)(70206006)(316002)(70586007)(478600001)(41300700001)(8936002)(30864003)(7416002)(2906002)(5660300002)(921005)(356005)(86362001)(40460700003)(36756003)(7696005)(1076003)(26005)(336012)(966005)(7636003)(40480700001)(82740400003)(6666004)(107886003)(426003)(186003)(47076005)(2616005)(82310400005)(83380400001)(36860700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 02:43:31.8644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e660ec-ae71-45a0-bfe9-08db2823ba6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
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

