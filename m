Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EA76ECAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjDXLGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjDXLFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:05:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3F358C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a6684fd760so5651755ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1682334351; x=1684926351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7w8J/31Yem77tq6w6OQLHfBqQH63bZFgtBA1kzm0Ew=;
        b=GGxWgzgKponfhoOaOh0cJCCA7XpNqxC81Bm0ENit9k2hfTXutAIn5x5ympX1OXcFvf
         bl8BNjC8Q/CRPTe1VZ/On17FzPSaRpC/bvw1akeyq7PTwlSw+3V8EsmtOZRFdsMjZ1MY
         NILF4R73mZVN5ZIAkGoaMYkeNNzYIpea+fYZVIRk0SHla/A0PS4KTHQhygZEWBDntqFJ
         Cze2Tr7tdWvlaTX+ajH0FKrs1cmp7HRa8en38pEVdtctI/cXYETMlu86S/N5bcz7shBV
         neBLxJgyx3pULH88jFjtJQj78SsEUy7lIkN9XBp0XRuBlxdiFDyomG8SzENyklY99iqr
         43KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334351; x=1684926351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7w8J/31Yem77tq6w6OQLHfBqQH63bZFgtBA1kzm0Ew=;
        b=A7m8Q0tV09IF2Vf/bHAW4CQfw3UCj158NcVIXeb25Grg3s5PpBHzlg37kN2ps+iXqz
         5M5hgQXhfQH8qQrj2YIytwAKmQitK+8I4WrftEbmwcG1bBMl2Yu5RPmBNKzm+oPpEEpn
         d+vWex+UdkVol6giMuLLKKccsLiola+mSZfBreGOYTZzAYakN7d5sRFFZzSfQqegn/JB
         xdztt+2xw1aqFRocN/dRAS6XqtYbmXQgRyam3AG36mxpEavAxxUFTRLf1xL7wtmq/BoF
         6LAxB2cvsRQXX8asquR3P3GDfHZCzl3TUkZ9WCErQ1c/e70xPwMtu3w+FD9xATjhM/Xt
         /rGw==
X-Gm-Message-State: AAQBX9dF7N1N7rkBKxDrAv0iel3lpsrlJ8vZ1VVI+Uybsk2n8HPlKd6A
        GnPaeVon9LeIvcC7mPVpQD9DSg==
X-Google-Smtp-Source: AKy350bzS4+fsq5HigK1dnGISsVR66cLKLGEDMdhj/BNt2PUkESpm6UMqAvcSsYJCNEJMc3b2KCFxg==
X-Received: by 2002:a17:902:dacd:b0:1a1:956d:2281 with SMTP id q13-20020a170902dacd00b001a1956d2281mr16147930plx.3.1682334351212;
        Mon, 24 Apr 2023 04:05:51 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902694700b0019c91989a1csm6364544plt.300.2023.04.24.04.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:05:51 -0700 (PDT)
From:   Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
To:     gregkh@linuxfoundation.org, cmllamas@google.com
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: [PATCH v2 1/2] Binder: Add timestamp to transaction record
Date:   Mon, 24 Apr 2023 19:05:14 +0800
Message-Id: <5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682333709.git.zhangchuang3@xiaomi.com>
References: <cover.1682333709.git.zhangchuang3@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuang Zhang <zhangchuang3@xiaomi.com>

This patch adds a timestamp field to the binder_transaction
structure to track the time consumed during transmission
when reading binder_transaction records.

Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>
---
 drivers/android/binder.c          | 9 +++++++--
 drivers/android/binder_internal.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb56bfc45096..b6413652906e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -66,6 +66,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/sizes.h>
+#include <linux/ktime.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -2904,6 +2905,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_size_t last_fixup_min_off = 0;
 	struct binder_context *context = proc->context;
 	int t_debug_id = atomic_inc_return(&binder_last_id);
+	ktime_t t_start_time = ktime_get();
 	char *secctx = NULL;
 	u32 secctx_sz = 0;
 	struct list_head sgc_head;
@@ -3145,6 +3147,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
 
 	t->debug_id = t_debug_id;
+	t->start_time = t_start_time;
 
 	if (reply)
 		binder_debug(BINDER_DEBUG_TRANSACTION,
@@ -5930,17 +5933,19 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 {
 	struct binder_proc *to_proc;
 	struct binder_buffer *buffer = t->buffer;
+	ktime_t current_time = ktime_get();
 
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d elapsed %lldms",
 		   prefix, t->debug_id, t,
 		   t->from ? t->from->proc->pid : 0,
 		   t->from ? t->from->pid : 0,
 		   to_proc ? to_proc->pid : 0,
 		   t->to_thread ? t->to_thread->pid : 0,
-		   t->code, t->flags, t->priority, t->need_reply);
+		   t->code, t->flags, t->priority, t->need_reply,
+		   ktime_ms_delta(current_time, t->start_time));
 	spin_unlock(&t->lock);
 
 	if (proc != to_proc) {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 28ef5b3704b1..92e64007f2b0 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -528,6 +528,7 @@ struct binder_transaction {
 	long    priority;
 	long    saved_priority;
 	kuid_t  sender_euid;
+	ktime_t start_time;
 	struct list_head fd_fixups;
 	binder_uintptr_t security_ctx;
 	/**
-- 
2.34.1

