Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C40654962
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiLVXdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiLVXcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40830549;
        Thu, 22 Dec 2022 15:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHQUxiw9hWP9KIAxfGUywpqfgrgXDLylvYhSNaLsk1Vk9d1QUFpkmBcR+LnsIJCRZFgewZYa2gR/sCVxzx1VfZf4OwrAv4N3kjpD9g2R4S4wqAwewhU6UP0yfXkDMqOlZojjui/WeKX4TGeveeE5UWe5Xyj5BOSMD3iYBxbNAEqlZU0YJlLkRxtuVl2mVFRy2S3Xra8BJjLh1gDMyVivAnUtcKX1pGn/uGyz1KeP3EXCVx088yA19sePn6JVyMPfaAthDzaYiuCLg6kqoKuVZJ7DmCCAZjZ/f+FTF5e+RZ6khgj5ykc1gNElL/nJb8MkGiMl3zrrIB8FRMj0eRVAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hWTtXXSNLFNh8UrNSm0cr6JJMABy78HvmXcQT4GQDU=;
 b=TqDHBxUWv/jS+Mx9cSi/MeXKoBNcxLOam8sJ7lJ+7SPLwwJEmINaxhf0akJWbbgVf0bg7mf0aeA1coEikT7UYJzXzY94yiBW2tcDZNXTvuQFppDu0DJkcWSU0ZoYOb3/BwjjESSK+S5crLM9JEs0h0o2RirREjUVEEl9O4tjM6Y7wCVMUm2/bP7b+Ywh0MjML2lx+U/ewBtxDm+TSQePQIIFd+9lKU0j8qJWvBRAwCYrigkzQ+YMrAYQOMYO0kjE0Ies0/JP6ymC07FXl/6RTBDqiNBuHVwVmR2NcSQxs9Cc7ncz0KfLJJdhKPDaVUb6CAdJvhuhj4yUpgO0Xlqg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hWTtXXSNLFNh8UrNSm0cr6JJMABy78HvmXcQT4GQDU=;
 b=qKcksv9/gdj8wKs1uhICCL+JFSzvy8A2fpxHD7mn8fA4gU32W4xvSKoRVmoxJMKfrSuOdGrJ4D2UJBYarLqGtaRaqP27EsZ6W6pq6DlAGFJFm9Ek7vN1ruJbDmtWhHetrZ0zexB5yyABwL2Yo9IcSYh3nolUe5cUV2aFYYWZ3tc=
Received: from CY5PR19CA0098.namprd19.prod.outlook.com (2603:10b6:930:83::15)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:59 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:83:cafe::7f) by CY5PR19CA0098.outlook.office365.com
 (2603:10b6:930:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Thu, 22 Dec 2022 23:31:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:56 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v10 13/13] Documentation/x86: Update resctrl.rst for new features
Date:   Thu, 22 Dec 2022 17:31:27 -0600
Message-ID: <20221222233127.910538-14-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c1bacb-713e-473f-56f6-08dae474b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcW0P7QLApzOb7VX5m9ffGW/2c5fAjjSKXSnKBL1WhvAQilER+dXsfRn3/tlCP5qvOLG+wPanl9J8sq8mMRl76ngsPxGyR/Mgz0B0hZPlCJp49pRkydgkKMUC2lmwIvL1agc+ryvjGEFGubFw/cjzBJ06vZwtLRDvSXHpSzy7mJFR6GL5BxudgMrBAzgNF9n7xmE+QPDQR5xVtrk8ufytFAcm8VYWsrRt+THKte4ZRPdKhUbQKRZZI5z6QfjCetxK3egTmSr/dX7HlDzC703zks9dGuSAadTyh0pfllGzvM0KciF24e586xYauazChQt0gcBFYTC6eTcybDBQleRAU8aqSNe8i/XNBFOiY8sqCgVVaI1kBY3jxlVMAg8e3UcLjFQlBTAWt6IC4wcqtPJ6Ea34LvUhOGJZgz1YU7gyby7ujyjNZHXR2o0AzpYqOzoHHJJhhCN8n4vvwFdApXpGW5mLhGIw5qMGmyYfvQLGrBywDus7ObHbcSpdzTo/Ek08Dg3ToaNmmNFloxCT/fOkEHvzP06+gyQqwYPqI+jIZkDcLovuU+zpCriGp+g+xroGPuYVr5cFT3+G9i9rUBtFu5YU5av/ozWms2N/bk/RW1a6h6rZRa0B2USOtRgByC+v7Mu3uW/7/RR4pvsbKIKdBzY6daURQBmIimiU7Zw42ihatYid4y/OrBcvn4XYNgUnh3EdzLdJfjf/5VgSgq6+FMfcVdzhTI+k0CVhvxQMMQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(110136005)(336012)(86362001)(316002)(83380400001)(40460700003)(478600001)(54906003)(356005)(36756003)(40480700001)(47076005)(426003)(2616005)(16526019)(1076003)(7696005)(186003)(82740400003)(81166007)(26005)(82310400005)(2906002)(15650500001)(7406005)(6666004)(41300700001)(70586007)(8936002)(44832011)(70206006)(4326008)(5660300002)(36860700001)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:58.5061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c1bacb-713e-473f-56f6-08dae474b853
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation for the new features:
1. Slow Memory Bandwidth allocation (SMBA).
   With this feature, the QOS  enforcement policies can be applied
   to the external slow memory connected to the host. QOS enforcement
   is accomplished by assigning a Class Of Service (COS) to a processor
   and specifying allocations or limits for that COS for each resource
   to be allocated.

2. Bandwidth Monitoring Event Configuration (BMEC).
   The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
   are set to count all the total and local reads/writes respectively.
   With the introduction of slow memory, the two counters are not
   enough to count all the different types of memory events. With the
   feature BMEC, the users have the option to configure mbm_total_bytes
   and mbm_local_bytes to count the specific type of events.

Also add configuration instructions with examples.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/x86/resctrl.rst | 141 +++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 71a531061e4e..bea6cab06873 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 
-=============================================	================================
+===============================================	================================
 RDT (Resource Director Technology) Allocation	"rdt_a"
 CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
 CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
 CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
 MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
-=============================================	================================
+SMBA (Slow Memory Bandwidth Allocation)         "smba"
+BMEC (Bandwidth Monitoring Event Configuration) "bmec"
+===============================================	================================
 
 To use the feature mount the file system::
 
@@ -161,6 +163,82 @@ with the following files:
 "mon_features":
 		Lists the monitoring events if
 		monitoring is enabled for the resource.
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_local_bytes
+
+		If the system supports Bandwidth Monitoring Event
+		Configuration (BMEC), then the bandwidth events will
+		be configurable. The output will be::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_total_bytes_config
+			mbm_local_bytes
+			mbm_local_bytes_config
+
+"mbm_total_bytes_config", "mbm_local_bytes_config":
+	Read/write files containing the configuration for the mbm_total_bytes
+	and mbm_local_bytes events, respectively, when the Bandwidth
+	Monitoring Event Configuration (BMEC) feature is supported.
+	The event configuration settings are domain specific and affect
+	all the CPUs in the domain. When an event configuration is changed,
+	the bandwidth counters for all the RMIDs and the events will be
+	cleared for that domain. The next read for every RMID will report
+	"Unavailable" and subsequent reads will report the valid value.
+
+	Following are the types of events supported:
+
+	====    ========================================================
+	Bits    Description
+	====    ========================================================
+	6       Dirty Victims from the QOS domain to all types of memory
+	5       Reads to slow memory in the non-local NUMA domain
+	4       Reads to slow memory in the local NUMA domain
+	3       Non-temporal writes to non-local NUMA domain
+	2       Non-temporal writes to local NUMA domain
+	1       Reads to memory in the non-local NUMA domain
+	0       Reads to memory in the local NUMA domain
+	====    ========================================================
+
+	By default, the mbm_total_bytes configuration is set to 0x7f to count
+	all the event types and the mbm_local_bytes configuration is set to
+	0x15 to count all the local memory events.
+
+	Examples:
+
+	* To view the current configuration::
+	  ::
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=0x7f;1=0x7f;2=0x7f;3=0x7f
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=0x15;1=0x15;3=0x15;4=0x15
+
+	* To change the mbm_total_bytes to count only reads on domain 0,
+	  the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
+	  (in hexadecimal 0x33):
+	  ::
+
+	    # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=0x33;1=0x7f;2=0x7f;3=0x7f
+
+	* To change the mbm_local_bytes to count all the slow memory reads on
+	  domain 0 and 1, the bits 4 and 5 needs to be set, which is 110000b
+	  in binary (in hexadecimal 0x30):
+	  ::
+
+	    # echo  "0=0x30;1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=0x30;1=0x30;3=0x15;4=0x15
 
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
@@ -464,6 +542,25 @@ Memory bandwidth domain is L3 cache.
 
 	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
 
+Slow Memory Bandwidth Allocation (SMBA)
+---------------------------------------
+AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).
+CXL.memory is the only supported "slow" memory device. With the
+support of SMBA, the hardware enables bandwidth allocation on
+the slow memory devices. If there are multiple such devices in
+the system, the throttling logic groups all the slow sources
+together and applies the limit on them as a whole.
+
+The presence of SMBA (with CXL.memory) is independent of slow memory
+devices presence. If there are no such devices on the system, then
+configuring SMBA will have no impact on the performance of the system.
+
+The bandwidth domain for slow memory is L3 cache. Its schemata file
+is formatted as:
+::
+
+	SMBA:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
+
 Reading/writing the schemata file
 ---------------------------------
 Reading the schemata file will show the state of all resources
@@ -479,6 +576,46 @@ which you wish to change.  E.g.
   L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
   L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
 
+Reading/writing the schemata file (on AMD systems)
+--------------------------------------------------
+Reading the schemata file will show the current bandwidth limit on all
+domains. The allocated resources are in multiples of one eighth GB/s.
+When writing to the file, you need to specify what cache id you wish to
+configure the bandwidth limit.
+
+For example, to allocate 2GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    MB:0=2048;1=2048;2=2048;3=2048
+    L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+  # echo "MB:1=16" > schemata
+  # cat schemata
+    MB:0=2048;1=  16;2=2048;3=2048
+    L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+Reading/writing the schemata file (on AMD systems) with SMBA feature
+--------------------------------------------------------------------
+Reading and writing the schemata file is the same as without SMBA in
+above section.
+
+For example, to allocate 8GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    SMBA:0=2048;1=2048;2=2048;3=2048
+      MB:0=2048;1=2048;2=2048;3=2048
+      L3:0=ffff;1=ffff;2=ffff;3=ffff
+
+  # echo "SMBA:1=64" > schemata
+  # cat schemata
+    SMBA:0=2048;1=  64;2=2048;3=2048
+      MB:0=2048;1=2048;2=2048;3=2048
+      L3:0=ffff;1=ffff;2=ffff;3=ffff
+
 Cache Pseudo-Locking
 ====================
 CAT enables a user to specify the amount of cache space that an
-- 
2.34.1

