Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7018363F41E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiLAPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiLAPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:36:19 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAD01FF8E;
        Thu,  1 Dec 2022 07:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ1TWKgf0VHKsvhgXrHJRllwSNt2TqSJQqBNnide/OWMZfXRwKC5iYizStlghguI1DxQh6vrZHYuK/p4W3zrq51gWzb3w03jxOEOcgfWvlsMp9VHFSzPHBLyL3Gen4BenAG6HxqUMDrhGrYz1N63jYQmlj+Yw/u/DM5gZybqYz77d5CXaem2G2ydcNamDU7d2HG5xJzzoGftYYUeamPOKKhy72IRCvt97Zh5wZMsR3WHlZU74RMgcXSjl8BbVPo72fOzRd0O07m8LZwgrWA99xYEE9tC6OwTRWmdILi8WBULgqqHWOMBVUoLZ5aDU43I/RNYTNfZQrxVpbRvJbDcpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqmqaHy5wf2Bf15//G3fdDODZMrh5F7I64ht4ch8z/o=;
 b=d++VA/FoullOeQoyq79U4zFFewOcKNA+ioUifG+3UNsmTcss6tO+4tgxnlrY6m4Ie5okN0j7XLwyNp3lSnVssZPky9BjaDUi92W1QqQZ0h4fDFkqTcKyw3jQILkWGt2wsg8EStwzoZgtpqLC0zPiz6E//Es/+OiIZipGj4lhlpL5DPc+YTzX0C6njaYtKRRtZzUkY7mooWiO8NwTcgNtWmbZHRDJi5GoFjtrWSL/iLzDZPbJJWAdJS2Y59uG2uVEzVzNmxNwN4qBVRFBhCH9sOiZPlOf/cib3f6ypJuBbN4/kCMT7tm9ueB6VCJvkj7HcYmU5t9Drfvlzc1fK7uiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqmqaHy5wf2Bf15//G3fdDODZMrh5F7I64ht4ch8z/o=;
 b=v9IZvcsiRGJcRuw20PJuAaFHAYm06oVusFPkSpdMr4LqQ9NMYNDJReSl59eSOZlaiatkT40hRhKOK2nZ2X0MAAVxBBhh9vZ+NY502sAexeBt5KkehhnMK6cPvUksao7oM+IVH54iZYgcEMKHw4yj9P4Vt075S1yv2yYoeWVdInI=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 15:36:15 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::33) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Thu, 1 Dec 2022 15:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Thu, 1 Dec 2022 15:36:15 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 09:36:13 -0600
Subject: [PATCH v9 02/13] x86/resctrl: Add a new resource type
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <pawan.kumar.gupta@linux.intel.com>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
Date:   Thu, 1 Dec 2022 09:36:07 -0600
Message-ID: <166990896761.17806.7084760980218047026.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b39381-904b-4081-b16f-08dad3b1c86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xduJVruW/BKjlmHeYOT5Z9JF/glwMnJYeJfbYK/mTiWd99PcIRyEDhzw1zlyjgk/NIvRrSJAne5bFg7F3zp5q4onuQMS0KJqjZlXw62sVMp+c4D9ZMtp/imVD4BuF8x3tbe+TvfyK17tXpcPAW58nxSVK4bLxF7xdlo5lJcnyVrS73PNkp9Iod7VfJXJuhtAcCeJV9F2i8X3HPyC7ukbmGPBdVlSHYt5f4Rvl6QuQrXfHF0qcf6maRZaRmJyF2rH6lu0tkEppdJVpR/vj2tVM5kv5JqUPKvaYjTL4/hqees+mlczDpHIVnGD6xy/EWXUkEyOXlZXFWLAHFCD9H0xj/LBNQhh0yi81hyg6FsE1HuGZgspJHzB/5kpn23qt99qm6vsBXNz0ICIayKVHjoYUdxv/myPRlag8//eEuS0f5HwrpUycM49/lEIUg6bHIVNwVWIXb4fSfclonFgsKAXxg/Rd93pcyov6FtM8V7SAd0F2Q0wo5DW6ZysGwtMbqwCbsYmhasElGWd+XuBEhKIY/v4ZQzs/K8KL4GHVD8uKAdTCidmrpsHGGeqeoZKO+ALaZJodLbhJfFFVYLry5kKbhIVg0/LMCujT7GaYdyncYhJu4uMjQhyP3jK3BRVmhWewLapQ9YGQooYwmtFUav4STF3VAkfvbFqE4LjTN7sdGBE/eKa91f75Aw4xXgyz1f2Fokak9bIUcTe8bpKNJ92D/UpQh7SVu3NRvCmosZhI2wuSgxAeDfUzXxUDyS1dcbb1CzfkT0bXqm3W26HMn180Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(6666004)(478600001)(82310400005)(103116003)(44832011)(40480700001)(110136005)(54906003)(316002)(4326008)(16576012)(70586007)(8676002)(82740400003)(9686003)(41300700001)(7406005)(8936002)(336012)(16526019)(40460700003)(186003)(70206006)(33716001)(426003)(86362001)(5660300002)(81166007)(7416002)(47076005)(356005)(26005)(2906002)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:36:15.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b39381-904b-4081-b16f-08dad3b1c86f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   12 ++++++++++++=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +=0A=
 2 files changed, 13 insertions(+)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index c98e52ff5f20..f6af3ac1ef20 100644=0A=
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
index 5ebd28e6aa0c..fdbbf66312ec 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -409,6 +409,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

