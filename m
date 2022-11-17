Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2091262E8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiKQW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiKQW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ACB10B5C;
        Thu, 17 Nov 2022 14:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PByVHZEmndZEVolMbyihxNZ0V5ZSuHfUGyh1gC6GPicAtVORbczkQ+Fh8Zt2wrdK1DT/ggw+moY50ypAcyWez7LNM6Y5hL1eUDRIqSiGQtKcpcQ+2ajwx7+PqGuEyKrQ6XNHxJ77EcFryE1NmnhnZJA8For2vKgCWYXZKLWVz/Um5TkEmaeiC86i+/2k3O0FTO6SUnetmarNFV4fpW5wgzfkCaaggHgYc91OosF30wVfvYI0AIuBc9Y+HLEEALnI7a+zDg8D8K5cLDQepcyFs6TkQoO1/SeVukHpnHzfanvK6cLs0MLiubaIAg1ArMgfZTiA9P0W5l6Ku63MjDrOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+/X29lmRHgI2UbPvsa4Gj8XsmqN3IqycqK0f56Sb7A=;
 b=PABlshNxbGDgdjdM30EDLLWoZyvQpbkHDeslZXdIThVyaKzqyCXx8ir0RsdXQQQesbjOmpiF/mOIK3LDSBVFpL0wAKT9WSuCUcPddsNdwWPb+lMydsN/SXVtGbq+akhrgkJIu7sfVJjbO0931mZuOXiGFNzVfTek/Z5qYLyAfe3yIUc+LFEnYSDtgJuU7qbVHAwPxY8tBoyHJU6lZUx6Ic6mdoaaTA3FoBkuhgNNv8SmCyrbC5fwFfikU5ahLRomQoF7AqJhFEtE8nEXit2CiVtUxo6ORd3Io2uLr4+ft3waCmHtsWXtEFDtbAMwja6I+WdpS9gf+m68O9yYLj9i5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+/X29lmRHgI2UbPvsa4Gj8XsmqN3IqycqK0f56Sb7A=;
 b=BCYhQWFFP/8wGdJ+AATed23arR4uBLCRdJrxeaHuRTk+89z41kaq18JkrocltN795g0UN/HoxAa1ns0ThCwsSJMqc2LQIcWwatoRh/9fwrSa+NHxW4hc78X4DLGoZ3MWM733SUrLi9Q5hI/6wCgahGTaA0jywt7gu3mEvALN8Fo=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 22:58:29 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e8) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:26 -0600
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
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Gross <markgross@kernel.org>
Subject: [RFC v4 3/5] platform/x86/intel/pmc: core: Drop check_counters
Date:   Thu, 17 Nov 2022 16:58:19 -0600
Message-ID: <20221117225822.16154-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117225822.16154-1-mario.limonciello@amd.com>
References: <20221117225822.16154-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 528dab81-d01a-4428-0302-08dac8ef3e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFM60C1uNwv7+cA+ge1ofwV5zNd43ja+NRT0X4m01/EyqCdMXqx7lm4JBqptPoRG+a2TZtXMCm1Y/U55D3Eku2qkNmZ7nEfAONb0Nhe5siBq78uEe2+g/EBiP9ZNmaqVhaW9VjPDUC/BZde+6cGXw37RmSno8sw/IaxaJv9lCortHZ/VRsvK6nnBMnwubaC6Fom+r+suMFl3a9k8ex1krU+H7ID8Fho8598pPs2ySK2r2r88yEzJKtgBG5Donh6XskSwY6Ah6VQW+Tp75iwViE9bUnL9H2FExUb/vfTf3K3IV6E41WpiHwBNwCv3MUlf12iHYV87oGn4QQtS74p1Z0iYzCLJGIw33RWyernxmGDsztYiosvZmkP/SyaQK8vufARJpuKDF3v+mAuIU8cZ7kWULXvEeLVcX++p7hgbTY5X9NvFeCp5SqQBvxXEb7icvxPm6HhmncuK+Dm3NiOPGwUDia7MHBlk/YPc0ElQNdhiKBpXiz65qW0v9hQBuHqlEn8HoS2ljWjzkkEbWfzqvqSJ2a4e/LGuI5Ig/NK9g+0f0jbVl3cM3mGsEhhVjQrkCW0xkv3LQtZAS4mNFvseU3zFHI81sCNkv4uvKrEsrD9x9JCtNPl/P71SSJz9CWcaEV5TTL/7aUIVeMnnSiN1ro6hA96AZiR4BRGh316+3PLs5CiM9LWtetLcuGPNWYuyS3JDm5mcZfg8ZRwrHLYohSoaYOOnKX0s0G4FNtk+fO8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2906002)(356005)(8936002)(40480700001)(7416002)(81166007)(44832011)(5660300002)(82310400005)(4326008)(70586007)(478600001)(7696005)(6666004)(26005)(36756003)(8676002)(36860700001)(40460700003)(83380400001)(70206006)(41300700001)(82740400003)(54906003)(16526019)(2616005)(86362001)(47076005)(426003)(1076003)(336012)(186003)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:28.7907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528dab81-d01a-4428-0302-08dac8ef3e03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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
RFC v3->v4:
 * No changes
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

