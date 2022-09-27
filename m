Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B65ECE77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiI0U1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiI0U1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:27:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822F8A3D01;
        Tue, 27 Sep 2022 13:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzwFHXvZoKMG83w/R96Zf7GX0RbGThoUlE6Ipk79Fecz+E1LRqjyEYFCufFFmy7ScTRFa+CfZ8dQM/qpZnJrsYEgpi1LBMYLtPFUGfMrT9yPLjg3E+qRNRs8cFk9pRWevW94AqhOP5iAQm4v86Dj8Zr9PdKY2IW4OkNSCq/nxd2WIbjBDdjr/UJYdnB2RjESFO3UB91e62FWJihkoV7WNL6iVoxjE26VZdl1/d3e5Cgd5AEiYhodsXiM1ZWchLT7k9GXeRtSOYHmUL+nuCfPy8z/ZEN6CfMsmvSzLGGsQs/vpIebx6omp3ejKqf1loU541U1LX6ywohaD4a8FgPPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHp04ho8LOg+MTTcoveJgFLVuJEAaa79PIWes3zq4rY=;
 b=PLrasZY6sVOcDvKQPuTsNgdrnQb3tXOtgOTetJL7ojaM+uCljwum0YrSVsOuu/aRSSAu2tEXD/XYg7mTkgzMS2+CDHDb38YCqdyAqKDgbEgcSyORCYqrexSuNHu03A7rjQRnxGQS6KKUO9QR3kpKZiKrojFnYY1ahboS6LjaAgdDL62oqlOmPpT351uqOKEOHrQBsCIJrZzU/ruiUVnpKWAmDt4shWlMgEzlBTNezd05Kl0MACxzy1Ai471shBMJvY2qpTfD2keDrbRyes4uRIsFEHx4Om+/TPXeoQ6Qb0turo4qU1MMmpesxqPRolXBB0D4X2rVE6jOHnuZmSbuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHp04ho8LOg+MTTcoveJgFLVuJEAaa79PIWes3zq4rY=;
 b=G/JYYTkSrIzTG6SpX2mTw7SSTrXrHVxuCZnXK3OfP0LeQHniDxiGKXjqUWJ4FHRYxRuMNMzrTMxKQ1LJ6HLgczaT+OncwHL1bJh1XGLiUqMJtFsvneUxmmYQv3bHXnZfuLDg0yF47JjmX2P5YTLsxXmU/dhIevcNKv6K9reIAaE=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:26:42 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::da) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:40 -0500
Subject: [PATCH v5 09/12] x86/resctrl: Add sysfs interface to write
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
Date:   Tue, 27 Sep 2022 15:26:39 -0500
Message-ID: <166431039972.373387.17483031820875867626.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: e313eb0a-448c-4d0c-1b32-08daa0c696ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXPAcLr4W2lW2ahbm4aqJEZnFKefSbX1LqL1Guqd1m3L2nN7XY/+ODt6pefOj523wH4sH6YQbO6nX8mvD2quGMtgO0XVcRNTRx/x2006CK+u6ebC4SBY6uSxWy6E/0H23t1azFj5A0LRoFUj0t8sUegB/Q5TKgAlXcM/5uceMvyqzLbfVZiKMGhUxLAarqVBohI8ifDVFQbyB2gKkDAv29sc9yBywj5+uSDPtdXugq2Qt0hbAh9TPzaianYcnsAm6l86SF220ZQUQBKy70IbUSF5Nv0z0NY3purvxrtiwJwAY/gk+20BjyBO4YzBcaxDhBiHfuICeGCG22xervU1MA01nIKM01WcEz7FVHpqrWW4L9qYujubyXwTZ6pVrM5vR12gKHGy9fkh3BzDUg/MRyTkcOdLZWXtReA/WfUemf0TpN0xOdQUvq3CKpSRsJ8MNRUScPdOyixMLUvHCBcuMOVlI4N2ye0+gm7q3KlK6j4k55gHGLhELsUglV0d3Zrv6C5u/tP/49f14tTLgQ+HyXw0xOLYw6fvWjY+xg6+fobF1mYJlbETQ40VlB5kR97jKSVXA/aHNLn/CSklzS8mo3CddRtlRU5vV4jJD9jze+HLtjQNgdTpynVWilLSA+ZzTkAmnnAEJv8BdeAd5iSKdE364mDDgGyOjC/gKVMTv0njq5hv+nbzisqSQ/TM0THuCGrLQdSOc99FlviJgAXQCNZeZ2sqozD5dDkM5k0ltujgYBfKLB/ZI41vyA0sD0cexEPM6zLx71i6KHqf9ST5aKvGXmK3p16ucNd8+13dKQ+QndYaPxG4fNgQR+RDGYXPoOezSOV+FF3E30yNNENp4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(110136005)(16576012)(54906003)(82310400005)(316002)(2906002)(356005)(41300700001)(8936002)(5660300002)(86362001)(7416002)(4326008)(33716001)(44832011)(70586007)(70206006)(103116003)(40480700001)(47076005)(426003)(186003)(336012)(16526019)(36860700001)(83380400001)(82740400003)(81166007)(40460700003)(478600001)(9686003)(26005)(8676002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:42.1277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e313eb0a-448c-4d0c-1b32-08daa0c696ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595
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
The event configuration settings are domain specific. Changing the=0A=
configuration on one CPU in a domain would affect the whole domain.=0A=
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
To change the mbm_total_bytes to count all the reads on domain 0, run=0A=
the command.=0A=
	$echo  0:0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
=0A=
To change the mbm_total_bytes to count all the slow memory reads on=0A=
domain 1, run the command.=0A=
	$echo  1:0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   23 +++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  139 ++++++++++++++++++++++++++++=
++++=0A=
 2 files changed, 162 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 44d3f18dfd69..d19ade3b5ef3 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -51,6 +51,29 @@=0A=
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
index 27bf6ade0dbf..c1d43d03846a 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1491,6 +1491,144 @@ static int mbm_local_config_show(struct kernfs_open=
_file *of,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+void mon_event_config_write(void *info)=0A=
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
+int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,=0A=
+		     u32 evtid, u32 val)=0A=
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
+	/* Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask */=0A=
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
+unsigned int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid=
)=0A=
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
@@ -1594,6 +1732,7 @@ static struct rftype res_common_files[] =3D {=0A=
 		.mode		=3D 0644,=0A=
 		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
 		.seq_show	=3D mbm_total_config_show,=0A=
+		.write		=3D mbm_total_config_write,=0A=
 	},=0A=
 	{=0A=
 		.name		=3D "mbm_local_config",=0A=
=0A=

