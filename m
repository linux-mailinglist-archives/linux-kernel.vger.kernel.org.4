Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEAE726A36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjFGT4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:56:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2130.outbound.protection.outlook.com [40.107.95.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC52125
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxaE1o+R50lwHjOGOOwH+AnRXWNyrQR6g6t7MqfVQHFt07zgsQVmElfRH8EIUb3ntICXkFffU4eRszcmB6AuvPKOePDrKv/tFn2Q805RfRh2eKsYdUKQoUwm+TwWIG4nRyRgrnfr7GssrHKxirxbkN+bL8yuTXxEgLS0/2955HGlfSXfL7W+gP62OsBtVLhY8Q5xDum0NfySp+Ew5s8a6lesSpxBP2yYi+L3jFjAQJwycQqSfAZ1vnyR+Zctu1m+tfWwIegqFZk/NXlNMGHybZf61s9nNSBFKnD9fzEl8X7x1cSPSrU1yoVNyUMj/uvhl4qGhsTbbP9qvRzpCka2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu4kQOnP0FzQANrlsb/BAbcZIM1icSlJY+ki7H2dYcg=;
 b=PtPX3XR5jxmRIgCbuWdzW4/+KI7ouvOeNP/IuwNa5sLzCAWaBW1LYE/LwTjWjzFwn/yr+w6rskgL6FEHvTtZ40v8GAqe2OsCtIR7trULRgYRNKdfvHv0Q6GundTXxrm/ZZ7KfZsv/Sf3sDitczcLsR3e01sjo5wgg49896ipf1X1yMDWoq+ucyC2WTfkyWNr5trHYh4XoGb/OINCKaxhKG4+S/wva7DfYcntdCXlmmJR9Fm1pxQFUYbqTG0qFOT+mnBrM5Fjv/JJu0aOUCsKIpJvkzXYe514btlChW3icYkpaPSJLDuG0z/uWe9Pzqwr4Ytek6ITw2M4uYBQgr4YKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu4kQOnP0FzQANrlsb/BAbcZIM1icSlJY+ki7H2dYcg=;
 b=FCNtNYOaGRhGeyqqzMR3MLlvvV6prbL8qIgpM9j/qmOaXjaAL8iFV/exN2yE9jOfIHYrAmaLoT8JpMiGaBFDT3HZfp8yaGGMhAYIJV2EBTmZUMchq84ipQYJ+LvJ8sbfkfN2313Z/jD3GF3bXaEulvTXaYKJZb0Uj0Uv2hoH/yA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 PH0PR01MB6328.prod.exchangelabs.com (2603:10b6:510:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 19:56:05 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:56:05 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: sdei: abort running SDEI handlers during crash
Date:   Wed,  7 Jun 2023 12:55:46 -0700
Message-Id: <20230607195546.2896-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:610:20::23) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|PH0PR01MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7e3ee4-4981-4dd1-aa6d-08db6791392a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCa14I4MDwcz2czQ7CY7O92AdxZ2EdpvNakhs0bFgj+pdVgaYDEYKBP3XBWqy06FNzi7lT834jGnXVHalHWA5HAXqJHD0RS85Qe8rR1TTT9w1V/LFbQMR+g0bHDUHwsW8ofHnvEVemM+cZC8EkSo4JI4cGqC5GOtBigN1mmE9Jf23FiuMsSZv4CClA4bqzBuo8t09/JN0ePmOOasqmtv9RZIaJfxbWgoAXU4Si+Lpe3hXtFBGk7/SOxzfClpoo/A7Xfz4hpTiIouw3pO3Sy2GKd7ZSaKfTFI20IjkfeFxFs0vZGevyxqY6+6ijwUbFzUq6sPkOADq5FyklaWeXiCrNkFnC3D17dudo4vdrd3oWLMwEF31Or88WsdU7UDjzAjartW90fi8vquGSJ5cxWpWjAdIEu6c+bBgvLF9AcK34SYpNzihykb97ZA8Wpq8ej/ml9ihgPDMREN+UIxKCWs1p0bT+cGjjDNtbsbSlVWW3M6FnnzD+guMMi+0nlMmXrtz/QH43MC/fkuOwZd67wlSbJrZQDg8QbHD/+NVn8RX8Ov01k/o2Z/NDolD2kLTyRp2foeXqghfmHX8Ljd6xVaMIKsfoEpTjOYuecmORWqN6KTe19pcyWFaO5qj1wS25MQFCgLr4Ex+vwE1ASF5R82FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(366004)(396003)(136003)(451199021)(8676002)(4326008)(66556008)(6916009)(66476007)(8936002)(66946007)(5660300002)(316002)(54906003)(41300700001)(2906002)(478600001)(38100700002)(6512007)(1076003)(86362001)(186003)(6506007)(26005)(38350700002)(6486002)(52116002)(966005)(83380400001)(2616005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pm3oRWIkOQK36LcI/xqShpDkioHGlBk72tDo5mrGbdpPxTJPbLCzMIg8C84e?=
 =?us-ascii?Q?KQcHUflqKeUkNOkdOb0ifCOZwK/7FFlB5jz3Y8umdHKH254CBTvVmaxZZ8zl?=
 =?us-ascii?Q?TLleC07d3X7BqvRhrYZaVWbHLGue7SDSts44FFq2He7Ez7Gr0el3hy23xVYP?=
 =?us-ascii?Q?4+teY3gIsdUsGcwuiguvxU44r+BM/UB0BA0WGZgi/18GFynB/srQjz/ZDw3K?=
 =?us-ascii?Q?PbDdDOHJaAWfIrHkjWzDD8m/Hn8ktMyHSPnm1w7dhDgh0h5YfwWtPT0C4Fu1?=
 =?us-ascii?Q?RVIkk3PAeSIjEhLXuB4g909jpBXqgsK/OSLJ6YoY1Ag0B54UQJDvJBrvgzbU?=
 =?us-ascii?Q?dJ/SeAccQi79GTb28Zpsn9iJHZnIJpN+t103Z6kNzyP3romBsp1rxOJE91QH?=
 =?us-ascii?Q?ATpfxXjkVTCO7qXcLMIH9Mq9lCr6GTl56SGbY8rMXcKu9H8OCeyuj3K0A9m0?=
 =?us-ascii?Q?IHHSb4KcQql+xBJf6LQfH6YQQX6lGbthyLqW9bkyMY3nz599BWBBBRi5YD/C?=
 =?us-ascii?Q?unJkLzPdTipBJZfFazo4rv2b9yYKCDBJAaBOjIZ6cbw3Z2r/MQAttLPR86n2?=
 =?us-ascii?Q?kW6dzPY5rWiU2jnLF93HjOD+LFRE0/33ygV4o85TnAGVlMfJNfXRUoR7fUP2?=
 =?us-ascii?Q?jWEMEDmj+e407UyupXVRkJZ1splbTZ+Ifc2tFmbgP5DlFHrENKmXo6xvMRa4?=
 =?us-ascii?Q?wzJtqx7Hs8prk3YSXpSoSd5X13s0F7gOryloQnp+IV/28N/9sBrPTZTlUmkk?=
 =?us-ascii?Q?IfwJASLRZdtAYlm64vAMGVytiWJtQYPCFczQl7hxQxrDIMsdS1CYGcQQdkaH?=
 =?us-ascii?Q?qcTMtP7jA5cvkLfPIFeNZClQo9sX1tn4Yd2DplxEKJL/oZ4/LHg2G8hti7Rn?=
 =?us-ascii?Q?3rsfUbyRzHiEg8WTzBCBw7ZhGg+h4Qc9US+QhqwgNw39ftbNvvypDtTKvhf3?=
 =?us-ascii?Q?++bTAxfzq+KtMeOg018yE9iBbT69IIO4+eF59+b+3FlISFs6wFF3cN7Uhslh?=
 =?us-ascii?Q?U0YdDN9+rxGbZ2/uweS4Qzj64xDtVO/MDS4usqCzhDgm6nRHr2OTOHkoitiR?=
 =?us-ascii?Q?ZtqNgqlWmGx/LnKQ4l33MpbslRSX2Jc9lWQlcTwn9SFHeyBZpuIZhU7LTRXF?=
 =?us-ascii?Q?JYLpUmecwFIQGUJFnhJMWScyo0b2XA1GjyHGBLoB7XQtE5wiLtW7gpVJwseT?=
 =?us-ascii?Q?S6ah9L1dtEPApk+lFrBhYDJJFL1W+iZT82q37vhFa/C7ZEhQLCmNkcT864hx?=
 =?us-ascii?Q?KGsURbXtaZqyjYmPbx7rbCNA+3pv7de0N48Ntr1O3NSC72GSR8YeQRuSvbG2?=
 =?us-ascii?Q?y/R29sCZQP37DS3aGKWvUzs2VeAFloxyfJDAQML5bAtv/TfRDh+NZMaVbdSh?=
 =?us-ascii?Q?vBlz8VJDpG+Qh1CQiv6FPzJR4mbwIVCrxMPYStvEFuH+P2PLjNuAPHUIXyIm?=
 =?us-ascii?Q?hHHOU8KfLHxVhO0+Zc8XDHzS5XhNmOSOn7oMI3tR+OvR8LZWVwK/l5ys/xPA?=
 =?us-ascii?Q?ySBWtUBpgluwyxuXvN8flcwl/CBmF69FEdTY8WuVdUYSHAPDRtI10BwWa/qp?=
 =?us-ascii?Q?jM9Z+uxzUBaMUxOcc7hq6Ou08ZKmPGrVBwjL/KoLKVPdHthINuDog9pSHe0i?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7e3ee4-4981-4dd1-aa6d-08db6791392a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:56:04.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzOmXP6psmNyCGkZbmQPKDpWmacnTa05LeCyuJcAY0VK7hM4PQ74FGfL36d/vlLCdDbjo5fZsGEETu0e37c2kyPxYepyeB/Ej31baTYS5sbto2XsfZTkktSfyg7KkcV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6328
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
---
 Changes since v2:
 - Dropped the patch fiddling with the sdei conduit.
 v2 Link: https://lore.kernel.org/linux-arm-kernel/20230329202519.6110-1-scott@os.amperecomputing.com/

 Changes since v1:
 - Store the active SDEI event being handled per-cpu, use the per-cpu active
   handler information to know when to abort.
 - Add prints before attempting to abort sdei handlers.
 v1 Link: https://lore.kernel.org/linux-arm-kernel/20230204000851.3871-1-scott@os.amperecomputing.com/

 arch/arm64/include/asm/sdei.h |  8 ++++++++
 arch/arm64/kernel/entry.S     | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/sdei.c      |  3 +++
 arch/arm64/kernel/smp.c       | 27 +++++++++++++++++++++++----
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 4292d9bafb9d..dc2f038a61ef 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -17,6 +17,11 @@
 
 #include <asm/virt.h>
 
+#ifdef CONFIG_ARM_SDE_INTERFACE
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+#endif
+
 extern unsigned long sdei_exit_mode;
 
 /* Software Delegated Exception entry point from firmware*/
@@ -29,6 +34,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+/* Abort a running handler. Context is discarded. */
+void sdei_handler_abort(void);
+
 /*
  * The above entry point does the minimum to call C code. This function does
  * anything else, before calling the driver.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ab2a6e33c052..e49f72b5fb63 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1007,6 +1007,12 @@ SYM_CODE_START(__sdei_asm_handler)
 	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
 #endif
 
+	cbnz	w4, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	x19, [x5]
+
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * entry.S may have been using sp as a scratch register, find whether
@@ -1072,6 +1078,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	ldr_l	x2, sdei_exit_mode
 
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
@@ -1082,4 +1095,16 @@ alternative_else_nop_endif
 #endif
 SYM_CODE_END(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
+
+SYM_CODE_START(sdei_handler_abort)
+	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
+	adr	x1, 1f
+	ldr_l	x2, sdei_exit_mode
+	sdei_handler_exit exit_mode=x2
+	// exit the handler and jump to the next instruction.
+	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
+1:	ret
+SYM_CODE_END(sdei_handler_abort)
+NOKPROBE(sdei_handler_abort)
+
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
index 4e8327264255..ea1595b51590 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1047,10 +1047,8 @@ void crash_smp_send_stop(void)
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
@@ -1069,7 +1067,28 @@ void crash_smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			cpumask_pr_args(&mask));
 
+skip_ipi:
 	sdei_mask_local_cpu();
+
+#ifdef CONFIG_ARM_SDE_INTERFACE
+	/*
+	 * If the crash happened in an SDEI event handler then we need to
+	 * finish the handler with the firmware so that we can have working
+	 * interrupts in the crash kernel.
+	 */
+	if (__this_cpu_read(sdei_active_critical_event)) {
+		pr_warn("SMP: stopped CPUs from SDEI critical event handler "
+			"context, attempting to finish handler.\n");
+		sdei_handler_abort();
+		__this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+		pr_warn("SMP: stopped CPUs from SDEI normal event handler "
+			"context, attempting to finish handler.\n");
+		sdei_handler_abort();
+		__this_cpu_write(sdei_active_normal_event, NULL);
+	}
+#endif
 }
 
 bool smp_crash_stop_failed(void)
-- 
2.40.1

