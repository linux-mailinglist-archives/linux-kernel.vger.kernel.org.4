Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6726743A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjASUps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:45:31 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59356FF8F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:45:30 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x7so2537371qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oClR+TZHqp9DBqgOuOBSYorZn56b98W2/rv9S0VBxMo=;
        b=kRSLuAf8/gwmklz9wS8G9knC1IWejn+s0khyuaHWOjOcqyQzapOa3DhrBNMcggxRdc
         8mQjkpQ6ntK6MgvHO6MEw8l6DDxM9Ll4vXQMEtu28oEunJGxUUisc8OYhctQhS9cIrUw
         yY9mCqNqAcI1WXzWajjdYWaVWc8b2+CaZzDRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oClR+TZHqp9DBqgOuOBSYorZn56b98W2/rv9S0VBxMo=;
        b=kFOEGinBRhN8ZAgqAdpPVIosSyW8ZAvOusq7FIao2EgbECnEoWCtG4R1O8siZYKjz7
         BerX5ON6tWvcNFSsTDl2ZvC9IutgF7ZhlZYuBXAbS5Ls05yOOKInzOFSRX6M5I7D3edL
         vGn/9xSGYMV3lyLzUko8Z7WYVqM/DbkXFYcc2u6iwR3UgDZZAvJYeI4tb7bO1eN770Sd
         NtB9q6ogb5AfUP6ESRf5iyKs5Yf11UDy6YF6yii9wCPB0kQnWWJQB+hi/sJl+uBtMjeG
         Y0Ce0Xof1RaR+pADxA/WXnlMSu7cCbadaq6HIdl6avzU0Vd9nw/OgmS8IJxnBgADgtEn
         nFOg==
X-Gm-Message-State: AFqh2kp0f8OvNCISXNXqtxx1rcIKhrZ1blgEijBsXkAtWrjuitVOwcYe
        uzQr9qLFO0GxeUhu8XEat3GAnWYWeP/3jH8Z
X-Google-Smtp-Source: AMrXdXsBgNfm4v/YHnYnswcQsiHSVsxDdoQerHQ+1QanqmlBp/4XgP92yMLRoCYURj0eMS8gTEUs0w==
X-Received: by 2002:ac8:60c9:0:b0:3a8:15d2:6e8f with SMTP id i9-20020ac860c9000000b003a815d26e8fmr16897815qtm.44.1674161129027;
        Thu, 19 Jan 2023 12:45:29 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id fu28-20020a05622a5d9c00b003a7f3c4dcdfsm19488469qtb.47.2023.01.19.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:45:28 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tick/nohz: Fix cpu_is_hotpluggable() by checking with nohz subsystem
Date:   Thu, 19 Jan 2023 20:44:35 +0000
Message-Id: <20230119204434.4017605-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CONFIG_NO_HZ_FULL systems, the tick_do_timer_cpu cannot be offlined.
However, cpu_is_hotpluggable() still returns true for those CPUs. This causes
torture tests that do offlining to end up trying to offline this CPU causing
test failures. Such failure happens on all architectures.

Fix it by asking the opinion of the nohz subsystem on whether the CPU can
be hotplugged.

[ Apply Frederic Weisbecker feedback on refactoring tick_nohz_cpu_down(). ]

Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: rcu <rcu@vger.kernel.org>
Fixes: 2987557f52b9 ("driver-core/cpu: Expose hotpluggability to the rest of the kernel")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/base/cpu.c       |  3 ++-
 include/linux/tick.h     |  2 ++
 kernel/time/tick-sched.c | 12 +++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 55405ebf23ab..450dca235a2f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..9459fef5b857 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9c6f661fb436..383a060f30c5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -510,7 +510,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+static int tick_nohz_cpu_hotplug_ret(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -522,6 +522,16 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	return 0;
 }
 
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotplug_ret(cpu);
+}
+
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotplug_ret(cpu) == 0;
+}
+
 void __init tick_nohz_init(void)
 {
 	int cpu, ret;
-- 
2.39.0.246.g2a6d74b583-goog

