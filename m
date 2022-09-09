Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9353A5B3E86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiIISFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIISFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:05:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796439C1EE;
        Fri,  9 Sep 2022 11:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPIsXUd9X/+3j/HIJYhf2Wj48I54bMmtDvObts3NeXWZGv3tEvFq+0exIvDdFGPt7NmHJBxHoHkD7mNDDs5itKck44kmCM4s43IwyUyNVBVA3Ih9go5QdlpvbOOBjGDDYTFSHZJihTaSe0A2CcUPPmoo16V7Wp+XZ0qWYRIpkDv7spMBBHKnpXjQjCIWvz1Qjw1Akg6x8MSVAf8T8fG1YImuZH9DK3+dLPGCq1LZzd7ZMvlVIV58KS370UiuA7rCk1L4yfAhJCvbN6isyjLF4oraK4myI+avgDACRkHFJMZmn3SulMR2BOdohovVEqIEZtfY1ybY34w/ACBpS7x3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhFJrJW+CG7zhjQDljwvhx20SO8Rxv0eM8ClyPIVpvM=;
 b=J6ZC8vXgCMkERqgu0xgGIKObb6toxDF/FWVkZ30CmJWXnoa+NC6TwqH7is8WA8TkjWS1ia7BvLcPGSJ1TE4u4FA3dkNuprofuGKs8jUrvb5O3xtJsQJ0O/6qExlvJCnYyHtJvWeDVo9M3QUPU85JA+h4L3pZlEDWfMUlA0lYC7re4b84RLDEppCE5MsDUsRlBY6aASSMlENDHTZVe63Hra4/+Ms5KfN8yCSftVoH8+y52JLAuP5PDyQAeqBDvlvnzA5UHxvuCJNtg7YrXIFzu1MiRyDA7UNLgbnS4cfIGVfAcFQYQAhfCBMxzwnC4vWPsMWKwpovdoif4FSMltQ4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhFJrJW+CG7zhjQDljwvhx20SO8Rxv0eM8ClyPIVpvM=;
 b=3BlUaEP5ZxETFe95zVaEIDsq7dNSGYMyXW1+pqA3jvTzi/WDtH6Duv+aC/yzek9eH8aibcr3RIh288U96t/20Jb0N+/xSoKhGlxGwu9gHlhvNYnYwPxHGTZqFUgdtLb1nLnxNuzdzH4kn2kjGbV6vzkBMrEFruul7+FXrn+/Omg=
Received: from DM6PR11CA0066.namprd11.prod.outlook.com (2603:10b6:5:14c::43)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 9 Sep
 2022 18:05:25 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::11) by DM6PR11CA0066.outlook.office365.com
 (2603:10b6:5:14c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Fri, 9 Sep 2022 18:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 18:05:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 13:05:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/4] acpi/x86: s2idle: Move _HID handling for AMD systems into structures
Date:   Fri, 9 Sep 2022 13:05:06 -0500
Message-ID: <20220909180509.638-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909180509.638-1-mario.limonciello@amd.com>
References: <20220909180509.638-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: bee3cf1d-2628-4c66-63ce-08da928ddedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rpTqVXLpwrvskhzLMLgkkli2rX2aiQWLjGtfv3P0dBr6iABccfKwgwBHybL19cjCb0i8kRy4h+ddRO+CjhkcX+af4cn+PaNJABv7cIAoBFgW7ze1smd9sBZDCkfXjKtuei07Bq6b66b+hls9G0lP8fa4H0Z5z9KTluOA6xCl5+r9cM1h0j/xJ55SvZnCrlg9uQJFblYzkPD4nIUdAubAdCCpubT4G4jB6+uJY8CJv7sBW6rHOC1OJxda/0tTF2rrN6FzjOtBxVyro9/fUMP09PREbwDf/osb7WrjDXlOY0JjdS63PRFu+DHI7+moH+QtjB3CfUfu0n87/Y9cASoWiLZZkzzG3nr3KS6UVlnS17wpXgD1kBIzcWncu2UOCJvh+RGEZRRm56GRr0U0l4l6H1LvZtx9eFvIl+w/XXM+SKg6+a8vY56HOwi08O/9/9++CU08t/MXAwwVA0qNgOoMUSIQ+6IZUNSDxNQWMtm3fNqF9Iab19vuWSahDqcaagaRiM2tvUqNVrIkNIoJVJ7OGN894aVhU83rkiGja9mDc8dvvls/h3IhyYCIyEZDeMUoQys6D2yLj0Fu3EgMw7WmHliA57AvRQpsqmxEdXEfI2g2vRx9uQsZ2Vqly7da7cX0/EbmAKCZGTY7jimdA891FtEoAkunbMeA/09BGVnxVZlO2gdvcXxzJR4+3QSiv0DoBmmgYJXMMl3Kh3Ozg6C/vFgmfzrRQ1uUlFrzLuxaJgP9Z1dco0IyKgaMNUp8ykom9L2rQzKsg1bvwBWCyq7OBrEIZ/9f+KZau+rabQgmiV0WIQIXWsosFCCpRbknrzk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(46966006)(36840700001)(336012)(44832011)(16526019)(6666004)(186003)(45080400002)(40460700003)(356005)(40480700001)(86362001)(47076005)(316002)(4326008)(82310400005)(7696005)(26005)(1076003)(41300700001)(54906003)(426003)(110136005)(82740400003)(5660300002)(8936002)(83380400001)(478600001)(36756003)(36860700001)(8676002)(2616005)(2906002)(70586007)(81166007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:05:25.2372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee3cf1d-2628-4c66-63ce-08da928ddedb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

