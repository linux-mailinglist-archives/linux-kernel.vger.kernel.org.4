Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D065D14A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbjADLW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjADLWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58264E0FA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672831290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7FtdTeXSvj+IGog0ZsJoTNbFV/xfD/WPMUVexw05nU=;
        b=QG02ijiB+TH9HLUQ2zqLXPwq+fozTIfj329GSYBks+fYFNdNCoGE2glkB/2kzcoNi8VA8J
        Zt0FawNLhCc5Y48i4m+NRH6dmb4+IQ0c/2qB3ERQnBv9XcoZf8Dn0gPcjCMbc2EETDe9mI
        j+gQsCXcgk06NGRETebDUuGR3T4QkKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-iEjJYsd5Mn-gHUqutFj7nA-1; Wed, 04 Jan 2023 06:21:27 -0500
X-MC-Unique: iEjJYsd5Mn-gHUqutFj7nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC5E48027F8;
        Wed,  4 Jan 2023 11:21:26 +0000 (UTC)
Received: from lithium.redhat.com (unknown [10.39.192.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14409140EBF5;
        Wed,  4 Jan 2023 11:21:24 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, bristot@redhat.com, ebiederm@xmission.com,
        brauner@kernel.org, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        alexl@redhat.com, peterz@infradead.org, gscrivan@redhat.com
Subject: [PATCH 2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
Date:   Wed,  4 Jan 2023 12:20:50 +0100
Message-Id: <20230104112050.402652-2-gscrivan@redhat.com>
In-Reply-To: <20230104112050.402652-1-gscrivan@redhat.com>
References: <20230104112050.402652-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 tools/testing/selftests/prctl/Makefile        |  2 +-
 tools/testing/selftests/prctl/hide-self-exe.c | 94 +++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/prctl/hide-self-exe.c

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index c7923b205222..024e107b26ec 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test
+		disable-tsc-test hide-self-exe
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/hide-self-exe.c b/tools/testing/selftests/prctl/hide-self-exe.c
new file mode 100644
index 000000000000..4085a473eadf
--- /dev/null
+++ b/tools/testing/selftests/prctl/hide-self-exe.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for prctl(PR_GET_HIDE_SELF_EXE, ...) / prctl(PR_SET_HIDE_SELF_EXE, ...)
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <signal.h>
+#include <inttypes.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/wait.h>
+
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+
+#ifndef PR_SET_HIDE_SELF_EXE
+# define PR_SET_HIDE_SELF_EXE		65
+# define PR_GET_HIDE_SELF_EXE		66
+#endif
+
+int main(void)
+{
+	int status;
+	pid_t pid;
+	int ret;
+
+	ret = open("/proc/self/exe", O_RDONLY);
+	if (ret < 0) {
+		perror("open /proc/self/exe");
+		exit(EXIT_FAILURE);
+	}
+	close(ret);
+
+	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
+	if (ret != 0) {
+		perror("prctl(PR_GET_HIDE_SELF_EXE)");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
+	if (ret != 0) {
+		perror("prctl(PR_SET_HIDE_SELF_EXE)");
+		exit(EXIT_FAILURE);
+	}
+
+	/* check it doesn't fail a second time.  */
+	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
+	if (ret != 0) {
+		perror("prctl(PR_SET_HIDE_SELF_EXE)");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
+	if (ret != 1) {
+		perror("prctl(PR_GET_HIDE_SELF_EXE)");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = open("/proc/self/exe", O_RDONLY);
+	if (ret >= 0 || errno != ENOENT) {
+		perror("open /proc/self/exe succeeded");
+		exit(EXIT_FAILURE);
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		exit(EXIT_FAILURE);
+	}
+	if (pid == 0) {
+		/* Verify that it is still unreachable after fork().  */
+		ret = open("/proc/self/exe", O_RDONLY);
+		if (ret >= 0 || errno != ENOENT)
+			exit(EXIT_FAILURE);
+		close(ret);
+
+		/* HIDE_SELF_EXE is cleared after execve.  */
+		ret = system("cat /proc/self/exe > /dev/null");
+		exit(ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE);
+	}
+	if (waitpid(pid, &status, 0) != pid) {
+		perror("waitpid");
+		exit(EXIT_FAILURE);
+	}
+	if (status != 0) {
+		perror("child failed");
+		exit(EXIT_FAILURE);
+	}
+	exit(EXIT_SUCCESS);
+}
+
-- 
2.38.1

