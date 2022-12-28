Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7FA657600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiL1Lq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiL1Lq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:46:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A896429;
        Wed, 28 Dec 2022 03:46:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSyAX5mHuF5fkeTT8KTlKA/mId3MtHu6ljAmTwBeJCr5LOejoG/6lq2akdAcPGY6mWyRoe0pzmV6Is8/BL804dVyGp+h/QeFXnp2w/ixF7le+50U/V2uBT4qVPZ853ZAVSUmzMJJP7c0lvKjcQdwvvU1psLlnFoK/lo2dNaZ/6fdnMySJegrMBwEc3UsHPNWRpZZIyWm9LVxDHTMaKYdts1bYws/3Qxqlg4/XK764hizVXMv2GmWLwecMqz7AkfC6/L1LXPBhPNKLPlkHGVVgtvd4NPvfrc019Afr3VxLafhkiRE0Z1ZNodU4vkD41bp0SdsgtZbh7oZgPK5zWm53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3/UVDmkHcR20RZfUQCalASCVy9iCXxdzHFv81d/e4A=;
 b=TYnbvoskey4H/jgG6q9kZjQHRua6DNkQ/tvc8vcu1lSgLLd2UBXEZ276Ymil9Olrg6vbd3mTwWyM3w75GuGhOxMpD+F2wJknk2rN5OEBkPWoMoDlDqOXJWsaOSWWX6CzL2rydiYpcLfZ8tcg9vpODfRoXHlW04Jh0UaiHz2M57lIVp5RLpBd61+8IEgj1FJ6fV4SQGqSqsRUcGQBgllOeZYjKVlx0JDZiLKREfqGxSw578zTalakEOU6RPtUWGthIEy+QFjZlSd5aPSEDHpKCeoG7uDv5kXzV9V4QScf0Bt6JcCYYFjoghXir7qXRMTz/oA/1BjE8asU49w/IMzmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3/UVDmkHcR20RZfUQCalASCVy9iCXxdzHFv81d/e4A=;
 b=BGLGy5pazL1lHgqDAjw9nLu0bB/H/VaINzO8ZIsneJXX6bt/iRfn74bNMUYMxfKlEu2ZhkC0kJ2U/am/e8PfvTac51J859dF4isum+DbN29SyRilN7jd/b6VnPwAiG8DDINBH5b76L7ecEA+gFRDA9EYfApHdlVTl1rvRs2JJxo=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 11:46:22 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::85) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.17 via Frontend
 Transport; Wed, 28 Dec 2022 11:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Wed, 28 Dec 2022 11:46:22 +0000
Received: from ruby-95fdhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Dec
 2022 05:46:20 -0600
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
        "Kishon Vijay Abraham I" <kvijayab@amd.com>
Subject: [PATCH] x86/acpi/boot: Do not register processors that cannot be onlined for x2apic
Date:   Wed, 28 Dec 2022 11:45:58 +0000
Message-ID: <20221228114558.3504-1-kvijayab@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b03bd0-d935-4c41-08e0-08dae8c9246f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVuZzK8bcmTyPYyIyeKUZTKCU06GonnZmNOEUM/6b/OPgMg1LcyvgE1GE/G5dLNK+M/Gh15HtSNMjdKrox+LN5H7/4gdAf7Wx8sGn6eWY8ATaUuZb3JPH68hmkd2nwWXa8nwMirKsi34eVTV1u8IENmpGredlYsWREzyia9hBwFDoPtYSaGk0C51FXNXNdfiHqBIGGdq+OkDQzAAcvBj1Z/f9PUo4MO83wUvP3QSpsBNcecdncGsjA6s7iqaFn9VyD/X+JJI6UcjhiaYkji5E/KUm47XMzXoAOIDgjzbipVRU6Zxc/Wmps//Y+hV4BWU7jzXvuIfYBUOHimARIxMK66zXHiIBRq1M0C1IpM3PHotPky1GBxP/Px7pAcZ42fmKUw4KvHOvaQ6b+KJ9NZ6OsqzKwOy0d/0ewcV0EcVhgR9Cxkku7LSeUU3vCYC0P5uivopLrB1kMxnFBW2wFlzPxFVFM9vkuJD8LfQEkJ/E8TeDLsl8yPvogQyGdKvg3VzU4NoS5m/JmfcNvWKA5g3jk7s7jRTTyHkGLcAIs6+O62E2hnNJp2qqfMGt6z/h4qgRfTV6jRNQXvaC/fjNj9yWy5KpD1/Jo7Lg7iXCkf/+jZhPjicrj/14WpxjZv/swIo56F4pEsikq6VOUCbkHDQCImLmtvcdapHbxTKPoDOLXG5AJxQkvESA5OQvxu+Sus7qI/jwiKNIFMcs5h9EJiMXVx5D9q1v9zjGpmYShEEV4o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(54906003)(70206006)(70586007)(41300700001)(83380400001)(8676002)(4326008)(356005)(81166007)(82740400003)(36860700001)(7696005)(426003)(47076005)(478600001)(6666004)(8936002)(5660300002)(40480700001)(7416002)(2906002)(316002)(110136005)(40460700003)(1076003)(16526019)(26005)(82310400005)(186003)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 11:46:22.2267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b03bd0-d935-4c41-08e0-08dae8c9246f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.3
spec mandates that both "enabled" and "online capable" Local APIC Flags
should be used to determine if the processor is usable or not.

However, Linux doesn't use the "online capable" flag for x2APIC to
determine if the processor is usable. As a result, cpu_possible_mask has
incorrect value and results in more memory getting allocated for per_cpu
variables than it is going to be used.

Make sure Linux parses both "enabled" and "online capable" flags for
x2APIC to correctly determine if the processor is usable.

Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI extensions")
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
---
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

