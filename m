Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071626A622C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB1WLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjB1WLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:11:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0D3211CF;
        Tue, 28 Feb 2023 14:11:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdL+V4fef+j/qSXreftDE022We7jL6tfRvvD8TBOK1vol/1Cs//PAPhhYLXtAGlalljNr5J+++dxRQ9QVLkmTtbT1hPGX5BXJux5Ul8cH1ZZY/kw4r06amg0nFQunKa1A032EMyXrdVH1Qh+2HdU5S/Vmqh9TysdOovXUAlOV86QO0Sn8VAcwkkOB+fM0lNEwFETbDbcdS0z5h1a7d+NTMgeIUFabbjX0bL50b5HypJt5MjFfT5/rteUk155kDztA78pseoCxlCCLlzamzoC4cSCkgt/xZbotXSupNuRECnEnJ6VXaxKVnnkCFWmfuSRqZeyTEge2lGNjUwl+mYIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMmEQnkm9ZbCrpvcqOdhQLyn5XCUVtaGFZZXNU0CydU=;
 b=EyCD9PPjzmPkZBP8oKoId1wf+wXitSPDPveLSCVVCu2DH1kzyfCknc/onIWO/9JFs6xQjzZk5utQnP9NYm1LigEQjSOa+Jhs3XeVLDmJkQj4R5Y5GqDQ8FHxEXZlZ829rJt1gu4t/1qgIm1coAKvIpaNDhzMNfvkNzZFblMD3SKb4qxCVJXwDQ3lPEnnEcYFZI9RfbgX5rroEDb3M9diUIbjXldMd+sAo4zEdq47xQayT9Hct8hIsTJ99QE6WiiTRt7ckuiwOI0B/nPKafrCJrWPhaFikkjXeLHQVEpT4tkOwCzpiIe+y1o1fxT5ZKdOuNQulshVBKajm3LRetAggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMmEQnkm9ZbCrpvcqOdhQLyn5XCUVtaGFZZXNU0CydU=;
 b=OIf9a3awkeKmIGammWtsm2/iuzZxWll2B/667Ej2Vggupm2O2+YD4ZxuIdKzFkpdWX0v3YUO/rh8uZBrcpidzojcLxBm5UGncmFwJAAOICPRczX504eXPv0XTkaK1x8Lqnom8KO1AeXei7tdvrmxiIEOsP7CGCKAEHOEjzqJC0o=
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 22:11:47 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::7b) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 22:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.14 via Frontend Transport; Tue, 28 Feb 2023 22:11:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 16:11:39 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        David Alvarez Lombardi <dqalombardi@proton.me>,
        <dbilios@stdio.gr>, Elvis Angelaccio <elvis.angelaccio@kde.org>,
        <victor.bonnelle@proton.me>, <hurricanepootis@protonmail.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2] ACPI: x86: Add Cezanne to the list for forcing StorageD3Enable
Date:   Tue, 28 Feb 2023 16:11:28 -0600
Message-ID: <20230228221128.2560-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d540ec0-f227-4a4a-5a6f-08db19d8c88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sxBOMDPU8mao/ra0BkpOe3tDe5ffcT+Xsv1MfZBm8FvrdwoRMlubAUDaKmPSoKsR86mUv8emRKjw54GVLZ+NNG4Hen63CmHYGCVFyOUkRBqRrvLG1TdwH7ddwgQeF0Boc2kGllD1xfsjWs5YgghzZvUGahFd9k8wk96Zz8FSt9Dobz+dbOTSxX+gGjPSHW0U4ds5lXQkNzO0DSr5SsWChIZ3L0oGZMLyRZ4Uiv1bbxdQOWVS4FIlOLng/7+QX8hNXE2z3H8zeHSAcd2+vf0HLNZBt5wDkU+L5R0aTXOoT4ciLnVAxXbY78tckwZh9ZpoD8aJZrNZflJpqILiu4BXHhDM318yZn3ETigzt+M8B3ByoSkPk4EuTJ4Mq9CwZepbqt4yWfpNZuq2XnvWLzwC5CkQLVdh4gy7eq0GRD85GHxvLieu/WE4mtjv8Uul7O1PlRVoRzug3Sx9PTEWL8x990izC2M1bbS7ArRNCuVmYi3Afab1vuwaZ/Kt87iZuSFNPEYodfwS33ls/+KhGWjuksvFXlz48WKZ607fFSEcbKrhTqHpyk/VVmJEohcuQ0Gxx1ToLeI4Z65k5Y6GrOjNn4088N/G+EE9H2lhXRKEp/C31diVXa9bdgkv4JWYKX9bKXcYj3CVpl6ZP0uC7b7rpGsyD1+v0A9akIweTh9qRztEIojX62aRTezTF+NY/jyZL6jKJHxVMVqIk4eR+vxQlKEZpofOxI6F9lPlnlY/VhlJDEs8ZRxZs0YnFsiObZmmKT7sL4FhJhzp+a0DeYPbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(36860700001)(356005)(82740400003)(8936002)(41300700001)(81166007)(86362001)(36756003)(44832011)(2906002)(40480700001)(8676002)(70206006)(5660300002)(4326008)(82310400005)(70586007)(2616005)(40460700003)(336012)(16526019)(83380400001)(426003)(110136005)(26005)(186003)(1076003)(47076005)(478600001)(316002)(54906003)(6666004)(7696005)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 22:11:47.0991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d540ec0-f227-4a4a-5a6f-08db19d8c88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 018d6711c26e4 ("ACPI: x86: Add a quirk for Dell Inspiron 14 2-in-1
for StorageD3Enable") introduced a quirk to allow a system with ambiguous
use of _ADR 0 to force StorageD3Enable.

It was reported that several more Dell systems suffered the same symptoms.
As the list is continuing to grow but these are all Cezanne systems,
instead add Cezanne to the CPU list to apply the StorageD3Enable property
and remove the whole list.

It was also reported that an HP system only has StorageD3Enable on the ACPI
device for the first NVME disk, not the second.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217003
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216773
Reported-by: David Alvarez Lombardi <dqalombardi@proton.me>
Reported-by: dbilios@stdio.gr
Reported-and-tested-by: Elvis Angelaccio <elvis.angelaccio@kde.org>
Tested-by: victor.bonnelle@proton.me
Tested-by: hurricanepootis@protonmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Switch to using CPU rather than an ever growing list

 drivers/acpi/x86/utils.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index d7d3f1669d4c..788b29ed9fb3 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -200,39 +200,28 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
  * a hardcoded allowlist for D3 support, which was used for these platforms.
  *
  * This allows quirking on Linux in a similar fashion.
+ *
+ * Cezanne systems shouldn't *normally* need this as the BIOS includes
+ * StorageD3Enable.  But for two reasons we have added it.
+ * 1) The BIOS on a number of Dell systems have ambiguity
+ *    between the same value used for _ADR on ACPI nodes GPP1.DEV0 and GPP1.NVME.
+ *    GPP1.NVME is needed to get StorageD3Enable node set properly.
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=216440
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
+ *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
+ * 2) On at least one HP system StorageD3Enable is missing on the second NVME
+      disk in the system.
  */
 static const struct x86_cpu_id storage_d3_cpu_ids[] = {
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
 	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
-	{}
-};
-
-static const struct dmi_system_id force_storage_d3_dmi[] = {
-	{
-		/*
-		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
-		 * but .NVME is needed to get StorageD3Enable node
-		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
-		}
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5625"),
-		}
-	},
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
 	{}
 };
 
 bool force_storage_d3(void)
 {
-	const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
-
-	return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
+	return x86_match_cpu(storage_d3_cpu_ids);
 }
 
 /*
-- 
2.34.1

