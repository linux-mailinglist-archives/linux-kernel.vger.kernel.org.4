Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB2601C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQW0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJQW0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679A814D7;
        Mon, 17 Oct 2022 15:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYbB45TwOX+ssE4MP7RqpsmIFJICbbJnkDClATNiZQ5YrW7UoQWxau/HJL12WasVQmfPdyFSZBGb9vG/+80fo01dhGaIGZe44St3iBKaPxYZVmVbsx0kJ4ghGeyzCz6GN3VyAPHxvW8CNs0mVPrke8Gs1GqUKu5mjaqy4v6wq7a5G8qL0KnHGgga04QUlCspCh2Pv5vxflUQv6FnQmB6I/MHfw86LCK1KT96tW7PJ94EDxSM4drAVCXZ9GvVEH+M8M+L8uZLjvOQEraSmy7RkSJrbhl7ecb+ZYJQ+V7If/tYSy+lABvxN3WwdPU5Jd9RoO5hm4YWhi+jS5wznkCv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXUWND517tmbByaWEbc2CT2bAWf2K7vLcbL3Ozw2Fjc=;
 b=CIvBUJa9/brHSshNRjbqdn5cgnMiWTpi2thjIScq4pHsEGIZcPh77y5JrODAcZ6k0kShFoPaC/E9g7R1tLEcjYW66YE6SB2vAR5abIz2i6CIx++4L2Z440x0d5X1Ixq9lTHNx6ikGKBEK9pW5bscbd2CaBuPoAokLns2Y8TN71ktzYBvVDMly83RXxiCz047Wc6X8727xtZ3PWofxoG09pAjcIJQLls0nP9lWOHYTDAQcQ/5FhmNvqyCd3q6Q5aZuJdhowGR5JZ8RshxuRF0c0RFZ41sqae6SbWwNTQMoQyadv/ypRudkFISVG2PO4RchXK+hamp7BVdVAfQzd9qTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXUWND517tmbByaWEbc2CT2bAWf2K7vLcbL3Ozw2Fjc=;
 b=0BF8Q8q6nGvQMgetz/F96O7Ny58BQkJUwQxUG52RA1/L3DxjQycYGRU9JeDNHRGSgn5Qu9BDN0mfoZdrIuUx9CfRu1WzIFh8ZA/i1JD8Mr0S1DaGMTxfTsJe1N433bAIKStAHaj8eC02y7N3OJFmR2ipVfeEYNpnkbDj6FUGREY=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 22:26:22 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::da) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:18 -0500
Subject: [PATCH v7 02/12] x86/resctrl: Add a new resource type
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
Date:   Mon, 17 Oct 2022 17:26:18 -0500
Message-ID: <166604557814.5345.10995820967282890535.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c85109-db11-4930-d2eb-08dab08e9dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzAZGozJII5MupL/0pJd6vCC2vPd4ZhggQDouLnJ196wqGN2AFTUiEFA8i97gN74dHq5SR6yTI1gJNStI+MsFzMuFbM3F9ZhOtGsTYZyA+0UMe4OfLVI/oYto47JzAy+2JS2EwTQBSxqrG/Q+4U2ZiauVZVt3AVpsI8dBL27snN+IQWVJV5Zhg8yaRtEYtfRWL7E4jazHxo53OfsCYVXIs7JeZRxxmgp6MaSVZMUYYfdQ5FSNJMPN6GjO8RydWJgGGK8FUHnYJBSPI5hzUTJY3SZIqa2FykS/+gl+48xeIEzA4b6g4PA0Nf0FmUtUyNMRwom6tip5SmZJpOOFFsRmNCVBc/4xeElaZPr7jDfrf6ywxKA2uUxfxn3P3/wOW3MH05XibS7OT2+qpX5FlUDstl5Lql4OdIHXJjD+3AGcOQTSoWjoUB3M4XwZ5lgJ4u3SQa1gNVykoKzjoDtxXZpS8PrCnutHN9wjpPpWosChlrlSsVEcT6BAlVPURWA0fADuQfmyuzFPEkWCeJrK9aXB/YqPWJhD3EX9uCm1NQZYVi4WkLTZoJC060zDBFMGyzG62kwQpli1VD5DLGbuX6J8wWqyH+QpEIblYsntDcPpDZKqgsL0AqziCF664+Xapf2s79BdZWDqBXevmnvyzb7oTYPw/zgeFaXjW3m7ztvwm2Hh2r/FZQ8SfIfpv1jXIiEQ6U+EZBOAbQODklyJIvZ0ZXeWr1PLzA2VSAsOUcyKvUJ4jUQwvh0U5RkyGab65U1woEHU95LivpNtqw9pGwfyra1vUGI+ogi/SbwRsJLmsg/mLSaQnsW9J96eaLhqOOGfHvfAgPlRtYfkphminMY3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(47076005)(426003)(81166007)(82310400005)(82740400003)(33716001)(356005)(40480700001)(86362001)(103116003)(40460700003)(36860700001)(70206006)(70586007)(110136005)(316002)(16576012)(8676002)(7416002)(44832011)(54906003)(5660300002)(16526019)(186003)(336012)(2906002)(8936002)(4326008)(478600001)(9686003)(26005)(41300700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:20.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c85109-db11-4930-d2eb-08dab08e9dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
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
index de62b0b87ced..efffce716f3a 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -106,6 +106,18 @@ struct rdt_hw_resource rdt_resources_all[] =3D {=0A=
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
index 5f7128686cfd..43d9f6f5a931 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -419,6 +419,7 @@ enum resctrl_res_level {=0A=
 	RDT_RESOURCE_L3,=0A=
 	RDT_RESOURCE_L2,=0A=
 	RDT_RESOURCE_MBA,=0A=
+	RDT_RESOURCE_SMBA,=0A=
 =0A=
 	/* Must be the last */=0A=
 	RDT_NUM_RESOURCES,=0A=
=0A=

