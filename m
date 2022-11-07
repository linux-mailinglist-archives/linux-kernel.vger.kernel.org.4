Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED361FC96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiKGSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKGSCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2212AED;
        Mon,  7 Nov 2022 09:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flTuED7WHg9YahbW7hBCeKyD3L1ziiFPNFcx+PIRqTfIjiasrYYyB4cjxE5H4v17TkOrfJW+JKFUVf9yowB+0ubHPHeo3+nwg/FVOb3CkBq1P7tPCBrMYg1MI/ZJmx8aPqXziKc8hOaEK05j0Fnc5MMjn6TkI4V7hhrerIWdaKA3X5vQPE2ua3FYO5Ec9Chh41aeWcsSC10u2wVM3h/Oza1f8pHmH1Hg9R2csJXCXYXaLE+5dHsTEkmldDi3ns2CYVXQ7qMNPbLbkYf6lp8D2pJiv23/ALRulKFALGx5JjL14frt6Y+Oogrc3wCNm36YRvfl8W++UACgtIliivOdZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mauCONpk0EXWpZUrntyK4bX2csAU2BBVTXi4Wa9M5K0=;
 b=YsPkvtMMGv5DFkD27km1U/KL8y8M3t6UBzMYlnjF2HI6TYXPKcbMrAYnAwFrFRAUPLphlEubxoEKsKkejyKaX8uZLRtZgyFGOggUG20axLMePbhs27AKv0q1taz93/Iboi2nTZylktocjUSa+h97rni8eSQuyXalf5DuS6tZuqFaeQZvugkUKRlu3setj3ebyaIz0xM7HiyC84UgL60HweseTIOPZyHIcjaka2Zp8uM6SLfFRDelWLdJ9g2koejc/unsBZx8YR6Hd2OwSjLtGsd1OS+SefTIlrlVsKESQIG62swNnx3mfb9LnXt9Afvcx7ftNmQVvD4WgrZhlzciTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mauCONpk0EXWpZUrntyK4bX2csAU2BBVTXi4Wa9M5K0=;
 b=DzjH2jbfdW3s0v0Wa9SyIRJvkGlfqpZpx1aRU70xkZgoWQ2RWc45WyMnT4OjKCo70Puffi50Cicg47XA6QyRnuOfSzckOQr6hkTgMBAB1WHzna21Fg2k0xYNn/D1ALhsyoNO3GX9xUyrwTK84z2JyFWNtOgGnjAGIX3thj4s3rk=
Received: from DS7PR03CA0177.namprd03.prod.outlook.com (2603:10b6:5:3b2::32)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:58:31 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::c) by DS7PR03CA0177.outlook.office365.com
 (2603:10b6:5:3b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:58:31 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:57:58 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles introduction
Date:   Tue, 8 Nov 2022 01:56:59 +0800
Message-ID: <20221107175705.2207842-3-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|PH0PR12MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1dbd9e-c792-4ed5-27e4-08dac0e9ae92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esiR2yrZcGtTbkX7SARkzP41gWAFjvlMq8ebZDTDYgrQmBhNgoyJwB6Vzt4wQFzICZOPjdWW7XN6Qsx2SOqTeXcEh0m7GJDkEqu2YXWBGEsGuHxLdnXN7Y05gMydpqt3padgxwZgucVqEbZaFm4628ajDAfd16oXOcjIjE5F3wqoWzUFxkPAY5H5bPLBWqyu/2zjL8joDpJzTHVc6Wi6OGtxB1pMsoZffLjrnSMGXhLSzVHexKmd2MpxkUOHiRcIGqNATT3WPPjeg+ov9KVnFVz6ZSuVvnHOpkQjxz82k+XAhVNSL/gRoycAifkfCrRZwGLwcyAH7c8ciJhrGusdOL+NmKNtF036VYNpgJuTX75yKVhDCknQljjqKhc1/r5Kl1wD48aV57pmiwzlf52byUk4iwGvaw8wwXn51zVVwy/OU4l8y4Y2/2cK5I1znVP/EW6nI2nWqVxAo5ZCkUQKsfUZylQP6tJMp0K5JNmfo6i11CcpqaEvGa8xHR4PUYh2eOpNw0Nv9FcoJckH6o+ZdtluRb+v1Wpd5oSP2LmusZbOWLoIN1sUkmcir6Lw03QNR1qvYDg72sDJY/QBuUKLc9FPieDHfvMjSLzYpS6N5ekir7PkFHLHYEow2MEot4jMiU5mc2dj3s7P4DTrOfOEhEHeqKILFvn6UTdDQOKw7lZ3fWKy/hz/gToH0erVzMAkmgeNE+7Knj55YtUV0TbUEvgoK5U/KSFX67CR9sXfrWkrFYtteGfzd/AXwjqy7JpOtxc8yGefec1ey97dqbFSc+0DcLpy/S2xbNMj3Zqp2xMWNH37jNs0xy5hdT96iUdW896MFcIs30v348/zQe5f4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(7696005)(54906003)(110136005)(316002)(40480700001)(5660300002)(47076005)(2616005)(2906002)(426003)(40460700003)(8936002)(336012)(16526019)(186003)(1076003)(26005)(86362001)(70586007)(36756003)(70206006)(8676002)(4326008)(41300700001)(83380400001)(356005)(81166007)(82740400003)(82310400005)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:58:31.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1dbd9e-c792-4ed5-27e4-08dac0e9ae92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
index 8f3d30c5a0d8..78c6525d5a49 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
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

