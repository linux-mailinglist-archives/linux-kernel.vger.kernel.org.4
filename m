Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640006ECAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjDXLG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjDXLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:06:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B7E30DB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a6a50dd62cso5578355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1682334358; x=1684926358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZj59uqTOdaKdkMKQNxt7QjTcz6A2zCcP9s8UJu1DDI=;
        b=1tm6/cs9NEbhQLSrgdMrPBw3SsbHfrcjEaN4JEqEX+ZDRrLGbNgZF7VFcdmPIisNmT
         Cf+Aa9y2owiVkMEYEEon6VTxGG/P/x9iPsUQrmSurCUGBJyYtlFcOb/6bni30UfCd2BS
         DknsJOJg9ODW7g/eSCLpB05XnrXJCnyV6uELta0McRBrMrEbfIGZI5CUuzcbmENnwBjq
         j1RmGiWH1Lw+8ZXkYs7Dr30/keAxMyqZ8M1+ITLnLggpPU2VArZiTDmA5WBkfft0hpVh
         mpQhL/HCYpWQnKM6Hp78RThM5P7lJKUVA+A+en63APxSJaDf8uM3WG2z7ypFNCnXuuPJ
         vV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334358; x=1684926358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZj59uqTOdaKdkMKQNxt7QjTcz6A2zCcP9s8UJu1DDI=;
        b=NSG/uJXiIHd4+O7ukZiPu4ONW+lqmGBqhLNrZqO0js1MSXu/R54degUtIc7g5w3HWo
         jy+RsEubhZAQG5y6rjhVFuhRVv1wwMw5cqDqd/YLuwTuzQ/p3zjG81R1XxQEx1sKQh1O
         3u8i8TzoIFiD2uOnf1y4KLUU2UK5rNd/Ba7yJkx2/uXPQSLtcsixKMK+UcZgNikKmadY
         if3vjmft7YKGJxllqd/mm0p49IiBoQxql97lZXzHOYBB1tqBpMKXrzYhJE5DYUywbUBm
         cmhaN7c5mSvW9t+KhsFLilq1qlhVzQve/0ZiuLRcOGXPrCugBbXmRsvxXlprEek5UWdb
         oyOg==
X-Gm-Message-State: AAQBX9cDbXI0M5DlNivcmGjVuyQwAYqUitB31MFaRPTI6gYs6ZLZ4VH4
        6pJs9y2TKd4NyNhYtfCiu4L9tA==
X-Google-Smtp-Source: AKy350YhYRv5sMtVVohwyL245tnW0pCD6Z2DlyL3HToCmUoG6urioic7WTu1a9webYA2k3wDhN+1jg==
X-Received: by 2002:a17:902:d4ca:b0:1a6:6edd:d143 with SMTP id o10-20020a170902d4ca00b001a66eddd143mr15868427plg.6.1682334358441;
        Mon, 24 Apr 2023 04:05:58 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902694700b0019c91989a1csm6364544plt.300.2023.04.24.04.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:05:58 -0700 (PDT)
From:   Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
To:     gregkh@linuxfoundation.org, cmllamas@google.com
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: [PATCH v2 2/2] Binder: Add async from to transaction record
Date:   Mon, 24 Apr 2023 19:05:15 +0800
Message-Id: <0c1e8bd37c68dd1518bb737b06b768cde9659386.1682333709.git.zhangchuang3@xiaomi.com>
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

This commit adds support for getting the pid and tid information of
the sender for asynchronous transfers in binderfs transfer records.
In previous versions, it was not possible to obtain this information
from the transfer records. While this information may not be necessary
for all use cases, it can be useful in some scenarios.

Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>
---
 drivers/android/binder.c          | 6 ++++--
 drivers/android/binder_internal.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b6413652906e..6674619845e0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3172,6 +3172,8 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
+	t->from_pid = proc->pid;
+	t->from_tid = thread->pid;
 	t->sender_euid = task_euid(proc->tsk);
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
@@ -5940,8 +5942,8 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 	seq_printf(m,
 		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d elapsed %lldms",
 		   prefix, t->debug_id, t,
-		   t->from ? t->from->proc->pid : 0,
-		   t->from ? t->from->pid : 0,
+		   t->from_pid,
+		   t->from_tid,
 		   to_proc ? to_proc->pid : 0,
 		   t->to_thread ? t->to_thread->pid : 0,
 		   t->code, t->flags, t->priority, t->need_reply,
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 92e64007f2b0..7270d4d22207 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -515,6 +515,8 @@ struct binder_transaction {
 	int debug_id;
 	struct binder_work work;
 	struct binder_thread *from;
+	pid_t from_pid;
+	pid_t from_tid;
 	struct binder_transaction *from_parent;
 	struct binder_proc *to_proc;
 	struct binder_thread *to_thread;
-- 
2.34.1

