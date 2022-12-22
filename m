Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9201654952
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLVXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiLVXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:31:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9542CCA7;
        Thu, 22 Dec 2022 15:31:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZJICHuX+Z5co8UXirod89kcAWb1tCFWMEi4izfpefJ3OyWu8OUaCteWKTIlwfFUS04F4hLaxBMqlELTkeE58q4bDD3rpIYpFQKhmTrxWKNEjkU3gCiqcy2fuyavzkV6NlMi8BUI749UhODtu2ofsOZbT+GR+rrSkeUZiL9w9I2o8FkbmvIfKa/qTPGlmOsV8kAwmIkGeA3hBVn0duL1FNLx1WHUDSpkGPhkRYiHSMc8XybDvYW9Y0wIhN0rXwWEhU10PUCTSCFpLJgIWU0ufDHYLJjrc0QroDwKDbeQt16d2SFINp9ytEu137OTFfg4IFr6XNpsTKaPur7Vib35TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwBjuBq7BuaZUOsOADDxSqBS8Jl31x1cmObIm2eD3M8=;
 b=G3ssxoY9nG4iK9h/gC1kh+LQmZLW2dOno8HeGvHuEppFLuiGFJOCIZtQXDjQixaN3d4clhBuF9nA6UE2mPzWEoXlD+nZLuR9a8q/S8cGXXVyyTsJKzzdXu6tC4X/OBXIomfW0l3OK+QUDKmq+Lnx3QsAPdomfb9NAQBcxBJJsra4W+dPjmdyFGkUQprt4aYH4RDBuA3S4agoW1c9tFMqjnshpXqkax+i+4TwbC4UbXtQ5/FWKwOlfj+xWC2MK30Y0Wmt7l5InY0wDQosjfKCeIx9SqTCDoJ4g16znmJN4l0GELHIs9xGZu2wwUwz33wM/EXRcZVjDFanLG452WSUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwBjuBq7BuaZUOsOADDxSqBS8Jl31x1cmObIm2eD3M8=;
 b=um3ANvfUaGTdNKHzS6/7x7x4hkr86Uy3HQc235k9JDx3z4bVAvHfq3zklbgLafoFK+YCJ5O1brux+J3dAc8hLxPOw0cK8pmMR2qz2v3ff0LSR+j8ktUK80LHDLIIOzujDuExA1RSUSgagVNLmgpaRDPBca/IaRW6dJtDRfMia7s=
Received: from CY5PR22CA0042.namprd22.prod.outlook.com (2603:10b6:930:1d::35)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:49 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::86) by CY5PR22CA0042.outlook.office365.com
 (2603:10b6:930:1d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:42 -0600
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
Subject: [PATCH v10 05/13] x86/resctrl: Include new features in command line options
Date:   Thu, 22 Dec 2022 17:31:19 -0600
Message-ID: <20221222233127.910538-6-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a60eda4-95d5-4aff-a08c-08dae474b283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoMZrWECYX96dDxQStIHenxE3pYikS5RzINAPbyCMFvh5GITL7FGDn5qahv3GmcxgJEJjziFUBJiTxD+fGimdvtE9hPS0wIvI+2+wiHkG8ohVTlx9jd5smrOjFbObMzYjKrJGAaibGjdsnU1m6XtDzoGGv1OCg0KRfF2cijyBoQRZ2FXiuCH25uA6tT1NkCbSRkHO/73kFoDDFADDOIBBR9zYXX22Ws7rbIMorDFUlV3pAhnBIIxYrjrdOpl0o3K2uRQTomcgdMZu5VO6AYWQ5RiLxq8x/HfzcSfLkeKvh8CdmQgL0rnyg75aaJAWx0ASCemb4QkqNI7PZIHDF6dgaHk88zVQgD+UQP37etDEhFRWnJedjdt0OqumsNsUntnJ9mN9pTf7fukz0OMWRmcESW3gQD5fdXhQ83GjM6U6yQwrix17FjmADz9l6yS2ZugsWK48F2BTTM9a350zrIIwe+evZ643UQez6bQFDKQzke5EdIq4JTJ3nRQMnefRJjHZ5SDH8sKwts7I06vxsbhiJbtPi/l3Mm2/BCS2YgvuLmIBPsvi9L1bk+ioogC7mfTOTBpC+jzya6lQiWSPoIHFd/dNafBz5CgqeIvfRQOX9f13gbP591oHjmn/oRQIeyQErOctf0IIrIHdT1XDcvLj5pnHgAOlLXfLB7dk3C4VYFUx5YcgOtPNVZkEfUiq2OOgeD4Q5jNg6CP9nni3JwL+VKZVMDpakppvu+98T6lRdE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(70586007)(4326008)(70206006)(8676002)(40460700003)(316002)(5660300002)(36756003)(8936002)(86362001)(7696005)(186003)(6666004)(82310400005)(2616005)(16526019)(1076003)(47076005)(83380400001)(26005)(41300700001)(426003)(36860700001)(356005)(336012)(81166007)(54906003)(82740400003)(478600001)(110136005)(44832011)(40480700001)(2906002)(7416002)(7406005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:48.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a60eda4-95d5-4aff-a08c-08dae474b283
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to enable or disable the new resctrl features.
smba : Slow Memory Bandwidth Allocation
bmec : Bandwidth Monitor Event Configuration.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 arch/x86/kernel/cpu/resctrl/core.c              | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a0eff3231c6..1935b0d9bd9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5199,7 +5199,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba.
+			mba, smba, bmec.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f6af3ac1ef20..10a8c9d96f32 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -659,6 +659,8 @@ enum {
 	RDT_FLAG_L2_CAT,
 	RDT_FLAG_L2_CDP,
 	RDT_FLAG_MBA,
+	RDT_FLAG_SMBA,
+	RDT_FLAG_BMEC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -682,6 +684,8 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),
 	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
+	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
+	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1

