Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2969162D146
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiKQCwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiKQCwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:52:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362A43AF7;
        Wed, 16 Nov 2022 18:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkWLJmmt1drKHO6jEoqGJ/EcRhYAb93/FgL8G/SDaQ/ilDQU6qFxhmu6AVIGDDiXJQDcyUILcfh+8NvZLt0mmq4Xeq2oncJbZnxH9xXCM7ZKctgA6Ou4WY1nUx1NsH9e4C39dUy5ukW7Lzc2L4zK0Xr71c4hgeYJCE+ch7FD3ITDl+NLnZQ/sl0se/6H2rDW5AAwotz5g8mRRtlgzxMtBEqfvUZpcCZBUaKtp+2D1C2tQ1WfqAxnHKHqanOl9rCIAJFOBTRJgtyzj9xJa1ktpkxhTKOfSzgyxQ65M7qKfmSHNw8kuTl2sxzwuPY/rkwguofqIOjGTmngmz9wYNshOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOaTYCi7NB3f7zqVf4NrguCJferwo6NNYNHoyElxFQ0=;
 b=O7YEBvdQW0VLurrRADmzjyxNGR4t01EcABf31pF5+GVV9i1K0IP9iTqu/6DGf5JEXIACu92l+Cogi51jTbS6k1XMm295TilVSrHFB2LGQ2sDUmevGKVgasV5XToVR7gtKgv+7EQa5urIdSKeVn/2yQo9mZz/+0HhY/iPjOrLIv3T3LsXZS9khwfNiQJbHc9TV//c8WWBoS7/EmKjDv4FyHmqCV3arms102GI/pCAHGH93DrCX8tun4uzw6Qpw1d+JdB+n9Trhsm8SBu6oNyoCBlJoHV8WJwLHKsfcasuWBoKpHDRh50Maql3jRQzMHClbFOeg0HeI6gCDJvOHFJyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOaTYCi7NB3f7zqVf4NrguCJferwo6NNYNHoyElxFQ0=;
 b=JgwZ5WVyaOedb2u4Yxn3RxM68CjKxDucKJjrzdUuzXDqxYKUCzx0jVTxhfja/UXOdPDHZtmNsjGSYsxzTxXf3RcsEj1PYqM6EIBsOB49XIsn0ZCovWXDS9c3oE9UMzvp10deGIdVLtGIzMBDDAsgERZ4OVGHCS0S2My6uTOOTX4=
Received: from BN0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:408:e5::33)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 02:52:21 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::a4) by BN0PR02CA0058.outlook.office365.com
 (2603:10b6:408:e5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 02:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 02:52:21 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 16 Nov 2022 20:52:01 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Mario.Limonciello@amd.com>
CC:     <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Deepak.Sharma@amd.com>, <Shimmer.Huang@amd.com>,
        <Li.Meng@amd.com>, <Xiaojian.Du@amd.com>, <wyes.karny@amd.com>,
        <gautham.shenoy@amd.com>, <ananth.narayan@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 4/5] Documentation: amd-pstate: add driver working mode introduction
Date:   Thu, 17 Nov 2022 10:49:54 +0800
Message-ID: <20221117024955.3319484-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117024955.3319484-1-Perry.Yuan@amd.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbf3f15-94a4-4423-fad0-08dac846bf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvQKM1SMlaEu+8B9gZUMGx59EQPuXvz1FSh8tww8HScfh7ZoHU9/SWQiW4Njqb7XGdkvRg/ZzaHp4a8HCtYZvwJRbbhYojwF4ESMDKl7dZUwtVfVNj11NM6Wa9MR63YaQStw7JvajbRnoJCfhrA85bLyZ7Jogci+z8oUHppfsqdZ85fMViL1w0yz/UB02uGkZxmqFQWnswfNIS6JT+McErU+YuTcxG3n1D7rsWWJlXweUfYImeRBg9ueGVW3YpKgm/Xeyux7BlRULc5UmIilt/ELPl8IS1UZvxQPOl462H7hDladEOLl9qmAn84u/CTMmKUH+kmhiwcU4u/3d7XZBInt75MI5Z85bgsPlZlXGfUusuqb8OMvvIRLl4wJpSK9c1400WX/r+RfHiA6hxy+xueKhvo3w1v1o9Lsa9cRmiqTL5MrxWbuyEfqsqmJMPpOyhzhf71UHkwOAqpu6yssNzrIXAtTzcprb9DowheG198BQoawcbYaDvFyn5D49j5A1V16WESHVG4ArhuO5u5aeXHAfnJwSXYzMicNJC0QmNZZyyEoSD2lzdpDoYelxLHwfrgnNhQ0K9vMq62qRhI0ONZLOsKnN6kynsoQ2S3Ff4u5stGUgPsCBsJtw6jV283TXPS1I1Q7jmYKbafdXyX+Pp0sMtDH4h78G1Duv5vsur0nKdoocbYLKZmBVHJ4jJT7JxStTenk9K4qmkJ7gYMMB2TeiyYTwUYHkSDWFOKzdPVj6LHLTajREOC8CEAJaE5sT8Fy5ekbu4NXv6WeKsuaSXDMQ2cyURI4RQ8GzIJQchd9jD0hGLaK5Dgld4Zm/tGlyU7aBYpNFppkI3jDmnxFeg2C08R8BtB63s4v6h1/RNk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(36756003)(426003)(336012)(1076003)(186003)(2616005)(41300700001)(70586007)(110136005)(82740400003)(86362001)(82310400005)(40460700003)(83380400001)(70206006)(4326008)(8676002)(47076005)(40480700001)(36860700001)(8936002)(2906002)(26005)(5660300002)(54906003)(316002)(478600001)(81166007)(6666004)(7696005)(356005)(6636002)(2101003)(36900700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 02:52:21.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbf3f15-94a4-4423-fad0-08dac846bf73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the `amd-pstate` driver new working mode with
`amd-pstate=3Dpassive` added to kernel command line.
If there is no passive mode enabled by user, amd-pstate driver will be
disabled by default for now.

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

