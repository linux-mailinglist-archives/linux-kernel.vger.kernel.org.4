Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F52682817
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjAaJFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjAaJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:05:00 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31F18AB5;
        Tue, 31 Jan 2023 01:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS/T8NjgEiMhKGaIFUBoYSbSkvYx8Fyqu5LNBjD8tivFXFjxsASPwye9Bpr11Gelh8oErS9EH46P2YFladbf4cm+GcDfiCDPeLNa/GuR7cx1nhnQWGzIJybitNQPPK1dYdZB2PL9BkxGOlNXf7yIJwctrHVM9bn695wiFlJ19qXvAScLep6HY9JkaXJIyG0xvLcLDP2G70wPVjfi7eSR8SRtKZi41KEkcEdiIBpG4wXaJIzVIFDifQ025jZYAIFWq53DAlaaCJsjwPArakPJu+fWi50yJ6E8dyh6tZXQKg6QgPLDHiDZp9+Xk7wu2coBjm3yzJd+9hH71iTpEyDg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtZucNF8/n0YjWU2KmFqZiS6t08dQ+1Lz4VneO6FxAw=;
 b=ntazPb5TLKPe3I7Qu3OvfFzXVovNo6s4d/LWKKSkNN1oCtIIQ7mbyOUIp6MhqtTKsfyvRj27dE0ezSWhPzQB3w9zmm45cUb1FdLzwPMOmH6D8/lUSJTG11uBzOUtLuB4qUqEyv913wlhYfVJ2TkL+TgmZ7XpT01R/2Q8qOSPx1HS535tLehtMZdiPJaqIdaPYYcRFhrx1sEbO0Lyyz/z0vg6vCDiYHXmYjBF3dBvpYYiUuWMIrhn3C9DZX06qjCrosg2z5a0eOs+i76YlU2UjPE505wXXg81272rQ6M8QhyyOsLSW9wuh4aTPOoAew13DS2qvKiZ4EeNO80oPaWWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtZucNF8/n0YjWU2KmFqZiS6t08dQ+1Lz4VneO6FxAw=;
 b=0Q4e+SEMLYSXC8EkpQlqF0vS2hM6r1nvkXSJQW9VfC9AMUeKKvles4gsExobFHorNRKQAj5lqMttCK6rziqepQXwumr0vUb7SwON4Of/vqZxmX4ezuVKsWIunbDyvuOsE2evcTRO2+9Q69tb/6yexxlf2qdkML8Kut0l3eRc/Kg=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:00:57 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::36) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Tue, 31 Jan 2023 09:00:56 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:00:48 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 02/11] Documentation: amd-pstate: add EPP profiles introduction
Date:   Tue, 31 Jan 2023 17:00:07 +0800
Message-ID: <20230131090016.3970625-3-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: c03b7ee0-482a-450d-ef4a-08db0369aa48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ge6IFZe8cTFQOQan6uU153xkPDE4SH8pa+K6XC2daIMQ0FzHucM9YZbSE4s1VhJpfGT/Oas6Ei3m0DSuOVlj7MIY77ViqDrkwt0ciBeaC3DIS8s/a3Ez60klZRgeLsePyGVSKXVIbxTjD71qPkKpsCwEGx07W8YxLpkLlBPrTM/1a2YSziUemba0dMFFqttHD9FgbHK1x/oCX8wCQru6hMcuJAMW85a+3KZMOZ8tk08qcngJS9PzosGPRsFFsepoe1DfDLFm7EVpov2Veqjyj1wAPbdvTVIDzezonlAwt9Izbp9Cgu101Q8yfgJCYbzFSd+qCZcGFtgTcoHMaH1CJB2ZxhK01t3X2gE8MTFB4UAGh6W77/2GwogxUvQxr2d7r4chWeQ1580QUbwDdW00dnV95ZpGzQVQ+X0UO2TAnoYzHtEogQR27qYJgLXaOfc9YzCNJTh2FkUIs7N1U2GVIMCBPs/VTUyOHX4z9lCKZRvRlPeJoE0LgMPpXu+zU5ajMPRBcrO3u39iCqcrWwGkXJ2C3zU8mIy2Vu68JNMNk6Sp7huyRqgAlZZ9W6j+ir+V+DfCKD3HtoIPrg/pPCDdzOP1beZUAitbiKZ8wEXB0N1XLDxydAN30fyCpxFIhXAJPlLw9gN94VcCA0rcP9cf60yttZnF4hXJCEPb0yY1BIaqcvwSNF56rkciUQRagCwPEqq2eDwFYGZlA3tNJ0V9xmhgvOnCTDQqBBENPMbxiHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(70206006)(426003)(336012)(82310400005)(83380400001)(47076005)(40460700003)(86362001)(36756003)(70586007)(8676002)(82740400003)(36860700001)(4326008)(44832011)(356005)(40480700001)(81166007)(2906002)(41300700001)(7696005)(478600001)(110136005)(54906003)(6666004)(1076003)(316002)(8936002)(5660300002)(2616005)(26005)(16526019)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:00:56.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c03b7ee0-482a-450d-ef4a-08db0369aa48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 5376d53faaa8..98a2bb44f80c 100644
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

