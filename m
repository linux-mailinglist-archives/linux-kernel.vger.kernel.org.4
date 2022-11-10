Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F26248EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKJSAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKJSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:00:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09684D5C9;
        Thu, 10 Nov 2022 09:59:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBopCSqXuwaBR8PfOexIfnh12cOCbTRJsNJXsW9yMlpDoQeS18e9MHVQ5yb4XQOH8WXHzNmw7FjToL6aGdrztFjefoeo9qSDk/35uDRG1v7/T9wnoiIGE8YjqK3F4Us//U3Nj29tJuZp9s7fdSkD7n80c47gBXlVg7+7tHZicyg/713huECScWSEWUVdeiC3HklBdYu9kKFJwfu3qvxdXjsgPY5jMp7X868fR1ZVAoGLkpcyFp5eagNLRJ3Ch0/JdjRb4WjdH+SXRbApMQejUnGCBYR64kH53j29M5Ljbc1TTul+evC4k0/G5S2fW20folV/VN75JZByKRJFFLuq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlQqrX4X2vwY4rfCZlUSL8UAgHnVKaiMh1Q8cKzN7Qw=;
 b=liN77i+JoEyUuJOXt0YJ393JGYbVVwWn2ccUVI69QieTBU+j/5CCe4ZlHO/LTua3UJwAypNSyXLU0Yab/tWN2vyygAfxE6YJwc2gZyd8EmY8P73h8VPnmNsFIlLFWUI1p/pL8TG9tXn8mpxJZes5UQKODLBVwerGwz4hJy+7j1kKj+y6H3FDuGP8vTa5CQ9QCU/E31rhBlnlBwl0VAJ0A01Kguchpc84SgFl/+3Yhp+oe17h8mmju5mLyF9wtu+Kg7zfwjAuxqJYwJvpLpa0HWwcxdilxynn0uBGWRe2XWE8mwc07Q4nWRLAPYqJmxp9Bp4T3yldzmJ9WLQfHqo4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlQqrX4X2vwY4rfCZlUSL8UAgHnVKaiMh1Q8cKzN7Qw=;
 b=t1VDD1KC1g9Aok0LItP1jGK9psyu+rf4L2zhZiahVHp+WrIU4V1+hLQosAL+xJEzLqQXfPBbMO416LmAqPucoxztImnvg8mooz1ll+0pOKvit/MaTwk8RrQiAuDAIXjDmb/y/tHpEafS5pmEOBc7z6KwONIAEbduv8FamxzN+zk=
Received: from BN9PR03CA0900.namprd03.prod.outlook.com (2603:10b6:408:13c::35)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 17:59:45 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::15) by BN9PR03CA0900.outlook.office365.com
 (2603:10b6:408:13c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:45 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:41 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 9/9] Documentation: amd-pstate: add amd pstate driver mode introduction
Date:   Fri, 11 Nov 2022 01:58:47 +0800
Message-ID: <20221110175847.3098728-10-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|DM4PR12MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ca713c-13fd-4e53-1129-08dac34559e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQ7lSsyk58y/FWbsLOaXjI27X5Yovv8wRlppUD+bO/cf/Sdpv/VsLBqepJUg3TE6kbeuQBvN4eQMjfDnDLFoGB5e2wcoa9IBtSNCitJI/kEZ44ubKyBYK7juISPo2zAxwg5JT2c1QOCtAVxv03urANprondyiKZ/YFQFdhnNij8Eqnx17ZYbAczj773x3g30D180YyIHI1kJBaFkMlgOTgNiQuuKRvfkm/CAfnwbQtYp3bVtkKf2l9Mi1ljL/ZR3O/FdLfkXJb42jtX8wKYsC8+Mk6woKaIeNVbDaUkhwtyhkLZjsXMghUizylNBkmOxhN8heqKy6CB0D9Kt8TAiWPMbtN9ti8KAAUi/jriGJ91mkPqzM2Ltnk76E8TBdJh6dHGF/6URz7OTYDZQcogZo5rPO68JJ7N3jKf1Qvq3TmOSbyXhhT/q7MzwKm9JzyljhN+5Hh/OWyrf/bkjpo23PwAUkj4oOjDjFcO4cN+zL5jr7qhOwcE1MOHq9Ks7ctC2OxVWzNZdLACT5jqo0gcgCpjQ/6qra6RTwYhsc4r88hCo8bhgnGZjL+BRzDLOzWBjipSBga0ZXiTvyOVp1zNRI2Rp9wF0sDkw7S543DEabo7zTmoIQCfljEftB+i8Ia5oDf4PFRbwtusXw+sjVzAOkL36u1u5TiZaUhVdhKvinQAb6aha4gP+M/IBWBlPlQm/Py6RzVKa/9y88zff2fds/IThWa2N/e3Wwfy7yO4mZpJHTpLC0A8nhV628Cc3tSoRQok6lIdOWMxlpTnbQf5aCiOlbxuCwD3ESsFIh5HaOqT1hJcoQi+rptYbNSLenu6W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(8936002)(47076005)(426003)(16526019)(5660300002)(186003)(478600001)(2906002)(336012)(83380400001)(2616005)(36756003)(7696005)(41300700001)(36860700001)(40480700001)(26005)(82740400003)(81166007)(70206006)(316002)(8676002)(4326008)(356005)(70586007)(82310400005)(54906003)(86362001)(110136005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:45.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ca713c-13fd-4e53-1129-08dac34559e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ``amd-pstate`` CPPC has two operation modes:
* CPPC Autonomous (active) mode
* CPPC non-autonomous (passive) mode.
active mode and passive mode can be choosed by whith different kernel parameters.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 47 +++++++++++++++++++--
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e7488891b12f..6ba02a658b31 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -302,11 +302,11 @@ efficiency frequency management method on AMD processors.
 Kernel Module Options for ``amd-pstate``
 =========================================
 
-.. _shared_mem:
+.. legacy_cppc:
 
-``shared_mem``
-Use a module param (shared_mem) to enable related processors manually with
-**amd_pstate.shared_mem=1**.
+``legacy_cppc``
+Use a module param (legacy_cppc) to enable related processors manually with
+**amd_pstate=legacy_cppc**.
 Due to the performance issue on the processors with `Shared Memory Support
 <perf_cap_>`_, we disable it presently and will re-enable this by default
 once we address performance issue with this solution.
@@ -321,6 +321,45 @@ If the CPU flags have ``cppc``, then this processor supports `Full MSR Support
 <perf_cap_>`_. Otherwise, it supports `Shared Memory Support <perf_cap_>`_.
 
 
+AMD Pstae Driver Operation Modes
+=================================
+
+``amd-pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
+CPPC non-autonomous(passive) mode.
+active mode and passive mode can be choosed by whith different kernel parameters.
+When in Autonomous mode, CPPC ignores requests done in the Desired Performance 
+Target register and takes into account only the values set to the Minimum requested
+performance, Maximum requested performance, and Energy Performance Preference
+registers. When Autonomous is disabled, it only considers the Desired Performance Target.
+
+Active Mode
+------------
+
+``amd-pstate-epp``
+
+This is the low-level firmware control mode which is implemented by ``amd-pstate-epp``
+driver with ``amd-pstate=active`` passed to the kernel in the command line.
+In this mode, ``amd-pstate-epp`` driver provides a hint to the hardware if software
+wants to bias toward performance (0x0) or energy efficiency (0xff) to the CPPC firmware.
+then CPPC power algorithm will calculate the runtime workload and adjust the realtime
+cores frequency according to the power supply and thermal, core voltage and some other
+hardware conditions.
+
+Passive Mode
+------------
+
+``amd-pstate``
+
+It will be enabled if the ``amd_pstate=passive`` is passed to the kernel in the command line.
+In this mode, ``amd-pstate``driver software specifies a desired QoS target in the CPPC
+performance scale as a relative number. This can be expressed as percentage of nominal
+performance (infrastructure max). Below the nominal sustained performance level,
+desired performance expresses the average performance level of the processor subject
+to the Performance Reduction Tolerance register. Above the nominal performance level,
+processor must provide at least nominal performance requested and go higher if current
+operating conditions allow.
+
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1

