Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79A66CF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjAPSs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjAPSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:48:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2697;
        Mon, 16 Jan 2023 10:48:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AijU5rz8pWg1TOcXLj3XHUxn9g2Jk9o2W1kqIgv4i7oIaaANG44v1FeBxNFKw5a0HRBvXtLNRDvGVEClJakFo5ho+EFVIgy/DU5aRuZyjg8uTo+fxrobS/dOUh/9Si8BUSU2w2qsjzD1jTFAI8DrDXJTqYy6ZQOk7s4B7NZEM15nUjPjuBOewG+CyhfTaH0BTfISv0wNcPfmGtONGsPmP1qeKXOxl2MOXMsuYEK5agSmOibkOxrm8nQ9Lamu47ZQePldp1pqNhkDhKoNf0VOTpA2xYok8B4HRsBSzfV+95ZO6+lCCC4Bn6oWXnMUFUb2A86JAebX3UiEwJM745VC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lQ3Qh0AL750KizEhGjKAEYMy4oCTltvXgwS7OHuNnI=;
 b=RPXvGn/z5mHfxmYP9QR1pO/rpsjp96LL2OXBFK86T9vVfYGa6ucISCzxucv9rA57bXyqb2HcAp7fu2Mm0bZKE6eHlPnysVQMmwduY4IPR5ue/TXZGECnTpJ83MtIsCHig/qqaDggP2H/2QMPa40klGpd+n6axr0EgYOIyKhb8DvL1/615eayoAuqJa6gHFQIbsbW9NZpF+vh0780UC04S+M9wqRUhs4Shdgi8ojWj8iWo1asB1JsQ3jE0wq6Z5esf1nISd8j65ByJ6TVGWEWKpOM81r9tJ8Ka3crjwbbuWOx0kYR5V1WxRAg/k7mMX91kTvTd64UZG/nsYmjCkZVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lQ3Qh0AL750KizEhGjKAEYMy4oCTltvXgwS7OHuNnI=;
 b=tmMr0VPy4n9Dyz4ZPTiyoAxKFvQeWTE1CG/y44ghL9i4GFaNla2KoD+yg2WK+7OdkPvtio6WhDS+vMOzVzVCj1ulSTEGC1M55Q/iLzOAadpCOH3NQrixmbq51SF6YJ/vAR3RAm5/LmKN8NiPR2cy7O1E57odIa77syrrkfJ/t7k=
Received: from DM6PR13CA0042.namprd13.prod.outlook.com (2603:10b6:5:134::19)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.21; Mon, 16 Jan 2023 18:48:37 +0000
Received: from DS1PEPF0000E652.namprd02.prod.outlook.com
 (2603:10b6:5:134:cafe::8e) by DM6PR13CA0042.outlook.office365.com
 (2603:10b6:5:134::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Mon, 16 Jan 2023 18:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E652.mail.protection.outlook.com (10.167.18.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Mon, 16 Jan 2023 18:48:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 12:48:36 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        <linux-input@vger.kernel.org>
Subject: [PATCH] Input: i8042: Disable wake from keyboard by default on several AMD systems
Date:   Mon, 16 Jan 2023 12:48:30 -0600
Message-ID: <20230116184830.30573-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E652:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 7920ee46-13a8-4212-3adf-08daf7f246e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STYuwcOMnlMeFdJVaLrfx3PrbXr/MCMhUB/Nwz0dM6gUgZk/uOKXl+nLxjOTAXGB3h54Mw3gqmWFBSQRhtqgGNOtz8qYgfMH3ra8rdVZHW1oX1PEuVSPR0FlXLra5R8EfwzMxt375N81fX03zuBiNpdl/0+t4kRH4J9iG0f6YWItN7/00oYW2YmVAi8OEC62ChhBbN9wGnCSHoJ6weXkinLVr+djTy0Cjvbkq3uTCDlBc/G0xj8Zm9VllHI69p4wX2KRlUaQ6/zcEJhhQ7DcnY+NgrRp9/I1nYGvSSMq6RyrK/B2rNLKNnsPbOUd6wFh9W/dcXLss4vBR9LadmSBSBzqGCPqe0LlBNaSrfVb9ZW/n9/Rvk8JLK5eAo6fuXss6BJuU24jltlt3JQ1pZ8YkfwOv51OgQ0T1eUQnWl46i9FXasVd6H17lm4SmGVQuow4ITtlcEk+7tyeAEZe+zTSERAXy4o020C03xx+15msv7LsrnKlcTrOSJ7LT0R90vkSlgKbrCUjqsd1jT6CJK8oNv+lYFnPKA9nCFE6uQsFHRLyfJkY3P5ARvMDPagYvpXxyXz+ee904Y3cNnOSBErQx6RF7gT47ZPCDZwJnlxmpsu7G6mRy1c1Kln/simAksebITHa69wp9sP22GAlBWtjvCawwYUPGbv1hlzagReCSJP8eyOCYJ8jnmikblQHKVb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(316002)(110136005)(54906003)(41300700001)(8676002)(1076003)(86362001)(70586007)(70206006)(336012)(36756003)(4326008)(83380400001)(47076005)(82740400003)(81166007)(356005)(36860700001)(426003)(40480700001)(478600001)(966005)(40460700003)(82310400005)(2616005)(7696005)(26005)(16526019)(6666004)(186003)(44832011)(2906002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:48:36.9205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7920ee46-13a8-4212-3adf-08daf7f246e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E652.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default when the system is configured for suspend to idle by default
the keyboard is set up as a wake source.  This matches the behavior that
Windows uses for Modern Standby as well.

It has been reported that a variety of AMD based designs there are
spurious wakeups are happening where two IRQ sources are active.

```
PM: Triggering wakeup from IRQ 9
PM: Triggering wakeup from IRQ 1
```

In these designs IRQ 9 is the ACPI SCI and IRQ 1 is the PS/2 keyboard.
An example way to trigger this is to suspend the system and then unplug
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

This issue affects Renoir, Lucienne, Cezanne, and Barcelo based platforms
that use LPC EC. It does not happen on newer systems such as Mendocino or
Rembrandt.

It's been fixed in newer platform firmware, but determining whether the
system vendor uses an LPC EC and has deployed the fix is not possible.

To avoid triggering the bug check the CPU model and adjust the policy for
s2idle wakeup from keyboard on these systems to be disabled by default.

Users who know that their firmware is fixed and want to use wakeup from
keyboard can manually enable wakeup from sysfs by modifying
`/sys/bus/serio/devices/serio0/power/wakeup`.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Tested-by: Xaver Hugl <xaver.hugl@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115#note_1724008
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/serio/i8042.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 6dac7c1853a54..c9eeca18c0816 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -23,6 +23,7 @@
 #include <linux/suspend.h>
 #include <linux/property.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
@@ -433,6 +434,26 @@ static void i8042_port_close(struct serio *serio)
 	i8042_interrupt(0, NULL);
 }
 
+static bool i8042_should_wakeup_by_default(struct serio *serio)
+{
+#ifdef CONFIG_X86
+	const struct x86_cpu_id irq1_bug_cpu_ids[] = {
+		X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
+		X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
+		X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne/Barcelo */
+		{}
+	};
+
+	if (x86_match_cpu(irq1_bug_cpu_ids)) {
+		pr_info_once("Disabling wakeup from keyboard to avoid firmware bug\n");
+		return false;
+	}
+#endif
+	if (!pm_suspend_default_s2idle())
+		return false;
+	return serio == i8042_ports[I8042_KBD_PORT_NO].serio;
+}
+
 /*
  * i8042_start() is called by serio core when port is about to finish
  * registering. It will mark port as existing so i8042_interrupt can
@@ -451,10 +472,8 @@ static int i8042_start(struct serio *serio)
 	 * behavior on many platforms using suspend-to-RAM (ACPI S3)
 	 * by default.
 	 */
-	if (pm_suspend_default_s2idle() &&
-	    serio == i8042_ports[I8042_KBD_PORT_NO].serio) {
+	if (i8042_should_wakeup_by_default(serio))
 		device_set_wakeup_enable(&serio->dev, true);
-	}
 
 	spin_lock_irq(&i8042_lock);
 	port->exists = true;
-- 
2.34.1

