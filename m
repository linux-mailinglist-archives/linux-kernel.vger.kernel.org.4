Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4F65FB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjAFGPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjAFGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:14:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85A6E0C7;
        Thu,  5 Jan 2023 22:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUq9bCZXnBF5mkaDIhEwksOUpWjE25/tv86UbYhtUvtnE/cPW1y0559jOjeaRQU6jD6/A/1/98f3HkLHgbAyZJvjc1Vii8b5kXooMy4Gr7JzMKBOMDExsusqrGjlbBC+KawPrpzItFuNWnXpCd4eufRA7DmjFRqc1oPWTTKWkrhv5astEmzpnJTf8iFwUoKvI+1JfbKZ0qqV8vkOv+4w4ADHnbLudWai3bo2YoRENcHiw6e2kMM7cNRoJHDUbwvg5tM9/ePwMwUmDDkr4WjPHUDlclxDZb7XpfblyxULGdWHi0KvBwr20EyC4ppN4gdIDk4V5JqXEsFGLdU8ve6epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjwQsbUMI+xjglvPFXwslRKb9ufVIqU23C0O6BQSXZk=;
 b=l0oVHgsbp8SwWGrgc+C7G2PvZDhnwLWMHgFtJ4syLJ8GUQUNnMrY/6+RwsUKVNBPRhrH9zJySii+Zy92BzbpMDMFbGtHoBushaWsAX9ZF7LcsIZrjcOUI0SakXoZqwArcCM4Pjljv+eoOzkP7VWkLJMYhj5X/EFor+U3iHWWe29MrybOcit+en4/UkVMGqfu2+6w26biXFZW1azuhNhBWR2xUOx+IoRy7Um1mb7O/vPniEH9MGSxwm/dq1X4LcAPL0xSCGYYRU3wO3GUTATcyuMKM31daQVHTIsJ5ApFslKCv5iScxWly28gv0U/+axxUG8D+f/E3z4LbooXQHBvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjwQsbUMI+xjglvPFXwslRKb9ufVIqU23C0O6BQSXZk=;
 b=0FvTv/bgHOv+EOc9NJUizFQ1SotmEY4YvE3zKipWgObmDQ2NApwSyoxDjR7MVqNaYLSfNQ6XA3cd4X6uUZ56xja1lTTZodLv9xMNpH0QkaGz7qC6Cw3YRSw4loISK+Ox1b0UMjW2twjbzLbfmd3NZK8NaMvVrOYdP2vSXG+2K+s=
Received: from DM6PR02CA0091.namprd02.prod.outlook.com (2603:10b6:5:1f4::32)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:14:46 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::26) by DM6PR02CA0091.outlook.office365.com
 (2603:10b6:5:1f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:45 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:35 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 02/12] Documentation: amd-pstate: add EPP profiles introduction
Date:   Fri, 6 Jan 2023 14:14:10 +0800
Message-ID: <20230106061420.95715-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a2a547-dfe9-431c-741a-08daefad4ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLKH+Z7vPxKdmXnzGr67f4Xv4177dHavXcG/oVnxLJyVAOxoJ/EssF3Z7+VwS3kukQUAxLaRBFZ/hwTc+Ub94zDyYHe8UR1B8lihgejTWkblsFu/dX6Mf51YYZPDflujDLQBNhSFzSvIdTBbuDsRcGz/08yeWbxBwvF1U6UgDjkIwTq8HGgsTcyHoLW38Oy+HR5iDaTJTKAmyHC8EjeNOO7iAKueMN5FGSdI+jAqSpyNFKGIhjhOJ48uTgJ04Qy21UWR+NOvUsNeJ6JQu1s2pQ3xy/x3b7nCM/FzK6p+ZhGiLXYpWeR9TJikQeKDdehqCL1msxkwYyHIu73j0U4EZjSxr34nfVNETl6Ba77VNqlrX9bia+CpFVJ7AJS+W+3QCawFYWGAiuozz2YlTGSZKUNRjNanQiH1gda8XNPpAMYeR5jQ8cXVhQdE3QirD8KNwUyDeJR2AO8zwaOrTKfIYkzLiEdCmO/kk5EzSv98bAbVsr9j7WNMLN376Pj9HlLgvNJ+hkc1kpkRfW6W/uFyomgfsTThC0W6NYER2CXAfIN40ZB1Qjvukm90xjihBsPrPNu1D7BR1W08s9W92WvrdKUsxUruk0B4S6nv2NTNLT6gmPiLri4/4u0gCme3M6hsZ+7hv2CVMYF/Kl33PZQUcllUyixNiOdE5r8XrQ8MOGEeFKbL0S9sJl20iKTM3Lezf7AsPyu/1EZ6tjgxyITI26P79sWA2HoTgOOcrHvblow=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(2906002)(5660300002)(8936002)(44832011)(41300700001)(47076005)(83380400001)(36860700001)(82740400003)(356005)(86362001)(426003)(70206006)(110136005)(70586007)(40460700003)(54906003)(81166007)(336012)(478600001)(7696005)(6666004)(40480700001)(82310400005)(16526019)(26005)(1076003)(4326008)(186003)(8676002)(2616005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:45.5156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a2a547-dfe9-431c-741a-08daefad4ec2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

The amd-pstate driver supports a feature called energy performance
preference (EPP). Add information to the documentation to explain
how users can interact with the sysfs files for this feature.

1) See all EPP profiles
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
default performance balance_performance balance_power power

2) Check current EPP profile
$ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
performance

3) Set new EPP profile
$ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
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

