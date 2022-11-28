Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700463AE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiK1RJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiK1RJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:09:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5C27935;
        Mon, 28 Nov 2022 09:08:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2iSM+9ZXf2hq/389Jaks51ihG9HQSySiGkP1BZlKr2ES566PeByqvprxVxpGYJ6Ha6TFyLeiWAytB7ToTD8yX0Thbjdk4e28SV0s8j33Atx6ySfUKMScF/CBb0OtnEcFnudzHhSv4CBDAfJm9NamHTZ3CIOZjzwjpyBUQCeENLemJWIWXx4zYITs+VjXhYz63q9VOyoP4F035SFv4XoFdcpoEYGBv9fdJQRnsh+ZTfpWMQoL2Lwe4UpDzs7aG8DrpUPVdqz+3LnW9vqgPX/RbCh4vSxICOr9jBm/XAMpeVVvJD+fCnLtSjagh13ngFyCcBAvYvzRrOxl+rsvieTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=dVYzDYnWk/i0lUMNOvqzQ9ILDS7c4rXMB0Og2WYIUAfUOiTCYWrS8PC9pN4i5Gk50frZQ4W+mE+dqYgF2ICQjwdhFi/MhRYRpDdfoZA1MqqZhVoqjcl4x+Y6Jtun0eGKaBKKXVdccB1gpMAz/e8v+Er5Wuvc0I6jjY1FDnZJlYC17KsvCCNkJDbhznn6Vqbq3QHlj9lV6zYQy8hkqOP6nLQofHGQP+lcoJRcOrMvB9v2kHRZHo6slA1E4io1roB+jnJdj2uXtfXv7+qFtjBKOv/Q0GgrujsrhwQXL3/4n5imj5697E248Gyzji0PM/iH5sF3PDBBNvB6ug8AB1xfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iLNwCDA2FPuXX0XbspH2ZQmIiCfHs2C+UB1BWc0KDM=;
 b=jN66xxNJLjdPGhvEy0Wz0Hzw3rUP6ic2YcKknOMS6CCUVSZkXFPr51KDEyZSEIvq6Lv39Esgdu/WoK8UlLQ9LT2Z4+YPuXw9/gOQCjXPOZkEsllr0vDG9por7J5ZjWe8nkyFuXr4N3sdNqkQk0/delksIvpUrmiA5RdtHm/1TWc=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 17:08:57 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::ae) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Mon, 28 Nov 2022 17:08:57 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:53 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 8/9] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Tue, 29 Nov 2022 01:03:13 +0800
Message-ID: <20221128170314.2276636-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
References: <20221128170314.2276636-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|PH0PR12MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f6ba08-b338-4ee3-9520-08dad1633c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLv8DB4Wdr07kYRLZFX2TbyR5Tq/5++ikbDMBvKEHdXKTzBhSsjzgHl0rzpDSKrQ+RioCXA0G0/nmh8O816GE1uAAKbwK7xwtpsrBQX7ywQ1hR1WH0MdWtUIWM0uIOPYrUK6IDXiEd39qA0mGH07Tx2G9q11TLi9+sWNfLxGQKTxNdVTe1I8iWDt9v8AI/bzlWgvpEdJQoIXbwFGFoKksYykwmkHlFdQWV1aKnc44WJ93H+j14ZTuertBODEL0riGR0VbFeyOxrfCo0F1P9FgGx1GxgGZjm4Mtexu2U9n7FKTRGqQqxl9+7ZFDAyRNNKustIAyKOG3XxhfB+nvn/UyAVB3ZDjZWnqkql5Jv0gr8cplzL9VgRXSYkIAqNci04MCkdLFkD/BfCn4MGkqaRb1QhfYqo//3INhNuy4/NoT4MqL4q607Sq6eyMF0H4EcZaRykfR5T2lfKl6AAQwL7IF/BdctEtPSgH8IC6QSY43g7vUkfw5z5t4Wh5ZM6x92nw8GSpXcN6g2EP3Qhpxq2EVjlo6l6oiB9rfBdAX/gckeMB+uP+2WUicVSQcWTmPGi2FYWpLVwF1DNOfQJpwAMweAHCXeatNwmaDizfWDUJVpVpWr/U3vlfeusaayVV5Lv6hvCDfKHjl7p0vDYHR8HCtQQ/5g6IaDnFewDSEe9wiNG2M9khyQIsqWmXiv9eqKpHiCfoTn4colEXSdk2cHhH78DCu++4+Qj3+VS9Hy7XKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(70586007)(70206006)(8936002)(36756003)(8676002)(44832011)(41300700001)(5660300002)(4326008)(86362001)(36860700001)(82310400005)(26005)(7696005)(6666004)(83380400001)(336012)(186003)(54906003)(47076005)(16526019)(1076003)(2616005)(426003)(110136005)(81166007)(316002)(40480700001)(40460700003)(478600001)(82740400003)(356005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:08:57.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f6ba08-b338-4ee3-9520-08dad1633c79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce ``amd-pstate`` CPPC has two operation modes:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be chosen by different kernel parameters.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 26 +++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 33ab8ec8fc2f..62744dae3c5f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -299,8 +299,30 @@ module which supports the new AMD P-States mechanism on most of the future AMD
 platforms. The AMD P-States mechanism is the more performance and energy
 efficiency frequency management method on AMD processors.
 
-Kernel Module Options for ``amd-pstate``
-=========================================
+
+AMD Pstate Driver Operation Modes
+=================================
+
+``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
+CPPC non-autonomous(passive) mode.
+active mode and passive mode can be chosen by different kernel parameters.
+When in Autonomous mode, CPPC ignores requests done in the Desired Performance
+Target register and takes into account only the values set to the Minimum requested
+performance, Maximum requested performance, and Energy Performance Preference
+registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+
+Active Mode
+------------
+
+``amd_pstate=active``
+
+This is the low-level firmware control mode which is implemented by ``amd_pstate_epp``
+driver with ``amd_pstate=active`` passed to the kernel in the command line.
+In this mode, ``amd_pstate_epp`` driver provides a hint to the hardware if software
+wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
+then CPPC power algorithm will calculate the runtime workload and adjust the realtime
+cores frequency according to the power supply and thermal, core voltage and some other
+hardware conditions.
 
 Passive Mode
 ------------
-- 
2.34.1

