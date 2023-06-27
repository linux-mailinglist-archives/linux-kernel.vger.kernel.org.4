Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E662E73EFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjF0AaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjF0A37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:29:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA51708
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvPgtVT5K045qPVNa7kica6hwcnyk2IW+0UQQkFE9jBSABvqWkgN1xXzO1BxXm7Lo3C8YgsTMmAUj4tyLojvUhKdR3x7shzslGE9mJbPijUpoqH66Wl8oVzr4ixk1qAYd25lac4BhxezZhNrlsYNUxDGNpC9UJs8nLspyJtTtDr1L2tWTNJUOnQvuDjMKMghzXL42lzkRGwW4yJ95pf7suG2QBVMVrdAwJgQrXc7f1eRsFrFFgxmTwN9NiKeMI9LjGdyKJgjLhiNlOJyFU3/ROU8Z4lrCYrrm8fP1SIS6DRbbKoCMbfqrSw3+plzTQ53tNnLEWivkLQi/TbtS7dufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+C2gtL7Ibjk4WeUqUG5om7JQ9Tj+V3aeBLNJZG7pCg=;
 b=fAW/Jupp0oLrqdR6XVWE7lHCVRW2QTS+tw0yEtRrP4aK/w+OGQdMRsZHTx5BrPz2YJm+5jAbn4FNge6VCAVwIhXZ9EtLn7xaEDv+520n3M4RJPp+PAIB5vUz7WCT1ItibdL1QAL867gmJ4KWdfXugejx05RzoNkmYRdzPjYE4v+25cMEZR5V5vdLF6ArcbP3ynjyPYMPNIB0ueW5zUuIxr1tZMJx626vba+RqWhdLUW+lXOmoVJ4WhRu7r35iC4S9OCLjdYyexPDs0tL2JD0f9uqU+ehrZ2HZC0nGrpjsJfOyabVq4YW3JlQGxWXLZk+QGLn/yCzW6jiFtD0aplWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+C2gtL7Ibjk4WeUqUG5om7JQ9Tj+V3aeBLNJZG7pCg=;
 b=NuCGWF3zsf+VuVPoR5rwQetJo8fMcgZoWrFNULxNJzGHYE7KJhIZm1qxxJs1xCd5UbN7Z2c59bQUySKJHOhNxZbNe6WmUn7GcfMIra9ftvS5Bzb19f199fSN1o+knk+HtXlq9aPuFc3tl8eUg92wKV/b6I56DHPtasvczbuuLSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 PH0PR01MB8071.prod.exchangelabs.com (2603:10b6:510:29a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Tue, 27 Jun 2023 00:29:54 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 00:29:54 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: [PATCH v6] arm64: sdei: abort running SDEI handlers during crash
Date:   Mon, 26 Jun 2023 17:29:39 -0700
Message-ID: <20230627002939.2758-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:59::24) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|PH0PR01MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: cfde7edb-9372-4855-8ab7-08db76a5a071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zguB3wYBT0m1JL0UWZXn79/r0ZL+mlszf4IuTDr/icYGH39L5GZ+H+Wl22qvPOJssaV8UvYRw8BzzZskGMTt0SzeXP9C/Ka+1wH8/kMaYxVMhfk+wDARYjkvgZP99kFgzJbYUgWlM18SoM7b7+b0ykrK+bIyqg5zSce/Wd/OzdtO+TBScPACp17HkFfUh355Q0hQin2AZPxEC99EOHkWXpPC95zfC6TfsW9UsHeiyndoHi7ZUqHwcmF0fYysHG5ZX63seuptXguxkIuJF3CAb7s5zgJJGtqVVUlb7Pu5Q8ASrNxJ/VoCwSPRGo5Vx0FkRAmWcNKM+10CIyoh6gH1LiL3LJbIlmcmrPAlP1O6gDVabn8lkkiGsXZ6kR26bFSlRvz/FgBFrtdggr0A12PwSnyNN2rUR0Z0D6JW0fK9vq1cbNzFdvF0svjMEiXvXgY+1mKCuqxxIIcLnJ+Ws2s2ozFoBlurWbCQ3O0si0TrIZZSUcSqHhE7XX6O4Ic44zOjQcgVKeQJfy4exPLGJg2tU42ChSI2PoySkB5bokCiq5uOU9lC9yfQJVZ2bTvYZXSywSuhcgLuTBI6NuDrkQpM5gR1ft55fz4NzurkwCIiJavWaIskJaHTM0FCjbxGouHkLxdTvVl+UdqD5TN4jwx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39850400004)(136003)(451199021)(478600001)(6666004)(54906003)(66556008)(86362001)(2906002)(8676002)(4326008)(38350700002)(8936002)(66946007)(316002)(38100700002)(5660300002)(6916009)(66476007)(6506007)(41300700001)(6512007)(1076003)(107886003)(26005)(83380400001)(186003)(2616005)(966005)(52116002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lNSrmoYVEwCvw3PRANeD7Z7KHdduIvfn5hvLHDkK8Pus6/Zp3trv7E6Fkptw?=
 =?us-ascii?Q?V4XSNTErez+W+BFc/2BkUB9RIBeXIFIddwncD9C4EBlEyFPrcHS5cs1QWrUi?=
 =?us-ascii?Q?QDmj9HfXqVew0JxnuJzmw4l5fZy0RBhYQ9XOwc03rmLHB4EgLsyCdLs8AgQ6?=
 =?us-ascii?Q?OV9J3oDE41cMFq3yqU2s7VZXtEItZYg7amo4J+OXhvHvpNd1w1LIOXl8sxbU?=
 =?us-ascii?Q?k1UVLmaiL0wL2iinxyCM9clj442mJS5WwBtSm9RDFvHpELiS4YzyjvgteG39?=
 =?us-ascii?Q?PzgelqscwFTsM1BcFGnbUBFoq0Q6+GOz12YZxmPDrA8TSwV/km10H3+6KT0V?=
 =?us-ascii?Q?uVva5AZJUKM0/mqYUZwScmS0hL7TE0D8tfdDwiyXECGSvGWMl6sOtwyYWGIy?=
 =?us-ascii?Q?FsyqdVkvoWq0SnNWgAnno0wIx6xw8ff2S3JARVujE2anPNajpwCEWg88TQtc?=
 =?us-ascii?Q?CdmNhdisSQVnE81xki1p6CGXuulxqcQAI8YixLGLijRFe+K9cycRiTs8Dr28?=
 =?us-ascii?Q?sissgPDDEP4ctmhnrQYzEQiPyUi1II/rnj8uVtCnNszTGMxoUVsWMotLeHMw?=
 =?us-ascii?Q?wHzgeeKigcFELdLKt6j4xNUY2LTWYPHCqqadrewdEnr4XQdQJxFsKgMEXYyj?=
 =?us-ascii?Q?RchRG3C1fflvrzE2CNaYeV/4Lh/m4WopKCUU3vZtSFv7E1PAkdeYbXISNirk?=
 =?us-ascii?Q?L7dKm5Fnut6sW397PDKO5dNGp8uEJKlP3Ggj+ENFdnD8vM8/BTKTbrpbcM2W?=
 =?us-ascii?Q?g84NYtk3K1Tl6VXyBg6OXkLtDStlXnYIhC/5MpqPCR+sdtknvRuCKQcJ6lVm?=
 =?us-ascii?Q?cZYCk7EY6k9niQ2Am7B4w13Aq/ZHZ1NGBDhdz0aqBEAQjvMxChEX5tHZGeWq?=
 =?us-ascii?Q?S88mQ8utf5e4ShSUQoDyrVrOUV9R9yTTyNGfAAbsNorh51F1Aws8cfsJxiiN?=
 =?us-ascii?Q?lZaQGEsri7W6CGTqQDKuFDyKSWcTkriNgAjPGhf6abdZKHl4RXm5t1DpVExN?=
 =?us-ascii?Q?xEU0dWqOqwcHqyXI9zJgub03wImA+qjWjucmcUCpxPP4FJP8L9Q7WYmgAcZC?=
 =?us-ascii?Q?WKQv22tN+BZnccFQ2KC4ZbGeEdDMjMqFhkBYomUmfA7WvHnH4gzhJgt2wza3?=
 =?us-ascii?Q?SG9qiZjYXjVcaDUB6q8yWUcbmt1zy/jIJBGaRqX5Joe9XV5hpALFET0RyPta?=
 =?us-ascii?Q?JlnlVRVMJBX+GyichRq/VTnW8iGFmo+r/DZgX4SjMVo3KcLh9amtc4FK3ngw?=
 =?us-ascii?Q?jE8IooNqiZ5GgBEUVfuBPhwsAy3RPy79k67AWKtLiizNOeevXgRtkGur/Wik?=
 =?us-ascii?Q?NrGYQ2iKs7HnBoM9YUlaVg5uPM1K7WaSv0C6OqW9M46V25uRRFuBgNyIcZLK?=
 =?us-ascii?Q?cfcuLdxeaqk75esqnXmdjGz05ShioIRYSkxL26VzBQVHfGgtQYGECH03Jc3X?=
 =?us-ascii?Q?DNNleNCGxrJTjREiRLwh3lIZNxUcVxBhQLZivXtiZkWkmBIYvPUZMuDMhSMl?=
 =?us-ascii?Q?j9SRlIh286qo47jVuAHLr/olkgaxVIcAhznyRBz5vNsBALqY+XWqr76ysuXe?=
 =?us-ascii?Q?RtHU5XgC+xI/SM3EUgDbP3bOp2zuetwRWoTevE6PPdtCSiGLh9RLaHt6qpNO?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfde7edb-9372-4855-8ab7-08db76a5a071
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 00:29:53.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m1kz7Qx8xun9KeqdDVzXFyXQKSzY50Sq4KYyCkHtkd8aGkCIUTqMKssdM8bkp/F8d1Dlfuk+CvlLjAGx7hBqTTas5vMmo85F3ythOG4lCNkm7anQDlC3O/YSWrDREcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts are blocked in SDEI context, per the SDEI spec: "The client
interrupts cannot preempt the event handler." If we crashed in the SDEI
handler-running context (as with ACPI's AGDI) then we need to clean up the
SDEI state before proceeding to the crash kernel so that the crash kernel
can have working interrupts.

Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
the handler, discarding the interrupted context.

Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: stable@vger.kernel.org
---
 Changes since v5:
 - move sdei_handler_abort() to drivers/firmware/arm_sdei.c so that header
   changes don't break x86.
 v5 Link: https://lore.kernel.org/linux-arm-kernel/20230626074748.2785-1-scott@os.amperecomputing.com/

 Changes since v4:
 - unconditionally include asm/sdei.h from linux/arm_sdei.h
 v4 Link: https://lore.kernel.org/linux-arm-kernel/20230625234033.672594-1-scott@os.amperecomputing.com/

 Changes since v3:
 - Fixed messed up #ifdef logic in entry.S
 - Moved sdei_handler_abort() logic from smp.c to sdei.c
 v3 Link: https://lore.kernel.org/linux-arm-kernel/20230607195546.2896-1-scott@os.amperecomputing.com/

 Changes since v2:
 - Dropped the patch fiddling with the sdei conduit.
 v2 Link: https://lore.kernel.org/linux-arm-kernel/20230329202519.6110-1-scott@os.amperecomputing.com/

 Changes since v1:
 - Store the active SDEI event being handled per-cpu, use the per-cpu active
   handler information to know when to abort.
 - Add prints before attempting to abort sdei handlers.
 v1 Link: https://lore.kernel.org/linux-arm-kernel/20230204000851.3871-1-scott@os.amperecomputing.com/

 arch/arm64/include/asm/sdei.h |  6 ++++++
 arch/arm64/kernel/entry.S     | 27 +++++++++++++++++++++++++--
 arch/arm64/kernel/sdei.c      |  3 +++
 arch/arm64/kernel/smp.c       |  8 ++++----
 drivers/firmware/arm_sdei.c   | 19 +++++++++++++++++++
 include/linux/arm_sdei.h      |  2 ++
 6 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 4292d9bafb9d..484cb6972e99 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -17,6 +17,9 @@
 
 #include <asm/virt.h>
 
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 extern unsigned long sdei_exit_mode;
 
 /* Software Delegated Exception entry point from firmware*/
@@ -29,6 +32,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+/* Abort a running handler. Context is discarded. */
+void __sdei_handler_abort(void);
+
 /*
  * The above entry point does the minimum to call C code. This function does
  * anything else, before calling the driver.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ab2a6e33c052..1b4a65a33186 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1003,9 +1003,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	mov	x19, x1
 
-#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	/* Store the registered-event for crash_smp_send_stop() */
 	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
-#endif
+	cbnz	w4, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	x19, [x5]
 
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -1072,6 +1076,14 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	ldr_l	x2, sdei_exit_mode
 
+	/* Clear the registered-event seen by crash_smp_send_stop() */
+	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
+	cbnz	w3, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	xzr, [x5]
+
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
 	sdei_handler_exit exit_mode=x2
 alternative_else_nop_endif
@@ -1082,4 +1094,15 @@ alternative_else_nop_endif
 #endif
 SYM_CODE_END(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
+
+SYM_CODE_START(__sdei_handler_abort)
+	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
+	adr	x1, 1f
+	ldr_l	x2, sdei_exit_mode
+	sdei_handler_exit exit_mode=x2
+	// exit the handler and jump to the next instruction.
+	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
+1:	ret
+SYM_CODE_END(__sdei_handler_abort)
+NOKPROBE(__sdei_handler_abort)
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 830be01af32d..255d12f881c2 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -47,6 +47,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d00d4cbb31b1..c6b882e589e6 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1048,10 +1048,8 @@ void crash_smp_send_stop(void)
 	 * If this cpu is the only one alive at this point in time, online or
 	 * not, there are no stop messages to be sent around, so just back out.
 	 */
-	if (num_other_online_cpus() == 0) {
-		sdei_mask_local_cpu();
-		return;
-	}
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
 	cpumask_copy(&mask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &mask);
@@ -1070,7 +1068,9 @@ void crash_smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			cpumask_pr_args(&mask));
 
+skip_ipi:
 	sdei_mask_local_cpu();
+	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f9040bd61081..285fe7ad490d 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1095,3 +1095,22 @@ int sdei_event_handler(struct pt_regs *regs,
 	return err;
 }
 NOKPROBE_SYMBOL(sdei_event_handler);
+
+void sdei_handler_abort(void)
+{
+	/*
+	 * If the crash happened in an SDEI event handler then we need to
+	 * finish the handler with the firmware so that we can have working
+	 * interrupts in the crash kernel.
+	 */
+	if (__this_cpu_read(sdei_active_critical_event)) {
+	        pr_warn("still in SDEI critical event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+	        pr_warn("still in SDEI normal event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_normal_event, NULL);
+	}
+}
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 14dc461b0e82..255701e1251b 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -47,10 +47,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
 void __init sdei_init(void);
+void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
 static inline void sdei_init(void) { }
+static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
-- 
2.41.0

