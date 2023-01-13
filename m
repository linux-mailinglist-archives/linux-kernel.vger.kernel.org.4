Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4665A669CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAMPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAMPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C37D273;
        Fri, 13 Jan 2023 07:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0ct+K30L1KXgeWWIeFY3RbRs2uCkSTuN4HzufhI5zlPCTQBlJYwKohFQ7E0clbP4XZV1euJcHDV0VvIYG0YCXhOy6G7xL3IpnRKPRCKKRbSwL6P/w1qkbTxetzdWjYPovTJKDg10xA62BVsvS79Chu+Hvg14+jE9Tc6/ojo+KFcc1WAPvbFn2HdWkkBhZpzU2fS049qI7C/oUSOD5tS6/P15ja/jcKWNmY9maq5ewR3K74YY+9OqkO0LupngyOXBrslOy9I94o9rMfDt4WkEz1WQCqAJ6yofwcelUrjhVoqhw1du9ZDpVPbvIRjAcBhPQzTzZr1KL7rTnc1k2aqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ/w7MRsnf1UDW+u5jMUtZCElSrGZ7FSYYp+dTVp/zo=;
 b=Mlsi344lPGTzftcP3i4g4mqpLUZLHJT2TusBaR6xJXqpt2paHgcMF9EcHYwbf38TfIgHXOPbahWrqZVUK61+QMZA9Nu2S7YUMKdAjcegfWpTAAPPiANnOuEUJv1wo42hcASzLMM7V0Zhxm6A9c+P6tBpOVGs16icE8nVDTJn2QBN7en0uX1w8tO5CrgvbUu9xKUiC4mgGr70hGo1om1A87pAn4ccEMWBWwf99OYiZFpAHFp/Q2QxfhujXZQs12ge6uDMbFMIbt2UD+S3IWB1QZixiYnXE0Iq9EJvbUc1+acy+tYIRlNmBVCECPWWThCcXxVpzibL+r4Rk+VAya9ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ/w7MRsnf1UDW+u5jMUtZCElSrGZ7FSYYp+dTVp/zo=;
 b=WjcnwoZUDD0A4J0/Gg3CJb2YlNkfcAGoHmYk6bbOrB8nC14JaKq0FgbnhiWDMzsCAvDea2pxBpMb+YcOkaNK9erCwsBoKtjUFNn3fvJ04Qd4J+vmlU/3RMk+CRiupPAXL1EOfZ34AQhOwVsXRlKswdlOTUEJdaPoT8KaSLQKAeY=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Fri, 13 Jan 2023 15:42:49 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::a1) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:08 -0600
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
Subject: [PATCH v12 08/13] x86/resctrl: Support monitor configuration
Date:   Fri, 13 Jan 2023 09:20:34 -0600
Message-ID: <20230113152039.770054-9-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1b5067-28a9-4a8d-6ba1-08daf57cd30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3jZUi6Gv67FC9d3j/HkbnB5b9dr57qbeZvsCgBRhIboe3FjQXfSoiIW66xDgjLXeB/cjUxb5VcTEj8irRBKC/cXlIqv0ip9A5Pu3LzDLsbA2GDfKz7StTCkcXrfEC0WMuFHQn8TtffC646wJxcrTVOlb9DMWANfctTR7/cblk3RAEq3v7pWPm521JAedf4s/B0NwVaAwWe5GzjVo6TOe0nd1Nbx/WLCTPBZSCoERyK//4YcxwrW3ltP2LCF8SuGEUFWeUcKE7QL7zop88xY+1EUyVh/KrS5++EoDSJ2+1hVb7ihmByeul3TSwmu4pusmWTLiRLIhiDCPIMLOUNv/kVTL04gdGsMHsBPTfq/VDZ8Eyizk5IQ2rYcVnRpMYJy3zKH9CwTLlO5RMbshFMS1oepl00iy+dK1SAPkNG8V1RWsaT1OeP0dyN82XYCudnL4gG4wdwVsaPSgWf61IU/THZGrfhtLmnQRH3Hj/DVSNPhx4v8abehxOc4oZyDiqzjWBM8IJG248sjlTS1PSCYOFRGJZWU2AP/CJKY+t66q7aCb32h512PrFLnbW+UXMppC09wpDxuCr2a3QLrf76LoD2gHoQT9L1e3rMIpoNntGaapXarVbmXCpibR/TbUQjV1c2G1xfpAJGPJg9bnFHSjrDTQYNJRfsiOJiKaC0oWqbA9pIq9I1IH4szEmlFxlZg2Mppf30aK8DspVHzvjPaOGDCHh0vAWUIggI3k7R2YzY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(478600001)(40460700003)(36756003)(7696005)(16526019)(26005)(2616005)(6666004)(186003)(70206006)(5660300002)(70586007)(8936002)(41300700001)(8676002)(4326008)(110136005)(7416002)(54906003)(316002)(44832011)(2906002)(7406005)(86362001)(82310400005)(356005)(81166007)(83380400001)(82740400003)(336012)(1076003)(426003)(47076005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:49.0834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1b5067-28a9-4a8d-6ba1-08daf57cd30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996
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
index 5665ab9725ce..cf7b6e59fa29 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -800,6 +800,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
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
index 75169680516b..bf0bd4378e13 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -998,8 +998,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
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

