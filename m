Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8794628DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiKNXlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiKNXkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:40:51 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF312604;
        Mon, 14 Nov 2022 15:40:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkyL5ya1S6r+QEhGEEMCH2qoLSJcJFHJj9I6DzrPDlePqo68BCiW2rLRYhoukR8Hu9EjTgttprG92w2uQ25aLQn1W3I1mTvyWTDEfFxQLo39GE6njJd4tGDfohGMX0yUoq8EUOw2pAnsNFs2TKr39d97n6j+xN0El34damMN7XFeIDN7+9+al08+CZcc2cFAd92HPStncCGPMfpLFsMFC56h9q+SH99ePoUIDjF6qeqH0BfscKE60DBkymEPdEtbhmgGGwmBjQy+ZEvtZ6WPyBfOFNLZP86WXDphe2kDtJhOAZ8vW4m20hq1bz07RTJ5fkc6tim8FOrGTNKvfh2lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQAqUUEDfoFQHSL1LSSwTe8XScwj5IknDOcwkdo8sNM=;
 b=IJE4Ofg6TAk+c5wMgV4c4NxsVwmXfu4Zsg14oXdme5tZEJHp8X+k4i2QxU1mflO4FSAxbFUcdXRroOZx7DaTDlYCVkziKAtWo0WvSRCh5kNp2xiR8P3GnL+Nm28VoKyoizOkv1MtOGVSEc+1nf94OTGtBvdAonha4ZvBvEWAIh9L2Op4N8p7Hb0a0g7GAKoSjR+VwYlqpUMx3IIUR0b8oEaUbZ3KCeIPLW7UiEP7K948OQ85cfDyrHo0W9GeTPuxaB7D+5HFw95OjmruT1mDtwmDAdlUDGeHlTvT1ZnXgWMfMskrjP2Pa4N8fAmoK3x6XOgjkg1imGiEJ9sLtwuKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQAqUUEDfoFQHSL1LSSwTe8XScwj5IknDOcwkdo8sNM=;
 b=vZOSnHrJChlTIE5nCN3mL0bTiVy9xLi7rjdNSI7N+aUgL+B/TXf3lE6JNfCFi1PcHEjX1hJKd4X2JkVW2dMVEKXIIXoAIfxryuaQ4xjTwcf8fEgpYHMpbaZJmaN3980S0Qpaj0WN2ZD9WT+dfFdud8LjoAtP/s7eETA32MEqXoc=
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Mon, 14 Nov 2022 23:40:46 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::22) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 23:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 23:40:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:44 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 17:40:43 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@amd.com>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v11 2/6] arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
Date:   Mon, 14 Nov 2022 15:39:36 -0800
Message-ID: <20221114233940.2096237-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114233940.2096237-1-tanmay.shah@amd.com>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|DM4PR12MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: a9954407-4771-46c7-e3a2-08dac699a72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ1Lhr1gCUd5HohwKUtfa6BEu9/fAxWidFfrafNOmFVgQlgn503ZGglCpyNSYWcZvMuxyDlWpmsjnGXjWuSXrf64UuWgPablGihOQHfwP626JcLiyk+qvvdEvgbYBClJlHwZPph2ljCZMN8VepAtahJqpvE2LakZ9yJcBdbWmfic2K+GEoKp8/7nkyUicvz9Trr5i0MeImkOCYkrbP6Rakm+jPM0eUSNmZpe+EorIDZD4cr20zXLIcpBAGgyK90VeN3eMbT0cGXOG3PpnrZXlBPAxP0AEYDFvonuEyfvwiYnWagB6RYsfAlnQ37xYfemWDIT+giALV4xbZLk61dI9S6sQ4xhAzFZf26ItwZohkeIhEn6M0QEhiXiYxhhVZbgfI6gTcstRTPudh1n/kx1xLb5MlEo5G/9gugDOcDoYuaSA76kRQYIXH5dskATaZ9h07lZ+DM+h2qnzIbqjnUYYPWP0BoXDyVxbB2RGm/2MVONxIlcL0KiKC1I0DegzbGaP+R/lokvFHsKZwKYVSzzZEFj+yZ9rsGz8vLBtgdLUImeGDxHAqpf3lNR7lFNiPVBfarhahMjAUIlGn0j4W1vXInb0mgY/H45o9d0TNT1VQ3i4KU76y8pvB6Fe3giuQ0I+LGP1n8UryUlCd7t6P21B+E5VPWMGjce5eILdJZ0aTBQ4qB6NZXH9ZnRtukBs4BrZpOQr9d5L4mUco8CR+3S1ZWviFFCfrbKHts4hpvWrIzMXAQCFHt/dPLauuGVbODv9ZmgSUIUCagGLEHbZkrtiZWzxPK/MeT35AzeIA7Do7ABxfl461+VGK3QZeMuedhy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(82310400005)(110136005)(36756003)(6636002)(186003)(336012)(2906002)(1076003)(54906003)(6666004)(478600001)(47076005)(36860700001)(41300700001)(86362001)(426003)(26005)(70586007)(8676002)(82740400003)(70206006)(356005)(81166007)(4326008)(316002)(5660300002)(83380400001)(44832011)(2616005)(40460700003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:40:46.2598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9954407-4771-46c7-e3a2-08dac699a72c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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

Changes in v11:
  - None

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

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a549265e55f6..c0f60833c0ae 100644
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
@@ -203,6 +219,23 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
+	remoteproc {
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <1>;
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

