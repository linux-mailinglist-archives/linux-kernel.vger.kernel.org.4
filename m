Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80E662B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjAIQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAIQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:23 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5AD12634;
        Mon,  9 Jan 2023 08:44:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW+pzvyOAHxIVbKl4Hq8Ot7Ve9Jo50YwQuXULq/K856imnZTSvSoB1to8jYnJwAfTd9navvzVR7+iB03XIjtTXZtV3h8wbP9u9czXR5ojaJXhqLeP0PQufIDwHX9i9DGSNvHBmCrTUs7h89zH7tkqp84Q4kElnmHQt6/eENr7tH9R6H6jBZKWK8jK3Pb2VdCdhMjLA2aIHFf9jKi39Natc8gvbAe7asCrQ/YeQlGObCwseHdseiBgYxy7koXRo4qXFPqrX8VMVB9YImiomSI5m2floAOMD8M3yYBgm0BcxU4HNbOGdnals0pMMrYVyf9wyU0qPbbNr0PweiCgqv0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=jzFytgFnM2nfEipn/p6iI5mDp1HdLH0b3jIVxTyOoafp6q45LviTn3Dy0r3tOmA/QOy9a2jPrJEXj3fq+MbV2goV/5pXTgWJVP+5QSOR48f9M7IT31gTIUX1UCOq1mTneSzkPiPk1VMbcR1NHCiS3gxVeXCxPPHgwqT3GjWmcb8EDZMlJhkl2lxPx1hm2j5VaLlNNiVnPCY5zZwLRUpzTzNDa4I/mimxATjTidF8xeVBzGFpGFUmEd5jNVf7DoTzxJEc9bfjGbMKtcNJD4L/zbuHravnQv442rXgWVZKbiAw/p5OsPL2fcgtnPXyiWkmCYwJTWdWB/mheRxc0bJxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=w/2UbkR4duGFBbebpzmQATr1NFj3SQsqNnrMaUea3tTyb3Uz1+wU2SLXRtt34ehjwpNRNwVDGaRT4eEwrvFBTU4LLCuUAwwgSkD3BuRp0zMRSlPxYOimcAi7+z/Sffvffdo8f26tNaarX9TT0A3kndXQsWnqRxWPrZtD5kKBSZM=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:18 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::1b) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:16 -0600
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
Subject: [PATCH v11 03/13] x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
Date:   Mon, 9 Jan 2023 10:43:55 -0600
Message-ID: <20230109164405.569714-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5d3b52-6ceb-4b98-ead2-08daf260c04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCsXxt8dbTNvnPFKS40KR0EW1OHaNhs8Hh356nClUbc1crqmIe5XKfF0HmtlFQTtCByM3+ER+YP0fRDCD+mG12M2lUK24I2rS2hcocMwGYj1VkBvSP/go9Ec1gqG7I5hCy08Z9VCiS8ff27S8hTEXyP5JGOuE2QVgngdHqH5MrOXQ0lK4DFGKOsh8/MuHGhDANVMdEEV1tmYPglj0K2nsXn/lJFNYPe8VrvnVCcaJXTUcfPNveCwl4X/sly6yaTVCRBnBbuVinPKWiKUaS+v15Un7owXOr4aluLimyk7EVMuI35XD2NwiTdjqDIM5fvWGwjLcFOfha3KixDS8liXfBq64EOgbhZjZJFBvJdtntYlCiR7SH4uR2S1Wi39tixDmObRLdOsB/KBhvcYQwbMaaJ5nXEsC1uIutoaCeoMo28HEwvihGNG+vrn641Z4b/sSA5Zaf81kuC6Z7WLh5oXVYl4MlwgtJbh2Vrxb8ZCSgY55UCWrWey4NcLBpoJN1oO2V4mtixc/LgUlr+SdnDzLs7MWE0fW8dNPSMyQswT3e0uQbbnbNxxJP4uE3KKtsvqMEonYqMwzOkjFQtqEKShmN3JyoMtDPNdSmHwAWCr6srFNlXZplVTQbLqcqeya8pPHlqRiq2MsWsLDhDAWJwIPJ3ew2kNKJ4XZUoLdxMqN4rMh1mLftjtcC5XLOyklWufbHuwlU5VKArI7/MR5kcv1eoiZF8bvaEtOMoSe/vX+L0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(8936002)(40460700003)(2906002)(7406005)(5660300002)(426003)(47076005)(41300700001)(81166007)(7416002)(7696005)(70206006)(4326008)(70586007)(8676002)(316002)(356005)(44832011)(110136005)(54906003)(186003)(16526019)(82740400003)(26005)(40480700001)(1076003)(2616005)(336012)(86362001)(36860700001)(36756003)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:18.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5d3b52-6ceb-4b98-ead2-08daf260c04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new resource type RDT_RESOURCE_SMBA to handle the QoS enforcement
policies on the external slow memory.

Mostly initialization of the essentials. Setting fflags to RFTYPE_RES_MB
configures the SMBA resource to have the same resctrl files as the
existing MBA resource. The SMBA resource has identical properties to
the existing MBA resource. These properties will be enumerated in an
upcoming change and exposed via resctrl because of this flag.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c98e52ff5f20..f6af3ac1ef20 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -100,6 +100,18 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_SMBA] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_SMBA,
+			.name			= "SMBA",
+			.cache_level		= 3,
+			.domains		= domain_init(RDT_RESOURCE_SMBA),
+			.parse_ctrlval		= parse_bw,
+			.format_str		= "%d=%*u",
+			.fflags			= RFTYPE_RES_MB,
+		},
+	},
 };
 
 /*
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5ebd28e6aa0c..fdbbf66312ec 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -409,6 +409,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
-- 
2.34.1

