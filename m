Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C2722A97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjFEPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjFEPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:13:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AB19BF;
        Mon,  5 Jun 2023 08:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUzQatWOIBafNen1TbSzfE89iblQgK+KlDUx4DJG7D6VVlQdyOqO9JlFhxjmOB9PQ0/yER3Bc6MG9RoJQ0aBHxhhJcR+HK35OIRW9qBx3yuLof92yfI5GvgFykFef8/Nm5fu3Jdwd11U1+xiLn7YEa7eg8zFISbtPZPuy8x7xem3Z5PjJKktnalNHYhqfjg+V9c/YG271dXOsrJxmf6pM1vBfLBXaV0aHM+miC8Gk23CxbKI+C6ahCx82pNqGh+92UH0MSmfhMbi0iSPZerSHxSqJaemY4DnbonlFfqNus6FvIuFqQYd8Y2TBRpamo3oQutrs9PLFXNISs64c0nGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+09+kDNMWYV43WnV3d+/pfY/d0oRazO3wK43obyAVA=;
 b=ceY5rZyyds3XEIJ+KIBNYxzyCrBcQlG4Oz6almazb6XyPl/w8evQxMIWF5dGDN7/s1mpzPH2ymL07iF1dI9HMWdym+nCOWJlThcoazRfmLfb8gDVGW9fJeH3EzGhU7dNroZJc/3SRZkoAjcbDaxSdzf+4DCg/VHi63sdObChlMO/c1wzuY667/asneKdxngR9ZD6IeFaMmciqPL+4sCZ/baiJMvKixT3BoVDJmOb87GKUCY2QPfI86czkV6eAtKYpw9KnxYnkVV5dF5qIAidPNjyP0A2f3pecBa+1+zJ8IUUVMlGBxShigJWCgHE+DFdAYiJISCnxb5hkFVnmibDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+09+kDNMWYV43WnV3d+/pfY/d0oRazO3wK43obyAVA=;
 b=xqxDRQKXe+Ej3y/hVEMEu6mKKJ2872l+glt4JGk2gw6Ld616Yesnz5kzTYaeIP+k2iHad0ishjyzUMWKk4a/8YbhWM6twxTJPYATC3ZqkTs2RzGHM7WYWlDXriC3MguLxA+WJT3YnKUm1ASXnfeOY55Dtjldty8HQlFp8ngGCX8=
Received: from BN0PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:143::10)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 15:12:05 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::92) by BN0PR10CA0012.outlook.office365.com
 (2603:10b6:408:143::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 15:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 15:12:05 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 10:12:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Huang Rui <ray.huang@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devel@acpica.org>,
        Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
        "Wyes Karny" <Wyes.Karny@amd.com>, Perry Yuan <perry.yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/4] ACPI: CPPC: Add a symbol to check if the preferred profile is a server
Date:   Mon, 5 Jun 2023 10:11:30 -0500
Message-ID: <20230605151133.2615-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605151133.2615-1-mario.limonciello@amd.com>
References: <20230605151133.2615-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7700be57-2833-4ef4-5da2-08db65d7390d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLDPJH4gA7haWpOtCF+VK0Tju/dt7u91pNi3jSDU4OtQNeGsctnegIKMM4MP9JOeykL83y2E64h1cNzbWslEmIu85YX78kawRviFKOUvw8q8pfF3mk5iO4ong7sHP+hnBr1Nr1AIb8uYYsDg4qFRC2soTOVl5smXcSLIfabeA2/BRz1geyCr2ehmVCa0DriRlohS1JV0Fq9e4rSaAZoij9i4oQIe8VC0+c+8qPXY/uek6mE2oHkKZpzNwEUdrRc0VE0DwIFmNTtqP3fgv3bh1rYVliXQsSFYrFT5k6nl5KtaCIkcAUlNhsnyNc2BGdqafV5dXVVGsoulWOO2mCbjcFD8BgIBVBJEkP0rC5jIy1S2GKvHA9f6rj8i2oxKUDapEnJ1Y7D++0HkPeap/mdoLY8elS0cNy3J1nALkq+vnINyTcUVfyYSPdPU8umwzIeols2SflfyVz+9WbAkIueF4Wnqbi2I6MIldSlq+XDroqTas2AVif0Cz7TFnogfjSL1AXqa0fyGLzWFOrlDs4+3m0OlnacoC+IQ+Gp33IApbtdva+0E2WwFXMkALJCk7XDobduVyDWDrN1EwD/5+fIjelj8q24BoKiFYmI8UdfHyuAjd0We7oxAKV2wZ4CanArEu1BERsAGPBBgLkn4RezBtVctw1K4sQ/Tp7vQW1Ghgs63nQnCoRYnI+pifqDdsNzagr/QKWOkLd/Mxj3Ie5rTHWqmTA6MadKqY5HB7wUy3nVW207Pkd6CQ00Oaq6ZftpKURWEFyWkHf88Wjo9HhH0Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(6666004)(82740400003)(2906002)(356005)(81166007)(70586007)(70206006)(36756003)(110136005)(54906003)(8936002)(5660300002)(44832011)(86362001)(8676002)(41300700001)(4326008)(40480700001)(316002)(478600001)(40460700003)(336012)(426003)(2616005)(966005)(26005)(1076003)(16526019)(186003)(36860700001)(82310400005)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:12:05.2139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7700be57-2833-4ef4-5da2-08db65d7390d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

