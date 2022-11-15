Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6296662A268
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiKOUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiKOUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:02:14 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393028E1D;
        Tue, 15 Nov 2022 12:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnFdqihg1xunfjLgUxznC4rlQINbYOuauyTT/dkp3qI5JjSfnAqcunQEeKM6ndpnWjY2YGLDFQANuK9RpVCcToO5UgQlJBAg/aRzxyBdcjAMDu4bhH3SYo5Oz9pVNk2wQDQZ2LjuPy1W7TFnXfkHsFOOvi/EwBUPEXMbh+n/kldz+U8Dg9ONM9EptGFWKr6ar/3doAaVyUVYM2ZGkA2tOlgXhlRmd54kKMaA0FTiDr4jBkZSzvuDXN95a6x5ppIcdqGPKfDVPmgnJ7BemFkF7svkkA4y+elDg8393oGQsznKS/NCAh7fxah6XRzzvSQzYYJMTz6U6PVfblteALH/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/LlIZAzwS1vA6Wr+INKY6X3OCIIC7ZpX7j9iNkdunM=;
 b=gJcdIovSRO7MbPK0WWIRRKIpSpaimcGMtkwD0vJvydW0ZWRmyNDF7gNyYi/DC3GTmmuD2EEtTIA8PE8OgJj9fzCRzGvyJWFAcc2kuTNimvl+WmVZCxbirWU0F0Df9ZlZAneEw6qSbmxIk7dk0llm5c+cO8MDRm/BGfkW3NBSLMWXBb/w6Jnge2lo2WXcJTFAgbn//Itn+VyI/R4pyZW3SkDrDIKTB/wJmvehYUbj2fv4s2hbUObCaRiBwC4bWb03jUId3PCUEPUeWExRznUgM0tgSo0Ezn5SAA3hiqLknjbT8ZdPeK84XMVhldCT/MYmJ0ffCGO5JWV+QUOitnabtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/LlIZAzwS1vA6Wr+INKY6X3OCIIC7ZpX7j9iNkdunM=;
 b=Nb4lnqevNkS2q+SHndCnMjlUvI1f2X861CQr1GfNW7pcx541PnxY9dFi/fiSip7NLxZHWSzlEQlkHQKDiWWNXIcIAxBN1U8jJmb9D0EifWH2cqDK/cvNrv1yAXc6mAE4SkH5qe1T5oHeFqmgu97h7omoocTTxfYenX/JewbOgBs=
Received: from BN9PR03CA0262.namprd03.prod.outlook.com (2603:10b6:408:ff::27)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:02:11 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::8b) by BN9PR03CA0262.outlook.office365.com
 (2603:10b6:408:ff::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 20:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 20:02:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 14:02:10 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 4/4] platform/x86/amd: pmc: Populate cpuidle sysfs file with hw sleep data
Date:   Tue, 15 Nov 2022 14:01:56 -0600
Message-ID: <20221115200156.12218-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115200156.12218-1-mario.limonciello@amd.com>
References: <20221115200156.12218-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 5336b950-424a-4f88-982a-08dac74448b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lE00Ir5w9+rmw6DMY4EYEVnKk2UcNIdcYXu0E6tyQlNfpIJOXzXC+wROnDcTyuBjqY8OsiqNW79GEN7N71sJTNehfn5Vo444j2v7/SdA6RI5aNdrB7kBFR5vUaQH/oornYk88Ok7KAgHX7tlTSV0ABYpEZGeYZycQh4pXloQvGPjyGtJDhfvXi4BNltiy/sUwOp+S/vzrl0mZAEuUgU2pBFoaXlRDhKJGwtrvYtyVyQbZHZD26QIS3MBUBLnFZqT10pG1iapXNginG7JWocbp3jgXTZaibTiXXZqjL7UhZCohaXejKGrtJWdfbgCBu1D/Xd5w9aB5PuVd2aAz9Vxe7gBuov+Ak7vM9/vJWnVR8vngBDJjDvdkBdRQRzsRYJqOiq0DqPTbfKbwqspnoe3wudDAmpZ9rS+3R0nrffdiLA53WfTfRDa0YmZMmmqFK1Z251VNvWOn3e9bYZo7jB4zaf4Vef8Is9KiQaYPlIxLn+DYTLjxuh0Pdn72UjuiQ5qDAei7uXyPXqwnxx10ZL8da3a3s+Ci1Xzm7ThHbFE75gr6kN5J9zporq9QhCH8P/8NPY3PEYI8Cqu/HFzLOHc6Fo1aPE/j/4l+rleU5OcNlGb3u9vcLnfgk+/izZorzuLeKFq+9mepob55fD+whL+X3crZTTzBx7/PY2FBggRDqE1RVT8nbqbJJ+Cr0+icFsje9cJpt/89zGRonzelvEFks8sr3NQopbgKUdVyR30jvrnZsWrE5xRThiG+yy19Az2ufRimWiGgh3mQllYWywJn27UNbquFBRIL1aBhYu4c73tbj44oVSE3r4Go+QFqY8a
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(40480700001)(478600001)(82310400005)(83380400001)(86362001)(36860700001)(81166007)(2906002)(40460700003)(2616005)(426003)(47076005)(44832011)(26005)(6666004)(8936002)(16526019)(5660300002)(356005)(7696005)(186003)(7416002)(1076003)(110136005)(54906003)(8676002)(336012)(316002)(6636002)(70586007)(4326008)(41300700001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:02:11.7441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5336b950-424a-4f88-982a-08dac74448b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD platforms don't provide an ACPI LPIT table, but the data about
duration of time in a hardware sleep state is part of the SMU metrics
table.

To allow userspace to query this from a standard location, export this
information to the standard
`/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v2->v3:
 * New patch
---
 drivers/platform/x86/amd/pmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 2550ba6d28f5..ef5c23df1a5b 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -787,6 +787,11 @@ static void amd_pmc_s2idle_restore(void)
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
+
+	/* Silently fail, if cpuidle attribute group is not present */
+	sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
+				&dev_attr_low_power_idle_system_residency_us.attr,
+				"cpuidle");
 }
 
 static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
-- 
2.34.1

