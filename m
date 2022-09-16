Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879F5BB211
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIPS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIPS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA247B4E8D;
        Fri, 16 Sep 2022 11:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8nEmGDRmZafw+U/3L716eV0kCeYa8X3A1CDpHRWkYVyWP1AP7N5SIt3+XDgVz2nkirPkvoqihKJLGCnTIoyv7ruuSCBG8So4xjniIp74xpCNdu1ixbnhnsOaHupan/Q2X6hVW5L3c9nGzp5Q6FeOVrL44Yv8eY1tB2ygqbanoCFY6yY4mgEULxI5z0tFqN6pGsiqcctHhR/SnkkfduTsvwe8PZt1lJVbVvYy5ca5qshwLIiYZGn3UbG3l4hVrVBEomtlB4TZQLklTqhrX45IMuHPAffxsocGyR8dor2moW0+3H/BulQofKdf7I4cCIzAVspb3laKj2gq5AWsDpv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j08TOhv36F/p8hgL5sflLK730tx+jsN8nYOB5PstjXk=;
 b=L5PzCQVFPfioe0Vp8cSS4QPoKl11eOUE2H4w1UpxlCHdmKNCXxIh++i5cKDmJJvwnvzWVKjoi37Jq5pQudFMSeUUrP0LW25mErbr1bRe338zdJdgjd+vN2C79DqIH9u/w0rsww1XbyujQpP/lZ4eGYLNrZO/i8GLJt4xGSxhg1GaUoYbAN8w/QCOOIp23xbQg4tPQdWlLqOptPwELKsMIL9JME3G01Srxx3Sd6HAnHiltURJOIgE194vsVjEOMW+H6LSJBVgMRVg/D6uijqLcoLqHM1s16N8pjs7aKCoXA4svPV01XMD/1Ssg7reS1X6yaLAPy/GSWnkpeWndqhaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j08TOhv36F/p8hgL5sflLK730tx+jsN8nYOB5PstjXk=;
 b=ohKHAEQZSvwZc4RwnGrdS6MfaEuKH0tRB8zi0MD1GBnNkdnkRUD4ynskzgrvwTQJLK48L+uRgS1XKNVPK53r4qGnBTuDnDyQYqjf+z8GIKrTmeTXtoJZnm1FVqqoj2kBSDGUfJSypikZlOw53XRLbFYZ6h1zPY+LUrmtDu+viyo=
Received: from BY5PR17CA0011.namprd17.prod.outlook.com (2603:10b6:a03:1b8::24)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:26:20 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::5a) by BY5PR17CA0011.outlook.office365.com
 (2603:10b6:a03:1b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 1/7] acpi/x86: s2idle: Move _HID handling for AMD systems into structures
Date:   Fri, 16 Sep 2022 13:26:03 -0500
Message-ID: <20220916182609.3039-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916182609.3039-1-mario.limonciello@amd.com>
References: <20220916182609.3039-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 63809304-0af5-4b1e-2d52-08da9810f378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgaK/RZ9phmSMceXPv3x51V+ImOldzLJczR95cw7lizLHgW7FKUyNt3mvPxkdjxJEaIs1+5icwAaI7CmTqMwxLWbsuEoimi7OV5473GexdzjJVoa58mfsFCY8LaS2Xmnq71QaoPZIQ2XDsKgi5i8/Bg20otPlMPR0XenrASVbbrKSCmthcEySrRCkxVwOr8BJJ6q1XPdxRGQcPJERNzKjcXkwhWlY0vD6LWWfDk9FaFTR51uFVo7mDbvjBYvRpZAIQ/1nE0foQCW5z9yEkBtzmm1AulkJMsju/x6wajH+g19ah4dTybxBRRuKMfmv8HUW+7hGCHbxhQqahG+9L8leo82X4ZijbPmg5WEHLuPrgBmSpJ3eP8jm1XI506hWoAeUYzLhIUa0BJ1V+7i6m3tPDnvU7DtP/ReRNuVOhfOP+KgH/KWJpBMQEUfc+zGbddITzwnT/rfCFODWqghXEnTFpYb+YnguXk9AehSKGbKtJcrUlnQ6F4xAD3Hi3E3HcYHWfjqraPwqZvHrm/FyOR6SOthUxcLQW7z8Fw+QFgbAVDerzop7fNIJybjYBxgVEIvzl2lsBaVvXRajY411wAokQ+pR2YG3IrMsOIWnZw7ZZ0rG64Qwqsn6L8nSBlkNQ+qoRVSanPOyTPhFCBS6nllUhYF45q0YG6KNEwaRbHksnUM7L7GLr6OnbGrJVMaYgG++Ei19TpWj2C3jfqguqttt6PRjINgP0AZjOUn15eS18b3chZ+2b6om5rsJ/pQq1eObNv1nE+zje+a2mcfW4YFC7CLkEq+Dp679F4ZV8mrrJBFpyyoaqE8+KhfIhS/a3Pv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(40480700001)(36756003)(2906002)(44832011)(82310400005)(70586007)(8676002)(70206006)(86362001)(4326008)(82740400003)(36860700001)(426003)(47076005)(5660300002)(7416002)(45080400002)(110136005)(54906003)(316002)(8936002)(16526019)(81166007)(336012)(1076003)(186003)(478600001)(26005)(2616005)(356005)(83380400001)(40460700003)(6666004)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:19.5640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63809304-0af5-4b1e-2d52-08da9810f378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
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

