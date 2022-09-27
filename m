Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CA5ECE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiI0UST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiI0URx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:17:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D15F121;
        Tue, 27 Sep 2022 13:16:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHglu0nbuGV+4PQkSQcIrs7d+aGMoW8kpaqDQcl4Olj1KsFC4vy+y8ap6fPQ9nxkCmqNcnlef7+knVXg0cZJAIJAlauFOhqSXtAgX77omQPjy6m6T8Mq2wYD7B/nXrVaVYUwQ/V+gfTCQ6SmQw/gvJxEnxmbRo+6b0yJZ+z52rqEkfgBCcyAULOFbVG2acQ75n9eX7WdzpsjRVyLYwrleiHSozcFY51TBCMLiEzriZN1sdba8jrxrsijHTDkHRSxjgTK42f0ckIHxsxAWzZJcbbo7ml10dc/EU5eAqHtjNESaUuRla9QTdqhMtBxxQfD6Z1cofI8vwrXz5p75rY4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnZyjY2iz3SEE1fazeNr75wrVT0PCH031AvjHUIVYcE=;
 b=LD78VBWe02iYbZoFLUtCpSWaymIoTfqRGNkmjaO1meBcUhsE2+TVfxJB1qbkD3HZ6kqMSp/YxbmCrFTbsaV33lfFq5EkQrsk8HI0Vu7Q/z5vqXKIa1fq3AyHsqRfLqCzMON8pEFlGYobs6RjmsxCnM0Oo9PoPgGrmIbSn1tSSB6CoXbra6nfhca8arsWlqnLxgc0ZvXFXlVbzm3Y/05s3OFr1WJmnX2bsd4gP27RXLwSwl9tmDrlONqHW+yeCFL5VNXPMlRW5OQbEJd9JBki36hNMAAjDaMNiRt4QKBNLwHs5ZUMDVbFJlpANNORkimfzSjUqExzIQfjjtJa+9wEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnZyjY2iz3SEE1fazeNr75wrVT0PCH031AvjHUIVYcE=;
 b=zD1133XBppKUs3sI0oORbzjzvKy1jR0BiErtvN1FrBe6kYE4uVLyVl4hn7xKv4XvUB4UB3tS3ZtaHtukXX3es8bmWDz8lKHwVLMGahcLndt0qNwF64bhecrmvajgW8pl6/hnnqN3OF+op1Hp2OJbT63Uz6cRjzdW+4wwPKtoFY0=
Received: from DM6PR01CA0011.prod.exchangelabs.com (2603:10b6:5:296::16) by
 DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Tue, 27 Sep 2022 20:16:32 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3d) by DM6PR01CA0011.outlook.office365.com
 (2603:10b6:5:296::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Tue, 27 Sep 2022 20:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:16:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:16:30 -0500
Subject: [PATCH v5 1/2] x86/resctrl: Fix min_cbm_bits for AMD
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
Date:   Tue, 27 Sep 2022 15:16:29 -0500
Message-ID: <166430978944.372014.15309570958318893913.stgit@bmoger-ubuntu>
In-Reply-To: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 37189237-c124-4da3-b2bb-08daa0c52b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5Uuz2GDu0Ae3bvUJEYzXmqIMQVa6jQMveXNOBogPFrnWcZsJQ0Ch54txIq9P9UqVeR6nsGxeNXN3uwBsG2/Ycvsr8rfJ5CN91lheWXMmDjdxJ/S8AzuyIBdmAsaZWWfzrv7CrxQyJLM+OqYW8V9Pj4SUBIpxCmkuokKXH/oh0OnXNCiyGztS495LK1Xfv9lR+MP/ZMrAtIPEeyPDd6W8I4ACeGCZOrTz7fHCPj3cNC4TPvvM5LnUqJjGf/lYqxbp+PBgHD3a2QfjOED7Bwb490Nj0qFg1P5M1+zcfBGjnahjNWOYFxQl3m0tNRac/Nn3k6+0Gfr+k9VBXB/KFGjZmVirN/KbfVfxRuUimzB3XOdMlIweVIFIX+bm4pQKZUhHGa4E+k80Q5sPtVxL3meGYmwxCWJPu+15OVbDq2sjCwByrvAfxCvOr0RwmHPSTYgxPwFS0Iljohv+CYbF62RrU88xc6VW47OA17SsWTSKcJ8SgUaWq9I3watdSmyMakoEtYQlzRCSg46kHCkmJLfqrn7i5nMQf3onR89v9Q6KShtedChE3HGo66c7/zze47Jq5XcBVWmT3c0DEZN7ZamB3VhjdwlMnF4/xBAD1RRjnwBMrN1mOuTyH9tTyWfcfSMuk0lJH2N1YUp+hHc1x0/q0r5LmaPdSylT8BTbklM1LkKfG8orAJkuExHAqvuadxhEktEsQvTujzL/XIvQUUzXhv+dYnF4BRGyLJHgdJQwzN03aQacH4ezkbYtVSH4ua/R6on+ix93ilXrXINgApkMbQiBbXeXYaM4VpAXgDaOCph719P5QRd++dOgQHMYmJR8yY3exEwK4M1kdeB+FYa95uyslvWp0JuZ2dopc7/qQ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(47076005)(103116003)(40460700003)(2906002)(44832011)(356005)(81166007)(86362001)(70206006)(70586007)(82740400003)(7416002)(5660300002)(8936002)(4326008)(9686003)(83380400001)(426003)(110136005)(40480700001)(316002)(82310400005)(966005)(36860700001)(54906003)(16576012)(478600001)(41300700001)(8676002)(336012)(186003)(16526019)(33716001)(26005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:16:32.0963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37189237-c124-4da3-b2bb-08daa0c52b50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD systems support zero CBM (capacity bit mask) for cache allocation.=0A=
That is reflected in rdt_init_res_defs_amd() by:=0A=
=0A=
        r->cache.arch_has_empty_bitmaps =3D true;=0A=
=0A=
However given the unified code in cbm_validate(), checking for:=0A=
        val =3D=3D 0 && !arch_has_empty_bitmaps=0A=
=0A=
is not enough because of another check in cbm_validate():=0A=
=0A=
        if ((zero_bit - first_bit) < r->cache.min_cbm_bits)=0A=
=0A=
The default value of r->cache.min_cbm_bits =3D 1.=0A=
=0A=
Leading to:=0A=
=0A=
        $ cd /sys/fs/resctrl=0A=
        $ mkdir foo=0A=
        $ cd foo=0A=
        $ echo L3:0=3D0 > schemata=0A=
          -bash: echo: write error: Invalid argument=0A=
        $ cat /sys/fs/resctrl/info/last_cmd_status=0A=
          Need at least 1 bits in the mask=0A=
=0A=
Fix the issue by initializing the min_cbm_bits to 0 for AMD.=0A=
Also, remove the default setting of min_cbm_bits and initialize it=0A=
separately.=0A=
=0A=
After the fix=0A=
        $ cd /sys/fs/resctrl=0A=
        $ mkdir foo=0A=
        $ cd foo=0A=
        $ echo L3:0=3D0 > schemata=0A=
        $ cat /sys/fs/resctrl/info/last_cmd_status=0A=
          ok=0A=
=0A=
Link: https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.=
com/=0A=
Fixes: 316e7f901f5a ("x86/resctrl: Add struct rdt_cache::arch_has_{sparse, =
empty}_bitmaps")=0A=
Co-developed-by: Stephane Eranian <eranian@google.com>=0A=
Signed-off-by: Stephane Eranian <eranian@google.com>=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
Reviewed-by: James Morse <james.morse@arm.com>=0A=
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c |    8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index bb1c3f5f60c8..a5c51a14fbce 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -66,9 +66,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L3,=0A=
 			.name			=3D "L3",=0A=
 			.cache_level		=3D 3,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L3),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -83,9 +80,6 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.rid			=3D RDT_RESOURCE_L2,=0A=
 			.name			=3D "L2",=0A=
 			.cache_level		=3D 2,=0A=
-			.cache =3D {=0A=
-				.min_cbm_bits	=3D 1,=0A=
-			},=0A=
 			.domains		=3D domain_init(RDT_RESOURCE_L2),=0A=
 			.parse_ctrlval		=3D parse_cbm,=0A=
 			.format_str		=3D "%d=3D%0*x",=0A=
@@ -877,6 +871,7 @@ static __init void rdt_init_res_defs_intel(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D false;=0A=
 			r->cache.arch_has_empty_bitmaps =3D false;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D false;=0A=
+			r->cache.min_cbm_bits =3D 1;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_THRTL_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_intel;=0A=
@@ -897,6 +892,7 @@ static __init void rdt_init_res_defs_amd(void)=0A=
 			r->cache.arch_has_sparse_bitmaps =3D true;=0A=
 			r->cache.arch_has_empty_bitmaps =3D true;=0A=
 			r->cache.arch_has_per_cpu_cfg =3D true;=0A=
+			r->cache.min_cbm_bits =3D 0;=0A=
 		} else if (r->rid =3D=3D RDT_RESOURCE_MBA) {=0A=
 			hw_res->msr_base =3D MSR_IA32_MBA_BW_BASE;=0A=
 			hw_res->msr_update =3D mba_wrmsr_amd;=0A=
=0A=

