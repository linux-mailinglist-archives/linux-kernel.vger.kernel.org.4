Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B00686035
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBAHEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjBAHDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:03:55 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB343402C;
        Tue, 31 Jan 2023 23:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfl0x402Cr18ChPko+xDFsUMXE0HtedtfaPdu9iV5kVicGhaD7yMo/6+CwqPsTOeIbT47d2IRboRPsKK+5e5b/bAr945kiRQm/Zs9wSVujQ4h0BsEM+7O/0CBSGuyHQ65W5tw1XbHvtUtM1agniYeGHLO+5EEkdIi5WubkJTMptRD5iql9KXtwmNde421np6pjerL46mHNy0eIR6QwOwF/vgxWTRmYuNP+QYKZoa1/r+e3q8reWpZ4nnZl8x+jB0pkup+CLllqDTqvBz+imDaFhK1smSieDlk8Wqu/Nl6z8UKI4ySK8tgi3jAyYKPTsawIdQGmwv6RkkOr9uPh3zNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n0RpfNBZd6GB8zi6rx8maW2j8088D2LzBQWffsVsrM=;
 b=LT+Fah+I4t5dezmOO3K/iZDNMpiq8xiSe7CNYfsfRTg6KX30LwMXyrR2/4NidRdLq5hrR7/w4Xt4JHqzvcPLiwZKFAvRJnZ+KWJbMrCCMpjZaPrXzl99GLYLSybaI8TEW9Yy9wgY2iG9sMh1wcaU+njv/V5vC0s0Q6jebdA3WjBJj6ZZv26KviXCAdlkmpljz22Akxb9Ovf7Xi5zoJimna2JboD6imVPWLMZpE9e3o1ic7L4qahQoWqk/N0+h+gRO47cLnKPQVMhuRWOrCxv04/XeuFsxxr9xDKznhU47rfm36ruZURXqkmVCS5aOOcf1hRdgRBAZnTzbNWo6vgKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n0RpfNBZd6GB8zi6rx8maW2j8088D2LzBQWffsVsrM=;
 b=lvEEiUCX4Hm0MsRUY0Jv5WdvuJ9+7u+tT6h9bwSm0JHbwoPiqYCr4cwVEWsAfWI5flBltinkMg1ZX5O5JPNLxTUwsJN50eB9VSK8OJXWo0a9vvIv7BH5IGtjBAj+fsWkJtVdeDps7X2mMfvu2+z4gFS10tRQEnVcApJeFXhfZs8=
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 07:02:56 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::8c) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.24 via Frontend Transport; Wed, 1 Feb 2023 07:02:55 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 01:02:50 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 6/6] Documentation: amd_pstate: Update amd_pstate status sysfs for guided
Date:   Wed, 1 Feb 2023 06:58:23 +0000
Message-ID: <20230201065823.189828-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201065823.189828-1-wyes.karny@amd.com>
References: <20230201065823.189828-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: fb48b480-35bf-4177-1d04-08db0422585a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/y9/ewF6g2ESQmcxRXNjCgudOUmhaxGVChGkK+Xx1rhCL9sD4UbSFAmql/X3GaZqCZReabLPeQlM+DxYxomBs7+eEEoLAnHDpeglwpgctoxffHbWUjgmdaWNgLLfhfF6N3Ra++uP0OW9BZ9YoeQe9xVhu8PM8JcTzC5DKFRJz6vz5wpnkC0po3bQL0K/dAL63+rn7J5D9AGixPL0U8MtpaBnhb6LwW+1gtbAnGp/NutldyncwZOl1I8wjBjMwOjpCzhzdvblvzs/1Vg1C0fIQ3dpW5WK3kv7b/GVbyULcg49rLkmXAS3bXMUtuJZmUvdjSPSdu6CpmNSYEZdgzsStCk2m1whAJZDzWrVpvYONt9CGve/2N1xjyj6M87MQEFAKjynXKx+mvTqTlpUsfOUy/bCtLvYZn7kJ6D/VEK0X6VXJOnFMLwPK8hfYe9tpg2aScxkpMNPPRhL/sNd/JhPSBtEgO0Aa/WuOSkTlKKg9im+0TvvW3UvtT/JG/QM/yCzrv/4A4hnf2VMbR4/WWo9Bu2XlFCIs6tjp7VpKqa5tQvpoDo9rHBiIfld1JIimbZa6MUnXA0c33+ZHVJLVlL+7c1pixnZ68Uj1nbUW0odr9vC4AjgYdHuctZowDcu3CuO345hg5IMNap7L4riR9uEElBfD1kh5RV1OkK+GrAJS52FmhgaFOR6rarRiCRgtxjmvozIwos0K5YTgwjHB3pdw3qWHKdxsc+skXaL7PtLsc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(2906002)(8936002)(15650500001)(8676002)(4326008)(44832011)(336012)(478600001)(36756003)(6666004)(426003)(186003)(40460700003)(5660300002)(16526019)(7696005)(47076005)(26005)(2616005)(7416002)(1076003)(40480700001)(86362001)(82310400005)(41300700001)(356005)(83380400001)(70586007)(70206006)(82740400003)(316002)(36860700001)(81166007)(54906003)(6636002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:02:55.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb48b480-35bf-4177-1d04-08db0422585a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amd_pstate status sysfs for guided mode.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 34 ++++++++++++++++-----
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5304adf2fc2f..17fafe5d6625 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
 AMD Pstate Driver Operation Modes
 =================================
 
-``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
-CPPC non-autonomous(passive) mode.
-active mode and passive mode can be chosen by different kernel parameters.
-When in Autonomous mode, CPPC ignores requests done in the Desired Performance
-Target register and takes into account only the values set to the Minimum requested
-performance, Maximum requested performance, and Energy Performance Preference
-registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
+non-autonomous (passive) mode and guided autonomous (guided) mode.
+Active/passive/guided mode can be chosen by different kernel parameters.
+
+- In autonomous mode, platform ignores the desired performance level request
+  and takes into account only the values set to the minimum, maximum and energy
+  performance preference registers.
+- In non-autonomous mode, platform gets desired performance level
+  from OS directly through Desired Performance Register.
+- In guided-autonomous mode, platform sets operating performance level
+  autonomously according to the current workload and within the limits set by
+  OS through min and max performance registers.
 
 Active Mode
 ------------
@@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
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
@@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
 	"passive"
 		The driver is functional and in the ``passive mode``
 
+	"guided"
+		The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
@@ -368,6 +385,9 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+Note: If someone tries to change the state to same state, which is currently
+active in the driver, then this will return -EBUSY error.
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

