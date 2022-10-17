Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72F601C55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJQW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJQW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015881135;
        Mon, 17 Oct 2022 15:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaFjMqgwHIrOF9L1Fpu5em1VkCYsTyHjQ+aw1QePU61yODuRByOythXm2r8gjhy9hF3Qn2cvlSIuePnMye8UENUvlwvYt4xi6It+61xg0235ACprMi1zUvGbazF/t5Q3qni3DhDFXzjAd9YwIQ0uYRFnvNTxAZyNCGwDokZiHDnwkzBjXzL2riTNMnPAxmLg8qgZvs5t10JOWTspEv24hoNFKF7J7gOhiQkoY1DwNUjTOUhbV/u9TD2bURwyN9QHHO6UqSeayvJg8mCCJX/PPxNk3j8H6Fy5RMKXLRxvDglKfqjHRe2flxs3iFDFmj9KLTboD6+PX1V/iMA+BAT4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy3+hTc1t55/XP3rywOlpjYoxQgTRAR725Zddfore9Y=;
 b=WWEUIo6TRuid7oETzNNpB546yQRQs7xZ14okmJfZGYc/fzrxGSd2bq9X8umOJzS9gy/xg6Q4+Vtaf1sxnpVC7PhJRN3u5QKfXPHPLvhIpa0Fwq1sMeMnao8C3ARJ8R6VofLdF9sTURKY7Sk5V4zLL54ASKjbJZM4zSNdbboSUyB2+XXr6fxxZgE98c75gSSQ72rOQ4/dXI/kiEukPoCZBiLZZc/Eb2h0SodqJimQ+vZs2FDSH9w05vbb6fZnhuaFhombFiP9Tgn4x5kB6uxi/ZwBJF0UJh5NXgQiaQO4S6zE7nII1M7njz7k1Bwo/0Yd1XCmlkVz8Uxtww+FiZ/Eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy3+hTc1t55/XP3rywOlpjYoxQgTRAR725Zddfore9Y=;
 b=k8vE4vHr98X2/YSlN6uM7lq8KnccAmRLslo18DeMHcqkNkRUq5xFCqo3SNlo1NvHK5EudcCpOVBD8DBKobS2VL9Sx5dAKrKbeZEB4Q6FMBBvsuC+j760gSWhj4gRM/jofufKfvlpa+PecKk+wN7KQy7BnaFfMNhHg54HDVCW4vs=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 22:26:35 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::94) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:34 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:32 -0500
Subject: [PATCH v7 04/12] x86/resctrl: Include new features in command line
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
        <eranian@google.com>
Date:   Mon, 17 Oct 2022 17:26:32 -0500
Message-ID: <166604559240.5345.4467065841093036343.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a627430-1050-45ed-1cb3-08dab08ea652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHC1C0dv0fNE9g2Dv9FDilJmkIdRI4cy/FTedRJuTfsO/MMeCUaQkRrHXXaVneWb9dbQTSWLJKdrZjQhqAbJUk+PY0H8zMWojRZ8C93BMmIE3RVL0u2l6wC7oapVeqg9+1wFLNVUgVyXP5dkCqdRVo8/R0hOuOa33UhcB7kcLAPK42ysE7MkPsbKEgTCysSjPp4hK7jNd1muYt7tjG+fA6FGhVFPxUY1odVjihzDYFPzs31ZPUhB/C4uEsYyO/KO5sclhSia4itDQYAsiLQ/tpwOm/z1TvzhMCcM6Mc4Ub0wAUkV01Rwswgy2CvQezlA7XGkuwEfLuR6x1iXcNfYmSPIehsvqhKkut3tsy0qA8OFGY6dMjQD/+o92KVW5ffX1/X1/Djj0pMYLN7PBan2OaWqn5/wlDNSXX5ZKm0J/KBZcsN1h7EY6bg033WHR7nZYQcKCtsVk+qvLIdGAluNAvpjeR7ek3TtMOX26ZvFuuEHtP9kolj7/cVROuRB9iRDZbamblRoiEhavtJx+AEsKQlsjoVPKzXrlhEH1js0+leBrwqSEpSsYXx8iH4zCJ1cJFwCz3FfU5nmaW3bAO2SJaCSidjh7/ZY1e0CmAMGAHG0My9lzp9wyMoeaAXRoAPkvuiBIPETRQVq9HsQ8hFyFXcjDh71fhFsjdxCNKhgyhz/pbzXrZnREE+OJrX8EDSXgE96WzZUgs7yQTea+VkvDylhZzOYYs1DUateWBip3+xZAu9iIt1H3pXzUeWu8mr0S4alQEA/d6150u6ntT6fy4k4Pf2yyCj8rfiTVBC1bhTJgmBSn1XYiVXXARzor1ry6dibs0Wdtq7gdSbzsPA6TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(103116003)(86362001)(81166007)(356005)(82740400003)(16576012)(2906002)(40480700001)(83380400001)(7416002)(40460700003)(5660300002)(44832011)(16526019)(9686003)(26005)(186003)(426003)(47076005)(36860700001)(336012)(8936002)(478600001)(33716001)(316002)(4326008)(82310400005)(54906003)(110136005)(70206006)(8676002)(70586007)(41300700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:34.8121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a627430-1050-45ed-1cb3-08dab08ea652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to disable the new features.=0A=
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
index a465d5242774..f3f0870144fb 100644=0A=
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
index efffce716f3a..c7561c613209 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -665,6 +665,8 @@ enum {=0A=
 	RDT_FLAG_L2_CAT,=0A=
 	RDT_FLAG_L2_CDP,=0A=
 	RDT_FLAG_MBA,=0A=
+	RDT_FLAG_SMBA,=0A=
+	RDT_FLAG_BMEC,=0A=
 };=0A=
 =0A=
 #define RDT_OPT(idx, n, f)	\=0A=
@@ -688,6 +690,8 @@ static struct rdt_options rdt_options[]  __initdata =3D=
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

