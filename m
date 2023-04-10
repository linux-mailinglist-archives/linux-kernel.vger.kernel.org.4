Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA826DC965
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDJQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDJQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:37:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9EBE60;
        Mon, 10 Apr 2023 09:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvraCz8ZZykT849xtZKFd1kPaxTq7wJiAMp9aPwhHBQ+e0kiDZnnTnSxWzJFr2DieayKwmYr31eTVC22xB/L2cHI88DTIw2aCg0mopiCT9fx1oYEkGbruJEPKpbx48dfY5JlZAUvNDWy8rlsJzjMbR3BxI8IWoiss7QRPF8O+xpkG2AgdzgoXC6WwnLADnFWw9imDzEtLF0iDeAZ3mP/1LuuiK7bR0/ax1nSF+hKU3l3uUkDvh0HPCZ2xLE0Sjvp6dsKKHaxQ/GkE/uw2BEUZeXm+jhIA9sU7OaEOnNg/7eAprKvHufN9SxN1AZrgmXImD9Ln21kob17qsOV59LbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYoWYuUZ+zF28wei/newECWVkOtei2JG5XmFivjD4hM=;
 b=MpB8NTA2XpVRoC1P/m6Pi6EhiSnRkHF3JJ2UMejneHeKJ46PaDsJQhUMQXVdEguI/uZu8iT6v3PpWEkFBwWVNGcSIzaSEhgiz1XZVctJbzxawlZMqFFC0rKseOdLbeSjRuDy3nw7fNvSuY3BKWrbYqFh7ZWMoA72dJdbpVBQhHuPpjWNvwEIS4IV7NiiPHYwU3rBSXtrGs90wANgEdYM1tC9mw9zzsyyekCUXVQdx7OtSdpHYTOnhbpfNySusiuolSWsD/PhqY9cX6hn9jXI6XDl7aH8nIYVoE1qHNxHeAzeLRxQWFTQ5Ggeen7qqUx05i0Npo7KxQDROEsPlbNdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYoWYuUZ+zF28wei/newECWVkOtei2JG5XmFivjD4hM=;
 b=RIhRdFfv7ysfAuhokrfVjXV474sikRi/xeSJJVFn0gP2UIag4IxuWdGWZr0l57waONzRLZiPu2KHWKz2XJ7j+4JAX12Y9TL7Ls6RnaQ0wz72hYICcre+90/xKlLWHrlwZbFZavtfPlBswjEZU58mUS2UKNu0C4x4/adjA6obAs4=
Received: from BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Mon, 10 Apr
 2023 16:37:39 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::3c) by BN8PR07CA0021.outlook.office365.com
 (2603:10b6:408:ac::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 16:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 16:37:38 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 11:37:32 -0500
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <corbet@lwn.net>,
        <jgross@suse.com>, <andrew.cooper3@citrix.com>,
        <peterz@infradead.org>, <Jason@zx2c4.com>,
        <thomas.lendacky@amd.com>, <puwen@hygon.cn>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] x86/Documentation: Add documentation about cluster
Date:   Mon, 10 Apr 2023 22:05:27 +0530
Message-ID: <20230410163527.1626-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410163527.1626-1-kprateek.nayak@amd.com>
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 752b6f07-1f71-4ec2-bc29-08db39e1e5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kBW/jmCZYVj7vBsnRt5XMVpgrOlrGkISqOStUnYLEtr04/rdNR/rRTU7rOa2OZvs0zdgIRONwc9uj/KD6lzIM5jiKY93C5HdnVgBWiS9T3gAjZJnGB5hzywL8yuwEM8Rj3OFMtRg2ca96RbCd0dKTpfpipIlXfH7fTNWDIYZ0ZBCJp+T56OwrzOfLT3UF5ycGp/CtATDF401P8r5wsAK0wFTHmNLkCwqQlE3zKk0otIJxhs32B9EmZ4itSoz5EHjlSF0mcPYP5xJiTCm01iEGFOGA2Iv+ftAZ56/pxsJ4/QaM6ZTembQoan27syDAnUiydO/J5nXnRQXQ9vZADXtEC1CIJTFfJMLbQkOk7vJf0HdGPBIwzUi/aLqDTiJG/q0kOOoo8nzd2ESVjvAC0soayfEAaDItlsebbFDX3LXJ1s46rZU+QAFNjjwCgM5MCkWIxo7xM3y0se1c7VLTY9zmnuJ/8mxtD7zc9vSBOq3ejj/ADnavdO4Q0mQURnBy3zaU1JRGolpvnUwxcJN9+v1lpQ26NAArJDsiV/kL6eFK6JLPICFsooiNbzHXMoWaUdvqHc0yy5qAb0doY2fvbFT9xG942XWC3wAjNihl3tiCqd1S3qaxdVdcC7O8NFP9Ll4oADsORC7sEwp0mJq7vOjhYaiL6cIsB0jg9umbINeilL58v6cLv4Jut3fPSmwFAHFnPkBSWVM1egedNLLlPNIF07Yju9/wNtODRo4I7Lupc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36860700001)(82740400003)(356005)(81166007)(82310400005)(36756003)(86362001)(40460700003)(8936002)(7696005)(40480700001)(6666004)(7416002)(478600001)(5660300002)(4326008)(316002)(16526019)(336012)(26005)(1076003)(186003)(2616005)(426003)(2906002)(70206006)(70586007)(54906003)(8676002)(41300700001)(6916009)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:37:38.8871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752b6f07-1f71-4ec2-bc29-08db39e1e5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 Documentation/x86/topology.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 7f58010ea86a..35991d8cdef1 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -33,6 +33,7 @@ historical nature and should be cleaned up.
 The topology of a system is described in the units of:
 
     - packages
+    - cluster
     - cores
     - threads
 
@@ -90,6 +91,27 @@ Package-related topology information in the kernel:
         Cache. In general, it is a number identifying an LLC uniquely on the
         system.
 
+
+Clusters
+========
+A cluster consists of 1 or more threads. It does not matter whether the threads
+are SMT- or CMT-type threads. All the threads of a cluster share the same L2
+cache.
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
+      - On AMD, with Topology Extension, the common upper bits of the Extended
+        APIC ID of the list of CPUs sharing the L2 Cache, left shifted to
+        remove trailing 0s.
+
+
 Cores
 =====
 A core consists of 1 or more threads. It does not matter whether the threads
@@ -125,6 +147,11 @@ Thread-related topology information in the kernel:
 
     The number of online threads is also printed in /proc/cpuinfo "siblings."
 
+  - topology_cluster_cpumask():
+
+    The cpumask contains all online threads in the cluster to which a thread
+    belongs.
+
   - topology_sibling_cpumask():
 
     The cpumask contains all online threads in the core to which a thread
@@ -138,6 +165,10 @@ Thread-related topology information in the kernel:
 
     The physical package ID to which a thread belongs.
 
+  - topology_cluster_id();
+
+    The ID of the cluster to which a thread belongs.
+
   - topology_core_id();
 
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
-- 
2.34.1

