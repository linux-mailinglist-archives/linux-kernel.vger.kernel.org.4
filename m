Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB269B836
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBRFi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBRFiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:38:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB41474F4;
        Fri, 17 Feb 2023 21:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5FsU2+Q7/LyEDfcTYEHEd1goBN6IscJYacMaykB9eHzMRDK6+0GJZNWRgyB/ntRnrs3/EdX7WgwJw8ruzZdEqL4CNQRQLKzfWG/0kfkuNKHd6Zd3+cXHVeQgRWtDVNRCL+1Eq86IMEUtFXpCdsGFGX/HbXXrKXMBhuMtsSE6ksrHpS1BSiocmj2OfpaZTN8qWewFbYv+tPXZOtZne0nwgxrqJZJWq1mNItrDXefoaYER8G0ei8ydtrXh0UoFkbIVh6OjWZSZJxKpnZmlzLyOcY+ebqH1+CqvLkD2kGlDmE0XQyfcVFi0oF1GWJGXRfQNOw5vJ4NeQUGWqV5WPsg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8loD21eoObdxkdy1USh64SVrdam9+M2IedaBGHLJ0kI=;
 b=hdYAxrPAZaeVBNPLeWVMrzWlN/aFpoEA9wyBFe+b5Gx09hpAUuCvfoMB5vUCU0N5kvm0wU6ufj7mUsKRRYlasamsIPcnIM3U7DUMGmj62EgnGz6HGvPfScAjocAx1amKxFDWfKhg0SeYo4ZSmj13aFjR0jP1NVGFLSIkiHbX1+Rvcurh3dlV6u5gzLT28NRBo78dDPAHO799meFaG+DFVuycVjObIS6Hhndxz2wUT1exiSyBEHCrL1VmVZ5YAyHkH8DMFxmzagUNwkbogk6Xav1ArS+aN/B9urfaXaSfKMd1H9eKO8vLQVjwp6/xt3G2aYjTLwED4KADC8RJVuvM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8loD21eoObdxkdy1USh64SVrdam9+M2IedaBGHLJ0kI=;
 b=JRDbIiyHOWfIQV9Opsyj72ow52ACr9nRee9v8n80XVrvJVNxmrhpc/JYovyT3CkMQH2hMbpbq0NXZ7Obr3lzkK4E3/ByWoBjU3R2mKC4v/8A6ObjJHIq5MLbvwBDdnwuHzlvTAqTguLCFC8P2tGdJqWAFzmU2fZkCAjQou2DdOU=
Received: from BL0PR0102CA0046.prod.exchangelabs.com (2603:10b6:208:25::23) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Sat, 18 Feb 2023 05:38:42 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::18) by BL0PR0102CA0046.outlook.office365.com
 (2603:10b6:208:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Sat, 18 Feb 2023 05:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Sat, 18 Feb 2023 05:38:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 23:38:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 21:38:39 -0800
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 17 Feb 2023 23:38:37 -0600
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: [PATCH 2/4] firmware: xilinx: Add ZynqMP RSA API for RSA encrypt/decrypt operation
Date:   Sat, 18 Feb 2023 11:08:07 +0530
Message-ID: <20230218053809.1780-3-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230218053809.1780-1-harsha.harsha@amd.com>
References: <20230218053809.1780-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: b555a1b0-6e24-4009-e415-08db11726446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfaPsC2Q9R8l1I3gMnHcauFc8bdWoUbhWHNNPqKAVuaQaEbG85SdAI4m7iV7Y7HEx1fyOVvV+2XdRIrEme/Bo36NGeRaVQz6nWrYh7F0pgwT3JE0oSJNN2kWekhxxZBaOfijfcuYSLVukzULMduF6UMUh3FM8Fm5R97LaH7OmvZUhtf15OUeTy27ZFDRUSeMmFTZAevNUT1VAM0cPryzvo0HusXtk8X2AXh5C6YUv0HpAk3XcaXzSLLbU9ofqf57r+CnbvBSCGO2fBV9eioH5/4Kv251CwIZ6aHe50X1kZ9WE08NqTACFmomRryq91P/ZHXDrOcuQrV0cNt04Wv6MNSLO54a4+6A9qJBVL2U1Qlefgn+ILBbCPEmFogJqEGsq24zB//uG3QoMtaG0DmNA4jYpf1F5o45/9cM4Mc6Gmhe/xJFIS1pLN/Pax8W1wFLiGA7bhaeHHtIxzVx+4MVHkHxusudYemDyI0TRVD2kLX1wBDRWkCu4Ec7+IpgECNSAsN5AqvGy9KdV1W3BBLFzelSzwzV+v2MWIggO2xdzp+DC9utPeHz8Ju+jbEJ7ZpiPv7/JrGQeHhvfLKKOPM9V+UNnm95chDRSRNUjJsdH2SneFxLeS1pMvambuqBIQs8FywjS0VOVaWPzMa4nmBxun/H4dh+uyjnh1YXs971R0LUzfp9249Bx5tmNQCHxHoAo1h2em4TV6Fobbt/l1ERz56qnM97J8aIiEza+7CA0/nDydWuL3LdHJY2qmuc5+xF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(2616005)(86362001)(336012)(82310400005)(6666004)(44832011)(2906002)(478600001)(426003)(186003)(1076003)(41300700001)(83380400001)(4326008)(26005)(47076005)(356005)(40480700001)(40460700003)(36860700001)(70586007)(8936002)(5660300002)(8676002)(54906003)(110136005)(82740400003)(36756003)(70206006)(316002)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 05:38:40.8900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b555a1b0-6e24-4009-e415-08db11726446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add zynqmp_pm_rsa API in the ZynqMP firmware to encrypt and decrypt
the datai using RSA hardware engine for ZynqMP.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
Co-developed-by: Dhaval Shah <dhaval.r.shah@amd.com>
Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 21 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 10ae42a2ae22..d6f73823bab4 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1426,6 +1426,27 @@ int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
 
+/**
+ * zynqmp_pm_rsa - Access RSA hardware to encrypt/decrypt the data with RSA.
+ * @address:	Address of the data
+ * @size:	Size of the data.
+ * @flags:
+ *		BIT(0) - Encryption/Decryption
+ *			 0 - RSA decryption with private key
+ *			 1 - RSA encryption with public key.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_rsa(const u64 address, const u32 size, const u32 flags)
+{
+	u32 lower_32_bits = lower_32_bits(address);
+	u32 upper_32_bits = upper_32_bits(address);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_RSA, upper_32_bits, lower_32_bits,
+				   size, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_rsa);
+
 /**
  * zynqmp_pm_register_notifier() - PM API for register a subsystem
  *                                to be notified about specific
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cd5acfa29cbc..8666b0c3cd66 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -117,6 +117,7 @@ enum pm_api_id {
 	PM_FPGA_GET_STATUS = 23,
 	PM_GET_CHIPID = 24,
 	PM_SECURE_SHA = 26,
+	PM_SECURE_RSA = 27,
 	PM_PINCTRL_REQUEST = 28,
 	PM_PINCTRL_RELEASE = 29,
 	PM_PINCTRL_GET_FUNCTION = 30,
@@ -542,6 +543,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
+int zynqmp_pm_rsa(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
 int zynqmp_pm_write_ggs(u32 index, u32 value);
@@ -744,6 +746,12 @@ static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_rsa(const u64 address, const u32 size,
+				const u32 flags)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
 				      const u32 flags)
 {
-- 
2.36.1

