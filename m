Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB3669C23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAMP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjAMP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:28:19 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5977AC4;
        Fri, 13 Jan 2023 07:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EimhoXVwvrTIEWyUQ8yfuaisfUf82y+FBDioMYNcq7CvsNX9oJbczbmwuY/TaqW3GPCjNZa5/ciJfeA2CoEKZclejqxgTpwtQGbYb6i84QWwV0+8PCCJchJtJ0Hes+d2SX6AyaOpbwsZjzHRp5PV3yW7fvNF7f7YY1RfImljCuokj8kcPnsQRaqq1WfZjaM5deHGtREW2tq92Ihkb08dQNa990ogQyusqtoIjFFsn+jmcKf+sglotpfYuLrS9hm8mksCQX0vz8tbpDa4fWjLFFbPuR+mdXrrYe1cJ8vK9ozhckt8s83SqpPON/Gw7SSS7zsyTPnqREWd2H6m8yI08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=oXzQknaerIygZhCEJT2EJm5EutPN/d95Ss7KsN3eXpVy9ZIuL6Hpd94F9fOD4G6xtKNZ9l2mjqUVxOwZVp21UYI2/mQBY2rNtSMyMRzF987QPtC40YE3uxjh0dDG2FKyublNT93FNeyTHrE3YaFKStGRbdJo8/bH5BeKeVfCIckHcYgwXUKliLvN6Tyn5qD9bRnQ4oIlMZh2a0S429+CZdbhiOteYj5G2utoN7au654jzYlU7CNb/qTczSPcJ3Bm2GpXYbcC6e+vcsi+iufeOA22XhtbE4IpNzEuLGJWFszC1tafuX/J48KKwdQkWzTu1rA6tHMeLXt0VdLaEknbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=guafYJLeumB3qb0L2Sux7+WtRWRLXl3Q0KgjaF5XdibWkvVTg4MQSJn6Sgq7VcBAVF6VqPyJfAPb857TK1pk98pMYIWppaxfpoCQaoRJDkEq76Dwo4NeDgyQWPptkqPiB+WYAxftq0WYY3pQtAGuzKU5WnF8/3PDxclrWhU93us=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 15:21:49 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::e5) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 15:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:21:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:00 -0600
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
Subject: [PATCH v12 03/13] x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
Date:   Fri, 13 Jan 2023 09:20:29 -0600
Message-ID: <20230113152039.770054-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 412ca5b4-6b39-4e81-23d1-08daf579e3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WK2kuDp+yZpErMi9d73K7fKh8bOhIBle9HKX+WcSoZhYDUsJAWQYxX/QD5jvi6FFxdZVGLBZuwVlF2C7AWnlF6TO9GL8XR+wtYQhsh+AP6Tg7iGlwF9cyFuomV9duQKtXAsBOGt6AlCevvoZZOCmY/XaJ6NHnC2q809sHjrf2f1ZYgh0jKfF3RJg8tqNMTc0tYwIIb8+uCqfm8Q9eYLLjbQxoXKx2ihCnkWotF0I7PQPjOB3fX76DueZr8N4I2n043RE/ubphS9Vu/VamUCeGt+49Lk8LuSI2Kr51NZip9b5YatkdKDuLC1y9yC+dAsmkST3s10YAg3ovh6xNlaONK55kvBk1C2u15fkAExhswNMPlt7+sLovtzGvlTogmWu7+K4tcz+sI59tdA5S/ozleFhBQ/wI16dcEglMekMIAYQJiT6lK5J3ncfaBJZaCJqM67PHa9vlaDvNjlU4mByX1WFMLZyFt37QGzogNcF7g7pOO2suwASf8IYL34Xc/wRussrLNCT3Ns8vXwKv3lUZ0Z8AZv39oWHcMhqTzRL8nv4mzUnFvHpBRB4O8WdUE5tLr7HgIXyARTZv2KwEmg6lOF8QsuobTd3GXkEvm1Vk3L5OV5xgNpXbfO8hAywDeeWpFu8i4ANESue9MuAyI7XR649DAwlGcSzWSZ4EkhhApKVWMTcvYyBV//dNiiMkJtJG7KE/nEFflH7zbStjgjjIzxEoyLrY0iA75iuXVty4DY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(7406005)(54906003)(7416002)(36756003)(110136005)(2906002)(40460700003)(44832011)(2616005)(82310400005)(1076003)(36860700001)(336012)(426003)(47076005)(186003)(7696005)(86362001)(40480700001)(316002)(26005)(81166007)(356005)(82740400003)(16526019)(478600001)(70586007)(6666004)(70206006)(8936002)(4326008)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:21:48.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ca5b4-6b39-4e81-23d1-08daf579e3d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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

