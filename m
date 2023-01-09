Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D46662B93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjAIQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjAIQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:30 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339285F43;
        Mon,  9 Jan 2023 08:44:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7wFe6iZU3KUWloP9l+Kp//CI6Sr3cu/vkzD4s8duY7Mn0uYRSNo5y67R4ccWtGnLkK0wz/VpiYWIIglBV3/S6JCgqNp9QUD9pvyl2kXC+YqoxbZFNWfCdb/3Xc/wUDMtscpYWBUNtY44x/4AHsb7/3qF5D/egg1w4WLFhMscBpl58VSTge850LsEUMA/R8l4ML/ICLalRDu6wILAnJLQvPYGIkXmvpsMaI7THZE6PoEODtkH1nj94hZ4qgqel/f+ar7RMByKP/EeJwhGGqGkPQdAeT0UnDWrBvXWxJyKU9mzvgkFP/8AbBpdspbn2AFGXzowU8tkqFq1ohrjE5ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0bR2q0emfUDh7SYHWelwMKwpBqpUM7KkxYqPZ2X+e8=;
 b=V34tt7tARkA4RXG4qtTxo1BuL+gw/aIJuICTjA8FAIx1rokJzBI6dwpPZPxQXRmsfKlkXGonw5+CQRM5fbXmz7sZCElYj896vOC0z2p+kmcvgiMb1+nkcdm4O8CqhkaoqA3bJs4K3J9AzUzHcSqJhVCHk3QxCA2n/VbPPxhWH/O1n7mRY0Rh701AD4EbiHaVKSRdf+ONVQBb2CvFOMibzHW322WLKLFGiJFnWBso7tToWwduHm/mK8KZnGHpsKpoIV92m9gXWfjIrQqqPKCYDBcnXMui87dza2UVIi38jlaWoAyE+SsfCYR0PAC0HIveYhtvYjHuKtLFCi85ThfkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0bR2q0emfUDh7SYHWelwMKwpBqpUM7KkxYqPZ2X+e8=;
 b=esnj17hb5xgLjcXjq+EVdFxHpqwkrCRKQE3r065MJODd2Jfi4zk4J6HIoJ0yz6FVbD4Z8vPOIQf7GAGSLNIz6gMl3o0/R1sOSuoNNBChRLF0Fq82oTFhDu40auyqP5f5BZitXCl5JIn06MiW8ve7bNEw2VvyRKwOMdd3PK2D3Q8=
Received: from DM6PR04CA0015.namprd04.prod.outlook.com (2603:10b6:5:334::20)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:26 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c3) by DM6PR04CA0015.outlook.office365.com
 (2603:10b6:5:334::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:24 -0600
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
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v11 08/13] x86/resctrl: Support monitor configuration
Date:   Mon, 9 Jan 2023 10:44:00 -0600
Message-ID: <20230109164405.569714-9-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c1f9ae-12b6-4d4b-f978-08daf260c548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LyFlG/bNjcVZdHfeYcanrkvtp+d8ISsWSbU5CKeZbEH4jTurKI5Y2oev1TOlSzL8vuLu74bqIWPFNAZNKt2Pl+im4a1W47nfpE3vgISNhdZeL3PpECFTLUUbgGRvdDjr0RS+pV8p6eX34+mk7eHP2SO2XZzOyFpAAkhi8pSA4QN1ipGEd8T/lKJGedjnSAZFc3Y0XP+IfynQJx4bFqTuQ7TeHAlTJbl4b/KEG9ZDY+DAYLOqQtdBfmzKYGcilp+LhEsgZnTIw9bS2Ds9/beM0gdKtoGU2NJrXsrzhlKF8ZU6fW/0c8oQ9ZFV2KSZe1DKdJ4LfLQAalrJq8XyPg7ZMFb2bxuRyNgG0N0OZdYgJ6Fb7M1KN5hbkQZ9lh20v3estimRtoRIegEnkhvmPnknQbf7Gu3yL42oahTpeLYoyw7kCyy7e7S1yr5Rp9lsjrgrp6fHRdEdJlNQvGvyXhiLMwK1twqjnFXeacqNArLZzVhA7jFhxDHsdS/yAfqjjTkWcqrbBea6tbeysGU/vWQZ6iLVTLlJDf78n20f7iR1pEpm/8y0owVfZbDkrzV3PDAwG9QmkrX5F0pBBjAO/m3XcHGmmcr6vPDdlMm0oWn+jcXOLrIVFZ2smLMwOukCRXBDOsEvsmHVZ7CN6a4JM+p78ayasrQczBDt+r4VTyQIFgBgCbi9H7dPEDlZ/MEWd9lyEnOmpHI+BpINImvnhBy+asWSJ1/f4KudiG5E0gxNmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(82740400003)(6666004)(81166007)(356005)(2906002)(478600001)(44832011)(2616005)(7406005)(186003)(1076003)(7696005)(16526019)(26005)(316002)(5660300002)(40480700001)(7416002)(82310400005)(83380400001)(8936002)(36756003)(86362001)(426003)(41300700001)(47076005)(40460700003)(336012)(8676002)(70586007)(70206006)(110136005)(54906003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:26.6241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c1f9ae-12b6-4d4b-f978-08daf260c548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new field in struct mon_evt to support Bandwidth Monitoring Event
Configuration(BMEC) and also update the "mon_features" display.

The resctrl file "mon_features" will display the supported events
and files that can be used to configure those events if monitor
configuration is supported.

Before the change.
        $cat /sys/fs/resctrl/info/L3_MON/mon_features
        llc_occupancy
        mbm_total_bytes
        mbm_local_bytes

After the change when BMEC is supported.
        $cat /sys/fs/resctrl/info/L3_MON/mon_features
        llc_occupancy
        mbm_total_bytes
        mbm_total_bytes_config
        mbm_local_bytes
        mbm_local_bytes_config

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f16b8bc5448c..0605b04f1b7a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -52,11 +52,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @configurable:	true if the event is configurable
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
 	char			*name;
+	bool			configurable;
 	struct list_head	list;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e33e8d8bd796..b39e0eca1879 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -783,6 +783,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	if (ret)
 		return ret;
 
+	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+			mbm_total_event.configurable = true;
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+			mbm_local_event.configurable = true;
+	}
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index aa469d708991..f34c70c7a791 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -996,8 +996,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = of->kn->parent->priv;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list)
+	list_for_each_entry(mevt, &r->evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
+		if (mevt->configurable)
+			seq_printf(seq, "%s_config\n", mevt->name);
+	}
 
 	return 0;
 }
-- 
2.34.1

