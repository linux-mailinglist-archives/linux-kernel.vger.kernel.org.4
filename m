Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD165494D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiLVXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiLVXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:31:45 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057AAF598;
        Thu, 22 Dec 2022 15:31:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R53UAYdeH3h+J5oUkYGhfb3U2xbCnUmZnlo4nLelLhQuIkQ8WjbrGLcbSOLSXJDibv45PPLFDLEE7dWxrqHPmK3T58v2l3C0RuK0Ek7sC9PdQEeR04BqSDXRsMbsry2hHXifzJcnnaAgkQpCfz+Ch9MB+u+6aFekc5EtE4DPefAcwtNqiwR7b6jPqFgZa8G8bBKP775oC91M2yvxTMkGHC37C77psJuOn9VBm7fzIgiADC9+ysPfjo9Z3kZzQPc5q814oZ3Ve3WCEnidfsuBB7xVC0vUYnfi9UnUs1/F+tAoIB839NGtsiiHM8iHB+Ev59Ijhzoes4SfCkivkUTitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=ggxRoCxbZhR63FoLUt7LcM+LIxTFSEuCkB0XLzxFtSg0IAD5Bnp8TFwnvFo8W50OUZP1BmO7hqlXShXznC5XkTnD7ynyvuZ7LK0s0rGQZ0mleubA3wDOTgtf7YWv7N7BtA0RE6LzljJMX6kHC5DfxgqRmtRY1ms0o2wBNjm4N1MNWhdNAdCJpQhYT4YNju93D9fOYXgsVHnkcDlVMVZaSBgnWr0rUyaAe4lrljM5haE2rgF4lafgRFQzazpXg1Goog6zTwUkUpoBommdVgBzSXW1JIjZNbNEUNZhAPUCjl/L7bf48Ctl/MqhTUEqD0rI8KEZGuhKtJtzoT9XmvOoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1F1GLlMLfSr5l7CElB+d0nCVkbg0nKh2QbK6amZ2zIc=;
 b=MsddbRbOjSyW80XoM1JxGwyR6PbnPeeW2wbEYAGGHwI3uQoENBIDLMChPsApcsVGxpXRJjHVabKQAVOWQufLUkCpVV/CbQa37EYPbKjwbA8IsgG46kySGBB9E+4JF7DsRQpOB2+XaoSVVtxmyGSYUbzlKxOwOmz33I4laM0Id44=
Received: from CY5PR22CA0060.namprd22.prod.outlook.com (2603:10b6:930:1d::23)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 23:31:42 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::ad) by CY5PR22CA0060.outlook.office365.com
 (2603:10b6:930:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:38 -0600
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
Subject: [PATCH v10 03/13] x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
Date:   Thu, 22 Dec 2022 17:31:17 -0600
Message-ID: <20221222233127.910538-4-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9d0f3a-9727-4a3c-1f72-08dae474aed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngIBcTJdrl2ZRV6KdixoSZD2klkqQ6qIcNd7nPKpaXYtJrOaJAvdEe61yBs2onMJxSphUVFbpJLhOYzCKkN8inOzvbJFxA6mttgW0ZEaNHEGzM1jDZ4rU/lJMZVpakzi7km/WVp0GmsKzDa5UhEdbiIV7UfDJjIDuUaCTdF6UhFnJLiCbeCh91vBKVreP5gTbBG8evUwVHzv9DmLcTwNYtCHO6dtVxsvJKAVyj39muwgMg4MWQN0vFQaPyyb9Sen1TexebEMszXHJ/SHCcsCdu1zULy6wfcENsBgT/fRQ/QWEwMTyZSfE8Cfd91PjMyJPnpEuC/ISf7pG9UxJ9hdQPqbG7d6fFxW6y/YnOJk7KGkgU0zxKLp8uW3K/ztKPVeU/Hgp3fdTn/C77PAhsplGjnsXsZDXbbYQ09pGe+CpjvYyQEXLZCmD0Z6+WYIvYTIgCNe8bB3b1RlvSVnDaIk3Aa1Hz0PXUHJ5RGp7CmmwIj6fc1t2PF17SsF6M3WAxmP4PAMN+2LQ7R1IjxJus18vrWirWq4GHooMk5/O/a/utC9p3voMsaUcHgYbcMWbOwh0lE13aH7AWlTFrQr60aSp3lRZA+Kf174TuSdxYuAR1fILnMOCByT157Zuy9ww/W56uUATrjXBqgFM7Su+R/FhcvVrktWG2WIaux14vK004QUTbu4uF5lBKJxrgr9YB4pPkdY2cSnUa4UWMBHMnCZA18M9TrtSeU08DY4sXtI1Uk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(8676002)(426003)(41300700001)(7696005)(82740400003)(1076003)(82310400005)(81166007)(5660300002)(36860700001)(40460700003)(7416002)(7406005)(47076005)(8936002)(2906002)(4326008)(44832011)(36756003)(336012)(356005)(478600001)(6666004)(86362001)(54906003)(110136005)(316002)(186003)(70206006)(70586007)(16526019)(26005)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:42.4907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9d0f3a-9727-4a3c-1f72-08dae474aed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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

