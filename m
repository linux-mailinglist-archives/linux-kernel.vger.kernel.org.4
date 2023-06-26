Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347773D8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjFZHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFZHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:50:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28310C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTV92AiRLtPQ1Ge423QCFofgE94yJC03esIZXg+awvf6mw80BdwumkQ6XFdhB6yB5IsR+KdYMFnqg+ahOAwzO+6EWaQvbpReXyaxiZjjcGHBH62vpj3MIKRaTTeQqT3+Qhxr5aESlEctMhAT1TiC0na4qPF/+oPFsiG41WG0eRhI8jBn68SAeqPG4tIApPNyYFHKv6/kuoZ73BZhI2iFVuG25cMUxQFBaJLVi6Lg9qmLshUpkGuTwxAYXSu38UbB86DJkFJd9PNrNGN0hQ2x6kMCa3QE/8Az+JHTnnlykT6t16wyPixTh1KbJAPxofvMxwvFC1e4/6aEZBAKnS2HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz+RWvXcbBb7bdBUnonUbfoHVYXcJo937rmQ02J74ug=;
 b=W2CSCF2sPdY/fVviA8Pmg2Pc4xCew7bg9LJLfoWkBRtf+a/BL60+oE+Q5nZ0863NwOWi14Gxry5luYfN3kpRA1tEYoJ2N454FouT9wPhCHDCgdJ4avMMT/+7siVfGZ+s1/V+U+TKPGltf9r/BhdcQP1OrT3qxhD+oCmqI/9FRpFSbkE4bQpyTXkNzNmh9/sYSItepSyu0CtOrwbLhL9Z8y4EbbXPhOo0W/Rozu+x1kNfVSDK7KyDpLNI/dbjl8pS9R84hHlmCl3cGklkmGRRy7szfwP9LKCRZU0kxbW+RZdVEkE476KDz8Lc8w+xH+N9YFLUtq6N0gmLDSt3Ain3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz+RWvXcbBb7bdBUnonUbfoHVYXcJo937rmQ02J74ug=;
 b=kEofo6+h5H/7UV5h1eBd5C6gBOJpi+3J1vXnM8LHisf1Mmbj2uaqTStGeb9puijMc/903GCYyCO7/BA6MqFrYnFblrhotSuqvK7BIw0XrhB3x2oFkwgGSCxXLAh4JXf//i+6XqbEtu9N0bWs9TZjeLMBt0WGuh9WzGmcf7m6DzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 SJ2PR01MB8322.prod.exchangelabs.com (2603:10b6:a03:536::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 26 Jun 2023 07:50:25 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 07:50:24 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: [PATCH v5] arm64: sdei: abort running SDEI handlers during crash
Date:   Mon, 26 Jun 2023 00:47:48 -0700
Message-ID: <20230626074748.2785-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:610:38::46) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|SJ2PR01MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7e3984-afe2-49ef-7800-08db7619ffed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVFnmeXY6gLYs56mI8lvb6pRP8tE/7GMzakD4najoTBSJaK0LlewiJ9wTc82s4ew6obKOJ6BIwpGfPQcREZ9qhhbQXs2L27DgsL/leabaFob1eArkcBYRR98d6Dt5a+/33kVYEq98LoOx71l5MdXJlGyFuHq9bICQcSqclbxXrU2xD4d1DtIYeJ4D5qTmZ89JFzO7KE7e7tmPcfwXThYfQZBxzLRgaYKRfSaHtekBvYw02mngZLLOQpQoAOEcbX45wOHuP2fOuFYAoTHIbUIQVPe3gb1T1cuKUQLnpoLr+UhcX48l+L26YJcAb7D0ymhE8WpLXMIISvzs2gdGnDKd2OyR22mdVzlnx6Kg452l6XBuwgiacboW3Mo+OJLsJCfiid/fs8pxrfEil8NBjtanQRvLWBR8P8moXU8D3Wp+EUjHQRBkeGQsNJS2usiUm93SGZBjbkpZSnBAD4wxQpFgsS+KCOT74OeH8hgb/IQzg9CYLVtLekNLJ8vISX2DZmgo4UA9H0lIYR8uLOjKIjaS+ZokJKWwvKKpGyUkogFCJkXUzzdyjR8mqnYR2Y1grd1+RYVCodKA4DtLTCLn3nTVGx2/ZOHSyyyPCf9upKvaXI8WhHcMSgF7+ztublFHuy/ZoCmrlMboAtawz9W9BRSTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(451199021)(186003)(6666004)(478600001)(26005)(1076003)(6512007)(6506007)(2616005)(83380400001)(107886003)(966005)(52116002)(6486002)(38350700002)(38100700002)(6916009)(66556008)(66476007)(66946007)(4326008)(41300700001)(86362001)(2906002)(316002)(8936002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14Y+iDLbtsbCutpvWY4RFRU1XIL++Tk7gib2VeAkF9ggG5brPrnwZrpeH7iJ?=
 =?us-ascii?Q?A3FZCJCF4h2i8oltnx49nv4yriUJfbcezrIfJ+7LSYdf4GsXJwoi4RzdG/0g?=
 =?us-ascii?Q?3FMKAn+Ko4/z4ueZep/hOVs1lDugFN4tPOuSoMUjcoSSP0skmtt2U0l/HHKV?=
 =?us-ascii?Q?nCjPTVudZTzxh8q24hy8oktGGiyG3V6JDLVxlEZsI3LVf6+nlGfWLOr7L2/C?=
 =?us-ascii?Q?Gy/IY1ga3VjMF6FDhfdmcxE7KsPcmlP5s0h/CPWb9tRvQydZtAAKLIChszze?=
 =?us-ascii?Q?di40s0gV6ft83Bhjte0AIN8h/qm1uTNjY8YetwN9Gs/Ld9HZIFN6ysrOUkNN?=
 =?us-ascii?Q?hunHnFB8YxVUn1g9gpow9kyII8Vw6Ot4b7FbQVN5z4AvGZlAJ2n8vBrFAVhy?=
 =?us-ascii?Q?uJely3fE4GQcapJHNOC4ONguhBtW/9i6Rgf/ZJwgiAZk/rdr+dGgO8QPiour?=
 =?us-ascii?Q?8Imt/78xtyDN7ViiT6VbtVlm+GYWi6JC8rKowgdV8RODXwyceQzuTnR+mDcx?=
 =?us-ascii?Q?srXel/b1sFzp7emnC2iiQ0FwhysKfglgJWPMp5mdePFFpw6BlLCIQ3C4Ta0y?=
 =?us-ascii?Q?CV9A3F7L13HkDFEXJal/rH5BCBOQL8jlguHPkLI28Ug+5oaBkQsDRbz/RInb?=
 =?us-ascii?Q?m9YsyQ0/7mYdK1eqcDoGWev1GUjdeR6OidQHGlwssxwZCno3Pb4p/4AKdJn5?=
 =?us-ascii?Q?+dIYgSf7anRK/UimnOiSB1bM/C4mtL50WQ+aHkFZAHkfjPTZRV5x6EMcuVmR?=
 =?us-ascii?Q?ZWFCkAXcMsTe1hbU2FnhVWF1Sg+rbc4hN406cL+jJrqgD1WjSn3Bcw9Wk7cz?=
 =?us-ascii?Q?67RyNWYNjrCY8nojxmVWkwKwEW3W5fk4n2QVwq9RbFXva1pXiFnusykGlO9V?=
 =?us-ascii?Q?BlDwBVIyWPAAQUTfqOl9T9DSgznzocpb5uGhw6Nbx5nNPiLefsbbrZijQe3k?=
 =?us-ascii?Q?YY5DayfOCnyRPyoJ4aYXNCMkZv4shhcw3aq+x6A4fdUjuLaRvgZbJBa4r6WH?=
 =?us-ascii?Q?2I3+WfHVgNs0g64DPreGgx26Voz771PdTvpLQNGXssJOLKn5IXgWG99dHUCr?=
 =?us-ascii?Q?FwFWTIE07eWfjNjv2D7Ori0SOUuevB4/OGT6D5nEurCtq4kuQNP3BiTFrFUS?=
 =?us-ascii?Q?e/MZ3bJN9fHjIyqWMbfHj5bvUXXqW6lys0tGIypP5lvJou8hO1G2KSBCO8Gs?=
 =?us-ascii?Q?gHnhoQvlrgyZZzsiayQ1vmerqyaQr/j3/8mz0h3xDXincBIKg0dhiObacM2L?=
 =?us-ascii?Q?upD4h/Hz0z61/yW8EQDQFtZEB0utgz8ZUJOVK+DNePjQw8x96rtHAXubmHOr?=
 =?us-ascii?Q?dz7cC0JJ+Cwv5rIq9zoB2pz5fyJjjXZKtlHWpO1yJwsphUlfNy18FWDxqX2H?=
 =?us-ascii?Q?6EvIr5KXNBodew22ebojCZMt1WdIEQsNvM4M8/2DudIZBECDseVNJ5oVWq2x?=
 =?us-ascii?Q?Y6QiQtZNASWIDtkdEncm/Tdih/cXbFcBJc6qAK/xDYiX/p5cfd6jJ+lFElFP?=
 =?us-ascii?Q?4AA7hFnACKo+hZRZ37ih/OEjDhUhjGR048Ma5etgl536K1VuXSfAG6ge5jQs?=
 =?us-ascii?Q?LgQJYryrwH0cIwKx+q4GokFJKA7Cus2rDABd4oA7Js9UbOy7ZhI7uWopD+7a?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7e3984-afe2-49ef-7800-08db7619ffed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:50:24.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QQ7Dx6FYu0h1BVFcghKvxPPnTNQJKjuunZB9n/nmcPewRBpAT8g9KopLE0Azql+CZUYtG9gzMOyazEM83rbuGX91GNbU9WLS1gcPLTijuRXkMLKuvrCd9SvhpxI/iOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8322
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: James Morse <james.morse@arm.com>
Cc: stable@vger.kernel.org
---
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

 arch/arm64/include/asm/sdei.h | 11 +++++++++++
 arch/arm64/kernel/entry.S     | 27 +++++++++++++++++++++++++--
 arch/arm64/kernel/sdei.c      | 22 ++++++++++++++++++++++
 arch/arm64/kernel/smp.c       |  8 ++++----
 include/linux/arm_sdei.h      |  2 --
 5 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 4292d9bafb9d..98786108c493 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -17,6 +17,9 @@
 
 #include <asm/virt.h>
 
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 extern unsigned long sdei_exit_mode;
 
 /* Software Delegated Exception entry point from firmware*/
@@ -29,6 +32,14 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+#ifdef CONFIG_ARM_SDE_INTERFACE
+/* Abort a running handler. Context is discarded. */
+void sdei_handler_abort(void);
+void __sdei_handler_abort(void);
+#else
+static inline void sdei_handler_abort(void) { }
+#endif
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
index 830be01af32d..fae7269090f8 100644
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
@@ -262,3 +265,22 @@ unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
 
 	return vbar + 0x480;
 }
+
+void sdei_handler_abort(void)
+{
+	/*
+	 * If the crash happened in an SDEI event handler then we need to
+	 * finish the handler with the firmware so that we can have working
+	 * interrupts in the crash kernel.
+	 */
+	if (__this_cpu_read(sdei_active_critical_event)) {
+		pr_warn("still in SDEI critical event context, attempting to finish handler.\n");
+		__sdei_handler_abort();
+		__this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+		pr_warn("still in SDEI normal event context, attempting to finish handler.\n");
+		__sdei_handler_abort();
+		__this_cpu_write(sdei_active_normal_event, NULL);
+	}
+}
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
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 14dc461b0e82..d534a8bb9359 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -7,9 +7,7 @@
 
 #include <acpi/ghes.h>
 
-#ifdef CONFIG_ARM_SDE_INTERFACE
 #include <asm/sdei.h>
-#endif
 
 /* Arch code should override this to set the entry point from firmware... */
 #ifndef sdei_arch_get_entry_point
-- 
2.41.0

