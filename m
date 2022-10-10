Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2F85FA649
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJJUbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJJUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:04 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C8C22BFE;
        Mon, 10 Oct 2022 13:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdLDBMgFzHD5ZaN4iA+g5FBvwKUeYiyiqqkfPxscHkZy3eA2yRsaWzQ1JBge/y1IFqNecbaWdJNYILujCxOjpP6iwrMMpJt25yKsJdW+m89EE2Fj0D7wg/O/h2cazub8tNomXr/yXPa65EoOuI+8G/RrOm6sfx32azq74GqjthjjQUkC+bnlHPyBrtsIA9SOc0XEVXqTJqtoA0zE58P9AOXC3mmunFaUtMTIt7/YWec414P/l3bikdOPKNFtBODRUMfzPP3j2ZMM0xh2NoQ1CFrFhMHk/+jFQMhSPbHQbx81P6Gd0Ok3Mzzyoo8mz7n6eO9t5qZgUFzq8YmWPcbWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHmsdfuyUZgBV9NaapYbUaxFPpD5iENV7ySgSROjkVU=;
 b=OfLN0ifdJoHrEvdIRmoSrVepas5pNTl46cQyHDj5Oc+BxgZapujfz0Zp75eAgq6QVw4YC6YfVv3M8Buekk72udmmritTyNXbm/EH+Rq/BzcJZ2zHS3cRNDWDUpNUGuTbGqkg6qP0UlEGMMgKisc6VQP1egFtJvjwj9G9WDu+OrMD6VzEgVwm3bCzT/2Q3oJPba7JJ8Lcx9U5wf9iq0/jHiSgyRH8LVft0s0LXLc4RdirnpCucpGFGCchSmhoaGF8r3hSMjEMHFdPuwsQPs8gNDSwWcYGSYqmTN9Qo/bjpEnrGFLlba7mvWszrFgutT1gHuxpG2mK5hiDY+4D4v4oQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHmsdfuyUZgBV9NaapYbUaxFPpD5iENV7ySgSROjkVU=;
 b=L7kcsx23juSaWO+X2Q4v2D2Z6DnV9OFl3HK1X+TIOYyO8CRux2NzYDWGqSyBPIaK0dMFwH+5JB52w8TDIU64Lpq9ISBQr8T6vpKTOd0Fjc+AoRk15TgAhkTLPzIuTz0najAFIhx65220Ry81rYdrM89dQUISzz6wRB9ldr5Zf9Q=
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 20:29:29 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::3a) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:29:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:29:26 -0500
Subject: [PATCH v6 06/12] x86/resctrl: Introduce data structure to support
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
Date:   Mon, 10 Oct 2022 15:29:26 -0500
Message-ID: <166543376626.23830.5138502593585732085.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 52442821-4cd1-4b45-83d4-08daaafe21b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y89+J21fVdSNCV7UrBvCmMaa7gA/5kqtpF38WwSnNTm6YWVRgRTPEJWfI3OD8aRol9J0E+99iTW5faHThB9odvBPhxu6ph5UyyJqiWTk3G+34d+U14VadEZOsiuu7z599OlnH8a9m0KqTV3jdJ6iuuicmZlIYpP5RMgOSOQFqie/lTEXyZWkKOQOYSpSmUbDY+7k1n5uNeIk1NE9doBXa+VDCfN8IY7tFaUys3kLANKOjiluu9IO/HvY4XJUbcG5zQBwsgcj2Q2nx7H4Sr8FKTo6TGgVm7wljSwCQggfkOLOnkA6VM0ashrH1B4mrlonyrV8bWjTDR6WoPbBmeGOWSq8iGAXis/f89rx0NIq2wv3P5XouaJHknjHQRfNNwj+2b7XZalnt48ZR2FRYURHBO1IODI8yDzIvo9Ld9B1GFQ7gGwam0+HkuvKlwBJw1AoeBB4We4I3vhDNmf8+AWCswB3yCDEEzwCHEuOeuWi6u4oZyf/vQee7NQchL3CHaGeUJcvrrtEyrSBL+zBk4wiaRQtejIerySBNroeWLtDPuOrurK9p7OwvkxmB392AzztP07T+VzodFcvB3V9V/c7zus9BVqDxakR3J7uuCFk6ipZMKBGgWjnl6AAiI91p12yWAnIcIFLtu59FMv8qfgbZgjxvpoWxlNTo6cgNDe+yH4FnQslTyCp0vq2qsiL/XsaJOPh+x1KnT/xOBBaSdMs6UUjcPqWcbTPDTL9XHlUL3ZBLLK0qKNoQ6SDJk4lb+DgRXhJxG+YJmLECW1m+Nv1TzzxxJ+G3bmY6Fd2qn2oJ/EYN297sGgy966o6fnwrxG/5OXv8LVIZiOQb409ZZSvYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(54906003)(81166007)(36860700001)(86362001)(8676002)(9686003)(16576012)(70206006)(356005)(26005)(4326008)(33716001)(70586007)(478600001)(2906002)(41300700001)(8936002)(40480700001)(186003)(16526019)(5660300002)(7416002)(82310400005)(44832011)(426003)(103116003)(47076005)(82740400003)(336012)(83380400001)(40460700003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:29:28.9524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52442821-4cd1-4b45-83d4-08daaafe21b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field in mon_evt to support Bandwidth Monitoring Event=0A=
Configuration(BMEC) and also update the "mon_features" display.=0A=
=0A=
The sysfs file "mon_features" will display the monitor configuration=0A=
if supported.=0A=
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
 arch/x86/kernel/cpu/resctrl/internal.h |    4 +++-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    7 ++++++-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-=0A=
 4 files changed, 15 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index d79f494a4e91..46813b1c50c2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -814,6 +814,7 @@ static __init bool get_rdt_alloc_resources(void)=0A=
 static __init bool get_rdt_mon_resources(void)=0A=
 {=0A=
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;=
=0A=
+	bool mon_configurable =3D rdt_cpu_has(X86_FEATURE_BMEC);=0A=
 =0A=
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))=0A=
 		rdt_mon_features |=3D (1 << QOS_L3_OCCUP_EVENT_ID);=0A=
@@ -825,7 +826,7 @@ static __init bool get_rdt_mon_resources(void)=0A=
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
index 16e3c6e03c79..b458f768f30c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -63,11 +63,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
  * struct mon_evt - Entry in the event list of a resource=0A=
  * @evtid:		event id=0A=
  * @name:		name of the event=0A=
+ * @configurable:	true if the event is configurable=0A=
  * @list:		entry in &rdt_resource->evt_list=0A=
  */=0A=
 struct mon_evt {=0A=
 	enum resctrl_event_id	evtid;=0A=
 	char			*name;=0A=
+	bool			configurable;=0A=
 	struct list_head	list;=0A=
 };=0A=
 =0A=
@@ -522,7 +524,7 @@ int closids_supported(void);=0A=
 void closid_free(int closid);=0A=
 int alloc_rmid(void);=0A=
 void free_rmid(u32 rmid);=0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r);=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable);=0A=
 void mon_event_count(void *info);=0A=
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);=0A=
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index efe0c30d3a12..4b8adb7f1c5c 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -746,7 +746,7 @@ static void l3_mon_evt_init(struct rdt_resource *r)=0A=
 		list_add_tail(&mbm_local_event.list, &r->evt_list);=0A=
 }=0A=
 =0A=
-int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
+int rdt_get_mon_l3_config(struct rdt_resource *r, bool configurable)=0A=
 {=0A=
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
@@ -783,6 +783,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)=0A=
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
index 1271fd1ae2f3..5f0ef1bf4c78 100644=0A=
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
+			seq_printf(seq, "%s_config\n", mevt->name);=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
=0A=

