Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C925ECE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiI0U2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiI0U1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:27:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EBFAD9B9;
        Tue, 27 Sep 2022 13:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsctmIm4WLFv2oJ07lXimHcS9qJDbtNZndHYLGwGuvvEOwn4Ip2QvhLC4KLNvGPZgi6SQtmAgcKZaTYgRyM/NR8C+fuq5N+vYvmSZ4bP6UDird87oQf7f9FgznIM9lIytoqDdWRmfSbYtV90bTXpdjljL4UJYhF+JN5+saNsR2MNyhPCpTMZaRFyh12a3Apv6jekZJuZyMBXwK9ohCzLkUPsAR/CI+n33EAP+CFIqVRH/J/ImZpoKQtLsNrzViEkBC82tFcLDB7mmkZYe76XCuqW6sTGI3awUD2yabAlm0seO3LOQaVDOkbbg479qBEV4zkTJGzJWeGN51QhLoP0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyXTHTmcXLsyAABbJ7kNTnaNkajP6v+b3wjU2T6deWk=;
 b=QnVn4G4+WwvPbBAIZijuxL5LuyLW8MO3XTZTJ5UZnYJ8z97InANEx41zE3FZQNwbRLjyTSyQG/VpCiiWGwLeGnqfXy80CkWOkcCiw2tCw4Nwp3wbAslh7u3MujlVbRunpmswUlreQPLf6LCDa68sl75psjjAnUJrAGElDqsGB3EJsYtEvQ6XxaLAfoc2RH37c0vpJoGTq7ppG/zdY7ZlHcPI14sGzgzIa99JBZxq4o3cgKlfwK0Wq7DX5jcl+gtzS+gQ2oSOtIL5F6oZdkwoNjomb4HiMR/M4rDna9MGSn+wTsrUPXHUgQetSGLlNms28uZLi93JXBo8C5N5sSR6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyXTHTmcXLsyAABbJ7kNTnaNkajP6v+b3wjU2T6deWk=;
 b=srnnlc+6r5D0s0TMsNTBMZmiRcHSXPi3ASMBp2fJERjtaR9KaztDx9VKM3izznIOgQyB5nMSfEDe11Dyyj7HrQfOHdE4ahSvsaWQ56JLi06fczY4irDLtd0OpZk9clW4jbU9R3FQlA6LVN8GCZL8Wdvnq27ac0khUl8nps9LxdY=
Received: from DS7PR03CA0215.namprd03.prod.outlook.com (2603:10b6:5:3ba::10)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 20:27:03 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::15) by DS7PR03CA0215.outlook.office365.com
 (2603:10b6:5:3ba::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:27:03 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:27:01 -0500
Subject: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
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
        <eranian@google.com>
Date:   Tue, 27 Sep 2022 15:27:00 -0500
Message-ID: <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ff3670-9b32-436a-c45d-08daa0c6a37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZqWD+5VkZlDTkAZhCSQeIA21Klhu6qLRX54IdzZWvHBpGN5Y5WmgGyLdarV40IY5M0m4f2o6w8XpqCDDEf31OWBJ0blZYL7t1AzCHcKVb4vjI8+NPasOQNmWl1pdwg8FkkGmiGv8zWeak+EbJgZV5mKRB20mhmvnBR6/d1Yx0E/6prPc2hi2rwUgs3nr0F29rjF4nKtXc9M/afsNTf0dRQ5I0SBR7fx5iBfB5ProTYIs8deiFU04RUxYXTER34mf7ipSSQmoK8mHJKrApnGDhk/bORmEMAFEhtnGZs8HOaHaUR3JDVOEev9taWrst+QQzwBrUaOmw2Mw0t8Rjh23DB+//C1wl+gSyaju2eYpkZouo7eU/3V1ins9Mv8J10r8oE8jzSnMtboK2cThmUCU8TTsk+5+4lJHEXF+l7jS2lPwRbMLdjDFEftM2zA4ohDbkzBeAZzT7HEj7quJzelezvybVqaLIrKK+uJcXazldwMWAALiHByYV9Fg0DXdHhB+oF3OoMQgdNxR4JUKmwg6HU67w3P5bbSmqGeBpNoROoux7sRr/eLu7RjhaS/5lhJLNu26Py14vYvHVVeQEiaj02HgWlQFBldkdhT/R4c0deqDtoldv9IozoAGHS7TTQT3wyLF4/hS8MUS27ihX1BAhe+9snY4fv1q71ES+7BU/rB3PqMSWyI3ttu616BfeB/yoxYDXnZ/gF1VaJx0nUBwvVkE0V28PGcOdXLfLYVoOHaVG1olr9W/RJ0M988jCam/GPm+MK7NAyhVLil7HCLxsEucv8p5ply73Fm3FbmMwihtVAnHBLWBBzva6auGoVL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(7416002)(54906003)(16526019)(83380400001)(44832011)(186003)(426003)(336012)(81166007)(356005)(82740400003)(36860700001)(47076005)(40480700001)(2906002)(40460700003)(5660300002)(8936002)(82310400005)(33716001)(15650500001)(41300700001)(9686003)(8676002)(26005)(316002)(70586007)(478600001)(4326008)(70206006)(16576012)(110136005)(103116003)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:27:03.2018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ff3670-9b32-436a-c45d-08daa0c6a37b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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
   enough to count all the different types are memory events. With the=0A=
   feature BMEC, the users have the option to configure mbm_total_bytes=0A=
   and mbm_local_bytes to count the specific type of events.=0A=
=0A=
Also add configuration instructions with examples.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst |  130 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 128 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..b4fe54f219b6 100644=0A=
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
@@ -161,6 +163,73 @@ with the following files:=0A=
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
+                   mbm_total_config=0A=
+                   mbm_local_bytes=0A=
+                   mbm_local_config=0A=
+=0A=
+"mbm_total_config", "mbm_local_config":=0A=
+        These files contain the current event configuration for the events=
=0A=
+        mbm_total_bytes and mbm_local_bytes, respectively, when the=0A=
+        Bandwidth Monitoring Event Configuration (BMEC) feature is support=
ed.=0A=
+        The event configuration settings are domain specific. Changing the=
=0A=
+        configuration on one CPU in a domain would affect the whole domain=
.=0A=
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
+        Example::=0A=
+=0A=
+            To view the current configuration, run the command.=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
+            0:0x7f;1:0x7f;2:0x7f;3:0x7f=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
+            0:0x15;1:0x15;3:0x15;4:0x15=0A=
+=0A=
+            To change the mbm_total_bytes to count only reads on domain 0,=
=0A=
+            run the command. The bits 0,1,4 and 5 needs to set.=0A=
+=0A=
+            # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_confi=
g=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
+            0:0x33;1:0x7f;2:0x7f;3:0x7f=0A=
+=0A=
+            To change the mbm_local_bytes to count all the slow memory rea=
ds on=0A=
+            domain 1, run the command. The bits 4 and 5 needs to set.=0A=
+=0A=
+            # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_confi=
g=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
+            0:0x15;1:0x30;3:0x15;4:0x15=0A=
 =0A=
 "max_threshold_occupancy":=0A=
 		Read/write file provides the largest value (in=0A=
@@ -264,6 +333,7 @@ When monitoring is enabled all MON groups will also con=
tain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
@@ -464,6 +534,24 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory bandwidth Allocation (when supported)=0A=
+-------------------------------------------------=0A=
+Currently, CXL.memory is the only supported "slow" memory device.=0A=
+With the support of SMBA feature the hardware enables bandwidth=0A=
+allocation on the slow memory devices. If there are multiple slow=0A=
+memory devices in the system, then the throttling logic groups all=0A=
+the slow sources together and applies the limit on them as a whole.=0A=
+=0A=
+The presence of the SMBA feature(with CXL.memory) is independent=0A=
+of whether slow memory device is actually present in the system.=0A=
+If there is no slow memory in the system, then setting a SMBA limit=0A=
+will have no impact on the performance of the system.=0A=
+=0A=
+Slow Memory b/w domain is L3 cache.=0A=
+::=0A=
+=0A=
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +567,44 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+--------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you=0A=
+need to specify the value 16 (16 * 1/8 =3D 2).  E.g.=0A=
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
+Reading/writing the schemata file (on AMD systems) with slow memory=0A=
+-------------------------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you=0A=
+need to specify the value 64 (64 * 1/8 =3D 8).  E.g.=0A=
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

