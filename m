Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1063AE79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiK1RIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiK1RHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:07:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C289FE51;
        Mon, 28 Nov 2022 09:07:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObJyHTUdCYLIaRwCFQpYM87eyaUsrTl7ib4cbdw3XZnvAnyISC14jJzDgmwq3NEaZ4cKICUKoWmbOJCj+y2U/VrYzndUEbQSNMGgySCodd792VqLiPQpcmURwdsYYsPxOCl+oIXEOWMD2oj+jCtTCxNEIYCwPet2n1PFlAEfGlCAK7S1gi/djHzKFA1rtxCa0+vqzG03M/EjzetNqPN9j4nhWzyZlkWYr7vSAdya8yL3zYj96BV3t7c1repWvjpDcrPOJ6mqEoJEzpDNRGEEUXwjkEOk2XTPotks6JKlyEcNQKHOGH3FwA77H3i1EsD4jQXnnj+A+mV5DOppi63T1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=PXqregeovXbYsc9yRxWITvpSjqg1W6OOdYZARmrzE1rPzg0PNkz/RqicLHVn6iRrxEEfW09Z08KnkOSkPNMcHXW/yMBnaXk4knmtPsu8oYKHr9RFcL0R0fQ3thNXeQ7+3fqFoMAVt8IkVLJ+mpysErQbovHtEbPfjsSF0qCtG05wn9o6grfji17qjTzdzE4Kt6VFnfwY4g0QAMxL1CAeRIoqNeMlrD7NpEI+71VoasnYsEoAThbLD+ky8EITX6Rvi11TFDeuRCNdlY28CDS7kQa/U5snRIdo1TvSOlivpk4w3N2T7zMPn364Owxrlsp/MH3xuXk4pixjyJUynudZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=Mjl2lDwmM7qXBI8bVpBwUUUcxTM8/iB81WMHSiW9XPMipdklibWjzgOfVDzVY5uOJ3BtNOior+51o5vyDSwG3ZWYbD2mVl1v4yRI6v5tvqC6FFnymfab61ozlVT4hSW8m6GhcMeWzDrqBxdgvT0odHfdMxEZmbxVqh//kVzbj8I=
Received: from BN1PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:e0::27)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 17:07:33 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::c) by BN1PR10CA0022.outlook.office365.com
 (2603:10b6:408:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Mon, 28 Nov 2022 17:07:27 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:07:24 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/9] Documentation: amd-pstate: add EPP profiles introduction
Date:   Tue, 29 Nov 2022 01:03:07 +0800
Message-ID: <20221128170314.2276636-3-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 134c772d-3367-4b70-7df5-08dad1630740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gR095yH9LVAVLWQoUC4CHwkqseE8SDkGhzswsT5y8j9BUT25IeOXTZqZDBOlIvn4Bzi6VBqcUT5/IZn7xYq9EnUeVV1PZCwKa5POybRZjiiXriIHWp8SPnGlcPMsauUUGiY6mOaB9IkSHyPY8sAwt6u5tFl2qSI5mDezzS8pWX00HLlUX4G+KZkomQZPh0Tg/8qwmaErwex3rtSxiFMKwxSl6DYlPvfjKWVm3JkCt18eINhDYAHidc8ooYNQwNU2D5WSVzd5kvcuia7+WtSEll62SCRmExCojmG+qPUCkxl9W/8YXXsXAEUirH4TnCOyMHNUZnXODCM4PbmazZKJOV7OruW/EWxU71UpCqyLt6Sv4Ah0cQoZ1K6neCzv4a3DJfCYBojO+4XajPQNWD/Rez9/xSyaXY4NRyN3ggQngxujsuuqypUEUrEn200atJGapaTcQr1qvHiFouhOiO6ndmbsJ9Tt50Nm+EgLhiTT17g6/X3tckLn9Ka1GFS3Xem8acLqRdGHzKWblnZlCRTc48ZlajrSgCFMff8l5sEjG9hIdnZ/YFmwRKM1zdHRtXyqRHGLmbO60zmrcItS+eUrs3ExDTImsu/W/Ovqc9+lJmwvcMfFhrO56MeBmMyRcGc9dOp92/AeannRlL+pTrtc0YZr/L7PRR98gRg1Ww6D24qhukI+Pf5rAzCHR+bEbeNthwRU38kFCHqkSnly/lKVMbYn+3WJjAWnPLaTO0nMdeA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(8936002)(44832011)(5660300002)(36860700001)(110136005)(54906003)(41300700001)(316002)(1076003)(478600001)(83380400001)(40460700003)(36756003)(4326008)(8676002)(70206006)(70586007)(26005)(186003)(47076005)(16526019)(2616005)(426003)(82310400005)(6666004)(336012)(86362001)(7696005)(356005)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:07:27.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 134c772d-3367-4b70-7df5-08dad1630740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442
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

The patch add AMD pstate EPP feature introduction and what EPP
preference supported for AMD processors.

User can get supported list from
energy_performance_available_preferences attribute file, or update
current profile to energy_performance_preference file

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 06e23538f79c..33ab8ec8fc2f 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+A list of all the supported EPP preferences that could be used for
+``energy_performance_preference`` on this system.
+These profiles represent different hints that are provided
+to the low-level firmware about the user's desired energy vs efficiency
+tradeoff.  ``default`` represents the epp value is set by platform
+firmware. This attribute is read-only.
+
+``energy_performance_preference``
+
+The current energy performance preference can be read from this attribute.
+and user can change current preference according to energy or performance needs
+Please get all support profiles list from
+``energy_performance_available_preferences`` attribute, all the profiles are
+integer values defined between 0 to 255 when EPP feature is enabled by platform
+firmware, if EPP feature is disabled, driver will ignore the written value
+This attribute is read-write.
+
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
-- 
2.34.1

