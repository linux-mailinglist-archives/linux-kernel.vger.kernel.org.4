Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF85FA655
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJJUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJJUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:32:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AE93EA67;
        Mon, 10 Oct 2022 13:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhVOlG9m53QUL3QY5cRestHqc4mwxxkNPXm52u15TKkpeW0VZIGxRBN+6hsPZnKr9YYU3yQR/6cQRe3qvgIwDmZistuNgupf8q8FRLql4c2yWo5CxOjjJ5oIP/He7Kaiocih5jiRSJocqRWQWXAZs+WkvQxdlqk+EL0mfvFxYlLQchnhhPLv7LhO9QnpLFSe7sv0HdYR1dF3QhgVhpNcYZ6it7X8Izv4/3BeccnSyADVjGBtnt4sYltRuIz+7TFMYlzIx2tTJUN6XZqi+QGY1bpWaYm7OA6y+m1USs5QjsqV8fj+NAE2jgrWES0vSChyct2SE0KIDLKQ0H/Y0jaf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6BA5wTBIJRDjqsbCLHcks25SjSd5KGpcIusntZi5h8=;
 b=aaNDkOLLIRm82ef6SEjMBQyrbXk6t6iM93oAWyp6xjzgR/d4axdIPdji9ZbmAJKN30O5HS/1Mu6iUzdtYHheTpuw5RkPu1ZrvpqAyFIlzoUfPVRJ0hew30phveEJA2TuvoO+RBV08d+JfmuoXrNqWcEHoQIpSoxNhcW9gN66444Vu/9xJKfSXZqahUJQhs+MJbeWVAmcomqHxg3Px2ttHPAxgrCDPcdVrOEOgLHCVMTvVq9q/xDNhS7OdE60uGnkzLFxNlgzdZ9vZEFYQK/8MTfabYmhK1J4XPS7odfxHtGwM8tPRsVb/EUhppq7sRz6pAHlFpLaZN2J1IfaKCcoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6BA5wTBIJRDjqsbCLHcks25SjSd5KGpcIusntZi5h8=;
 b=ytfqOTqC9UlX/YWKtL2ONwuwVdgibB0kqVueDRwuip8EnWaNI2JBzVmLtTPqk0bjBPY3X7Ilx6RKW5cZipM9OthBWyxj+V5Wtvr9xe1KtPbi6hPEH5RiEbyzlNQrIA8KLkrUpdNmpC8l9M8i+cKg7e5hotXWOLuy7cQQTipo23c=
Received: from DS7PR06CA0036.namprd06.prod.outlook.com (2603:10b6:8:54::14) by
 DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Mon, 10 Oct 2022 20:30:43 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::c3) by DS7PR06CA0036.outlook.office365.com
 (2603:10b6:8:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:30:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:30:40 -0500
Subject: [PATCH v6 12/12] Documentation/x86: Update resctrl_ui.rst for new
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
Date:   Mon, 10 Oct 2022 15:30:40 -0500
Message-ID: <166543384024.23830.1715326237069935949.stgit@bmoger-ubuntu>
In-Reply-To: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
References: <166543345606.23830.3120625408601531368.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c80a5e-513c-460d-cbd5-08daaafe4dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueukk8nxKjaX61XUr6VG1vmgaWOFj7FwYtUVE82Oo1SI3zZuemxwB5BqLLMXNTftEnezJ1dIR00kPDYcoG1zLt0baWE27C1g/Xn/2d3Ps4mncMCRyOtu56lNlWB/1GPZFZaOL5bsXG1bmcrzeYwq1qwnZ6fctk9/WSaNt8WZJusA/Pht9j6R3NiMSA8nufLHX83sDAoO91iXR9ruADIIpLejwtmIYkZoOSk4kd+DdVaikyG646nznCRqWu/GOGNo9w1Xiz4Y88Q+OHuaK2fExXenHCM+GzUXDl7zrNb5ANWqjWmiLk6hQHMz+brdUG3Jnb7wiVCHuZulMHjsto6JmzXettQpofni5jz/hetrWb/T056YRMRWzrP7Q+W1R9tlTESNiKoDO1sL0DiupSQ8DE0P9baE9LGjzoI6DcIShyDJ18NO3PMP92LAiKCXzNIh+NODEEMoh+zA/lzaxFqg5wpg/yTKsdtwyOUp2x7YtWrfGYpIkx5zKkiy4gd4RN5S8i1kGyXUdXWwGGfGJbETjx4LcYTZevYwRyWfEbrZGVlhVeKfJIM9ia1He92j0PXt9xw4UGPAVC7hgEH/EEC4Fzzyio88BnEyV6RCo1C6eqb4srgUU9SfhGYsTzejy+V+/O0mMO1Va3YkwJlnL/OzqVsBZjYhhf5xyPwSjiTjWNhjMcbxHkSJSMvnhWLSQF7TtPB6nAZH9ZKs8heUFiH6eTMoTNHYM/zzA84WIWIsDU14GmeuR4QBPG63p3E6rfzWuyNuTfIKb4M66KW/EhpBASxlbEVH8CvdMb4jI76l6ARrQraUSkaEWjS81A7RxPRL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(26005)(9686003)(186003)(16526019)(110136005)(316002)(16576012)(82740400003)(81166007)(356005)(54906003)(478600001)(86362001)(33716001)(103116003)(36860700001)(40460700003)(8676002)(4326008)(83380400001)(47076005)(426003)(336012)(7416002)(44832011)(5660300002)(40480700001)(82310400005)(15650500001)(8936002)(41300700001)(70586007)(2906002)(70206006)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:30:42.8476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c80a5e-513c-460d-cbd5-08daaafe4dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
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
---=0A=
 Documentation/x86/resctrl.rst |  136 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 134 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..e2a59249d183 100644=0A=
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
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
+            0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
+            0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15=0A=
+=0A=
+        * To change the mbm_total_bytes to count only reads on domain 0.=
=0A=
+          To achieve this, the bits 0, 1, 4 and 5 needs to be set which is=
=0A=
+          110011b (in hex 0x33).=0A=
+          ::=0A=
+=0A=
+            # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_con=
fig=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
+            0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
+=0A=
+        * To change the mbm_local_bytes to count all the slow memory reads=
=0A=
+          on domain 1. To achieve this, the bits 4 and 5 needs to be set=
=0A=
+          which is 110000b (in hex 0x30).=0A=
+          ::=0A=
+=0A=
+            # echo  "1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_con=
fig=0A=
+=0A=
+            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config=0A=
+            0=3D0x15;1=3D0x30;3=3D0x15;4=3D0x15=0A=
 =0A=
 "max_threshold_occupancy":=0A=
 		Read/write file provides the largest value (in=0A=
@@ -464,6 +539,25 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory bandwidth Allocation (SMBA)=0A=
+-------------------------------------------------=0A=
+AMD hardware can support slow Memory bandwidth Allocation feature.=0A=
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
+Slow Memory bandwidth domain is L3 cache.=0A=
+::=0A=
+=0A=
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +573,44 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+--------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you=0A=
+need to specify the value 16 (16 * 1/8 =3D 2). For example:=0A=
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

