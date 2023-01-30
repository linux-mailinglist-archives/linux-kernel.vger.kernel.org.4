Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D936680CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjA3MFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbjA3MFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:05:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C0303E9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvmnS9vpVv4ZcagOiVvRDNnU+luAmBQW61t2XGhvkMPSsb3KF+L5aOp02S9Lo2UEDzLw48qMUAXeHrMePpNbMLCHptoxC8zZKKt7spdAFRS8HDX7fwUY+2NTXv72N4u4X8/gBvIZUQZNAfbP/idv2ypzzQxMlB1L1zy0D4TSHSa1PdUh7B6KxQuUey4Xa5mcYnS2ai/pXxyvTc2/KLDMjF/i7Mz+RIUmh7t/iShqAVmZ6Pf7hI67fVEPIHgW2Hweys7vTkOqtMJdjZMT8veLka7ssbaZn/mIFqqveXdzlxcEA9HedQAcU9HcA33qd+XAwobfA+wFUHhsUPZGjo2ADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx+yG9AZnQF59rrQ73Y/EzwSREn+oR7ZAv4vA8HQdnI=;
 b=OCgnuEAY/bw8QOIVv7TcXkp6LybYI5YPr+pNVty0dr+xMqyIg7+MlL4uQQIKEHUSFEKePST4KSxFk6fBMnvuMQguWDB/hwdowRENY5yT+cQPi/P1CaYi30lcoYoTNidPpvwZfDSE4tERz5PizW9rk7hY6yeIS9hshIkBCAHa3sLYBRvT5hStxPlOr9zV5dhGuFBZ/JOuL4ucRswrkDuC0p1I+RHTrfRHtpLpc3AIhtpzh2rv/GCSlEeDBSEwyZ3LzNHBfRl4mIBHAMJoGZ35IgkOML+1/EtOPPhHMmL1Cl4vQK9yOPPo9Bsyewm8lQeexdBO4grGWoXQw3Yqt60Nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx+yG9AZnQF59rrQ73Y/EzwSREn+oR7ZAv4vA8HQdnI=;
 b=lJ58/dclBIqeY7X2HhhCWlyGAC+wHarl0tK7F/oj24axfeeizglCvvtID5o4HTlWTbk9fH4jZbgSOmzqTRLEuJBVeti3NGeqgllFzEZmdE/4Pz4lGEAtqRGgk0caIUjRjLDq5V8SiazQmg7xz0G/0cG7NI+jOO824Y2GLC1eNuc=
Received: from MW4PR03CA0098.namprd03.prod.outlook.com (2603:10b6:303:b7::13)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 12:04:44 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::7b) by MW4PR03CA0098.outlook.office365.com
 (2603:10b6:303:b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 12:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 12:04:43 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 06:04:39 -0600
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <jroedel@suse.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [RFC PATCH 07/11] x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
Date:   Mon, 30 Jan 2023 17:33:23 +0530
Message-ID: <20230130120327.977460-8-nikunj@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230130120327.977460-1-nikunj@amd.com>
References: <20230130120327.977460-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: e136874d-1a2d-4bee-fc56-08db02ba2cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Va56TmieqUpuuX3ejm4SHFtDUcVyu12qzAJwIRQf83F3nLB37audBm6oYg8JzIQFdh3ZZcyxq7YeomQ1dSZPBtSCJmU/xYFdT63r6xdbAIFnzTSGV3CbWuBthbksP0E/qNFipIWhjzdQ+8i+JMD+Cmf0awYrZmfpbuzPi83ruC8cz0RgbCTWrh6fpad814xtQrqrersX39HcpDL//YQ0D4yYNZoxV8hQ2hzpujCRZCzQdODLN2S+5yKQQAEnamovzxKiSQ4F+nHVhOf/puYARfv01XekZ/8dBXFuiIZu4LXqFZT4hmwoGqRKTQZIbKtBghZmkYQ+zESDB7qem/hHIz7VrWKDRrXx3YG3epaCTmN2vSYKTGKg6Pcym8+tGdRScS9g8+dEnoQF/3WxilU5TvaKaVduEHzv9BQERZVqrhtJDhfeE+n/tNxp5urACb37QO2pKheXUCgX3ZQ3uqi+ZZHRko3TvczvyUXVr9Fca9iIUt5ewE3+lSm7qIkNX/7JHaQE+YZ9QSkvrfWTs05EI+HIBpWai5dj8FRqElEcYTLtrDKWXhdx5O4u7KMAJwhHq3fewqPdyQMPO3TPm3aGk5s1weeCS5x6YKgdAkA1yn7kclbLrMKOukI1etz49uviNCjrHVeip8bbxdlwRCoSY+d6osSLzs/7O5/2fwkImTEXdFxYr7G7k586bZ1jP3FFgRLXJBidGIfJliFQXCWNlsoKp/zLvVI12u7uUspH7Q0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(81166007)(356005)(36860700001)(82740400003)(36756003)(5660300002)(8936002)(70586007)(54906003)(110136005)(316002)(70206006)(4326008)(8676002)(82310400005)(40480700001)(2906002)(40460700003)(7416002)(336012)(83380400001)(426003)(2616005)(47076005)(7696005)(478600001)(41300700001)(26005)(16526019)(186003)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 12:04:43.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e136874d-1a2d-4bee-fc56-08db02ba2cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure TSC enabled guests should not write MSR_IA32_TSC(10H) register
as the subsequent TSC value reads are undefined. MSR_IA32_TSC related
accesses should not exit to the hypervisor for such guests.

Accesses to MSR_IA32_TSC needs special handling in the #VC handler for
the guests with Secure TSC enabled. Writes to MSR_IA32_TSC should be
ignored, and reads of MSR_IA32_TSC should return the result of the
RDTSC instruction.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/sev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index be49a9aa3a2e..3ca87cd4548e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1601,6 +1601,30 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	/* Is it a WRMSR? */
 	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
 
+	/*
+	 * TSC related accesses should not exit to the hypervisor when a
+	 * guest is executing with SecureTSC enabled, so special handling
+	 * is required for accesses of MSR_IA32_TSC:
+	 *
+	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads
+	 *         of the TSC to return undefined values, so ignore all
+	 *         writes.
+	 * Reads:  Reads of MSR_IA32_TSC should return the current TSC
+	 *         value, use the value returned by RDTSC.
+	 */
+	if (regs->cx == MSR_IA32_TSC && (sev_status & MSR_AMD64_SNP_SECURE_TSC)) {
+		u64 tsc;
+
+		if (exit_info_1)
+			return ES_OK;
+
+		tsc = rdtsc();
+		regs->ax = UINT_MAX & tsc;
+		regs->dx = UINT_MAX & (tsc >> 32);
+
+		return ES_OK;
+	}
+
 	ghcb_set_rcx(ghcb, regs->cx);
 	if (exit_info_1) {
 		ghcb_set_rax(ghcb, regs->ax);
-- 
2.32.0

