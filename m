Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E970C6D5352
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjDCVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjDCVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B63A90;
        Mon,  3 Apr 2023 14:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esit964yQXs6frSyVkjYg1TDFEuA2ZiWvBCFZ2Ox5YSSqKETZqNrF6xj1FB/pKY8H/iMBOuAzfexHYxrPORdsN7AP/uspPJGkNJ7CNuOVrJVqiTEOjDw9b2Xuke1EotQWo/8QBxV9AQse9Lz3rm9wOY3yAYeRVGIPagi7eQmon8KZwtTxsCMLFgF/9Ost2o7kj8wRBw2prBxgXL3l6GntNqzXLApsBBH4m+g4aZEfcR4aWDimOZxBzoCrgZyoYrhrPGrrQc88Doq+RbjNyVjqzWw5dB3LmVLzy/zIdLA/ArREfkEQN4MTZeC5ty3qHC3ZxQmD5v1BnWZjRjLFnXn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zre6zoz6VCEDHhbHVqJULs1y/YQC8GblVynIwh06wlE=;
 b=fyFOllEwaEgSo8sic0QNRl/d0wHch7Z0jO3dQxEW6pH5Sl2dAcY0xww5lb66lg6vdLw5CbfblaSsOFifIBKktc33sPJ6KZ6vI6Zk8COsPF1GRU6kX8k7bavcvaK75+8pJRMeAuQZg3UZge18ml68U9oLtEUFUWZU74kaBGwjtx0/poHGth6+nA/uFWoJP17QCN17X1tm3sJYBMYE842bpgb+eIb8Ni2f/4egLwcVZmVOXQaHrbXCKnjn4xeQCf8yazR+QbpYFvsylR/dbnURn4QNRbm3S0QyA1bEIJv9Z5fmUdZfJMghfKtm7YXQnW1kPsJUrxt/d/KHp0+CmQkNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zre6zoz6VCEDHhbHVqJULs1y/YQC8GblVynIwh06wlE=;
 b=NEHzBA9T8RuQIk8O9cqvi28L7d5Jcc+gdJlpHsObtzIvAgzLwj1pc6wpeiCGEcVqEsy9rrmbv45fnXjoY6UZRBOp0z68mOk1Dt+SA2PL9fUZJ6tf6sCmggNbQHnRkhuiBu2Lp7g01ByzGfUSHDtnWa2y6SwxCXSIYc4uDAQZHKg=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 21:18:47 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::49) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 21:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 21:18:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 16:18:45 -0500
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
Subject: [PATCH v6 0/4] Add vendor agnostic mechanism to report hardware sleep
Date:   Mon, 3 Apr 2023 16:18:26 -0500
Message-ID: <20230403211831.4010-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc06b5f-7f09-4f12-46a9-08db34890314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7HpRJ6wVpJN3eDdB3HXSxh8iyfexXVIu6wyyRdLyoGthGt7noalWOP+aP6xq9/IJQZMvcs9nuf/vnYGDmq1ibzYFTLXW+97GPWHfcPBK+MKVUtMypBHptBhnh6b08AFCreVeMZ1d2Rz4d83oGvyUlWKf2JCpTtmVwkMqIC5GqAmS0AqeB6M+Hb9cB4vK/roF5EopI0VmJoyFfaaFQxBqVRp+JRvMwieY+OeX4t+Alah7mFjsCQcwlj54P2EeuYTohw1g4wV/bL1bOlDbuM67w4afEhlAPJVb0NGM8tBRd4Khr3D0pvm6MU4jJSyup2txrbPJtZEXT8d5aURzyzEPzqdhkIwLmsJcyuf6iyJFbdcyJswdTOHnneMfW3Y1OIO36/skHhQOmSgexZHMQPKhS041aj5Rt7G4kug6YswtPT6zvAR5F1DMUbkUvmyDuRBmhlrPFVxeXWM9Ywqr1P9KFESfiH1PXF2E8HYDMiG0au+xQJzb9H0KUVKnVDjGry21NbgNr+5M8deLDWjl6nJhYTIJPrQhMkd3U35juhCkQl+zC3h9NU40SJp6MfQuohvWPimfnFsUn8QgcjGozLEDBgZOa7Zp6dkTqbTQfDILPjsVUBf66mV/lnLsz01MXig8025pnNKWd7jsZAliaxEKWTHKjPB35kD52dKAjbqMxaXzSQfFBQVrse85CkqFSm0CgpZWzKp09Gc89dUKFZQnDQi74T0o65M8oJduKvN1rI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(86362001)(82310400005)(2906002)(36756003)(40480700001)(47076005)(7696005)(336012)(426003)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(4326008)(8676002)(478600001)(70206006)(36860700001)(70586007)(40460700003)(82740400003)(81166007)(356005)(41300700001)(44832011)(5660300002)(7416002)(316002)(54906003)(110136005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:18:46.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc06b5f-7f09-4f12-46a9-08db34890314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

v5->v6
 * Add sysfs file for total
 * In cases we know overflow return -EOVERFLOW
 * Update documentation
 * Rename symbol
 * Fix kernel robot reported missing stub
Mario Limonciello (4):
  PM: Add sysfs files to represent time spent in hardware sleep state
  platform/x86/amd: pmc: Report duration of time in hw sleep state
  platform/x86/intel/pmc: core: Always capture counters on suspend
  platform/x86/intel/pmc: core: Report duration of time in HW sleep
    state

 Documentation/ABI/testing/sysfs-power | 27 ++++++++++++++++
 drivers/platform/x86/amd/pmc.c        |  5 ++-
 drivers/platform/x86/intel/pmc/core.c | 18 ++++++-----
 drivers/platform/x86/intel/pmc/core.h |  2 --
 include/linux/suspend.h               |  5 +++
 kernel/power/main.c                   | 45 +++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 13 deletions(-)

-- 
2.34.1

