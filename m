Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915A63F436
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiLAPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiLAPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:38:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E0578C9;
        Thu,  1 Dec 2022 07:37:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZBf+xyCtW7vwtvbyaMNbMr1tnpyUqT1GgpSef27kANEUE6qXEUnN2l/mbAHdPesaFnkPybZj/fEDbitApfjG9rACxk4as7KFLvQpcb7BNZb1S2Wy2FA4kM2EyM5KycunfNzQGIcPX/xvhZY7k2wmT+HoNssIaSxfw9UNt2A44V61WXdEpprfJ6K8i9pRZzJAeZ7n6k5RRhJK5qChRMpY3O8sXVskZ4IXWLXhNe1N4tyntzKdMlyJEPtqVT2OpD3s4s3OpxuepXmy/o4DwmyafaCihJhmiFxcc7XDS+1aDh3ijasCSsYBujn385RCPy6gB2m/fuaNLEHItw2F8KzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzKlud3bsUwIY4ugncGjqWJsmEy3IPiYuI+nDgn9TSk=;
 b=HHv6Am1re6hT1isUdzawbIbYFpxK2npKDnr4Lv8LB76b8edfoj6G5a3OPH1weVyoYs4euFFJUwi54LW90EuwRLmCOxTdEZfNewQHPIzLaWew07I51rpG7W9SWyIQKvrq5nIdCent10UUf5X0w7LvNqLdv3+Y1BZakd+ej8k8VOK3kKghD7B9SXqhjaWCsdVouwzFd5qJjAGYKphm+zZLeKnN/+Glm4l3IqjfDP4wZDPCqgIGJCWN8qxRjI4Oe1Lz3hQGvTMSw+J7LYvqVx6BAcuswMnUs+FcBwB6OB0te3AM2QfzzeuWkv4fzjz7t1SEAKO0Pu3/CDV0ekxbVgdSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzKlud3bsUwIY4ugncGjqWJsmEy3IPiYuI+nDgn9TSk=;
 b=0QmLHVwgZFwsdyuDWeWQ+JHWThMSQLwApvD0DPH5HPM5Jof8zyEcyj3I1QaZm0xKjlI4N9R+Yp4CotJxgF7JEIFypyK7XhVazjVK+VwRIYYHFWuXCHY3i/kIFwp6TIjWOe9mAerSs5FQZ49HhwR/SFULtq3WuJyo8ZhxD/PDGVQ=
Received: from MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:37:43 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::a4) by MW2PR2101CA0002.outlook.office365.com
 (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:37:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:37:37 -0600
Subject: [PATCH v9 13/13] Documentation/x86: Update resctrl.rst for new
 features
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
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:37:36 -0600
Message-ID: <166990905693.17806.6942517971262471285.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|MW3PR12MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: a5582ca0-ef3f-4c4d-38f7-08dad3b1fcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdF77W0x5g51NYZJm9cNuo2ohKUrNUYINQmIydRM2VOz6N0cDav+snFW6QLyTGAFaM2a+UazUkAMF7vkf2BbThtM2iAPDDilC8zkyWtW6HqBJATv8X0BXzJhpTIFH5n46ASky9DJ/SE1agnLV/YYQu+mlxWXc+2rIibTiRALQHfJt6WOky75VzPJ3RCnZ+rYknsaj9YdtOeWCfBm08MCrknEn7evzzUI70CIwI6Ec5MpLZva+SW0h+QjwI3Y/eg569D1ErqW/2zRNkqvHrwXhc5uzkVoK1dMPe+1o8YDzehZNd9nFdqJUX6v/wp45zSVu1aTmD94ZdHNjGdHjc2oxKoqvHTRwStS1UVXg6SpV8JUUmUASWdjQMvBMVqWfVe/zK1ofkzTWAaauHu3f8wmCNyiSr+7fDXpPb2FHws0TyBVGEhQHp6sxrDE4kCB3yV0sgR6UB3jlB8YjHp4GkWcp8P7KCUpCZ4Fn7aZ+CA6iUaABrzHZp2QqqKYb2rHcINc3Ci4bkZmLSqpsk1R2x5pv3Iwz8NucH+NBOkwmVT3bhRo46vR59cY5aHyZ5kMM3cVQUzELNaIa1Lk3To3Xl+CRnUeZ03lhrNuUbJ/T4tiO868zbPp3rLCrSwtFZS2uCmva8yS7B9SOXRhCvSSUQqljP0TtZteI+efSdkgBWhdlBJQZfpHSs9xMDrjkkH3E1gjMhOJRSqOvvv7Y47E2E7zlG863C+Iv/59WRE9y5h90TLr4oBq1QkyWLIDvusFZpIq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(86362001)(356005)(103116003)(54906003)(40460700003)(110136005)(316002)(16576012)(5660300002)(33716001)(15650500001)(7406005)(44832011)(70586007)(8676002)(70206006)(7416002)(4326008)(478600001)(41300700001)(8936002)(36860700001)(83380400001)(82740400003)(9686003)(47076005)(2906002)(26005)(186003)(82310400005)(426003)(16526019)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:37:42.6863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5582ca0-ef3f-4c4d-38f7-08dad3b1fcb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation for the new features:=0A=
1. Slow Memory Bandwidth allocation (SMBA).=0A=
   With this feature, the QOS  enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC).=0A=
   The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes=0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not=0A=
   enough to count all the different types of memory events. With the=0A=
   feature BMEC, the users have the option to configure mbm_total_bytes=0A=
   and mbm_local_bytes to count the specific type of events.=0A=
=0A=
Also add configuration instructions with examples.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst |  138 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 136 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..60761a6f9087 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of S=
ervice(AMD QoS).=0A=
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cp=
uinfo=0A=
 flag bits:=0A=
 =0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 RDT (Resource Director Technology) Allocation	"rdt_a"=0A=
 CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"=0A=
 CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"=0A=
 CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"=0A=
 MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"=0A=
 MBA (Memory Bandwidth Allocation)		"mba"=0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+SMBA (Slow Memory Bandwidth Allocation)         "smba"=0A=
+BMEC (Bandwidth Monitoring Event Configuration) "bmec"=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 To use the feature mount the file system::=0A=
 =0A=
@@ -161,6 +163,79 @@ with the following files:=0A=
 "mon_features":=0A=
 		Lists the monitoring events if=0A=
 		monitoring is enabled for the resource.=0A=
+                Example::=0A=
+=0A=
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                   llc_occupancy=0A=
+                   mbm_total_bytes=0A=
+                   mbm_local_bytes=0A=
+=0A=
+                If the system supports Bandwidth Monitoring Event=0A=
+                Configuration (BMEC), then the bandwidth events will=0A=
+                be configurable. The output will be::=0A=
+=0A=
+                   # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                   llc_occupancy=0A=
+                   mbm_total_bytes=0A=
+                   mbm_total_bytes_config=0A=
+                   mbm_local_bytes=0A=
+                   mbm_local_bytes_config=0A=
+=0A=
+"mbm_total_bytes_config", "mbm_local_bytes_config":=0A=
+        These files contain the current event configuration for the events=
=0A=
+        mbm_total_bytes and mbm_local_bytes, respectively, when the=0A=
+        Bandwidth Monitoring Event Configuration (BMEC) feature is support=
ed.=0A=
+        The event configuration settings are domain specific and will affe=
ct=0A=
+        all the CPUs in the domain.=0A=
+=0A=
+        Following are the types of events supported:=0A=
+=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        Bits    Description=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        6       Dirty Victims from the QOS domain to all types of memory=
=0A=
+        5       Reads to slow memory in the non-local NUMA domain=0A=
+        4       Reads to slow memory in the local NUMA domain=0A=
+        3       Non-temporal writes to non-local NUMA domain=0A=
+        2       Non-temporal writes to local NUMA domain=0A=
+        1       Reads to memory in the non-local NUMA domain=0A=
+        0       Reads to memory in the local NUMA domain=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+        By default, the mbm_total_bytes configuration is set to 0x7f to co=
unt=0A=
+        all the event types and the mbm_local_bytes configuration is set t=
o=0A=
+        0x15 to count all the local memory events.=0A=
+=0A=
+        Examples:=0A=
+=0A=
+        * To view the current configuration::=0A=
+          ::=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
+            0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
+            0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15=0A=
+=0A=
+        * To change the mbm_total_bytes to count only reads on domain 0,=
=0A=
+          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in bina=
ry=0A=
+          (in hexadecimal 0x33):=0A=
+          ::=0A=
+=0A=
+            # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_byt=
es_config=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
+            0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+        * To change the mbm_local_bytes to count all the slow memory reads=
 on=0A=
+          domain 0 and 1, the bits 4 and 5 needs to be set, which is 11000=
0b=0A=
+          in binary (in hexadecimal 0x30):=0A=
+          ::=0A=
+=0A=
+            # echo  "0=3D0x30;1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_=
local_bytes_config=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config=0A=
+            0=3D0x30;1=3D0x30;3=3D0x15;4=3D0x15=0A=
 =0A=
 "max_threshold_occupancy":=0A=
 		Read/write file provides the largest value (in=0A=
@@ -464,6 +539,25 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory Bandwidth Allocation (SMBA)=0A=
+---------------------------------------=0A=
+AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).=0A=
+CXL.memory is the only supported "slow" memory device. With the=0A=
+support of SMBA, the hardware enables bandwidth allocation on=0A=
+the slow memory devices. If there are multiple such devices in=0A=
+the system, the throttling logic groups all the slow sources=0A=
+together and applies the limit on them as a whole.=0A=
+=0A=
+The presence of SMBA (with CXL.memory) is independent of slow memory=0A=
+devices presence. If there are no such devices on the system, then=0A=
+configuring SMBA will have no impact on the performance of the system.=0A=
+=0A=
+The bandwidth domain for slow memory is L3 cache. Its schemata file=0A=
+is formatted as:=0A=
+::=0A=
+=0A=
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +573,46 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+--------------------------------------------------=0A=
+Reading the schemata file will show the current bandwidth limit on all=0A=
+domains. The allocated resources are in multiples of one eighth GB/s.=0A=
+When writing to the file, you need to specify what cache id you wish to=0A=
+configure the bandwidth limit.=0A=
+=0A=
+For example, to allocate 2GB/s limit on the first cache id:=0A=
+=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "MB:1=3D16" > schemata=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+Reading/writing the schemata file (on AMD systems) with SMBA feature=0A=
+--------------------------------------------------------------------=0A=
+Reading and writing the schemata file is the same as without SMBA in=0A=
+above section.=0A=
+=0A=
+For example, to allocate 8GB/s limit on the first cache id:=0A=
+=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "SMBA:1=3D64" > schemata=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
 Cache Pseudo-Locking=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 CAT enables a user to specify the amount of cache space that an=0A=
=0A=

