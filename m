Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D657D6E0B97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDMKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjDMKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:41:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA949EF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:41:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b1e92ce21so178738b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1681382466; x=1683974466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiYTZRIwk9ROTIrblLNUMUDt3W83vsBb+YQOnYk2aRE=;
        b=Cmcl+/DH2y0iFsEmNAa74QiO1a14FsXYAL7Xxw+ptKQK/MSmrSa9t7UimZ4PTfjnYF
         HkTtKC8dhkRKn3ZGRy+qOY2yztsEtGCQ4xXZPWgOGUNp0V97c1+32Mbvi7Tu9T4MyHSx
         JstY0PCBOC4oPuD8SFOJjU/psnqP4NB9I4Yh03RpjY+dwc8s/tOHYT0rKtlKQLIFKWk4
         IrLTEFTu8Rjc2Qaoe6ZTfrcublW4yTXtOxTWVb00fURzm/S1USIyV5ToDiWH4aISMAQX
         Ioy/5l4TNgGXovyM4ZvLFCrWNyeNEyqfHhJ++5KPqp7T6Ha1RX9jq2igjKbK0Qfbp34t
         vrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382466; x=1683974466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiYTZRIwk9ROTIrblLNUMUDt3W83vsBb+YQOnYk2aRE=;
        b=PJKuIMj2eGA68wJiN27aW5z8+OX2LuOLuFfWQgeVCiyLR0EuwsvRnrznIR6vwz/HKi
         i1Gxv/WCiW+y56ccnBgICKICGvGu3HTHBV3M2lEQHSJBIezQw9uNBAtAKVorkjd62TWV
         +VamA62SWNq2/feSC/ajN9go2IWgD/g/YvZKPvwZPYf2ppn0q1ZEUKFQfjwb2blfmPA/
         ZffGqfPmvAo/f+NgwW1D2tUAl4cNLGFTvJL6V6e7vueTZ7Y4n3X+6YaKdUNsoCTt23Cv
         j5wzvzMeayHIMorVkRBwoFZqQ4iBv9Eqjvf37DKvHpOTasFDGJ2iVsnOqknRTI8l+PkS
         8NVA==
X-Gm-Message-State: AAQBX9d2lHW2Fz/kxTLNEWeaOM/iXnuxev/wtgf8Hikt1ujhVVOH6/oq
        CZWKO6UMTK8eoxIhUEnjrFJJBw==
X-Google-Smtp-Source: AKy350aLyA6znkshYqfjEX/OMTptkJfQsb2J51rA72fh6WMd6ucgg5v4bMp7qTJW/2wHwIu36J/lzQ==
X-Received: by 2002:a05:6a20:8e19:b0:d9:a977:fae with SMTP id y25-20020a056a208e1900b000d9a9770faemr1781568pzj.3.1681382465739;
        Thu, 13 Apr 2023 03:41:05 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b0063486255a87sm1152124pfn.142.2023.04.13.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:41:05 -0700 (PDT)
From:   Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: [PATCH] Binder: Add timestamp and async from pid/tid to transaction record
Date:   Thu, 13 Apr 2023 18:40:47 +0800
Message-Id: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuang Zhang <zhangchuang3@xiaomi.com>

This patch adds a timestamp field to the binder_transaction
structure to track the time consumed during transmission
when reading binder_transaction records.
Additionally, it records the from pid and tid of asynchronous
binder. This information is printed when reading binderfs
related nodes to assist with debugging.

Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>
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

