Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E335FA64F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJJUbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJJUak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DA27FDC;
        Mon, 10 Oct 2022 13:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kT9kdA6mtey1Br+ET2Y3mOqSpkzfrePKdqzyuLpkem1tgPPh6wLPRLi3nztqS6sRDpFGrjA9FpGwOp3w4/DOehkau4gcWu8P93vDEmjsTXoNZiT9SZAGMB3aHb0FmgR1aXKY93SRACE7D8TIC3hyk4ZfRnBVQbtmI1PfMFjPvtjQUnm7qKVn+HPHGqgehh2KZq1XLulYmD7AJSKv9SOoAAOB+05K89X8yNZbGyyjXx37oPRWBa59RRWDrgluYSiAwS9iAGIf44ACRchuPQw52QGOlsUD6GWw73ecp2iMKfOU9h5hmxQJy4Bg/n1bQ7bzTSCayVFGk5O/zP569d9q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTZF6Tlzw2g49zJT3SRnZMpoonEFStYI2O9xOZnyf5k=;
 b=KYjU9Od/WrS8q8/xm579dJAcSdnTr1dRVsRtzI69mSbnQYgSFl18kgf5KTzahJuH8KR1G6KClEznHDEQRC0KwT7NHoTHkUJuGw8sM170ngsue6jxrYUl3wEm/gokE4XL+kDl2SoH9snQ8jFwR0Vi/RT2Y2Ms0b0uXFzL1UBhSay5AjalsD3e7bp8oriOBnmq9J+A7mVVS/3fCQTkbKCjiGwULZMFrjczCJA16zfgds3xnKWVeQMUHRwMejDhi7txSxsNYlke5bbUxk3eRVmGrH+kVlW2d4OLh/VImGPtgpiyvDnpujBJnZB3moOBgLQgHXkATDnPTuVG97ffsemtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTZF6Tlzw2g49zJT3SRnZMpoonEFStYI2O9xOZnyf5k=;
 b=McNeiSZYob0f0qEPgNggVq5tHVQ2zQJAGXQ56WRR8daWr3zWacAY/VKR0JjGS+s7rx+wahpLpjmqaM/dFoswGX8qzrLYw7BmCXQQFSiln90LfcwODXjznBVQLz2EEXKjMHitu5P3mvp5GjwMY2dhJCyOgCOdhxk+ZPkq2L8/5Vk=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:30:06 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::e2) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:30:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:30:03 -0500
Subject: [PATCH v6 09/12] x86/resctrl: Add sysfs interface to write
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
Date:   Mon, 10 Oct 2022 15:29:58 -0500
Message-ID: <166543379820.23830.9029078361756200962.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4de28d-7c94-40b4-3e2b-08daaafe37b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6I17ci1zd7ZjxdaPulKylGUmO0Pie3tLDCRzW+CcyVtZh3I82oFr/2Aetr8Bnl8ELaK6EJnsNeE8XhqfsGZ0fm2YFxsVsQ3J/wMs6EQdNH5p/bZmMEMVgZggmDZp1GtMwv+MicEQf0gX6ACWMjV60lfm1uiLrz90V233fzIzWEcpmEb70B66Z2MighP2g3jJVGkOadbt2y9IadvQrLGTZGSMJveu0JmQ6zq5OIkX0juNOyWp7ibvYskufw9njN0t4dNag5HKFWxeCsGQPvkK4pzy6MLCYk0tNP5FlsNjOKKwQBXE9K4N3iIOMhzgT/iaqDn6wk3UARI1imjlBkeG9YofurtYG4sqAMvloH29wRjkCogV0hY9TPcvso4bo0yrkIxVnIiq9CZ0whZezaqUr34gl/FgRLL9pwQV4OxQuhEe/uXPdDJM4ts+0antUYKiEWzxHh75+N8UB5OI3o27IXg+ObywH5TOW5g/hdeVgt1/CohIGxYpEIIhYRt3bxYY2LxiujkV/JppxBMSaiMcCDC3hJtWNqaZKfPZpQBwXPjgBE5UDiMMl6/Vgtc29ET4H9UVy64WzB4OpMh5fsuJqKOLrDThgs4fxInM2/QjSv1/kz1VuAGdKOY/oimMTqcJmadcDOYO7bSDLRG2CzWRYAumiJsU5JIhzUgAu9ts6sSRf3m2iPWYVP9p1tSCYLb/lcrRRSLQOId/QiSes3NMvFqhPTVEavs09IgX3rqePrwxypiHngimEdtMgT9pQ2vAzT98GN5bBA+lz63739Ji6cuP88Hn4np43aWB+AvjanLa7XkgIADfmrkiVEYICIWN5eLSGzYe9mfUSmKFAlZgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(33716001)(356005)(82740400003)(82310400005)(81166007)(2906002)(41300700001)(40480700001)(5660300002)(6666004)(26005)(8936002)(7416002)(9686003)(44832011)(70206006)(478600001)(110136005)(336012)(186003)(16526019)(426003)(47076005)(316002)(16576012)(4326008)(86362001)(8676002)(54906003)(70586007)(40460700003)(36860700001)(103116003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:30:05.8277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4de28d-7c94-40b4-3e2b-08daaafe37b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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
To change the mbm_total_bytes to count only reads on domain 0. To=0A=
achieve this, the bits 0, 1, 4 and 5 needs to be set which is 110011b=0A=
(in hex 0x33). Run the command.=0A=
	$echo  0=3D0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
=0A=
To change the mbm_total_bytes to count all the slow memory reads on=0A=
domain 1. To achieve this, the bits 4 and 5 needs to be set which is=0A=
110000b (in hex 0x30). Run the command.=0A=
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

