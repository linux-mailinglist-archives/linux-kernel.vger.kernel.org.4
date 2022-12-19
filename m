Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A336507AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiLSGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiLSGlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:41:16 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5458267E;
        Sun, 18 Dec 2022 22:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGmE7UMg2OXVmM/xSssEcBMD9QflkCTKp35g/LMieICbxsAxZ9G0TImjmBznOnRGMJhm3MdtRdx8rs833RYT+JwM9MFr0Q0ACu/ApMRN2SItbTY1Tbt/IO7aM2wL+LFPTg3zu7hL3WDQEL9Q99Pjv/Ep0ESYdSE33eigS+0gpeTjcoNEYxGpxTFvho4cknlMW60G7Q8RuLg9ORI34SPolVJuJmw3rfhqcyvQs1YF2UM4iKBfZBeag+i+M5apbkYsDN2EB9AypSD97zhWsOti2Su2wYHNMR4GR4c8s8jqI2jT5S4Bjlkc++igShAmhtDE6f/7K6na4D/nexs+BWrT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=A1Znrw+T0zaasJi9+oS8HkHYQmlaexZQOpdQZH/17iaF8Kpy9VYx4ubDfkDALJjbdlhDcPyFAsLq0keypJI1kdxykCPxzOMsK+a7hL5yYw/m5btoNlFZdhyM0KrKxyiQQAREqFXMWiAvqwfb+T6AY2uGdQV78wFJlKLFWds4IYCDAX9tdcPUqnPv1+EFbjK+wi33a0n8726jBJS1KYEMlu2oyxNveNL5WX8kd9Lb5NpdfBZE0s87KfrI5P4Cnkj3Z3s8W5VHLmCS0QPu0q+5PVL6A0+wxixsnb/RCxcv2aH+FqsOYmltyjz1KOfzEoKNJwtzZ/dwgSJAco9rMJGHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=GP9lxtsZTF0e9Jc9vlsSScDs//OH2KX8zSauS3WCRgu1X/dTnatOlxr2/QZTzWXxnyDNXyinAFXDZg+YYVtCUE/2JNI4jF9vde2jXihzQ3EKcgzoSOYjHkGV4tLXkzcFzghAMp9KKnAn63QRN7XatnUvgoWYGrItTmWfuW09Qn8=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Mon, 19 Dec
 2022 06:41:12 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::5c) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:11 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:06 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 02/13] Documentation: amd-pstate: add EPP profiles introduction
Date:   Mon, 19 Dec 2022 14:40:31 +0800
Message-ID: <20221219064042.661122-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: fe681a5d-5763-4885-bd1c-08dae18c0499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INonliDLMgbDtdthLwvn4Df/ItlWVo2ZqjHfPAoVdkyf/WcmVhmiDuGWAABbs6PK6MZinMufCzt4glPTD51sAxYPcM9eRdXmIe9efOcQ+F6hFOGHUhKkgqwhna1tLNx4PbOza2fbFTyqk1KinKF2HwIKkXor44iNluz9fp5o0LVy3/rW1GvkaOXe9Atil4yEl8ECdvTfcmL8rnswxhubYFHtkcrsvmxAzkFHQVSjg0+5seLwE61GA25HH13zNg0EgBM9R2xVVdC70rwA7zd9nY1ZTcnshfbpX2UmIt2F1rV/TCuwOvmuQEUK+mIZEr/+ne3AJa6iXAsMv9Hqj40CDLoXDjiOeJfG5HNbdyICo4lu/piPid8pYIzL0+ccvN/Hm99ku6gN/2Yk06Ytzx2KfRFkZU4s+2pKq02kHAYVQG9I9ntWUJdtD4JUyw2m3+ojpempUafNzxuEGXyeE8PJWJFnexPGyq1iOABRn4uAujIU/e3Fd1Bn1I3NECbSUHoXx8W+kqUSYzOCD4EloIUgyqgox19qO+KX35+P0baWOfPGMserLTUZWSqW/zZv4PDlnKo5y0Es2G6CBDKcWJ2dcuX8qHrObipyrLXVIzqJMT1wCS9fxDpcZF4E7egIy7dtodscH13anRE2zIx5Q38wbYa/AIOoeyWrlbm/2KHgyS5/Xf1ZI66kC0fKYHe9wqesTn9XguETg6xwOscQem7lyJH5nmubbcCYlzhwFY082ho=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(356005)(36756003)(83380400001)(426003)(336012)(47076005)(1076003)(36860700001)(16526019)(26005)(6666004)(81166007)(186003)(8676002)(478600001)(7696005)(54906003)(110136005)(316002)(2616005)(70586007)(70206006)(4326008)(41300700001)(8936002)(2906002)(82310400005)(44832011)(82740400003)(5660300002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:11.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe681a5d-5763-4885-bd1c-08dae18c0499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
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

