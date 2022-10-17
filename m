Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6D601C61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJQW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:28:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA2814D9;
        Mon, 17 Oct 2022 15:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd/03qZCTNPpAEgVNW0D6JJVc13Eglc+Ul+J3SUZgVo8yXeEfaQKqLzQzi+/PnPCJ7Fex5TBRJLVlgGs65U27SWjKOA4+ADp5orcO/lYb9jrmBKkIpF3k0Lj2CilIFbdA1GBunOfzDuvd4dOG//TOTYqWPnael4m6+UnaY+ew8BPj9HXRnm/PaVHHA5z2HYdzqlI9A4VtAJAWS70kFM71yBLnkwdM1vQYKen9t8c34z49wDVNXwr/xEhI06iQ78pn5d8nN5SPSUYL2SVJOgF1t/QZy0oT+KU8j4/AL2ZYhAUJ/SwBvfYowq8TG4ykW5LdDRITJJjR34cp7VRBufEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bv7CzDbWswhhZMyEbNoAAkCOs7/1eJj6H82m1ZpCyk=;
 b=oJHO/0JLQxzSww0PSZhbKWiv82zqCfakLhLVB4NmwtEoTnpd5eSTA5indjnr9NV27spQ26K4HQaxtPQjFtD+xW2iHQ0gj9Zh2VNcfDVlcdL67NNpElzsbTGcLT3aLwTVNXgB65XIH0kFhq1rlvb8+vAOtIa8zwf0ipFmNX8BYOsum6f2vyv3pcKCjh2ptLnz3yPNP5qGVUkMv680EUs4VCCZ/Pfx6ehC8aoQPfE74zmspHz8N1CcQ2M3c3fubvexraW66fUljIWjRrSY4xo9VYoqh0zKs0Vn2pDUVos7sA7qE0YNsVxZKajecdpc397RTBSH8RH60+DazsO5XII8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bv7CzDbWswhhZMyEbNoAAkCOs7/1eJj6H82m1ZpCyk=;
 b=jGT2zPT+KnEbsRtpCqKrbodjo1EshqcUWmOTXxW4rFgwfgIdeeRXLCshX8vmXg4RV+4olF4SVcXvhR4WIcok5T4PdIDQUHjlmmi4uUF5Vh0Azaytfjo3MKAFgd0n4kiDNR/bn4wgP2RFFWuezBeS+hw3oafVfMBBMd6+JGHgg4A=
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 22:27:15 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::9e) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:27:13 -0500
Subject: [PATCH v7 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
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
Date:   Mon, 17 Oct 2022 17:27:13 -0500
Message-ID: <166604563304.5345.2402589906956965706.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: ac366786-2979-423a-1cfb-08dab08ebea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QclPc0lSZWBi1OPFJ79Ni1i+cF0TeY09XyAenS+5l5tFzJwnbVr7oyBpmCvfDrLj7aGCXiOgHfl0+tiwwuKHxAlPGJjG46NXdeOaWkcEPmTHz8f1/0H9GNL//E1HyYdtWvE76AFygQ9pgBeQPEJzyVfqVyRCFHhEnWwVnL2UF3X9cAbPIXd5kplP+XPD7qBTVhvWgEPKfBcIif9l+Tw+NNOr0Z3c+3hFFCHK/9czs0Gpnvl4Yzp5IQvhNo4yxyhHvo3lgKLmTZpFNFaO7Zo26Mbrf6MTmnOaD7bBKECf/mehjMOeUwH8qDo9wOMNT6RrLpMDcibIexSK3RgHW9m1PI++cheZVagOfJvirSMbyoA4NF+kQuowmVItejfjNFrIC7jDsCw1j2CSVVlImnM4RjVQZbxxjP+j9hzO8IhZEjXrA0YAQnGtDiKIWfHR32reA69Up1ZxhvM5q9B7O9/VelMHyAUrmXx09aP56FCpogx1ItEs8o0BRlTScC+4K53nV1cxGFuLsS3h3MEHHDL5wXr0MtzPLxmmLPEwuqwz92XMqRluMbpMZEBFOQUViHnsAQQa7O6L9oQLcTCqrTGPiISpd1NQ7qpHqyr5l67j4drbHB1WvRrHYhrx67qE38wltPlIH2PtTD07xO+8GMWxBES1gZ7HSzzvXuRdjv8KcNCP1bGMlG7AZOGLIcJC46kmrs4BjLIi+VcHLvb4Fy4ua92vJlT2Vy/qRFXTmRR2qicSUTeZitng5kUAv7Lemxxmb785BvnyNp7d86/wLXneREWOdWnJvFFJchTlYCNv7a0ZT+v8tu0Y0RndklaLJJs1bB4GjvexVy7GJNcatufqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(16576012)(316002)(110136005)(186003)(40460700003)(44832011)(103116003)(4326008)(54906003)(2906002)(26005)(8936002)(16526019)(41300700001)(86362001)(83380400001)(9686003)(7416002)(336012)(70206006)(70586007)(426003)(47076005)(40480700001)(8676002)(5660300002)(82740400003)(33716001)(82310400005)(36860700001)(356005)(81166007)(478600001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:15.6476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac366786-2979-423a-1cfb-08dab08ebea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be changed by the user by writing=0A=
to the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.=0A=
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits   Description=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6      Dirty Victims from the QOS domain to all types of memory=0A=
5      Reads to slow memory in the non-local NUMA domain=0A=
4      Reads to slow memory in the local NUMA domain=0A=
3      Non-temporal writes to non-local NUMA domain=0A=
2      Non-temporal writes to local NUMA domain=0A=
1      Reads to memory in the non-local NUMA domain=0A=
0      Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
For example:=0A=
To change the mbm_total_bytes to count only reads on domain 0, the bits=0A=
0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the=0A=
command.=0A=
	$echo  0=3D0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
=0A=
To change the mbm_total_bytes to count all the slow memory reads on=0A=
domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).=
=0A=
Run the command.=0A=
	$echo  1=3D0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   23 +++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  146 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 169 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 326a1b582f38..c42b12934a0e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -42,6 +42,29 @@=0A=
  */=0A=
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)=0A=
 =0A=
+/* Reads to Local DRAM Memory */=0A=
+#define READS_TO_LOCAL_MEM             BIT(0)=0A=
+=0A=
+/* Reads to Remote DRAM Memory */=0A=
+#define READS_TO_REMOTE_MEM            BIT(1)=0A=
+=0A=
+/* Non-Temporal Writes to Local Memory */=0A=
+#define NON_TEMP_WRITE_TO_LOCAL_MEM    BIT(2)=0A=
+=0A=
+/* Non-Temporal Writes to Remote Memory */=0A=
+#define NON_TEMP_WRITE_TO_REMOTE_MEM   BIT(3)=0A=
+=0A=
+/* Reads to Local Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_LOCAL_S_MEM           BIT(4)=0A=
+=0A=
+/* Reads to Remote Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_REMOTE_S_MEM          BIT(5)=0A=
+=0A=
+/* Dirty Victims to All Types of Memory */=0A=
+#define  DIRTY_VICTIMS_TO_ALL_MEM      BIT(6)=0A=
+=0A=
+/* Max event bits supported */=0A=
+#define MAX_EVT_CONFIG_BITS            GENMASK(6, 0)=0A=
 =0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 305fb0475970..25ff56ecb817 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1494,6 +1494,151 @@ static int mbm_local_config_show(struct kernfs_open=
_file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static void mon_event_config_write(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 msr_index;=0A=
+=0A=
+	switch (mon_info->evtid) {=0A=
+	case QOS_L3_MBM_TOTAL_EVENT_ID:=0A=
+		msr_index =3D 0;=0A=
+		break;=0A=
+	case QOS_L3_MBM_LOCAL_EVENT_ID:=0A=
+		msr_index =3D 1;=0A=
+		break;=0A=
+	default:=0A=
+		/* Not expected to come here */=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);=0A=
+}=0A=
+=0A=
+static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,=
=0A=
+			    u32 evtid, u32 val)=0A=
+{=0A=
+	struct mon_config_info mon_info =3D {0};=0A=
+	cpumask_var_t cpu_mask;=0A=
+	int ret =3D 0, cpu;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	/* mon_config cannot be more than the supported set of events */=0A=
+	if (val > MAX_EVT_CONFIG_BITS) {=0A=
+		rdt_last_cmd_puts("Invalid event configuration\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	cpus_read_lock();=0A=
+=0A=
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {=0A=
+		rdt_last_cmd_puts("cpu_mask allocation failed\n");=0A=
+		ret =3D -ENOMEM;=0A=
+		goto e_unlock;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read the current config value first. If both are same then=0A=
+	 * we dont need to write it again.=0A=
+	 */=0A=
+	mon_info.evtid =3D evtid;=0A=
+	mondata_config_read(d, &mon_info);=0A=
+	if (mon_info.mon_config =3D=3D val)=0A=
+		goto e_cpumask;=0A=
+=0A=
+	mon_info.mon_config =3D val;=0A=
+=0A=
+	/* Pick all the CPUs in the domain instance */=0A=
+	for_each_cpu(cpu, &d->cpu_mask)=0A=
+		cpumask_set_cpu(cpu, cpu_mask);=0A=
+=0A=
+	/*=0A=
+	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in=0A=
+	 * cpu_mask. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE=0A=
+	 * are scoped at the domain level. Writing any of these MSRs=0A=
+	 * on one CPU is supposed to be observed by all CPUs in the=0A=
+	 * domain. However, the hardware team recommends to update=0A=
+	 * these MSRs on all the CPUs in the domain.=0A=
+	 */=0A=
+	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);=0A=
+=0A=
+	/*=0A=
+	 * When an Event Configuration is changed, the bandwidth counters=0A=
+	 * for all RMIDs and Events will be cleared by the hardware. The=0A=
+	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for=0A=
+	 * every RMID on the next read to any event for every RMID.=0A=
+	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)=0A=
+	 * cleared while it is tracked by the hardware. Clear the=0A=
+	 * mbm_local and mbm_total counts for all the RMIDs.=0A=
+	 */=0A=
+	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);=0A=
+=0A=
+e_cpumask:=0A=
+	free_cpumask_var(cpu_mask);=0A=
+=0A=
+e_unlock:=0A=
+	cpus_read_unlock();=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+static int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid)=
=0A=
+{=0A=
+	char *dom_str =3D NULL, *id_str;=0A=
+	struct rdt_domain *d;=0A=
+	unsigned long dom_id, val;=0A=
+	int ret =3D 0;=0A=
+=0A=
+next:=0A=
+	if (!tok || tok[0] =3D=3D '\0')=0A=
+		return 0;=0A=
+=0A=
+	/* Start processing the strings for each domain */=0A=
+	dom_str =3D strim(strsep(&tok, ";"));=0A=
+	id_str =3D strsep(&dom_str, "=3D");=0A=
+=0A=
+	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {=0A=
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (!dom_str || kstrtoul(dom_str, 16, &val)) {=0A=
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric event configuration valu=
e\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	list_for_each_entry(d, &r->domains, list) {=0A=
+		if (d->id =3D=3D dom_id) {=0A=
+			ret =3D mbm_config_write(r, d, evtid, val);=0A=
+			if (ret)=0A=
+				return -EINVAL;=0A=
+			goto next;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return -EINVAL;=0A=
+}=0A=
+=0A=
+static ssize_t mbm_total_config_write(struct kernfs_open_file *of,=0A=
+				      char *buf, size_t nbytes, loff_t off)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+	int ret;=0A=
+=0A=
+	/* Valid input requires a trailing newline */=0A=
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')=0A=
+		return -EINVAL;=0A=
+=0A=
+	rdt_last_cmd_clear();=0A=
+=0A=
+	buf[nbytes - 1] =3D '\0';=0A=
+=0A=
+	ret =3D mon_config_parse(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);=0A=
+=0A=
+	return ret ?: nbytes;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1597,6 +1742,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_config_show,=0A=
+		.write		=3D mbm_total_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_local_config",=0A=
=0A=

