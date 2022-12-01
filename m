Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E417963F426
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiLAPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiLAPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:37:01 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5BAD308;
        Thu,  1 Dec 2022 07:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRDxha4wk3V4zxArTH5aG+HhIn8UoiWw3GoUlU9pjidApCb768hT+W7q0a2OAxOAh1IHYD3RBf0hLTU77MsCeMaQ7m0buVUbrx5t4znr/5NzxjgYwMeZnH2k3XqSRVfBlKePtWwoBoGT5Q1GLDUT0ckLFwW8NaIgrqLhn7RyNtM7/+APqaOAeS4PfzBNl8Ht+zpatPsxUVmU+zPYK6O9eoNHMg+gEJjDPcEVUWYa82q435NzBcb61NQSY/az6s4owcJzds73NCYGmuYwsO7jJ0+uGB7EkpxwKVYA66V+QrKr+q3ODEZKSY6oxiGbed5Ewig4Tq3mkM/q3d2u+xfIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kp0l745S1XIu7+8yr6l2+/6YQvSMNkE6vuVre9tAq6o=;
 b=Ojxdvwi+ch/1Nx6D8I39OU5L/QiduejIb1DruvlEX4BT3nrr2EAxH4r2+2P1rEoT9uPseAWmztx176dDsC0t/JRqp/eDhSt1HssMoZg8+7N2481nrfustktyNs3bnXrbWOILqJlY0A5GK6/4CkvIjwvvNdwWv+gEoVjgYKWee5LCUWGi4Siskb/fS6HaEsrELKQcODLZmiADv2Rvyi6Er30Dz3uoZWWAw8hFRSn1UiOwCJUiM7q/ULFnKVekGBI2OZJYBF3a/2e3IBha7rItscv1TQ0tuGzli3gpzYFFTgPEgx5nra2BJ8eUs1Z0o7/+ffx2u+OtIB1c2mNt1BMfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kp0l745S1XIu7+8yr6l2+/6YQvSMNkE6vuVre9tAq6o=;
 b=LmR5H0NIS5vC/2Y7Jnu1KlpeOTVyHSabtbU6doE14hi/WvSJxddV3s/G18QBLN8yI7ExqN9QroN0qmeLqAo+RQDXm0RO3Ur+KYnsqxVvj4EFZWp3vZfG9KRJHXSaEcMGMJaEpnMGTC8EfYOB/PDyE2GT3pUaR9n/VpSszT2iZWw=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:36:55 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::2) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Thu, 1 Dec 2022 15:36:54 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:49 -0600
Subject: [PATCH v9 07/13] x86/resctrl: Introduce data structure to support
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:36:48 -0600
Message-ID: <166990900849.17806.5346239458898437535.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a37182-d919-4846-e2d6-08dad3b1dfec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2tlRxIJGysZvD8ohQWmJ9Z0RRWdtUCFQ2+TbxFBGviW7oB0e1NNOLj1OEqI1EgoczgdzheacekEQGExzrkXIu+3YDAoivKDbd/DZSeaxZVxvqiqiPuaVPS7U41+xStSb+blKkleagcbOfOCzBRlSuzH+RAc7M8h6pB/cKBQNfqbC84r3UIQxVb1gyBo4eG6Y20gbBPggYyMoXQ4NnZKBdrA3B8xQalUFvzSC3b2e2VYtIrikfnG6VcgWrXxbqlzSzdJG8QZnabr0yhcyCQWYAREnVZQGkIKIr3RzMmhN5kcb+DB7AC4nnDgq7QQIBmQMp4IblRBzn3axapZh0d6reo74tDzwEU/CSVyYqEAqxMySva4U1qD90ejw16XKYkhXKxCR9+l+uigaIpl3RwFFdl7B/tBQ8H1m/IIDKD2s96QXTemezuD/tBJKm8juWRUX9bE7vfUrGjXnfD9mrwqHXgn3lqcZiVLUqhUgvlNBhYxRA1qtEkwyxDBQuxmqKWH92E899g1rG9AuUXzBXMhB0wN5eL2Q3z9cwubYS/in5rfNserGoOdyqRTsEAx5ovdAi1Y3lYfRokucV4EGab5ahK2jOztjj3l58Lfvoh+G09IuZb3lJzpQfd/LRWIW5j1OFALc8u0zpPrCIvBnG/7+l6JJARI+bG3eQoFnnEVQ7WbS9lDRry+UnjqC76M3aOQynMejsBEwt6KSTtoOz8VAqSLqSISfH+B27Jzd+/6FC3SzqMpKak0Hc3sEO097iljTCvuZdtYSc3sX1wlegVuDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(7406005)(41300700001)(7416002)(8936002)(5660300002)(44832011)(4326008)(8676002)(103116003)(110136005)(40460700003)(81166007)(86362001)(478600001)(316002)(70586007)(336012)(70206006)(2906002)(16576012)(47076005)(26005)(9686003)(186003)(16526019)(54906003)(426003)(356005)(33716001)(83380400001)(36860700001)(82310400005)(40480700001)(82740400003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:54.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a37182-d919-4846-e2d6-08dad3b1dfec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
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
The resctrl file "mon_features" will display the supported events=0A=
and files that can be used to configure those events if monitor=0A=
configuration is supported.=0A=
=0A=
Before the change.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_local_bytes=0A=
=0A=
After the change when BMEC is supported.=0A=
	$cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
	llc_occupancy=0A=
	mbm_total_bytes=0A=
	mbm_total_bytes_config=0A=
	mbm_local_bytes=0A=
	mbm_local_bytes_config=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    2 ++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c  |    7 +++++++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-=0A=
 3 files changed, 13 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 7bbfc10094b6..b36750334deb 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -52,11 +52,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);=0A=
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
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/re=
sctrl/monitor.c=0A=
index e33e8d8bd796..b39e0eca1879 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c=0A=
@@ -783,6 +783,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *=
r)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	if (rdt_cpu_has(X86_FEATURE_BMEC)) {=0A=
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))=0A=
+			mbm_total_event.configurable =3D true;=0A=
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))=0A=
+			mbm_local_event.configurable =3D true;=0A=
+	}=0A=
+=0A=
 	l3_mon_evt_init(r);=0A=
 =0A=
 	r->mon_capable =3D true;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index 8a3dafc0dbf7..8342feb54a7f 100644=0A=
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

