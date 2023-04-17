Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0956E5547
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDQXek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDQXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:34:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560C35FD6;
        Mon, 17 Apr 2023 16:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4LXXXfZRE43d0Wypyk+VdHBaN59ZXChXfK2G4nRQCU6uJ2OAxYjuhMOXO8BUSaqt+1jK56Xhwgj12+xcjIFjBK99K8VKbbwVqY+bdBz6sdCY5LBArqs6SG7BH5bnYHSnmoAfKcY/gG8Jp4zkdyLooXR4eZQMQInqqeqNi7sGY0hKCgAukhiF97sZw4kQTa6f08vnWy0TAwb3ecz1eyFA5lreD79JjHI8xgSTKBGUsy4y6ycIZc+0m3CuuI37i5vMV1vhQtG0zrskZJRndYcRYMi07GCwrfL0aGr+mQj/x2whLy+Zzmz8PD5C2HpWinMy4RcXeKAGvkqPwlogPtZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp8J0/aAt/h2yh2n0l8J7cj4pphpRiCM2fjSASc+DUQ=;
 b=QcUCg52ZY65ToOg0RL6JRId08HYyEcScoW8sJUQe2yR3RyQMKuhm8mzecnltCw8lwvSwziINqhW0TtBh9oYqqrwems1fzHZyDgsB1XjWm/KjBiYz6HLu9l4zsN0pA6i94gzLQcmv56gc9uAxMpmafAeHVi02onPCmQW6ektJegrHdwPwjsk+2/fcTpK3pjGekfoS8ZFzRwKAfUaFdjIdL4R6ldCVhx1VsDduZ+1xSH4RTNQ55UjbvrIhAwNVBCgNtONgryR6egMrudkIblkYzJxOs3Ecm+SIOHjoTsnV5OT4Pk65NSpxD4eqbmKL/BFf32Kz8I37EhCMt7Is4GPNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp8J0/aAt/h2yh2n0l8J7cj4pphpRiCM2fjSASc+DUQ=;
 b=N3pct22tGwxJOfodN1CME48xTt5YQ9llD0tnR+pPP8vs9lWSq+CI8oQHz9+GKYPuUEcbkiTJAi6Xnyqayp6h2kMktnZuWp60Jmyvhgo1tvKtUYNZ2lFFIsZ4u1EB/s1O8cNrMC1L00ysjUDA7DVapbwwFI4MNVnzxynqCqRwsWU=
Received: from DM6PR01CA0003.prod.exchangelabs.com (2603:10b6:5:296::8) by
 PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:34:25 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::f2) by DM6PR01CA0003.outlook.office365.com
 (2603:10b6:5:296::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 23:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Mon, 17 Apr 2023 23:34:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 18:34:22 -0500
Subject: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
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
        <peternewman@google.com>, <babu.moger@amd.com>
Date:   Mon, 17 Apr 2023 18:34:15 -0500
Message-ID: <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
In-Reply-To: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 74aad304-8c68-453a-919f-08db3f9c476d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKFvhe7Xg9OWEH3Rc7DBF+JjLAPJHQ1w+ufXsZXYHJxjV5fHDrHr9tBMOzFNVEQIupVfp3DtFsz4q9z6ehPoK+LIIO1McbzhaWa3u3iY5/1Iy6yuMwlxgE8EgInsn9KkMOmdz527XRPHhQO8m0Pchdz4VpRh5z4B1WBYT+xT1vY4D52DZZz+t2/cXLeEtuO1zwmax9aa8bdbNkdqP7nLMuDQXzJ0eo//w/Ia1uxApJ4fbEIEHZExRDarJENDMEpNz2rD05wNN4exHkN5pJmopEuyFgoeZtMA7WO7EpwxCWpUn7rVyynBsSTD0TptsEm2SCIpd8E38oqp62XXokESMXnRpv0zeoytEj8Wi/KTGjR6hVNfPwF5VI2BnlKMuhtX/cf05PJ+e5O8zXhDsVoKwR3loHpUQFCJ6H//eTAK13yJvxJL4vj/RqUubiYrq8jCwHqdlOMHjck40fgvBH/30x3pVjtqFxocTQmjG14uJb3Rk/o/GiyRX047+as4uScIiD3jAY36Q6lMXp4yrAzS2p7R7QG4bl3JhpFSZbcu+PSRfBsb/jbOMFMSlxnQZYHftk6nXXhnFEFh56qv8DK0CpP3P6ElKNoEE6H/96O+zKTTbcHjJLv3op+EZWrLy6FR7tQIsJ8FNbTmYwG5OXc1y6M5U/8jm7b1lZsfyChgr4J66vicORAEX52HEny9uoXNLvlYeW7tk6o31HqwNKk+lreQvhCfFJBTy0DdpoVgN75HENiAqLxbjXH1sUundQBF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(16576012)(110136005)(54906003)(70586007)(70206006)(4326008)(103116003)(186003)(26005)(40460700003)(9686003)(47076005)(16526019)(36860700001)(81166007)(356005)(336012)(426003)(83380400001)(5660300002)(8936002)(82310400005)(8676002)(478600001)(6666004)(41300700001)(33716001)(86362001)(82740400003)(2906002)(7406005)(7416002)(40480700001)(44832011)(71626016)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:34:24.8087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74aad304-8c68-453a-919f-08db3f9c476d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary rftype flags to avoid multiple indirection.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    9 +++------=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |    6 +++++-=0A=
 2 files changed, 8 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 85ceaf9a31ac..62767774810d 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -243,12 +243,9 @@ struct rdtgroup {=0A=
  */=0A=
 #define RFTYPE_INFO			BIT(0)=0A=
 #define RFTYPE_BASE			BIT(1)=0A=
-#define RF_CTRLSHIFT			4=0A=
-#define RF_MONSHIFT			5=0A=
-#define RF_TOPSHIFT			6=0A=
-#define RFTYPE_CTRL			BIT(RF_CTRLSHIFT)=0A=
-#define RFTYPE_MON			BIT(RF_MONSHIFT)=0A=
-#define RFTYPE_TOP			BIT(RF_TOPSHIFT)=0A=
+#define RFTYPE_CTRL			BIT(4)=0A=
+#define RFTYPE_MON			BIT(5)=0A=
+#define RFTYPE_TOP			BIT(6)=0A=
 #define RFTYPE_RES_CACHE		BIT(8)=0A=
 #define RFTYPE_RES_MB			BIT(9)=0A=
 #define RF_CTRL_INFO			(RFTYPE_INFO | RFTYPE_CTRL)=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c=0A=
index df5bd13440b0..6cd0a8396f30 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c=0A=
@@ -3239,7 +3239,11 @@ static int mkdir_rdt_prepare(struct kernfs_node *par=
ent_kn,=0A=
 		goto out_destroy;=0A=
 	}=0A=
 =0A=
-	files =3D RFTYPE_BASE | BIT(RF_CTRLSHIFT + rtype);=0A=
+	if (rtype =3D=3D RDTCTRL_GROUP)=0A=
+		files =3D RFTYPE_BASE | RFTYPE_CTRL;=0A=
+	else=0A=
+		files =3D RFTYPE_BASE | RFTYPE_MON;=0A=
+=0A=
 	ret =3D rdtgroup_add_files(kn, files);=0A=
 	if (ret) {=0A=
 		rdt_last_cmd_puts("kernfs fill error\n");=0A=
=0A=

