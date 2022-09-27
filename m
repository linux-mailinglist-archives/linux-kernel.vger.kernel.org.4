Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98BB5ECE7B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiI0U2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiI0U1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:27:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0DEFF5D;
        Tue, 27 Sep 2022 13:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdIxjtJhzdwnlAdpxmCGOz1AYvZ3Olob0qVRfj7w3BM+w4W4RiK+bFo5mAxxxjL9Hp8vaS5vmsuUCMY3DuXVieNrPAED5Kty8QdIKOWTh5goKxpob8C0IPURxm1ChHyzd7TcCu6s9Ae8c1hcLkQTOxHA9rPrt1AaLOSiSiPj9SDsuTHnHQ97Ne3KhFwBMY977rAJ6f5swoX/SIbp7RJq/43m8ooHvIOY4woEc7T/0Gp1Ne669ThjUhllij/d8DMP6KlmHhPZmBUm2ozFU8iDRVk92PldO5oIODkUWVbAbnzdHkHposJuFwDVZPQHwtxGAagMlju8TGUn7MN17DUYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp9HP++gt21/hVU1HvBSmOyTfbYZwVttiPeNeSFO+T0=;
 b=i7GRpVg13QlUiwRecEk2O94uyiZOzWmuGM2EO014US7+NvzGnbJVJk7NBJkIdG2w3zMkdGULpLlFm2TdDul1xu+uNXdW5IlZJKUoacpCMzKwHvdS07BFfRy/1Qh6dtPUBB8g0UT88aOqw/2RdFyBzNSvilEuWA+eJKm0uTgUvZWMnUtTy0I4Utnc2y0oBdU1fkS3KkTAqLu3EN9pKFLt1p0xkKfph8lmE+17SglsH7K931CFj6CNYFcfk0SBX6NvHb8he34bK2e7aqxII2oUvC/Hxu25yD6SL4lJO5RBmXdK1r20fLeug6t2wV1z3s7RtY2us6JVNBCFySgmnPdDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp9HP++gt21/hVU1HvBSmOyTfbYZwVttiPeNeSFO+T0=;
 b=nl2TB8HIGczwvE3uuoOwNzdXa5fLCiUGDRHjyCq6kG+svIH2tTj6rYWZi04n2vU613ScFXgU2OsByxNlYFkZ4VlxYNMmUUBkWHmULCuddGXu4uElKbZARBMpSB2FJcidhUWQZvydh8WYNMRYXNMGM0iK6NcDjZYlTHdDTaS/+0k=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:26:56 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::30) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:54 -0500
Subject: [PATCH v5 11/12] x86/resctrl: Replace smp_call_function_many() with
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
Date:   Tue, 27 Sep 2022 15:26:53 -0500
Message-ID: <166431041367.373387.16343892218388937640.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b716f3-4348-4f14-cfbd-08daa0c69f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIvXcK+e9zoSdD7mImPx+XQrj7Hag22evbUfcxirbWULffB+Yy0pv1sYwepPJcjf+R+bYEx7/GvZIrazlvnFmruSceHFq98nK8v9rycTHEdS6LXUa2atThStk8fX+qj82VTXcx+fM0q9KsoxE449M/4UfxVx+F65Hk9pKDrBgYbeihBjYYpDCtZ1zCVCcuCpqDjLzvstMqjbaQR4PZexr7Hjz3Fa1gA4vTy0o5XBOp0gDmmYj4d5Hf1RcYKbu6tegrS8gqxiUroVZbxJg637uVwdSMN3zOe61nWn/U8YiFU/IG1LqXGpvJSnASMK1D4hnKFTnGdzdmkRnekR04Q+/KGaFRFqONzmoXkNzzM2qV1sPZCTPq9CyUpJVT5DdJCwIT57B2/oxmswKmGU2gLmKLkvFnx0oJSn89X4LAoPNYFtIGPrtKVRhfrq1LJsK0P97hCVbfSMuerJrnlDfcl1AxWO6rzvJDkxVx2PomhL9OjFzlcCLeXukE2S5F05tA49nfVJFH18VvSuUSP87gcfk0UkcanFZftbqs0Gnq0nHoWP37gfy20rpoNbi4fO42XyvwFf0DpTnYD4BioHSkBvccodGXI6hQXHmHzkdJqBuKDYYTSMYdxk1T0AXAcArkc+qHDhke0v7tocx88tNsdWsstizaE0wguXoZ15cE36HGPRIuVHwgihZl47qfU7ZeCcJyHIU9EddjHqAOyYjkdvm6uooY5MQd+fPl/QAuvcH9orycN0KEfdp9SVb5a73q4uGLLMwKSBlXZi18Udb6xm29lT1Cld7D4eZKSujUqU9rNKal9vXONDxY7qaIyfsn3eRH6VGiqPN6cYd1x9Tk5WGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(33716001)(40480700001)(82310400005)(186003)(44832011)(7416002)(86362001)(16526019)(5660300002)(4326008)(81166007)(70206006)(356005)(2906002)(103116003)(70586007)(110136005)(8676002)(54906003)(82740400003)(478600001)(8936002)(316002)(41300700001)(16576012)(83380400001)(336012)(426003)(9686003)(26005)(36860700001)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:56.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b716f3-4348-4f14-cfbd-08daa0c69f91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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
smp_call_function_man()y with on_each_cpu_mask() to simplify the code.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   29 ++++++++--------------------=
-=0A=
 1 file changed, 8 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 87f3f8018c92..532bb0025054 100644=0A=
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
@@ -2121,13 +2116,9 @@ static int set_cache_qos_cfg(int level, bool enable)=
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
@@ -2569,7 +2560,7 @@ static int reset_all_ctrls(struct rdt_resource *r)=0A=
 	struct msr_param msr_param;=0A=
 	cpumask_var_t cpu_mask;=0A=
 	struct rdt_domain *d;=0A=
-	int i, cpu;=0A=
+	int i;=0A=
 =0A=
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))=0A=
 		return -ENOMEM;=0A=
@@ -2590,13 +2581,9 @@ static int reset_all_ctrls(struct rdt_resource *r)=
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

