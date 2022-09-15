Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E25BA0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIOSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIOSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:23:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2C1D0;
        Thu, 15 Sep 2022 11:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2/ZuSI3mnZ6DVJ4REnMbJwgDSqZdv1OhRPOEAz3ZHFLV+Wy5GknaBq9B+N9JXitAdtc1loTQdFEF3R38oe8pnmZDdVB9i5E2xIp4khSfxDYgiQJPGbcpuXkeYAa9ghNQNtmKq+uP47r9duj9/iMtJcxuvIxyrCs6yVdSdS5EHD03PWiDrPnOnZbIHRysTHAigvJ5K1YIiLvAtPz0OwuyoKs5j8hbYtBeF+GuXXiYp+EHGfacWqs+mkbLDXjRe2MuCy1az3Cqemm8ADWsOibOV1hWwipngBjMLHVnw3vlwGRSb5MT0xR3uLekNqC3pnpW0Rpq9ebkiiw+9QOM5WuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b45p/arZe3QwMBsG0aylw02+MUnkRzkTnZVNSRYZ0tY=;
 b=inLg82uogtoUM9u02iXZ/ukfqTOvXPMVqqS73oJ8VpY1wIoxAmeZsjGJd8uDp4F2W0hYa8/V3uXQmBJEHsxUppGQ93NJ1OR/zM2z2NXJ+t0WaqS7GjdXDbPM0BwR6QWV7yQKMyB39dn87w06md7V9SrCSWzzYygk4wifLxZQ9Nv1VeN8MYSPq+ym2r00aOt0IFJwYTg9OZnbvED4BF5pogoMWQioPHsFoCw9CH7JVbqK0TUSbXj4in71iiPXSCxUccPLdZ+eUdjATksor1ARqH8yUA4VDq01N28jFfevs27tlQNSFCOaahcY0UC7l4PW8Jv2VfKKUUHN7ZpXzvtCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b45p/arZe3QwMBsG0aylw02+MUnkRzkTnZVNSRYZ0tY=;
 b=x57ElTVQMKOpOfvGA5+tYVe9EkE8mFMzRk7O0K7rEpKecXNJHxXg6fPabgEk9JJMas63mtLyvJfZLbrMPLVGcyEYWQge3dtxZDqMclKzV9131Zvtmv8HfX1EPz0X4WXGHQaA+Abn0YGvGZbEMwDfXPaNPO7kUHg7e+GDg0Wd22U=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Thu, 15 Sep
 2022 18:23:28 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::d6) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 18:23:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 18:23:27 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 13:23:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Luya Tshimbalanga <luya@fedoraproject.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI / x86: Add a quirk for Dell Inspiron 14 2-in-1 for StorageD3Enable
Date:   Thu, 15 Sep 2022 13:23:14 -0500
Message-ID: <20220915182315.276-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2b3373-c0bb-4801-dace-08da97476299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWkxrLM1SmX0sDDSpROshjdFpw1AfUSvhKkGhmNXAYzdwz0pTJsb1bmgHVmsN+MjDkYSBo1GTFN8vCxugBw1LY5eEuv8A/aDSSinrNDrb86hJnpDtMD4p7n+DL1+FsFWXYmi6zPV5zscJM9QrWuN09iYnfrjc7uHMahRRA+mB/41lcLh/J8Aq8phBvFVcxSXp747F0K/OMgPdyOJ+myxdCFtPrzerVpx1L0tFjJZ4GdCbbgobTkiQ+6a22CImpHjNCIzxlhB8a4zxrutHIh59Uu5vopEzGF1sgfDynJxqgYH3bWDNgEaFAieqqdX/YyVEVXjihB0S6Q1EHJRYebky7kRWYIlRksWqg4nRBTfvPhJP0bgXL3LUms6rSDKMedmMSFpx6yj1o1sfsIABp+EXGAs8JH0GZgODTqhq3c9Nu4YW5D9ak69JziFWEabNrgS/Cmj88teMup1UEgRp+X9wpglxDjolvFnt78p4okBWFXeD2JfFJazG5VKS8YKetSjk1AvJrkMbpTe94X0GVZpDfSzihmzXtEAI5p+Tm6mdDsbSQGOQEcHESTlytLKTL1gR5bzFIbeENlMggz8p05X3uoXkWtxbl6b/zdNqt0hDYv0ghn6GB8OFQv/w8YOB0yaMY6/2ACpsZwKo089akcmDlzCzrwdyv9WaLHioSm4nx68U6YntISTENcfcVPiQJkX4Cmnh34cMNi7w0PC4srfo94lJS0TuQGF1ubs5vis4VrAa9Gx/y/INj2RP6SE1kgbBKYdIN1IwRt7YsH9685gWcFGgTPYas3+sT/x7LOTKzG1GqKWzx50QGOFn6ZpXc1s2LdIqHtzy85q3PqfWh4kvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(26005)(41300700001)(7696005)(6666004)(44832011)(5660300002)(186003)(40460700003)(82740400003)(86362001)(4326008)(81166007)(2906002)(426003)(16526019)(36756003)(478600001)(336012)(83380400001)(54906003)(1076003)(8676002)(966005)(47076005)(82310400005)(70206006)(2616005)(8936002)(70586007)(356005)(40480700001)(110136005)(36860700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 18:23:27.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2b3373-c0bb-4801-dace-08da97476299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
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

Dell Inspiron 14 2-in-1 has two ACPI nodes under GPP1 both with _ADR of
0, both without _HID.  It's ambiguous which the kernel should take, but
it seems to take "DEV0".  Unfortunately "DEV0" is missing the device
property `StorageD3Enable` which is present on "NVME".

To avoid this causing problems for suspend, add a quirk for this system
to behave like `StorageD3Enable` property was found.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216440
Reported-and-tested-by: Luya Tshimbalanga <luya@fedoraproject.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
I had attempted to modify the heuristics for when two ACPI devices
have the same _ADR to prefer the one with a _DSD, but this wasn't enough
of a help. As the ACPI node doesn't contain anything valuable besides
the _DSD, it seems that a quirk for the system is a fine enough solution.

 drivers/acpi/x86/utils.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 664070fc8349..d7cdd8406c84 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -207,9 +207,26 @@ static const struct x86_cpu_id storage_d3_cpu_ids[] = {
 	{}
 };
 
+static const struct dmi_system_id force_storage_d3_dmi[] = {
+	{
+		/*
+		 * _ADR is ambiguous between GPP1.DEV0 and GPP1.NVME
+		 * but .NVME is needed to get StorageD3Enable node
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216440
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 14 7425 2-in-1"),
+		}
+	},
+	{}
+};
+
 bool force_storage_d3(void)
 {
-	return x86_match_cpu(storage_d3_cpu_ids);
+	const struct dmi_system_id *dmi_id = dmi_first_match(force_storage_d3_dmi);
+
+	return dmi_id || x86_match_cpu(storage_d3_cpu_ids);
 }
 
 /*
-- 
2.34.1

