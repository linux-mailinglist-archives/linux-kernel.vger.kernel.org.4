Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC961A1C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKDUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiKDUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:01:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A144B996;
        Fri,  4 Nov 2022 13:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiTT/roqYHQyIZrQkloAOQjG2/c22CxzyVfeJlHHJx31jfETehR1bZts8O7P5M1h+zXM8ec9xQANFKH9ZsvC4z1UZhqyQTynK6v86U3pDV452/v97CJcuPqZOCL3+mzwJzsiuucKUO7qUbeaVWEeTV/4rwiNaMpPxKGbtgMNU1mmhRQAdM19Zde07nnSfQ2ROB1tNoYOIKV9fPvXPTjSaWjfKhH5N++/D+YzKEXc4HhxzG7Mwx0uc9b3a9VtC7v3B17lZJdXV5SK8L+KR29s++awfB3qBqFYOqT1BR72yeVVW40nXcz2f40/1Pp1I3Q2kRnYNdWoVvtwKyJeoB9+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bdApC+C+Pz47I6PY3IaepkhrLN/PquXbV0FTP+h2+o=;
 b=XaqW4DSwEBFiwPsRY+YwtD5RlR9A3GKbWJpn5nHxgPKEPxCoT2Vj+e3V0u7PM8kGn+BOB6of3Shy6oEv+JoUfIAfmAwREHr8KxKJYRSX7UwChS+CaQYKZ9NCwnp0x4PxXREV0ZkhjGbBzvYPpYqgkKOcAjphcik7ZXMylv9VWgNwR970GMGnW/FnNQaII1vQJ0BtUgqGedbKsSY0NJt2rHfqJ5R7TllOvcoqmMtwapjXJAso3Njup/ZV9zzF/mDslnrT4p2pTccpI+uDZVBrnNwxrrMk2PfyK5/unDegA6XyENw20rtjJlZSKc2xi6QsllEbVMYSeD8g6N5DxuMr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bdApC+C+Pz47I6PY3IaepkhrLN/PquXbV0FTP+h2+o=;
 b=bBAj2uQ5+KwErJ8xF5JcoE4dAZ4puYqx6josSkKbqAwW7/50YE1SyW+zDAONMUf74KegReAOEUVc4cU2flqVrykAr8PI0WV1sewpNaCdiGcQdZjHR7jqTBI2DXVjY2agHMl+tTSI3hgx+tm/n/XtDjdqcL+xTrSHn83I4Tsb1fg=
Received: from DS7PR03CA0286.namprd03.prod.outlook.com (2603:10b6:5:3ad::21)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 20:00:57 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::17) by DS7PR03CA0286.outlook.office365.com
 (2603:10b6:5:3ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 20:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 20:00:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 15:00:55 -0500
Subject: [PATCH v8 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
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
Date:   Fri, 4 Nov 2022 15:00:55 -0500
Message-ID: <166759205510.3281208.11437041392524040365.stgit@bmoger-ubuntu>
In-Reply-To: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9873935e-cdbf-4177-d730-08dabe9f49ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvffVthzzfomMIfThegbj92TAu/I+9VCLNuBLp09H3y5/Vym4rfmGYD+OfEKJaxQ6iX73GyVAb8zwC5JNbSY9zj/LKeoaqnEl2qJ1oGaQBF4A1jPu+j4aFAwhyia8VQkGXqxWlMENuDKK10O6VRLqagMHMMCD2IiL4D9TRDFqZB49XR055jA8mtGH5Kv3Pu/HXhUzHvw8kz25mONLDQMeIoUNzkxLtHjGob190q3wkhXeNyb8Xvs1csH8n50201833UKQeoxJ70I20OkAhUsX7I4UfHjhzGIwWiTPbGnxZypb0Jifgep6meLYj8czu/6cvbuFRrkhQrVR5+aps5trhtOYlRufJZOdOzXH/yOSgtFpIgPJAu+JpXL6uvfeF+e/6pZjwX/utD2HeePgUzthvwY3XjG/DcweSnwu0adaW0kg5I9c8FeRQriPRKmDZ1lFqVVq6yHHjafZ99jgICkrPru4ib/mD+i5V6SdJtOLi4WcCr13e0mswyKtk5CogdSBZrTjh0dAzdgYiTQzlmhH9wtZ98WkexkGXxswk4HPStkX7yd4tOVKNveOlRgDUigcoDhjx74miq+YxqjgzbzbAQcp42bGsCMaWu9W74Eun5R8JgCuqJKS1s/DYEcMt/zzNl7qk/077DQWfcNxyQmYt/qBwMbdZ6/L7h1TnwExzQTQjzJyWFD5yzJgxghOS0x6XHGOQTcgiBlP3DeE2gnd/i+cxYceEaVl72u94jQjmqn1sdVuk6cCiVT0aUawX5gVGcmfP1Y7OoAywqyWTWtySin4ZYUA2FCRvn7pCbLdh+c7iYWsc5BgjDvl/etnhhGXOt4pnV8WBE098VWX3JEXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(47076005)(426003)(2906002)(70586007)(70206006)(4326008)(40480700001)(86362001)(82310400005)(316002)(16576012)(110136005)(83380400001)(82740400003)(36860700001)(356005)(103116003)(81166007)(33716001)(40460700003)(54906003)(5660300002)(7416002)(8936002)(478600001)(41300700001)(9686003)(26005)(16526019)(44832011)(186003)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 20:00:57.4941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9873935e-cdbf-4177-d730-08dabe9f49ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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
the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.=
=0A=
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
By default, the mbm_total_bytes_config is set to 0x7f to count all the=0A=
event types.=0A=
=0A=
For example:=0A=
    $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config=0A=
    0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f=0A=
=0A=
    In this case, the event mbm_total_bytes is currently configured=0A=
    with 0x7f on domains 0 to 3.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |   28 ++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    1 =0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |   87 ++++++++++++++++++++++++++++=
++++=0A=
 3 files changed, 116 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 5459b5022760..c74285fd0f6e 100644=0A=
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
@@ -41,6 +42,32 @@=0A=
  */=0A=
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)=0A=
 =0A=
+/* Reads to Local DRAM Memory */=0A=
+#define READS_TO_LOCAL_MEM		BIT(0)=0A=
+=0A=
+/* Reads to Remote DRAM Memory */=0A=
+#define READS_TO_REMOTE_MEM		BIT(1)=0A=
+=0A=
+/* Non-Temporal Writes to Local Memory */=0A=
+#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)=0A=
+=0A=
+/* Non-Temporal Writes to Remote Memory */=0A=
+#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)=0A=
+=0A=
+/* Reads to Local Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_LOCAL_S_MEM		BIT(4)=0A=
+=0A=
+/* Reads to Remote Memory the system identifies as "Slow Memory" */=0A=
+#define READS_TO_REMOTE_S_MEM		BIT(5)=0A=
+=0A=
+/* Dirty Victims to All Types of Memory */=0A=
+#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)=0A=
+=0A=
+/* Max event bits supported */=0A=
+#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)=0A=
+=0A=
+/* Max configurable events */=0A=
+#define MAX_CONFIG_EVENTS		2=0A=
 =0A=
 struct rdt_fs_context {=0A=
 	struct kernfs_fs_context	kfc;=0A=
@@ -542,5 +569,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_d=
omain *d);=0A=
 void __check_limbo(struct rdt_domain *d, bool force_free);=0A=
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);=0A=
 void __init thread_throttle_mode_init(void);=0A=
+void mbm_config_rftype_init(void);=0A=
 =0A=
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index 06c2dc980855..a188dacab6c8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -787,6 +787,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (mon_configurable) {=0A=
 		mbm_total_event.configurable =3D true;=0A=
 		mbm_local_event.configurable =3D true;=0A=
+		mbm_config_rftype_init();=0A=
 	}=0A=
 =0A=
 	l3_mon_evt_init(r);=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8342feb54a7f..dea58b6b4aa4 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1423,6 +1423,78 @@ static int rdtgroup_size_show(struct kernfs_open_fil=
e *of,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+struct mon_config_info {=0A=
+	u32 evtid;=0A=
+	u32 mon_config;=0A=
+};=0A=
+=0A=
+/**=0A=
+ * mon_event_config_index_get - get the index for the configurable event=
=0A=
+ * @evtid: event id.=0A=
+ *=0A=
+ * Return: 0 for evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID=0A=
+ *         1 for evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID=0A=
+ *         > 1 otherwise=0A=
+ */=0A=
+static inline unsigned int mon_event_config_index_get(u32 evtid)=0A=
+{=0A=
+	return evtid - QOS_L3_MBM_TOTAL_EVENT_ID;=0A=
+}=0A=
+=0A=
+static void mon_event_config_read(void *info)=0A=
+{=0A=
+	struct mon_config_info *mon_info =3D info;=0A=
+	u32 h, index;=0A=
+=0A=
+	index =3D mon_event_config_index_get(mon_info->evtid);=0A=
+	if (index >=3D MAX_CONFIG_EVENTS) {=0A=
+		pr_warn_once("Invalid event id %d\n", mon_info->evtid);=0A=
+		return;=0A=
+	}=0A=
+	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);=0A=
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
+	mutex_lock(&rdtgroup_mutex);=0A=
+=0A=
+	list_for_each_entry(dom, &r->domains, list) {=0A=
+		if (sep)=0A=
+			seq_puts(s, ";");=0A=
+=0A=
+		mon_info.evtid =3D evtid;=0A=
+		mondata_config_read(dom, &mon_info);=0A=
+=0A=
+		seq_printf(s, "%d=3D0x%02lx", dom->id,=0A=
+			   mon_info.mon_config & MAX_EVT_CONFIG_BITS);=0A=
+		sep =3D true;=0A=
+	}=0A=
+	seq_puts(s, "\n");=0A=
+=0A=
+	mutex_unlock(&rdtgroup_mutex);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int mbm_total_bytes_config_show(struct kernfs_open_file *of,=0A=
+				       struct seq_file *seq, void *v)=0A=
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
@@ -1521,6 +1593,12 @@ static struct rftype res_common_files[] =3D {=0A=
 		.seq_show	=3D max_threshold_occ_show,=0A=
 		.fflags		=3D RF_MON_INFO | RFTYPE_RES_CACHE,=0A=
 	},=0A=
+	{=0A=
+		.name		=3D "mbm_total_bytes_config",=0A=
+		.mode		=3D 0444,=0A=
+		.kf_ops		=3D &rdtgroup_kf_single_ops,=0A=
+		.seq_show	=3D mbm_total_bytes_config_show,=0A=
+	},=0A=
 	{=0A=
 		.name		=3D "cpus",=0A=
 		.mode		=3D 0644,=0A=
@@ -1627,6 +1705,15 @@ void __init thread_throttle_mode_init(void)=0A=
 	rft->fflags =3D RF_CTRL_INFO | RFTYPE_RES_MB;=0A=
 }=0A=
 =0A=
+void mbm_config_rftype_init(void)=0A=
+{=0A=
+	struct rftype *rft;=0A=
+=0A=
+	rft =3D rdtgroup_get_rftype_by_name("mbm_total_bytes_config");=0A=
+	if (rft)=0A=
+		rft->fflags =3D RF_MON_INFO | RFTYPE_RES_CACHE;=0A=
+}=0A=
+=0A=
 /**=0A=
  * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file=
=0A=
  * @r: The resource group with which the file is associated.=0A=
=0A=

