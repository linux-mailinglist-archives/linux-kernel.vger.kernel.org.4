Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AEF63F421
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiLAPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiLAPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8826AD31D;
        Thu,  1 Dec 2022 07:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEp9kiUDE/zylQ44wv5CQEZebdf8oWtiIrvWAePHA53r4aYCQ4GzN+UK5kA0q5CtHfFR7PWWlXb9NEDxFUyC7MTltwojzyBRpboMJ9GyIp7pjRqCtFnMdmyfNhrHWhxLX3EPQO4aq8EM9d8M9fK57QEP7gr8IyjB2xQ7j1eyW6+i3mwi8ExW+YQ7NotVJoD6YupUrqEueZn+OWCwsWAkjzC10CUbYjcStMjeGNq38mguzqb36v1p6KhAlRe2aR3b4HSPNu1nVlG8eWFe9injptX00EWRozw1pwbxkJ5cxuZQs08pgAT/Af9YqhwWEopHYkqV5wiajuiQUH8/EsHy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhgL6i4JEcY9+QVUte286D9t8xhROvUeJPLIDM1M5q8=;
 b=Bi7vNnTlLunOgT+p/8SUwv++0AOeHnYxP66zdwHdxUspjA1Y5J2T7yjUt8HG8FqxYjJF2PEx52Fn/8YVwF4yFM8EFEDMPmWcDz3gYnh8KwMBi9FEjEszNKIOydCbC+OX5s2YijdfO317+Eq+BLxFtqUiukoMbRc30fF5eD+6NmLCLG5t2uHfS+wiO2qzAY37u9JTy+DaOnTYzMmPhZ+xWIxAyITeZaXPEoJhNg/d75jcIGdh0GjuSBORStnpUYD13QK10Dqz+hkaYiAQ7tSzC3XMNLqZvjVsJe+ezbsdkwa6jcFPsmkwHYKYOWoJWkd82MPTX/pDe/bbx6GnroVu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhgL6i4JEcY9+QVUte286D9t8xhROvUeJPLIDM1M5q8=;
 b=49PNzIAY9BshvDSV1ZeDB8IG+7E3XTVKdQ6QE2fXGEyi40teakpUWEGXLWad//8LXH528rApLcL6iDgpNwNHx65aukm/NLOsUuzQt0N1COjCFZVv8X46+xTP7SbvG7q3sEQmxJq2hJKX218qA5pcwUKqe4eDHNyx5UIMlGfkKE0=
Received: from MWH0EPF00056D03.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:d) by PH8PR12MB7231.namprd12.prod.outlook.com
 (2603:10b6:510:225::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:36:30 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::201) by MWH0EPF00056D03.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 1 Dec 2022 15:36:29 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:27 -0600
Subject: [PATCH v9 04/13] x86/resctrl: Include new features in command line
 options
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
Date:   Thu, 1 Dec 2022 09:36:26 -0600
Message-ID: <166990898682.17806.2447018872734886554.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: bafb2e31-e618-4eac-069a-08dad3b1d13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnQNyo5CqeU31aWbkoN0tiCeCTF0//4OO6eEe+Qo5JCpEXqpPf9CXhaQp5r3WZU6SiZfwkmcjxgr7PeSujghhpR3lED6oFOS52Nox+fdMDp4NfrN6CtL4bS684X0A1JUfLaR2hkSjxZ86gOSdxXMF35FEbL9pQzKVVtoUHVmQy3elk08zQJyrT4dQ6/Z910sBQGhSgB59VDUPGMZ0cB0smZzzCNTK/i7zrtkEoEXEFxUB9DiVpem5L4FEsWt6HFr+Z3x5CXk5jnmRMB7mzkVdP092m5ZlMUWi7I/5Tjafk9PZev0aI3BSpE7WOjGYbfIpOELpBgEPoNg2+v2FhRAXwrHiqH9SFfDBWOCsxGgHjZUDV8upU/kCb5CHTDU0uwVrXizLYkpxRLjB1xbiYOME5uMhaW9OLb3fF65/NF2EMrPQXQsiJZ0N4kIcVwyKKcgH7YrjsmA8eyhOSVtlcIEENKJ+BXzDY7sB7ZsvPuugzfBWA+Hr7t+kM7anFk9o8McTUwinGLx2iCY3IojLibu9AuMHvisjry0iiBupfeDQ6/hOrP75p0XAi4Ga7wzonRTlT7C75SfAPX8wy68pox5AicV1ZZ4ohKOmOrFulrlBL1mrpCbHeY+a0qdkQyKnvNtYv87g2wsIBtTItCt1JNLRy6fANgqbgCSJf62eItoCIGxlrPBKtnaF0QbsTuc6txB6NeGd2erwTOpkvrg1xENOquCvjdka+apK5KiUnH2B+UH9hQPXnS6X3SwWJ7F/HTUTaLKTz6KzrM6dtyyeNCrOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(33716001)(81166007)(40480700001)(356005)(40460700003)(86362001)(103116003)(478600001)(9686003)(110136005)(5660300002)(7406005)(41300700001)(7416002)(2906002)(316002)(4326008)(54906003)(16576012)(70206006)(36860700001)(8676002)(8936002)(70586007)(44832011)(82310400005)(16526019)(82740400003)(336012)(186003)(83380400001)(26005)(47076005)(426003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:29.7959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb2e31-e618-4eac-069a-08dad3b1d13e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to enable or disable the new resctrl features.=
=0A=
smba : Slow Memory Bandwidth Allocation=0A=
bmec : Bandwidth Monitor Event Configuration.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/admin-guide/kernel-parameters.txt |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/core.c              |    4 ++++=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt=0A=
index 42af9ca0127e..a7b6634f4426 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -5190,7 +5190,7 @@=0A=
 	rdt=3D		[HW,X86,RDT]=0A=
 			Turn on/off individual RDT features. List is:=0A=
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,=0A=
-			mba.=0A=
+			mba, smba, bmec.=0A=
 			E.g. to turn on cmt and turn off mba use:=0A=
 				rdt=3Dcmt,!mba=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index f6af3ac1ef20..10a8c9d96f32 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -659,6 +659,8 @@ enum {=0A=
 	RDT_FLAG_L2_CAT,=0A=
 	RDT_FLAG_L2_CDP,=0A=
 	RDT_FLAG_MBA,=0A=
+	RDT_FLAG_SMBA,=0A=
+	RDT_FLAG_BMEC,=0A=
 };=0A=
 =0A=
 #define RDT_OPT(idx, n, f)	\=0A=
@@ -682,6 +684,8 @@ static struct rdt_options rdt_options[]  __initdata =3D=
 {=0A=
 	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),=0A=
 	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),=0A=
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),=0A=
+	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),=0A=
+	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),=0A=
 };=0A=
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)=0A=
 =0A=
=0A=

