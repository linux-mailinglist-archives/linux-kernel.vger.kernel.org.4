Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5792560F2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiJ0Ixz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiJ0Ixw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:53:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903F15D0AA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:53:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso5608899pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxILUEhhuIRRDXNGGTClKXs5A57MKkYLhJBHPtEVeMk=;
        b=ZYH3ZRbJiHV4047FALOjGhndjJy9T8t65dSVQn/JOmOW2sm1HNdoKsxcTrqkqqU7+C
         VkJHoKNVr43ZIY0pEdWsfzXhUb0CyvZY739xAeDrC+A4wm67MUuVHcV/mhuwCrWrX/8T
         L4VwIGzT3KGYXTB5mvEjb47ReZSQg4L71Pags/pUwr+Xybpd/Axm/HyOmN758pvna57e
         OPaieyXaNhxM15T3Jsy2BZ7GZE6JiZpG8/8v4PyD1Ey8bVHqrUutUSB9IVh4ELTx3Ziu
         IqT9dyugY6GhU7pnNrpiFZlnqoFBUbX0aD6w/5koYBgyrCHXauNG5YADjr45xvSItIyH
         5xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxILUEhhuIRRDXNGGTClKXs5A57MKkYLhJBHPtEVeMk=;
        b=UaHbYHe3w6k9sKA6yA4n2bSrAxCWZMKnHeFgTwYTtVRiwr99L3NkQZ8TEW5fl8QR5j
         8OFd4vu+KntReXmNvqDv9AVRDU0xie40A4GF8RSueu2qmdoKAUOo+pGbU5dRM0rmpp2c
         K87c+yuUbTFsioIo+yT5z0SLJHC4iPhAevgrd7BnT6DaZMKoAXNvQj3Gmkiyb6we9d8Z
         s4uFLlX1mcofZuW2qEWsOESymIZWQfj8mrUhASpzKvrwA6Ue1K24zhRcqJGcqdelGvxZ
         qc6x2dfcXj82cerHMsGm/UmkEpLoYOr8VX+wPmRGVK8ZaiYEpC4EQ8jNrnoUe6f0yxW4
         cTbg==
X-Gm-Message-State: ACrzQf10OL6qsdnTNZrmzgSXKlvzgVWsQJOQ2G8M7uBAm7QCGo6nMbW3
        L6sf53tJ91Tk1t56eb1ZX3KUZoDVLlpNOQ==
X-Google-Smtp-Source: AMsMyM4MD9GHHGPojm7NBuvLtBadLwxYjuyqiWkAssSs3vadFUNVN2zZ3ZneOWUyvYxArunhfbD7MQ==
X-Received: by 2002:a17:90b:1806:b0:20d:3256:38 with SMTP id lw6-20020a17090b180600b0020d32560038mr8727249pjb.94.1666860831788;
        Thu, 27 Oct 2022 01:53:51 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a1d4100b0020dda7efe61sm2314581pju.5.2022.10.27.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:53:51 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] ftrace: fix static function tracer not working
Date:   Thu, 27 Oct 2022 16:53:43 +0800
Message-Id: <20221027085343.2388485-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Setting kernel command line parameter ftrace=function shows
nothing on the kernel built with static ftrace.

In static ftrace, ftrace_nodyn_init should be executed before
initializing tracers. While this commit `dbeafd0d6131` brings
the initialization of function tracer forward from core_initcall
where ftrace_nodyn_init still remains.

This patch puts ftrace_nodyn_init and ftrace_init together and
makes function tracer works in static ftrace.

Fixes: dbeafd0d6131 ("ftrace: Have function tracing start in early boot up")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 include/linux/ftrace.h | 6 ++++++
 init/main.c            | 1 +
 kernel/trace/ftrace.c  | 4 +---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0b61371e287b..4bdab0461b10 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -978,6 +978,12 @@ extern void ftrace_init(void);
 static inline void ftrace_init(void) { }
 #endif
 
+
+#ifndef CONFIG_FTRACE_MCOUNT_RECORD
+extern void ftrace_nodyn_init(void);
+#else
+static inline void ftrace_nodyn_init(void) { }
+#endif
 /*
  * Structure that defines an entry function trace.
  * It's already packed but the attribute "packed" is needed
diff --git a/init/main.c b/init/main.c
index 91642a4e69be..ebf8136e828a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -986,6 +986,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	trap_init();
 	mm_init();
 
+	ftrace_nodyn_init();
 	ftrace_init();
 
 	/* trace_printk can be enabled here */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 56b1a42e1937..40325ae575a5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7454,12 +7454,10 @@ struct ftrace_ops global_ops = {
 				  FTRACE_OPS_FL_PID,
 };
 
-static int __init ftrace_nodyn_init(void)
+void __init ftrace_nodyn_init(void)
 {
 	ftrace_enabled = 1;
-	return 0;
 }
-core_initcall(ftrace_nodyn_init);
 
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
 static inline void ftrace_startup_all(int command) { }
-- 
2.20.1

