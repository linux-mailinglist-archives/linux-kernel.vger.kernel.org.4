Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335DD6C29E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCUFfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUFfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:35:36 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA620067;
        Mon, 20 Mar 2023 22:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2TZceIACovO4U9L+T+KyTsUW8+hzaAUAsp+Irwx+UnSz81G8o7h7fP7Wc6IRgNPVYqiahQcq4vxI52adA9x5QKC6EpPtVMnW4tma61XHt59QnBhzFoQRvdHK2cWM6h7v4vkyoo1BGfz1LlsbMmyer2XvHz2YIwAhu0mpxVJljDtwzHznmwdhsd++3Ty6cjQ52UnUtBnyes3fPeS+gpmcRVRiYEq+Le2lEtgE4bRq2pnzIykwDAjBpsBHsSVm0NmrIyEm3M8YMZ6f5ppP6pcm5tg07Zx0xgSITXxEqQxE4gPZkoV6GksJC6+GHjZZHqud22ecx4IY3ln1ZS/gkrm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8loD21eoObdxkdy1USh64SVrdam9+M2IedaBGHLJ0kI=;
 b=PQVgTp8OE6AI2gfT6Hh9WvebDBw5BCaHxo0uXnqPl1lPbMU/37U0fD2c4j3jiUZ+C3bSRc954ZvKKMLqDiKQwA3rxm4Dp0QA5F82My8yOYVEeLHQ9NrE3we+5Ytisk3vZbOrvVIewGDwTI33Kd8lyyr7JHq2yrKnuCTPnhtYZWkTWij0rWlu3oEEItfDJWWn7SMFVPYgB17/g5vIBEMer88/yHffa8E/kWpNqFZQCsRdMV7Fax89ziPK6iZsv+obRwCIoETlrIB1D53xLQklt9eSlrNYo/XyyW3LE4LO9pwukhzo+6CVtBxgwdG7xeE1zGGNNmFfpoZBR3QR3px+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8loD21eoObdxkdy1USh64SVrdam9+M2IedaBGHLJ0kI=;
 b=JQEQQfn9WPMw3JJCJHzb2Usvkxie59nBpY1PixbfdYoRdX6LwB0qxFBzeHfq0EJ2Sjr67Xjk/US//KeIxgODDocWZdrSeACmVwWZxKRVuG6eZt56K8+NmKWvsye47k7Wzft3zYMXlot5A3+A3xHPlyQYAAR25HRQeNYwDSAyV+A=
Received: from DM6PR06CA0057.namprd06.prod.outlook.com (2603:10b6:5:54::34) by
 CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 05:35:29 +0000
Received: from DS1PEPF0000E64C.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::64) by DM6PR06CA0057.outlook.office365.com
 (2603:10b6:5:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64C.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:35:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:27 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 00:35:18 -0500
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: [PATCH V2 2/4] firmware: xilinx: Add ZynqMP RSA API for RSA encrypt/decrypt operation
Date:   Tue, 21 Mar 2023 11:04:44 +0530
Message-ID: <20230321053446.4303-3-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230321053446.4303-1-harsha.harsha@amd.com>
References: <20230321053446.4303-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64C:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a27238f-3e0a-40c8-90c3-08db29ce14a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Cm9wWpJMcJstTzcY3MoCJP9Br6GdlpCm0JMlpcEexSlNZS581tx2+jIRNxLmmF24bNDpgUBI/mVNn0nf6vY3V1xWAOSRtUsL3gNGiqqP7w6sEpJEiikrAh1q6LF/RoclUL3dKkjWt/2KMhaDI4hAvrQYr8Ve79wOwKeNU0V9pAT/Mf8LN33DXHQLayd4Es17MJvsIlsE8DScgr53P9Txx5ZjOM566QRH+pUR87DJ6HFxTW3ua6ejBATtnUFEx9g96Ec2+FXZ5CKEUaqGn928aJuGwt1g3uuQTQ7qCKESFR1R0+kXeyq4imHMDUIEMD2XoQdath3u+PoeYHOJMcQLn3GgA6k+B1Ao09+obhfaZtLzrAxvaztlzgn+OYwncYdc35+pi13zaWjs8pts8t39PzdTxnIvCBm/9DBoiY5+dVbQzu5Tr9irlyAnHg9BliXGRau8d/4uI+3c+8LjoVsbM0RTgV4cpUgE2r0drqDYXxZOmC57u5erJmTHzqjF2/Zm4CZ4HwKzmU13hFZ7rMm0LwT7AZUY+fXIxcMYeYiPTZyGD9uRKDXolm4Q2km0C5fo5vn4svwXaw51QxTvRpcrg7E2/8+0hqGDcVc2mZu8y8hdrInz205BR3etCV/SLzRid1cGnCTGdtJeDg699HHrmHYOoL4pjEZCo2/U1bvRk/QsatAOreWqZfxT4B47koMYI6wstxvjLaR8CYkNPLkOacj21UHF48xnO1KXFj5LMwVcrpd9oVFtRv7rSUjBNC+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(110136005)(336012)(1076003)(2616005)(26005)(47076005)(426003)(6666004)(8676002)(4326008)(316002)(83380400001)(186003)(70206006)(70586007)(54906003)(478600001)(8936002)(5660300002)(82740400003)(44832011)(81166007)(2906002)(41300700001)(36860700001)(356005)(82310400005)(86362001)(36756003)(40480700001)(40460700003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:35:28.8606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a27238f-3e0a-40c8-90c3-08db29ce14a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

