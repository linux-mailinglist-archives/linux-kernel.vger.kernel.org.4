Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E055E549A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIUUlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIUUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:40:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF39DF91;
        Wed, 21 Sep 2022 13:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjgW5u5vz2ysT77dCBfdHZCTOgQE7LeEwX2zxSUTc4j1R/N1K8KaYMRUd1yBhEepdWX8rE2jfawBkeQMGced1Aaxa+aaor5fwRp2fpZqNQpMp1gPTyVZ3yQlhJVEXRqb8+9xepkv67pta5IbNrsLqY7D0WGxkm+MqdfWGc+KieLzg9px2vX8pTARibGYbvGpKE3jjvrrp0Hjn7j4CXDk37bn+5K4q8Zc+LLGPGHdDkRxZrtH4YoEh1wIkepjysmEvhJSkfMlccca9+UoN73BtrNzMVofJ4HCrxF4ZJ9+9pjtZ1I5R7d8ddOeYjFKnG7LehmEMSpAno81CqK1xyrzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j08TOhv36F/p8hgL5sflLK730tx+jsN8nYOB5PstjXk=;
 b=Tdl5PjyPwZGqG2+RowLzbZdhPk27QgEt3QawB0qK77WkCK8oweXZPgmewsot5WyAIAY/iJ+IPuonHsaNR342SDcLiQPnRi66r0tutDvA95X6iJQ7SeDRnCCNhVue+55+pFP95JnhBhofBQE4EmFyCiBLN3km56vkuHbF273vVIYBuTDwbqp8T1PvsoTQTDHbE6MCfP9lvMF6dZlKX1pGCYOuOvvPTdPticA1Cx0kmEflgIYY4NIZMna1eypqEcCcWGDNobzcl5WPWj1fLB3a5Em6RrbLdgp//1PFh1SYNaUEuYNCaX/NMsbQJR89peXQ58EKNNVYnIWldn4wtt+dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j08TOhv36F/p8hgL5sflLK730tx+jsN8nYOB5PstjXk=;
 b=y8V0FjUSenJCWhoqumdNCL8GZkYWkdS1BUq7IXck3t5c5Er5/Zors2BOwo8J7IRSxL0kEs8JU1cb+zXZHT+6Na5zkA+5DbFot20xfE2uDL71i7kexig2D/UHWQy1wRm4Hufz3WKy4/RX4tkDMSAnTMrwoeWE+8aMz4lkPsaeXNw=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 20:40:52 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:8:56:cafe::31) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5 via Frontend
 Transport; Wed, 21 Sep 2022 20:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.11 via Frontend Transport; Wed, 21 Sep 2022 20:40:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 21 Sep
 2022 15:40:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>, <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, <iam@decentr.al>, <hdegoede@redhat.com>,
        <davidedp91@gmail.com>, <marko.cekrlic.26@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v4 1/7] acpi/x86: s2idle: Move _HID handling for AMD systems into structures
Date:   Wed, 21 Sep 2022 15:40:48 -0500
Message-ID: <20220921204055.22889-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921204055.22889-1-mario.limonciello@amd.com>
References: <20220921204055.22889-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6229e927-dda4-4f6e-4caf-08da9c1192b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Naac6fN0VnYkzru8snVNK2RHoLgBh+KTX+EP8Y9EUXG9wIir+zb9QZpJXZKLctnlptukYDMvDOusn3xWe9ARhSH+kIYWFHMM1tly28CkvSMJjZrzx11cENGlnO4/hoz1H6egggDdEOvNUX+kqkLJPO1diilcea2sIccwTMY++wUQ8NY7lXRBHTbXnnE/TBKyE7AJ7lAac6gv2ZHkREG3PxH1QOoAYx732zV1NHr1Sjh0o/ka05ceBq5FQtrseeQFemE5vQoiE0aP1tTJde7daHcbcX/tcx5n/3L6IQQSfVqUhTs5cy4MH2OdvTYv7l5fxzIGJcYupTqguxhDvPSnpMPSctx2ahN8N2T39qEyvHEhAq2sIh9i1GDengvxkEllufmDQc23Gp3cWKsdL9KAD86l0qUkXw8Aeoa1+W98kstGsRV7sINBAbI8v/p98XNTw2q2iMRo8kiXHYL8sC6wLXYeqesEQ/KOhaMAbuCW/CbXjDO4o6ZWU0h7pFCdXJ43V2hPOTuogqPIVdo0U0yYCDSjfgLl7bELCv+ztfcXsySGsBBEowSlgBWXywneaXOzfu3a0RwhVzLJgVN4vw6vMWsbw1i00RQJsh3ec+VCJSNgjveuAGQv174OpW49dTwsKiuMuk2aMdHIdast+Me2xh2wrZOM03iikTd63I1ldcSSpoU4Q+eL0zw/qnX623Kvvj5/AKGOBM93s+hBFTv7cRSN/hc2JInap36YQPtzlENzKT87UsaMh2/cmyjaxOzwi0XlnELY/zKKJ/lltn5KEDwamCdgEnPuJBpF0Hijf6xgE39aaPtJq6G0WbneTJd0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(2616005)(83380400001)(16526019)(336012)(1076003)(426003)(82740400003)(44832011)(356005)(81166007)(36860700001)(2906002)(7416002)(41300700001)(82310400005)(40480700001)(8936002)(70206006)(5660300002)(478600001)(7696005)(70586007)(40460700003)(26005)(8676002)(4326008)(45080400002)(316002)(54906003)(110136005)(186003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 20:40:51.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6229e927-dda4-4f6e-4caf-08da9c1192b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the information about which cases to use for what are in a
comment, but this is error prone.  Instead move all information into
a dedicated structure.

Tested-by: catalin@antebit.com
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
 * Don't check for != NULL
---
 drivers/acpi/x86/s2idle.c | 63 ++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b778e6..28a3ef9a6bc1 100644
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
+		if (dev_id)
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

