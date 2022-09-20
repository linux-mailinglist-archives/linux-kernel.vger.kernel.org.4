Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E514E5BDC61
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiITFYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiITFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:24:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C5054C91;
        Mon, 19 Sep 2022 22:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/Uhx4bDHOgjr9mJWbJ6QtXnKspIeOyUXp/MdaqldamovAQWG13MfxCQvF8mzQAAsof/MDGvWYnBI5HaqIv8VasQ6CC9uIu2BrUhjyhcBm2rIZtuBTcca+mBtddS602NhJp1oaGruioO1pERdhqonZXDW8nvKaH2/YPIlq3h20dxltOjAfz6Lm/HbBE+tCBBeWrexAOVgAd2ZHgF2QD6oL1F0GZAPVgRcWyx4KeGlcj0QceIoFJOYMDLP7KHqMUPmiN2Qi8iDc7AGDeeFiMFh5osctignMYoVWDirPbyjw+khgQxsQndsfy9GlI1BzrwqzotAuGlIayQ3kpkckNkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IGDlEnFis5My9QBLKzdET6S/p0U0JXc5+PPFXV5xco=;
 b=k5ZGmrQUWJojI7/srDYooqk0oPokcg32p0OFsANNpqaJVsuCkdSA+cMQtz3NfaOK197YVpHEWQ+V9JkAioxBgD1A83iQA62hV5wjbHj4EnrFVEhlM2SE38XKzYzYfxrkRWMRLpy2OWuKLwlVMtDshgEm7FvOXZqg/FsvLxBneBy355uM7veK717tLtK+EXIX/cYXpvqUFNNmMV4/BXb3R40JTn7yqnnxGNiU7tD3quk1v0trpHEh7e28PRiO0KPr/6GLUojBke15q6pM8QLqHKiqvlG2J7fzCn1lj3U0/kM49MBzaxPG2FarLi6aiQ+5Uh0reM4GPdWdVxulJjeVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IGDlEnFis5My9QBLKzdET6S/p0U0JXc5+PPFXV5xco=;
 b=j7hbZHhPC0VjiTafJx4Xmqiun1SEz/ugx4nCZEoVU8REq7Zuk/LgaHbDMMrYtUPc7YeC8yF283nyGPkuFhW7PgcWbz6JIUoNXS6qIcwJwXtkTLoWt7mzWdISF7lt30WQ3sOanjLiXwC0fCWIKt31rbZuypjIdxJfahTZoOJf+Hs=
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:23:13 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::df) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 05:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 05:23:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:23:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 00:23:12 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 20 Sep 2022 00:23:08 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <balbi@kernel.org>,
        <linux-usb@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <michal.simek@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH V3 2/2] usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug
Date:   Tue, 20 Sep 2022 10:52:35 +0530
Message-ID: <20220920052235.194272-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920052235.194272-1-piyush.mehta@amd.com>
References: <20220920052235.194272-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|BY5PR12MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 035c3baf-3c28-43ce-ea5d-08da9ac8372c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExIIJFZYmqB7OdL2yy3Gso7QztqJuTjYu+7nY7wpLOY3JryJIEgZXy12ZN1odITDhlgqO9iCpP1LkpSpcQf7/osJob225X0EFoRihP5gdwViBpUMAc4GBVoTAlOPaO+caCjvvvPNsnZAYmbS3ovsj1ohKs7bQpGeEmziiAZB6z1tPo9D66/R6xHGTSEc/k+HAW9J7Qu/ZITf6zKEwJwC24KA3gPYN0k1MinM9ieRIvWuRMRgpecwsytQgt9V9M5Y9qHQzB2R5h7Pd/koyF2nyy8UsRlHYHXSvl8q+MyJV51P+KhXVt61be8/Ng9pqZ1lVTPovPokwq6g6Dgmxd36P4KvmkWne+hcG05W10HQZRSdhDqTATg28niu7JCTSzi2hMC51NZ9RnzQabD2u7vMKidoJpPUv60nYsJDHJauM+wo0hYNLac5V4Edd1os6lLsYOPiEU5/UhjHl75nBDLCDOMl+I+bqJajV3/ih3bz9mfFpQqYS/TTi8Ai9AvCZbs32rC8KjiIZhMqGo4qWocBoB6RKGao8bmkjNm528ezWRVyY0tk7WgoVbZ1l9CFkWsccwxAiD/xWgCQDAfybTzxrAD8oAOVbjjOOidRFEL1hoTZVqJPq18ZUkToP7PytClaL4h7jRoyRLdTXcGkZ1iopTyENmaPwarR8L/sFHffhRea9F4y1IIXpQrRADr+PiLeWjnnkno+nNjTeWLqeOwp/E9XKu/j0adlPiWJ6iLcMb3XZC0/XHsj9zgwbA7Ggj99gagPR8S6AhTH20pvs/s7f9Uq95rToLQumSrD6JwE+9FP0iMmuxLwggAl290TOetF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(70206006)(47076005)(44832011)(5660300002)(2906002)(426003)(83380400001)(40460700003)(41300700001)(110136005)(316002)(82310400005)(70586007)(186003)(8676002)(82740400003)(2616005)(1076003)(36756003)(8936002)(81166007)(356005)(26005)(478600001)(36860700001)(336012)(86362001)(54906003)(6666004)(40480700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:23:13.5079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035c3baf-3c28-43ce-ea5d-08da9ac8372c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configured in HOST mode, after issuing U3/L2 exit controller fails
to send proper CRC checksum in CRC5 field. Because of this behavior
Transaction Error is generated, resulting in reset and re-enumeration of
usb device attached. Enabling chicken bit 10 of GUCTL1 will correct this
problem.

When this bit is set to '1', the UTMI/ULPI opmode will be changed to
"normal" along with HS terminations, term, and xcvr signals after EOR.
This option is to support certain legacy UTMI/ULPI PHYs.

Added "snps,resume-hs-terminations" quirk to resolved the above issue.

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

