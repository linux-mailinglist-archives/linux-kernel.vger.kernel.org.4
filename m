Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C26601C65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiJQW26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJQW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:28:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59228260B;
        Mon, 17 Oct 2022 15:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY6fFrGilXpuEiFdPoMNI6dqNeSZlowVn1oZll/hRLQqpXK6Dy6N1lnX4Kls7BEasjEqpmI/oYJUqCFKera2CoP/76+v8Eji9pHnie4e7SXhDoMirySVThl0Mb5CsGvHjrSSgOfgnFt3hWEGdW9SknzYswGMtj8/527Ye6Ar5eWApxkeMNZ/zArJYekO6aizekfj7Zll0oV84nr86foGVWodnSMBuiq9+Uk3O4MmSXvuVEA9dJ0CQHpz3A6MHD0Eg8+VfXoQtXOqx0H5fIMVO41gtjZWATT1BFXozI0dHYcvZb9NYppzOfcFbKyoVw0fO4IkhJQZKtES4Yx4SlNsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NICPXrq+QsQoxlNMsQMMrBhT49k4nzEuqoTHOywL1uA=;
 b=GhzOG7u2tBD22JbUjaSzvnKHzJXNz3x8NxAwliVaxmgWR7ExZLYav4ftgsmGG8/t3QG5nRYovzYWMqKM2mDYePm28amAJeysWGdddT1hjPZTzgpKiU6Au7vpiv6g2wzDge6+hYrdG0eLBkKqbjEYdWIzn5xdwSAMRbPdMhOT1AlaGERdbLIkv8elTwRfqCkZH7woIkGM24jb1TfmUZfakF1E2OYkhsnttiRIvao2Huusm92j5JyE9Znsmh2PxJUCnfrN2H8wu3v601bVzKKPe4+tEglMdTolSl54yclZt6CnTu0smSRO9XiCdi3fRm8v0dLPIJ72Zzn6dyoP6nJ8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NICPXrq+QsQoxlNMsQMMrBhT49k4nzEuqoTHOywL1uA=;
 b=J68xD7SB93cGwmAk8P+ybbVIBDMkVQI/zmyLqCpOehCQ1qYluwvHNJ1hwJNl+mKlr3k7J+6zD+wk2Jy+nZNB3rA3/STkDkdeP9/MMELNieq2Qba3gcojM/DrPMAHxvZouQoqMEjg5GwKajMEPdwVmotX1H2YdlsReNTJ+7ViHck=
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:27:31 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::dc) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:27:27 -0500
Subject: [PATCH v7 11/12] x86/resctrl: Replace smp_call_function_many() with
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
Date:   Mon, 17 Oct 2022 17:27:27 -0500
Message-ID: <166604564729.5345.14834531439162556392.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|CH0PR12MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b24d8a-a7df-4b67-945a-08dab08ec6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTMQ5IWjcM3Lj3FwhPWWkfi/c0mdwDygq0Pnn+dqD1tx9hrrcOSVatHTAP7k8tz1x1X4GzyjrFH0VL7Ziv/qvqzvIZOSccnRrV0xcfhgznQz5w4tv139r0Nh/e1zdPtpz3PFNjybo2fz8ZX+78bzBNoqE+g8rCqQbnhsM9N9AQUeHpmYhwJMI9AO2byOeL0n3DyNiALTetTkJKUHg+jMtX08Ez5AVWrzoZ5yx2vcg4E0wvq2UbpaInm6iwGbO77R/lgyEo/IuPFalXdHYVKyuM5ReT66T/kgMRlk5rrR2JkS7DO3hdol4zh7l1csFijmu9Acqw2s5L7B2gdCL9uT8uQL4led+mSsu0v5ibOFWT0Qq/Gtxk9g3OOskRNCWRS3Ry2/6hhf7x7iACGJAJJlzqGrNYI0ht+qfltH/2+3lZEVpn18L57GwKNlbzqn4Lklp/eKdW+4KGIoKv8or9MDGQzERODOl1WclCamkrQ8LKQ+y0Aq4HzSa0yzgz/wN2LDT/YEwyd26e2kBrx3hO4r2LIGuJNIp+Xa9x43nQmB2jnPx9x8BA9d93HjxEwgfYEevrjh3XJexHbh7pg1FBJInnVkuvRHEtjz+QOfmhrHrwuz5YMMzAF8NMVlCcTe6WNOeKPYsRd5ge3yeCH5bOjchkdvaibFvJ+poyR0bMSrCb508BwVSw7Uy4nDCBXYHgT7DyjvYNkYBQAIesP2u7Gan2+G92xPpwwfgQnqAcOkere/GGUf8PjzFXNARQekvQvAwEs69s0ghwgf4kAfQCOLIvBNvOm6FLnsy2NZGUb7I+bQ78OQpK5waZvtKEGistNyO9t5SgSqeNSAKmeaxTkn1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(110136005)(5660300002)(44832011)(7416002)(70586007)(70206006)(316002)(16576012)(478600001)(41300700001)(8676002)(9686003)(4326008)(26005)(16526019)(336012)(2906002)(186003)(8936002)(83380400001)(81166007)(82740400003)(356005)(33716001)(82310400005)(47076005)(426003)(36860700001)(40480700001)(86362001)(40460700003)(103116003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:29.6295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b24d8a-a7df-4b67-945a-08dab08ec6fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
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

