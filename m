Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2089073D54F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFYXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFYXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:40:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2107.outbound.protection.outlook.com [40.107.93.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBF1B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 16:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIJWvll/DomLS7r9JEfT3keO4lha+VHC0G21L2wBuQ/ek+8Q6yk6NbKh0+WWbctCFa9A0hFtKgbV3QGRC0eisfHlVMlrZhKeCd5o8HR+fOaZUKSIA0pRhBatyrT3PgvLuu03qnGI/H2ZAqFbLEEewwYVV3ZjHcSfXwno0+iuSh3lYbPPZBIjDSAclYGrjQPi8aqCyXbFLwl/I2qGb8D4IVxwWtsbNRPYpJP0uZ+Z4RB92LPGDSZ/6gsuY8c+UKn0UZYInf00zPMGk7opzfNo6f0YKs3SiBzlth+TMh2CJO4t3s6LprlaRDVblxM1M1dEBqf+71edgyFf0Gnq5cjynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MinWA4lEzpDdipSaXfDcy0ZuglmxxMzXr7PoGOILy0=;
 b=UwjMXXCigMHujRAzud03MjDfyyVcj884G1yAdRXhPP3zzeEJInWm58USe8y7Bk74iR9R3/BJMaQn7tAWjfFSEORIdB3oxkFgMH8Xg0L3NRjoVgE0TOj62975S8/GGxvhjNbPaAKIynQKmCs3Ag6V+HES9OeoOMtcQgWo1NQaFGQC8K5QsicI2mFSG1kLCGrmBCepocabC7CzknD78ZVZ4wztReQBDy5sEk8ixCdLZ2FNQ1jZHYE+bpQXeRhJK7YDRwultqprhcmb9iD+MFXLPH1o9R4mYW0HHjlSqNPuIRuBRgpyZ+I4ymwMwBOgzfVLDen7WFfL77qHPofg03nBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MinWA4lEzpDdipSaXfDcy0ZuglmxxMzXr7PoGOILy0=;
 b=hVQp7Nq3h5B8+2AY2IAIoV1RLpsSwSWuSoDrfo2LZ6uI29iUsrfpWWlkdZVcqWS+x4Nj9gyAtnl5wN4+PsC4T+tRVkYMv++MQVJ6ZpooWuBf2HzEunReBY87wT87Zx7d9Hyhh36WMT2ptgS+hf2jsvHL7TwpePWY51bWE7cPsWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL3PR01MB7194.prod.exchangelabs.com (2603:10b6:208:345::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Sun, 25 Jun 2023 23:40:49 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::c3b4:c7ab:46e:476%2]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 23:40:49 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: [PATCH v4] arm64: sdei: abort running SDEI handlers during crash
Date:   Sun, 25 Jun 2023 16:40:33 -0700
Message-ID: <20230625234033.672594-1-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:610:75::8) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL3PR01MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: a62308da-baab-4e8e-4110-08db75d59aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zi6u75lra+JSFKLX8Bs471sfuo3aQe5WIjch2puWT7yzszK9yAbyON7uOMuENYvrwOwY+4Eh8nOdDmTm5ShwazzjKYrPMPQeCNzQkpDIXBThHnV5jd7GYD/G4XkIK+x0gNdWnDm0/t4phJfZPBFTTtfn2UNyMl0TnhcFy2rn1RGkrwem2dUl7wcLc/mgpxEzrJrgsH40TjDLORyNImo7ymZLFZmVY4EYW59oOaDCD8iewQRI7UlqOVNcmTMYxy9mGFn8IODTNbrRknAXSgasLQ7xKhak4yKuK1E16K5X3bsE5VNr4uMIRVToiE9ljWFZmrBC+44TcfY8P0OFz1YMNzp/zWUq//CGL4sujNdHNFdk2x6kuu7b816V3dAOGOo3yvrbFmUc8zbjIew+HEFW7puC1qZY//HtD5PINRQDORFBIFtOflTsRWrAxKCMPmJ6LeuN8SH2oJhYwJjGd9wObza8FW0+61yZ5TSlulnTmfjA+iNoj2EVdCsCT2rGbrm9D3snoVXOvzJFCRifJGdVdmuHoO/Dyi2T2jcgGgM3GJKvOvyhhv8BSbj5KXhfRxnlYrCI+OzloFHbCQivDuKWb0nxX1Nz5l8nQmz9QCGyXOCH0g4Hryy47/RQ+rq3N7BGwvxf6AhSsWOU61X4Ax1qFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(451199021)(5660300002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(107886003)(6486002)(966005)(6512007)(1076003)(26005)(6506007)(2906002)(186003)(52116002)(478600001)(54906003)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3WleRgpmR34Kr9dGaShiiYb0cc3tapzflsoAV26V81emrIo5198r/gdLviu0?=
 =?us-ascii?Q?+Su3YD5KP84ut87P4e5SCEQYV82kH8h46if0oHUqFwY5trigE9tD2TPQQqvi?=
 =?us-ascii?Q?6RpCZDhY9cU/2zNepcvRTW/xy7TwBN3MvE4vYDRUMs0nAXLYUqE1wyNNR9oh?=
 =?us-ascii?Q?3iqgC4aBkRNo5VLBpjmVZw8tU4dgncLgG58UExUYgLoifrAhkOO+wXRIlY+t?=
 =?us-ascii?Q?oeSH6OupT3ZIedyq07M1DQIL+DxKSwot6htnPEtHyk67uylvziPByHOOYaNE?=
 =?us-ascii?Q?aVvQ9DjYMij6PaO4H5GtSNsGFpCeoCO5ZgdCWNyosGdWdTOOu939auI2e73i?=
 =?us-ascii?Q?e738JSmOu2tIMmyGjLQlV5aBwpYTJ4yFcWPorfyKtw9SWAcppNpwejzVZxAg?=
 =?us-ascii?Q?/ZiXrwrWNBt5ke4QCSXAStEqYrlgB9StyG/sRUIB0zWvCRXqKlO0KxULL1Pk?=
 =?us-ascii?Q?/4LknpklkCqwboaM5Q+Mw2L0IWrtvN76UBM9eV4cKVm8Jd17qdQGr8OYBUCk?=
 =?us-ascii?Q?i7zDrrYbaoDNB6r3TNAbaDtFqblf/ryWcQ5jgG7SHAZswgNOlNObDhYeA5nm?=
 =?us-ascii?Q?b2xtkdi+G5A+eeDKsr46pF+70s3f1MnbavY0ucdnjTefwNma1MRqafwLc2Vh?=
 =?us-ascii?Q?aPOQ+piffWJqPBu/Yq5jD6L7CA9QalK3L7FIbH9JU52USTFW3NbK2WoV5NFN?=
 =?us-ascii?Q?Bf6BQeMi+Tv/J7U2wDkPjagsqcuYIZwGcsTnROqqpF48/Ca10vAVblAbo+l2?=
 =?us-ascii?Q?ZxbVuDyPBjPHEsyn7e89V9c3Tg+sJ6SReouQEgxD/g94c3K3epfJ1uFDovhc?=
 =?us-ascii?Q?wVQs3U1zcWXMdGRo4A+zU2e7XpyvPeynDiiH1e1Ya6PFgYOKDYWw604e0UBm?=
 =?us-ascii?Q?gAfAKTEzg5cYccqYQ64KASH5ey6T8ZFc4NWZ0pFa43QvfwYTY2C9uw2rNBua?=
 =?us-ascii?Q?M/ypjqNW+wVGm+e8HU/Mo+K89aI1g8xgOIeOYmNkz4GFdgukCmbZ2/e/tflN?=
 =?us-ascii?Q?jj/DinXuVqrh7XHxrUfjPXGo/mZUg1N1V4PXj4/lTSbki7DfLvix2rHLZXdb?=
 =?us-ascii?Q?pRtbEak0OwXcozIdxZSUF3tXjzVHBk2bd/4efWqBWRle8lqJbe7rdjKRR6Bq?=
 =?us-ascii?Q?a4O1JyYaevsItaoLb7d+dMhPH+cQXMJ+HofZAeL8sgWj2WZ9hAdbljykirfZ?=
 =?us-ascii?Q?mEy2yzJRGKVeonFwTt0Kn4Cbt5CeOV3PFrEcryMeP4cZG/FTW0Ud5dbY0I73?=
 =?us-ascii?Q?AJVjEPR6FYa6PBPwUs0imDl2njHfoqIwLToWvWirzZ708ACMpHwTDa8UwdnP?=
 =?us-ascii?Q?jSdkEFR21+WYjqaNgF8FjfmFR/ToqFVzN5P++ZuIw2bovsygHgrvOudhCH3p?=
 =?us-ascii?Q?R6lnpDi9g+4lTs6F6XpoM77DQ/txfshWlMuOd0a0HLsC9DVNU4TclMYSJa7h?=
 =?us-ascii?Q?NkBmt1auBWx2fosn512BQb9y+0jWY9gpYwksUvjbs9FhmVv9C+fI6mkryv5R?=
 =?us-ascii?Q?mdVbzkoFPUqHqgfkYMksMFkTyTh9EC1+g+EQcSUnw4jIJ9BUyymghDkIeGmq?=
 =?us-ascii?Q?7WrhCPQ4bYmfZTghaZ2yUfVL9SCKiBnsAoloRbLjNRml/iQSnsP2uBZysPOs?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62308da-baab-4e8e-4110-08db75d59aaa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 23:40:48.8359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RH9JzZS41VqiaMY56m+x7LC3Gw0KfkUfnfMV4NPCxIo+cuYOUscyAX4hG9/MdqGdCYnZehDjD5wHaaP2XiR/WEtjUmjb2jxTMMcbldg+Sdmtnk93/gXIDpiejRQ+dRWe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7194
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
 4 files changed, 62 insertions(+), 6 deletions(-)

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
index 830be01af32d..fcd418af386e 100644
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
+		pr_warn("SDEI: still in SDEI critical event context, attempting to finish handler.\n");
+		__sdei_handler_abort();
+		__this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+		pr_warn("SDEI: still in SDEI normal event context, attempting to finish handler.\n");
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
-- 
2.41.0

