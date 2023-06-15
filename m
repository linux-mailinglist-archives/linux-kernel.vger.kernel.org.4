Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18AC730F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbjFOGc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFOGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:32:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C698EB;
        Wed, 14 Jun 2023 23:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiDOaMVLnos7EaLe2oithawY5zjWVojEGNzWT0nstusOFhcs17s6nDfEAkwg/IbTQqDKzkhaWnyPcD0Qao0mTR5CiSJpu/kfqJ7xnBuu+quEb9KOmpWbLKTDe8mj7VKWCYzGzuh6BNWS8KARTIwp/4iS/+Lq3HgdH2AXpMMlCa70oPFoKMDBAi+mfhTnLqszqGxVEGhF49FwY9XcOgIvdkhYOCirFCe8bU8KHHr8dhfzlHm6nU9x6riB4aVh5Fg8bAlEspw8pStcGY8aWgOY6vM47z6ZA2UaWIi7uk1ulDP82cpZa0ciZ8wM9xWgawtc/NoZVqi98hY63CuhglgwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sqNMlleI3wJPM6ynpLP1EEqxGcw6czpGjERFJDhpvA=;
 b=HqAuzSG3mnV+rkOaEXvJAiCCquuNairCT4LME+orz+ZhcH4L5M3+HUwThkHFWwBZdHxyDFgrytal0Pqu/oyk1CJyRFX2/PCU5+DMpfZn/y8Ff6MmejmHfoKwPJlQZqEKwP8KO0zKAbt/9PPmfYKegXj9HYt+V0ypQ+/G5tNbNXMcw+onts+2U7pLvc8HtwcwFL+513fiVX23lYlvNnhAMOZVMAXRVP15uXAuYIY1ggV8cry9w4BbpvrLuQQvHtB77aTVd0HwFQFrljuvnrnGP1B0gcb6yYjnHoQfLuxT9F22JlctCqaZKYcqLQZud/rPgKyfvykEge4XkvbCyTNToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sqNMlleI3wJPM6ynpLP1EEqxGcw6czpGjERFJDhpvA=;
 b=jXw0qtjDjC5BbFPosWf9GL/4YZcgRNW23WAdAhxt5LfPaTi7A4VYE5qHp8pTodywkx92SMEOiI32kx0XYDLCxyl66kNb1ZxCeJR7tPbHdSv0GrIoh16GDpDbExWru3STHe9mwCUVHOtnE8ZG4CIUfLZ50rI8Ynu2zA5h6TvdUUc=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 06:32:20 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d5) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Thu, 15 Jun 2023 06:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 15 Jun 2023 06:32:20 +0000
Received: from pyuan-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 01:32:13 -0500
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, <Mario.Limonciello@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Wyes.Karny@amd.com>,
        <gautham.shenoy@amd.com>, <Sunpeng.Li@amd.com>,
        <Xinmei.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] ACPI: CPPC: Add a symbol to check if the preferred profile is a server
Date:   Thu, 15 Jun 2023 02:32:00 -0400
Message-ID: <20230615063200.4029760-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa46465-8d63-4c71-2b95-08db6d6a45b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lQfObxdW1dJEmoccZcL3xAV/V9KZjmTuUhYWUHrmxQKHh+RwCKexCHYQ+48gRbsFAjQVW6O+wuS7fji3Bc4NN1jO2Iuwu1ZF9pNONLdMw8lNd4hnRTB9t9Z58Z+nyqEHY/vedq1YI2qrIoiorn1M7umkvO7leaKV/AETzmX06fVSunz68Y7om3W6dj1hB88j8o+ABeOoWJazlACcT9PznpHxLhKMZjFhRc9std7y84NpnwP5hzUqpugATAtuo9vjVu+9bdICnXWKwXSCZ/vFC1SLC2ujhChLL432urGQ0ukXjo68z5h80o4GQwSpGAIV8in3BNjBnsfq/ugZNGqsa77zDWghpc3s4Ci5L+c2Jo5D2JxX4xGwO26RcLXyBkFYnVoixHg5rlFD1rItW/zVJKH0PCxvR9b1WXK0Ra2zcYLcKhJkTGkMbg8sJwXfRhaIf2cp1uHmJiAKn1uS7L/LYMDpHsHbpn25CMUBKrAjvTeCsCi9WYDkePObgs9QrawoiNqXZoa0rxV34Wj5XdLj7sU1p++O7ijyrL9pmdoetoqFGPZW9KaJT3CFQzwEF69YVtaDUe9ePSmDMhypEcdF6CniKkfRg2N7Kz7ivObhu9yV2KlK9Xe9kXK9ZgCVtP2rHj4vGnGJVQ2D/7RWPINV8qoemgxkb4kzm7Bmxt3UJ6UrEHpbCmXc0j508rQgF3P9OA+AKwL0o9/TSr/snmSNK+3VAAsrh73vZqmu8t/K2JPz3vrrdG/fkeAIsor0Gj8g6cmcXMmCkL8eFVsepCV2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(83380400001)(426003)(336012)(186003)(40480700001)(44832011)(2906002)(47076005)(16526019)(2616005)(966005)(36860700001)(41300700001)(8936002)(7696005)(26005)(40460700003)(8676002)(316002)(110136005)(54906003)(6666004)(82740400003)(36756003)(478600001)(81166007)(356005)(82310400005)(4326008)(6636002)(86362001)(70206006)(70586007)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 06:32:20.4629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa46465-8d63-4c71-2b95-08db6d6a45b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

This symbol will be used by intel-pstate and amd-pstate for making
decisions based on what the FADT indicates the system pm profile is.

Suggested-by: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 34 ++++++++++++++++++++++++++++++++++
 include/acpi/actbl.h     |  3 ++-
 include/acpi/processor.h | 10 ++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..d8827eae3ba4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -941,6 +941,40 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
+
+/**
+ * acpi_pm_profile_server() - Check if the system is a server.
+ *
+ * Return: true for server profiles, false for anything else
+ */
+bool acpi_pm_profile_server(void)
+{
+	switch (acpi_gbl_FADT.preferred_profile) {
+	case PM_ENTERPRISE_SERVER:
+	case PM_SOHO_SERVER:
+	case PM_PERFORMANCE_SERVER:
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(acpi_pm_profile_server);
+
+/**
+ * acpi_pm_profile_undefined() - Check if the system is an undefined pm profile.
+ *
+ * Return: true for undefined profiles, false for anything else
+ */
+bool acpi_pm_profile_undefined(void)
+{
+	if (acpi_gbl_FADT.preferred_profile == PM_UNSPECIFIED)
+		return true;
+	if (acpi_gbl_FADT.preferred_profile >= NR_PM_PROFILES)
+		return true;
+	return false;
+}
+EXPORT_SYMBOL_GPL(acpi_pm_profile_undefined);
+
+
 /**
  * cpc_read_ffh() - Read FFH register
  * @cpunum:	CPU number to read
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index e5dfb6f4de52..451f6276da49 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -307,7 +307,8 @@ enum acpi_preferred_pm_profiles {
 	PM_SOHO_SERVER = 5,
 	PM_APPLIANCE_PC = 6,
 	PM_PERFORMANCE_SERVER = 7,
-	PM_TABLET = 8
+	PM_TABLET = 8,
+	NR_PM_PROFILES = 9
 };
 
 /* Values for sleep_status and sleep_control registers (V5+ FADT) */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..05a45ebddaea 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -360,6 +360,8 @@ int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int acpi_cppc_processor_probe(struct acpi_processor *pr);
 extern void acpi_cppc_processor_exit(struct acpi_processor *pr);
+extern bool acpi_pm_profile_server(void);
+extern bool acpi_pm_profile_undefined(void);
 #else
 static inline int acpi_cppc_processor_probe(struct acpi_processor *pr)
 {
@@ -369,6 +371,14 @@ static inline void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	return;
 }
+static inline bool acpi_pm_profile_server(void)
+{
+	return false;
+}
+static inline bool acpi_pm_profile_undefined(void)
+{
+	return true;
+}
 #endif	/* CONFIG_ACPI_CPPC_LIB */
 
 /* in processor_pdc.c */
-- 
2.34.1

