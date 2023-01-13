Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83F669C28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjAMP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjAMP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:28:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D1777FE;
        Fri, 13 Jan 2023 07:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcrCqjjk0kA1HTNxzQRFI/E5N0QM9a8d9F3vSl/BSiKJBTRvjqE9JjI7okmfWJ5Avsk3vF03rSj98ycpJ3IEJ1BinC1oHhATxHiEDC4BCHFv1xBNoxvdleCukWDtqeq5wNuUskvlQM0sGECUZ89paJvJKhceNLLwrP/lAtTe8b2GIfqH+vYYfAq0JWNbk3cjS93pNnNMPgbCZyg1ioh5bdvw9FnJEp1Dhyzif3f1VwLtO6Uo1qhwQzmf7AXQ5m5zEqfnV/kY8tGTOoNhG10+BvWjKpFMbffOQVwSttHWFfmY5IvCaY2hDCR/UwZSQUIxLyibCN7NR2CTFGY44/HneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ0txemEripltiNGTXy/Z+dsa5is9tRbljc7gm5f0gg=;
 b=KOPhvTJO1DdKvlbH/4p/V7Yp/GaX9+jDcKhZgZdRa00qncrD0MJ0lNHKSHnMm/k3AwPbZJj5WMIbEXoTmUNhCG58nt1gcTvvM8AsDIxTTEGqGE7T3bW1yL/UKX5FSYg0KLwSvkPu+ypQUBK454SqY8mWP3iKhlpPpOb3RkO31QhFQkYw9K6BsCAbBOXEyzMdzmE/3gFQsalEElduxwAdLp3n2VGjogjxfKqnJ5MP3J2zfdRpz31RG14qgg7wcHP4MPjVWzXI+htQAeu5TYPYQb2F7qXLxtlxDrQUaH07UdeIEkplS9KQQRP1DeJryraNvGkZMbuG25A24+46m2CUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ0txemEripltiNGTXy/Z+dsa5is9tRbljc7gm5f0gg=;
 b=2192W8f7b1Niy9cfVaJ3A2aYaskcmY97v2nSe0r4zlZbT9XP82a0wRERRfCLEjrjcw4ARW2e6ByAZHRmL4yyBs8ir7YLl9+TzrFC/lI7LiEj60Nuc96csmp2I/eRZdvdrDtDQ21pQ3+w/6fNA+OVl+W/64rHEGtIEEbh0gvX4vE=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:21:51 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::83) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:21:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:03 -0600
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
Subject: [PATCH v12 05/13] x86/resctrl: Include new features in command line options
Date:   Fri, 13 Jan 2023 09:20:31 -0600
Message-ID: <20230113152039.770054-6-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b0188c-5d0e-4258-51f7-08daf579e4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrLc4ijPwC/v9gw7fA4SfjpM8xQ+cwqLYYNxvO/y4h2QW2z1XqZW3IH3FuNisBUKI7WL+s1h0Si05JMU83+B8mmJMjzPnVfTciOv9bGIbhc5Xpe7U3NOUwgkf7R5bQxnM/pS8E+gSvH6yCpIWeaXKwElrN4/AF09cYSasV4vammmKgOBu9OjERStr6KBy/xd3GrXJzqdr/Nyt1Pe5ssRkbhFhy01JmfLTiY+HkwJhVBaYoyLKfFwELFHK4zJv+n9/+NZaya3NwH5h9k8GFI4dZcSIMgpjpd334+vodVbZhix7tJjppjGE2ZrtMxW1wyOVs43ld0Qq2zWfjr/jbgIfpRT9BKJrI/mur3cV6lRfpRahktQuvYC1e5W/3Eam8X8SF9mV1p//hUqmflFTBKHpXiWh6ldeFD2O4JX4H7cRYEnN2yNEn0ezC2LzrnWvIUZOMzWgcB7302xCQaS3ZZ5Gwug1GUPO+4OmsYdiax21iHkfIvxJ9KUPU+tDXNKp4JhOlwj7W564nAGZleJeDcIhUl10NPVQQQLdqZJmCrUbTJ4256CFmt+N8HIcd0Nfx/bbN/lzBjY1WdZKIeU7uLZI2x18QIj8Nf16ja8C7r+KOqe89hqwYay3N8dc2A+XNQ6J3hEBcF4NLK7M70L6vcKcg8vwvQogY3Qz6fXDH6j27QvwAbNR2aQ9nJqJtnTFt8mbMut6XlqSnerNHcvE6e3wWqsFOxG0Z+e1UR8TZV8FJU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(7406005)(7416002)(5660300002)(44832011)(8936002)(41300700001)(2906002)(54906003)(83380400001)(8676002)(36756003)(4326008)(70586007)(316002)(478600001)(70206006)(110136005)(7696005)(186003)(6666004)(16526019)(26005)(1076003)(336012)(40480700001)(2616005)(81166007)(426003)(356005)(82740400003)(36860700001)(86362001)(82310400005)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:21:50.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b0188c-5d0e-4258-51f7-08daf579e4ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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
index 6cfa6e3996cf..0ee891133d76 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5221,7 +5221,7 @@
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

