Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374986F51EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjECHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjECHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:40:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE444B3;
        Wed,  3 May 2023 00:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7gUtqYxrr5Yh883I0V5SiFAUnBOOs/g8XeWYXhJgMoKjml7cPC1zEl23Eh0iA9ky59w5r0jzRR/4ocmPr8sXLYZpqyYiAy+gT7ipR2tThK9eYQLx1pkeqLnyRFHtKGM6oae1PMxk/R8B/OLERCPB6nq8PoNiFxZZUNL2wzluh24VGymYRKU3CgStrliK6G4ib47Ln9kAKjvYsfIMldJdCuhKdu+grR5gXbUPjGgO+XbwKKIfw5BYICg7N9xWNFrmVAUg0piIOjFC6f9mHCvbfkYtsS9vm7E3kjTE9QFo+OEucmE/4/fplgHQbs+6D+ZrDhYNJvPLeUVuwBOJBF2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+nUCKBCNejj0MqabvYeh8ASQFGvrMfNsbguryuzE8U=;
 b=QYY7ZqX+0Hqru8iLTRO1KC281F9ULPJIb3D0fmC99rUFNy3gj089grq4/7Nz79avVlgaTqDacSBYoLLZKtu0Vzi1BCpwrV9aXniLmL5wmGswOo+xrjsSeOCPYLl7dd/IDU3KaNUeu/9uL+c29GnECnvQMO4hsnw1R/Sm7lEXgydw0auYuOByMnDU7fTms0+rtF/IoxcVqO/CoFuTDObY+B0l7+C5gNaEDQ2wJWPUqDc/i/CBTVwA+JqPlqBS4SeoMwf0JDLgRMGtBQ8wNA3n3jzAbTQa6RefPnGGc7KgEe+/aLubXwoV5CXiMaQT1+/+fobCQ57zJpxPnorO7N1nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+nUCKBCNejj0MqabvYeh8ASQFGvrMfNsbguryuzE8U=;
 b=dcMGFbvaDr9vJT8gSuzCRJMmXdmiyaHxA+Is1HwingLietyBOaX5g8eaU7wH6hRPSPvSqFOVS7q72S6ZESaIS+LHSFyF2soGusn8rpFQWsXXhLqF2Vxl+PsmNgZ20G+69pJiM3iM1BnedwefXK/QNEM1MUAXA90xcVxGpfHm7WI=
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 07:40:24 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::db) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21 via Frontend
 Transport; Wed, 3 May 2023 07:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Wed, 3 May 2023 07:40:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 02:40:22 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 2/2] arm64: zynqmp: Change zc1275 board name to zcu1275
Date:   Wed, 3 May 2023 09:40:15 +0200
Message-ID: <9b50c72c4e634b2c72758eed6275920eedbda06f.1683099606.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
References: <4ba0eb85629ec5f07902a93fb75d13fff9697eb8.1683099606.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: d2dcc2fe-7c02-4568-1f62-08db4ba9a7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /b5f6BgUd25DpE1uUg0OqNHXd8ryUAV0aqZCz0bfEV+dbgAJgJnWE6kuYDM6ndUKQKaecGGdCtSr4HvNHsZe+5ETODKzHdT2+vJrkK7edQi4ZO55nwmq2ufLnb0loXRFS5MOTpNrsVMRit6Klk576iXO37kofUAU+bhVvWeVCeUC7vylmsI2VSN+mjuBX0x5Q5GdmjW1Kw16D7TLiovQatYIKAc48rGld7+R1P0tZNpYGhgcypv9qL+1+9NrCnBvL1CD1l2S1b/LlsmucJpYyf2sMG3xfLPmqi2/+enNxCL0wNDEEHsm+VzekMHTiWmCTs3LdwpXm794jE1LWOAWaipeDoq+A5Nmy1DYX9wcgXQ9XkY8f3K+MZ7ATY7gKYiuGlD7JwqNl3I/B5m3PRy2JooPkOT6R3SO8RsiKRRFXPVmCuVtK7ZYrUjkHtXJn5V2JBif0Wn2DIcSaubkFpwEx/UFjIc2ZtNZO2bZv9Nf/rQMcAGGBCnXoLqQiEgy3MBFtlj+WG773iP84tUdSRqhNnHPsZrS3aE3xFigLip5nvWwpA67NuUmyRpQEdo2/jbxkUyZ/Q6gJK9B1w2LzOByxdUZ7EcYwJ3B2jqNArq4JQQ5STdVSRJpKJBsHZGGCoUb96l2xGTar9UJZ6zPSu4VfwMi+pOiqO1kbrrEjZzEXNotp+F7FnHR1UCeZ7MzyXA02MLKLveemKNHBf2IkqrZAIBB7sjtkLxjZyGSaXWUcp3zdrBrjwJ2U2uMqVuVJ26I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(4326008)(70586007)(70206006)(82740400003)(82310400005)(36756003)(8676002)(8936002)(5660300002)(2906002)(6666004)(478600001)(316002)(41300700001)(40460700003)(44832011)(110136005)(40480700001)(54906003)(86362001)(966005)(26005)(81166007)(186003)(356005)(16526019)(426003)(47076005)(336012)(36860700001)(83380400001)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 07:40:23.7961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dcc2fe-7c02-4568-1f62-08db4ba9a7c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal board zc1275 was released also to public which ends up with adding
missing 'u' to board name. Reflect this change by renaming DT files.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Separate binding from DT/Makefile change - requested by Krzysztof


For more information about board please take a look at:
https://www.xilinx.com/products/boards-and-kits/zcu1275.html

---
 arch/arm64/boot/dts/xilinx/Makefile                           | 2 +-
 .../{zynqmp-zc1275-revA.dts => zynqmp-zcu1275-revA.dts}       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-zc1275-revA.dts => zynqmp-zcu1275-revA.dts} (87%)

diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
index 686d50752b00..5e40c0b4fa0a 100644
--- a/arch/arm64/boot/dts/xilinx/Makefile
+++ b/arch/arm64/boot/dts/xilinx/Makefile
@@ -2,7 +2,6 @@
 dtb-$(CONFIG_ARCH_ZYNQMP) += avnet-ultra96-rev1.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1232-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1254-revA.dtb
-dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1275-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm015-dc1.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm016-dc2.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zc1751-xm017-dc3.dtb
@@ -17,6 +16,7 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
+dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu1275-revA.dtb
 
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
 dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
similarity index 87%
rename from arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index 676b8550a625..ad641e01ac7b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -14,8 +14,8 @@
 #include "zynqmp-clk-ccf.dtsi"
 
 / {
-	model = "ZynqMP ZC1275 RevA";
-	compatible = "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275", "xlnx,zynqmp";
+	model = "ZynqMP ZCU1275 RevA";
+	compatible = "xlnx,zynqmp-zcu1275-revA", "xlnx,zynqmp-zcu1275", "xlnx,zynqmp";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.36.1

