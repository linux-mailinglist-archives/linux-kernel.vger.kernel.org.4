Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8EA5ECE69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiI0U0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiI0U0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:26:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C09410A;
        Tue, 27 Sep 2022 13:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX74gGhfRmCGj1pwREa8hUgjvrfDjTzQxYvRg0iTFhoaJqzaqClDHwSH7We4q6HUvnF4eRMyQHj9ALPbj3cSw9dKdb71JXcwJB+M9hTRGUOp9+ShwQL+bkJQ/UFQt1xepiMJ4TeJJuvQqzu8qxtwgIVZf7Qsa0zpbEQuYyk7ljVcPbYSa+VjhGscICtanZhIYhvwdKoWQc0x0iXmimAMEo6Se+maSo6O71f+GYStW5dDQmL+450EnAoOUwGJKucM4ADjCS5xZUv4F+7B0JJgkuGUtJ15jll+tP4TU/gJH+3iIpK85oJsPxBFu5IDZdT5dS+GhGkleekzaBlZ+8TrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OsjRgvwsn1/V2TGCy8UJJZ+8yG1IQ9hdJ/Z2EHB1Cw=;
 b=C052Tp3PvjyNW4bsCAE02YYYUQbQGKhqu0iIiBm3N8gRDXcbyn+1aF9H3raa3QrPWKlox4Ise0jGcQIlIoz1zzESM2CxOywRaHE8BeYin2jIdan+RPbpMroW93OYOi/euUCNT2qUgRR+//gpjZVPjgXivHDVALLoycPtSGYVfadaw3DK9gnNEv3gs9rmYHeoBQY0V115PKA6kGUc4ZvIa3huVBUT2CdzRUzEwJYCn5Vdg0o0g6ubFuu4tw3iTanpa4FoNga7oCNEROfMGBR6TDtkL07CBN1FO3b4b9pHmJ07oko11PAB26CL6bqlSTmZaUBJSh8JYVoRYhAfzouJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OsjRgvwsn1/V2TGCy8UJJZ+8yG1IQ9hdJ/Z2EHB1Cw=;
 b=fn+6UB85O6Zg6L2zNRaAPRk9C14AEe8wVtMdowRLjsmoXnmbsHEX9y6W5DacUWbkR6/uucFNFasHiOVDX5wa54eHIBlK84PAPMZLUkV4fbBEbU9BjhFPOr6EGAtlajUPeE3sbSBD+91PU76JyI2ds0cF4+xNhZxdnB4A02mhm+0=
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 20:26:02 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::40) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Tue, 27 Sep 2022 20:26:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:26:00 -0500
Subject: [PATCH v5 04/12] x86/resctrl: Include new features in command line
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
Date:   Tue, 27 Sep 2022 15:25:54 -0500
Message-ID: <166431035471.373387.5266268593915885892.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a567a9-c501-4fb3-d0a3-08daa0c67f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1fhYTa/0onsWOWNCgUMtfFf+byOJqWmLUb5p0A0Y5zrpmj08rY3QGM8dfhwmT18hi9ygT3RKWveO2W6w1tHLOMzAEtxajrrbHtdSHnik4gJ7ZVTjNBn8+eFSYqstDPt0dKtEJ/n3XFNMX7AQacG0d/RpOllIP5i5K5tLtv1bKHhuOupVFmnw9MGdgQwJsfARhXSU4pFn5muDifHTWD8jicoT43vi90Y78d8zAFDpxuEkCpHQ0TC+qpc3MV3grhr0X8yehoabet2dHhw/7HbfKJg5hAFHG2kyqHoA/ZrdeVVzf5dFac3esSBlb15JDqkdhE4NzmLtgGzbk6hW7J+IAq6/kZZoPqcbhMiCR0zMsaYqWf6ad5+AfrpYCunsK63zeHDpg+tgeUngo8/KZ9SW7vVfoOMYIMlycSz0WqfjHokZfnNo3KWDRxxK5s3zXjLcyTg0aAfAxoIHvp6mDrIrqYtNHT1tKjpzSyywqiUqaiahQ8YuVTRmOC+hNLe8uunuw8F+ZEn1LgqqPMIuyUCbm7jhkDwPmnohFjsmo6XiuiMOSpDF/YSxinhKeUayuT38TaF8Ke3Q6ywnXjc3cRy66BfX6R+uNUjZ05HJOI4Gsd63DUb0MU+8Q1a2qIg2QectaBMkgxTA5F/ptGX75gzSsai9rdzU4Ammfc0COAS90YMZqsoRcMKQ+h1RXQSbqWBmENrjsZWplTxw8MBC9A7aldqVcxWKXGH+39rgeCoBsIhUt96ZAW2kIm6BeoIbsFmCFL0/RGfBd3py1EYFfufCVMlZGwVLAgetkAkJOUOUQKxTs/o3qObQDt1oG2Waun/mDtUIspEFWGdR3XsEdIuIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(110136005)(54906003)(16576012)(316002)(83380400001)(478600001)(41300700001)(70206006)(70586007)(8676002)(4326008)(6666004)(5660300002)(26005)(7416002)(44832011)(9686003)(2906002)(8936002)(103116003)(186003)(16526019)(336012)(82310400005)(40460700003)(356005)(33716001)(47076005)(36860700001)(81166007)(40480700001)(82740400003)(86362001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:26:02.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a567a9-c501-4fb3-d0a3-08daa0c67f19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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
index 426fa892d311..71b397cc776c 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -5169,7 +5169,7 @@=0A=
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
index a7e9aabff8c8..53fbc3acad81 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -700,6 +700,8 @@ enum {=0A=
 	RDT_FLAG_L2_CAT,=0A=
 	RDT_FLAG_L2_CDP,=0A=
 	RDT_FLAG_MBA,=0A=
+	RDT_FLAG_SMBA,=0A=
+	RDT_FLAG_BMEC,=0A=
 };=0A=
 =0A=
 #define RDT_OPT(idx, n, f)	\=0A=
@@ -723,6 +725,8 @@ static struct rdt_options rdt_options[]  __initdata =3D=
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

