Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFC5FA1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJJQYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJJQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:24:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAECF754AD;
        Mon, 10 Oct 2022 09:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiV4WYCaZ8CfLo4xyA7rkT4xQGmy0p5Fd0zEj9g76pfr90d9dXS5K1tkGFoCNOvANZZNicJ7D+wDVjAXdXC01xXT23054dlMN0JV4fbjvikTAIG9oBU2rnEnNsuXPxJZ6sxUt11E9KvQRQ24SZ7Tm22eXiF3vux6EV0gz26yB23bE69GLcqLtUcrb8XQQPYRYiXOJFAdVUPRm1dN0esZSoZAdNhN8dcxQe91jnDPegCPMwaQMBx5CqVXEMrGJuqFzSPIUoiDs0sYr1A1ux0ytUBAlEQy/AN6vkeAqYR5jyaDbj+W0QddwxQE2bFaUoydfcq79Gw+9rcyB0HGLsQZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=h2RE0LRvBrd2yguEacAy5YaCD27uS+IRHr3KxKrqBM00IjwTFxwoRIVe495lm5rbK6qni3IA8xB7obYndKlj0sC/GpW2IJXIPm/jSDSoxqVIvE1k6mWvfoqyGlQFl+q6wjd/Evzqd8Cjc35SnAFqHvP6X2B+O9MMf0TSEHlGeP8QEFtefHJBh/d/FHlsPcanyuFFvl13O013SKr5tPJ1/janebZpmt//0SQXV4vjgAw+Edfg5ziT3Mm0xpjkmMeyY+1XGUJH+ddZC6neQtY6kciqZ1TVfsSxBAkDj46xHPley6hSG1cqTIeljkGdyaWRss+vG27wqVwFaRXspPCU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=BB/MxAABBApyYWqJLJXAJcivdZxjKiRvlO+Me8MXE8NUfcEjIF0p0FHn6P02qOeW8gEvitJPLWdVsH8S9jokHWeRs670ohuygt0Fxtd3IdcWGiBFI3hRmCeWcytGvypysIL4+JZGZVBlTmC87u7n/IBMdljjSSjIrv3yO3vY1hI=
Received: from DM6PR07CA0058.namprd07.prod.outlook.com (2603:10b6:5:74::35) by
 IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:23:49 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::a3) by DM6PR07CA0058.outlook.office365.com
 (2603:10b6:5:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:23:49 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:45 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 5/9] Documentation: amd-pstate: add EPP profiles introduction
Date:   Tue, 11 Oct 2022 00:22:44 +0800
Message-ID: <20221010162248.348141-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2392ab00-9f04-46e9-b61e-08daaadbd033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cW3ychRAPue+rp0EO89oTCJOYv+ZTXFqRs77augSRTwIkx8teQJBHvI8q/mnR5LjSYCQtcwukcarFiVweGWKhJU1fP4EoL5wH/oWNZn7wtaV9xO3pSybRq1gYcbb/QZEcMna2fDoR1tf2hj6phn3+xCRNRsN1WENJ46YgICJdvTMDSrbDySoILZs1hF9CkDPryZmGQk81ezYK9zZEjvYiyRZcOFsaYDpeAWv6ytLg+HXqGcClDpk3yjtkJi4JBE0tBbs71P7eMvJjmrscOMWOJoS0gHCyUfpsx9FWlu8OT5C2OxkohhWCcRyDW9GX0pTBo8/XUzOcyiC4IfermgrIUhgeTjMO8eZj1bKh8iRI7VIFb5/iet/zOLBYvtvbZ/zXj7AzrKX4pm00ESKXLM9FBEgFDIQk81auFGPoAhjvLwBh8VWXRmXL4ZUgtqsMC3PJEawRl92jQikkZISP6Ly0K5em7zyiCJcyTpCKX7mlzJdgw1ULgMaKaKDdDxdwfMPDyH9LHN2keZODJB1D9lScyuYbfXm5Q0uwHlXEIGETnE9vfqCPkC5SZVxWiXAxIl6NuNJqjdbMzSSpIh2qiAn5+EoM+1Ck6VQiRdNuVJCQfrBRpz5HSJ6+dUM62SjNqggjblbDNCu0fWmAQ0/Ji7rTYgoHkp5tQ6i/x6zaSwj9l+OpDcI1dYPGXd119/QXML5lgX3+muZhJPlohzgyhDGR0nfmoa8HBzoZ7AdipjY69zlL8fYnk69jRpf5pJECBFHmQzN0m1QOSJVNHd4X71FnH5aZyTpY6nZjYLCNqAXFeplAK4zzQXzemZPUcm5dPcAemfg03z9c2DCpcVAJGt0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(36756003)(316002)(36860700001)(2616005)(86362001)(2906002)(7696005)(26005)(110136005)(70586007)(4326008)(70206006)(54906003)(8676002)(40480700001)(82740400003)(8936002)(41300700001)(16526019)(336012)(81166007)(186003)(40460700003)(47076005)(82310400005)(356005)(5660300002)(1076003)(426003)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:23:49.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2392ab00-9f04-46e9-b61e-08daaadbd033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 83b58eb4ab4d..d0f0e115013b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -261,6 +261,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``energy_performance_available_preferences``
+
+All the supported EPP preference could be selected, List of the strings that
+can be set to the ``energy_performance_preference`` attribute
+those different profiles represent different energy vs efficiency hints provided
+to low-level firmware
+however, the ``default`` represents the epp value is set by platform firmware
+This attribute is read-only.
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

