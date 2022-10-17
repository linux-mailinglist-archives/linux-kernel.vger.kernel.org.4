Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E81601C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJQW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJQW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:27:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2222814FB;
        Mon, 17 Oct 2022 15:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npkGBj9Mxxh2aQSLf0OxSea44tmNtbi5RSJQDM5h63oT3TRKgF4ePdlrfO+Y7cPUSn6jTyZYEo/0wOdckBoSicxHH6BCTWphE6agEJKi/V7eAwme6ghLlaBXkwFNAglzhaiHqS/lC/eSRb0zkmrODG4tnmqZtQQHTXKPx/obGOcmIy1e/wXdKjGXRBliJsLaeu0kj2P3jIcfqB50D1vjcS2B/Wx0xUeR6B7anJeaDqlfRaj7OtHkmGWvmp+mGbFCUxZ7lt28FuaK1F6orPxV1O2OgRo3UI3rNfW1oizrxh+vNYAWHKAYhoKeTRh3wW4TojjoF4serirZ01C775rkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHmsdfuyUZgBV9NaapYbUaxFPpD5iENV7ySgSROjkVU=;
 b=BlNf0pXcPIWdnEOLhb6/Qz+2dqk/K5bBK/AGiduR3wLMNE+zN/DkioZIaorvWNzn96snl5QSskc2L1qTN53CG77mNk7vJn00SGrhN9NtbyT6yPldoBrpJWKBMkrq9DeiSAnP2p8cgiAGTwSv1eu2ngYbkL3CQR8a2ht0j2D/1C8ShIs4QsA75oZWHevSPEl+3B/vNsusx1Vd4pRC7DK5UuEU0yWo2CwaVaU82qxx7gTnb0GsWCQvpZR5TpPEeFjWORW2p88RbjqCvlf+P1QbEvVk4b7pEuX9umFDlJvNfIEPL9IeuuDZqDcFr9zAUNDpPsGCHaW0Ud5m3w1nX8ckbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHmsdfuyUZgBV9NaapYbUaxFPpD5iENV7ySgSROjkVU=;
 b=0qu7VaiK8XKGPHM//aGzCL6MmaUJbxZSwJsCNDW4BL++0m5KRMqAAurvDplHbpUhDEXe/RzD+zGPz5NoInqLoq18t35oD6WYPh0qHQjh1Pz2XmPcPj9Ep6LMW3BYfbh3pCPSZOOmPtBOurYeoiDWiBzRhdqh17R11y+cwDEFAm4=
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 22:26:49 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::fe) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:47 -0500
Subject: [PATCH v7 06/12] x86/resctrl: Introduce data structure to support
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
Date:   Mon, 17 Oct 2022 17:26:46 -0500
Message-ID: <166604560666.5345.17936133716540279017.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb674fc-a675-42a1-7d8a-08dab08eaed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROEm9rrqo0ftJy+Mb8b3wmDI8XWrOvRYt6k6l1gKcINDFE7Or7JhBd11PJyubPPpQ26qWYKyM9rTCF+m2klnl8GkupbAzS+FcedrIRqS0yY73EdXN4jse0hE0tpb1a+c/BBw0v0gLuckPZ48/9i8pk6rZ2JOQ1PAqe8MuugM6gJqPvxHBqeZTYmMnVSqgvv6lS/vEtJzZYI0v5gwiLi8gZSBCR13MbFDshQqZN3P0yQf03cV9g4lDipuIZ9dsYMB1V2rgQD7kPeZj468ppeMlyMRn+iqKaQgkKSJVOdX0lXgzFUBwGoDX7hnbFLjoVLFmzxHL5emCB7gqtISei3r202x/M0rzS/wNp1325YMn+3Pl70GznEIB6ZY09CJ2vXENy5dEbcRjTquVV78CadkeDtNiJcEp5TlpppvQDsn4NB54/n/y2GMJCH+jz+XK96gyc7BEK10bUaHFUOUGpMd+eUtwbgqwbq7caOdO7qr3hm8PmJxNgwMGs/RiYVlYiGSkaRQN9/v/KQCqCbsM0IljcQBp7ZzlZZZGDm+nf2O4GG5lrnYTRwsX3L4BnZS9kNbHJ9pyApYYMS9bcPidBruQHu3p//ckPxG7tswVrpPHpTAJDpzgRwrlUkaFeTBXyUYhLhAmdWqAjRJC0/TUv2/N12fvxkI3mDDDwcHAX5vGC2Fw2fe4X3tDj1xNjxAkPc5Ul/UQkK668Df/09OT6UNB7IQhOTCFT71y64pWxFv0XnFsAkKxA0VvjfB9REzn3NJJDZqsSiURtFvvroWEGmKW7pj0f74T8VAehIT6wPki0eMTMhUk45ZSpK8mziD8bq3glgy6C92y1sT4tM6k273KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(26005)(9686003)(41300700001)(40460700003)(186003)(478600001)(33716001)(336012)(16526019)(44832011)(4326008)(2906002)(103116003)(7416002)(5660300002)(8936002)(82310400005)(86362001)(36860700001)(110136005)(16576012)(54906003)(82740400003)(316002)(47076005)(426003)(8676002)(81166007)(70206006)(83380400001)(356005)(40480700001)(70586007)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:49.0687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb674fc-a675-42a1-7d8a-08dab08eaed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

