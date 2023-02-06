Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA368BFE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBFOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBFOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:18:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2871817C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPTNZ6BYdhbdSYFHq1RrKer9tq2riT4nVukyvcBCIsFR2rFrzPVJoBDDwsslfFl2702LarmcxRtZ7VNTsDOBzwkkkwVv7YHjORWlTQCrwQPMd9skUgmO9o3kELwtI37nI2AZDEmQYt9D62f0qLeDWMMTmxxFj01XiFmHKwuMTcdmjiH713MExzK62Tprhk+oD8SjXUDi+WhMWjc7x/9ZS/yQS0FSK9d67U6ohDgqGVIeIRICV2Pkr5vwolXgPCzU5ta7fPXen1ya2QZo23uvc5z+ESDvO6aHypKTOVgFdcGUQOE8hEClNSMtxBcoZ6BE0ilzulGEiAaW/d1OSPIQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8lkyPv38D/Q7w40v795oAFp/SRo1MIinpAbtDHZluU=;
 b=VzsmCp8oNL3uL4kVWGXzk4MIjvAZsYg8yuW2wNuDlaHW2ruv9gVjM1lLdSldJ9TLETUKqDPqG1E+6OPVcfhoStNEU5UGNrolGWLHh1e1nIe5e0kojDxcYHRudu5XR3d2cnJwbHpaeLqWGXP24UF/CCjRiS387zS2SXqyPOdoXVlgf5Oqge5Y2BskeJSbflXs9/EM7YQiuee5KncCJU4WGza1QZ/jwHo/IhX7l4Qiep251W/PLK2DKk6U96aOsl6eBn527FDE1CdIc60gVygtz2kdoF7gWRZIxtrHKnrtOKczJHPaHGg0bej0XRQFoW6NzoFewhgt/h8Ol8QiNYWliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8lkyPv38D/Q7w40v795oAFp/SRo1MIinpAbtDHZluU=;
 b=qUn0eZamEYepK0aEz/nbqgOG9nDhkvopviAek8dg2RZlT27V9JorLg6tEDUux1szXJdtP+0hvr4O4JvKxAgF356FTWa8u2zL4x/h7Ag5nUv1KHMy7Yr8HHxP2hSFJYW/jL5nA2X7qsRUbw84AsRyL/Yz2pB2/uM901oaEqnknQQ=
Received: from MW4PR04CA0185.namprd04.prod.outlook.com (2603:10b6:303:86::10)
 by DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 14:18:52 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ab) by MW4PR04CA0185.outlook.office365.com
 (2603:10b6:303:86::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 14:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 14:18:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 08:18:49 -0600
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <linux-kernel@vger.kernel.org>,
        <bp@suse.de>, <feng.tang@intel.com>, <x86@kernel.org>
Subject: [PATCH 1/3] tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007
Date:   Mon, 6 Feb 2023 08:18:30 -0600
Message-ID: <20230206141832.4162264-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|DM4PR12MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 558ebc4c-48ae-4691-ae2d-08db084d1253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dn1ZcTFNqRvxWoTi6GbbNjLRFrabJ04aUhD4d93cKr7AjujLSetyv5jWR0sleRyhgGEHIy1+8i8VAqOrRz77igZLiKyV2lqCKhpmM1NJE0D7t6mrU0U4zo+CzIBeejsZLAi/CR2oXh2RuggK6Gqh+91j3Qsg1aNSddCOzTKBshlXb8k9PzZ6cuzvilggPdWWWViGq1+0diQeYlQXlcFhDC63fYQCH8BftxMaGUAcONH0Z0YAjC2+GuoVPx833ZWF8nY9Zfeb0ZMRblbYD4XdqlreMvKX85JgDfWy39MLS/7xJo/P3AADH6AY/VpPTIlyQ9WobFJNt3IqPc+H4fXIfnXFZsymUyFsLYGVChYQt04U9OQIHHkrrFHFJ6QFG73eVlHXzwGjH9tbvmr+ftnHgRI+Un4q6gVPcw25JlGdfnMcScPgjb4sa11fYviuOyMGUrKyvfFYi1JeTQ7YtxN/yCEGGDHSQLub52Bm5oMuQReucVDWSws4cPBzb71Ve0uGh1v0L6Dz14RXRMFNtEW0Rtv/sBhj8h3duhjoSwKm2DTdxgzBSV/8zTpBev0BQFvSi6n/53Smt6pUz30qp2pMmmrbqH2bQvGMr6shCxZYrlpCdFqJzUs2jLA3S71EnVkPExoI/YDs/OL+qF6fgK6wonX4xItZ3KtvSQf7U6wHvTCNiP/67tycNSxprKg07I7W9s9gzw1sM9sVw7FFkdmTRB6Y4rW2pk93IASpIxsgRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(86362001)(1076003)(41300700001)(8936002)(8676002)(81166007)(36860700001)(70206006)(82310400005)(5660300002)(70586007)(2906002)(356005)(44832011)(82740400003)(110136005)(316002)(36756003)(47076005)(478600001)(40480700001)(7696005)(336012)(2616005)(426003)(16526019)(186003)(83380400001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:18:51.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558ebc4c-48ae-4691-ae2d-08db084d1253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaf Fn00000007 contains avx512bw at bit26 and avx512vl at bit28. This
is incorrect per the SDM. Correct avx512bw to be bit30 and avx512lvl to be
bit31.[1]

[1] Intel 64 and IA-32 Architectures Software Developer's Manual
    Combined Volumes: 1, 2A, 2B, 2C, 2D, 3A, 3B, 3C, 3D and 4, December
    2022, pg 3-220,Vol2A

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: feng.tang@intel.com <feng.tang@intel.com>
Cc: x86@kernel.org
---
 tools/arch/x86/kcpuid/cpuid.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 4f1c4b0c29e9..9914bdf4fc9e 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -184,8 +184,8 @@
 	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
 	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
 	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
-	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
-	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
+	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
+	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
 	 7,    0,  ECX,      0, prefetchwt1, X
 	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instructions
 	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
-- 
2.34.1

