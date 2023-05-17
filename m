Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9634D706E19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEQQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjEQQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:27:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE7093F8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+TZQ+Ry1jWnb2sffJqj2OQzGiaNPUSrf3zIPPiEOJR0n9buhoFFHrFxd3Gf2gZw10jWGjAbSOq7bR6afNNqtNSG5/vpRMMU09w07YWbfatCbTgpFC4LcI7t2RbD4smozatNB041YcBSI379hS/HWGTstqFYs8RKGsWLPY3cc1wQKiXNHUdS+H1F3K8Hfo4mtI7gu8bSt6OPhv1njpTE6ITnDxxLysz+10C2GQfdQs5I7cW1eeZnFLjqz2+iT3SP/rDJ2Xz1dvzRIoOZ/UNMlKKIXPOWiQuBVTXLOu2ZO5/RqtvOZAUkTLnvxgAUvKHjCe+TH0D1X+rCtbfXeA+ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxv6jH/nmnRvTZMlXQJlodGGXD399xCHGamyVpZ/pfQ=;
 b=ealokLvRsGorOc1xjFMTwQ86484BFv78g6xFFGwMXRD185tvSaQ8Xn+gI7AAO68Yg1HBv0kkjZ0i4zvMRfZUT+TBGPU7f5lGdhrozjGZnY+Mtct81kBYZmhXVOmwwYo/Ned7TCY+lgRK1K8f3MvCtsVTc5Xg1GjZJEjQ9Lr5IoHbxFmWjThnlMJsuqqcg1m6SxOmKfoEfmUgsKJpDvZqmoDEJI2V+GL/F0YqxrTBi6oGsG+0wfd8WNIks4aVkh2DdRc7mzmU7625qaCuMvyJQk6nsnXEM0P2aI9HU8bqnYmniPpjSIEqKqW/2FhmzzVwshR0oNvbB3Tc8riH0adNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxv6jH/nmnRvTZMlXQJlodGGXD399xCHGamyVpZ/pfQ=;
 b=pVqTZl2NHHXirfkdbi8/Ue7uqeaq2JpnDqPnRXsS/L9QcoH3oFueRa00tsuiCWM9gPTImI74hi8b1jfpst9RqCwZsq6PJAVJUlvXASNkXZO57lU4XcD89yMVo5Tp2hCxNZ8HEdionnr09fn5IJkzcNcS96d+jBUHxOCRwd9y04k=
Received: from BN0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:408:ec::30)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Wed, 17 May
 2023 16:27:06 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::7e) by BN0PR04CA0115.outlook.office365.com
 (2603:10b6:408:ec::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 16:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 16:27:05 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 17 May 2023 11:27:03 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        "Ashish Kalra" <ashish.kalra@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/head/64: Switch to KERNEL_CS as soon as new GDT is installed
Date:   Wed, 17 May 2023 11:26:41 -0500
Message-ID: <6ff1f28af2829cc9aea357ebee285825f90a431f.1684340801.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SJ0PR12MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: df1581f7-2377-4a98-0bc9-08db56f38dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61W733DU219l3cY7MLAGKNz7/f7FIG9r4vX2kXjXT2LhlFZzallf/lUzJNn2NXCJmlhPZXKhL/sM4f46YfQiPFl7ZxbXeaXEMyNIFbhRYhKrLdGanrNA7kbd77bu+1oVBoICyqFTe+UeRA3/4TDR4lTZdmbPKjvY5tdAX+bpcDm5k8pUfo9js0FjwaXcoue4x2z9MZIVxvrkQBIS+4voI9D55sJTT9f70CQxEk17Nfs0CHWm9ZAhEaJfPZa01o5DnXBVRAh5NquIj3gUg7u9BZBBSdhezZdekdIsXHg5MR1aC5vokivUHnkU6iGX3W5oaiO/bGelPO2ZSi/jBf50XXPF+fOswfNjwhi33vVL/Gg+WxZ8Im2F+XwoRPbOGsOKVSYmRq1+/oBObxpKswmkZ163J2L5//ORGkVjBR8QC/8KuvG7QZZ6opXNAIZC2hplrAscJ5iEvrJhC43VImLTNCansqXB/XpDQOL728lKsbVF14B2NV3VqjCCitcgMmti5b1jj+yKzvbFL+OE5rHgiOKB3CTW4waC7vky0Rr+9qoSGdB7BKcNs6DS1kVv5JGBL9ObGVLuG450aio0hf4TDPewXHjdqtW6HRv8S2xmvJnlCz8WfLw9g0jiRhlHsqy7mE26D0UCPmaD3UPfH5lMnYtShzwF+8mldSe9GU7XieT4GcOBFgtxH1eQoPzoStg9dsMJ9oneAroDStgwVRRQKwqD8c7YfGV2e1HOWIkqoKtojU13JgAw22O+CEHXpFdBxO1yz4wM29iy3cwFC5U3dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(336012)(47076005)(36860700001)(426003)(83380400001)(70206006)(54906003)(2616005)(86362001)(478600001)(40480700001)(110136005)(6666004)(186003)(8936002)(40460700003)(5660300002)(8676002)(26005)(2906002)(36756003)(4326008)(316002)(82740400003)(81166007)(356005)(70586007)(41300700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:27:05.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1581f7-2377-4a98-0bc9-08db56f38dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to startup_64_setup_env() will install a new GDT but does not
actually switch to using the KERNEL_CS entry until returning from the
function call.

Commit bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in
boot") moved the call to sme_enable() earlier in the boot process and in
between the call to startup_64_setup_env() and the switch to KERNEL_CS.
An SEV-ES or an SEV-SNP guest will trigger #VC exceptions during the call
to sme_enable() and if the CS pushed on the stack as part of the exception
and used by IRETQ is not mapped by the new GDT, then problems occur.
Today, the current CS when entering startup_64 is the kernel CS value
because it was set up by the decompressor code, so no issue is seen.

However, a recent patchset that looked to avoid using the legacy
decompressor during an EFI boot exposed this bug. At entry to startup_64,
the CS value is that of EFI and is not mapped in the new kernel GDT. So
when a #VC exception occurs, the CS value used by IRETQ is not valid and
the guest boot crashes.

Fix this issue by moving the block that switches to the KERNEL_CS value to
be done immediately after returning from startup_64_setup_env().

Fixes: bcce82908333 ("x86/sev: Detect/setup SEV/SME features earlier in boot")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/head_64.S | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 9cd77d319555..c5b9289837dc 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -79,6 +79,15 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+	/* Now switch to __KERNEL_CS so IRET works reliably */
+	pushq	$__KERNEL_CS
+	leaq	.Lon_kernel_cs(%rip), %rax
+	pushq	%rax
+	lretq
+
+.Lon_kernel_cs:
+	UNWIND_HINT_END_OF_STACK
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
 	 * Activate SEV/SME memory encryption if supported/enabled. This needs to
@@ -92,15 +101,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 #endif
 
-	/* Now switch to __KERNEL_CS so IRET works reliably */
-	pushq	$__KERNEL_CS
-	leaq	.Lon_kernel_cs(%rip), %rax
-	pushq	%rax
-	lretq
-
-.Lon_kernel_cs:
-	UNWIND_HINT_END_OF_STACK
-
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
-- 
2.40.0

