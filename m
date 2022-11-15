Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E562A266
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKOUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiKOUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:02:12 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666928E04;
        Tue, 15 Nov 2022 12:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ac7q4iwTAQvZrTF+M4dUbfVESK27INcQm7dPUS2qkopyEkZNa32ckVQ4D0Byp8DxNdcpD70GKtHEN1xKCqlQpkhnvAKrU/iQIaElfxM2h/bC+tFBfAX4lGPTza8e+lwpuDSjUXaJ61lSxlWEEpqdo2DKzX4svu641NjQBcgqCOk4CXRSxz1dcPElZLQcwP4196jqDA1Z73jRIQVIVfF1cmxGaoiPEGEHy85lxlXuAejzK/XRzOP+1hpvuFwq5fGdqxZw7ER2lp+F3jfXunqfS36q++AgcdzQfLzZ7QL9qURGaTGz5dv8wqYECMRBZ6LMNxfqnHUvVaCXlKxOgjwm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbxBwp6dZXD3CCBU7jCaZkP7td2hc0GmCq8O9URT3qg=;
 b=XpE1UZMZuj966l/s5T16xmjuAavVV+q2AQ+4NWd6rWYmIfVb11qTUumkHx6k8wef7QtZYOcv1bKYiprreuBVVD8snj2a5bm7u2k1HCyjxDlZ8NeA6OilstbluWoT3FbVZOQHMv1csWri8sfYJXrVT9+pPG0JHtWtD6xRv92XoaLDobHVS+eP+CHyFGFj1YVYOw1IMnryjuPTrDW3gcP9cH0Zf9v5xhl4AugfpsPTHEdMxXcYEdpIAr4BzOc259enyR72lSTqqBKZm6y9Qp9sv1XbYeKcOyVhQsM1tC1Pdn8vDSAGk/UslFt7TdpAZ2LqJsTvIbtJuhnqupk3utVsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbxBwp6dZXD3CCBU7jCaZkP7td2hc0GmCq8O9URT3qg=;
 b=0g0ylU6AK9fRKJnUjO74EWW4gI8bkJza5w1nOGGp91ugyq46Lhfa7qRtoiA8tlQPv2LdByrZW5qEDDefcXNrj+Q4A1H/qsBpTPhqliwyJA8J5VjpoO2WG3VlZ3Dyv+Bl7BfGrFfXNQAXxWWF7b1QwrgAtjgFKLZDxVRJBj66Uhk=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:02:09 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::fd) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 20:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 20:02:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 14:02:07 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, <linux-pm@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v3 2/4] platform/x86/intel/pmc: core: Drop check_counters
Date:   Tue, 15 Nov 2022 14:01:54 -0600
Message-ID: <20221115200156.12218-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff52443-d5e3-4744-4f5a-08dac7444718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUYSV5DCsWj8Zgc0WYhFwAkGFAbKC85CRpIIMx0/zGFLSdwFLVnaKm4cbBiHVAYL3l5LligkqWp7mteOBIzyc6B64MeseeqgRSXT4Gy4DKmjx3pRQVNT0XT7r2F1V1n8lDQYdCR3PwCPaTWVYx81QExiVptAdQhcam8vwzwEjPNzCNIOZsq94ZpShpglY6XTdJAQKwfhIOfPw73ko51gm3dLYVzDzu5v1QGDLZorWiIFy/LZt0b1dGECufcUAmqRc5798FvsF0GUdK7F1Mer3OYyVHvw4oel3YD2PFhCX2m+s+e7wjmyQgZqp3aST75n5fjJTVzh744fhq4DtXb+vjksuOxff93MjELXe1df/1QtoMqs+UZX+tNxC1DLsGA5mdOYdd3sznclENVSklRQ/BGRm9DyUdc8EreUijEcru2foXsxpE7ft9gzjVi28J/XjpZVLnU80SEgQ2OO1E8w9C/TZ++YfKBjOGi7F6ZUb+TjXrkeqntz8WctevuRACC7d4w0yuLaC/6pPD2o7MoEbBMwAULGXtG5dUrB66S9ML4ieN5k1+BaWxx6qiJ7eMNDvZNO1A2fORmzfpA09TCYfBzo7IE2WhRExReNF61g6aQXvggLgZkriMs3RjCinDI4g92VztMp/HpWIVZSQLt8sgKtl+EoyGaPGToypEYvtqkiTjRFapngR1Qc4SbGGQwyQBFlWerpra4OMfMDpSfyo1Kkf7DShYjptYCQ301Wi0mxRyR+4RZqRJbNRh1ge681sLpQButHW1WBtMkLK+Vbmso9y5dXiafNhIWvsPthVGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(36756003)(2906002)(36860700001)(8936002)(44832011)(7416002)(83380400001)(426003)(186003)(1076003)(356005)(47076005)(2616005)(82740400003)(81166007)(16526019)(336012)(110136005)(5660300002)(316002)(54906003)(478600001)(40480700001)(8676002)(82310400005)(26005)(70586007)(4326008)(70206006)(6666004)(40460700003)(41300700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:02:09.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff52443-d5e3-4744-4f5a-08dac7444718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`check_counters` is a stateful variable for indicating whether or
not to be checking if counters incremented on resume from s2idle.

As the module already has code to gate whether to check the counters
that will fail the suspend when this is enabled, use that instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v2->v3:
 * New patch
---
 drivers/platform/x86/intel/pmc/core.c | 7 ++-----
 drivers/platform/x86/intel/pmc/core.h | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 17ec5825d13d..adc2cae4db28 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -2059,8 +2059,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 
-	pmcdev->check_counters = false;
-
 	/* No warnings on S0ix failures */
 	if (!warn_on_s0ix_failures)
 		return 0;
@@ -2077,7 +2075,6 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
 	if (pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
 		return -EIO;
 
-	pmcdev->check_counters = true;
 	return 0;
 }
 
@@ -2113,10 +2110,10 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
 
-	if (!pmcdev->check_counters)
+	if (!pmc_core_is_s0ix_failed(pmcdev))
 		return 0;
 
-	if (!pmc_core_is_s0ix_failed(pmcdev))
+	if (!warn_on_s0ix_failures)
 		return 0;
 
 	if (pmc_core_is_pc10_failed(pmcdev)) {
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 7a059e02c265..5687e91e884c 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -316,7 +316,6 @@ struct pmc_reg_map {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
- * @check_counters:	On resume, check if counters are getting incremented
  * @pc10_counter:	PC10 residency counter
  * @s0ix_counter:	S0ix residency (step adjusted)
  * @num_lpm_modes:	Count of enabled modes
-- 
2.34.1

