Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF901601C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJQW1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQW1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:27:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA981699;
        Mon, 17 Oct 2022 15:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd5YHmRFR4IMoToEJ3yqEv9CxLHx363QHd03U7MUcnE0qoSaLC24u7CHEjlIzWi2z3ckMj66DWIZahh4mpi2udeCIRo3m+7J7G12iGDKG7CH1hPkXsGVAKD5j2uWveV6hWvqmnbl4JLqKGlxPwQSkqFLKvcJJ22L8DBMRJ5xmsEM431X3qDT85RHm5uRCE2VjXT9O+OhQ50GP6reYu1wD5De7wZ3evShhU1D3sF4NIlP6hSFt0H7ygEaGXYaobecv6GWhS1Ju9Iw3K1xeLzE2D9iM1VucFHqvdq/pxHGJ5HL4seAbRMtS5OsOiafn/Q/UIurWzrzkh19IXQBTiGwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBc5uQI4L44w2VOYUdGsR67oMZjdqOaBhzJv42OYO9w=;
 b=Q9yqeVtMVIpD/jY+IvdkT/KrW9w+onDQfy5qZqy9i+PHNOiFWt9K54Hp8zHbV3rGPL1V9+q4SUlWSk9oF99SEJxgGXz4XCV9JIpfDlXue4Y0LjVlE02m38CL6I5Loccs4HaCq33npJ0EfDLzh9zrtT71ghK0JD7z5tlKuS04EY7EYtENk613+k6xMrfcNGOFvFvolaXGkgwQDkaHXxA+XR+LOXFBZ84byUqMkOaCUBK70QUsx+cnrtAj9mlACVNVDP5bzN/eP9GiJvDyiEE+bfiGMBh40IRl0dOJf82bir+L4YjA58y+kQU7ioVB1+m8Y6Cjb9UrlAQOlJj96xr2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBc5uQI4L44w2VOYUdGsR67oMZjdqOaBhzJv42OYO9w=;
 b=YP9VHvNtgnG36Hb6rVVx63MXCqaH+eOlumVo93XFu1A7mpfvZ/d+9hYbSXryScTTUNVrAKWFHuZdpEV+6YchmFem7VT6kSaFbo2JXRwIwrrqSVIcG2bXDAm/uyxVI+AGeZqEmmhD228UmISAFIqjbklzOywhEM+YCosHLypeqko=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 22:27:06 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::b5) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 22:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:27:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:59 -0500
Subject: [PATCH v7 07/12] x86/resctrl: Add sysfs interface to read
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
Date:   Mon, 17 Oct 2022 17:26:53 -0500
Message-ID: <166604561380.5345.17668177010598977321.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff6a9f2-6240-43b5-d03a-08dab08eb884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgZHywpcPFrj6OeJpntb7TGgciC+2eDlRlRhi86pzFFzLgh9oBlKV62aZ4aOWui/mmThvg1d9vqnsSDLt632ipQ8B46a3Ky7RN667+CxyprV/1odg+TrAphRvMDAWB1rI75ba5dJHD5DgUa2Vw4iys2+SGEpWFqx2rO5SbxcMcsuTs+/p7a008sZKjPx+pGp0tY9F7ayyxNmOnZVE7F8Wqn4hGMZhk6VEKHbY0uWaRBVvBUn0Kz1lK5wpuiyRPafcV1eLWBbzOs+50t09Nd+M20V8UmR/KKkp5Pmgt9W8mcbWtqD8NO2t+dqvD0ULJC9B2NrOYMgAafCWJBhisD6r0uHY9e1mpBapAKAMHEIIo17HjcYH0uNCJkdJmL9qbEF03O/8puZgo/jUDmIJ9F3EfStanaMUNZrKeXnl3qSqAYE4tEEqTmoAM3bueJnQYevVtR6OEcEwFkRG09NZm4I845qWyBPWWZJ8f1drEvllgRQPJRZ2K4o+ZKu3C6ZAEJ5HKQq6MhcN13HKfQ8Q763mjogIqvgXB3PYNByPW785QYg2m1bDmUc4qqXJJlDvOo+3G3WbXBEguPWvxE4PuSMcnxGkCe+dlCW4hWWStd76qY/m9dUlsVrTX9ZcbuBOoj58yTbY2u5f6SEZEnWVM+14ylBnXjA8+DqRDxoiSA/xGe5jypXHB78FLzs1vhfbmj7t1fX/rLjrGNJG6Zq79KgK5ZLz5EvwhN4OZ9vekjx19BVw6cAw0LsEIvb93bqvMjTXLBGzteagKevbGBvFtgDn+2VJKEAjQW1amjLc0jO6yTpRm53uZ8uHaCPXGJ+y+mMDCZe/CvqFvyNdOTMtmgf0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(356005)(426003)(47076005)(336012)(186003)(2906002)(16526019)(83380400001)(82740400003)(33716001)(40480700001)(40460700003)(82310400005)(36860700001)(103116003)(86362001)(81166007)(16576012)(54906003)(110136005)(44832011)(41300700001)(8936002)(316002)(7416002)(5660300002)(478600001)(26005)(9686003)(70206006)(8676002)(70586007)(4326008)(6666004)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:27:05.3434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6a9f2-6240-43b5-d03a-08dab08eb884
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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
The event configuration settings are domain specific and will affect all=0A=
the CPUs in the domain.=0A=
=0A=
Following are the types of events supported:=0A=
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
all the event types.=0A=
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

