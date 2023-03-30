Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355AE6D0F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjC3TpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjC3To5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:44:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AE935A2;
        Thu, 30 Mar 2023 12:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVud/tyTyEdCDQXMg/PvD6Y7y4lXf7UxOrvcMlSqT069yhd/TYmvhjTcCaSHpFtMstARlfvmM+PWIugDhM7L/8DjSZRGImLGtA7zxjBpf9icelAEvzlIEfSuLJMANKA9C/1a2iixctrjrivPoVfPCrk4j/T0Cex2c/JdQmD6GSdK2gxpu1lwCmU/prnef//ufsbP5JVLGjCCkAEODKnd6Wo1BOPp0FM2CddxffYx2A7jdSosysls4FqsRQzU4dzunKywqLQ1Y5F08m5eJc246S31hGDcwUC1emLRAULEkR0VxPFtqz6QfKYdKFdtk0UbkS75PiM3IFf6VUr0r1/6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n951d29tQYhail1QPyHvl1KFSGUJaJDdPS/6kSYzSU=;
 b=ICf7fUK511+e58lqFjPAS+JQyWEuCDf+rrCZk2c4KeJyvqjeJ62+QKobiAglY9qMwJfWaUdbYsmkvK5yGLvD+CNnX1k+6WQFL5+qcRG6gjv8A4b8U47MUhyomn+mS1s7Tk9z/ei0jfhI4oAB7mBvQaxKnAJiZ+wLch0WY9gNM1GuUTj/oWBl+sxM655r2s5lGXTBQauuAHrNDsBlfm4zCDjMSg65M2Jl1A0HU38I0p0F6C8PwHqDmrcWKZHmeKEZNlo30iJtyxXc8gsfs/z9hdIanO/47wOHi98aCUEWYi67lRNPCuSrKyOPeaS2C//UaPwwVw9gitb9CrLQ3Oy5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n951d29tQYhail1QPyHvl1KFSGUJaJDdPS/6kSYzSU=;
 b=pqxPqCjnfgW0nIgXaBy1rE7bk2QSf7L7zah9AVjrWyva6gvbgTV93mMiwz/3NPUfVbaCgsFuwCPmNHlBV6a7F6hWepj7aX30Wg9GG/KggPtpOtLU2lXrzoK5paGRuqv89Pwt8pDBU2To8XMdh8UyjSGY6wXSVE5/epZfRZZyWj8=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 19:44:54 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::6a) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:44:53 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:44:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Thu, 30 Mar 2023 14:44:34 -0500
Message-ID: <20230330194439.14361-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|DM6PR12MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 251a6f4d-b066-4137-2902-08db31573be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPAtDguU5JeCfpasGmvJZGMBrDZgoH7QAQSO9/Ggti9Ay4Dh+Qjy7sn4SSoZORpyy9bBoHkjCkSe8VwdI8BMwin/2NGnNt621PXWJC+0ruvxdTGczygUW7sBpZ84l96loGMwMEdU66S5jAQyqPRTdgryVnwZjslwxFVRcJAuuzQ8/zbpxUsuKIWXuQyWNS5xEq9VVgmkOx53ZorM+SAf//l7bKuwSsKLvOjKcGWEgGcHlC3U57aTbJ/xU0ruj9v1QKDwpMjWVGYvPbJttcobiEUmnCKWpc0tjrTLW4knDE2yijzkzkirfHrzYAxY/WL4Ma8EEBhTk2Wy8BQ1T3kHUt3wTmQ8FtXhId0g8WaAv4xDo3QIbvhUSC7MrESkdPXEoWIqhacAjM5IS4HwnZh2+3PCAJAR3xKd4qju75QJab+N+d3GohCWxbYOgvNeHIOTIz4CWQ2mKdu5UOHNu6ucQz6g57vB3DMgxQcwPaBgBa10hC2xR/j9YW/Y4ubirvMrOWLj24e6R2+9eGDE59xwQDenHh+gkwP4MhUe9Vhk7MlO6R5OXQ29ebyeCqciRU5c63xdghWYGJtjAIGtyerZxlaGIRFh78PGyjHhuLRv7TmVhv/sh+0Kf+QSd8lvMcT+RaB6k7Jfb375xOGEODs8+ntqsawPpUVxpLojahz2wU+8W1pLAhscqOF/Teo9IAytTyhNe6XGolFFF0Em8rgW8vqg4qid22TAFU8Q0CZFt5I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(356005)(83380400001)(1076003)(81166007)(82740400003)(26005)(6666004)(478600001)(40460700003)(110136005)(7696005)(70206006)(316002)(7416002)(82310400005)(54906003)(36756003)(70586007)(86362001)(41300700001)(336012)(4326008)(8676002)(2616005)(47076005)(2906002)(186003)(966005)(426003)(5660300002)(36860700001)(8936002)(16526019)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:44:53.9000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a6f4d-b066-4137-2902-08db31573be4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An important part of validating that s0ix worked properly is to check how much
of a cycle was spent in a hardware sleep state.

The reporting of hardware sleep is a mix of kernel messages and sysfs files
that vary from vendor to vendor. Collecting this information requires extra
information on the kernel command line or fetching from debugfs.

To make this information more readily accessible introduce a new file in
suspend_stats that drivers can report into during their resume routine.

Userspace can fetch this information and compare it against the duration of
the cycle to allow determining residency percentages and flagging problems.

v4->v5
 * Stop calculating a percentage, let userspace do this if desirable.
   Userspace may just care != 0.
 * Fix S3 case for Intel PMC

Previous submission:
https://lore.kernel.org/all/20221117225822.16154-1-mario.limonciello@amd.com/

Mario Limonciello (4):
  PM: Add a sysfs file to represent time spent in hardware sleep state
  platform/x86/amd: pmc: Report duration of time in hw sleep state
  platform/x86/intel/pmc: core: Always capture counters on suspend
  platform/x86/intel/pmc: core: Report duration of time in HW sleep
    state

 Documentation/ABI/testing/sysfs-power |  9 +++++++++
 drivers/platform/x86/amd/pmc.c        |  5 ++---
 drivers/platform/x86/intel/pmc/core.c | 15 +++++++-------
 drivers/platform/x86/intel/pmc/core.h |  2 --
 include/linux/suspend.h               |  2 ++
 kernel/power/main.c                   | 29 +++++++++++++++++++++++++++
 6 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.34.1

