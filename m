Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A976E4D20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjDQP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDQP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:28:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840CB75D;
        Mon, 17 Apr 2023 08:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5xa7O+JPDJlegDo6O8S//lxqZ9kd6hyYkeRQJmGtFkOVYTuf8cnOrMG/Lnwl50/M61b7SX1vP2B2pky0WxLYwEQ0XxUKYyIFIlkqh+rTnBAbqARnMYjGius6FYUT8fc1CHzpmGouzaA8uWmQUOYhyLlhG8AQYf55wRmBm5mX3RSLbK29sIY3qoPKIESrai8HrlEtC/cWCxiDGjSYqyc7xFbDgoAwVuSxu460IqhMGmIvYRJxb2a/1TneUIlc3VOcfXXJ0fkleKXadHSE53fit1kRXTh8dkGargZZkM3koZeE4LT7Hmt5gE9Yu1FsVBlIxItsdPkBj6VSb08//eddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX7IzZ9NoGafkcLs9B6Bii7+0aRCJ+oL7qYtxqnKRdM=;
 b=RbvjwWau21zzSvejfmLHoOyHBNe0ymGDf0faN5fPAiaW0UggemViU8y0uDAtD4C3I3qzTFcRBkM9m8iCYu0PHMIPXGUjK676knV001K+M52xGwLaQscqN2YOwZuQ0xMmlN19RtOhj1iAvkSi5DWj0IA1zlDXQ70H0i1CRA8aof1I6D4J17osojN4qnUzcaUIjqjAqCPBJFjSI3NlEnj5gSxMHvybQxgLsq2TBBHX9U3MMbOh4wapYFRz3dxWWXe8kBDVhIB5IO+t6LXNlVF4QT+I5UnatEXTOLjNru6Ny1IZgD9qgN/PEipR1sxONk1wMY9UnqxAVBwvtUHJKnE42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX7IzZ9NoGafkcLs9B6Bii7+0aRCJ+oL7qYtxqnKRdM=;
 b=JCnAttsu3Pz0oGMdvQID100oC0GMTQYvH2dXfTKKTt4NciXm9kyb5dS4sbF89SrSQOGNeWYL2gWqIhhdsoz7A/SsWnZF8jcDM/crtStEUj6WVNNuEYz+hL8nzorYIEiilbhLChLdfkFQx5/fMkRg5sh0gEV6Nu+9YHyyL4PihRc=
Received: from SJ0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:a03:333::9)
 by BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:27:27 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::b9) by SJ0PR03CA0094.outlook.office365.com
 (2603:10b6:a03:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 15:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.14 via Frontend Transport; Mon, 17 Apr 2023 15:27:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 10:27:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Box David E <david.e.box@intel.com>, <jstultz@google.com>,
        <pavel@ucw.cz>, <svenva@chromium.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <rrangel@chromium.org>, Jain Rajat <rajatja@google.com>,
        <hdegoede@redhat.com>, <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v10 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Mon, 17 Apr 2023 10:27:04 -0500
Message-ID: <20230417152708.3599-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|BL0PR12MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: 73329d16-f645-46e1-c2df-08db3f583fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVtEeHKHYUvVEfIjqo77bQ1ENzsaQKhGKNH3wVmB1BxRYOjXOnrnlLFQHFFWyFv8tHQCK7ATyebI/SGtz1M+XAdBudFFMLf+K5KVmyPdowP+5QZ2JWBy74FZMBArz+lgMOZzkjF7+inAVxWp6hLVPAo/wQt4aaDWQfyZAh0vG/DshuYA1hlGSlFcmGBmajqq7m+QlpRsxoomXvdQbm+qmwgbgrlWpW1wsVXTTfY9epPqkP1v+wksP8U57nj1YF1E4zhAxWWqQciig1hI7UXFUtCCpsfGR371KLc3bJOaIoUq/SlXy8VmnFuac4o3lzTSEeIX01mBvo7KLcdKHFPQYN0Fyj9kfnX1r4MK9uh9BjyYw1IKPrlOXWNfVJ5LkSC5QDwSjmFe+E98Gm9mCXMehZ0lHW/MoAmauyswzm0IJzfqCTOFnac755tFlLjeSVB/VjRNUoBWfD1UYxqpSVDxhI0jCiDAZhXkblj/PPiqPTPVqTHsn6PJHUBBuXJrebzqlxZ6yNA2hEbcF1HnsViE0q3vi7+si4VrDY57O+N/VGf3GZAzNkf5zXO/4OkGqK1iDA7glO5MAGE13eacjW1+SI+EbxB0+TAkl+CgmDQuOrz4C544Nmg/xzS1czT9j6YsgFNhuETb5Ew19CKiu/UvJu8sJYGcA95GlQcIl364U9Z76ujwEQLg8SRIBHl53T0WqWuw3cFNu9hBHkxCiQ/FCn90aprcS3xY8sRm2CTJsKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(40460700003)(44832011)(5660300002)(7416002)(2906002)(36756003)(82310400005)(86362001)(40480700001)(478600001)(7696005)(6666004)(54906003)(16526019)(186003)(2616005)(36860700001)(26005)(1076003)(70206006)(70586007)(82740400003)(83380400001)(316002)(81166007)(41300700001)(356005)(4326008)(6916009)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:27:26.0501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73329d16-f645-46e1-c2df-08db3f583fbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

v9->v10:
 * Add tags
 * Rebase on linux-pm/bleeding-edge as it will apply through this tree

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


base-commit: 0962c5df83b088fad0c531257744fb7a1e83221c
-- 
2.34.1

