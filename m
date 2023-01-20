Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D12675DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjATTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjATTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:15:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AB95193;
        Fri, 20 Jan 2023 11:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZU6k/Nobvf8CL6TzEr1zydg/NSszHbHzEFRVTYPbQlCF7l21+vvPsUoyyPcBS5/ShRa0YLSpuWXnhhAK0keeF+a/9xogApkbudZUghq1/IZd5/dMuglR8JXlPm0NsM3dRwtLrmWaBaZddGqTsfFdnbjMs4vmlmTVftMuKSm/Wzdbm5bz7U9GL4wH92CWjIty1c6CNoZqRirnBMmf0kq0yRUX0yblaOHeUh/J/8R4Pq8eREDV8kgDE7Wxi8EhmiPhySJD16tQFaTXY4sFwQAL7tPd5AXB/yt4Aw1wQmfE0glD3mXaMsiiUCe46ibyIPzp3x0bq0pkDKFmibr7ngZGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNaxUg/SL2JD0XmaaiFFxCTxH8mEA0+i0kVhmcMIa6g=;
 b=G6L3g+41Iv286eY/EKLBweUbrSLLj5uhmyVMeSveltxg+oMBXwAT6AGzthakZOGjWLUbTRKbCstqCor4tSPJ0xTTNPaErYWglry5p1Gcx0GNUioNdQUhXNzOGZ2gp35U5wWCG8uSZJQTRXxUNh/iU61bmKiYl/TDHiFg/sAge9tQPecmoaUfeIoeljg1RpoljNX8P/xbrr658BO/L+50TJnWKG/hbrUV0k5QG9VgE5hT0UokTK9/WrZIPq/xnkwv9M2n/k2A3OkssPsABYOZnygV+JE2ejsGjKHHHbrOWatBusBkRzbfLI6pvnrQiriMkSx86ftS1CmKgbQgPWjtYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=canonical.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNaxUg/SL2JD0XmaaiFFxCTxH8mEA0+i0kVhmcMIa6g=;
 b=Cr1HXHJJpcYUzQAO0jcp1e3hKTaoTeIUxB0Aldka6qshZIw/eiA22UHwSTLtgVnbamC2s9HmNeCEBooIhrIrsDnCCv8bOm0Ds0zsti59G0eV6jMOo3EulzuWMtLeckS4TYAUlJCjSA9+cKt4m0Ugc6j79H2Xf571L1XC3X07Zkk=
Received: from MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::7)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 19:15:19 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::14) by MW4P222CA0002.outlook.office365.com
 (2603:10b6:303:114::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 19:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 19:15:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 13:15:16 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     <kai.heng.feng@canonical.com>, <xaver.hugl@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] platform/x86: amd: pmc: Disable IRQ1 wakeup for RN/CZN
Date:   Fri, 20 Jan 2023 13:15:18 -0600
Message-ID: <20230120191519.15926-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: d5980761-fdce-4280-6201-08dafb1aab2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2jiYUs0VAVsMBIgb1KtAo7anDPLzBfH7/066b8ZHFdYg8sgg2o2rihGCdeAO4ddnipkg7YAhC/JUFsfr5T7IM7JaoFp1DaUvQJqArG3mjnDzczosPihVn3UBFbDEz4N7fwJNOdOwPAkpfUp8vyh2AfNPQ6aF8iwAnSeYuxan9BkIkfiGltRUX52QubY7PeILVwsjikiW4aaB+erT6h1TfJHHj2ANjsLMgEQlxI4VBnyxtCzQUXZmdyhD5v2qIxAyhHd1hfEmwlQDunuDeSgHHUxUjsK6tYa51ZguO0m+Sl6wC+MBvliCJUvlXdSbRxEWCxhUWCcLaxAevwVeW+jE5AZmRw9BnLshQtZfHkISvnw3j4VXrqu4QqGxOKrZwkibLszjHJICMId82Qs/LgJQ2YmylIoEUJturrZ6ojDUeigcQwA6iatDiGL0CrRIPQ3j+USBqn+PXuiaGDYLzOj+BSKnQ9szz/AWfVg+YNyxLyYSmUbLGRJ2WT+0b/yN2NmevP7jh4WmEx4BtxIQmYfs/GcRYqo2dpUGrQYX/FAADp2SbZ/879E2DKeacxk8oOQXkFiud4E0i9msnZJ7Zzwz4poZWWJjcMqYXq4c6EYmO/0Ywh4BGd7RQJl7G5FFytc6sC5SjNquTuhxSbO2ZykMbGydnMEax4UkfMur+vqkjrhV7BVOn1ISmuX7lWgextr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(186003)(26005)(82310400005)(44832011)(16526019)(426003)(86362001)(47076005)(83380400001)(478600001)(2906002)(40480700001)(70586007)(70206006)(966005)(316002)(1076003)(336012)(37006003)(82740400003)(4326008)(5660300002)(8676002)(6862004)(54906003)(7696005)(8936002)(6636002)(41300700001)(36860700001)(356005)(2616005)(36756003)(40460700003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:15:18.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5980761-fdce-4280-6201-08dafb1aab2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default when the system is configured for low power idle in the FADT
the keyboard is set up as a wake source.  This matches the behavior that
Windows uses for Modern Standby as well.

It has been reported that a variety of AMD based designs there are
spurious wakeups are happening where two IRQ sources are active.

For example:
```
PM: Triggering wakeup from IRQ 9
PM: Triggering wakeup from IRQ 1
```

In these designs IRQ 9 is the ACPI SCI and IRQ 1 is the keyboard.
One way to trigger this problem is to suspend the laptop and then unplug
the AC adapter.  The SOC will be in a hardware sleep state and plugging
in the AC adapter returns control to the kernel's s2idle loop.

Normally if just IRQ 9 was active the s2idle loop would advance any EC
transactions and no other IRQ being active would cause the s2idle loop
to put the SOC back into hardware sleep state.

When this bug occurred IRQ 1 is also active even if no keyboard activity
occurred. This causes the s2idle loop to break and the system to wake.

This is a platform firmware bug triggering IRQ1 without keyboard activity.
This occurs in Windows as well, but Windows will enter "SW DRIPS" and
then with no activity enters back into "HW DRIPS" (hardware sleep state).

This issue affects Renoir, Lucienne, Cezanne, and Barcelo platforms. It
does not happen on newer systems such as Mendocino or Rembrandt.

It's been fixed in newer platform firmware.  To avoid triggering the bug
on older systems check the SMU F/W version and adjust the policy at suspend
time for s2idle wakeup from keyboard on these systems. A lot of thought
and experimentation has been given around the timing of disabling IRQ1,
and to make it work the "suspend" PM callback is restored.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1951
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 8d924986381be..be1b49824edbd 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
+#include <linux/serio.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
@@ -653,6 +654,33 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	return -EINVAL;
 }
 
+static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
+{
+	struct device *d;
+	int rc;
+
+	if (!pdev->major) {
+		rc = amd_pmc_get_smu_version(pdev);
+		if (rc)
+			return rc;
+	}
+
+	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
+		return 0;
+
+	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
+	if (!d)
+		return 0;
+	if (device_may_wakeup(d)) {
+		dev_info_once(d, "Disabling IRQ1 wakeup source to avoid platform firmware bug\n");
+		disable_irq_wake(1);
+		device_set_wakeup_enable(d, false);
+	}
+	put_device(d);
+
+	return 0;
+}
+
 static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
 {
 	struct rtc_device *rtc_device;
@@ -782,6 +810,25 @@ static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
 	.check = amd_pmc_s2idle_check,
 	.restore = amd_pmc_s2idle_restore,
 };
+
+static int __maybe_unused amd_pmc_suspend_handler(struct device *dev)
+{
+	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+
+	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
+		int rc = amd_pmc_czn_wa_irq1(pdev);
+
+		if (rc) {
+			dev_err(pdev->dev, "failed to adjust keyboard wakeup: %d\n", rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(amd_pmc_pm, amd_pmc_suspend_handler, NULL);
+
 #endif
 
 static const struct pci_device_id pmc_pci_ids[] = {
@@ -980,6 +1027,9 @@ static struct platform_driver amd_pmc_driver = {
 		.name = "amd_pmc",
 		.acpi_match_table = amd_pmc_acpi_ids,
 		.dev_groups = pmc_groups,
+#ifdef CONFIG_SUSPEND
+		.pm = &amd_pmc_pm,
+#endif
 	},
 	.probe = amd_pmc_probe,
 	.remove = amd_pmc_remove,
-- 
2.34.1

