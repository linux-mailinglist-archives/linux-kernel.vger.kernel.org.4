Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542CF6E199C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDNBYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNBY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:24:28 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A21F7;
        Thu, 13 Apr 2023 18:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpiHZrCwKBBHs9do9VtUZ1CvWcPaocGUAsMfGJC+C3DGgIVBJec99rx1URtYoz2LfYsm/oz22iLVXG+R3uAb8mXM7psOegVk8mGHR3nUhWxzPpe0DBcYPuSFOLHK+LE1jeHLrraupJ+wt0qn9a+orTI0tpebOW6zLDNNfLF4M/n5CERm2IVNZ6UkuD7mUjxJ7wCPlu/bxmYwi34OB2d0Lsqo53ihDCvaM5zL6UxuwHDKBoG4ofgxNvuQU2oaHq2HmpJjO0e2BZZNXAr5Yjrpg+8yvu7Amte7CN5k19Pml3H/r5cHVK9cCPF5zZFWNsshNRIvU/x8NrJ0srN8pmYCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4Lz7usC5ynPZjlDvVNFYAxXVojPa+WFoPELe1Zkg54=;
 b=NRlX5jsDYlArYIEav7DvBxfAYUT8wwEoU91s+L4s7bHWOACeh7wk/gzKn8aDnCl1OsMirCsyWnGaZg8PU+elUOVDSAr7L+cMRkJ+DfRy6zTJyr05IV2lUYd1IVDVPGhaGDs1CD62DstRoKEKGdKMAKvfnWNAvCLd0TaqbyfTdzjbuDWq0/tQhweGozVhv7q7dfBVozTgFtiJTV1zghpQymSXPpy8vucavZbZEwXZRHSkSB1EO7bpSqs8yJQMRVpcOB8Lu5o8deQ88vK3Jefuwvh1xy2Rr3Uy+8Oozedodh5jgEncHmyq9au3lgqifX4nyRr23URs+yBMevrpZWBJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4Lz7usC5ynPZjlDvVNFYAxXVojPa+WFoPELe1Zkg54=;
 b=cs3fGnXjRdSYu/qEzj4zcgHwGGw51YOaRIZT9P8tq2oQpyDUF+6rJ54Nxg2NNj8Vs1NIQodUkiCF2l/eYapvjTFVYZE92deXI4umeHRHqAZPDl1Y5E1JgjAwAIsb/uMdJRKwLz3s+Rfi6tRHBV0zLBW3aVI1YYbLRki4EJ7uM2A=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Fri, 14 Apr 2023 01:24:23 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::5f) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Fri, 14 Apr 2023 01:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 01:24:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 20:24:18 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Thu, 13 Apr 2023 20:23:41 -0500
Message-ID: <20230414012346.1946-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 525cd1b5-f286-4898-54f7-08db3c86fb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x+BtTnSsK0LTlFR42P31pyeKR4iPDHVoZmy7566HajdEOh4CgQcC2a6GAu2160Vn9nfXJz2tnrlpHqjK9gs0VM+2toeBKZufrEzsPA2M9yZy0OLfWuQoDPEKursy34VqpxYj4+8fufVGHmp20Rgp8AtaknUOz5zWjNqNc+99eWRDJGSPwFwsjLr2ePCBStUxbYpWIOC79zMgJjFlzl75IQdQIx3yXQJVBAIaj/gjME+DHXS2UiA9sWCBtqfGWX7lqv2cQGF8i7+s4aA6HBBqvDjoIF3sPCnU0r2mFlAHoAotodTH5Mop15TVfU8ZmZtG8TmOGFMRC1DtyLj/Kbdo2smEVRFBv1QEXBeoIfdcWTjb+ZU/Q6F4u5zeaU4T+gO1ca+kevoix3G4shw7vAt8rdvDm8LxbZVJwfqo3IuDXowrwjpH7YEe+88UfP6bFZUK3XY51dA1sq9xjq0dWCqEAGO8p/AUpXvjiY5veSM15br1Afh4RhDEORmYfnaWJNWuMVOoz81SaijWSHsYZntqvh/sjna0LwoJV/KLN2WwuAJniT1qbdXDg+DEtiCZZhPI0BRlewVokqaC2qwob6wpzr8SV3qxctXklRxW6tugM6Q4WLF73dSkpQSoK4pwHi2YmqOD7SMvysBfW+7j9KrwZredhDEwaEDa9RpNl8g5bj9NpjaI7isR9R5/sfm/EBFrQ9XJdN0c74EXC/jrhaDkf8bEkTZAitPxTW7x32vN5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(478600001)(86362001)(426003)(336012)(44832011)(2616005)(8936002)(5660300002)(4326008)(70206006)(316002)(1076003)(47076005)(83380400001)(8676002)(7416002)(70586007)(40480700001)(2906002)(186003)(36860700001)(356005)(36756003)(54906003)(81166007)(26005)(82740400003)(82310400005)(40460700003)(16526019)(7696005)(6666004)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 01:24:23.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525cd1b5-f286-4898-54f7-08db3c86fb14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

 Documentation/ABI/testing/sysfs-power | 29 +++++++++++++
 drivers/platform/x86/amd/pmc.c        |  6 +--
 drivers/platform/x86/intel/pmc/core.c | 17 ++++----
 drivers/platform/x86/intel/pmc/core.h |  4 +-
 include/linux/suspend.h               |  8 ++++
 kernel/power/main.c                   | 59 +++++++++++++++++++++------
 6 files changed, 98 insertions(+), 25 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.34.1

