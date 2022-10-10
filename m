Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A873D5FA64B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJJUbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJJUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01260CF;
        Mon, 10 Oct 2022 13:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrWl0vxF4dIKbyDCSCd0N4cix1yN10T1U80S8LY9SCAwTbbEo/VqUKHzEQfEeiWV9rUUwaMWOZZaWt1R+Qj5cGyGhZdWEFCYCQNoeWEAv9Oewu6xJijgxqakaxTTBolgjzRe93v2d8YNatrYUrIZ+JwJ4cUp9zdhkAnlZGCwRmKQY/TFQQWdUU7JcFANt3hMDMo2PzhdAgMZUoQgY9Vq9rXUKEOelF+Sw7ibcJVya05ahfPHjbp0nMuTAsMyEqLn5VCfJ+Caj36f1BC7Ttno106EH4SoUKuKfkVXSacvTgVen/7z6mM1NLA+LmAbDFfEltWMJB2CykdXU71fuiYiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFKQDlQ71ja5CyJc1/CwHTE9DbdLdyCNXuACEDqeNA4=;
 b=oXNLTyctEu9+xQjVKHDT3G/WKHCSEi+Ers8omqpXjZ4ruz+MMkWv6iPADM4V9i2oEKaDM83vKupke+mPwXQADTeTXbkoH6czm+FUmb5bbqdCG3bXSmRhiccfGPVkp3xhRv48/He7HDtVvmrDdAE3w1o5qh+EVgKU04xcTszRO8u6zSNXIVzd6zA5dO4wvcdr1zXJcfsY1G7hKlxmSF2+M/pWtsMIEMh1x0SALAAERjmcQEZW+zqqaFTCktZu31bgLi+bAsP+Ved0VEjDFlGPljB0jqiNBCllv6HWRwzzLUxmqWjNZ8nXeJN/ZfdJ+raCtAki3/ljGIQqdwV17gosTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFKQDlQ71ja5CyJc1/CwHTE9DbdLdyCNXuACEDqeNA4=;
 b=RDIgpld/pCLWWsLEIE1rsKaIyVAxLDfHmVaSetH8NiIBZIHMokAyTNjfrkpdukkQODFbXzsU36lcn9FpKOmHPMqMTk0Z5hZbEfyyHan/QtdWTnFmeZSEUPIYmO3VQMtClZuePiR5N8YAL7stWrAIB6qljN51yilt+JapM2y5Tzo=
Received: from DS7PR03CA0290.namprd03.prod.outlook.com (2603:10b6:5:3ad::25)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 10 Oct
 2022 20:29:36 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::96) by DS7PR03CA0290.outlook.office365.com
 (2603:10b6:5:3ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:29:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:29:34 -0500
Subject: [PATCH v6 07/12] x86/resctrl: Add sysfs interface to read
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
Date:   Mon, 10 Oct 2022 15:29:33 -0500
Message-ID: <166543377343.23830.10906905028303177147.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT009:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e49a088-e825-4021-4992-08daaafe25e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20dzXc5N8CPR4SE/fEVtcct+2HVdGuq1wF8LkhCktHLwiCIcsSvbPnBU6jLKWFQwAlzykwHFzZ8I45HRjM2Z97duR0S1R3F++fb+f5x7ngc1zPOgADr+NSaHMcwO48wxsXCNScuOIDgl1v4jg0J6HUDRYle5pdT6g750yWscQ9RpHMBRiV0yGS0iOtW9jcwa95AnCpZstAYXFdQD0q87gp2SBR/gJVdz26A6/VMwYiSKxPCqTw0EK/hvWqYq8st02xbyAaLrOT3PWG2IWsxbrryV3BfBIGRg5JPRphzSGh4JoNxrhXPSs7tiEA7kU3PnGkLssvHcVD7R916ymiZy2ucejxKhSRdYBnTaeY3gmyKoZRCs/53pZA7g836RQqPSvsssPR9wWkvyFWx8SM/sumAya2o2Ce+AdeAvSnLXW06TaZtJ2jmZjML8jpkKa1++7Ws6Eda+lSsuDzi2Ih4XkZaY0NrkSM3r7ufeJqv98F+DAQB2VL36NYaSgpVr3lu1fEpZi+p7fnju3+N1aiSMyUmUDMRkdfIEydCkxQFt5hh9sWUG6ylug7P2NAO837Wn/5QDfarHSTh4OlwG6lArNxc4/iUCzyn0X8cQIfaxn7PJ0womJ5weuDorVyjHycI4Iyvb0JB9GR62gnbI5hN//DhbifzFTLyUb3vFpDSMYXJLF5BDYbK52FXKVeW9imHb/VQ7tlp91rCRfZD5JYSXg+oLcP3NsVXWYW5Zpmyv/ADe3GxJjjZ/3zu5TGNhKl2sWf9nfHJ07rP/dILPsVTppA7Owgpc5822VyUMuRxWxgacQyOTlwVS6Wz+wpoJg/3/eSiG3boEWvY8dK+2atrWJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(41300700001)(16526019)(33716001)(40460700003)(83380400001)(8676002)(81166007)(478600001)(5660300002)(2906002)(44832011)(7416002)(16576012)(40480700001)(86362001)(4326008)(336012)(8936002)(9686003)(186003)(316002)(70206006)(356005)(103116003)(70586007)(36860700001)(82310400005)(110136005)(426003)(82740400003)(26005)(47076005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:29:36.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e49a088-e825-4021-4992-08daaafe25e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
    0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
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
index 46813b1c50c2..758c5d7553a4 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -826,6 +826,9 @@ static __init bool get_rdt_mon_resources(void)=0A=
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
index b458f768f30c..326a1b582f38 100644=0A=
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
@@ -541,5 +542,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);=0A=
 void __check_limbo(struct rdt_domain *d, bool force_free);=0A=
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);=0A=
 void __init thread_throttle_mode_init(void);=0A=
+void __init mbm_config_rftype_init(void);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 5f0ef1bf4c78..0982845594d0 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1423,6 +1423,67 @@ static int rdtgroup_size_show(struct kernfs_open_fil=
e *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+struct mon_config_info {=0A=
+	u32 evtid;=0A=
+	u32 mon_config;=0A=
+};=0A=
+=0A=
+static void mon_event_config_read(void *info)=0A=
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
+static void mondata_config_read(struct rdt_domain *d, struct mon_config_in=
fo *mon_info)=0A=
+{=0A=
+	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);=
=0A=
+}=0A=
+=0A=
+static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32=
 evtid)=0A=
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
+		seq_printf(s, "%d=3D0x%02x", dom->id, mon_info.mon_config);=0A=
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
@@ -1521,6 +1582,12 @@ static struct rftype res_common_files[] =3D {=0A=
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
@@ -1627,6 +1694,15 @@ void __init thread_throttle_mode_init(void)=0A=
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

