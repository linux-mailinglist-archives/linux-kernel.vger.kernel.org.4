Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADD6CFDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjC3IQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjC3IQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:16:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76F07699
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so18844335pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680164177; x=1682756177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeGMhGjlOUL9hcw/OfwgoUUZHIgylsB55Ojf8081slY=;
        b=cWRCrnQ+IkpjAOgI8J13qkCxF4uiPfP10nhJBLpRwUJr0Pb8OIPcOYuIEVl5/MuBAs
         b9vC1uC3UHX6e07WVcto2r9pBuH7Uo9gK/TPSLNAX+iLKBE6pLHwJIw3N/6vQA8p3rg+
         q/TssNQOutacWxiFzIcYWpMLT4QvLIWiFRImrAm2YgjNtWTm3pJnTQ05AtlIxTw0yuF7
         R+yPMC4/mZWyItAuvyVZNDL1RX2giobChvA/eMwrib2Iyy33Hu6mbPQGQFgFTIxbjHwH
         Cu75Y4jNVfTl2h4xnJtDke/0QBbMANRvwlC1vkFpBiIGVjAWvPTl5C0A/OD+zS41jV4z
         P+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164177; x=1682756177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeGMhGjlOUL9hcw/OfwgoUUZHIgylsB55Ojf8081slY=;
        b=Q3jUE3k39L+KOGhRZf3hRx2MJuxTklJftX2tRwowVofWXwqwYZMez+kJ/7J4CDY+If
         PPueqCBVm64mXz1T79GxFVXCVPC0BOuKGVi6Al6nOHBQPnwxOEAggkoiQQzL0UDKqK0x
         LN/HUg2dtDFDIqP+P3jbadzgGrOUz+N0ZwWEwiVr5X3onc7bI3zO57eOC3ae1rj/kn+A
         shG7hec+tFgUb9KrTCpU3L+Ug8+We1odvPfesvlARTWFi6cQvc6hAO7xqdYMQM72jo1L
         MzAhXsmOjU7zLtNma2tq7J+1CLerRPL323IIX6lAgn8rWxtptZkiSFaFNdBZtniWVsMm
         fczg==
X-Gm-Message-State: AAQBX9dKk+vvwIm1NKe1hd8raVEiMue6IndNLOgCK7zO20JOm7ZLHuUo
        G+QzLKM/7eimLGESefv4PQnqIw==
X-Google-Smtp-Source: AKy350bJ9z5dZ3L0svQrDt78Mp7wSxeRapQ/vDbkhQqaEI4KbU5YFJGeTOtA3+EFM7jRivmkGJe56w==
X-Received: by 2002:a17:90a:eb12:b0:23b:4bce:97de with SMTP id j18-20020a17090aeb1200b0023b4bce97demr1486260pjz.4.1680164177141;
        Thu, 30 Mar 2023 01:16:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090a138d00b0023cd53e7706sm2630837pja.47.2023.03.30.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:16:16 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     peterz@infradead.org, keescook@chromium.org, jpoimboe@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, rostedt@goodmis.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/2] x86: make profile_pc() use arch_stack_walk()
Date:   Thu, 30 Mar 2023 16:15:51 +0800
Message-Id: <20230330081552.54178-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
References: <20230330081552.54178-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The profile_pc() try to get pc by doing a trick to read
the contents of the stack. This may cause false positives
for KASAN, like the following:

 BUG: KASAN: stack-out-of-bounds in profile_pc+0x5b/0x90
 Read of size 8 at addr ffff8881062a7a00 by task id/130040

 CPU: 1 PID: 130040 Comm: id Kdump: loaded Not tainted 5.15.93+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x4c/0x64
  ? profile_pc+0x5b/0x90
  print_address_description.constprop.8.cold.12+0x10/0x36b
  ? profile_pc+0x5b/0x90
  ? profile_pc+0x5b/0x90
  ? tick_sched_handle.isra.20+0xa0/0xa0
  kasan_report.cold.13+0x7f/0x11b
  ? scheduler_tick+0x30/0x150
  ? profile_pc+0x5b/0x90
  ? _raw_spin_lock+0x82/0xd0
  profile_pc+0x5b/0x90
  profile_tick+0x78/0xb0
  ? tick_sched_handle.isra.20+0x83/0xa0
  tick_sched_timer+0x94/0xb0
  ? enqueue_hrtimer+0x100/0x100
  ? _raw_write_lock_irqsave+0xd0/0xd0
  ? recalibrate_cpu_khz+0x10/0x10
  ? ktime_get_update_offsets_now+0x148/0x1a0
  hrtimer_interrupt+0x1b9/0x390
  ? sched_ttwu_pending+0xf1/0x150
  __sysvec_apic_timer_interrupt+0x7c/0x150
  sysvec_apic_timer_interrupt+0x61/0x80
  </IRQ>
  <TASK>
  asm_sysvec_apic_timer_interrupt+0x16/0x20
 RIP: 0010:_raw_spin_lock+0x82/0xd0

The KASAN checking is already disabled in the ORC unwinder,
so let's make profile_pc() use arch_stack_walk() to get pc,
which fixes the above BUG and also avoids open-coding of
unwind logic.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/x86/kernel/time.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index e42faa792c07..eee884306d36 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -17,6 +17,7 @@
 #include <linux/i8253.h>
 #include <linux/time.h>
 #include <linux/export.h>
+#include <linux/stacktrace.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -25,27 +26,24 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 
+static bool profile_pc_cb(void *arg, unsigned long pc)
+{
+	unsigned long *prof_pc = arg;
+
+	if (in_lock_functions(pc))
+		return true;
+
+	*prof_pc = pc;
+	return false;
+}
+
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	unsigned long pc = instruction_pointer(regs);
-
-	if (!user_mode(regs) && in_lock_functions(pc)) {
-#ifdef CONFIG_FRAME_POINTER
-		return *(unsigned long *)(regs->bp + sizeof(long));
-#else
-		unsigned long *sp = (unsigned long *)regs->sp;
-		/*
-		 * Return address is either directly at stack pointer
-		 * or above a saved flags. Eflags has bits 22-31 zero,
-		 * kernel addresses don't.
-		 */
-		if (sp[0] >> 22)
-			return sp[0];
-		if (sp[1] >> 22)
-			return sp[1];
-#endif
-	}
-	return pc;
+	unsigned long prof_pc = 0;
+
+	arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
+
+	return prof_pc;
 }
 EXPORT_SYMBOL(profile_pc);
 
-- 
2.20.1

