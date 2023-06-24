Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA073CB12
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFXNiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjFXNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:38:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E321FCE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:38:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-54f73f09765so910491a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687613894; x=1690205894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBNJeoxuxKW0ngxLaIhEfBBILdjbuZVFIvRZIaQ+D1o=;
        b=MscyhnW3MCMF6oT7zsV8MjsOV3Exbbxo82on4ewasF67ViEwZKRzzhunGT4ApAeoVC
         fu1rFctvDo8RTDHPiu0q1tiwMahRLV2Gp/0d7O+IvuzWPFOY9BWFGyX4XQ7bCDtIY1R+
         4hph2eUFR5Z+unOGzFmTRPWv7QPpEzHT9/DevOYseNTOdLMBsYf/+drI2xb4cPfviMqx
         MCMu3McW623IAC4mEmazp7Rh/YDITIzt9jzfFYlB4yOzar43ADLWuyDxmCvXsur4H1RY
         nPon4pfbGUdWtvoAkz0eoMsUs0pHA/E3ZGwkmP0MctbiwB960fQ+ejrU2htBf4fUqvtA
         w00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687613894; x=1690205894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBNJeoxuxKW0ngxLaIhEfBBILdjbuZVFIvRZIaQ+D1o=;
        b=kLCWulNwQE+43tLSyu+q9Zw5qBSQBU1Fh0auTwK9g9TScAH28F3XeH10/ytEVSOPxN
         f42jh1isKhkGmD9roE0o1rZFAvRUbpkD6PxkN09vqYScYmvhJUdz+2S7H/9MqVvv7UsJ
         rfISg+xh3kW5CGaP1zuEK/l9LTXuX/zUryUjxY/kshQbFSqkgtIix+kFaUwf8XWe9rPz
         N9ddEKTfCCiRs+25vOH9ZRQxZRCJeIuRy3zCf+kUqKsPVCC2NY0brGpdmuREaSjv3AkM
         YAB5UfXk7q8tvXLkTua+9wCS9MWF0t8MCvjfi5NaS6dbgATBR9uLt4q1dthH1lQaw4p1
         HOWA==
X-Gm-Message-State: AC+VfDx8UBYyZACYfJgPvLzRIOuwjn8Y8n/FOfL3yHH+M8Y5VYzbEY7x
        RwEq2B+/dCcdRXI+8MP8LWKcOdMtHdA=
X-Google-Smtp-Source: ACHHUZ6DTPP5LYhoCbUjMLO0Mt7Ur3q/4ntF8WfS9LaCnTj7skV9sunuJIuSRyepDxPqugEX03DBPw==
X-Received: by 2002:a17:90a:35d:b0:25c:2260:9f5c with SMTP id 29-20020a17090a035d00b0025c22609f5cmr16477389pjf.34.1687613893609;
        Sat, 24 Jun 2023 06:38:13 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f5f:ba7d:3496:54ff])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090aea9700b0025dc5749b4csm578942pjz.21.2023.06.24.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:38:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: dump userspace code around the exception PC
Date:   Sat, 24 Jun 2023 06:38:08 -0700
Message-Id: <20230624133808.621805-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of other debug facilities dumping user code around the
unhandled exception address may help debugging the issue.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig.debug  |  8 ++++++++
 arch/xtensa/kernel/traps.c | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/xtensa/Kconfig.debug b/arch/xtensa/Kconfig.debug
index 83cc8d12fa0e..e84172a7763c 100644
--- a/arch/xtensa/Kconfig.debug
+++ b/arch/xtensa/Kconfig.debug
@@ -38,3 +38,11 @@ config PRINT_STACK_DEPTH
 	help
 	  This option allows you to set the stack depth that the kernel
 	  prints in stack traces.
+
+config PRINT_USER_CODE_ON_UNHANDLED_EXCEPTION
+	bool "Dump user code around unhandled exception address"
+	help
+	  Enable this option to display user code around PC of the unhandled
+	  exception (starting at address aligned on 16 byte boundary).
+	  This may simplify finding faulting code in the absence of other
+	  debug facilities.
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index a2a9a460ec9e..17eb180eff7c 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -175,6 +175,23 @@ __die_if_kernel(const char *str, struct pt_regs *regs, long err)
 		die(str, regs, err);
 }
 
+#ifdef CONFIG_PRINT_USER_CODE_ON_UNHANDLED_EXCEPTION
+static inline void dump_user_code(struct pt_regs *regs)
+{
+	char buf[32];
+
+	if (copy_from_user(buf, (void __user *)(regs->pc & -16), sizeof(buf)) == 0) {
+		print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
+			       32, 1, buf, sizeof(buf), false);
+
+	}
+}
+#else
+static inline void dump_user_code(struct pt_regs *regs)
+{
+}
+#endif
+
 /*
  * Unhandled Exceptions. Kill user task or panic if in kernel space.
  */
@@ -190,6 +207,7 @@ void do_unhandled(struct pt_regs *regs)
 			    "\tEXCCAUSE is %ld\n",
 			    current->comm, task_pid_nr(current), regs->pc,
 			    regs->exccause);
+	dump_user_code(regs);
 	force_sig(SIGILL);
 }
 
-- 
2.30.2

