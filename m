Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114E862A269
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKOUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiKOUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:02:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F00A28E0D;
        Tue, 15 Nov 2022 12:02:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSswiwgBwZqeyJvN9ecdAMltKJOUtnSaCZ3Iw35Qd0UqzBFsK8j+g6xfYWkKcO6HR9A9SXuY63tu17iRhyheoiLW+hGciDti/VsdnSBlKSVyfPh9hToIM1ANNHEW2AJ56yF0yvw66QhWNGsN7UNcIDGl1ddN5DjSc9Zz38nMoV2xlUqjPQqCDEkKtF1ntOFwjirVUh4tLZLzyFGLVmNX5HV+XEDUj+9VFxehzBPLe1WAxO9zjWcWkd4w8Qxx3GJglZCkfeuO9g06IKT3zQnFtXDlpPrt9FvKw18e1+/PFZA6jeUE1pmWB4X9Smga0DOuoE4qnXAq/L98BOF/TLO3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR4HJCIssg6ApayI+7cqqOPLB8XH6rZSsae7Nm9cJ7I=;
 b=Nh6eMXn7tGr207pBeI+1OEifUFGpiB0eB2IVfPwCzDhFcC84aroH/hpWBMHRDsJ8/dhZcelLIhNFQz6QB29kK8Q1jPolxuu6ZD+c/gyMbsxnrGX2in5IL1QmO5exfmb8fgnB4T5bYAAm74MmxUOL39zTHp8qORXCaP3uG96pHt9hNzbjHFAQD+KLYuXTmSIeWeH0mKj4QwB8wK6YUui/Q42QnGKLE1R6A84owA5xoplWi8QTpA1QkKoLLyoeBEUpfe5oDRV8OutmN3wfJ7iAv1XRsxtl+AcifGSCG3X0gWaJO950M+P52tsrFy8B59BU9Z/JIeayDhgWURl0KxLEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR4HJCIssg6ApayI+7cqqOPLB8XH6rZSsae7Nm9cJ7I=;
 b=TVUlygJmdgvBv8+UQPoVEmIRkZ2Lzzq5cBdgU73nlZTaAnw+yYsUWGNEovTTftqZKUhKRCeFaY372MNNNxmN/XyVv/AZ4GWMrCdzQz5/mUCPBzYt2BP2QgT5ho+iA+juMVsHLnLMvTKBXhhLvOLoiY/esyewxebRpbIaxgZpUTs=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:02:10 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::99) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 20:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 20:02:10 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 14:02:09 -0600
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
Subject: [RFC v3 3/4] platform/x86/amd: pmc: Report duration of time in deepest hw state
Date:   Tue, 15 Nov 2022 14:01:55 -0600
Message-ID: <20221115200156.12218-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: b439e362-1d89-41ae-cd0c-08dac74447e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+NAMeEtuA2U66AkPvlUTce2m9kXAAwn2Wv2OSJNWmQ8nKsBhNcLt0ympTMzWA+bFYBpHFFMWS/YHXu+Xrce/ZvUsEPadPANmZlNgb8Ws4fjdp0Oq/RW8Cu1XfN+SQyPx6HfJfc/X7qR54Ne4Ienx/YSipvqwqGURaajfEfzvBG7Admzx+Zv/rif4DdKr7lu9nnsW2GVhQPTP9zPZi/4eRDLmz8XbC0qDvoEVaEs2yHQL/dDR0gczbob18XpfIAMqVZDDzWQdECDglsqzjTS9OTknx2Zt0bZkLc0IkGVM22+ALfLXZ5au17e+pmJhWc/tbDCsfMVQPyAk3frHXZCyJpl8AfS7zh0tF/eJ52Q4WNZwviLY2iB8SqXWNRUW7emuJBddwtzEzvw14gMf7k51PEZ70RK2l52CBJ430ru1M3QK3yX2BSL292G9n1UT/fanrZREfpljehX1L8f36/X765c049nxgpvTlEpvRUCvJKYZCc/PPEw7augidt4+K1aTJxjidn3ecTlK57/hN3dwpHMnI02Y1C4b4pAS3AtSyPpEaSWdLzRst7SBFPuPHd/yBrQHHWzwaHidIFtmdLXXkqwxlV/r/W1bWS4TxMnVP2bKcpEDhjy4F/9F77aSuQBIHn0Bimgesdd1UR15KQilu+heKpQhWwTErSR9vKyxQDqXNvJXYw3FMer3WIM8EGpmBKI2jiUv+lnqVO+L9p6QSzqZoGd8kKuF3+cN7lDXcubCVCBsf1LW7FVPn4L2XQrG2cHuH0oAR7ElYv88FuMH9D3aefR9fe7xzGNkjPy+clseGxf5vGu0JqdLhQb7dFQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(186003)(1076003)(40460700003)(2616005)(7416002)(5660300002)(16526019)(336012)(2906002)(8936002)(26005)(316002)(8676002)(36756003)(70206006)(70586007)(4326008)(110136005)(6636002)(7696005)(82310400005)(54906003)(356005)(36860700001)(81166007)(44832011)(82740400003)(83380400001)(47076005)(426003)(40480700001)(86362001)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:02:10.3692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b439e362-1d89-41ae-cd0c-08dac74447e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pmc displays a warning when a suspend didn't get to the deepest
state and a dynamic debugging message with the duration if it did.

Rather than logging to dynamic debugging the duration spent in the
deepest state, report this to a file in sysfs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
RFC v2->v3:
 * Create new sysfs file instead of reporting using kernel symbol
---
 Documentation/ABI/testing/sysfs-amd-pmc |  6 ++++++
 drivers/platform/x86/amd/pmc.c          | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-amd-pmc b/Documentation/ABI/testing/sysfs-amd-pmc
index c421b72844f1..89354da8e680 100644
--- a/Documentation/ABI/testing/sysfs-amd-pmc
+++ b/Documentation/ABI/testing/sysfs-amd-pmc
@@ -11,3 +11,9 @@ Contact:	Mario Limonciello <mario.limonciello@amd.com>
 Description:	Reading this file reports the program corresponding to the SMU
 		firmware version.  The program field is used to disambiguate two
 		APU/CPU models that can share the same firmware binary.
+
+What:		/sys/bus/platform/drivers/amd_pmc/*/low_power_idle_system_residency_us
+Date:		December 2022
+Contact:	Mario Limonciello <mario.limonciello@amd.com>
+Description:	Reading this file reports the duration of the last suspend that
+		was spent in the deepest hardware sleep state in microseconds.
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 96e790e639a2..2550ba6d28f5 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -13,6 +13,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -363,9 +364,6 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 
 	if (!table.s0i3_last_entry_status)
 		dev_warn(pdev->dev, "Last suspend didn't reach deepest state\n");
-	else
-		dev_dbg(pdev->dev, "Last suspend in deepest state for %lluus\n",
-			 table.timein_s0i3_lastcapture);
 }
 #endif
 
@@ -417,12 +415,30 @@ static ssize_t smu_program_show(struct device *d, struct device_attribute *attr,
 	return sysfs_emit(buf, "%u\n", dev->smu_program);
 }
 
+static ssize_t low_power_idle_system_residency_us_show(struct device *d,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	struct amd_pmc_dev *dev = &pmc;
+	struct smu_metrics table;
+	int ret;
+
+	ret = get_metrics_table(dev, &table);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", table.s0i3_last_entry_status ?
+					 table.timein_s0i3_lastcapture : 0);
+}
+
 static DEVICE_ATTR_RO(smu_fw_version);
 static DEVICE_ATTR_RO(smu_program);
+static DEVICE_ATTR_RO(low_power_idle_system_residency_us);
 
 static struct attribute *pmc_attrs[] = {
 	&dev_attr_smu_fw_version.attr,
 	&dev_attr_smu_program.attr,
+	&dev_attr_low_power_idle_system_residency_us.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(pmc);
-- 
2.34.1

