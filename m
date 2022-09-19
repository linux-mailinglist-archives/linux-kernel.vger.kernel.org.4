Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63C5BCA13
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiISKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiISKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EFA13F78;
        Mon, 19 Sep 2022 03:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFGVRJ+OMqANW1vET0y0oC3VsuPTZVzUQlWpTmPXB6ZG5E8WHDFvH2Zg1oTnF/Rvtew3JBytjdr7WnRwLflsR2dYxqObchuhAsr321qs/rFBMp4M1iKgwNE0mEA4Farczph0X/FfDvd9lmbK0qCItOlJyx33Nk1z200ARC7LRuAsNUSZ2KeZBkK7g1VQkex3EXTQmfNLLNGa4CIzlh0gh4SqyenGLsh7OCji6Rpo509gu1mtQUpG61b5IBX0JO95qHeEw3KONcHZ42OorCnLIAydbmVJtXdat46R99Zav2qsndYdEn1Y1TFDF3Bmuzo0CE9Mcicaqyc1j+jc1VETlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CM3uk3gWLluGLjkU/4O3koDYShn75wP5bA+o4s26nUU=;
 b=b0bJqgTU/yr5j1Jhzx1TEl+6yHlgfmcpWalJTuw6iRSbZ1mLXfuyNK+tSiKRYhN8hyTkaOFXEpekB/vCqQ+YdcfTc1rXtozn3peynY4Aqx+UAbt95BWB7/GPXQ2L8UY8FLa6aPRUakHRRNQvmsbj2iN2V+m9k9IqSSkXoPJjJLGK3S9so1pUU+NaVEfeYBSAVdBsbixry2pNLsJ8opXjWcGHcmgkCTfp5Qdydk0frBokdgfNwQe/xcMvN0MSGEFHzPXFO4Cbhf0Hxm42raAk/hQKdDqxqVGk0wraqREUnta9sr8+Miirw7ouvh8NlNI+M/b1W+k5RnpgWKVhaXl7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CM3uk3gWLluGLjkU/4O3koDYShn75wP5bA+o4s26nUU=;
 b=j41phENfUugx8n7GhSLapFyMsd9x49/OX4oBy4x8JNy2nT0R930LcTXluwZIh3r8NKP7OZMXRXxqdKvViBnL+VJ7bjyVjIEymNgQod2vPhUNdwI2oxuXYzlSZclm9VPDCWCjYsjfOCGSN++uJ5Mg6ymDmHkQDw6M2188Q5si1WU=
Received: from MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15)
 by DM4PR12MB5262.namprd12.prod.outlook.com (2603:10b6:5:399::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 10:49:17 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::d4) by MW4PR03CA0070.outlook.office365.com
 (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19 via Frontend
 Transport; Mon, 19 Sep 2022 10:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.12 via Frontend Transport; Mon, 19 Sep 2022 10:49:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 05:49:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 05:49:15 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 19 Sep 2022 05:49:11 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V2 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug
Date:   Mon, 19 Sep 2022 16:18:16 +0530
Message-ID: <20220919104816.4075019-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919104816.4075019-1-piyush.mehta@amd.com>
References: <20220919104816.4075019-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|DM4PR12MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cff7ea-e465-4210-3b14-08da9a2c997c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9D3yHvd5zzbTFMC6MpxPRTlpZG866FOxzCvRmpz30VT7tl/AayaUvri/xbI/Je3PTuus/sOjjN0UGLMnE6H543Njh38H/VRWxCJZNk0fl3UpSWU8aJH6JRh7l9OolR8em2YYcpxDu19O1otUgjNU9LJySDmP0aZvUvfGPcaYzVesDcv052ZPGSB7mGx2z/wYaqcWDfCahsrOv4eknRbpCQB/iMNe/fxn347befaWxnCp/5WqynQdAItQ+MxVkTBByf4b+ThManbRLlMuIIWE5b+3Eyqu/+98XqboTdtxlGNWdKGxcV0yqc8qmtYl+zJk7RN7kEyrI7733BRjDPfAg6zHCsmhz2msoSESMg0Ey8ku/aUVJYaHlWG3hA069u8Nz/guIns/Vxbz1bgZYrTR2yz4UoDqKV7cHDl48akr4hBtbGicExRR8/t6FwbbToBlxVY1aJGWxg/hMtWbsTFsUyFw+c91wYVu5JQYExJQnYnoFkrSDF6XomIKZLmEy3r8rJLPSJAhqgXZ0YvqhZRrEiu21vMipNZyRrlI8HfS9fcB6b4Fca21ZQro6Cb5PTMfX/W44jpA1MmBGzyNYkcu723VIlEgmuPRlgjpudlJ3CElRos+1rxc1aN7886KbCwPs2sbYvPydytT+uj1k0RhznXS2FXs6Zy2qaVGafhJ6E3F+WdJjJlU0l4SF50l9TYnpKqCzVdj+jN+arOkHP1Olqm0zpjVgDnrf12X8nYYuKKbeM69LyM54cvT1a7eJ5R+nZ6MlulXwCAZE4dg+8jvxiiK/pJXQaNDfbVlKRcvDqZFbbUsl8oyCxRyKP4zorz2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(2616005)(2906002)(1076003)(4326008)(70206006)(70586007)(82310400005)(83380400001)(8936002)(47076005)(336012)(186003)(41300700001)(426003)(110136005)(54906003)(478600001)(40460700003)(8676002)(26005)(81166007)(40480700001)(86362001)(356005)(316002)(5660300002)(36860700001)(44832011)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 10:49:16.8765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cff7ea-e465-4210-3b14-08da9a2c997c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5262
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

When configured in HOST mode, after issuing U3/L2 exit controller fails
to send proper CRC checksum in CRC5 field. Because of this behavior
Transaction Error is generated, resulting in reset and re-enumeration of
usb device attached. Enabling chicken bit 10 of GUCTL1 will correct this
problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations, term, and xcvr signals after EOR.
This option is to support certain legacy UTMI/ULPI PHYs.

Added "snps,resume-hs-terminations" quirk to resolved the above issue.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/core.c | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8c8e32651473..7223074be6be 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1180,6 +1180,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * When configured in HOST mode, after issuing U3/L2 exit controller
+	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * behaviour Transaction Error is generated, resulting in reset and
+	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
+	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
+	 * will correct this problem. This option is to support certain
+	 * legacy ULPI PHYs.
+	 */
+	if (dwc->resume_hs_terminations) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_RESUME_OPMODE_HS_HOST;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
 	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
@@ -1523,6 +1538,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->resume_hs_terminations = device_property_read_bool(dev,
+				"snps,resume-hs-terminations");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..bc5ac4d0d61f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -263,6 +263,7 @@
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
@@ -1096,6 +1097,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1311,6 +1314,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
-- 
2.25.1

