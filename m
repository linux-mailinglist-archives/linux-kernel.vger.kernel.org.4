Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E41D62E8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiKQW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQW61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:58:27 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD538BE7;
        Thu, 17 Nov 2022 14:58:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/D5ibYfcstD7fYEsTLJkPgkewGSFG0i9zYgpOu9p2r/g5rl2xUZQYdWiUl//iUzHjvzMSs/OLjpDQgrp6Hgy8cis+AU6hUyKv5CWTTm1rtkeXFHHPdmFGMMwYB3iHyi5r4QvquEcS01Q6movkpBn9jOjDZ94LBSq94+znTel+ZfsdX/M9G7re2I2FEar+iyVcCfrra34CHLkgu/441TjWm4WQPWWwLjcO5LcPCUgL1xJ/sq7nhkPYroS55Wc2iJmdpq/BtRN7KuC+xoHn2xGPx3R/muK2N+8WmTt6dD8x48pCIDJ6CTtlLbmAPntHmu/+zPI5c/X2Bs8Eb46MNL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocLZXIJYcu3CkhHbhC7rN5Jyxs8/Fp6OzDs23ZD1sig=;
 b=TXa9Ny1cEmpTjMwqEYSztGHGJYjd4yGOBWSZ5MqUdM4BtuelvpF9/tPvBu+BvbMvj23hxBkemJvXL7pPKmqjiEeQ9iiR7bgI02Ilt0BGrcSdNjLIigWLVz1wNcb3PSYkQ6fBA9+5Glz9WOo0hPCqo6i2XlPHeuPQg0OP/3cEoJty58FhmWzqlzS1Cg8IBKs8DS9FbGDJtWIkiUBa9gWPse7ZWad6XhEk8uc3oR5Bsn8+1Hj0sEyJEk2dhGe1VQIJrBMVAcOp8TAnAd0yL+hXJZsl+6jhdqaV5UI0kpqhYMz97/XCeBx5CHKc04uqELfArAoop7Xjs9SsEsCvIy9HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocLZXIJYcu3CkhHbhC7rN5Jyxs8/Fp6OzDs23ZD1sig=;
 b=rNnswfGds9k4YraoEa4gZh9kJ2sGQ/dRucYOsC+oew2Y9x6eOfv30rsT/6ve7gY2INlsW3zKk0E92l0JwXUqtromZEcadg/9GtJFLvkqxSLLJ4qgC9r/Vl7neFjbjtW47rVKk8OdQyHtI9LT23lBLoiKhO2Mt36q5K19vVlk1s0=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 22:58:25 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::a5) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 22:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 22:58:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 16:58:22 -0600
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
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC v4 0/5] Report percentage of time in hardware sleep state
Date:   Thu, 17 Nov 2022 16:58:16 -0600
Message-ID: <20221117225822.16154-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|BL0PR12MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e64e8c0-7b95-4086-0e1c-08dac8ef3b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqx6LvRN66ZDWOojZiH4kAVJEk2/pm3wiuMz3VjUz2CJ4aQEl4galIPOOPwPVr7Zb3THU1qAUCtxKIuhS+gR9ierY3rkWsKH0jRGx/OItpTf81g88243x7WiPmlku3MS/oF7xWI7+E5K1qfZjhd9xxPKxFHMLHk58DurXWm4v8V8tD+0ndxbHbI/MDaZhvuo8mwms2W8ztCDRng/uC3qJ3x4kfzNktH5EBfFUFXNJRZamzDBjvpNbGLvfpCnMQV2DhGjMYhd9L1ruxp+V/YblqQ+7SLmOwba1Y/wp6xbtfZ78jbxZ6yYY3tJZziVhrEkF5r6RbZ6pf13COXKDysbiBcRnRYqD8DZrKTr4GdxBGt5AjoWtIM4w9i37wKMKA4BfQTfJnsGiqcAy3cjOtKczxGxRNRoFm1GiSRXvolZbvAwJ+3My2JsudxIin2+DlH+alBUH3pIqyjn3f4KY5ecQpARrsZewLTL+hWAIN93ZQW7ole7uyWqKfOcuFJfRGZFiTN2of3I9ATxIzy22x+RYvDhbNqbohxg5pDWRFG4WSLZbT7By5p5l2RQOQsK+i0yi4t2jXbqZvR6WbRhx/uEW4L/e6t1G5sOc5oDVqCEUmO5QfL2oZ1FALx2tUJwpZeDMbTt1+wBi4k/gKxw3uqphg+gBD+5sXv+zWniA19yifA/0O0334KRR/D84/oWeJjdcHbD0sJiEhiiwhjYvt5UQ1OxARXKb7mtHuNUdHrHlcw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(4326008)(47076005)(7696005)(26005)(44832011)(8676002)(7416002)(1076003)(336012)(8936002)(426003)(5660300002)(316002)(70586007)(2616005)(70206006)(36756003)(41300700001)(356005)(86362001)(81166007)(82310400005)(83380400001)(186003)(82740400003)(40460700003)(478600001)(6666004)(16526019)(54906003)(36860700001)(40480700001)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 22:58:24.2453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e64e8c0-7b95-4086-0e1c-08dac8ef3b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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

One idea suggested in RFC v3 was to report the percentage of time instead
of the raw numbers.  This allows the details to how much time to be reported
to be abstracted by individual drivers instead.

RFC v3->v4:
 * Switch to percentage reporting
 * More changes to Intel drivers to hopefully report this properly.

Mario Limonciello (5):
  PM: Add a sysfs file to represent the percentage of sleep in hardware
    state
  platform/x86/amd: pmc: Report duration of time in deepest hw state
  platform/x86/intel/pmc: core: Drop check_counters
  platform/x86/intel/pmc: core: Always capture counters on suspend
  platform/x86/intel/pmc: core: Report duration of time in HW sleep
    state

 Documentation/ABI/testing/sysfs-power |  9 +++++++
 drivers/platform/x86/amd/pmc.c        |  5 ++--
 drivers/platform/x86/intel/pmc/core.c | 13 +++-------
 drivers/platform/x86/intel/pmc/core.h |  1 -
 include/linux/suspend.h               |  2 ++
 include/linux/timekeeping.h           |  1 +
 kernel/power/main.c                   | 36 +++++++++++++++++++++++++++
 kernel/time/timekeeping.c             | 20 ++++++++++++---
 8 files changed, 70 insertions(+), 17 deletions(-)

-- 
2.34.1

