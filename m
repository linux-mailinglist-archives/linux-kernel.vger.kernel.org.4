Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC15669CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjAMPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAMPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:50:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8D81C11;
        Fri, 13 Jan 2023 07:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqoRzXjETP+tWmKvD4Zu/im6Wc14rtcIgr0O6gWczY6riIWpgB3I1o8DSBj5TfnuTjXYpTZp4a9YdteOQMmnluy7de5ipVzYiV5+gKYxYQWSontV17Pxjw+icLBbzsELYwl0kCCxwUCXx50Zd4cB7qGO/Q2ikz9ebLCj7ZsIo7PoMc35swPE2CqNr9t8N/DxV2imyn+qKUlXArim5ffHHdcUBndP5wHGgRolN/q6hyLuFCtQ7E+0wkfa/IEo52gYyOF0H4vRsEiZGqlpilswlzu6fLZkwr8w/4RiGxhf53MD2CcxXo09yX1QjhHHCz10CqBGpF6y6HKx3VEK8GAZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrIq7l2IxWft6eeo6eLD5zZHhkdsQHF/JdoqUmitJnI=;
 b=QO2uphSRX3RKGES9j796OUqDYJowiVXXVMSM/g97AnId6pERuVuFFnuNVrIhDEfkbadGf9Yeu0x7nPfTZEhJWc9l8m4cCfyh71yFsKyZRzf/Bde7nPm4ktHBj6VyaZ0cQmkbdWAPd9GPASzYZfN/i4ZqzgLuglgEkMr14QlOEGAi9/0maxK//ZeXXaDUByhNDZZPJV4IzZ1pbQq+6Cbn51+gm5aA+M9wlTGbvTJeCjiJ/bDl19lgegbGzDDbfIpBSpE3Qw3GUg0AusqzrRc6fdFp4MPIOghDRpPNfVeaSvBDaUg9+ajwQNVjAeYIhmqBWD7SVwuu58DDAuasYVcoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrIq7l2IxWft6eeo6eLD5zZHhkdsQHF/JdoqUmitJnI=;
 b=28OBaT1XvMTHTI36dSjSJYrdJw+bWbZcNl0QfwM0i3GxzWlKblOiVGB+mtb4q2GHGnErfjxFek6KlPcqPEnA0hVFROJzQAkleivpkr8GTJ3P6AzM3hV9rnDlozWvYbhySH4e/mg30/nYGgkQb7W2jc2JzfjnumWP6VPrW2ogE3E=
Received: from BN9PR03CA0341.namprd03.prod.outlook.com (2603:10b6:408:f6::16)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:42:58 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::e1) by BN9PR03CA0341.outlook.office365.com
 (2603:10b6:408:f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:57 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:16 -0600
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
Subject: [PATCH v12 13/13] Documentation/x86: Update resctrl.rst for new features
Date:   Fri, 13 Jan 2023 09:20:39 -0600
Message-ID: <20230113152039.770054-14-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8ab288-662c-4871-7c0d-08daf57cd812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnOJglZ3aDf5YXTzUVkZ9ZI2Fu9rj2/pHgCI/s4yEpllFP2FWvX6CCrk+D6mkp/pI3oshaDbfd/Oo5gE62JLnbm3UTZqz+CHYKdsbgDO+6nLVBeDYXs4XDOayhfpeC8upM7EWpKBpcVd5A4TWmHriPWe7Q+xqYViBe3999XX7ekszThW69vWG4vLuBVCz8pC1jQ+/bB9id+OJEa8MW2/N/SW//iOKIM/C2Id/uK07lt8EJ1gBRYPdum80EusbFI6WLKbRnz1RpAofUbmooQsvEhde9VSSOUhQhdw7Q892TbSBNykIlHMHw67txtFfaJgjIrqmS/ZSELKGfOCw8DytornIM2OEzsTlGljBI4k7Y1JiXlhHfzjkzPOSXSxsXLKEMpYIiLQpNUjlzGF0nVOGbq22oRWEmKW2W878IRKQdA5oOhza8vSGMrYLjX8DYevjEOvB9xoiEKwqBgmqNmTP3/WZ4PnZm9BgpL8fZcURPpwhBqSWJDkOKklNyVXrLwM9fW/bx7uG1bZRvj5sfq0dalX6esboVXUpffyPRj7lTYRz+cy1gb3kBzXcTq230Jzq+ca9nhnniAxsC24NCYciWSIB8cetEB00hbqmbQpFUZy9Wg0MgyoEqvTy9x4UnRvBFzuEBeyxMg9JNS/YM+6yKs3dcT9F146bx6wJ17ll7dE/5yyR5JSYUWPcrTSHWZJjqUpzTtPHJtxPJlMmtt2q70yBoJub4BjHCaPilPV/m4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(7696005)(6666004)(186003)(8676002)(70206006)(336012)(70586007)(16526019)(478600001)(26005)(4326008)(47076005)(426003)(83380400001)(41300700001)(8936002)(5660300002)(7416002)(7406005)(2906002)(44832011)(15650500001)(82740400003)(36860700001)(36756003)(356005)(40480700001)(82310400005)(81166007)(2616005)(54906003)(316002)(1076003)(110136005)(86362001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:57.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8ab288-662c-4871-7c0d-08daf57cd812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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
 Documentation/x86/resctrl.rst | 147 +++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index 71a531061e4e..058257dc56c8 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -17,14 +17,21 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
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
+SMBA (Slow Memory Bandwidth Allocation)         ""
+BMEC (Bandwidth Monitoring Event Configuration) ""
+===============================================	================================
+
+Historically, new features were made visible by default in /proc/cpuinfo. This
+resulted in the feature flags becoming hard to parse by humans. Adding a new
+flag to /proc/cpuinfo should be avoided if user space can obtain information
+about the feature from resctrl's info directory.
 
 To use the feature mount the file system::
 
@@ -161,6 +168,83 @@ with the following files:
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
@@ -464,6 +548,25 @@ Memory bandwidth domain is L3 cache.
 
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
@@ -479,6 +582,46 @@ which you wish to change.  E.g.
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

