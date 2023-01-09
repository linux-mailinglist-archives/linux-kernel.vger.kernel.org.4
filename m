Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D438D662B98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjAIQpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjAIQok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:40 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BF5F43;
        Mon,  9 Jan 2023 08:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAs5rWx9sAJw8BWD7ieEKDWZjVghdaZaHMtSpU1n+FpFCQo1J5oXkazb/BcvNX1fxkMy+ZwP7UTd7JPTpWNz0HEXj9JXLpsH2knMPp7RSc8OKIbmaZ/lxoF2s6cCksptAzP/oyGM+5NFeJ0WjQGT5+sqKOJglz38SrQ3HQ7gouxlgmG9tV/BY6s96YN8spS11rA6Cvs7laYJUn44ZwJqiLKLnaJd9r/1Zq0rf6EJi66uN8B/G7aM50UGSm8etv6pYy+pMp5GXOQWGcgtqs3iMV3Jrt9aGB9u8XZe1dhAxnFHdu26oNPSucdZdSryx9A6EeN8hv3W8pGYBFkOaR57BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIKnkiU2VOmW02KhvidhhyVz/nE+t6wH0/fkqMzLIzg=;
 b=G+UO054fv5WjuwbGWAQg2qlkPVvOCFL/jZ99yIJ0Kwwvte51ajo2h8FYoG1pk/3zZ50NZvqccBOM1LN0BhNUxZgHPvL8V+K2TZ/IGIwpkRwKhSPufRhFGmbRrAuEQJnoLsIdYyDuOH/MBwiE0tyArtD+b/Ma9cFSD6mwPEgcAj7PddF4rf3AVXA3Cu1+cZ7PEgyPhWGGaG9nEK6t+TMdmbbi34VqaAUJ7P5jlPfqlRKcczVhfsUAnJAe4NGnPMZJr/Qe/1/UGsZqHrIu/r3Ang8YarS342mlqlZKLNVYy1sa0wixr0LBWoIZbMeX81mWcKwjZwQnFXyWEodA0uOSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIKnkiU2VOmW02KhvidhhyVz/nE+t6wH0/fkqMzLIzg=;
 b=XkiQxpvz8aySA+ztb/kSaCiHOK3rbx0IeGWRwTUec8kXFODSVAYT65g+nJsMOHFc5D3/Z5lnMFzbpsukKFiUQ8Cv8yKZx6f2+9UEPKYU2PXnXukOr0Kp30O2CG2nB8NV+BTWHOpCeT5mMEEcZWDl829jKxWVT3V5Q6MrvVhgrPo=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 16:44:35 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::31) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:32 -0600
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
Subject: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new features
Date:   Mon, 9 Jan 2023 10:44:05 -0600
Message-ID: <20230109164405.569714-14-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a8513e-81ba-4ce8-9b5e-08daf260ca78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKxCnwuo7TuZWk6EvooM212NrTDx/UUzRFFHIIFEyp4jLoW92jw0HDpBDJW3G2ZRQscwCifIaggYZ+0waDvglhL2+ZkTQplBJSRC05rRK2eYjsU3opKpPFZWOYjXdqFjeZHFjo2KPF59UUaq6o53wxr1ndedcMLt+jWTxg788dlZozLOXnvRrommomtn/tYNusWkDw9R4OtwNf25L4K+q7d/ixQNe5cO/8lP1+Jm0XMX1HGV8JIr3YCvfjTg93+GhFzdWe/Zdr3dqKtnz43IfNLqxGBhV9v2cYEprKwNqoCc5wOjH4JS+akhP/wZ44WTw19aUs2+xsAh3MupuBL9BmQWxlmkMd0Vy2MvtOw+u6ELpDIRMpgY40/F+2bvajkz9jutYy8Ox+Re4gz/82rA2BbPXI7GBTqwaG6KKwANxJkAqyc/BEf3kha21Mc30iIq/MfeI7yjqSpjZKdMBsiWjzPdk8vixC6KkSmXPDy32Pkqyfhbxcx7XkXsiiwwByPi3oj1RmMa1Zqny9MZLR8bmkLMIFuAuqt8LXd31DmUxaL5kDNnGL9jM/Fd7cfRfjDX5iJS2UiLkGg2ApR/D6JF46JfTnWUbsFG4kW+/tpnxf/OsgGwUOj8KEFWynUiyyhlnWPUHf8/Tx7cQQdUYCeTltotuTuAwb3fgeniaByW7+8tREK6W2iNxxIZAbqhIa2qmuJj2MtCttR4Qx7nvZK4cWzRXKwQnTPRc+z5xNzkiQ+zGEs0p3ULCZ89fqIv6e8QgmB5wJfEnFV+xpYT6WHLIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(426003)(41300700001)(110136005)(70206006)(2616005)(316002)(54906003)(8676002)(36756003)(4326008)(1076003)(336012)(70586007)(86362001)(82310400005)(36860700001)(356005)(81166007)(82740400003)(44832011)(40480700001)(8936002)(5660300002)(7406005)(83380400001)(7416002)(2906002)(15650500001)(16526019)(7696005)(186003)(26005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:35.3405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a8513e-81ba-4ce8-9b5e-08daf260ca78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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
 Documentation/x86/resctrl.rst | 142 +++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 71a531061e4e..2860856f4463 100644
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
 
@@ -161,6 +163,83 @@ with the following files:
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
+	all the CPUs in the domain. When either event configuration is
+	changed, the bandwidth counters for all RMIDs of both events
+	(mbm_total_bytes as well as mbm_local_bytes) are cleared for that
+	domain. The next read for every RMID will report "Unavailable"
+	and subsequent reads will report the valid value.
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
@@ -464,6 +543,25 @@ Memory bandwidth domain is L3 cache.
 
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
@@ -479,6 +577,46 @@ which you wish to change.  E.g.
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

