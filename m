Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85265E478
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjAEEMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAEELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:11:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F81A195;
        Wed,  4 Jan 2023 20:11:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTV7KNnL770sOF4tPnKnD+mhATi59gDOSHKXnLVR5x9fyZhfySM40mzAjQeOVc66swm56PvzZTHGEVJbPGLAmNNtc6gHpohiRrRyZ5SjsghVjjN065LK8mWkJLgrbc+xYbC3QB154XxOE8qeMXmlHxlSvLY6w9fadc1YagkQYZ/WV0tBeVs4rAA5iZf/v69QiqCRKqJX62qoBk7cjiki3eZU4qJG8hhBQbYTYdRINFLVYU1zIplBUJGa2xAOkGkaa5Cf5OraqPhk23QcXkbEsGC3Hgsdkp99VBM3k3vN6RsE/WtRZS962CQ7aKDnlZ3icxShp0ubAGYfv50+Z7T4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2lFnEPckNNNzSv8pOVHZdQPZ7UF6VuyXT3zg8q480M=;
 b=bONqvcIPPbt59TH695XOfCmSdBeSGHsazzFgI1mXNqXxQQrgW4JtUhLRwPdFE56kLkrM3uz/IrygfCZ+b1/DaV8e89CqkgQi1uR4GvUotDBmTcwYmk8UKuVTaRF23TVQAjiekQy4gICmJAP1QftudP5Aac+2XOc5DhyRRTu4aMSKcqlkhYPqR54k3s5wnYR7h37yHCEynYTu2fmLkKSHXfnnIrsdZtl3CHt+TUkh1p1U59Tef3XYSqaIXQsC54TKKV7rgIFbY1xW8HVkcFLglBM0btH4PmGtn5rr9dvjqLjcf9PMZPLma8DacXHF2U84R8joXaTIoqon0O1NI0ng4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2lFnEPckNNNzSv8pOVHZdQPZ7UF6VuyXT3zg8q480M=;
 b=jRHkZ5TdrS9fgUsaJONlK/guHQFBlOVOFlOKDpv57UTI55IvdEEIu+IxvMoZ0gab7bbwn6xblkDqvjrtH8Mo9P+irGTYDaXWyW/8XXoXVDNYo7mO+xyVCkluIYh/2m8MhR8brxlRX2w7VMc+ZvURhgzUCRGR+nR7HhI/wGgPvBQ=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 04:11:08 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ac) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 04:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 04:11:08 +0000
Received: from ruby-95fdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 22:11:07 -0600
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
Subject: [PATCH v2] x86/acpi/boot: Do not register processors that cannot be onlined for x2apic
Date:   Thu, 5 Jan 2023 04:10:59 +0000
Message-ID: <20230105041059.39366-1-kvijayab@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: fae7b004-dd22-47ba-550c-08daeed2df9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3ktHKW1LwcVQnMNWH4ZvKvfpDF2lF60ELeVIB8SgJjIO5HBPwbYeWoUesXibCK49nRmrwMIX1Wiy7O6DmRUYEjQBzOhNwjnyawjwIXsmWrlyMi/VhlxSuRao/ZymOaL/PeGKyVtZeFXi1g8ALECm+hMlafZT6B8qtJ/+camUAvqQTnccdEzC2bLd3Dcw75j+7lc6he97IN3sAj4c5wNyOMRVUd8aGWeeCVjhH96bi9CFmX2Lwhu2ZNJtFgdsyjoJ6fsdCRUaRl+RmU9I/YEC9Kit/isw2jAwBmsMxWHhgofbKY587epF6GHbczvTQXHwBlN5gHxhU7b9GDx9ro8BwpuFFJIi6q7HzDRZFBS0pJZPraMYNfi8abINkqQID4bTNi7ijjMsaKKfngrkcsU39jfhs/6Mot9mIYcW8Jc18S11TNuvWouP29YGFRCzIZnz5jdMgJ5k1HJyM/r4itOG6cyUfLNJQpDqXHdrnjL3SI0/4O9n4t7C4i6n7WQc9QBGPWC7QpNVwRTWYWAL11gu0dRxVnVQNWX//DttZK1PkX5ESIhutDeLOuZcIrdSx8o5X4POpvrECVRlpLellRq35ljuZV+Q/Il1UcysW/7njUBTE+hJSbBbO9I/8chFWuXk/1Zjulh4G79vNC+jGDyZ9wSRRLL1Rbbfj1kSIMjtNH7nKaRltYoFEX5K2We0w6iFVjYtCI+W2pEikA23MbwbnoRdEx7GCfb5V5PoSWhF3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(82740400003)(82310400005)(36860700001)(8936002)(81166007)(70206006)(4326008)(8676002)(5660300002)(70586007)(7416002)(2616005)(1076003)(7696005)(356005)(83380400001)(316002)(2906002)(54906003)(110136005)(336012)(186003)(26005)(6666004)(40480700001)(16526019)(40460700003)(36756003)(426003)(478600001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 04:11:08.7854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae7b004-dd22-47ba-550c-08daeed2df9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
spec mandates that both "enabled" and "online capable" Local APIC Flags
should be used to determine if the processor is usable or not.

However, Linux doesn't use the "online capable" flag for x2APIC to
determine if the processor is usable. As a result, cpu_possible_mask has
incorrect value and results in more memory getting allocated for per_cpu
variables than it is going to be used.

Make sure Linux parses both "enabled" and "online capable" flags for
x2APIC to correctly determine if the processor is usable.

Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reported-by: Leo Duran <leo.duran@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
Changes from v1:
1) Changed the ACPI spec version to 6.5 in the commit log
2) Changed the Fixes tag to point to commit aa06e20f1be6
3) Added "Reported-by: Leo Duran <leo.duran@amd.com>"
 arch/x86/kernel/acpi/boot.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 907cc98b1938..518bda50068c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -188,6 +188,17 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 	return cpu;
 }
 
+static bool __init acpi_is_processor_usable(u32 lapic_flags)
+{
+	if (lapic_flags & ACPI_MADT_ENABLED)
+		return true;
+
+	if (acpi_support_online_capable && (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+		return true;
+
+	return false;
+}
+
 static int __init
 acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -212,6 +223,10 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (apic_id == 0xffffffff)
 		return 0;
 
+	/* don't register processors that cannot be onlined */
+	if (!acpi_is_processor_usable(processor->lapic_flags))
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -250,9 +265,7 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 		return 0;
 
 	/* don't register processors that can not be onlined */
-	if (acpi_support_online_capable &&
-	    !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
-	    !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
+	if (!acpi_is_processor_usable(processor->lapic_flags))
 		return 0;
 
 	/*
-- 
2.34.1

