Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA86E6D10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDRTsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDRTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:48:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48355B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJHEbIrS+c4cnXxyYjkbB62KW8IbBxkbGJgHvQX8jgURE3u1Fb8U0q8kUQf7ZBZW8HaWpb60fMHPvwJ8R/dbBnrBH4Jo0RgqOhOAtanhSpLVFFRmbzwo5NYOuJ5ZjDeXe3LAu6ly1GND10GWWv1FaqpmvjPwWTezewBwl9Ob8mOkajo96Z7hUVN98seJec2b3mWiO8oOQbfyxTNa52RYqcuLKgA83L8DGVwtOgdjlDFmTQrowhwmhjgu+EgPcIAwEjgb5tKThgqcdvso0zMG7VMyQhsjlehKx9vz5SvOxgorZsfKhQrUMTpyl7l00/glXCseTK27bmch/jNQHBfYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBqPvPs4q2Jt1uOdvG3vZxgyMi7/bDMueON4hFS2uo0=;
 b=El9jfer1eYjKLLh3RkKBaJufCaC3GQNFOyWaDmhG+gkcx2hkKj7eW4Rish2D3QjkFau/qVH6ONZoTOBCWuGPzzMDRfKk5/mu4zlRhCM7CVpvi8aQplD4U3BIG6kgXNOaxU5DhiHd3Y1YrQ0Da//4lIySQRB3Xgy7qEVLYxgIoyDe1lAhWWRzSgvu6EFPqw0DixUz1b7GbE+j/5ciTMTwp/sSqVfJQk25ntN6wEkspdScop9qR49NhSrJwkC4bck7y6NSTsh5KSGW1HfEFteV6pBf2lUhYx1kYo6Jrz5u6exZYqqlydEeLZ2cuqLlx3bZtne8MAy4hoVd89+wHiEUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBqPvPs4q2Jt1uOdvG3vZxgyMi7/bDMueON4hFS2uo0=;
 b=c//FSstinSV/R3qiB7pF//ZoNLuM3DBd++rCV96O7DWIUEQsN7fg1A5CBldsYrdUHCLsjHCTqVxm6OiF6/H/WX/LjdrU+Xg/KxcxlTrrWIr1fHYpHF3bHT09b+0wYof6KahvSgCCaQdvT0vpHswB7viErXEDsk2CDPzH4sjfBi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BL3PR01MB7196.prod.exchangelabs.com (2603:10b6:208:347::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Tue, 18 Apr 2023 19:48:03 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::1cda:7642:ae1d:599c]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::1cda:7642:ae1d:599c%3]) with mapi id 15.20.6319.019; Tue, 18 Apr 2023
 19:48:03 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 2/2] arm64: sdei: abort running SDEI handlers during crash
Date:   Tue, 18 Apr 2023 12:47:46 -0700
Message-Id: <20230418194746.620266-2-scott@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418194746.620266-1-scott@os.amperecomputing.com>
References: <20230418194746.620266-1-scott@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BL3PR01MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5fb34-4ff5-4ad4-a49a-08db4045d253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVIxC4eRsLv6Z//JFLkDhdCeHaGdjuP3Tn7THAzqPlrRg5RDCMFk3YhFWWPRRfhjn80ZwCH83Z/K3cuKK1zGaZOydR6Eyt4ajKYNZXHNopd45prqhjrbH8osYy/PTiUpqFg14gm1wE9y0RuF4LGi8E7Lyku9uNFFcZ4fJgoNw53mh4gvjkaRsR8/GX9R2QHMXB/gRygsJnEisUn21yuRDC3JndIwz6SGOemjLkNxlei3+Pj5c/sv/n07oD8+vOl1sO5RggAyorjmJoNta5cnMFhA7LmwIjPRABt/ewQfVkkhzf5+TB15jncSdSDevxsBAHUhO9Lvr9FmwRACD8aIeWdV3mfK6SDyFBN49nG5DPNk1rIKdFxRu59Uu7epB7zS9avZbC6NnmuWbWKoeI4EviTjrykoqpn8umW/q5V4Q8UusARf5B/z7J0XUEXBUXq5dpm8bQVvOa8uN8YfTBNdr5Efnl5AUgGG/ygcwHu0l4sB/YYMxHPhXkHaaQunDmCuiHcDpBevHKX+VOLpW1Hj4mwXCOS8APLCPKsCyP/D/Xp+CMnUjfPGzTcauarc64tCgkb/d3/zzx/RAyrLh1exefhKsLpY6qeF8/HCutg3w81EkJadSpN6QUEwzHvrM3SF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(451199021)(5660300002)(2616005)(26005)(86362001)(83380400001)(6512007)(186003)(1076003)(6506007)(38350700002)(38100700002)(8676002)(8936002)(54906003)(6666004)(6486002)(52116002)(478600001)(41300700001)(316002)(66556008)(66946007)(6916009)(66476007)(4326008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FMeKC+PgUtkf8yCihkEhxFbDwl5nZzAWN4LHBksdN2INRuMw3V1KxLNIGXkY?=
 =?us-ascii?Q?6wODv8DVqpq1w9N2TCoF0nSWOVWz48LJDHcvT2darf55VZ7GCGmIHUHT9eoj?=
 =?us-ascii?Q?r1SOLPM2AB8NNjz1/TM6L4gm5XBS0dr/kVS8qFNn3LvmuaEQb0bzJjnXUJv0?=
 =?us-ascii?Q?ATKJEiWDy+YuTP3zg3WlJxq31Jtay2nmBwzQ5P3NdLLeht/CI5icIdCSN2gD?=
 =?us-ascii?Q?cAPk9ygwyER3IUn+oXeICeJlckNLS2VN7nEpQcjo2uGWcRcvz2wb0xyjVptH?=
 =?us-ascii?Q?kM0P3v8tSMNQzBiqg6ZNz1MhxsPX/vcmn5uNoAae3rx9zP0qGPg6rfW/rAk4?=
 =?us-ascii?Q?dvMMZP+MwRWstcR46WPau2FV0lGrbevbIjkY6T9fLDptmqBSgkvv9RD4/14y?=
 =?us-ascii?Q?H0O5Y3tdZk+L3yj9PKRbKgSY9OqzfX6+3wrRukNx0L892AvXIgAaiKAR3PHZ?=
 =?us-ascii?Q?zIHbmkN27AtAoKHpVb9Us0owzru80l4Y5jxyoqtddK+OjXk4DU2rKacbEK2I?=
 =?us-ascii?Q?8Wg6TtLKcU4zSF8f3QvanHet+GdxuFuFB58QMYTp441IHiZ6zZe15uzIOtXD?=
 =?us-ascii?Q?/LAs3Jy2y+ScJe8OsocGmyHVkchBt3rfdfpReeh7acjLmP20947FtJe+paDM?=
 =?us-ascii?Q?9U8sZ+2a1Jh3Obgz1k6B4EtkM5mlRSRyiYrcz3gZZr7VWaz99Z/BpN9B2Rv6?=
 =?us-ascii?Q?2N+DdkKlOE5W7yDOmhvFSP5SNmiq2DDaM+78K5EOkbDYuY8yvQhVH+TBPzyh?=
 =?us-ascii?Q?JDZqExKAsAXyTVpuqrOWWJbhkTIAwDgvVlWaKDIwCOZbKRvuH4EgLB5HEGbG?=
 =?us-ascii?Q?ZbP3eIoSZPHHt9m8sOSwssJE0dpjO1QznNzec0QZFu6pasDzdbaCbZIq90To?=
 =?us-ascii?Q?5FL6wmMTc3zcurvOeGA+fg5tJnbyzY5s0RUtTkumfhs7ORdCsD0aXMuOnsFj?=
 =?us-ascii?Q?dgz6ASarZkfqN3Sh4L/HfS7WujqgERazjR5/t+r6oNjeQP3XdqRTNvqI9j0l?=
 =?us-ascii?Q?fUIztaHwVDW26Eo7Q8nYIoVbUKU5WHWeqPdQDJQhJiHEbp4Md/YwuO2JAkwM?=
 =?us-ascii?Q?3HDs70ZrrTnfBkrCyDpBtJJgnfm38WYo20eTwPXmymg6Ei7mY9q/mpo8SFyx?=
 =?us-ascii?Q?fQRkhZIHJYoyBLM1C90ppADL2jYylOBEtLGKd6NEsUt9EspX1PezQmQuAw0U?=
 =?us-ascii?Q?BK67AEeaTjOOf8CUG11wx5JnFhNalEHx2RsvUB8Gd2+Pjk+06IVex6OyK5z0?=
 =?us-ascii?Q?TakWv/Ca45uku3bL+ixsL7bhIhveS0bkiUQH/MiZ923N/XRqC8+4OSh5pOgz?=
 =?us-ascii?Q?Da/r9YoT5mDcbDzXSWcwzpWY+Y4DGNtbmvqZ+h8qLIw4NFiyOVqjj1lUqJas?=
 =?us-ascii?Q?39ufHCH5dpxdV/jKixbnBzxN536mS2Vds4Pha2IRHahxQqhwXnso7xGxu+rB?=
 =?us-ascii?Q?LTtvAG4NqMISelvEaB0rUNaJUowiOHcXJdmb0mMK6fR1rq8BaxdXU6Nziz1j?=
 =?us-ascii?Q?rlFbvNy+5CZCXfU1NMe10cii1kQ0gzXijkYCxpg7pkfzjaHg1KhIQw7EM+6i?=
 =?us-ascii?Q?fHj7H3/dyJB5NCfv8MCs6lBlwL5bm37oCP1xVXJNAbFDInq+75TcE6EEHkUB?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5fb34-4ff5-4ad4-a49a-08db4045d253
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 19:48:03.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd8za+g9YCedsf82ZRo0yC4cZFAht0GpzL9zie9Jhnv1HMWoBDaF3GdLRSgQo5IhMDObzrQwZPwYH9LtmQnhkADhDq2juMNQ6Y5nvF/w/YHP8NODs5ZBXPpAjzQ5/Cub
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
 arch/arm64/include/asm/sdei.h |  8 ++++++++
 arch/arm64/kernel/entry.S     | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/sdei.c      |  3 +++
 arch/arm64/kernel/smp.c       | 27 +++++++++++++++++++++++----
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index badb39510515..58bc9ebe4a6d 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -13,6 +13,11 @@
 
 #include <asm/virt.h>
 
+#ifdef CONFIG_ARM_SDE_INTERFACE
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+#endif
+
 /* Software Delegated Exception entry point from firmware*/
 asmlinkage void __sdei_asm_handler(unsigned long event_num, unsigned long arg,
 				   unsigned long pc, unsigned long pstate);
@@ -23,6 +28,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+/* Abort a running handler. Context is discarded. */
+void sdei_handler_abort(void);
+
 /*
  * The above entry point does the minimum to call C code. This function does
  * anything else, before calling the driver.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ae7aa02f0df5..6d5694dfcb7b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1003,6 +1003,12 @@ SYM_CODE_START(__sdei_asm_handler)
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
@@ -1066,6 +1072,13 @@ SYM_CODE_START(__sdei_asm_handler)
 	mov_q	x3, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
 	csel	x0, x2, x3, ls
 
+	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
+	cbnz	w3, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	xzr, [x5]
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 alternative_if ARM64_UNMAP_KERNEL_AT_EL0
 	b 1f
@@ -1080,4 +1093,15 @@ alternative_else_nop_endif
 #endif
 SYM_CODE_END(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
+
+SYM_CODE_START(sdei_handler_abort)
+	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
+	adr	x1, 1f
+	sdei_handler_exit
+	// exit the handler and jump to the next instruction.
+	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
+1:	ret
+SYM_CODE_END(sdei_handler_abort)
+NOKPROBE(sdei_handler_abort)
+
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index be7f6ea49956..07fa9630f0ce 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -45,6 +45,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4e8327264255..ea221b1ee9ac 100644
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
+		pr_warn("SMP: stopped CPUS from SDEI critical event handler "
+			"context, attempting to finish handler.\n");
+		sdei_handler_abort();
+		__this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+		pr_warn("SMP: stopped CPUS from SDEI normal event handler "
+			"context, attempting to finish handler.\n");
+		sdei_handler_abort();
+		__this_cpu_write(sdei_active_normal_event, NULL);
+	}
+#endif
 }
 
 bool smp_crash_stop_failed(void)
-- 
2.39.2

