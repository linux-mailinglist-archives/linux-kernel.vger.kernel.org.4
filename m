Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387B35ECE71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiI0U1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiI0U03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:26:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98298A4B97;
        Tue, 27 Sep 2022 13:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS97XflzdTfrfv3lCOD/dLaG4K9d2O2LDbWSQR8etvuhLTO24owiSoYDfK1C08krA2CN2vPQhq7eGH6HuIdakP9KFov8xmZ3V2xA/PnCUWBUyvECfIEIRCJdRoThCO0KYeu5fGl58HNYJfZ4h5NWeNSRZjVJqMG039lWZn4neWJuszhOCKToFQnN8v/6orZsqd8/86KLI6IQoh5shDGS39Ho0FE2iIfwbJZaRHp1daSAGCLXZnp4L2jg/aYLGNvv7x8JwW6N3gFxcvOmGpOxsBhzEoBKnlbBjczv/5rQ/L6Dade/fz52L+HVLfta+InVOqZPtkPF8ZAEgJgMTT5blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePnZglaI25+qLfkARQE5rXWhQcFxTJwMlrxWZcmomTY=;
 b=Yn8k0r8srL33t8bV2dmbEvpna8Koxh7e82d6/T0A/4Z4elmVq7MHYmmFaXPWTORZ09Acl+9wg/I9JTfXCVWDLIEx5WjdT7MuxiBsH7eG0SPoc3uPX6twBzCFBcyoMpSJcVwCJ7X8s00j1s06DgjFrNn2Auj86aMDjCPYYPMZQsHIfgWKz5+Ly0HmkqBlcBZ0wf4oEDM3Bjx3hzHL80Xc1Om+I8W3+RUqlhh7OI/nycSqFKda44LWRbn1ZlBSFVTf+wkx955VcSpyNiJo2eC8AT7YZuzRqT8r4rzEZGCkrjZRXHSdx9eMlBv1yzPYvyZlU92A10LWMHeYPhEoSMWKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePnZglaI25+qLfkARQE5rXWhQcFxTJwMlrxWZcmomTY=;
 b=kNNEuDYjvralH6qSJZUQvXTJ0vfzj+gSrT4kWDZfoqpWuUOECo5hkS2tT++CqXwiRxgNJ6G1AlxaYbBX25syNgmgxmUYkcqgoiL5uWzSIlUelWNNrL12/+3WsotzCOMWFxqEoixGyZLtu8lGuop7hacEFDNiGN9CKTvzeFWzzNE=
Received: from DM6PR06CA0029.namprd06.prod.outlook.com (2603:10b6:5:120::42)
 by DM6PR12MB4864.namprd12.prod.outlook.com (2603:10b6:5:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 20:26:16 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::bc) by DM6PR06CA0029.outlook.office365.com
 (2603:10b6:5:120::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:14 -0500
Subject: [PATCH v5 06/12] x86/resctrl: Introduce data structure to support
 monitor configuration
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
Date:   Tue, 27 Sep 2022 15:26:13 -0500
Message-ID: <166431037370.373387.14792678048042598706.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|DM6PR12MB4864:EE_
X-MS-Office365-Filtering-Correlation-Id: bca90984-3d85-4183-d775-08daa0c6877f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/Fv0FZkMSd201D9GUgJdrQntUAQeUqUm9H0qTayZil4FIGyDBZUMac1yTRfNgUp1EPHAFWbPHbO4mKo4/dWpdQGTRoZvxg3XmIYlhUNnF4ChLsA5i77TY7M0ZKLfa9oW1EWf1TvoCCudhIdBGZU+j2PwcFTr1MWacm1iFYmpdjHqa5gUUnYVQU3jIzR7Z5rK4sA461Cd+FV7J1zerY3p6+hzzT2CXqkHBIdKeh6BpOPKozcS0S4PNCoiawtFWTtwBQji27a8/l9FNYx5zut4C7+i7EDcFQ7sy+7u3E4TO09mmgXkgYw0jrEbOujpJ9UodTs9AgWe9EGkiYqdPrAYRvz76MYQcdfGQphbdYRUPvmylfGZeFSbSHAwNT5n9j79Wr7RHSdEu+TmL4y2vNReWDmpn1tDaw6ex/A5Wwq2OCYfWYUjeCH2St1WfqxMI+mKNX8Luv44J3LzgkHFOj7D0ulHWFtd5d3dxUAA8tP2yIN2oUCkAVgUegEEFAR38Vwi9K/m8fzso5ZOeZOzQSUgYn/JRI9wXrNJg7HGvmHUtigBcgBkrpq9iKTaLi/sV+9OWEckonAcpeMNWusEk7ElP2GQRKD30cnCL+zrBHHn0aufhLsO9sm/kvr4dnH8e4S7poy6xn6uFOrgHt+1aRKTw6YDw4ummwNmEKzER0NQ/pq7uIUyw1klyRP8VvwRSzLGR3KJaJQXNMb6NA0/0Gsu+0NLBdzMZVTRVKVqk8nG7L+Icd1pSD8hFNM7R7Iv0cILowoYZJRQwJVpete9LR1PjJfJnkkZZYXvyxla/1BtMhGtG/MifTpkWWXR8btMSugZrrTFzJSkbIOx4PZcQ6HbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(186003)(16526019)(83380400001)(426003)(40480700001)(47076005)(36860700001)(336012)(4326008)(8676002)(70206006)(86362001)(70586007)(33716001)(356005)(5660300002)(44832011)(16576012)(54906003)(8936002)(110136005)(316002)(9686003)(26005)(7416002)(82310400005)(82740400003)(478600001)(41300700001)(103116003)(40460700003)(81166007)(2906002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:16.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca90984-3d85-4183-d775-08daa0c6877f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add couple of fields in mon_evt to support Bandwidth Monitoring Event=0A=
Configuratio (BMEC) and also update the "mon_features".=0A=
=0A=
The sysfs file "mon_features" will display the monitor configuration if=0A=
supported.=0A=
=0A=
Before the change.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_local_bytes=0A=
=0A=
After the change if BMEC is supported.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_total_config=0A=
	mbm_local_bytes=0A=
	mbm_local_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |    3 ++-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    6 +++++-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    9 ++++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-=0A=
 4 files changed, 19 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 56c96607259c..513e6a00f58e 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -849,6 +849,7 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 static __init bool get_rdt_mon_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;=
=0A=
+	bool mon_configurable =3D rdt_cpu_has(X86_FEATURE_BMEC);=0A=
 =0A=
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))=0A=
 		rdt_mon_features |=3D (1 << QOS_L3_OCCUP_EVENT_ID);=0A=
@@ -860,7 +861,7 @@ static __init bool get_rdt_mon_resources(void)=0A=
 	if (!rdt_mon_features)=0A=
 		return false;=0A=
 =0A=
-	return !rdt_get_mon_l3_config(r);=0A=
+	return !rdt_get_mon_l3_config(r, mon_configurable);=0A=
 }=0A=
 =0A=
 static __init void __check_quirks_intel(void)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index c049a274383c..4d03f443b353 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -72,11 +72,15 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @configurable:	true if the event is configurable=0A=
+ * @config_name:	sysfs file name of the event if configurable=0A=
  * @list:		entry in &rdt_resource->evt_list=0A=
  */=0A=
 struct mon_evt {=0A=
 	u32			evtid;=0A=
 	char			*name;=0A=
+	bool			configurable;=0A=
+	char			*config_name;=0A=
 	struct list_head	list;=0A=
 };=0A=
 =0A=
@@ -529,7 +533,7 @@ int closids_supported(void);=0A=
 void closid_free(int closid);=0A=
 int alloc_rmid(void);=0A=
 void free_rmid(u32 rmid);=0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r);=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable);=0A=
 void mon_event_count(void *info);=0A=
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);=0A=
 void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index eaf25a234ff5..dc97aa7a3b3d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event =3D {=0A=
 static struct mon_evt mbm_total_event =3D {=0A=
 	.name		=3D "mbm_total_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,=0A=
+	.config_name	=3D "mbm_total_config",=0A=
 };=0A=
 =0A=
 static struct mon_evt mbm_local_event =3D {=0A=
 	.name		=3D "mbm_local_bytes",=0A=
 	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,=0A=
+	.config_name	=3D "mbm_local_config",=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -682,7 +684,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
@@ -714,6 +716,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (configurable) {=0A=
+		mbm_total_event.configurable =3D true;=0A=
+		mbm_local_event.configurable =3D true;=0A=
+	}=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 04b519bca50d..834a55d78e3f 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -1001,8 +1001,11 @@ static int rdt_mon_features_show(struct kernfs_open_=
file *of,=0A=
 	struct rdt_resource *r =3D of->kn->parent->priv;=0A=
 	struct mon_evt *mevt;=0A=
 =0A=
-	list_for_each_entry(mevt, &r->evt_list, list)=0A=
+	list_for_each_entry(mevt, &r->evt_list, list) {=0A=
 		seq_printf(seq, "%s\n", mevt->name);=0A=
+		if (mevt->configurable)=0A=
+			seq_printf(seq, "%s\n", mevt->config_name);=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
=0A=

