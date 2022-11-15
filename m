Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E962A260
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiKOUCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiKOUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:02:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BD28E04;
        Tue, 15 Nov 2022 12:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcxFTn2CEWlBPS1TtN0qOe3XJg+8bRV7zDibP/szvMiNAi4UnMoPS/Fbi0OlRgrgjxUu91Do7gDto3lU3U1ZIQoH8Bbr3mWJ78MKS5gL6OE9E3To83bJ2NvQOFigyQ3tGIL1GZ82Kep8veQAOWuaZCDDwjNBqBG1/xQuTV9j9BTv3ld7oS3+Yub168TWPktWq2WvRhjkFdXbC3WaZuGqvXuEQkE9hE1EQj3HYR2LHQc34Fj+kwW0/Gd6mqxOv1Q0h0GpA99zmCRTbyeYxOmAbqRJq7Fj91Ief5a66iWw7aQxiVxE+BJoc8S1+6u5IWDRtomaStKS06AQEP0oyiP8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hh11FskTtxEZqoQn3p0cx0bTGV27W4TXK8VWH4Mxpg0=;
 b=WSjBy6upYlAYvpd18Z98jVNm5Lv7pyIZhj6dHX6AGxedPxUxbw9wTksJo6aaSjDQYpUiPUGXW2f3jHHpeo5ug93vRaJ+b3wMgq5fPateh6S1UzXEB2gOhe1Ts92EPFy/tj5xIyDC52CETmuD8tHRcQJ0whwUqeIE7AP2IHk3TSZoGVPSMtugMRiwCdibiDbu5zsmwmZ7e0kPISnuIkAg0LrSjA1DmXlRykhoY/yyhLxyFvsr4i4yArcVgTZov5d77EsJ8ZYDGZufdFEZyFjw2hrDAzsIJ3vlQ6/49lOdAce1PffXY7S0WBrzVwxABDNpU1LUdGIr2Tkz2G95paT6qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh11FskTtxEZqoQn3p0cx0bTGV27W4TXK8VWH4Mxpg0=;
 b=n70fFsIpS/tTrMx57PtvSwt1avfK2UqQsLzg6vIm/C+g5MxCyQ566nRbYA36NQLePY/IsYAxaqXXvvQST9bS3bqlPTIq08uLI+F4hNuN5Ny9BmNQWJKFtTHnwGCGW5usTG4pVOC2nJDJDX3lLqS925SPtk80QesAh/5sp7lf/hY=
Received: from BN8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:ac::21)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 20:02:06 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::5a) by BN8PR07CA0008.outlook.office365.com
 (2603:10b6:408:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 20:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 20:02:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 14:02:05 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFC v3 0/4] Make it easier to measure % in HW sleep state
Date:   Tue, 15 Nov 2022 14:01:52 -0600
Message-ID: <20221115200156.12218-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8647c367-90b4-425e-774c-08dac74445b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCsupEa1ty64Y/ws9ISHKq0Ep5lTlesQ1u38psGQtY7sw+fSAsvfQUAGL1vEi6oXungcLVC43sGJIUQzJN7KsxQDE32PKRzPG5pCuTK4Pw/Q/OpvpHJFj8wcKmUviTA9SXoMVFmLuGj7yvBHBUC1Wnw02gAvyQ5BEj88Oib/AgoGKSNiYly36KqlvdE5LZ2VhozFPxZ6gIDtZbdPKsC4iFsdvvDVUA8pukQJAkLbe2AZVrYvM8Ts8sJ8aVuFD/hnY7WW7cw7ZkyB7lfAcn1p+jcuDuV7vljoyRSwwdVwwuq4p9HqxN7wgkJTEs2n5wzxyNXayjLuZcI14BYvq+yjAYamW24INGfGXkhuWHjO3J2bpbUVZCeduAz5nKWi6fZMnyroJ/XHKbbCYRuiDdq/3pIXfLWcUQ0VadlGaeUQhUTCCgxsD/ijhcBoq9VF8RfrC01BoJZBTzIeKfItgfX4OEOV8TT8Vm5rDwH4G67yIhyUS3Kn2kBbo54KEiAu4OobFN8OO8cGw5iwFBa/htg4CQAAPCbge3Lp8Me1pvdHfMFjjFSm+M9uzdFQgs6k2CO34st6ObsIZiblcN+xmCVBDq8qsDeDOkLUWkXhyIeZonzXQowpVWwQHRLmD7pZpQp75XJHYonei0qCmYJH3q9o0JbEIixUeCGQI2Q6IPxQlBjJgafNTaP4NSxhcuR7ZoJmEvQ0/RiB9BSxF0NjsX+oGtjkT08PgJ86XAMda3yQqw5J1vzmY0YRR/BXunjf4WeW4RtvT4f4yzRh+ykrK896bStfVZ19CKT4mwwuhPCFRg5ompDZAaVkSrpiDYn+aJNB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(70586007)(8676002)(70206006)(82310400005)(4326008)(83380400001)(36756003)(36860700001)(8936002)(44832011)(41300700001)(81166007)(5660300002)(356005)(7416002)(47076005)(2616005)(16526019)(40480700001)(426003)(186003)(336012)(7696005)(26005)(1076003)(6666004)(478600001)(54906003)(110136005)(86362001)(316002)(82740400003)(40460700003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:02:06.7232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8647c367-90b4-425e-774c-08dac74445b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven van Ashbrook brought a patch to the kernel mailing list that
attempted to change the reporting level of a s0ix entry issue to a
different debugging level so that infastructure used by Google could
better scan logs to catch problems.

This approach was rejected, but during the conversation another
suggestion was made by David E. Box to introduce some infrastructure
into the kernel to report this information.

As it's information that is reported by both AMD and Intel platforms
over s2idle, this seems to make sense.

RFC v1 and v2 introduced two new sysfs files to report the information, but
Rafael pointed out that there was already a file that could be used on
Intel platforms: `low_power_idle_system_residency_us`.

RFC v3 creates this file for AMD platforms and also introduces another file
that can be used to determine total sleep time:
`/sys/power/suspend_stats/last_total`.

With these two files a simple shell script can be run after suspend to
calculate the percentage.

```
 #!/bin/sh
total=$(cat /sys/power/suspend_stats/last_total)
hw=$(cat /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us)
percent=$(awk -v hw=$hw -v total=$total 'BEGIN { printf "%.2f%%", (hw/total*100) }')
echo "Last ${total}us suspend cycle spent $percent of the time in a hardware sleep state."
```

A sample run on an AMD platform that was just sleeping with this series on
top of 6.1-rc5 shows the following:
 # ./compare.sh
Last 15699838us suspend cycle spent 98.63% of the time in a hardware sleep state.

Further discussion to be expected on this series:

* What last_total will represent from the suspend cycle

* Whether the semantics of all platforms will be the same for
  `low_power_idle_system_residency_us`
  - AMD platforms reset this counter before s2idle entry.  Do Intel? Others?

* Maybe the *kernel* should be responsible to do the calculation and export
  a `last_hw_sleep_percent` file instead. Platform differences can be
  abstracted then within individual drivers.

Mario Limonciello (4):
  PM: Add a sysfs file to represent the total sleep duration
  platform/x86/intel/pmc: core: Drop check_counters
  platform/x86/amd: pmc: Report duration of time in deepest hw state
  platform/x86/amd: pmc: Populate cpuidle sysfs file with hw sleep data

 Documentation/ABI/testing/sysfs-amd-pmc |  6 ++++++
 Documentation/ABI/testing/sysfs-power   |  8 ++++++++
 drivers/platform/x86/amd/pmc.c          | 27 ++++++++++++++++++++++---
 drivers/platform/x86/intel/pmc/core.c   |  7 ++-----
 drivers/platform/x86/intel/pmc/core.h   |  1 -
 include/linux/suspend.h                 |  2 ++
 kernel/power/main.c                     | 15 ++++++++++++++
 kernel/power/suspend.c                  |  2 ++
 kernel/time/timekeeping.c               |  2 ++
 9 files changed, 61 insertions(+), 9 deletions(-)

-- 
2.34.1

