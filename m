Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1C6A251E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBXXcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:32:20 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDB76F010;
        Fri, 24 Feb 2023 15:32:02 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id bh1so1068054plb.11;
        Fri, 24 Feb 2023 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogl86awpdsmdZqeffQnskO7M/1aafsTEVLhtpf3qa4Y=;
        b=o1JFEmoEEsE819cu2a+6E17o8mG1i8Hu1t+bGf8JtGPbKJpOluiPKHiTPbBl9/D6ZE
         ng0lGy4q+bnKaOB5WCoe7lqfpa05+o57KfZkskTYZ7IhEe8PtWrOcV6niRUELjhyeIQV
         T8VowftRoJaR6ESg7n10bnw03d3uVMmuPQGG4sdeaKmEVTztOhw0ESohOrj9utGbnK7d
         0D7RSu6WRCRAPVAoxMXGL7Co7ZjDZv3NNBdK7Ffr40FzlY9R41byJO6bUh8/fReyOVKU
         FjI6fzCL6VidT74KI90k9v87+TUttnBH2U9ly4cnTTBQhPG/Nzc1HyFSApWD+S1oq42s
         rrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ogl86awpdsmdZqeffQnskO7M/1aafsTEVLhtpf3qa4Y=;
        b=WVtqxwxg5CH2aKB2dycLeLysqWcajiOmvzdtPz9VQQGxcETVxj5BlfdLDEY7Uzh0GW
         RKehAuqXBcBielxcDZ101SarfO9FwkbJP9qk+p7/Ug+mtI88Rbm4GhlVp7Z19YgvFKB9
         XkWsL+14e985V2KKGm3fpWSGPhf7NyT67z7f4N4HkacE5TExMop4OVonKx2SyEGkU+V9
         R9NRP15FxRWlV4cKXT1oIFcXtrLwdPPoFeVc5MB2s20FwJ+saLR0yXxf96vu3w+jL+F7
         OdKcAOeVv85zw7eLD1uZif2xYxif+uqfHCqpiraEnK6rAB0Cowb3PmuQojiCUmhAejg2
         nQwA==
X-Gm-Message-State: AO0yUKU9Ls9SV3BXOPAoEH+e4271beO++f6QR5id7l13TeRnL5KxqrtQ
        +bgkWZl7qRGbgdCtQIp4/kN/s54pwxGV
X-Google-Smtp-Source: AK7set8I6VGYRH8kCoKGDb7Ha8xxPGIp4IR31x6yP24z2bLjEddpmPa6d6Ngb9E6JjJCHBmXICQAYw==
X-Received: by 2002:a17:902:c406:b0:19a:8fb9:5af1 with SMTP id k6-20020a170902c40600b0019a8fb95af1mr22520532plk.36.1677281522244;
        Fri, 24 Feb 2023 15:32:02 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019a5aa7eab0sm59680plo.54.2023.02.24.15.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:32:02 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v12 3/3] selftest,ptrace: Add selftest for syscall user dispatch config api
Date:   Fri, 24 Feb 2023 18:31:26 -0500
Message-Id: <20230224233126.1936-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224233126.1936-1-gregory.price@memverge.com>
References: <20230224233126.1936-1-gregory.price@memverge.com>
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

Validate that the following new ptrace requests work as expected

* PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG
  - returns the contents of task->syscall_dispatch if enabled

* PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG
  - sets the contents of task->syscall_dispatch

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 tools/testing/selftests/ptrace/.gitignore    |  1 +
 tools/testing/selftests/ptrace/Makefile      |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c | 72 ++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 792318aaa30c..b7dde152e75a 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 96ffa94afb91..1c631740a730 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..5297b10d25c3
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+
+#include "linux/ptrace.h"
+
+static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
+{
+	return syscall(SYS_ptrace, request, pid, addr, data);
+}
+
+TEST(get_set_sud)
+{
+	struct ptrace_sud_config config;
+	pid_t child;
+	int ret = 0;
+	int status;
+
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (child == 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	memset(&config, 0xff, sizeof(config));
+	config.mode = PR_SYS_DISPATCH_ON;
+
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = 0;
+	config.offset = 0x400000;
+	config.len = 0x1000;
+
+	ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.1

