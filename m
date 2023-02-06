Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210C768BFE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjBFOTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBFOT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:19:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A11026C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:19:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBKPTkxXr9SVWk0pZrVXCOC7sCmjQt7H1umhRKpYllWMH3GEoUsUal8zMW9ZBzL6mfoiRWE8upP6xrVmviPoJVwE3GD4+mfam5nZHqR4/fhXHDqWAUvwqXDkeEF5JysHHJZGJEvKuNTzkHDXMMbUbTSYoeNiCmR9dXuQaZ7Y8Obh/vKxMIAQuWfjH16D1WyYSlSQwO2paREj02Ap8MrYDm8dXL7u3KdmCayVkOLDWWfDw7itXkDEAR/APCvY8a51YLcS3VZVgfuGraQtMfgRIGK4QsgJATt8keKDvLZ0GM+CT8VzDvOiehROoYw09ocCn2Wo4QA+FJG92xxuJUrCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oOGbRAvgl2pAKnwqvNz6VRlYGA5GM6e5YaxgfnT5nU=;
 b=biexTv4Au+WPIVMWflUC4HU0cu5FMv7jBFV8dgmYjbLgY4NDZNLPD6Y2fZUfw3AMSY2RjephWxPMPc0Eq8K5FpxtZGqLSiQnzzbiv5M6zIOKMtJnmcOV+My40IhFrrVTQj5P0HMI+4ybkfY2iZjYYV7jmsspBTbD4rGGlr7bHTC+fOaOMzbFG4k8vCEkN3jL2HKWNoN/6xmEoLYVLyvryzFdjDIbyuwN0IVvVitVI9vlH2DRewIBwCxYx6SVVeI4wIce1JI0SoOWcfoSw8Kl+zSmwdtGR96YUu4jq0yvnASu8Kff4P7j5i/eBCy8acterSHciwixCwiUeSRsagtupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oOGbRAvgl2pAKnwqvNz6VRlYGA5GM6e5YaxgfnT5nU=;
 b=U7jK4QOdSUjlGhs36JaX4fFIBQ3WtzmWaCtS9fwG0usZbug3UHVSeWfEtMtgfbvLKeQQAZc78l/ezFpi4VeFh1tVop2TloVzp/dAvYWCb1HEMvbYHY0eufKZEl1HdwOH1TvEuoJVhTSr3gr2m5MLWoBeYaBfTkTT6AAA98vE1CU=
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Mon, 6 Feb
 2023 14:19:12 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::5a) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 14:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 14:19:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 08:19:10 -0600
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <linux-kernel@vger.kernel.org>,
        <bp@suse.de>, <feng.tang@intel.com>, <x86@kernel.org>
Subject: [PATCH 3/3] tools/x86/kcpuid: Dump the CPUID function in detailed view
Date:   Mon, 6 Feb 2023 08:18:32 -0600
Message-ID: <20230206141832.4162264-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206141832.4162264-1-terry.bowman@amd.com>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: afb18c5e-beee-41d6-93a7-08db084d1e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WluxxcW4dLJvmqnwSEqJRuFfuFQ1f15omu4JaRBZ1WXq5bhfrRKKQTSe0VQ+XL1MCDX4t/Ux/sg4vf6b2KMYyRi1i2rrD+LvOex2k96O6ioERvhuAGFXKpUiefF56XW5jKjmKP1fzgUzk8bVpug8x+AuqJYWTWY8tywktOStsVQ8pb/xEw7MB1kmBzXGBOPQP3u4IWZrfx+ifl9P1rSBSUoObYbq8dfnr4vpoL3bqgSo3S9vGNNr6/q42IdH2yiTgiSGESl6jSy5mQUUE8r9ZygBM/YoPFSXei+/lijS9ay78irVszFga3GH2N0FfhsuhJNdmA5bo6mHxjgaoiZV6IAgDMJvSLS/kof2zZsF3kFL1WDAqHTFzWOC3dRBl7FokhwcojZmtpV5KvE1RIr1UL/6gWyp9ZXm1S4RmdW8fZcMWLWyZPDxCHjBx4LOI5FL7NTLfdbFmJ70joYAEkrpSzoNnnAoU00uyOW7KUDx5LhGbpdNZARBESnOyKU+kZLnCruypQkUAQDpyyQCKeZv19N1y/FdIgpFSV5WWrJJOTCoZEjGvKVKHtfs8LkFBFOcvBZJ6NyjdnRKqjOcFOm82VssInX4PKof77jv4889Sv5NiLMvbELje+MOPpp3qGIxDSFlk2GROs48NOTN4dLZg2x+Hh1pIBFS3Fd9Vzwo8s+u11DckX1KLzkGflfndwkT15QvDGzVoNIojxL0DZzoUS/Z8U0IpeQKDOorF7ks4Nc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(47076005)(356005)(40480700001)(36860700001)(81166007)(316002)(5660300002)(110136005)(44832011)(82310400005)(336012)(2906002)(83380400001)(86362001)(8936002)(36756003)(426003)(41300700001)(40460700003)(70206006)(186003)(6666004)(1076003)(2616005)(26005)(70586007)(8676002)(7696005)(16526019)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:19:11.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb18c5e-beee-41d6-93a7-08db084d1e58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Sometimes it is useful to know which CPUID leaf contains the fields so
add it to -d output so that it looks like this:

  CPUID_0x8000001e_ECX[0x0]:
           extended_apic_id       : 0x8           - Extended APIC ID
           core_id                : 0x4           - Identifies the logical core ID
           threads_per_core       : 0x1           - The number of threads per core is threads_per_core + 1
           node_id                : 0x0           - Node ID
           nodes_per_processor    : 0x0           - Nodes per processor { 0: 1 node, else reserved }

  CPUID_0x8000001f_ECX[0x0]:
           sme                 -  Secure Memory Encryption

...

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 tools/arch/x86/kcpuid/kcpuid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index dae75511fef7..3bab3398cec3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -468,13 +468,21 @@ static void show_leaf(struct subleaf *leaf)
 	if (!leaf)
 		return;
 
-	if (show_raw)
+	if (show_raw) {
 		leaf_print_raw(leaf);
+	} else {
+		if (show_details)
+			printf("CPUID_0x%x_ECX[0x%x]:\n",
+				leaf->index, leaf->sub);
+	}
 
 	decode_bits(leaf->eax, &leaf->info[R_EAX]);
 	decode_bits(leaf->ebx, &leaf->info[R_EBX]);
 	decode_bits(leaf->ecx, &leaf->info[R_ECX]);
 	decode_bits(leaf->edx, &leaf->info[R_EDX]);
+
+	if (!show_raw && show_details)
+		printf("\n");
 }
 
 static void show_func(struct cpuid_func *func)
-- 
2.34.1

