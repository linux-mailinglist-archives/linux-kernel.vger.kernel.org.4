Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D815ECE73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiI0U1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiI0U0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:26:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94BB7296;
        Tue, 27 Sep 2022 13:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZzfezcS9E/yXWch8RpNVjumfq/CCd9zRwpbNCngmaOPRhPXeSRty5yfO1apNykchIDA4zzFm/PGvYsNpprCDt8AuONCNJ9+RFyqqHm8JEyOHrfU1orUIgLGCZTNpUnB3auIyzSL276ZQNs7KrQkQSO4Pv01OoN1g45jJxopymUMDrriWtN3NBI+NU2QCGLvRFyjmbSszjgq+EjRUznwFh0MXSAcfqIg2LDpgf/BFFKQRNtSl/uHPKUpnegnesMF9I/me2G7IenmJtqnmplMXQ8AwsnS+jfUJOWW5+GX+/y57RIrcqhd3EUXUi+eNp56nVFVAFiyNhAfVNyRpLsMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWlmvlnadJCucXgbW1rM6mFzJTlU/LSovUL83VQ4zDg=;
 b=SV629VSO85GUmQlGh4cF2slfP9z1Hs8QTdqaWHUSk2M9qSzdQ/2U6pcJsFTEr1K/5PP+mcrZuwtX/U19/modg9AeVO6VukSuTcb8ZbWCyEBAB4HvBBc2QhfPLYvRMN3qfUEdIVqdTvALhWC8oCVsDvuhaFd8k+xex3QIJt1AmZbMZ9k3j3NNpVJkVtPiCS2jZAE0TRquEWD2FIJkIB3QhtcI1sAN6TklwvspWHHWI2+SUi7cFjfhKxsdMo2M0SWe7hVXc4vI+/E6b1rRg0L2pvlwoQZbsI3GAuAr3sdsQpqvsqGvj8ldH9y6jrAm++aXFlXl2uKVaJfeU1N+ldUBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWlmvlnadJCucXgbW1rM6mFzJTlU/LSovUL83VQ4zDg=;
 b=EZRM2MUTtpXKs8bPprqr6tq2mN3e9T+5pvEkHiDidotBOVlwCMr/5XSi5lTWtwKnKHoSjLk+GWagdZMQxUxcrrsoDlEWTqZ/N2R9+OvcrQ+1BR0NNJSIXwfrAeAHOhJS1wPXDGB7vqnXyulTRFl0pUJp5zzB8Et7aPGRhThGslM=
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:26:23 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::67) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 20:26:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:21 -0500
Subject: [PATCH v5 07/12] x86/resctrl: Add sysfs interface to read
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
Date:   Tue, 27 Sep 2022 15:26:20 -0500
Message-ID: <166431038074.373387.12300700929220707129.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0978407b-48a7-4ad7-d4ba-08daa0c68ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGfP9Z0cqSE9v7sB5+YoUmpG0n48OXqC/QPqzlGLVs8Mfd8+SSyWhafm1ZiKl1dbPTojlsxq5xUKaCVnugXdGnazvkGB7mApa5e4KKWS5QMGyBmtNMUAyWnMJ06OwKHlDY6tCiE1bng6X/quwYKnjxa3aCr6pUDk90kiXpHdwnBcAFDcSmxGTVgxo1TMLUw4gJT+aDCVK0UI4RA4L3GFrm3gxdlSctQciM2VAMOczNUlnd3FMGVNfqiQ5a+qtnTNIWgHgGX2nmqUmh/lfcS8GkzncXNw3f2PFyOZyn2RrmgUxyzfe2/POpjaaZALa39OP/DRJ2khVO2qTL6Ma6dADPEwytil7yG0YFl+z4puD0otaqFHqlqG6EnpJaqcjHqG1yZ+TWgJH6cGbbEZLIAgLAyQYRpUB+heCVjImRVLXBZ+ErydvZWlSYDfMRmUXsh2sskFL9nzzqL8LYRMHNFbeHXAIWYF2vIjt1NgfLL2e/2i+WgMivmK0YJzWpf7dGJYBn3i36vNLAq1o3xD1R5+cJFOs+kaoIhHtglafPbYrAWq4owb/NfgR81i7ODImLR75w8WuLdgr0uXfXvthLnbXaU5OilvclI5qDtdX0hxT+eFd1sHWNzmZXwo4RtUM/u1zSioqYIVK4I3hIQ5iGywOddjnTMeiJBbtKyHgo/OIRPK9wQ22ChHXZmzmKSjHwJ7Z5XJk0qpltOXfvhz3ODbu7CHo+uzAm9U+uLMCj2GyJVMtx98P62obfMmQkqs6fqyQMFI9iL5XRfLGyBILDP2v1VpV9AjyQZED4B9vsbYyxA8mdNgADfF5JeIn/t7vmqrMGYNG18e1XSS0pzeg38QaDPMp8defzxEzUn3Xr+qy0GACvgT2QTmjN8yhqjBx22y
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(33716001)(82310400005)(47076005)(478600001)(356005)(81166007)(316002)(2906002)(9686003)(26005)(16576012)(36860700001)(44832011)(82740400003)(54906003)(86362001)(110136005)(426003)(7416002)(5660300002)(336012)(8676002)(83380400001)(8936002)(16526019)(186003)(4326008)(41300700001)(40460700003)(40480700001)(70206006)(103116003)(70586007)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:23.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0978407b-48a7-4ad7-d4ba-08daa0c68ba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current event configuration can be viewed by the user by reading=0A=
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.=0A=
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
By default, the mbm_total_bytes configuration is set to 0x7f to count=0A=
all the event types. The event configuration settings are domain=0A=
specific. Changing the configuration on one CPU in a domain would=0A=
affect the whole domain.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_total_config=0A=
    0:0x7f;1:0x7f;2:0x7f;3:0x7f=0A=
=0A=
    In this case, the event mbm_total_bytes is currently configured=0A=
    with 0x7f on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    3 +=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    2 +=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   76 ++++++++++++++++++++++++++++=
++++=0A=
 3 files changed, 81 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 513e6a00f58e..b3bb8badbaaa 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -861,6 +861,9 @@ static __init bool get_rdt_mon_resources(void)=0A=
 	if (!rdt_mon_features)=0A=
 		return false;=0A=
 =0A=
+	if (mon_configurable)=0A=
+		mbm_config_rftype_init();=0A=
+=0A=
 	return !rdt_get_mon_l3_config(r, mon_configurable);=0A=
 }=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 4d03f443b353..44d3f18dfd69 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -15,6 +15,7 @@=0A=
 #define MSR_IA32_MBA_THRTL_BASE		0xd50=0A=
 #define MSR_IA32_MBA_BW_BASE		0xc0000200=0A=
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280=0A=
+#define MSR_IA32_EVT_CFG_BASE		0xc0000400=0A=
 =0A=
 #define MSR_IA32_QM_CTR			0x0c8e=0A=
 #define MSR_IA32_QM_EVTSEL		0x0c8d=0A=
@@ -556,5 +557,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);=0A=
 void __check_limbo(struct rdt_domain *d, bool force_free);=0A=
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);=0A=
 void __init thread_throttle_mode_init(void);=0A=
+void __init mbm_config_rftype_init(void);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 834a55d78e3f..b51fae77ba5c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1420,6 +1420,67 @@ static int rdtgroup_size_show(struct kernfs_open_fil=
e *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+struct mon_config_info {=0A=
+	u32 evtid;=0A=
+	u32 mon_config;=0A=
+};=0A=
+=0A=
+void mon_event_config_read(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 h, msr_index;=0A=
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
+	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);=0A=
+}=0A=
+=0A=
+void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon=
_info)=0A=
+{=0A=
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);=
=0A=
+}=0A=
+=0A=
+unsigned int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u=
32 evtid)=0A=
+{=0A=
+	struct mon_config_info mon_info =3D {0};=0A=
+	struct rdt_domain *dom;=0A=
+	bool sep =3D false;=0A=
+=0A=
+	list_for_each_entry(dom, &r->domains, list) {=0A=
+		if (sep)=0A=
+			seq_puts(s, ";");=0A=
+=0A=
+		mon_info.evtid =3D evtid;=0A=
+		mondata_config_read(dom, &mon_info);=0A=
+=0A=
+		seq_printf(s, "%d:0x%02x", dom->id, mon_info.mon_config);=0A=
+		sep =3D true;=0A=
+	}=0A=
+	seq_puts(s, "\n");=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int mbm_total_config_show(struct kernfs_open_file *of,=0A=
+				 struct seq_file *seq, void *v)=0A=
+{=0A=
+	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
+=0A=
+	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* rdtgroup information files for one cache resource. */=0A=
 static struct rftype res_common_files[] =3D {=0A=
 	{=0A=
@@ -1518,6 +1579,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
 		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_total_config",=0A=
+		.mode		=3D 0644,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_total_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1624,6 +1691,15 @@ void __init thread_throttle_mode_init(void)=0A=
 	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;=0A=
 }=0A=
 =0A=
+void __init mbm_config_rftype_init(void)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name("mbm_total_config");=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+}=0A=
+=0A=
 /**=0A=
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file=
=0A=
  * @r: The resource group with which the file is associated.=0A=
=0A=

