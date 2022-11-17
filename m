Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8262D435
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiKQHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiKQHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:36:34 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B560716E5;
        Wed, 16 Nov 2022 23:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWJEvMUi7yyzn4ghS0elKbQdUglpKPvk3oBqz0Cd/jJn/bWQB0f5JhPEAIMEDqiQajZIJRiR58XSv0Lxp5aszz0UvgL9gcUx1f6IxVQgqPy/K5hiinN5Livn0bGM20eIvR/13ZsfJJOAWn+jDq3zXv5LCNXQ8zSQpLqAOoPVijpNfJ89SNPT1OXcCnaqrS5YLoPMHNLwH6ZI1UyTSw5mkRZxC+ly0YSAoVmJhlp0Vv5O1SHAksRJcMNhDvH47nd2lQfoMnlzBNAY/zX+pE6Q/WOhPMQeP9t52KwH7HbuMloyIlMSwicDfokwAiEypPeZe/z1R791vQMwEro/SmjBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO4m3TjiJFvcONan9IEiN7O/JtpSbNDasZ8yYiMl4VI=;
 b=gjfIgIJ+hH/561kL1LK4daElcjr/iV/ubi74ve9gonDvNiEre306S+s9g9LEYihgXx1f1e4lnjfjnId4dvlD0CtfIqmN4TAVxm1a9T1gFm8/14xCBogvxn5KcoLmLBv5nihOR1yClZBzGK0xaw7KuQhDJU2XOdea4+EZXCyRcnKzzYtXQMijL+BCUSyA2KmMoORONeHedIZaipYat8lCdD3cQmg53XvPb5toxdHPVyVFg8rSZaS61r225nAG5/W1iMhbiWxZGfhsvA7XlBkENozJQ8/gvBPYTDqriJ/mVC76XA91KUVwWfpcZpBX5xTCM0C9gOlF/YPzmeo1xWkzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO4m3TjiJFvcONan9IEiN7O/JtpSbNDasZ8yYiMl4VI=;
 b=vq5fvNXzhZA8i3ITRD+d9IrjbOBvIBpCcmDuzwoq92ISPn+XvhM3qyMgkt5r4sWi/XTpDlgLaU/IkiTvEpsWWkT7P0R2wFD2YUrHlpwL2/gzCt17BK7efg8bHhHrVrGIjBzxpvh+AY1uGaWe0zc/m+I7Zr3nNhe+pEXCjUfOrsE=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 07:36:26 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::b) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 07:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 07:36:25 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 17 Nov 2022 01:36:21 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 4/5] Documentation: amd-pstate: add driver working mode introduction
Date:   Thu, 17 Nov 2022 15:35:40 +0800
Message-ID: <20221117073541.3350600-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117073541.3350600-1-Perry.Yuan@amd.com>
References: <20221117073541.3350600-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 545c60a9-9e39-4ff7-ba37-08dac86e6f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fYBWSZV3dfCuhN7l/o4Ko/cgr09XlTsV9iEXpdXURE5eQne623BqJp8L+PAm2EY+h1OMVK4R0keiTPJkxLOkZLtEnAZWNigum2LkkM2zl100aKWVF1JaXanFhX5b8LNap+KF6M23EyS78qBdP/tqOJuy6PMrx4VkXG3GSeD9M6C+b4h0xGwXAHgE769+Bb5QHpXa9GP1SnBfLw3HH/yik8IuAmccBRHVB+KoHVXpt+KLOVrY2f4pu6FMLzjn7l4Zy/RmfuS9J46IqYRCH0xEW49UGet/HgtdIyrvZqVGHjGj0hGn3tIaqru6x/Mg6ZzPU0Zn+tNwbfQ4JzIMYG8Ceeitxw/S5f0WBAWsYvB+7BGRvXNqU/r5cVFp0XVMTCrKXs7poKq3WJFt7FhugcPp3qLyyKqo/gO4XVwV4xHkHasLWHEwQLLiWnMC1f2qsBmU4vll3YmgAMJC3IrlItYIVKvi0jyzy76UbL/pN3DjO6sYjpLjZkDUVDuowVQYxT3XT2n5w/lezMvKvOMvsiSwCDktRLbiG9xfq4+jtkeGWnu/LurMCzvbkS3Ih2zjVjf/WG9Coe+D89LokebTXjbaLf6Y+w3gUKfZHiCyCbNjO1UT9aj8k4a4nVT+XLl1N9g3J2Y4siP1XrBL7fmWbNmrzZU/aE2EeZEhMbvdpMGMHE/s8SbOKrJ3yoSU9DUXEwvkOFHbjYxII4um2Hzabv7UM/Y8szDrX/lgxNZkZ4a4MDhRdmttBDsMZtvr93UkoyQF8xYqqc5I7hGTjvBK3unctFPuwkWX/VDuNJM/GZl65o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(26005)(86362001)(81166007)(82740400003)(82310400005)(36860700001)(356005)(83380400001)(336012)(426003)(47076005)(2906002)(40460700003)(186003)(1076003)(16526019)(2616005)(5660300002)(478600001)(7696005)(110136005)(40480700001)(8936002)(6636002)(70206006)(6666004)(54906003)(70586007)(41300700001)(8676002)(4326008)(316002)(36900700001)(2101003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:36:25.9035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545c60a9-9e39-4ff7-ba37-08dac86e6f02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the `amd_pstate` driver new working mode with
`amd_pstate=3Dpassive` added to kernel command line.
If there is no passive mode enabled by user, amd_pstate driver will be
disabled by default for now.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 30 +++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/ad=
min-guide/pm/amd-pstate.rst
index 8f3d30c5a0d8..06e23538f79c 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -283,23 +283,19 @@ efficiency frequency management method on AMD process=
ors.
 Kernel Module Options for ``amd-pstate``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-.. _shared_mem:
-
-``shared_mem``
-Use a module param (shared_mem) to enable related processors manually with
-**amd_pstate.shared_mem=3D1**.
-Due to the performance issue on the processors with `Shared Memory Support
-<perf_cap_>`_, we disable it presently and will re-enable this by default
-once we address performance issue with this solution.
-
-To check whether the current processor is using `Full MSR Support <perf_ca=
p_>`_
-or `Shared Memory Support <perf_cap_>`_ : ::
-
-  ray@hr-test1:~$ lscpu | grep cppc
-  Flags:                           fpu vme de pse tsc msr pae mce cx8 apic=
 sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mm=
xext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpui=
d extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 s=
se4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm =
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt =
tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp=
_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2=
 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsa=
vec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero=
 irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc=
_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_=
vmsave_vmload vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid overflo=
w_recov succor smca fsrm
-
-If the CPU flags have ``cppc``, then this processor supports `Full MSR Sup=
port
-<perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>`_.
+Passive Mode
+------------
+
+``amd_pstate=3Dpassive``
+
+It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the kernel=
 in the command line.
+In this mode, ``amd_pstate`` driver software specifies a desired QoS targe=
t in the CPPC
+performance scale as a relative number. This can be expressed as percentag=
e of nominal
+performance (infrastructure max). Below the nominal sustained performance =
level,
+desired performance expresses the average performance level of the process=
or subject
+to the Performance Reduction Tolerance register. Above the nominal perform=
ance level,
+processor must provide at least nominal performance requested and go highe=
r if current
+operating conditions allow.
=20
=20
 ``cpupower`` tool support for ``amd-pstate``
--=20
2.25.1

