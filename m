Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8DF601C53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJQW0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJQW0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:26:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA2814E0;
        Mon, 17 Oct 2022 15:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeZGy1D5AlZleH3VjSO3A7MeCe8fU3IHz4k6artwiW/8x440lGKTCNKJvGp9dnVMPEc79mxkCMwjWeGOothEyY1F0I8/4Z2KIr23ZTcGQDt1jC31ZSt7djO5BwWmFzF7IS2NMNv9DHhoKw0G25j971hHBEtnZRP37ol1/1Ot765efwe8iOPgNIxuX9Y2YX5R+AEyiwJn0jsQWrtAD1XeSeeC92qrT9b/kp0sXVAFuP5cGQmeNC8mE+A8xli6HgbeKtSNcUsIJ00esDfYtN5NbMln712owpqTi9IXCgfXNpuMT4s7kx8e+zyDFVn+1RaRV2INZfJatID+D2S31sdmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSm02XV3XZEFn04nLHzL7xnXTw3Dm4EvTrmeFsesXnk=;
 b=Wt5M+8gn4paN3u+9RCzxGgZMSBc7+rU6fAkOfC72kMRJf4TbSrYvORsZI6ysx44eTDpXDhOJChWvSmsvPa8o+lIuRUaZNeQsVpJB9ok5suTxxVaRrs33J0zxWOPuQG7NTgJKsmjG3YuD/bQwWtcMQrQ4XEY+dOui+DQABvRhQwK9Ydw2LvXViCOw5EIJN2LoBOShVbIW8J/6eRmm+tgJiUbAWTfQf0Z/EFX/bcOdXa0zGHn7B7N3xscuY/JsqgaAd09itKmzRUOl7R3vmRJ6SY6xd3KSX39tXjtcLUnVJOPUtEMs0XKYsQk0hgTzFJSYVESUg7hcz5a/pXjSppjrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSm02XV3XZEFn04nLHzL7xnXTw3Dm4EvTrmeFsesXnk=;
 b=BvIMmDZtNR0jSX3e+OfFr0+iinsMJGXxNzq5Un+zH1JXTs3Esw/M6UVN8q4yz7PZGp8h5n4Iq2X0tg79BRsbgu/J43h25nJ4bx78vfIsKvGL93e7spAS3mjFZNBdvMnimEY9RBsBBXJGem05jULk5wHorwQtCJ1KnqsNXaZyF68=
Received: from BN9PR03CA0719.namprd03.prod.outlook.com (2603:10b6:408:ef::34)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 17 Oct
 2022 22:26:28 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::19) by BN9PR03CA0719.outlook.office365.com
 (2603:10b6:408:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 22:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 22:26:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:26:25 -0500
Subject: [PATCH v7 03/12] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
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
Date:   Mon, 17 Oct 2022 17:26:25 -0500
Message-ID: <166604558527.5345.9308279363992246757.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd98b17-abcb-43ba-9051-08dab08ea20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+WceEQZoKApUnvvU4WNGjrxW+r8g242aO/hmKGIES6yBeeW6F/sxwkFuzYqD+k0J1kWm5zyQL0DA6FubUrwUx/1KQGqhxnFt1IUK1ZDxwKLgTsRNLg6MonTwLlvghxdDOwW9YQekV1FU+uCZ62HVZcdOvkYH/9rxMuXek88AgCnda9xGQhv0kj2RI1agv2vLgl09/TNyGfxJZbLt3gFTwM0zoqQjybrUfVs43EaDQ93HScw7mxUbeD8XSbxuGecJoHmXtT5grf850Hg56moP7vyd5eaVl3gNBpXPeJTVfaBMtBRZ9c9s/oUT3x1cWSTFDCgOihecxgIpqkcna7uGSeDI7pdZo1B+9RSZZn6gnvbiAUd5yjt/d2yMU9pU2YDCUDl0o44b0QHHtkSwcdvYokuG2lNTPNnHDe6h0j4q3Y7BVekHNpF9I/GYbdsUpBoHnzQiB7fIMSvtYuTZoVMSxx2yMWD5psWOxmLl37lou8oQV//AF9ekxxaxmt45s+PYOIH/xJnVFyLKvXl5QxEHIr/tAk7M8nqdGkQjYviONZXESPU0+So4foFuMbwV6As92LNNrGwuL4ceNupu0sFXsSVg5/x0a5myqi/XSPjtm+J8zRJdEHJEPEQ+08IWsiI3DqPRDfzgEOdqaA1cBcLsYGMCNWNkIVVDSEyzDlU5uLbM1dlLxNbQHZKnHi1qlw5fVbBz8HzcjmdYUptGLaDW6THG8AnsL9lw8+/XcgaeYZ42BPHsBHM346s7yyCzKWEb7RoKzD/K2K+xbClkLA/7Ox4g2h+lwt+uCIGKln88Z1trisYtOymeeOyus/KFW9xlyleOz/Zx+IpMimj1gITYdCaag5KUKqJ/bfmtaOmVtWkOJ8ZyVu7jrkLKoNJpscP3LiJfaXJSoa7FzHUC0vEjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(7916004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(33716001)(26005)(9686003)(103116003)(186003)(426003)(336012)(70206006)(82310400005)(316002)(16576012)(70586007)(47076005)(478600001)(16526019)(966005)(83380400001)(54906003)(40480700001)(356005)(40460700003)(110136005)(2906002)(36860700001)(81166007)(86362001)(8676002)(8936002)(82740400003)(41300700001)(7416002)(5660300002)(4326008)(44832011)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 22:26:27.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd98b17-abcb-43ba-9051-08dab08ea20d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC).=0A=
=0A=
The feature support is identified via CPUID Fn8000_0020_EBX_x0 (ECX=3D0).=
=0A=
Bits    Field Name    Description=0A=
3       EVT_CFG       Bandwidth Monitoring Event Configuration (BMEC)=0A=
=0A=
Currently, the bandwidth monitoring events mbm_total_bytes and=0A=
mbm_local_bytes are set to count all the total and local reads/writes=0A=
respectively. With the introduction of slow memory, the two counters=0A=
are not enough to count all the different types of memory events. With=0A=
the feature BMEC, the users have the option to configure=0A=
mbm_total_bytes and mbm_local_bytes to count the specific type of=0A=
events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0xc000_0400h +=0A=
EventID) which contains one field for each bandwidth type that can be=0A=
used to configure the bandwidth event to track any combination of=0A=
supported bandwidth types. The event will count requests from every=0A=
bandwidth type bit that is set in the corresponding configuration=0A=
register.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
=0A=
Feature description is available in the specification, "AMD64=0A=
Technology Platform Quality of Service Extensions, Revision: 1.03=0A=
Publication=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/cpuid-deps.c   |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 3 files changed, 3 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 583b88bcc7e1..bf0fd022e80a 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -305,6 +305,7 @@=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_SMBA		(11*32+18) /* Slow Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+19) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-d=
eps.c=0A=
index c881bcafba7d..4555f9596ccf 100644=0A=
--- a/arch/x86/kernel/cpu/cpuid-deps.c=0A=
+++ b/arch/x86/kernel/cpu/cpuid-deps.c=0A=
@@ -68,6 +68,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {=0A=
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },=0A=
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_LLC   },=0A=
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },=0A=
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },=0A=
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 5a5f17ed69a2..67c4d24e06ef 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
=0A=

