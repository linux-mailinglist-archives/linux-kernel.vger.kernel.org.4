Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C56DE654
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDKVS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:18:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2715FDA;
        Tue, 11 Apr 2023 14:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUFDYOFwGVn3xOvmnddFzKuhWG2G5zU5XmxXpIrxC6RTlzA6Pa7mzw6AjOUhCDuZQQEVOf7W8aYCpvYa9q3cAB1TqyaoVNEYFfPl+CgIK+0Ko2o1lupNG6PgEJNbMUfQQjugrkb8lOnnX2qx27fuPmAwf70jqd3654hYf/e4PrndkEnZt/Uezi0aqE4Y8NJJ1lPUKpyd6TG89rLnqBL28jJPPEFc/da5hWi+hEQFsC6Xo4kegx/HgfYat681ooSVyfw2FOkFtSrg6yIyx/rYD+mzUbCyLb/6tCMXBPJQaSQ29qjv2ENQiniJ4mqMY+WWl2wXu2jgjDQNlKDEuUQA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE8MRLhkhixWhGJobhh4Akc9sdxPv/vAzn5PTr+H/FQ=;
 b=l2KK20gnyMnqPUuvTicEHVVj4dh4qN9fmww67eywDnb0XlqatjAK2z5D5AWyEetpoHlFdt5M2x9oe3e+BDiJaLHRsYFURy4TDxmixbTSEkqz7ZwFPEdKROMNzU98G9mkuI/gmvRHopvN53AIaJN3i0mDRGoP41ATLej+Wxz+ZFuwRvAhXouBRDPN3GKC79/Oa1GsHmcPzByNo4XX3Zyg5d62B/uXGFxeanLEfKvmRk/BhPXLWTf1naghhgqCGmI+oqS9rTHHH8vsN8s66YsXeBFblZ7Z7PKAFT1bNhyGjH7oFVWDWVZEzdUU8/IAkmKEAK36SVL30cck/ESEqcGa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE8MRLhkhixWhGJobhh4Akc9sdxPv/vAzn5PTr+H/FQ=;
 b=yl8jyPlJS1+U3vakzQocnBq6OlYiQJvZCDTa38FdSoZMldK/ZCIFoHXVM1Pv9wQ3mVM6vq+Trn1gBgkOODEGh1QqW50LzcKU96jIMPQ3J4R9RbfDAcZpYaKRZ8aqqiZqp86QyTEYRlmIxFDtaCYfPorvwzrdRIkKHDb+DcZraYo=
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by CH2PR12MB5020.namprd12.prod.outlook.com (2603:10b6:610:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Tue, 11 Apr
 2023 21:17:49 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4::4) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 21:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 21:17:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 16:17:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Tue, 11 Apr 2023 16:17:14 -0500
Message-ID: <20230411211719.4549-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CH2PR12MB5020:EE_
X-MS-Office365-Filtering-Correlation-Id: 64329f96-8563-4a54-36ea-08db3ad233b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoT/+wwkTtG6ANxbh/hjI2spzkawa7Hm2XKakDNKJj3Hs7Tcq1pwn70dBAX340Ni66JJHg51+1FvSst/14f/jF2AF9GWv25kY4AO9On5T4a11kH6KCezfIkmCPairXj+FTVJcLEB4ju0LGvAI9cML9f8Uk/SukIMawcouvk6rXi5kbgHgMaFJbEiHD6fnDKopoYueuNdlvAE85bIL0UUav+zTCYTBXILSybH1ccx7gsH47IlyZMbynPjwQHTEOGE0vC7bLPI3eeGeX3NIRwzdtbh1jpfDkax6ksjGCKxWLRCb8GSJMmLIMguc21U/PNzRU5Ql6Xkfb37VO5l4VMQduvoM3CYHocPKSxJNvo4xBfiAoFi+bfwcm8+RPfmx3AnGLQxWQOtTkeoYR7FnBwbNAWl4sIV+AwPuSwP+ckmpdtRfIjYVsIlJmSyJLZ/Dy3oYyJVgv27DwZDhr3TZIetTX9e3Qy+QQ9rdBu1cSvi0NZOMulg+9t89aDFbRwfaBQvMiSCDVv3D+qZ+gsjabag3VhUrEbddZOm85FAg1VYK8ehb6YRAF9esyx7n+Tuq9vMZvQa8i5++2pZzfIOxUFgrholHw3eSe8dozMUj7kEPtxj5w9GsiTF8mVr/Cvw5sYm5oZ7WZXmS3Qf+0oQWaZ+glnsK6E6Ztf++qU/gI5G/5OA4Hsj1sEtBRocZzjYZqEJb60/VHXvNcdTA12rEtyYx/IpEiYVfTVXr0gEYiwiw+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(7416002)(1076003)(356005)(82740400003)(26005)(81166007)(47076005)(83380400001)(426003)(336012)(2616005)(186003)(16526019)(36860700001)(40460700003)(82310400005)(36756003)(44832011)(41300700001)(7696005)(316002)(8676002)(4326008)(5660300002)(86362001)(6666004)(8936002)(40480700001)(2906002)(478600001)(54906003)(110136005)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 21:17:48.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64329f96-8563-4a54-36ea-08db3ad233b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An important part of validating that s0ix worked properly is to check how
much of a cycle was spent in a hardware sleep state.

The reporting of hardware sleep is a mix of kernel messages and sysfs
files that vary from vendor to vendor. Collecting this information
requires extra information on the kernel command line or fetching from
debugfs.

To make this information more readily accessible introduce a new file in
suspend_stats that drivers can report into during their resume routine.

Userspace can fetch this information and compare it against the duration
of the cycle to allow determining residency percentages and flagging
problems.

Mario Limonciello (4):
  PM: Add sysfs files to represent time spent in hardware sleep state
  platform/x86/amd: pmc: Report duration of time in hw sleep state
  platform/x86/intel/pmc: core: Always capture counters on suspend
  platform/x86/intel/pmc: core: Report duration of time in HW sleep
    state

 Documentation/ABI/testing/sysfs-power | 24 ++++++++++++++++
 drivers/platform/x86/amd/pmc.c        |  5 ++--
 drivers/platform/x86/intel/pmc/core.c | 15 +++++-----
 drivers/platform/x86/intel/pmc/core.h |  2 --
 include/linux/suspend.h               |  5 ++++
 kernel/power/main.c                   | 40 +++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 13 deletions(-)

-- 
2.34.1

