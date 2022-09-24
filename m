Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A85E8DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiIXPXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiIXPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91E8709C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664032965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfsmTvmGXeM1/5qFA1Qh7h37ne6tkdVL6kPv6MNEep4=;
        b=JY4K53SvpnZ5+pIV375oZl9HWqRBBNKLpBE4G0H4USMcV3sbe6nomhlW1NU7ZThFTcXJIE
        KBOxETVAlyaU8z8itU7y1XbnLQzjsOT5XSfFsJPe5aKHkX/lGxFLh49julzGkwq3+oIBH3
        eHd8oTvD6x4S2VVya5xiidqcjdsOcqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-WxaCzjl1N6S3eY3sgWrY9Q-1; Sat, 24 Sep 2022 11:22:44 -0400
X-MC-Unique: WxaCzjl1N6S3eY3sgWrY9Q-1
Received: by mail-wr1-f70.google.com with SMTP id h20-20020adfaa94000000b0022af8c26b72so485790wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 08:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FfsmTvmGXeM1/5qFA1Qh7h37ne6tkdVL6kPv6MNEep4=;
        b=a01PPYz9RYbA64SyeKEJ51aTPoCFdJ0toUsVWq+RZf2p5kI3Lv3Cwq71dpjYfn4DD3
         ZkQ3zJWfzJ52binUkdw8mvobWiSzy/pgKR/IYN9sDJtQkTSEcjWYMu31sbFgOA2WOTyx
         wW8kZw6XmK4MttAAuHOFDHBQ5r09MKmJcmuosjktKCoqinnZk7DEa4zT+zb9bfLqoUkn
         j//arVJJIRcBoVs6QG2lTMIucdjJAaFGb3fea0plPJ+rZsCYQSbLxkpckmU/MR54h4HM
         NQVmgjIPgsyauV1hLIdx57DlW3LwZ1QZ870v6H3gTZT/Vpz6MKpsoKSJ3D7b3AVxU44y
         PkNQ==
X-Gm-Message-State: ACrzQf2C3ohpCnouMf8nQjx7jG8Cola3giu3lMmdUBIsuRuC0+tA1zWL
        dA3q/nxTYNRhwRFgud7qS+Zcs4fb28e9/ZhGK/wh6GzZwW190UtGXz505xim9EDP9kQ4djlDSn/
        +cw09tkHPxQp95ThpuRBkkoE=
X-Received: by 2002:a05:6000:18aa:b0:22a:b61d:877a with SMTP id b10-20020a05600018aa00b0022ab61d877amr8412523wri.512.1664032961876;
        Sat, 24 Sep 2022 08:22:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56wiVnnOEt4nyShWrMqWg2SekETLv7jY1m2hDmQ/noBoVfgCeZVDYazjwtyeDkFVI65YEN6g==
X-Received: by 2002:a05:6000:18aa:b0:22a:b61d:877a with SMTP id b10-20020a05600018aa00b0022ab61d877amr8412517wri.512.1664032961709;
        Sat, 24 Sep 2022 08:22:41 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c378300b003b48dac344esm5421645wmr.43.2022.09.24.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 08:22:41 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     frederic@kernel.org, mtosatti@redhat.com
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, atomlin@atomlin.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v8 4/5] tick/nohz_full: Ensure quiet_vmstat() is called on exit to user-mode when the idle tick is stopped
Date:   Sat, 24 Sep 2022 16:22:26 +0100
Message-Id: <20220924152227.819815-5-atomlin@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924152227.819815-1-atomlin@redhat.com>
References: <20220924152227.819815-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures CPU-specific vmstat differentials do not remain
when the scheduling-tick is stopped and before exiting to user-mode
in the context of nohz_full only.

A trivial test program was used to determine the impact of the proposed
changes and under vanilla. The mlock(2) and munlock(2) system calls was
used solely to modify vmstat item 'NR_MLOCK'. The following is an average
count of CPU-cycles across the aforementioned system calls:

				  Vanilla                 Modified

  Cycles per syscall              8461                    8690    (+2.6%)

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/tick.h     |  5 +++--
 kernel/time/tick-sched.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..a2bbd6d32e33 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -11,7 +11,6 @@
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
 #include <linux/sched.h>
-#include <linux/rcupdate.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void __init tick_init(void);
@@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
+void __tick_nohz_user_enter_prepare(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
@@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
+static inline void __tick_nohz_user_enter_prepare(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 #endif
 
@@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch(void)
 static inline void tick_nohz_user_enter_prepare(void)
 {
 	if (tick_nohz_full_cpu(smp_processor_id()))
-		rcu_nocb_flush_deferred_wakeup();
+		__tick_nohz_user_enter_prepare();
 }
 
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..634cd0fac267 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -26,6 +26,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq_regs.h>
 
@@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+void __tick_nohz_user_enter_prepare(void)
+{
+	struct tick_sched *ts;
+
+	if (tick_nohz_full_cpu(smp_processor_id())) {
+		ts = this_cpu_ptr(&tick_cpu_sched);
+
+		if (ts->tick_stopped)
+			quiet_vmstat();
+		rcu_nocb_flush_deferred_wakeup();
+	}
+}
+EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {
-- 
2.37.1

