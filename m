Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BFD5B3D49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiIIQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIIQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60691145FEF;
        Fri,  9 Sep 2022 09:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBSUcUHCEN04FBbIbbnCOmuMIMYIWzA+wqzoDSKM4Ei1o09leUZAtjAJYzt9izL0ZkvTMaHPg7Cc8vqpqWFiy9lfc6lO8His8K+tBFek/KTSs24ndg88zwxpI5UQSfMc/dapzXMM/IClXHAISzz8tHXu/rVwQF8zDHNTSQl+tODygXap+kvKX2GjSrwYM8TIpUIO68rwSsthamrYmiKSioZBYDHvEhC2/5OpikD5w73JALpp3qicH8nFkQsdd/dysU4E86XLLqP6Yha2w5mwqqfJsE6Guuz/YN+6FsOQlIGRHQmXuiyzd6KW2cYiczpsKk4bX1znggae2gegp8WKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=Y9V60Tdn45Rj8W4++CDzWQxJxJ82ASxYCglnGEh1kEJxA0Kp9xscx+FvrL1l12Vi1Lel9URYlivM4wEivyT8CBXjlDKomb/v71NqWozCwDgv/jHEhgq3NU+8uEGYfXVvyqDQKE9vRdVt65oTF9L+HYpRH8b89Y8oWzs+DCy2fOrksr3AzVKNmM64RSldViiPYBfobIGiQiW5mi6f+89pX7SsVUMdhg8Su6F8ssIE1BiWjB9+6Jl+VRMxzGWvw/KsW23w84axaYLF5LYmeroBYT+RUJ0TT0sngmm8B23UkmmNSRqJWw/HL5DUfih3TY1diunISmx328SYXSuV17k87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgwwgUTea8LzxYVtl63IA8DkBDwDsPFufaAzSXP5Xw=;
 b=HZXUbS4swv75xbcu7+2OKHmbe12/RVQuPzYllC4sC2lHWbu88lRyC+VmZjo5c3D3OKL7GbeyiVVw2lC2KC8DUnkGGNGSmjuPiprZ1KwHHffwwy4S3FdunKEKhVPkW4jByt4XBD91ct+qdYWsq1Duhooe+/0tsSWwpFp9lFKMbyE=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 16:47:07 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::68) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:07 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:47:03 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 3/7] Documentation: amd-pstate: add EPP profiles introduction
Date:   Sat, 10 Sep 2022 00:45:30 +0800
Message-ID: <20220909164534.71864-4-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 3068b7b6-93ab-47f2-dfc6-08da9282eed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfOEI9ZyuVONl/xN/x5xF8x45ztVtd+b0ANbXWRHYMjqX9Nz1Xry0CXCNfcaW7fJqbRWlfc/3g95QhiLTD+NXUB2dE+TpClWEfIlC1GVcMySak4U9yH0eTrpWNA5Atp8lFonhxXvpItg28uw6GjUXivL4OPbRORj6MwYZGbqgO34UVt7BPTCNnRVpj1j3PHkJ9l8ptLXb8jgcve+ADZNhLVhe/MHWVgIfS4FgqZn3+gSStxr0h9no4On8Puh6j3/JJ5B1MEM5vqg4yFIf+bcFzVAzlwGvgxVu+m9YGo47OWjIetl1BrU8aJnWsw5MCmzHq5YrTlR89RhEfloErslivQ49hOe2JR0Tq3iYhFdP6XSH9UU17H5kQbpkSBnQbn1OxyNpP3tszY3U/0SXSB5f1skr1zVGY0i3ltn6DKWwrf72Y6zxZvdVFKmj2QKf/37nbn3H97LysXFhKgUha7uLUiiNIZ1chVLoThrJ4e9s6HGbC8YkUtZY9GnC6CdsX7+x3nhD+KVLxj6gSRdMtZuuhZmn5UlSH7J5Rf5ko51ukdDm9Q/PpXbmKn7hjYF/YYJ7eKNH/TOaH6gs8BBn8VUroGVbaQBm4PEQFTOFVDA/nP/BBUx8MBEcSdBbYIsWc/d/SNlzaj3fqcXP8vZFf5AmXkL0jM/OuoI649UEjUNMxEnYfRi4BcQX7GudCx5rdSYc0LgqfLL7j4tCygftVOS4nQZjgJia2qDes2rt90azWlwk2gBCwO4wwym/oyopcCvsE+DZDDGc0CBRiGvm8CSjBeD5Oav+Ejne/5rklelzTRRX5CG79XXI2ZKmK0gtgptK8bW681et7+bqQoWW7SI8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(41300700001)(356005)(26005)(110136005)(82310400005)(6666004)(7696005)(86362001)(478600001)(40460700003)(36860700001)(54906003)(47076005)(2616005)(336012)(16526019)(186003)(81166007)(1076003)(82740400003)(83380400001)(4326008)(8936002)(8676002)(36756003)(5660300002)(2906002)(70586007)(70206006)(426003)(316002)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:07.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3068b7b6-93ab-47f2-dfc6-08da9282eed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

