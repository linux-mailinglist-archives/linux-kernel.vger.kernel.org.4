Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC85F7AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJGPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJGPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751DD73FD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665157572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8NlfJJNnBH1Hg+bNlEeNOaLSp643edXbrFkYOuHdj0=;
        b=XZUItkYIA3WfdfQpFv5uH/wzOdi2rNdHRiXGvFX9L5EMq2XkGJ+8XfPQH5ucRnCn+i7Uc1
        H/lrjzW1XDH8DvUElN4C+UwG8shntaRncllqAligm8rt8V+hw0smKLELHsby8Io767sdG+
        D2Vqy78S2Ya38nUlGgLst6q+FVvKah4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-XkI1c9RtNAOudKYGN1y7_A-1; Fri, 07 Oct 2022 11:46:09 -0400
X-MC-Unique: XkI1c9RtNAOudKYGN1y7_A-1
Received: by mail-wr1-f69.google.com with SMTP id e14-20020adf9bce000000b0022d18139c79so1561234wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8NlfJJNnBH1Hg+bNlEeNOaLSp643edXbrFkYOuHdj0=;
        b=PyTInh2SpxOt1KAWQCQwuubGax8M9XXlOBIu7SnBFNZt/YlQE+nc5HCguAENrOt7AI
         AYaPblJuFazNUKaaFmw0Po/mclb8N9lD43L74VI06bDMutojJF+8Yj9EZPBNN13C4V+o
         o22SAfx7InSgWjgbYMSvMcsox6k6QA7o096ywmDw8lsAs/pupkL+fCQIxglthpk/l9We
         KOdBwS4pQ27vOUSw+vfQXNKPRF2HwYTS9nGRsQz7BCIzOZM/nxHvw072GM9Pailex7tS
         jjcOEl7z1Z1qQ2GCj59gCozPjvNQ85fYFgOB0iLzFAHcezYpaaJW40A0qkQFTfNvKrJH
         nymA==
X-Gm-Message-State: ACrzQf1qn99S5zAR45vhgDG4DEms8Fyq01q/dm4WQK88UyyBvnuGhH4l
        xUM1O2XQ+ZWJkXBm1h2klrBhW0RcnytO7+WOFkG01+mp7bxOmSwKZJOxZqgI+5u5rGADeeuUnAl
        tw9E79m2/Rk3c1XC/XzpjnukA
X-Received: by 2002:a5d:64cd:0:b0:22e:2fc1:9511 with SMTP id f13-20020a5d64cd000000b0022e2fc19511mr3566262wri.415.1665157568143;
        Fri, 07 Oct 2022 08:46:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4t9ram8oou3fr6TpdC1R8We+758fvnnqCUt2NCTCIakvPHOGi5POwCK/ARZj0LE9PFnGcXMg==
X-Received: by 2002:a5d:64cd:0:b0:22e:2fc1:9511 with SMTP id f13-20020a5d64cd000000b0022e2fc19511mr3566217wri.415.1665157567961;
        Fri, 07 Oct 2022 08:46:07 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:46:06 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 4/5] irq_work: Trace calls to arch_irq_work_raise()
Date:   Fri,  7 Oct 2022 16:45:32 +0100
Message-Id: <20221007154533.1878285-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a tracepoint to send_call_function_single_ipi() covers
irq_work_queue_on() when the CPU isn't the local one - add a tracepoint to
irq_work_raise() to cover the other cases.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/irq_work.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..5a550b681878 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -22,6 +22,8 @@
 #include <asm/processor.h>
 #include <linux/kasan.h>
 
+#include <trace/events/ipi.h>
+
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
@@ -74,6 +76,14 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
+static inline void irq_work_raise(void)
+{
+	if (arch_irq_work_has_interrupt())
+		trace_ipi_send_cpu(_RET_IP_, smp_processor_id());
+
+	arch_irq_work_raise();
+}
+
 /* Enqueue on current CPU, work must already be claimed and preempt disabled */
 static void __irq_work_queue_local(struct irq_work *work)
 {
@@ -99,7 +109,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 
 	/* If the work is "lazy", handle it from next tick if any */
 	if (!lazy_work || tick_nohz_tick_stopped())
-		arch_irq_work_raise();
+		irq_work_raise();
 }
 
 /* Enqueue the irq work @work on the current CPU */
-- 
2.31.1

