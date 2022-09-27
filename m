Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B05ECE64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiI0U0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiI0UZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:25:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A85A8A6;
        Tue, 27 Sep 2022 13:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwjOpZLkHkDBHFZFhsp5BGrz4N4hKOIjpE+kzqkCvk1Iu+TpPNil2PfTptayb0ASC5+lg38WftnnooQEQzoYwbAI1mST0EpHA//vyBUbmD/rPtNLqTlC/JyTbM6pXSe5Bs+352B9XaBbqnK2QKsVXdCNshuYNoJl0QU3B0VaRrMdYurWBa3v1fg4r8ZAcPXDHhabJ9UY3JLKtpboMn/BEWpMtGeUZzCqq/JmyXBtPzEemlHQ71DTsf6OFI1B7tNCTAelaAmN94c3mMzS0NojUm6Ozg/cKVluPcG5m9LOF7xLqvYWD+Z6BreyQM53yv+Wh1HlE18Dnm+biqglSyo4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eXT2N/E7XIecHeS6gYE1JrYs7rHt6Wt2SlhNw21wZQ=;
 b=m5kyfaSmDif5uy2od4Fo3H6zf+DihBzm7Vao8R3Uw7gJyAT2c+Zj/8y7oszUNoXLyEld5OfzHDPCd6idkW3nKGykXKbTqkRN1lJtQWd/1VMdc5GwLdahuoHNr4QGYV432/MWMAiRmCMK+6tQDlCKPsulYoHgbP5S3rm4nF98jurcID9KdedSwaCTRnQ5J6tOhTa/3T2cL0hqpVfHutbdFuNNDog8ZIavD09E8jbBbaSHdV4Hp57VVe2baXIfoUypfzbaTsBvmVX5pZLTWyW6E/K+UGiw+LrDpqpMNPgiGzBtIx44utPXE4zMHa0+qrsUarvxiW71BxnhwiHVGFFgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eXT2N/E7XIecHeS6gYE1JrYs7rHt6Wt2SlhNw21wZQ=;
 b=3kF8CjFkaLlAlkfEkgivFMxnV/zGdEc/18chqxODN5dY1Qpm0FnNVrXuiTaBb+E9iGltYVotAgQTnYsZTOJ1Hd+Z8XK82ywTv4q7efwD35zQOEHm74hbO5k6VaqDpVAaH16Gk6SwuQHWBP1IDjrQf+8jzV9oJadbTy1m4VusPUs=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 20:25:43 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::4c) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Tue, 27 Sep 2022 20:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 20:25:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 15:25:40 -0500
Subject: [PATCH v5 02/12] x86/resctrl: Add a new resource type
 RDT_RESOURCE_SMBA
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
Date:   Tue, 27 Sep 2022 15:25:40 -0500
Message-ID: <166431034040.373387.6952407781810455057.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5617b753-dc59-47dc-7679-08daa0c67391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKgdim0iq78YVaZdZMAO60XOnW5MX3PlUlKh8GvfNP2m1kk+lZD0+3Ibo50zZ3usGNESV1dAvitjKjqobXZwFSaoHZCmeK0gvdr/AOaphJyBWKA9WBRoidu8h/cBT9l1jZdQAqsWWdq6Jx202ye6RulGP5tdzGO88LNDx2Rd1GcoT/Z3tK5RxIIySC99Yd9tkFWO4358bJleQEcaP/sI+ZHMMPurAOdg8SD6whu8y/Y/6qidmUqsayzm4V2fRUskTJt4xPs666upbCEPfi3rLpkyrTfE298002x4nCIjESeLpulHgHBvMnRWVOTM66e36VcWH0MCcKYvS2fbQhIoBE6IsqIpF8eAyeBXdC43UkCzp27rphOCeChdnoMRrghXYPgzwtPJyV3GXR2Ki6zwLeMQ7yKgEsfm5PzffJ8YTIONr4WdwAWMES7oROB0KSziEg3bJDWV24pd0TBhv9NLsIqYmznXFS8MHwuQ0N3n8WjrOtxfSXQh4CaiSr41MAerMJ8JZh+tQDL7iCcKze6080PjrEWePUDbi6dkTMM2rHCPgTJX02Y5lAy3u7UcGW2q4UgzZSSV5tqk72EZLi8RxV+Pugc+67EEohIg8cPXFUS91hDeyBNqt7WjFM2TDBN1aWL7DmCs2SPWa4nOCaKXbrEbS0YzMY+jau5oJ+rivnZLIoKN0V9D1wly/mc8vBQiVBixigjAJa32nWSreT0W5wZhnimQHzbR4LOhP24b9IOpVC4ZOQ7wXkiAhsPY9bGRSRJCAHkftGVK53gHY3j5VYeI7YN5M+Gp9A5mNMG+vzWlu8/nBV6jW5uMe+v4V1VbuSflFKZA0jyRHd0zu3ENUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(336012)(44832011)(86362001)(426003)(186003)(103116003)(2906002)(16526019)(82740400003)(54906003)(36860700001)(8676002)(16576012)(110136005)(316002)(8936002)(47076005)(7416002)(356005)(70206006)(5660300002)(4326008)(81166007)(70586007)(40480700001)(33716001)(41300700001)(82310400005)(26005)(478600001)(40460700003)(9686003)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 20:25:42.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5617b753-dc59-47dc-7679-08daa0c67391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new resource type RDT_RESOURCE_SMBA to handle the QoS=0A=
enforcement policies on the external slow memory.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index c2657754672e..a7e9aabff8c8 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
 			.fflags			=3D RFTYPE_RES_MB,=0A=
 		},=0A=
 	},=0A=
+	[RDT_RESOURCE_SMBA] =3D=0A=
+	{=0A=
+		.r_resctrl =3D {=0A=
+			.rid			=3D RDT_RESOURCE_SMBA,=0A=
+			.name			=3D "SMBA",=0A=
+			.cache_level		=3D 3,=0A=
+			.domains		=3D domain_init(RDT_RESOURCE_SMBA),=0A=
+			.parse_ctrlval		=3D parse_bw,=0A=
+			.format_str		=3D "%d=3D%*u",=0A=
+			.fflags			=3D RFTYPE_RES_MB,=0A=
+		},=0A=
+	},=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index 1d647188a43b..24a1dfeb6cb2 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -418,6 +418,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

