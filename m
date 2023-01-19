Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8A673783
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjASLy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjASLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:54:20 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBABE4B4B9;
        Thu, 19 Jan 2023 03:54:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG5ikeyxmo3AB+/6/MRoSKy31P4KE6pF2OjxlUCRkmKWxdxc865vUcXbHw7dhI4x+ZrCfMRJcGDGr7fzvwDxOEpg4BjMrBB5wYUzrjJo9ILfZwF5KGh7LTyO6NYhMnxpuYrRxOxAcqebXmblj4UCipYJTvmMSx4xVMzx6SDMp2oNW6yLaSrjoOXXD9W45v1LdkSbbdrt1Nq4M3X1iBTNl99l0QATmLFNZcVUaYuxjSsRt16adyRTH8Z/EfVwUQPELuPOa2gcJgwhAzo6aPYvohGLePY5N46B+c82YM14DYCM7CB5Rs09D6cpbjlIxQOmqcGo1i2CQOLyFfl5qrR3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2+bi/RLp60NJfFTa706oIDyFewKZo3lNCtGPoDlh+w=;
 b=eKjKHj5KCt4CuZTB+pqOIWZjeaQQuJxy0gYt3fmvQ7iXDXwRpSEkafZ0Vyu/RjxX/I+Uv2FpPqBY/VHvZk0H8yq4/qx9vwkO34F31XCaX866ljnjQ1MjbprPebC2VAETgu8+XGUTom+hVfqTbnJjdKH3QLQxvEYkXpTNFcsgkAL15XXMv6H5qgbbjtw6XK/FVTZ79AekaaQcgG05tYClWhIzJCkaAUeQRhxzrpSFW0eq5lou/MWVuwH+J01S8+EQNKR7g+ESxHqnfombY1EhW4wwu7vNGQMFonPe/o8fbCBDPugF7gKag2n8N22tyXBUX9hXsrIZS3DDatfNoTGg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2+bi/RLp60NJfFTa706oIDyFewKZo3lNCtGPoDlh+w=;
 b=ARfAczN+1d3iBfOCbV3HguCSKQgSKeyZH1YWZp2G0nVHKJ0qkVMb07438o7GneN+uvgnhLgVlGK6M5NRAoeDp0HvFrEN4yZIPT7lOKYhEPy/Orpvcxo4ic6UVoALe1I2DVjGmpCbrQh+LSIv0677IW+wTefhhbfP4CHRnsASNV0=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Thu, 19 Jan
 2023 11:54:15 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::d) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24 via Frontend
 Transport; Thu, 19 Jan 2023 11:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 11:54:15 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:54:10 -0600
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
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 6/6] Documentation: amd_pstate: Update amd_pstate status sysfs for guided
Date:   Thu, 19 Jan 2023 11:50:17 +0000
Message-ID: <20230119115017.10188-7-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119115017.10188-1-wyes.karny@amd.com>
References: <20230119115017.10188-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6677d9-5564-4482-3b7d-08dafa13e375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zM8F1K9DEwFvsWTRevyzEg3azDcSXouNxW3bnjXsBirbOhPXUaqC6N5TvBjjVqUA7Vc9ivOUcrvWAJ2kwRuzDNI9NzLsT5cOGWKmRZbCIdBQEoU2mgAFbbGPDGIhZZa0JKyY8LNX/nc1FlvSfbSy0Y7RVsHUJGTjwbPMgbfhekpUYhwzoEwpRYS3aecULBnOGB7LDncesESSFxOHL75LUksgq6b7eGb6W+qZR0225lBgSNn+f2+cLd9Nvkpxst71uRYyr2yEo+ZcONV99LLpw5PeKdXUy2kYk4j1u+u1ZX127bscuexBn64Gz/h4WcvwBt5rw6d5RZn7t3XU2Um1VjCD41VPcqKs5Nj0xADZ3oA7F8QNaMWj8ZTZZNZdmNT2IcVmx5z4mgeYL1auMgQ6eNGbid1k24MieUG37UvWx/rpf1WRn4ZGS1Emx1vDOvisJYUmoTWBAxR6v0iJ6xzd10x+c+TkBfdJx1icNdzp7NeowybL08GdrippPDwb8MbS9+C0J4dU3iJpPV6HN4jqE0KllCtljd5HkUPqxl08rAVonGzCuYAbsZcwI7YpOBEZG2fjSeF3Fv8L0FMfH5wZ9bXebB0wOnx77R9tqFJYPHU4cRFW+ea1wpV4aEXQGtsUKfM+XBLoQWRsJOeEHLzCQCqZ8+2pFNLYrbE6xoy0827MShpKojn2RvCv2khxJ4ibqMGIFWbfKUpRsOsv07u6Pc+Hh0GETKhtPCEL87MqlqE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(7696005)(16526019)(2906002)(110136005)(186003)(1076003)(54906003)(2616005)(26005)(6636002)(316002)(41300700001)(426003)(83380400001)(15650500001)(82740400003)(36860700001)(336012)(8936002)(82310400005)(8676002)(36756003)(4326008)(40480700001)(70206006)(5660300002)(478600001)(86362001)(7416002)(47076005)(81166007)(44832011)(70586007)(40460700003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:54:15.2998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6677d9-5564-4482-3b7d-08dafa13e375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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
 Documentation/admin-guide/pm/amd-pstate.rst | 32 ++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5304adf2fc2f..d85a141109e5 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -303,13 +303,19 @@ efficiency frequency management method on AMD processors.
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
+  and takes into account only the values set to the Minimum requested
+  performance, Maximum requested performance and Energy Performance Preference
+  registers.
+- In non-autonomous mode, platform gets desired performance level
+  from OS directly through Desired Performance Register.
+- In guided-autonomous mode, platform sets operating performance level
+  autonomously according to the current workload and within the limits set by
+  OS through min and max performance registers.
 
 Active Mode
 ------------
@@ -338,6 +344,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
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
@@ -358,6 +373,9 @@ control its functionality at the system level.  They are located in the
 	"passive"
 		The driver is functional and in the ``passive mode``
 
+        "guided"
+                The driver is functional and in the ``guided mode``
+
 	"disable"
 		The driver is unregistered and not functional now.
 
-- 
2.34.1

