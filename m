Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED35FA654
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJJUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJJUb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:31:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C155B13D01;
        Mon, 10 Oct 2022 13:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6ZpytFwH8+a//Tisybpmt9pEI7zQMrnzlWS5Yx8vneggNr5Do9s2L8VbQHsYBa9AjNWS8QjUJWX3GzGnmEDLjXY0KhplLO0rqmeyJcuMALcN/Ng0RvZWLZEIM+EFZgJubdPTNA2R35hgrZPzk8JtdKMK2GC4eJnRxtJjwg1gjkwgO0zpiGzXEGaoF0Cq34CuNp2xap4fhsfB8j0UUouA3IG6oM2XPbBGmdrRAUNK887f+0FvDP9R3u/FignfxNA2M4bO5tkxGWnbubGkw/6gTBrPg0hekMD8M+b+FRaBDHLUcbiLUTMV5EFjfM6IEG7oBW7gl51suNijUyxVNt0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NICPXrq+QsQoxlNMsQMMrBhT49k4nzEuqoTHOywL1uA=;
 b=FyDMj/oJemDVQcWugbtegjZNUBpH8VAZfisgw2C7fF6RUuNcLpL+0aaC38ulfusiGAGHJOF5j00YjiI159GJCCM8XNfh67312jMot99X1f3ru12v4kJgY5WYydMtnf7ERZ9KtaHPXwktV/5ueduA1qTEs5o6R/2bRuOwWjTxAI/FmTJLTLQnpwk8VejlK2xzioikISYxhTA+Jj14XkEM8az3nL07YLsJ4Wmm+eG+ofZJdkGe+IJ2nHNLevVdJhD6kcBuPz9K5+yz8oVDfsLAzw+QmkowS3/QDjlOQh3EAYK5AVBekLwNK7q/HUf73MrhDLPuZZYz3+R0aM/mlZBZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NICPXrq+QsQoxlNMsQMMrBhT49k4nzEuqoTHOywL1uA=;
 b=3gsy240TOYpEOZU1wJxR0Zwrko+Y3Tz7OnSpMO8rVo7gaWASpWgELLXoft6o7W0I4O12Ga/FjJbZxrIIgEC8AV3yfBMqz0TVwhKwAwiQwsb46sEvsr/2LU7EePNVC5jvuz+BNkL+BktDN3ghVQRff+nve3F5jj6MjJxGqxOZTrY=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Mon, 10 Oct 2022 20:30:35 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::62) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Mon, 10 Oct 2022 20:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:30:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:30:33 -0500
Subject: [PATCH v6 11/12] x86/resctrl: Replace smp_call_function_many() with
 on_each_cpu_mask()
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
Date:   Mon, 10 Oct 2022 15:30:33 -0500
Message-ID: <166543383308.23830.18388408549121180741.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 58904a36-670b-48e2-ed6c-08daaafe497d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMk99x+Ule0V555h1uciuVpeqeQmCQAMe56L9pUsnNZjG/ESBIkYEy9ofH3+Anwyb7EBSFzvU1Sg1QKNehfxvVujw09kXeaVmgfQxUotTyN6LvS3oMlY4wisAajpMWWZdl/QLQJCFZQriEmThFWF5HpTmIt6csPhyiAB11NWTRVDmCuW8Ylgnkh5mcWyutqvY9mG9fT/OYLUn9t1o6Vn5WD1WKinp4b8PN4rdpCKxE94hJqRpJebN/43I1S7QbYk7Udzhl/p4RnIRUvUdpIi/Yf3jbDu7uphSRAqSmgpKAsMFW3xeR0ROTIATEXwMEwhQXiDJeSwH1fiSKJZlEc/3F9PYsVIzwoddzQCCiSf49KqaIRlyk5+Q/B8Dxv4z34QNGE+n1rfY9GS62pftykmunjHc4fznl8CQ8Y6vtO1Q9Jv5/R943GDhAEFLjQq3QCgctc5GDXiwfrf/3U0xmW1SZwQWEzwRuZV6dQVBIZu4xNjv1s3hiXFelnAAbHubcDNVRqSx7fsXJ/erIOgyvSOvaEXXeNeG2cEQPCWmriHt19cAMY7PGlNQ/5TMtcV+7nQX7hsSS9ENlnndqjSFEWK7Y67aSS2ttT3mYPQ7lr+aRIK1ZzLNyae5dgXCc/M2nd+YUqH4PSgC/f6cNv7R+G6NhzNf3EQFhw4d9ckAYX++hKIVyAeBYofcVorC9RuzRj25eFUVS/EvSHcwhklLx/x2sxuiIJX14XKG4G23ExBvp6jBtHi8kUZQQz7Kb6fkbueZsHbJ3U+92GNekf0eJIECWKJb73E9AgBZnehD7NpoH1HCvINTcOZAxcycQKjzlYHF3UmkilxLB7GzHU7YBSIGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(316002)(36860700001)(478600001)(2906002)(40480700001)(70586007)(70206006)(7416002)(82310400005)(103116003)(5660300002)(86362001)(4326008)(8676002)(8936002)(82740400003)(33716001)(81166007)(41300700001)(40460700003)(16576012)(54906003)(110136005)(44832011)(356005)(426003)(47076005)(186003)(16526019)(83380400001)(336012)(26005)(9686003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:30:35.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58904a36-670b-48e2-ed6c-08daaafe497d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call on_each_cpu_mask() can run the function on each CPU specified=0A=
by cpumask, which may include the local processor. So, replace the call=0A=
smp_call_function_many() with on_each_cpu_mask() to simplify the code.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++--------------------=
-=0A=
 1 file changed, 8 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index e744db5dc057..4f8a1c9c3e7a 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)=0A=
 static void=0A=
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)=0A=
 {=0A=
-	int cpu =3D get_cpu();=0A=
-=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update_cpu_closid_rmid(r);=0A=
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
-	put_cpu();=0A=
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);=0A=
 }=0A=
 =0A=
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,=
=0A=
@@ -2131,13 +2126,9 @@ static int set_cache_qos_cfg(int level, bool enable)=
=0A=
 			/* Pick one CPU from each domain instance to update MSR */=0A=
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		update(&enable);=0A=
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, update, &enable, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
@@ -2614,7 +2605,7 @@ static int reset_all_ctrls(struct rdt_resource *r)=0A=
 	struct msr_param msr_param;=0A=
 	cpumask_var_t cpu_mask;=0A=
 	struct rdt_domain *d;=0A=
-	int i, cpu;=0A=
+	int i;=0A=
 =0A=
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))=0A=
 		return -ENOMEM;=0A=
@@ -2635,13 +2626,9 @@ static int reset_all_ctrls(struct rdt_resource *r)=
=0A=
 		for (i =3D 0; i < hw_res->num_closid; i++)=0A=
 			hw_dom->ctrl_val[i] =3D r->default_ctrl;=0A=
 	}=0A=
-	cpu =3D get_cpu();=0A=
-	/* Update CBM on this cpu if it's in cpu_mask. */=0A=
-	if (cpumask_test_cpu(cpu, cpu_mask))=0A=
-		rdt_ctrl_update(&msr_param);=0A=
-	/* Update CBM on all other cpus in cpu_mask. */=0A=
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
-	put_cpu();=0A=
+=0A=
+	/* Update CBM on all the CPUs in cpu_mask */=0A=
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);=0A=
 =0A=
 	free_cpumask_var(cpu_mask);=0A=
 =0A=
=0A=

