Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1C64013E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiLBHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLBHuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:50:46 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2DDA1C19;
        Thu,  1 Dec 2022 23:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy7XM8SkN4viO2AVys6Gg3N+08XaDNxK2cy03uqwK1wZNKXM8epjX7ezGS4ajUWdVfzTmUoBzynHorQ9hEqt3HtIqIttZTsPRZDwnAUBkSNeKrO+k6IGr09TbaV3y2O2TwkJIxTFNrChwxiMMSAOk7C1Gu7s598QpSmjObLalZgs3fI91F9hcX/xiFUrt/Qrw7naAZ/sKwrBksH7oDmTBgLfx7p9l+z4B+/Qa+Rl/LauwygkyKIlbuOJPESk/EQpJqh8VahX56k5n9P+XQvYCyWx28eGTHmNPkS7vyugpTi/PXCUIOxM3vk7RXYpnfoU3C3xPxJaqQV/fp7scI+ZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=MEs3DhY0atxhkj8G8j9xln/Y31yFZAIMC8gtNv9yICsyBgPSzS3vFJVXNsbpgTbERDMuiRNVzcwm7LBG7hVn9et9+m+btFivdoHPZJDHhEZGyKeF/AbS0+oDWlrCjk5yXhECty54PlQL0cvhcKWJTPeDueg7wIR7mjxYYKxPPLyz2GNbKWNyFs64TniIQLUEU7mj8bkb9MBUVovw6+WRaREMuDKXLGyKMxafoZPXy4b9oteAfrMK5BP51vv0yzr6sNqsN2ei0VCS3QAw4AGITdZrp/RDcpv7lShIMlhFE4QASpY7fz8/Oxiyt8IY6ooo/kxZlKFsnePJOBCTYV+g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lHyokvSSTNMOUXwriwhOhupYBjdKujambfB0vTM8Zk=;
 b=zO85ZZfGY4cpW7XIkWoAOiDjQoDPahFvcUezO7dsP6AVSV8euwlZ6Y6yLjLe+MSfHIfbws7L0pQdA2scUNhXLVfcZRhJYJBkgcfoCOp8zft14Oq7pcmnWFCqySWJ2OjAk9Olqcj8HNeehle1HwTv4sgFJWWBWX9ByXvGABp/Suw=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 07:50:34 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::da) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.10 via Frontend Transport; Fri, 2 Dec 2022 07:50:34 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:50:28 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 02/11] Documentation: amd-pstate: add EPP profiles introduction
Date:   Fri, 2 Dec 2022 15:47:10 +0800
Message-ID: <20221202074719.623673-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM6PR12MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a73cf73-2b3c-4731-9b24-08dad439e525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1lJuE/DxaemZlGl7Jq0QKGAedRxKiOJ/Q3G9eHCucPAVBs6PUT1DtHhxlzivXXm/bkTOI0CNxh8B3YP6fAncOhmZYGvLeyxC9WMxHENu5Ez9anBXrg7cpS+AXNoCKVB8A8bI9WItHHN1OSGsNEuue+uPArOwaNNPlmhSsyuPrpswjtQmR4CyP5vftZG3vYRy98wcPZKU5Kt3oOF3RY6vyPlPu3X11VcYrXcRMbUepW5qPEfVTC+T4Ik4uVw4fdr1CGi8xSJ1iaUjmvO2zpccypQQWP3F7Y7GwaIbJqu6I0NzsJR3oe8HinRz4CIEBbU9M7hm6yIk1TeRYfh4hYiLeaCnqMN3Wu3a1wR5wymqnogZdWK+u6G7itTVSAfJeqhmnDqwtMqVVIcrPIQR5+NraX0/dHm77le1gObYlyX16hVL1GVzI5ZfMlg6FLPMHAvfDDDxxoS7kPUf5egLPS9OLwgbV/t2bybK0lQihPdL1GUAh3JW3KuGSA2GJj0yHv65xcLkYJ3qMPwmL90Kp4P/EwSKeMwFQhw28fbezQNkFKY3NIQr9hpcALBxSFsj/12mySL4KTm+uCMGlBK1PUwNkGDi9X8OS2kWp/PNkV8fwrtUrnuwz3pwfbXswy2fxWJWzPqUmg4dK1ddRlVRErCMDslUhLbE9FUbtEBQUOoFZAOKJh4ZIQfZ+7AGbcGdUHAATWc0o84u+Gjjabj+gQIEkD/82Tya5AOf4a+ngSYVuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(336012)(2616005)(16526019)(1076003)(2906002)(40460700003)(54906003)(316002)(110136005)(81166007)(36756003)(478600001)(356005)(86362001)(40480700001)(7696005)(6666004)(82740400003)(83380400001)(26005)(82310400005)(47076005)(426003)(186003)(44832011)(5660300002)(36860700001)(8936002)(41300700001)(8676002)(70586007)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:50:34.8236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a73cf73-2b3c-4731-9b24-08dad439e525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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

