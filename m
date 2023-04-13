Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984DF6E1381
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDMRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDMRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:30:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1993D2;
        Thu, 13 Apr 2023 10:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9lma2BvRx1z0yV7/eFqBweOzEMg9yXSip6Gl0BQMUJVdIIy87RBdCs7T3yvnS8KTx6zEVP6CWx7yiCxR1Y4BUCnJ1g80hv9VzlfW8YNKbBUy2t14MSg9zzjlNuZtMVquxw65UvLFG6zdOEO63/ScQkrP68tjeDtIvbPOcMFuOxpTEVBDPzcyiOINyfcBLD8621ON6ELJ01v5cEFIEe70FPqOTrBJrDA1SDaFcc9xYRg0AXnb9A9U7jDPQYxvFdgedxNZOJwFZZzPBOKEa8dXxNPAtmfXiL3ijXJVknXSI7VyDmj2TgFx3cy3p/epJ2UQapWry16rFwe/h8gBoWwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BXGw4oQ1wvrkU3qPWmk9kg/Sh295wQuFEVkhFgbvyg=;
 b=Mg0MOLzzQqIegugcTU81/XXd6spsgyJPpM6F7bcwSszNm/gUS4RXqk2EcDtJ9J/jQts8Cg+lZCoMtBAoFvFyBMYIO6tHtqEwH+6xVdaTvUB0JCb67ey+EcX6daZQvHlMeZePq4WcM6KephkKm+THccQtsVHwjlRnEZ6Xxz/pt3ChW3phFV9jqYNiIDLvbePltbH+JYbjGQEOtz4i+s9yHzAVe190cReJ1a1wlE7YyvDt4xBZjAHXGUI1qdf59jwKk5L8IC7sauGS1VMDAHhRMRg7mwIPisAWyGgORyhGhv1TQJvuHVxwiWfNRrpPYLfT4gGS5RzqkCh1I82CtYjJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BXGw4oQ1wvrkU3qPWmk9kg/Sh295wQuFEVkhFgbvyg=;
 b=nlzpQbb1u3Xou9MGhQz/9A1bFs9cWpCIldYnA/1cXGoAJspC0aGOLQjrMwI1UmeYKuuPv1I/zRnSyT+PMQTZsI97OAAbrF3xvQ8FCOJ1iVh4Bx1pA5Mlu4mghZBDqKBlCLibjC+sXVRXkwcY3xcPTPoH76V6+ylv6uhmCpKKbQo=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:30:25 +0000
Received: from DS1PEPF0000E637.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::e1) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Thu, 13 Apr 2023 17:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E637.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Thu, 13 Apr 2023 17:30:25 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 12:30:19 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>, <oleksandr@natalenko.name>,
        <bagasdotme@gmail.com>
Subject: [PATCH v2 2/2] x86/Documentation: Add documentation about cluster
Date:   Thu, 13 Apr 2023 22:59:18 +0530
Message-ID: <20230413172918.1500-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413172918.1500-1-kprateek.nayak@amd.com>
References: <20230413172918.1500-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E637:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: d665472e-6b3b-468e-69a0-08db3c44c4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evoSp7ULtOdhuH9sqjdIptcHM2s0nVbxaKag9cIgjIqMSe5zkeiDC3rZmp27iRTswmNJhqSVVQCoH3IL3NlNMEmn7gxhwPv7lv8weRJzqrRPoYHLwhwUqmbIFCZcMvjaR6ub8fLhNXCrTuacXsmMvRsRH65ZBJ93dzCe+Etp8O628TZt/cyeWhuawVqXYHnMbceiRx70zaE21z1IGS7J5be8sYJLBqLnryKWkdvpEzSTDM/bKqACKU7Sapg/N39ZEnclrAupk3ErXIx/doFdnWoZZbAZSxmJI6f3FTBadIa0/dfOpATqr1OsPC8Zltyx2uGynggdM1HB/izEVXkuOobNwGKj9cBAycRKr6Zxt8FmiU4oOZ/X7F/HIyMVcvqPBi3bRmHGoE06pdcWwnCuqGglGRaM4KIZvkWij8LJfqfPeDBs+nRMlBI27/BGwiedl56tCFqAi2T6wH+6Cr7Vc2TO+bF8vJb5j7OGKHDdr+jR7QDmuQ5LXov7gRHSP8pE8WdbxEaf2/0wvQQfUiMMEUQdm0+BbLFE6u53izAPqCmpdX7sow892LJKyqoAdH4inbHUtPoIXV/EzoSgdBGEF/nMdNsO1CLcVBNj93Rx8b26IJ5aTc374Ayh+4vAI/fYFWam/466+tfEUO2RR69dZPX4leYd2IdctunSAs1UdL7dmPRFt/TgPt4zCcXf2mM4acJNOD3wt2Cb/+/dhZE7UYnz2+vHaKWvr2HCiQbOpU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(40460700003)(6916009)(70206006)(70586007)(4326008)(36756003)(2906002)(7416002)(86362001)(81166007)(82740400003)(356005)(41300700001)(5660300002)(82310400005)(8676002)(8936002)(316002)(478600001)(40480700001)(54906003)(1076003)(26005)(336012)(426003)(36860700001)(2616005)(186003)(16526019)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:30:25.8335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d665472e-6b3b-468e-69a0-08db3c44c4bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E637.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 processors map cluster to the L2 cache. Add documentation stating
the same, and provide more information on the values and API related to
CPU clusters exposed by the kernel.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
o v1->v2
  - Reworded the definition of cluster on x86 based on Peter's
    suggestion.
  - Fixed double spacing before and after the cluster section.
---
 Documentation/x86/topology.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 7f58010ea86a..5dae8a0327d1 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -33,6 +33,7 @@ historical nature and should be cleaned up.
 The topology of a system is described in the units of:
 
     - packages
+    - cluster
     - cores
     - threads
 
@@ -90,6 +91,23 @@ Package-related topology information in the kernel:
         Cache. In general, it is a number identifying an LLC uniquely on the
         system.
 
+Clusters
+========
+A cluster consists of threads of one or more cores sharing the same L2 cache.
+
+Cluster-related topology information in the kernel:
+
+  - cluster_id:
+
+    A per-CPU variable containing:
+
+      - On Intel, the common upper bits of APIC ID of the list of CPUs sharing
+        the L2 Cache with lower bits set to 0.
+
+      - On AMD and Hygon, with Topology Extension, the common upper bits of the
+        Extended APIC ID of the list of CPUs sharing the L2 Cache, left shifted
+        to remove trailing 0s.
+
 Cores
 =====
 A core consists of 1 or more threads. It does not matter whether the threads
@@ -125,6 +143,11 @@ Thread-related topology information in the kernel:
 
     The number of online threads is also printed in /proc/cpuinfo "siblings."
 
+  - topology_cluster_cpumask():
+
+    The cpumask contains all online threads in the cluster to which a thread
+    belongs.
+
   - topology_sibling_cpumask():
 
     The cpumask contains all online threads in the core to which a thread
@@ -138,6 +161,10 @@ Thread-related topology information in the kernel:
 
     The physical package ID to which a thread belongs.
 
+  - topology_cluster_id();
+
+    The ID of the cluster to which a thread belongs.
+
   - topology_core_id();
 
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
-- 
2.34.1

