Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F045BB213
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIPS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIPS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D9B5311;
        Fri, 16 Sep 2022 11:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqs/ktKKi+3urarY7cANDyqYtaBLtl4XyDKydlg+naoPd7pwk1DrQWs7CypepZbh68Kboi3t4YGozR2j7Vc5g02/1vymLTjUPCr7Yu3xXOHzret4jvMKStGDr1JQi6iA2jwk5yI0v0z3hvwlaA2gwjLei9oagSHn0Qzjxmyo5f2MQ8uJa8X3/yPY7EZ8qgNdy11kGPND3TKz0mIvSeRegjVyRYnHoXKn1oeKifJ3Hasu78+PqJBSjPgNMrJzX45yKwwEKkg4Mz+2dOoCJNYfy8cGInmWaGuLHck+kOVyKth5FB+A5/3Uua3hdyf6B4jqbTYwpn8sctJTCIppr7+R3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePyhivEEKSN3uPtWtOfk+oKtHUm2HMfkEgpNzEqPEf0=;
 b=oenU9iHIX9eywBrDA+RD+f+oWvfoVGVwMUdlip0J46OOfk9D4Y/3bJ0iKuDBnVONJT9TzTqfs3EXmWKpjn1h3Lzc0q192BEHra4IvykZPZljP4Kwgf0DCNE3WxwN3MImYT+fQXu6whpo+LR9K5wnrpMj7gREcaEXhquwXfwBhI5AYQwrV6WUJux4jibFb54KGMVhlO1PCh2YGOAIwIGr+HxnFEIls7+q2q9JrP+PyapHCvqH5krqW6WS3vUMVESDgpipOj67VlMcggpqlwcO2+/1z3xEKZZC7H9KW0W9jnZy/gMkn+9rCA1bv91rpi2aJQ6hAHhJ3tdnm28l5E80PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePyhivEEKSN3uPtWtOfk+oKtHUm2HMfkEgpNzEqPEf0=;
 b=z59Ji46or8KqtqcP2NFMJkdHvJhS6zsMzP79Qii0S36dx1HMQKw0Mbq2xc1FnUTNBnNwWXbS+U+jD8PGAePGwOpaVhvpydxau7mfCZiddUtwLxlV3Uko9VXfdxs3L3eQymWzQriTwdBo2UacJXxMYXXLV4Ar3F3SeFDb+6MwCPw=
Received: from BY5PR17CA0017.namprd17.prod.outlook.com (2603:10b6:a03:1b8::30)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 18:26:22 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::9d) by BY5PR17CA0017.outlook.office365.com
 (2603:10b6:a03:1b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 3/7] acpi/x86: s2idle: Add module parameter to prefer Microsoft GUID
Date:   Fri, 16 Sep 2022 13:26:05 -0500
Message-ID: <20220916182609.3039-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c79222-b286-499c-1b1d-08da9810f52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0j+kc7ikkZgPIRpfCxyy/qwi2NtK5YDAiTd4zMefAPBIdn+YUVd6O1uPVv2lR7tAiZJwyb0+euvV+EG64y9EjmzylbDgvCsH4Z+rRIUXJPGNl9hQJtf28S4ymLb8AzeC4E3kYufmDkolLVnUJyzSwSJSXUW6FgJanDvDtnk1pXQ4UvlEMLQv6J2XE39mNo9enKq+hidFWVu+sPvGWiVEyeaTuwtGDqbXanaiVLH64Ad4NRPl53u0K8FYw60Zv5E7va1JycBBya9faEWtzgctv87q8PksxWKuy82Tn3c4iVmdVBF1YDRAYEeTu2533uTDH4bd9AW3VYQWExVtMdB5c95Nq2lhRCFzOnlRcyZMqtwOy37UxBv6HhCG1UC9p51TWWT/oqJ7QulNpbDkm4inwKAhNsqAa8BQijgJ1ed2/XWDXCYzllP4ymAgeC0ePFXGcqWGfFz4GIoh/MEDeYOo3bIUEsTzt7mL3ooXB42W1PNboXvyzEza1O7dJOPqRn767IF8JcbQ2nFcTql143Q6bR/LDPmBKA7fZ+k9duFuRnBIGyymAAPWAoVALfYn6uzcxAC6BCXlHIpCrTUUKjZEAnJkkNgZgDd+Wqjhpzfdt9Qx2qNM3Re2KJS93msv5mPr44f/j/lx7CSqayik2RsoyIkYEb6Ui6bqNNCPHZ3gL/am3wZ7mbOaTEo0e9lJyYMsg1X530MdhlOtDkYqCqSVQw8sdSBGqbA+B8aXzEQfTYSFSh6hnVinStIb2M1U/7+aDBtV3twXCySCDnEx77gwEFNd1h0X5JVUGo4jAInSCdk6jeXJkB9wBLfBbtZlV9l
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(47530400004)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(52230400001)(336012)(16526019)(36756003)(40480700001)(81166007)(82740400003)(40460700003)(86362001)(2906002)(44832011)(36860700001)(70206006)(356005)(82310400005)(8676002)(70586007)(186003)(478600001)(1076003)(4326008)(426003)(8936002)(47076005)(7416002)(2616005)(5660300002)(41300700001)(6666004)(316002)(26005)(110136005)(7696005)(45080400002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:22.4547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c79222-b286-499c-1b1d-08da9810f52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OEMs have made some mistakes in the past for the AMD GUID support
and not populated the method properly.  To add an escape hatch for
this problem introduce a module parameter that can force using
the Microsoft GUID.

This is intentionally introduced to both Intel and AMD codepaths
to allow using the parameter as a debugging tactic on either.

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
---
 drivers/acpi/x86/s2idle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2c5931d247a2..127215150b84 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -27,6 +27,10 @@ static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
 
+static bool prefer_microsoft_guid __read_mostly;
+module_param(prefer_microsoft_guid, bool, 0644);
+MODULE_PARM_DESC(prefer_microsoft_guid, "Prefer selecting Microsoft GUID for LPS0 device");
+
 static const struct acpi_device_id lps0_device_ids[] = {
 	{"PNP0D80", },
 	{"", },
@@ -402,6 +406,9 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (lps0_device_handle)
 		return 0;
 
+	lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
+						    ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
+						    &lps0_dsm_guid_microsoft);
 	if (acpi_s2idle_vendor_amd()) {
 		static const struct acpi_device_id *dev_id;
 		const struct amd_lps0_hid_device_data *data;
@@ -416,16 +423,12 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = data->rev_id;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
-					ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
-					&lps0_dsm_guid_microsoft);
 		if (lps0_dsm_func_mask > 0x3 && data->check_off_by_one) {
 			lps0_dsm_func_mask = (lps0_dsm_func_mask << 1) | 0x1;
 			acpi_handle_debug(adev->handle, "_DSM UUID %s: Adjusted function mask: 0x%x\n",
 					  ACPI_LPS0_DSM_UUID_AMD, lps0_dsm_func_mask);
 		} else if (lps0_dsm_func_mask_microsoft > 0 && data->prefer_amd_guid &&
-				(!strcmp(hid, "AMDI0007") ||
-				 !strcmp(hid, "AMDI0008"))) {
+				!prefer_microsoft_guid) {
 			lps0_dsm_func_mask_microsoft = -EINVAL;
 			acpi_handle_debug(adev->handle, "_DSM Using AMD method\n");
 		}
@@ -433,7 +436,8 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
-		lps0_dsm_func_mask_microsoft = -EINVAL;
+		if (!prefer_microsoft_guid)
+			lps0_dsm_func_mask_microsoft = -EINVAL;
 	}
 
 	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
-- 
2.34.1

