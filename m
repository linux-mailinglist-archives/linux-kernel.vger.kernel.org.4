Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5376054B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJTBLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJTBLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010A16552F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ez6so850313pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJohSBMpko54dLX8P/51bY6y3oGzs1tMcw4aH/Yvzng=;
        b=Aq+lPDV4PUAgvfmt2l+zK/WTvDukCwcSf/iEiizuVXAIUeFOQ9iS+Fh9ro4ADsXeJb
         hTyoIEHWrhYmmG1dtB0BM2qr7N80PPdl+FiFzju9NUoNw/QLnG7Iyiq6NMPkIPBRyW4n
         SRJuWhyrjIdi+8KwjNFo7bq1f1BlFvXJr4oik70p5h6q7a3xfm4kaarWblPWYWD7bfMk
         f+QEivOdBsJ569IEApREbc96II3Q//letX9fhTwdV3VoHWoN1DUe0GM940IoEXbJJjf9
         UJUU3qdpt4XiT8ktx9zIIxcoRm8EbHlm5oy3eXbMt11tPkbKKdCIYxj6CnzcL+uPa7fG
         CgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJohSBMpko54dLX8P/51bY6y3oGzs1tMcw4aH/Yvzng=;
        b=6hBeFTgF4t+9BrU4CuktKg16iepID2BWagcW5rkvf8AXapRhlbVvHv7ZV47ubUKVAG
         3D7pdU9n32Q1+mGqbD7cBxjz7s55FxeTAPlaylVryidrWctNMAFAYQ1+ZXX4sm6Y13Vq
         /59koQ11GKdAcMQ7mRPLL/nLeIa4OgDjUuXWWe4L+jQj5+crP1pLhzRr/QajabOFAhWL
         +AJo4WvUrfC3ZpQMzq8LzdGi9T5Kui7e8+MzT8HOWVhVRq7PXVylxhigWKlYEn1z+4yq
         KK60nUcyWafEw2+Nzjhm0sgQoL7Bwra4BCM0M7fUQ9wc78nfPTTHesiwYZuGZRASccqS
         u3TA==
X-Gm-Message-State: ACrzQf2eJEuLBSqGK/5dN0fFbNq7HXNMuykp9xmjNy8/geEuhXBwr1T5
        xYPd9E9Jsjt3qfNCAPi66W0/tngeucbhDg==
X-Google-Smtp-Source: AMsMyM7QibunXcGAfnNWo7j5XIvt1edy9I6TC/cUP1SKdwiBkzOq7N0egxLyWEIpwLdTu6D4dLQKCg==
X-Received: by 2002:a17:90b:2250:b0:20d:9587:45c4 with SMTP id hk16-20020a17090b225000b0020d958745c4mr12621755pjb.17.1666228264084;
        Wed, 19 Oct 2022 18:11:04 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:11:03 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/5] sched: add a few helpers to wake up tasks on the current cpu
Date:   Wed, 19 Oct 2022 18:10:46 -0700
Message-Id: <20221020011048.156415-4-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221020011048.156415-1-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
up processes on the current CPU.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/linux/completion.h |  1 +
 include/linux/swait.h      |  1 +
 include/linux/wait.h       |  3 +++
 kernel/sched/completion.c  | 12 ++++++++++++
 kernel/sched/core.c        |  2 +-
 kernel/sched/swait.c       | 11 +++++++++++
 kernel/sched/wait.c        |  5 +++++
 7 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 62b32b19e0a8..fb2915676574 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -116,6 +116,7 @@ extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
 extern void complete(struct completion *);
+extern void complete_on_current_cpu(struct completion *x);
 extern void complete_all(struct completion *);
 
 #endif
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..1f27b254adf5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -147,6 +147,7 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 extern void swake_up_one(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_locked_on_current_cpu(struct swait_queue_head *q);
 
 extern void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 7f5a51aae0a7..c7d3e78a500d 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -210,6 +210,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 }
 
 void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
@@ -237,6 +238,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)							\
 	__wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+#define wake_up_poll_on_current_cpu(x, m)					\
+	__wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)						\
 	__wake_up_locked_key((x), TASK_NORMAL, poll_to_key(m))
 #define wake_up_interruptible_poll(x, m)					\
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1c1cd9..a1931a79c05a 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -38,6 +38,18 @@ void complete(struct completion *x)
 }
 EXPORT_SYMBOL(complete);
 
+void complete_on_current_cpu(struct completion *x)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+
+	if (x->done != UINT_MAX)
+		x->done++;
+	swake_up_locked_on_current_cpu(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+
 /**
  * complete_all: - signals all threads waiting on this completion
  * @x:  holds the state of this particular completion
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cffa8f314c9a..1412470216c3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6822,7 +6822,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 76b9b796e695..9ebe23868942 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -31,6 +31,17 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
+void swake_up_locked_on_current_cpu(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	if (list_empty(&q->task_list))
+		return;
+
+	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	try_to_wake_up(curr->task, TASK_NORMAL, WF_CURRENT_CPU);
+	list_del_init(&curr->task_list);
+}
 /*
  * Wake up all waiters. This is an interface which is solely exposed for
  * completions and not for general usage.
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9860bb9a847c..9a78bca79419 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -157,6 +157,11 @@ void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL(__wake_up);
 
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
+{
+	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
+}
+
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
-- 
2.37.2

