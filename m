Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F2668B48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjAMF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjAMF0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:26:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD474631BE;
        Thu, 12 Jan 2023 21:25:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7LrVNrdoyUSVWSM2U0GKevEJjW4N1OLImbJ0b1nxIQmb8npVUjNi3Mb7vaBWhyNF732MuQHeLmz5cEOAokJcz5YigTPX31sTvbFl9THxuqrrAGkIVdWcDPVMfrmpxHNRwnlsJrYForOXd1lDG7e+iV6WeOQjstcPQ23xbaT3DAvT+YM0gWx7k/dMqRMMY+O+YfkvO/OFWsCZJFlKnnzxUL5B0ZLX6E5X3vfkyaofu5tvkr+uTO3Z4u7zQQm3JkYkL9bIgZ7kZW/6Wyey2Xm7yjY7vPwk8Iu6yHasclXzhtrUb/usQLW1hZuX2WqVupEp5yTWgiN7B+demTX5WnlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9erekdQ/mftikoOpNdo+ex6T2H+4bLNpiJgAumRNs2s=;
 b=X4O21ij7mcCGSWeyLclj6wNqjct+2OSh2lm8KRlk+J2TDy0LA2ZdLuToEtkRqq2w45LJ2aHUg4W7gHxGNdWk9GkEC76rTzEAqsbERoXdXNif6EPwWkZXKgGJoQ0pv1nLWDL2GhL8caoQ/0hFCz7gyTFIHS74eEqJLHzXIO5R+K6WGtf85A03iM2vL2v3JP3n4kj55Bf6GrMyUHM5Q3EGvWZM/34Qp2JecH97Zpsn2i1QfjyIlrDb5OVmmpPiZEC5C0w1SMElGMbbG5vR8W9BupxUZlY2uhbx/FukCfmuinw9T1WMaoWvyZzUcQP7ITly6NKHPpvGwk9fgsBCin4UXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9erekdQ/mftikoOpNdo+ex6T2H+4bLNpiJgAumRNs2s=;
 b=QgmBo4p+0EC4gD9DJX/9FNjCfs/8+iHWMGtwnQBdc/tmDxSie0ZEcVaROAldg+GPdoq1TpIxVmJDpXPKb2sOJ5oai1E56IMl9Rn96pOT+8SCtzOPw11Kef7gzF2LqsSkaO+pWJ43FmE107k+lMxjYuzul8xdahcZphA4y6r59ns=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 05:25:19 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::3a) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 05:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:25:18 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:25:13 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 6/6] Documentation: amd_pstate: Update amd_pstate status sysfs for guided
Date:   Fri, 13 Jan 2023 05:21:41 +0000
Message-ID: <20230113052141.2874296-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113052141.2874296-1-wyes.karny@amd.com>
References: <20230113052141.2874296-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e31e33-4492-4387-7543-08daf5268f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0zipcBx9K2nb0ivuhMEhYlXRalMLTraQ3DmJEk0JbOMcZYP63gCF9PymManqpk1htxzM4blj0ftX4v2UNGxn3+nDEYm4g6mRl8yIOgIliqQh2mUlvrtUo03KWaTH2hn1gLwi63oWzQ+bbu30cP0eVkJCMi2ebbpjXhNpWiJ5DT0m7xH+wqjh2CB6iHy2N7ZPqlAfbG9QKztjs0g5LfwV3n0jggkfAai4NkJxJvH1pf4MgaMG/d7/Gd5Y2RH/pwZ1xcGvlBCQCuF9tmzfwlMfYzEifZVfbhyzJb9ECSJAdAtGRuFwZX4idGOmrd9uhk4v48s/isV+kJ6dXUQ3fCiyvR26yftwcr9S3gYfOdQYAjyvPKJs1vtMGee1NoSOJTx3QklyICKA6rEnVD9fqCGw468XDeXvxt5qj0r7O4QSkf/+p5spdXQOJ3x0FbPDP9WK/JWhCBsxcHZc5DsAaAooubHM6q9dMEX3Z6AA2UL7mPqP9CiJqDOdqTRBHulZXfaroKyjztwrSL+zsRlYVDTsEY/CIN9o/suvhjJLKFUOkvVtvB04Ecd+9uHkVPutrdLBNIZpE2BUUxwTv0Dpbalpp8etqJxlCVbcNM2hNo6EhmCqP39fvAnpoqpOLnppIquz7VDzjvjd+uKrcKAPrJbTONB4jYV3f//DixQyXJxQmODaa/9zjGOWDd7VBbklPV1+CXam+C3jjHVxC0dJT6nG8KUzboegY97TLNYIjrS9wo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(8676002)(70586007)(70206006)(4326008)(316002)(7696005)(356005)(81166007)(110136005)(54906003)(36860700001)(44832011)(15650500001)(426003)(47076005)(186003)(2906002)(5660300002)(6636002)(8936002)(41300700001)(40460700003)(478600001)(40480700001)(83380400001)(86362001)(6666004)(336012)(26005)(82740400003)(16526019)(1076003)(2616005)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:25:18.4593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e31e33-4492-4387-7543-08daf5268f23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 29 ++++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 55396981266a..92fa22e45a2b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -303,13 +303,16 @@ efficiency frequency management method on AMD processors.
 AMD Pstate Driver Operation Modes
 =================================
 
-``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
-CPPC non-autonomous(passive) mode.
-active mode and passive mode can be chosen by different kernel parameters.
-When in Autonomous mode, CPPC ignores requests done in the Desired Performance
-Target register and takes into account only the values set to the Minimum requested
-performance, Maximum requested performance, and Energy Performance Preference
-registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode, guided
+autonomous (guided) mode and non-autonomous (passive) mode.
+Active/passive/guided mode can be chosen by different kernel parameters. In
+autonomous mode, platform ignores the desired performance level request and
+takes into account only the values set to the Minimum requested performance,
+Maximum requested performance and Energy Performance Preference registers. In
+non-autonomous mode, platform gets desired performance level from OS directly
+through Desired Performance Register. In guided-autonomous mode, platform sets
+operating performance level autonomously according to the current workload and
+within the limits set by OS through min and max performance registers.
 
 Active Mode
 ------------
@@ -338,6 +341,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
 processor must provide at least nominal performance requested and go higher if current
 operating conditions allow.
 
+Guided Mode
+-----------
+
+``amd_pstate=guided``
+
+If ``amd_pstate=guided`` is passed to kernel command line option then this mode
+is activated.  In this mode, driver requests minimum and maximum performance
+level and the platform autonomously selects a performance level in this range
+and appropriate to the current workload.
 
 User Space Interface in ``sysfs``
 =================================
@@ -358,6 +370,9 @@ control its functionality at the system level.  They are located in the
 	"passive"
 		The driver is functional and in the ``passive mode``
 
+        "guided"
+                The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
-- 
2.34.1

