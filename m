Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B469E8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBUUSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBUUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:18:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E12821D;
        Tue, 21 Feb 2023 12:18:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c5so6412600wrr.5;
        Tue, 21 Feb 2023 12:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=K4wARtPq5CBZcxNYArbgX74UmxkR18PCXKmmieiDZQ25FwASSxyRYxq4twVVJP+/KX
         w8+2CoBlO5x/2vFkFqqOkQfv4LpoTYO2E4FQsvnyEtxXGR5UNnmOIRASq5KHK+McvV7K
         wBMGYHcs1/6giwUNNqIt7ppBQ8ENj8g2B+93fKb1Xz+NC09d1NU9/OFjmIGy4WsNQvqb
         ZBAlp0QwtXS1TXBTc32WneBS+W5tUl4EnwWvmddjy2gQRfxGRTPVi/WyUaDcA3YkZSfJ
         /NTErW1rwbXbZLOXQqXeGLPE3I74167SGquNQX8iOVBxHgRmCviusLkjLz9mIFFLNGts
         LNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdtGqct+MwH2EWhlTBd073J94ebfBu7k+yd8Ehy7SG8=;
        b=uGhY/Ybm7aaD/R4RjpFrjisVmjItgyCp2QddXflXonCYwokm15+cD/b69f4elKpL+u
         6HPBpRFFaIhjs5xZR54KELrwdmFvRy8p/DQ+5sgKUeQkEFfODQ43WpffoO0O6d259oRj
         8RVgsU/+joXJk6LkceZAXUqjXYaid/FBtk3Vmv1euwntd0fPe8YaqkRpCI3hoaqHzIVi
         PwjXWZ0dlUpYjNFKg34Am+jn5EDMhoOYuufuywsn09FGrlES2RnccSn3x2N7IfHXwWB3
         CE7Zoak66njrq2NIaXgUxzG9Czu+gpHR8ulMpiq3D01eeIZwW8j9R8CN57lN7Emq43Dq
         tbFA==
X-Gm-Message-State: AO0yUKVh2DLw+VGy4sT6E3pOaAAuaj4/3IECzyzIFqltuFg28CBqmtCn
        s+COTkE5VgX++WkoPrMH1QUnIDQ+o1A8
X-Google-Smtp-Source: AK7set9cPf+v02KHuhhMk+OkCfsjAL1QkdCtLNuKBrVpa9yhtMBzT0l1shf0c6ZJ9PLexMPSxNuUzg==
X-Received: by 2002:adf:f590:0:b0:2c5:93fe:12b7 with SMTP id f16-20020adff590000000b002c593fe12b7mr4037706wro.41.1677010711373;
        Tue, 21 Feb 2023 12:18:31 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d434e000000b002c5a1bd527dsm4656080wrr.96.2023.02.21.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:18:30 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v11 1/2] syscall_user_dispatch: helper function to operate on given task
Date:   Tue, 21 Feb 2023 15:17:42 -0500
Message-Id: <20230221201740.2236-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221201740.2236-1-gregory.price@memverge.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
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

Preparatory patch ahead of set/get interfaces which will allow a
ptrace to get/set the syscall user dispatch configuration of a task.

This will simplify the set interface and consolidates error paths.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 kernel/entry/syscall_user_dispatch.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..22396b234854 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -68,8 +68,9 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
+					  unsigned long offset, unsigned long len,
+					  char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -94,15 +95,21 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		return -EINVAL;
 	}
 
-	current->syscall_dispatch.selector = selector;
-	current->syscall_dispatch.offset = offset;
-	current->syscall_dispatch.len = len;
-	current->syscall_dispatch.on_dispatch = false;
+	task->syscall_dispatch.selector = selector;
+	task->syscall_dispatch.offset = offset;
+	task->syscall_dispatch.len = len;
+	task->syscall_dispatch.on_dispatch = false;
 
 	if (mode == PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 
 	return 0;
 }
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
-- 
2.39.1

