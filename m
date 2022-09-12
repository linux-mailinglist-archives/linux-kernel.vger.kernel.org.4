Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9185B5F43
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiILRYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiILRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188093F32A;
        Mon, 12 Sep 2022 10:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ9YX1YXi28O5H99w8bHCNW+IYA5yOvPpGnxkoCuR5uxoCUZQPxcAauMHNK0USV8BoVG+UlNs9Gx5IZz9ge01ZJLwl37edWFJe5U6HhOFWShYelkPfa0WmfjL7Cx4pWT23xSG9fMBaH7g9OnmSZCTlqKu5nXW3eH/cuqCuDvefu4KtD+hzv4ieqwsikhdITCwBtVz4J+LosJTtD9FB4syt3M65F9qP0qWhSUR9ty5hiT2oFBVSJ6EJrtxqNTmVEKc6G902TRW8zL/O+OAZ1hGg+7048bh5NqAuSHaCPCr8jqJXb7cbrUJzLfx/NB/Gk5FKliut2dVhiLfG1Hwaj64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhFJrJW+CG7zhjQDljwvhx20SO8Rxv0eM8ClyPIVpvM=;
 b=VHXdYP8yDimTqrpoHRIcwunJIs1V0X7KIsYhu3V9DVzmpkcvf/YXWPTwSuVo2awk5PcxKNBZWaHLSqBD5kHX8QuFPssrsGfKlmK9FLz8Jq+NfMkU4SdKiRCATbHiZ1NFC+ZDx7LRf6Vvq6H+Q/t3N1E0qoKwnJlm0v0nbVaswWBJkTxFcNazoIA6dy+iqeVK/FfJSklS1Hx8PWweGRZCXjsM6Z6CoR1LrLTxea7R/t+Lu4Q9Xo/dTlwjksbaWRLSTM64Wq2HwxD63zB1A2EmgOOQmVvowo4TJFNhEsGt8Pq+5jsN2TH16rRjopyuNPovEM3g7+uXXSbqh81+BDhciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhFJrJW+CG7zhjQDljwvhx20SO8Rxv0eM8ClyPIVpvM=;
 b=pTU7KAOhRDfqrysOPVd4nBPD+W2fQQQwM4yVLj6f9Ho/guL+NGh8R0Sdi8gb6Lgg/Hd5NGS12OrER2qHI4icO1132AAok+g4x8UlLF+VFr8CHqQdL5H1sBVKBqxEFKnVz0EN+j+mxlRAfn8tiVLWPCGmU+1FrifARN1HYfMBtdg=
Received: from BN8PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:70::36)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 12 Sep
 2022 17:24:00 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::27) by BN8PR04CA0023.outlook.office365.com
 (2603:10b6:408:70::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:00 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:23:58 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 1/6] acpi/x86: s2idle: Move _HID handling for AMD systems into structures
Date:   Mon, 12 Sep 2022 12:23:55 -0500
Message-ID: <20220912172401.22301-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912172401.22301-1-mario.limonciello@amd.com>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|BL1PR12MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 618164bf-41f1-4759-d312-08da94e394d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKLtBIN21wfH6z/S6QXCMK3w38D9W/6br68Mt0wnNsv0Gbery76b/7sHLsgmooQGQNonZTuI5X+fupodrsYQ/qFhHkG3JRCwugyNWiQIRAiJFGna9C16eukJua6B3a4rB/qsyvtdqpW4OC2zqDaNCNmsFjR+Pxt5EIu0831BP247PtnDOdQpD951IVtVDANOzSZh1PXL/5DJdBxL/Csx0X/JrOi8U1yKbCAHdz1A5ViWiOOoq1v4cHh3nfUoBZ/Xfi4rDKo+O7+NgEkWeViDjifiUpS76U6HlDkYda74ooS2PG9nfSfpY6CB+v++BAE95c6KriSut+Wph1jk+cqO8ZtrcGoSqTrDGFSO+A2MSLJXJEgykteY2cTmX33JvW/Zz56oNB/Oh1AYOKhuHBaxVMShTYBJJF/+fUDQp/tEB+LbztAeDMokZym5wbgtQgpM/rN/xquvTx2kfBMBORfwibFXNsc3Nfr3d6EIYl/q3Fr4BEdPPNuANhSbKZ0nsS36rW1qYc1SaNWuc+CsIuYtx2mUeW54umtrqdWrWhHrzw/3vomnmJyB3EC3Cmx4vKeU0V99NStrxhag2gJz50k51lGJjFbanWv6Xb/ur0G2q93WrW442+8g4g4U8xTcwlTnhV+loVpxdpFSLW5r3KFIdcSzECnLiB3lTfyCwtanAYf1a4b3nTQejq5HwqiKXCrTGIAbjRk02XMl0OMS2MktesvCfHperjmbcyt48UCJJp1nfeGF0RNGz6cDjVJlwoAnX3JTofdF9rNytzOSCfQJ4m0PdoEwPlzzMuDWD1cWPBf29B5BbjJByOiO1q0ZGx1q
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(45080400002)(316002)(16526019)(186003)(2616005)(47076005)(82310400005)(41300700001)(26005)(336012)(1076003)(82740400003)(2906002)(70586007)(81166007)(8936002)(40480700001)(70206006)(36756003)(5660300002)(8676002)(4326008)(6666004)(7696005)(478600001)(40460700003)(86362001)(356005)(54906003)(110136005)(83380400001)(44832011)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:00.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 618164bf-41f1-4759-d312-08da94e394d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the information about which cases to use for what are in a
comment, but this is error prone.  Instead move all information into
a dedicated structure.

Tested-by: catalin@antebit.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 63 ++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b778e6..a7757551f750 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -363,6 +363,39 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
 	return ret;
 }
 
+struct amd_lps0_hid_device_data {
+	const unsigned int rev_id;
+	const bool check_off_by_one;
+	const bool prefer_amd_guid;
+};
+
+static const struct amd_lps0_hid_device_data amd_picasso = {
+	.rev_id = 0,
+	.check_off_by_one = true,
+	.prefer_amd_guid = false,
+};
+
+static const struct amd_lps0_hid_device_data amd_cezanne = {
+	.rev_id = 0,
+	.check_off_by_one = false,
+	.prefer_amd_guid = false,
+};
+
+static const struct amd_lps0_hid_device_data amd_rembrandt = {
+	.rev_id = 2,
+	.check_off_by_one = false,
+	.prefer_amd_guid = true,
+};
+
+static const struct acpi_device_id amd_hid_ids[] = {
+	{"AMD0004",	(kernel_ulong_t)&amd_picasso,	},
+	{"AMD0005",	(kernel_ulong_t)&amd_picasso,	},
+	{"AMDI0005",	(kernel_ulong_t)&amd_picasso,	},
+	{"AMDI0006",	(kernel_ulong_t)&amd_cezanne,	},
+	{"AMDI0007",	(kernel_ulong_t)&amd_rembrandt,	},
+	{}
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -370,31 +403,27 @@ static int lps0_device_attach(struct acpi_device *adev,
 		return 0;
 
 	if (acpi_s2idle_vendor_amd()) {
-		/* AMD0004, AMD0005, AMDI0005:
-		 * - Should use rev_id 0x0
-		 * - function mask > 0x3: Should use AMD method, but has off by one bug
-		 * - function mask = 0x3: Should use Microsoft method
-		 * AMDI0006:
-		 * - should use rev_id 0x0
-		 * - function mask = 0x3: Should use Microsoft method
-		 * AMDI0007:
-		 * - Should use rev_id 0x2
-		 * - Should only use AMD method
-		 */
-		const char *hid = acpi_device_hid(adev);
-		rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
+		static const struct acpi_device_id *dev_id;
+		const struct amd_lps0_hid_device_data *data;
+
+		for (dev_id = &amd_hid_ids[0]; dev_id->id[0]; dev_id++)
+			if (acpi_dev_hid_uid_match(adev, dev_id->id, NULL))
+				break;
+		if (dev_id != NULL)
+			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
+		else
+			return 0;
+		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
 		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
 					&lps0_dsm_guid_microsoft);
-		if (lps0_dsm_func_mask > 0x3 && (!strcmp(hid, "AMD0004") ||
-						 !strcmp(hid, "AMD0005") ||
-						 !strcmp(hid, "AMDI0005"))) {
+		if (lps0_dsm_func_mask > 0x3 && data->check_off_by_one) {
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
-		} else if (lps0_dsm_func_mask_microsoft > 0 &&
+		} else if (lps0_dsm_func_mask_microsoft > 0 && data->prefer_amd_guid &&
 				(!strcmp(hid, "AMDI0007") ||
 				 !strcmp(hid, "AMDI0008"))) {
 			lps0_dsm_func_mask_microsoft = -EINVAL;
-- 
2.34.1

