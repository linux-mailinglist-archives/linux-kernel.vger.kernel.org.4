Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086F16E1AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNDSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNDSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:18:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6712D40;
        Thu, 13 Apr 2023 20:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huVbV0zw7FUJAzgPl8jc82/AXUOSU1Zw53z4xM4RMt6yRxuMgSiTkrSaUKmRLSK9BwEXTG7vxDel00jOVQbam1WfKRh4Aa3u1CpiOFzJ+NuYz3tDprSL3X5OQEJBrdMHSqWbZlLCkRe3CZtb/XTMtjEgLZVJtLIN4IxYaVY28bgdF6h6BYNY1fAifQx1oUDvScUznRLgpPqnFvQaW7toMJ1iEmDA4HPuwJPo0gwivynkcdIhy8BIUDTruixcnwvyBQsPSsTB4uX4gIr6QIA9Bf4pEVhhCbAZyT87wY/9obz0/fXBXP19QlFgFf2IYGePXxSNKedClYxTu6euUX28+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukHFr/Cf0CqMPD6Pu7nmWReon2YQpMPQj1LlU5zw4fE=;
 b=BHDSWmnRyurwfcIPqQjhDIHOk878W5mbYpPp6n5/n81z5bVIdgmwe9zXuNmvwKa9VNqAy951/393DJAN1sCkzjZ6vgwTcdd9sWUytd0ahGsR04BUiZOy3ls7S8K/qncvbktf20JFXPsfyyLLjjgNXKVUaHb0J6RJ6ef0CnCz1ei113BU6WeKbxgSW+Cat6PsrwLHqed9zuImj8nivNMDdy+CYCX4XFp9tsl57NksPMRDIh1CRNlCc8BKK2kT63H5rEgAhn2oLV1eEYwjv6S0xVkbZEtHdxs5LjgeNJu0X9KLwVxEleX5w1z9spoGKXaMFxkVMRgYAL6sHcKQTtwPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukHFr/Cf0CqMPD6Pu7nmWReon2YQpMPQj1LlU5zw4fE=;
 b=SBKEwcaTf6QSsHG0wesVGPe0PKA65CcMVgQ4NsxdlLJvdkRf/phxXZWxGCK9NNdZPV+9TEbbCipWh6/a22LbeI3Z6Ar/dMIm4Osc0MtE/w1naR9boOeoJp0w9xkfHQ5PKOuJKWKrBqyzoI8gT0LR2ewfYM3S5Gdsm/mUSocKcus=
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 03:18:02 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::25) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7 via Frontend
 Transport; Fri, 14 Apr 2023 03:18:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 03:18:02 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 22:17:56 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>, <oleksandr@natalenko.name>,
        <bagasdotme@gmail.com>
Subject: [PATCH v2.1 2/2] x86/Documentation: Add documentation about cluster
Date:   Fri, 14 Apr 2023 08:47:43 +0530
Message-ID: <20230414031743.875-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413172918.1500-3-kprateek.nayak@amd.com>
References: <20230413172918.1500-3-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 53753226-852a-42c4-8af8-08db3c96db2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJyVKoAzQoRtmE7ZIReXP4qZfPwJELOUOuRrUJes5ZYm2w9sBPObAWFtx7kGSVhUrjj0TjUM1phneMDFB3nmMRzwt5I9RWI4zqrqFzASS07G6q103gq60rJ1D3Vl5nld4vhmppmMCwZnb0yRCedk0JzneVveS2xdtpxoewDEuLkhmEDh30KlDhQPH3BypYmfy4J24g5cafIuobn3MMN/DbP91AOm9t4up1KiM2jMnZgiZdnrRExx0OERxQXT3my7U9QQDgDGDROxmd0ecFZX+HtoHXy59b17F0RTHrt5Rlg1lVlsLh6B/B8E1lfhWNadEHRlU9qa3msPV1b7HmmnI5xEqvOlgEXp63RPwLppgjRMvOQosbeqF3ofpbv2aEZfhZuVliFsxNJAwJJF4/NFwJTiSiSSp8IRSTcwJAStfiRcep94oO2s5LL+GLEpsffcAxQFxjgMJn3SI5MQs64nZ2oQFHJM4/cpg571Gu0o600dX1zC9lj9Gq4Y7MnstgvgtrshQcsH3RPZhMWjamOflRHXuLL8XJr+SRy6nSVuELdE1ZkpTzQPRaK8TO8j+8DHsziLFg5rBwMdUFxKz5+dlpXSFZcjVSorXxBj4jNxygN6sCc847QC+RtmRZiEhZ0Y8wRqju4aqOKDHSUq9C8U+siQ9i3iOvVGMygneybH7OVotXyeormNChHd5B1glGarlV/3IgZLC9JDMed3D6lWqj0OoXLBzwSsgzfxy2z8mi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(316002)(41300700001)(81166007)(26005)(1076003)(7696005)(16526019)(86362001)(356005)(47076005)(6916009)(2616005)(36860700001)(82310400005)(426003)(83380400001)(82740400003)(336012)(36756003)(4326008)(186003)(54906003)(40480700001)(70586007)(70206006)(8676002)(8936002)(5660300002)(2906002)(6666004)(7416002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 03:18:02.2347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53753226-852a-42c4-8af8-08db3c96db2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 processors map cluster to the L2 cache. Add documentation stating
the same, and provide more information on the values and API related to
CPU clusters exposed by the kernel.

Suggested-by: Dave Hansen <dave.hansen@intel.com> # cluster_id description
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
o v2->v2.1
  - Reword the cluster_id description based on Dave's suggestions.
o v1->v2
  - Reworded the definition of cluster on x86 based on Peter's
    suggestion.
  - Fixed double spacing before and after the cluster section.
---
 Documentation/x86/topology.rst | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 7f58010ea86a..9de14f3f7783 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -33,6 +33,7 @@ historical nature and should be cleaned up.
 The topology of a system is described in the units of:
 
     - packages
+    - cluster
     - cores
     - threads
 
@@ -90,6 +91,22 @@ Package-related topology information in the kernel:
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
+      - Upper bits extracted from the APIC ID.  CPUs which have the same value
+        in these bits share an L2 and have the same cluster_id.
+
+        CPUs for which cluster information is unavailable will show 65535
+        (BAD_APICID) as the cluster_id.
+
 Cores
 =====
 A core consists of 1 or more threads. It does not matter whether the threads
@@ -125,6 +142,11 @@ Thread-related topology information in the kernel:
 
     The number of online threads is also printed in /proc/cpuinfo "siblings."
 
+  - topology_cluster_cpumask():
+
+    The cpumask contains all online threads in the cluster to which a thread
+    belongs.
+
   - topology_sibling_cpumask():
 
     The cpumask contains all online threads in the core to which a thread
@@ -138,6 +160,10 @@ Thread-related topology information in the kernel:
 
     The physical package ID to which a thread belongs.
 
+  - topology_cluster_id();
+
+    The ID of the cluster to which a thread belongs.
+
   - topology_core_id();
 
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
-- 
2.34.1

