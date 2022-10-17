Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C336E601C67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJQW3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJQW3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:29:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE8A8112F;
        Mon, 17 Oct 2022 15:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNJN51S7izkPFyzDznIKfOHDDaiE8ThZ6qceHofkkRTh/ylGC23EZXWTtN2fd+NgdB2PFe57lyFsv9RWHa1W4vVGxRddJj2+7+QWKI+vO1I8J5UAhwlgs7fAsVa0MBwo9vSwkdpar8qSwg1hODci77ryPXJxu+HS1a4JjZ+oI9KueifhoWMtfAEOuwl8RpFL9j3eFiilkKfZEfJcLoR55UHvdCywrqI3OgtOHt3kx/fyR0CGIajS/qFzLJiYBNOOhJMThdpzu7TFhwgBueP5CDek2JXx0eeQqwXw18ZfOWMzPWZdEGldXI8mPuEmmy7LUD/IovgASqpweSbuMMr1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmUmdOUT/+idtnOSNOzH0DTMOQ4xeQprS5+AjbtNBc8=;
 b=mJF2tz/nxfp5RkbarxS7iFevxSl8O2jl8/nMsP9joT9W7ZP6333TvBr12gGAU5yBkj3N81z5BB1pMuuKCnDmqTFf73E3lINCPh8GiuQSf1WhiiXjad/qZ5ESF6shUU5ARJLx+xlED7OBakc0trlABGft2BokZ5hukYTrjHrE3HiQQTh8dN3Y0y2gfgwzCCEezK5Z5pTETltwHzcGRufLhpN9hGAq84ONb/vwwrcZJzLP2j27bGboWdL4yW9Gt5t4AKLuSyzYzj2zhMEtApw/tHjn2GuEuKIfvkHc3dClrACI0K7TKJ2kDwQm0lKJpl+wkeExDTnXLeNdBAg8PPoIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmUmdOUT/+idtnOSNOzH0DTMOQ4xeQprS5+AjbtNBc8=;
 b=37zUg8wQ76TQ+DkFxP8D8eWDfBq4xYwqxy2oW9qgzD5/u6t0P6lZub3iyG5xonED6PYV50mT2zIMhCgxuru6Sou0jHrxYsZ9WwCT2myBfGJkZDHoB++I1CAX2XxChR+WRA0oqbKeQYvGN8a/ZywjHGqy7TLcLfMID2KmuizvUeU=
Received: from BN0PR04CA0133.namprd04.prod.outlook.com (2603:10b6:408:ed::18)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:27:38 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::40) by BN0PR04CA0133.outlook.office365.com
 (2603:10b6:408:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:37 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:27:34 -0500
Subject: [PATCH v7 12/12] Documentation/x86: Update resctrl.rst for new
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
Date:   Mon, 17 Oct 2022 17:27:34 -0500
Message-ID: <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
In-Reply-To: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|PH7PR12MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: b739b5cc-791d-47f0-0aed-08dab08ecbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI2tudMtwB/+u7Acas2dFTfHCy+65lxRFS7swMw8W/Q8tfuI8S5Th8JwPS+pJnP/ARp6l6X2bBLTPPiv3hGG600uVEW77E9e8APvL1n4InFM2cTotoLJq83cbyzFAaHsLOMgOXm3EWtGxQ15sZ0nX0aKRt/w+EkmpOZ8Vh1HJ7MRilWjWEXpe45jCnzQTV93Mcfud+aOynJ3gR3nsZb/urI0VE/9xkhG0d9/imjEDM4pYzuSKMxcjSppCcjgfXWpihGerbxdrDdqmd14IYEUyWECQqVDv9wFgRfKviho06ugGLwvcrDHXtPgja2Mp4dFFjZJBrHyWiuNc98+HVJFjnTEVfXlARX+s1BPDcfI1BJVaBP1RfSCCImY92L3vJgMVICgjN4jAA/jyV9Op8WWyiZyqh6SBM+8Y4CR00MlFg5nbFA9lvraks4bqhl5ZauE/aIQkNhO0FXh2EN94qUKA4XeHqgCd+ECK3jPGU2Jo19z/n20j0TDqdSBt2xcm3oOG482Muk+kQKC58ZS5jeots5Ejo6RqKJpQGtVgjBxSpe2d1An/4LFUDco5WLjynJCQ2RbJyENlhdGBICny4c75FL7pGE/WijmnQZRLF7aDS8F8urgI+pXwpW2fBZuWm6JkdxJW4ndQyDlMk99YZa/toVOzncH1gpaD4nJlfEuHqfkcHHlJl/0O0u3DEaJP/jZyN0rZPgZ0EvK2KwF9JG3yq6zZ4HIRlqYjKMmTfw7Fvq8aAJ9QAY67aOyud5veF0YwqvcRrovltMwJUCGESWQeuSto8w13PaNuo4xmD7yC+a3fyo+TyUM4FIKGpzPKnFL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(110136005)(5660300002)(44832011)(7416002)(70586007)(70206006)(316002)(16576012)(41300700001)(478600001)(8676002)(9686003)(26005)(4326008)(16526019)(336012)(2906002)(186003)(8936002)(15650500001)(83380400001)(81166007)(82740400003)(356005)(33716001)(82310400005)(426003)(47076005)(36860700001)(40480700001)(86362001)(40460700003)(103116003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:37.4968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b739b5cc-791d-47f0-0aed-08dab08ecbaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
 Documentation/x86/resctrl.rst |  139 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 137 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..d0b4e1a2cb8d 100644=0A=
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
+        * To change the mbm_total_bytes to count only reads on domain 0,=
=0A=
+          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in bina=
ry=0A=
+          (in hexadecimal 0x33):=0A=
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
+          on domain 1, the bits 4 and 5 needs to be set, which is 110000b=
=0A=
+          in binary (in hexadecimal 0x30):=0A=
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
@@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory bandwidth Allocation (SMBA)=0A=
+---------------------------------------=0A=
+AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.=0A=
+Currently, CXL.memory is the only supported "slow" memory device.=0A=
+With the support of SMBA, the hardware enables bandwidth allocation=0A=
+on the slow memory devices. If there are multiple such devices in the=0A=
+system, the throttling logic groups all the slow sources together=0A=
+and applies the limit on them as a whole.=0A=
+=0A=
+The presence of SMBA (with CXL.memory) is independent of slow memory=0A=
+devices presence. If there is no such devices on the system, then=0A=
+setting the configuring SMBA will have no impact on the performance=0A=
+of the system.=0A=
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
@@ -479,6 +574,46 @@ which you wish to change.  E.g.=0A=
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

