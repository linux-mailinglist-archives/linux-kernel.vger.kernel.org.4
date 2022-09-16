Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80A55BB216
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiIPS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIPS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0116AB6D3C;
        Fri, 16 Sep 2022 11:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfOgNSx8rV1AR5Z41uTeCXPPHrHvkJ8NDZb6C5c48Ewyv1LZ8G/TTxCowRT8HSFAe/IVxu8weUIPCQ7foToYzfFGFf9HJD4/uBljwl/hAmcLe7OfHXHU4iHe3bOZnw8xLFp8Nn2xnbwDJrsrDTE5wgSjkDGKM+w1UtfANP2El3BhN50om/37Pb6Xa6mPM3KN33b4RqlFywL+KbTOgEcSj/D8+LbcZck8+aBF8k23w8t4sRaFSQgyo84j6gD7Y7gva4EGJM8jT3p/wUmmBVHn1hm10DKpdfR/hmQtr3A5wxQ8uyK7kY4FV9dDaKoDdenmjvn9hpqieDvjURr4bIEWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b2/Owgi2BwWHOWGXd+TlPezx3gF6ZA2SaTGT8qvrhg=;
 b=gz7uqLBFtr6phHk/DHWqJ8K1yYAXfTkmQ54plRY+jlvYDD5wTGy89jxnmgsQXBIiEt+JJJHB1EWq/UggKDzCohLBWhk/ONTeT9wZKRWbxJBK5pVq/EDy6fTKmSErNXhP7LxQ6v1BGCvtFaDghPoL0ZUoFvN4IDw2/4h+vAvmN8eh8WNhYuono19ayC/PEh9GsqYwfEtDCYs6bDyKAoEgNHO3kF8/ZWYazrfpG4OdJTkg/RpM7qyNN6P+8EcufmV15Pj12VIXsCRJaPTdCei0Ps52RXFccdTjSlELHceyaNTePdu6ccAam1PwaKd3P7hkeeLLv0j520xxfRngX/jkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b2/Owgi2BwWHOWGXd+TlPezx3gF6ZA2SaTGT8qvrhg=;
 b=iP58SrQmp7BBl0obOCP5cgqqNLJDGek7stRb0fyKjCsppkWDj7YtSmNa9Q+5fpjxcUdwxgBRT+p3gsq8tn5fvdf5H0kvdVLj0O/RecEaNLiYNWeChKCxgAErLcOF5u4Hvr2rBb7lmeXmChgPU1v1FCiqDkhP1fBqwluicqk4MZE=
Received: from BY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:a03:1b8::17)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Fri, 16 Sep
 2022 18:26:23 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::59) by BY5PR17CA0004.outlook.office365.com
 (2603:10b6:a03:1b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 4/7] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
Date:   Fri, 16 Sep 2022 13:26:06 -0500
Message-ID: <20220916182609.3039-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: a9524431-0e4b-4272-02de-08da9810f593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5LGHM3uSH8yLt8H5VwBnNHu3Zc89BUoSU15uW7Rnj+DIQvhlZCPJEFe4EWXyVgmuUAEj6vJ7misff1Mg2QT7YJgbYQNhujqgkLncGSWrcnW6z0P/YiIPVocmMqk3dJmAflURH5zCOtRwxXX46SOd1U2wJBsiupMW/h5VHDAdMHzOmie+FCMEQr932lS5/pBibwXfNGgunXHeuo5Pncv5tpcDHIklROLiGyxTJTCIJhiUMH5Bv+dyEqA4gC+6iWBlsYFh+Y7zNx527zg3KkCQ98MR/Jc9gLS+RXvJJIh6YMt9pdSkShYERA2cKvKBCFR7kwAXqxL3r6Bmd4ECIib+qt9JzZuQ13xCqEWcXM7oOHe89rKJQ+1fx2fctVRP2XJvF1yzMHdUq/GsEvuvZkqB/yUGICmU68hpPCt8FROjezXX7RAFfAG3iC+OP6cb3Dno37O5EfycrpLfs3gpYs8OFq4eh7eUtLLChl56/xnDT8epHHM3ROYqTB8m6Z2yXXFBvP6dgtrRODHrbu78jfV0CxeK15d6F+1f2Pz8OoJnQVfm7FZqy+WdpmX1FrpLWXD95bTZIIrVaCPZ+9PeOHClJNp8rrD2KPE7oxMODg4tq7Uk32jBOtYeEHqjKUxho2Ak/Yepx28lTOsKCCkhm37tw6GlmLEXzAjeZkD65ojvvjsn4TrY0j6jPqHnQHxH0FzHBJtNz52hlGED2WZ/QguAia02d4GvdtbjGbIg6s3HaO1lIa+Ei9YOgpy50S3HZRoQoGzy0PO7hiJSEZroXpLKnTMZRKiDW5MY329SQdzB2ZRs0+vodUJPaErF91JNiGZFclsd7akKzbqbcS3PaIq/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(478600001)(36756003)(83380400001)(336012)(86362001)(186003)(7416002)(16526019)(4326008)(426003)(2906002)(81166007)(40460700003)(70586007)(2616005)(8676002)(70206006)(110136005)(40480700001)(316002)(36860700001)(1076003)(45080400002)(54906003)(47076005)(82310400005)(82740400003)(356005)(966005)(41300700001)(7696005)(6666004)(8936002)(26005)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:23.1422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9524431-0e4b-4272-02de-08da9810f593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
s2idle resume.  It's from a missing call to an ASL method in AMD
the s2idle calling path. Force the system to use the Microsoft
Modern Standby calling path instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
Reported-and-tested-by: catalin@antebit.com
Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tags
v1->v2:
 * Fixup for __init
---
 drivers/acpi/x86/s2idle.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 127215150b84..1b638bd30fcf 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -17,6 +17,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "../sleep.h"
@@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
+static int lps0_prefer_microsoft(const struct dmi_system_id *id)
+{
+	pr_debug("Preferring Microsoft GUID.\n");
+	prefer_microsoft_guid = true;
+	return 0;
+}
+
+static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
+	{
+		/*
+		 * ASUS TUF Gaming A17 FA707RE
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216101
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
+		},
+	},
+	{}
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -566,8 +589,9 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.end = acpi_s2idle_end,
 };
 
-void acpi_s2idle_setup(void)
+void __init acpi_s2idle_setup(void)
 {
+	dmi_check_system(s2idle_dmi_table);
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.34.1

