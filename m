Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523BF5FBCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJKVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJKVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6E6170F;
        Tue, 11 Oct 2022 14:25:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDyDF9MP/CpvaAtPjNDidocvoV0RvQCo+zog/3dxJ9cRmT6givEHVcbclAKV/aFlCD3FRUUntWq+sGeJ0lv7BlQQhPYfDCZizuqgNhQpCVt9puYJUnycVFMmVFYoN0cvfvfmU0Kf1fsUsXowFBoO6FgA+jEwPTdOxXoP9U9nICxAiYx1Xt43kYmzIo9TX7SCo0/E44ZgozT7JyKB4cnAbr/eiugPNCWleSjg60cA2IF7LnuCGdHB3rdvyMS2mCuZbpbevP3OVUgtSqCk2lYrlHheCS2d1TwkLs93wZ/cM1XVlXiiHe3KyBuPBEV2PymquTYyjjWSGRJd1VteU2dViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL9WdhuRKg1CFrL0pPQvKadz7dvKrVEYRn+JSaEUEBI=;
 b=FewCk6ztwY7OXp8ifqfFz6UmTcjlcuu+/asJ5aPZXJOdZHrj2uwgeS9QUEPCloFRS2EJ5MVRttfRkAXM5Nb0ilLltH2AMEOByK5S3VljC8eJcw6P2jETSBxs/x5RYhD1ewZaBbMZg0ZJonO01Y3BZ7oc1IAKeryEkeLkeKwkJlnGR4fAafM5r0xPAp+Aj9HKw3MOTeaSkmuoHQp+eAYFn1hviT5KusLlo1VRRBl6Ekb+ItfcXHwl664Z6rCjKxbhBK84yMv7NTfpNr/eZklHxQ9etG9EVDuhZ2Ro4q+7OhzuhBiVQ2lgXe+e1q3gx9xNih9qtIQXBYuajWf6ziVzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL9WdhuRKg1CFrL0pPQvKadz7dvKrVEYRn+JSaEUEBI=;
 b=lmjCsUcS+WywnWXgQh636CPH0+9xRc+Uh7Ppqop3MMRpxt+6UKSHZhS/xJTGjCMDBw0BktKnWBZjDVO4LXUBmGOADJWWBaLxcl6DwUBKZ9fDaSTf9UkDJ/7yMwn3p0N80T6Rp3LzAYIRwsT2rE6dxaw90Eu7+GUMcABdon9/ReQ=
Received: from BN1PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:e0::22)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 21:25:13 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::dc) by BN1PR10CA0017.outlook.office365.com
 (2603:10b6:408:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 11 Oct 2022 21:25:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:12 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:11 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v10 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Tue, 11 Oct 2022 14:24:57 -0700
Message-ID: <20221011212501.2661003-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7654c151-5a2c-4457-05c5-08daabcf1549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c12l69bAkC5q5+GZ4/u/EssBk/2J6trqCrU8QTVOr29qDJ/xiXrUQyCG90f1GWlkHa0zKpnhQ4bzPCsZLBDuGNTPYNCpQNnwJaOGJl8idDytvu9h3qJUKxjhmxGGkdo8hjUXDntt2b3kJm4ugM4jBxO2pB2bYz50ALecGgs70SgCNZqSPmx+4SzBEzRyaD1AvF5YgK8+DUoyhKkM573nnfj2GAnXyiEBfD42LXuk0OFoAHQrOC3uFpYkVTHlF/Mv2LnkQqwdGWb6UsIol6kAJ5OIHHSpSp3MIJ05RGiCzTavh1/5AKrd5qnm6CZtMftAZD7V3XYAiLFoMnzHdDn2pyJNUNgPwd1c1ansXNL6GR9F11i0LOvLtrTwicIbhr/CxBIvWNV5M4G06sKcJBZwlSGveIMoQ5mxqT9JseUBAG0+xg4eWpSP9rnQ1jEaacyz/xpLfP37N/1lTt8jGvUtnRtzULUXQImUsizwvoJG2B+69Hr2XTlg7ChRHWJJeQlBSY6zZxluCwESOieCJEkbOEvZCWgyq7sYvhSD2FU0+KKbX8jJihCug4mtIDxDB3wZGv9BiOBr4T2qw29Y8NCdfnA1o/yo7cKFR8EhsO1CsUpFeW0XpLXFpL1l83AfCdrkgUc6vLUagvUwF+Jr/TGc0TG0/RKcBLsjITw5V7eFaqnaFGTwCT6vevGrjB6gmBsqy9k0xfvx5w2prc89TnIfrwDytE3JlBYEBUpZAeCL6u9PkRGLpNDMF/7iqCaXPgcsKQzKbefk9y0iFShO+Ofa23yaV3fUwvU49BmalWyriwXDAiqkETcHDeGODbOuWxlA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(36860700001)(40480700001)(336012)(186003)(1076003)(426003)(47076005)(26005)(44832011)(36756003)(5660300002)(8936002)(2906002)(2616005)(6666004)(8676002)(70206006)(70586007)(4326008)(40460700003)(41300700001)(83380400001)(81166007)(356005)(82310400005)(478600001)(110136005)(54906003)(86362001)(6636002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:12.9564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7654c151-5a2c-4457-05c5-08daabcf1549
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPU subsystem can be configured in cluster-mode or split mode.
Also each r5 core has separate power domains.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - Rename node name to remoteproc

Changes in v9:
  - remove unused labels

Changes in v8:
  - None

Changes in v7:
  - None

Changes in v6:
  - None

Changes in v5:
  - Remove optional reg property from r5fss node
  - Move r5fss node out of axi node

Changes in v4:
  - Add reserved memory region node and use it in RPU subsystem node

Changes in v3:
  - Fix checkpatch.pl style warning

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a549265e55f6..cfb16413e327 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -100,6 +100,22 @@ opp03 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rproc_0_fw_image: memory@3ed00000 {
+			no-map;
+			reg = <0x0 0x3ed00000 0x0 0x40000>;
+		};
+
+		rproc_1_fw_image: memory@3ef00000 {
+			no-map;
+			reg = <0x0 0x3ef00000 0x0 0x40000>;
+		};
+	};
+
 	zynqmp_ipi: zynqmp_ipi {
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
@@ -203,6 +219,22 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
+	remoteproc {
+		compatible = "xlnx,zynqmp-r5fss";
+
+		r5f-0 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f-1 {
+			compatible = "xlnx,zynqmp-r5f";
+			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.25.1

