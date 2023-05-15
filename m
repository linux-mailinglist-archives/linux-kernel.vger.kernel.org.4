Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBDE70222A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjEOD1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjEOD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:27:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8361997;
        Sun, 14 May 2023 20:27:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64395e741fcso12688226b3a.2;
        Sun, 14 May 2023 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684121226; x=1686713226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiiaLoe2FHTpcejFRmixK8pQOtJa58cAbjMGJsmgl/s=;
        b=rr80hkcjv0wdh0TWDxyo+jfz7J/dCaLoIrPfhOEfAZsmxb2C9sfdYQBYLt27Wpycly
         hAAJWHk5GTOFY06VkHnCW3Y9W9unD/aJmf+gZ1CadLq0VSE+DcGoZlPHZB0yURl9Oy0p
         zTUzWL7T8lPZx2ODFhnOAHV+sYGMR+WsYHHI/GHJMLrkMW6zaZbFOsBULsPZWekocpR6
         LamOP/q7Ux1HCELYDetYBQL0V8zN9r8oTu4qGLtKzzDv8zHhlYGvkjqqLxqKjG6gKvdP
         fjnhdZcY5ZbPSMmLjtrBgbl+3S4/FA3L1zKoeCZ4I36ljlPbdczKtaVSdL2VMHBptwGv
         naQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684121226; x=1686713226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiiaLoe2FHTpcejFRmixK8pQOtJa58cAbjMGJsmgl/s=;
        b=Ufm0CxBFYO4/ucbeBQXrkYGE9Vvu2oMN65zhdWBY+VDHeTcCOd2nz/SKdqbZ3EvS5X
         UXbjAPUg9Lm1pRqZVQzuMHkYTFNdBOY7MZ2yossp3zOB6dzKXFxRQDMdwBA7Y7ijXHQ7
         3RYrcUB6HiJI8lInndgwbwEs/DHd2SKUQBjk8ZJyCuIsG10+4y9OtGBCMFmL2KZK8Cv8
         Hq96aicVEjPhpKh+FAKp2ATUo3JEv1/DbvN+mW2vnrLdk+LFa2xFrr6bJ9U5YiPehYxM
         XYIeroZTK/7u1LLXiCYpt3bnb3wMQN1QrGud6Mug6RkAitkog8ArBQNfdsIblOh+LvL9
         984w==
X-Gm-Message-State: AC+VfDzKFttLt7SPpZ3jPi4Od8xDSDaM8OLuKXhHDNxyuSIKaOgb+8c+
        O4hF3SAa7GfCZLt0Vc1eO1A=
X-Google-Smtp-Source: ACHHUZ7rubrqnZfjbqZKzH9zWyIPQbRbwQ7rhPjKGTF915/k1w9IO7PigXoxzYe/agLc1gGJKxelqw==
X-Received: by 2002:a05:6a00:168b:b0:63d:2d7d:b6f2 with SMTP id k11-20020a056a00168b00b0063d2d7db6f2mr43084736pfc.4.1684121226572;
        Sun, 14 May 2023 20:27:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.42])
        by smtp.googlemail.com with ESMTPSA id s6-20020a632146000000b0051416609fb7sm10363825pgm.61.2023.05.14.20.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 20:27:06 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] fprobe: make fprobe_kprobe_handler recursion free
Date:   Mon, 15 May 2023 11:26:39 +0800
Message-Id: <6c428b9f74090b2780b67ca498c45aa5e8c38c44.1684120990.git.zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684120990.git.zegao@tencent.com>
References: <cover.1684120990.git.zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation calls kprobe related functions before doing
ftrace recursion check in fprobe_kprobe_handler, which opens door
to kernel crash due to stack recursion if preempt_count_{add, sub}
is traceable.

Refactor the common part out of fprobe_kprobe_handler and fprobe_
handler and call ftrace recursion detection at the very beginning,
and also mark these functions notrace so that the whole fprobe_k-
probe_handler is free from recusion. And

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..ad9a36c87ad9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -20,30 +20,22 @@ struct fprobe_rethook_node {
 	char data[];
 };
 
-static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+static inline notrace void __fprobe_handler(unsigned long ip, unsigned long
+		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct fprobe_rethook_node *fpr;
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret;
+	int ret;
 
 	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
-
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
-	}
 
 	if (fp->exit_handler) {
 		rh = rethook_try_get(fp->rethook);
 		if (!rh) {
 			fp->nmissed++;
-			goto out;
+			return;
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
@@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		else
 			rethook_hook(rh, ftrace_get_regs(fregs), true);
 	}
-out:
+}
+
+static void notrace fprobe_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	ftrace_test_recursion_unlock(bit);
+
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
-static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
+static void notrace fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	struct fprobe *fp = container_of(ops, struct fprobe, ops);
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions called before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
 		return;
 	}
+
 	kprobe_busy_begin();
-	fprobe_handler(ip, parent_ip, ops, fregs);
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+	ftrace_test_recursion_unlock(bit);
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-- 
2.40.1

