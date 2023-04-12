Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD16DFF11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDLTt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDLTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:49:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD07AB7;
        Wed, 12 Apr 2023 12:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdMnlXX8ap9tVJDkJGUOwjLPIl+QeD3pGAqLCKlo6taZcw23wOqed1ejGPZY1c3sDcT53Jfhnxrlq83XdmyOhGnPDKkSdrw9nq26W2qNHsBu9KNw5bZEHQeN03xtik/LyzQoLw3A583VyQSXZqtosj9DA/rPScCs5+wi5hKMbav3G3agcnEGbLaaR1bJpnx0ECcf0+SOimeYyo9rEIDpM78qlizHS84ApG9FjWZjCfKd1iikZemmvGxrIebuCUlbeAZxgfShWQuzyuWbARA7oSqrEnSyGp1qFAXXBkhqNHb8wQwRK7k8QGWemlhaV6WO/cda0jtW4112/WFTufsEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jze6VODEdn8Ll9pM/C4zzNUmHbotNqnPcxPU6N5o74=;
 b=ITGpcjipiVQuWusVfj3kZYSkQjrBmCS8v7O0GJffA+bD7YqDfT0vQUEz0XjOkYROEZi7yJpdyEij3jS3TrOSnSFJeP1hJKH5j9v2ee3EZEJgz2KT7EAma10pl0dHFJYhmlHEWokRcCLFyR9kksC2HPAEk8ga07U9Rtkop7jqknW+2g15DJSyCOUGCLxBH1bPtWQNb0kqoTGiRPKdv1QNrtC1Ui8ce1uv8Iw+IMBTa9t718kltLI3UGTSxLlHfGphKL7o6MjCF8TYP28nNvITPf+b3a/wqP0V527KneYbMUa/xjWkWH6mSL67NIVxS2fXR8z17wt1xiuqYIzqoMBftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jze6VODEdn8Ll9pM/C4zzNUmHbotNqnPcxPU6N5o74=;
 b=44RJfxPHjT0GlB58t+qoJcTC6NF1HvYZZ7RmTUxB4hIn6oKg8XCCL1SvqI4L6YBwGbc+Ft2aAdtrhcju0YElaGvzCCCjtjvlpN29YHGFXGtX/0qa0+7AsmtOgzIp/SnG52KWa6UK/uEzngpnUW/qgLYTW8HKniFKcQ9FeJ71/JM=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 19:49:33 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::3d) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 19:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Wed, 12 Apr 2023 19:49:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 14:49:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <Shyam-sundar.S-k@amd.com>, <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>, <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Wed, 12 Apr 2023 14:49:12 -0500
Message-ID: <20230412194917.7164-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT113:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a049b1-9fef-4098-2736-08db3b8f09cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rQ4ST1g4quhSBCDhgG+/zVe5ttqKnJTN+y/xgdCz9PqB4GgzhwJnRk2wkX1gtD0TpqXm3tOMm6nawYwTvpB8TaVLFGJx1gvur6JROHYgw/C/GCA1sEYLXRZB7wZNatICsdnzgpH3QfzrLQXcdTexp0BhuBlNhq8nk/GG1qaKZTg1LyXtVsYH+QsleR4kbFzVfBsJ65sMCNYjh3ecGdqv+1C8qelHuaQmU17TnkXAS+X7ZoLq/VSG+oHh+QE6B940RC5y6PO5O9PQxqwAQII1t2GPAa1oyVnHlNgU4L7I2yBboF2OhlWa5V+S0UUo7/FcEJKmhpalhhpBZiaSypZnSQdk41zPCqT4j67QZ9dPYgIqDXfINScZySkj8+p7PM1gL3mhsya5gW91RGWJQlwPB5mkwczEnqh4pZ1U5htlks97DC03OISevPNKEID1deitr71OWU5yWouA00+sBHa3DrcynIVtjGJPrOaqKbnfwEIdExSIwHq3s9h59HGeG9oOEJN7M7fROfDnoE+TIJvbJCqqPa5DxuvKZNEeNlSID7ScBtG79V4W6Pg+aSGCossQwJdbWgU6kEisncZggbsF17U3+UcJ+0NMITq/AnTnM9ivXKF8OAJi7E5dWBzFzLe9FAPe5a+/6+myH6d975dc55L2yVAJWqXiiB376yr/SG3QgF1RIUwM+W+tfDIfL5+cb8FnydyWfxP/r4z5OlHPxqPsJsDHyNeowkcOq54y50=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(336012)(426003)(1076003)(26005)(40480700001)(70586007)(70206006)(36756003)(2906002)(6666004)(83380400001)(82310400005)(47076005)(7696005)(2616005)(186003)(16526019)(36860700001)(4326008)(40460700003)(44832011)(110136005)(54906003)(7416002)(86362001)(5660300002)(8676002)(8936002)(81166007)(478600001)(356005)(41300700001)(316002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 19:49:33.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a049b1-9fef-4098-2736-08db3b8f09cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/platform/x86/intel/pmc/core.c | 16 ++++----
 drivers/platform/x86/intel/pmc/core.h |  2 -
 include/linux/suspend.h               |  8 ++++
 kernel/power/main.c                   | 59 +++++++++++++++++++++------
 6 files changed, 95 insertions(+), 25 deletions(-)


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.34.1

