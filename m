Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33986C95CA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCZOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjCZOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:47:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B97A88
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxycigX4V25dMjoswm9lzFwIrJDh2gB1PndVR6h7PqmRBDKSwPcLCzfLQl+INH03xDp/K6P1fJu/faoYQY/xQUMmit212V6gqN0Crz33LLPD4r7BzrRNLhlSJfDgwpZ/n0x6UZvUuT3uRDcAAB2c3aWSGAxejnQ88ABQJQyPbebOSgCOyNI3k08fUcUYpuXLKEDA1MOYTuRA+izR7rHtmQkpgaO91/tzENeqQt9k/vu5+V5qyfz6sXpfUXojZiP8LqfA91vmJtdq4Ehq5qmnLwBSeMZIHfOn0YKRKuv+fWZwCxmkY4wSZuzR3KIrypFnToAmCeWP2Fadqm1UAFeI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2HoLyHFCavrP2EYHHagnBQpLIhkR5uHWiKsotNsC5k=;
 b=l7EIO5bSvNHi9DIpo+/zsLQbiIQSC2oYMDsSU4LWhgvUJbE2NXyoovdNndx+jdXwSThFmNV9Mtrv+g+x+hh/F1XiNg6z9C70ylme8xgF7CLkKdLdFG6MhMxOHgn2sKuDXnpkDoe8dZioDvKEyhGLXtiz0Hb4Bt2A068VwQif1WNRDGtuzSJY1VCFDhmfWCin+8nOlSxSKd5pnEa86qocdxrPt+E0I0GDQLG4/Rn+EZlzzQncb+wrxZuyAiUc2Rhu7kMKFH2aYgaDd7Pk6wbCbxhStt+mV9y3bCL/cvjsB5OE/HYZSgJrQFyC58zcZtz4Gxx0hpNX3V1Kf0co+029mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2HoLyHFCavrP2EYHHagnBQpLIhkR5uHWiKsotNsC5k=;
 b=Z5oAlUKeL8c78KRRnniUtVW9h1TEGypjc1e+pRi7O2dnI7CVaUwArHN1IAzlM0oeCbvnlRSqz4reIPf5pNmBPD9tGS4H/eQt76wIk2IQhUJOgmzrrC/KEZLCe0H4UN87VlMxFDrau92onDfJs8etIpuiE1NM0dAd0hKTAH/EY4g=
Received: from MN2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:fc::28)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 14:47:46 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::93) by MN2PR02CA0015.outlook.office365.com
 (2603:10b6:208:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40 via Frontend
 Transport; Sun, 26 Mar 2023 14:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Sun, 26 Mar 2023 14:47:46 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 26 Mar
 2023 09:47:42 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>, <michael.roth@amd.com>,
        <ketanch@iitk.ac.in>
Subject: [PATCH v2 07/11] x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
Date:   Sun, 26 Mar 2023 20:16:57 +0530
Message-ID: <20230326144701.3039598-8-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230326144701.3039598-1-nikunj@amd.com>
References: <20230326144701.3039598-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff4fcaa-967b-4f6c-06a6-08db2e091029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVgTUKceVo6YdObVEQ4JQdnu7qK3xQP0BVnhJ0eN2Q+lXfAq+m0c4gwWGtDrAVbMM0ttfhlGbJomdH2YPE5CH9O7Ro+5pQBAepp+Hj3IOEshg3MFmgOM6QI+Q31x6TvNJCzyiwDyZvfWCStem1gVdHH5F1JjqlFQ0Zad99F5loKl40B5u1NKG2EsuDYCBDrPOSDtLxYglZ7+0g9ui8xruuIkAdFiSMHi5tFu7B+DbPidZyXMekOUiiGyM3R5GCNz4g+S9xUgME77/AqkMfxHVxbE/Q5EtjmQEgqvyWGPUp7HbrDUKzmLTtAQKU0HymhgKSp6/mLsvpD1EH/TcXj1zzj3Q1cvWCi7UXNtbbsbKpXJVRnsWWIS9hzH0aN+NFWwUcfrsJk4n137ih38aYiWjfrFL8i4e6xK0BRE+Ij/vCSjenD271d6/rUg6s8GjhOSfCrbmKMPxd5BJnEYDdNXaGiAS2/sDfS4NxEAKVNor+gnfxSVHXmBqHsFprBMmW40kKiD9WHU+iB/gel04l8dPef1lUYMFget96t2feknkFmyvsBfDLdLgxy9A8jg05VpLFT/1KiXCjFT9Ccw/u/37xT+q4+5qo3QhSxCCEieZwpaRNHM6Z5GJECVQcx9Fo3wBd+Hx9UhTc1dyaNXdn5/Rjwak2qDFZUd+w8kTj0kyexK9xloEd7AS/kKP3n9zqmV6jXIGM+o42iVpuFB/ZQJhlyeWdgtl62+58l/0oUGHFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(426003)(47076005)(83380400001)(40460700003)(186003)(16526019)(336012)(2616005)(40480700001)(356005)(36860700001)(8936002)(82740400003)(81166007)(5660300002)(4326008)(8676002)(41300700001)(70206006)(70586007)(36756003)(26005)(1076003)(316002)(110136005)(6666004)(478600001)(7696005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 14:47:46.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff4fcaa-967b-4f6c-06a6-08db2e091029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index c5ca97aab8c1..3750e545d688 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1642,6 +1642,30 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
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
2.34.1

