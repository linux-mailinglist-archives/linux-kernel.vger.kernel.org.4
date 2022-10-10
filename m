Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992005FA643
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJJUau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiJJUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:30:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950823C8D3;
        Mon, 10 Oct 2022 13:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOfmDcvRFosFK678wFIBeFMl0zR4hFtbN5E+3oB/ZCzXHAyr0KR1uGM5C8OukoS7GxABF1ryeIqJYOjIylWo9QOGEtkjghWsLoYuoVyeNKq5oszH7nTLpMzG5o864LY7zjnIn0SU5gtyqIh8ETccybm3RNj+OvHHRAdu0QONdZhdFb7YYYtFAWJooHDcU5TjrN2+8brvaLUeyWUtMQYhQyS1VB9xFRj3PMRpbXeFugRG2MSDIguJErNPgZyvyXjA2xusAWOlZ2qClv9asGD3xHYOpvHTp0BzBt0OhJvh8boxvaRrYkzSdQ5Z8cl4sPdpxQHchM0n7xKJp1lTBBrccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F5Pq2E029wtECCiwp7BUqaAplu/4pMMejbw6ABMwkY=;
 b=ikp4o7faNJ7V58ANVjNOOjlU6WIQPr5M4Ecj5Qfy3zd6y2n5O5sPlJ4klmMiprZfdfdABE9+neKx4RJqzHhE79WQSAYvV/pw/i1qGLQbTvDZYE47n5Quqct1IqnTuU7e7EplYwW6dDgiCj2/646zzr3fxGYM5oqacYPtjNimnPi9TblPCw2271o0riYCueYkUGGZiGLLN2Ggf7C4We6rUDXK1iWL9CMz8Z+hzsTvvjGv7nlA/Q2noijaZJ6gRiu98ERRoeRFKX0mCQtrwiAG7P0AD6ZinFmtb33+jRzb9+Y1umhYiOVNAH/XTyFWcl7ZT5oX+hmq6l7A1HdYACucNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F5Pq2E029wtECCiwp7BUqaAplu/4pMMejbw6ABMwkY=;
 b=29xEptwI4nwLes6AlMQgF1bdtYJYAyYj/J7HmcdFaAZ4WBtzRZsG8Fv07RIejsI1EMgh2bPYauoARHmluyWXI5YQfGUSXiajVqANxFVNQ8sS5DZndzx4zj9TZrNDHL+fumceOnvH3mROyJOzGxpx+3iHfYjkcj4xvpYU7I+Owz8=
Received: from DM5PR08CA0051.namprd08.prod.outlook.com (2603:10b6:4:60::40) by
 CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Mon, 10 Oct 2022 20:29:15 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::cd) by DM5PR08CA0051.outlook.office365.com
 (2603:10b6:4:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 20:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 20:29:14 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 15:29:12 -0500
Subject: [PATCH v6 04/12] x86/resctrl: Include new features in command line
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
Date:   Mon, 10 Oct 2022 15:28:59 -0500
Message-ID: <166543373926.23830.6551235898170426788.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f30bd3b-9fda-46c8-86ac-08daaafe1951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWfE3d7jCmEJwIlHPGmgh6UNr5DLRsT+t8Ywj4vDYEwey1sFNOZCalzu1pYge7gZoT2tQLbrgZ4fJzx8CF4mq8CJRRNQEh8ZlqZ9hoA8BtncpAbg0X0sEgwYqHsQsBB4yueffk/2ZAsWhtMGjK+DmM6Jw0Cm6xiPztc0dKdk6qpJAfh0auWxd/9zGX5/8TYx05RnTO4SFUYqv3PjnwLEbTNlaEXyxbXWWlpfA9nZOCEe46sUQJDM2VqmApTuSUq35o5ngQ7uIWZvR+V1o+6Nk9pONZP2CvN4Ms1JCvWxHPJINm8ShTs/MOLlWwac1M/vhWqTi2WunsS6f7Aor0PtyD7b41iam2FqhiaOZNDMoSVD6/28Qq9tJ4OiwQ3YgaVCKayY6e2Vsp64OSMHZIacdPwWF2l3D/S4oxb9iWC5wp3PRulpAs4c5yf6NnZ2nNp+OaaCz7KA6UeDdW0V3sBtPu/kK8FtPXQ+tEGqByUsVCbBxfu4AUkJNztTY1OwlwuyY0rxdSRSrRcPLriXXGCcdJ0Y50tWgWkqZL3k/SEcIUrq3X9t2wa4kgWf0ecwoqMDpEMvLkH1p0LcZaSf4/HshAksfhvvQT9Jvm24Qd/GEX9VOtVcv1Bec0VB50VdqaKGKb8Hod6OecpagcVQC8+infA0gOC5XPSL81V1wzBU88DvT+/+Xvqwv2t0zjNjzCY6FZ5jzL43gVxyH+Qj3/tni2ByFwidT2OoVPk2RDkblI3I5lfP+DNkb/nxAyvTXSfURQRiarmycFv/Y8s6xBiFDIRHZ9nfjzavjV0f/xvsYVl1kzgzC0NHHHWq+VtXSUPjCbjg6ZkEk7Yo8Sb6FqDZxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(336012)(16526019)(2906002)(41300700001)(8676002)(70206006)(86362001)(186003)(47076005)(426003)(83380400001)(70586007)(8936002)(103116003)(7416002)(44832011)(5660300002)(6666004)(82740400003)(82310400005)(40480700001)(478600001)(54906003)(81166007)(356005)(316002)(16576012)(33716001)(9686003)(26005)(110136005)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 20:29:14.8753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f30bd3b-9fda-46c8-86ac-08daaafe1951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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
index 2bc11a61c4d0..d616366e964a 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -5173,7 +5173,7 @@=0A=
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

