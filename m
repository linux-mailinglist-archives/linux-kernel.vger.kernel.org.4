Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5A6F45A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjEBN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEBN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:58:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477971992;
        Tue,  2 May 2023 06:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9DefO2PaoIbMbtkoVBv31JNp0+7xiO2ozJrKndAQjIFXxJ5kZfxw0YqNzQ3TExx4XzP4HCZ/I11Lrybh4plDYI7sZ4bwZB++5OcgaoOB0rH27MK+NNeiL3zD5Gpj16yZHq+1dSQcmc5BQXQmZCOKR0KI3NZzXj7ydmbhwBA5ucKzlafn2F07D8Hndfm6KmE4d6Os+ciJ01uOG5Vr8nVWSIrOZV1zPn4RHuh/0G32IWJvkgGPhlXyatYPBiv+aJhE87NEBak3cSH+D9BeLqrGqxKeR82SnQHihlB/RMzv39Vod/HntA0w2LYkpXJIzKYVHBW6LAuapjLBxNGT8rQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh7pa9vhdO3G5dNtnLVwFGBTIMR3CqI79+Iuioj3BMU=;
 b=DGpykMti/ZVZUFY41vp4Fu5bI4lWO0iJvtxnpGNTkjSJAbKzolrbn6aEcuiwjvBsyIpY6lRuAzPrblEjEbV8QIMHQRxXgcaNCeSaDlROimyxYfqcdxQnB8yQ2XTDc5e3BWVb6rJTS037dbrb5uvFFxWHtV0knXLuBwW/MtBWe1kphpQx/1d7hJ51EMQDTg9o+M2lhElkJjU545ne5plehVSocrq8j+ISvQ+nQSb+OMHAGLsBKJEH3J+xPvSlPopar1R9udQqC77Gx0fGVSX0AYYXBi/HuR/8E+JYVfca1k//qhmHkVdYxY9cnvGqohED+po59AQ5gF86lctO3zepfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh7pa9vhdO3G5dNtnLVwFGBTIMR3CqI79+Iuioj3BMU=;
 b=oAwsIBJJRbF7/f54DHs/HQp8rMVdDi4odfFSF70d2gMnXKplfQOIjDrs2Xo4uqwYrIj6PzUXjPqKm7f8L1heYPL1aceD6sRLVZWOxnAfdEBbJBLH4PV+wTaae1lSQQT/BIRtme74kkvasXaxZCc7VoyFQSH6qrdy4NbNjKpMqQk=
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:58:20 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::44) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:58:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:58:18 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Change zc1275 board name to zcu1275
Date:   Tue, 2 May 2023 15:58:15 +0200
Message-ID: <79bc2c83929be5536cbf10883519e82cead21dce.1683035888.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|BL1PR12MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 110dcc5e-4889-4496-18bd-08db4b154998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCNG9mBiyB6yCRJzRFZwr/20wnnJMdrc7Mbus5qkqLm0gH3gzXRkCk5jDZ15QN72S8ZRJ4GicqjsZ5TtpB22drOxA/wqyS4AR03+dmc0HVJRmbeO+3A+1XuqDGgzUglbu/2BHS5ubJQnBc9yUIcETFgdQKFKcMb9is3teCL275Jw7Iji/KfTTF2DggWluynBy+al0piLq3CeJNYBKXL/txIau5oywp+PMIdXyAmwp3f/H2lw7ZOdYWOvH1gQ5cCBW17zhvvnJBDM+psqT5+6fVyH8IOJrCZ/C6/si+iKB8O1FKrnPcPE95llU2WQTqV1towKHUCK000tjCVTbuRoKvxy7CvftK+3a3NCxEzT6KMk5VPnAf3BHbP33uN7op/VQQl47cEbwQeIzZbUQsn0PsBvtOplizCqxx7IpLkm2Fzkx1o+X3LGFi4XH868Ttl3q15ADDMjZ26rgsx31aRlTGt7E1NVWAQmzAORJUUyB/oTeKsFP1JslpmXM9w5l69F7rGU6a4OaxGRFqX05EOXg8Ki3BD2nsPEFMEKW4GA4IaW/qPGpKb6IkAytN4ed8lgGbRztN4pOp5hCER9+YgvJrpWLf1nDs8sU6Z3uyWnXo5CkEFOQ5vKsqZFnI+125OkNvXn+Nq403o3NBmuY3/lyl0bexaovcedrLXk3tk/SBaVrTY9OTwzRvU1FYURQHIytbsFzFmrt1WegNgkZH8sQiRtVOxR3b9vSCClzswi/NnyZdXJrdrsk860Cs3eXXxz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(966005)(110136005)(4326008)(316002)(70586007)(70206006)(6666004)(54906003)(41300700001)(8676002)(40480700001)(82310400005)(5660300002)(2616005)(2906002)(44832011)(8936002)(36860700001)(478600001)(82740400003)(81166007)(356005)(16526019)(186003)(26005)(47076005)(83380400001)(336012)(426003)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:58:20.2439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110dcc5e-4889-4496-18bd-08db4b154998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal board zc1275 was released also to public which ends up with adding
missing 'u' to board name. Reflect this change by renaming DT files.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---


For more information about board please take a look at:
https://www.xilinx.com/products/boards-and-kits/zcu1275.html

---
 Documentation/devicetree/bindings/arm/xilinx.yaml           | 6 +++---
 arch/arm64/boot/dts/xilinx/Makefile                         | 2 +-
 .../{zynqmp-zc1275-revA.dts => zynqmp-zcu1275-revA.dts}     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-zc1275-revA.dts => zynqmp-zcu1275-revA.dts} (87%)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index 969cfe6dc434..b3071d10ea65 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -61,10 +61,10 @@ properties:
           - const: xlnx,zynqmp-zc1254
           - const: xlnx,zynqmp
 
-      - description: Xilinx internal board zc1275
+      - description: Xilinx evaluation board zcu1275
         items:
-          - const: xlnx,zynqmp-zc1275-revA
-          - const: xlnx,zynqmp-zc1275
+          - const: xlnx,zynqmp-zcu1275-revA
+          - const: xlnx,zynqmp-zcu1275
           - const: xlnx,zynqmp
 
       - description: Xilinx 96boards compatible board zcu100
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

