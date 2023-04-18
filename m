Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A35F6E6D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjDRTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjDRTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:48:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310C26AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qC9LtVsi+nY1WI7QhT3StX/GqrzL1auLJk3eV3f8uJTq7fTnYsU+Hoapt/2rd1j7IYfuqAlcuo4qgZV1ySpK++Yp5pIa5E4eUO4leebYhxLE+LIRR6yCcs2uPu1sQEoM4C3E1acM6+MLN1xqUYNalDnIahi8QqBKx8Mz6A+s4nkXL0u5wS4X+aUbdhm29QiE4Arwenwceam3HdE82rg2cgWhDh5r/tybsBbOgbdKdcabMXt2TIaZsuW/o7ILnpHdRh6e3bt+vxqugbwqlqvXtHw7Uw+X7WL9gSeXss5Ja3Pjmu8ZvPjPHxjPCPjJxKg3erCf8ZhHnrnu9CGBUR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1QKyM0ujN8MIg70hN50CWZYNE2zTZ84Lbe11dCVmwU=;
 b=KFS0FX5Qr4UnRWtryCMntRoN8+2TDNenZZlY0+Yz/36PYZHHblyVkcrRia9lD5r1yVr/KwW2t0bc9VgZ5KHYGvf/tShZJlIp48doKkymd0eDmqoQYuCsx96TcJu/9HbjVXRpUnIoVsP9p5jYsyTZq6xkDJ3+DLm5Myxj5AsXVT66Rq0Xnx9tAYdzLQQtUTnALD92t+kh9AIvhMkbZM8dByVo10uzjKpf3tyFcuuI0rjFcmqto3SW5QCuXelW90e9HYo/8Lx3N7LM0sopepJspmzY5wY+R2ZvcdYZ+F7P8E8eq52X5JhYtQAIXrFVsbcoKyudYK3Z0htumnFWqBoW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1QKyM0ujN8MIg70hN50CWZYNE2zTZ84Lbe11dCVmwU=;
 b=gnrXnIuPY2Qd4FVMbdKOeqtslgPu9Qr54V7LKvT9Ff7DlTgvXvOQKaIl3pY0WQYNXYT44L6zr6nHTf41Yc9qy36+t4Cu8NWQILW3/qYV/fqFd5Sb/AHbdpWst3Rnq49/e8xkE0GUOskioX+rRxy8dRdaXYNhONecONdCw+Q3fXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL3PR01MB7196.prod.exchangelabs.com (2603:10b6:208:347::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Tue, 18 Apr 2023 19:48:02 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::1cda:7642:ae1d:599c]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::1cda:7642:ae1d:599c%3]) with mapi id 15.20.6319.019; Tue, 18 Apr 2023
 19:48:02 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 1/2] arm64: sdei: Use alternative patching to select the conduit in sdei exit
Date:   Tue, 18 Apr 2023 12:47:45 -0700
Message-Id: <20230418194746.620266-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL3PR01MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a09d52c-3169-4653-ec20-08db4045d194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+/7Hq/tBfy9MNp/2lCX19KiMntq9BIV/hSbeyYDTQSq1/EFk7V2JgT/35D7BupWxTSZZZfSfWhiqOKcT9FxgbSlYwlO4nwF1Fzq0Y7Q1Q8dT9u2e13jFOwheqyY72ad5d1VZWRA94nEGkrTJucfPXeRZgXEmzSFwZbrPJamxR0jGE/WwH47uGUjanpgyb/zGbtiloJ1iMQHuN5aomfh5Z5Dbc1UCwyEq/KBMkLq3Tmibk9V2N1PRN88R1FDRnthrsss3TwpcUw1Dsm3T5XQe/7s+lNYTO2CE7OQAJStVFlElEPR1SAMYl7MhRnSuPYgpeKosp/23EuqmJC4K5ulRgi/fb0Kc1G87OMFjELLyrnL5Dn33Qbx/ZellJ/97yg2aw3bW236DpWms7hLKNJqzSa/WL5FPl6fRYXBvLWmOOTLPdfb2QsSV2PCba8KDw+VtM+cvj8gg2vkoeaQOxi7F3KniCBvO7k5y4mOkgg8Gk9dFFpzllOJVoixuER5z4Bpd7jP7jPjFh/xkONXhQWiCWxX9B4wBMMm20+GulfzeY04jr4t+jhxsHfOJcR7AmJAW0AXzZoZDrb9bEziSoZsBvUleqpOkQOHlyfZG1uWLMh4AdHkrv1lTNGErz9kcUVT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(451199021)(5660300002)(2616005)(26005)(86362001)(83380400001)(6512007)(186003)(1076003)(6506007)(38350700002)(38100700002)(8676002)(8936002)(54906003)(6666004)(6486002)(52116002)(478600001)(41300700001)(316002)(66556008)(66946007)(6916009)(66476007)(4326008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w2BifIuL0fRuESN4Jf1F1lg2TE0XhEwpJbdH8VXjGKGXxg5EOnfdF89MjZTg?=
 =?us-ascii?Q?zAm0booBx7Xd0TXzbMSoLVKtguOVe7ob7osfZCPJaFkyEASoYVP6lBw7b3LT?=
 =?us-ascii?Q?kDEodWFKS6MLiEd5EvI4rX/LzY6X6xwwemLSPCz1iBi868N1mFVNEQ/2Wmo3?=
 =?us-ascii?Q?42oqBg/VR0x8MZ77Wb+DmZ89uLsnI9ztE4jdfl321aSZN/FOCVOW9sxYneRM?=
 =?us-ascii?Q?a1LvMajCGFOjFnHuUeYvh+2GC0V2vPL4Q7oi3E26fbApea8Dr0n6S7DIApIu?=
 =?us-ascii?Q?BNRhDoiE3vkF+B7ULHPAqHQK/vb7Ovtru05UnfgNoLlUvQU0qnZJ014NftH4?=
 =?us-ascii?Q?GNXAGxlmT43+/nHjOq3VFs3APWcf3o9A0HP6EM3sXCJXiBtrDK1SoXJ099ZT?=
 =?us-ascii?Q?QVhp2+NUWOujqlLd9ZlDIVgPw5qU211/SNZKMQrHNOFs8Phims4sQJX9CZVQ?=
 =?us-ascii?Q?ISjwcXCBjBc7w4JE3SqLw1fIPQOS1efUIMdQbdYskSo4DGaVKO6PRB2J4/Et?=
 =?us-ascii?Q?n1p3Ai7MumLvO1A4OjUM1Fow9c3Xqc6L3vaPwr+0hC+1mBs9Rg5/MUl02X/P?=
 =?us-ascii?Q?hEwfwLZe2qqPTGgo4sfW4DLa+Bclng0DvwwDBSSZMHiTd1FMJoUw6SHlfg5z?=
 =?us-ascii?Q?PSZTVmBevnob/30aIfEDQH3BB82nbph9AVh+ALiZK0VtGm74QxJrjtdwloij?=
 =?us-ascii?Q?4eMaF9cIoI2nsZVRyWUYx70KIgeAerLw2mj+fo32jrtEJeA9XsCVMXmJoO+U?=
 =?us-ascii?Q?JNNWIhU1o9aA0fjwHHG4Nwnow/8HGc+S5WhzQVQ3qafuxGIf6ccWHUuCnpoD?=
 =?us-ascii?Q?ZV0CsIWpV4Fg02Lc0lpAP7B4MeFWMidGBVTaGLmY16JOk1D4MPGUndFqM4Ds?=
 =?us-ascii?Q?2vHThDeC+J3LNMlh1wZ907otqwm9P7kGkrp9I5nq9eHGd5BMLKHO6++gtxvG?=
 =?us-ascii?Q?LMx70t7A29L1zPDi3me9PcDGl9E1vACiqK28X1P+bxyFxc9NQ8C+0vunRfm2?=
 =?us-ascii?Q?hNaFxkQOMSgWC7eGO/X2bhmRbKOWHqBiSbprxgP+k3tNGub+qX5o8p7sHpVU?=
 =?us-ascii?Q?zZkc3Jl3H5eU+S/M628TOfkeqbzh6YeZYpBs/8f2DC1nWjYkRgqWM3KdFWhi?=
 =?us-ascii?Q?InwWhavmoB8RftZTEYmrmTOfTPffkiFiHwgc+mT2HB/1Z4zeNI287ZSpqleB?=
 =?us-ascii?Q?NUtJNDcGeaih9c/nKKUha6pSqrPOPtZnhAqFda3ZNiwVNNxVwuDYoZx8a8Ko?=
 =?us-ascii?Q?jvm4RYisn1+1MrqA3mIAkSzqSMrsdksEUKlsk5zS0GpvbKIaeOgP156CSXk+?=
 =?us-ascii?Q?ADeeJBKZ7HuqGEoID5dIKv0R70qn4dEcbJ168lbgo0T0viz/6ScLFiSwCGVI?=
 =?us-ascii?Q?l7t6GvukA1uKtEa5c5B2vuoiFbAhfoISWJ0D3Ol95IwlmzIz8dLw1GTVnYga?=
 =?us-ascii?Q?vIM94ypHwexYy+CYz4S9CgB7wcyfHPKRJ4uK4okuB1wuiR9oFDfedqONgcZe?=
 =?us-ascii?Q?IpOSs/pFiXSdlnO3Lw1FHs0TetcHtvMmDpofxcSecieSqe84/qYk0aN3bZ4y?=
 =?us-ascii?Q?/7pDvDhqUOfF0R4zXsGaUwGl4jbUGZPVtI/SaRRR9JbzsV2RlVPP1MtSh/fj?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a09d52c-3169-4653-ec20-08db4045d194
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 19:48:01.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CduQbcu/VGECtB2wdi2Cw1DtJI01SF9OUAyD03NNgIkxWKmM+oIsyDuuVXEhhGqHah1z3yfOFu+EsgVc/37sflzJATgtor/ITduxKGbfQcSxd2PIL5ZBBUh+b9JgeEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch in the conduit instruction for SDEI instead of branching between the
possible conduits. The sdei driver's conduit initialization is moved
earlier in the initialization flow, into setup_arch(), so that it is ready
in time for alternative patching.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
---
 arch/arm64/include/asm/sdei.h | 13 +++----
 arch/arm64/kernel/entry.S     | 26 ++++++-------
 arch/arm64/kernel/sdei.c      | 30 ++++++++++++---
 arch/arm64/kernel/setup.c     |  3 ++
 drivers/firmware/arm_sdei.c   | 71 +++++++++++++++++++----------------
 include/linux/arm_sdei.h      |  6 ++-
 6 files changed, 88 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 4292d9bafb9d..badb39510515 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -3,10 +3,6 @@
 #ifndef __ASM_SDEI_H
 #define __ASM_SDEI_H
 
-/* Values for sdei_exit_mode */
-#define SDEI_EXIT_HVC  0
-#define SDEI_EXIT_SMC  1
-
 #define SDEI_STACK_SIZE		IRQ_STACK_SIZE
 
 #ifndef __ASSEMBLY__
@@ -17,8 +13,6 @@
 
 #include <asm/virt.h>
 
-extern unsigned long sdei_exit_mode;
-
 /* Software Delegated Exception entry point from firmware*/
 asmlinkage void __sdei_asm_handler(unsigned long event_num, unsigned long arg,
 				   unsigned long pc, unsigned long pstate);
@@ -40,8 +34,11 @@ asmlinkage unsigned long __sdei_handler(struct pt_regs *regs,
 unsigned long do_sdei_event(struct pt_regs *regs,
 			    struct sdei_registered_event *arg);
 
-unsigned long sdei_arch_get_entry_point(int conduit);
-#define sdei_arch_get_entry_point(x)	sdei_arch_get_entry_point(x)
+unsigned long sdei_arch_get_entry_point(void);
+#define sdei_arch_get_entry_point	sdei_arch_get_entry_point
+
+void __init sdei_patch_conduit(struct alt_instr *alt, __le32 *origptr,
+			       __le32 *updptr, int nr_inst);
 
 #endif /* __ASSEMBLY__ */
 #endif	/* __ASM_SDEI_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ab2a6e33c052..ae7aa02f0df5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -914,13 +914,10 @@ NOKPROBE(call_on_irq_stack)
 #include <asm/sdei.h>
 #include <uapi/linux/arm_sdei.h>
 
-.macro sdei_handler_exit exit_mode
-	/* On success, this call never returns... */
-	cmp	\exit_mode, #SDEI_EXIT_SMC
-	b.ne	99f
-	smc	#0
-	b	.
-99:	hvc	#0
+.macro sdei_handler_exit
+alternative_cb	ARM64_ALWAYS_SYSTEM, sdei_patch_conduit
+	nop	// Patched to SMC/HVC #0
+alternative_cb_end
 	b	.
 .endm
 
@@ -955,7 +952,6 @@ NOKPROBE(__sdei_asm_entry_trampoline)
  * Make the exit call and restore the original ttbr1_el1
  *
  * x0 & x1: setup for the exit API call
- * x2: exit_mode
  * x4: struct sdei_registered_event argument from registration time.
  */
 SYM_CODE_START(__sdei_asm_exit_trampoline)
@@ -964,7 +960,7 @@ SYM_CODE_START(__sdei_asm_exit_trampoline)
 
 	tramp_unmap_kernel	tmp=x4
 
-1:	sdei_handler_exit exit_mode=x2
+1:	sdei_handler_exit
 SYM_CODE_END(__sdei_asm_exit_trampoline)
 NOKPROBE(__sdei_asm_exit_trampoline)
 .popsection		// .entry.tramp.text
@@ -1070,14 +1066,16 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov_q	x3, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
 	csel	x0, x2, x3, ls
 
-	ldr_l	x2, sdei_exit_mode
-
-alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
-	sdei_handler_exit exit_mode=x2
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+alternative_if ARM64_UNMAP_KERNEL_AT_EL0
+	b 1f
 alternative_else_nop_endif
+#endif
+
+	sdei_handler_exit
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_alias	dst=x5, sym=__sdei_asm_exit_trampoline, tmp=x3
+1:	tramp_alias	dst=x5, sym=__sdei_asm_exit_trampoline, tmp=x3
 	br	x5
 #endif
 SYM_CODE_END(__sdei_asm_handler)
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 830be01af32d..be7f6ea49956 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -20,8 +20,6 @@
 #include <asm/sysreg.h>
 #include <asm/vmap_stack.h>
 
-unsigned long sdei_exit_mode;
-
 /*
  * VMAP'd stacks checking for stack overflow on exception using sp as a scratch
  * register, meaning SDEI has to switch to its own stack. We need two stacks as
@@ -162,7 +160,7 @@ static int init_sdei_scs(void)
 	return err;
 }
 
-unsigned long sdei_arch_get_entry_point(int conduit)
+unsigned long sdei_arch_get_entry_point(void)
 {
 	/*
 	 * SDEI works between adjacent exception levels. If we booted at EL1 we
@@ -181,8 +179,6 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 	if (init_sdei_scs())
 		goto out_err_free_stacks;
 
-	sdei_exit_mode = (conduit == SMCCC_CONDUIT_HVC) ? SDEI_EXIT_HVC : SDEI_EXIT_SMC;
-
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	if (arm64_kernel_unmapped_at_el0()) {
 		unsigned long offset;
@@ -262,3 +258,27 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 
 	return vbar + 0x480;
 }
+
+/*
+ * Patch in the sdei conduit instruction.
+ */
+void __init sdei_patch_conduit(struct alt_instr *alt, __le32 *origptr,
+			       __le32 *updptr, int nr_inst)
+{
+	u32 insn;
+
+	BUG_ON(nr_inst != 1); /* NOP -> HVC/SMC */
+
+	switch (sdei_get_conduit()) {
+	case SMCCC_CONDUIT_HVC:
+		insn = aarch64_insn_get_hvc_value();
+		break;
+	case SMCCC_CONDUIT_SMC:
+		insn = aarch64_insn_get_smc_value();
+		break;
+	default:
+		return;
+	}
+
+	*updptr = cpu_to_le32(insn);
+}
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b8ec7b3ac9cb..6286c4c59074 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/arm_sdei.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
@@ -365,6 +366,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	else
 		psci_acpi_init();
 
+	sdei_conduit_init();
+
 	init_bootcpu_ops();
 	smp_init_cpus();
 	smp_build_mpidr_hash();
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..0dbb88bcc9a2 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -919,37 +919,12 @@ int sdei_unregister_ghes(struct ghes *ghes)
 	return err;
 }
 
-static int sdei_get_conduit(struct platform_device *pdev)
+enum arm_smccc_conduit sdei_get_conduit(void)
 {
-	const char *method;
-	struct device_node *np = pdev->dev.of_node;
-
-	sdei_firmware_call = NULL;
-	if (np) {
-		if (of_property_read_string(np, "method", &method)) {
-			pr_warn("missing \"method\" property\n");
-			return SMCCC_CONDUIT_NONE;
-		}
-
-		if (!strcmp("hvc", method)) {
-			sdei_firmware_call = &sdei_smccc_hvc;
-			return SMCCC_CONDUIT_HVC;
-		} else if (!strcmp("smc", method)) {
-			sdei_firmware_call = &sdei_smccc_smc;
-			return SMCCC_CONDUIT_SMC;
-		}
-
-		pr_warn("invalid \"method\" property: %s\n", method);
-	} else if (!acpi_disabled) {
-		if (acpi_psci_use_hvc()) {
-			sdei_firmware_call = &sdei_smccc_hvc;
-			return SMCCC_CONDUIT_HVC;
-		} else {
-			sdei_firmware_call = &sdei_smccc_smc;
-			return SMCCC_CONDUIT_SMC;
-		}
-	}
-
+	if (sdei_firmware_call == sdei_smccc_hvc)
+		return SMCCC_CONDUIT_HVC;
+	if (sdei_firmware_call == sdei_smccc_smc)
+		return SMCCC_CONDUIT_SMC;
 	return SMCCC_CONDUIT_NONE;
 }
 
@@ -957,9 +932,7 @@ static int sdei_probe(struct platform_device *pdev)
 {
 	int err;
 	u64 ver = 0;
-	int conduit;
 
-	conduit = sdei_get_conduit(pdev);
 	if (!sdei_firmware_call)
 		return 0;
 
@@ -984,7 +957,7 @@ static int sdei_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	sdei_entry_point = sdei_arch_get_entry_point(conduit);
+	sdei_entry_point = sdei_arch_get_entry_point();
 	if (!sdei_entry_point) {
 		/* Not supported due to hardware or boot configuration */
 		sdei_mark_interface_broken();
@@ -1059,6 +1032,38 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
+void __init sdei_conduit_init(void)
+{
+	const char *method;
+	struct device_node *np;
+
+	if (acpi_disabled) {
+		np = of_find_matching_node_and_match(NULL, sdei_of_match, NULL);
+		if (!np || !of_device_is_available(np))
+			return;
+
+		if (of_property_read_string(np, "method", &method)) {
+			pr_warn("missing \"method\" property\n");
+			return;
+		}
+
+		if (!strcmp("hvc", method))
+			sdei_firmware_call = &sdei_smccc_hvc;
+		else if (!strcmp("smc", method))
+			sdei_firmware_call = &sdei_smccc_smc;
+		else
+			pr_warn("invalid \"method\" property: %s\n", method);
+	} else {
+		if (!sdei_present_acpi())
+			return;
+
+		if (acpi_psci_use_hvc())
+			sdei_firmware_call = &sdei_smccc_hvc;
+		else
+			sdei_firmware_call = &sdei_smccc_smc;
+	}
+}
+
 void __init sdei_init(void)
 {
 	struct platform_device *pdev;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 14dc461b0e82..de9aafd87c48 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -13,7 +13,7 @@
 
 /* Arch code should override this to set the entry point from firmware... */
 #ifndef sdei_arch_get_entry_point
-#define sdei_arch_get_entry_point(conduit)	(0)
+#define sdei_arch_get_entry_point()	(0)
 #endif
 
 /*
@@ -22,6 +22,8 @@
  */
 typedef int (sdei_event_callback)(u32 event, struct pt_regs *regs, void *arg);
 
+enum arm_smccc_conduit sdei_get_conduit(void);
+
 /*
  * Register your callback to claim an event. The event must be described
  * by firmware.
@@ -47,10 +49,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
 void __init sdei_init(void);
+void __init sdei_conduit_init(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
 static inline void sdei_init(void) { }
+static inline void sdei_conduit_init(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
-- 
2.39.2

