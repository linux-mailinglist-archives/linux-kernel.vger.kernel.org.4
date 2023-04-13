Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6D6E0A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:38:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4F4C3C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:38:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so19988594pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378693; x=1683970693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjNmvCCPoamVFG82i0Mu+zEIpddpsnFLbNzstqSHclM=;
        b=kRnj6UoFW97dtn9gWiOEiPYzQAxnHoc1PHzuhn5h0yuRa8GvPx6gXhXUNPYsZwby8V
         vfpOyhZKRmzD78+Oxug/5t0IpMX+M/GePC0Bpt1AkL9DOeyVAn8LXvB+lvmdopHl/my6
         3cpWTIlpX2gHW3rZfuqFP5QHdT/38k8rxlIInEZKiFVps+WX6MdtshSXjNPpGu0JtAR0
         5uPADnzqHk6hvrnLaeBWqJljNXRWuZIGJ7vpfXfGHnsMHTekAbguCDqox1RWKyfqHvI/
         xYOlp3/9rocIYUMvhxVDaLJ5bWAPQ5mCS1NK5ofZRxNfMPm2X+DMYqw3GYLuJVw8kbwe
         c8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378693; x=1683970693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjNmvCCPoamVFG82i0Mu+zEIpddpsnFLbNzstqSHclM=;
        b=g2+sujx+ZWy01Nwcp+VMlIlK45OCSN/LHeP+n9vOyvPmfwBq77JUzwdUZzOHz9khYf
         Mjp8qBF9OinuJzBPCJc9fnj1TD7zqvwFggvDcD1b+U/H0axHhps/QE6v26Td1xjFQiNX
         fA5s4LMOsKhkrL6Rol6PLp8YB1rHjfevtVgQN7i8HziHYqCjmPwoLqrr78tAAi1trzyL
         vpflCnG1ENKmmuCDKaqJ1GUGGI92vcgAz8YCriqczPOJ03kOGl1rJDPFowKELMzGy9Tk
         9f59RoaGaQ22VF/Q7DNkr1fYxyzbxLP8s7JR9DZsY0beOn9GIo7wFdiOfnYJBvuHhpCG
         39QA==
X-Gm-Message-State: AAQBX9cy41vF/sP/R5wN3lUAFsmyTFxq6aus+0ft04250k7FrY+S5oee
        vZj5/wdPx6J29ryNMh6R4EE=
X-Google-Smtp-Source: AKy350Y68bbvsTKoeeZxitcjrFhWC4cZVJRI1X9hLsyWh+NMF0NrN/gfnvRiQscOBF0q6SGBUNBTMw==
X-Received: by 2002:a17:902:f90e:b0:1a1:dd00:b4d9 with SMTP id kw14-20020a170902f90e00b001a1dd00b4d9mr1578708plb.46.1681378692798;
        Thu, 13 Apr 2023 02:38:12 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001a644662ee0sm1085640plb.18.2023.04.13.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:38:12 -0700 (PDT)
From:   Chuang Zhang <zhangchuang1909@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        zhangchuang3 <zhangchuang3@xiaomi.com>
Subject: [PATCH] Binder: Add timestamp and async from pid/tid to transaction record
Date:   Thu, 13 Apr 2023 17:38:05 +0800
Message-Id: <20230413093805.385284-1-zhangchuang1909@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangchuang3 <zhangchuang3@xiaomi.com>

This patch adds a timestamp field to the binder_transaction
structure to track the time consumed during transmission
when reading binder_transaction records.
Additionally, it records the from pid and tid of asynchronous
binder. This information is printed when reading binderfs
related nodes to assist with debugging.

Signed-off-by: zhangchuang3 <zhangchuang3@xiaomi.com>
---
 drivers/android/binder.c          | 24 ++++++++++++++++++------
 drivers/android/binder_internal.h |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb56bfc45096..e79f548bcbac 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -66,6 +66,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/sizes.h>
+#include <linux/ktime.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -3145,6 +3146,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
 
 	t->debug_id = t_debug_id;
+	t->start_time = ktime_get();
 
 	if (reply)
 		binder_debug(BINDER_DEBUG_TRANSACTION,
@@ -3165,10 +3167,15 @@ static void binder_transaction(struct binder_proc *proc,
 			     (u64)tr->data_size, (u64)tr->offsets_size,
 			     (u64)extra_buffers_size);
 
-	if (!reply && !(tr->flags & TF_ONE_WAY))
+	if (!reply && !(tr->flags & TF_ONE_WAY)) {
 		t->from = thread;
-	else
+		t->async_from_pid = 0;
+		t->async_from_tid = 0;
+	} else  {
 		t->from = NULL;
+		t->async_from_pid = thread->proc->pid;
+		t->async_from_tid = thread->pid;
+	}
 	t->sender_euid = task_euid(proc->tsk);
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
@@ -4963,6 +4970,8 @@ static int binder_thread_release(struct binder_proc *proc,
 		} else if (t->from == thread) {
 			t->from = NULL;
 			t = t->from_parent;
+			t->async_from_pid = 0;
+			t->async_from_tid = 0;
 		} else
 			BUG();
 		spin_unlock(&last_t->lock);
@@ -5930,17 +5939,20 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 {
 	struct binder_proc *to_proc;
 	struct binder_buffer *buffer = t->buffer;
+	ktime_t current_time = ktime_get();
 
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x elapsed %lldms flags %x pri %ld r%d",
 		   prefix, t->debug_id, t,
-		   t->from ? t->from->proc->pid : 0,
-		   t->from ? t->from->pid : 0,
+		   t->from ? t->from->proc->pid : t->async_from_pid,
+		   t->from ? t->from->pid : t->async_from_tid,
 		   to_proc ? to_proc->pid : 0,
 		   t->to_thread ? t->to_thread->pid : 0,
-		   t->code, t->flags, t->priority, t->need_reply);
+		   t->code,
+		   ktime_ms_delta(current_time, t->start_time),
+		   t->flags, t->priority, t->need_reply);
 	spin_unlock(&t->lock);
 
 	if (proc != to_proc) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 28ef5b3704b1..7e60f547abb6 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -528,6 +528,9 @@ struct binder_transaction {
 	long    priority;
 	long    saved_priority;
 	kuid_t  sender_euid;
+	int async_from_pid;
+	int async_from_tid;
+	ktime_t start_time;
 	struct list_head fd_fixups;
 	binder_uintptr_t security_ctx;
 	/**
-- 
2.34.1

