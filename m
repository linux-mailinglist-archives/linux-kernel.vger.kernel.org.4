Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE063647747
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLHU2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLHU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:28:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F2F1A393
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:28:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so2094818pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHlLt6aWAsdCI5Y5mp+WVK1u7mkTRlfHIjBLtpnt7a4=;
        b=N3M8dzC7SB5Ru5QsrRLNYoBMAzhR8GmN/iwfvDMnqWpLxUQ5lP8RABY9JHwziygBBP
         FfebVYUGm7o42AdWO7a6gOy6/5S+3SVNTwZQYJv4pREi/ZajSGsx16mpLlaDQwPl8VtK
         8Q0/Jo84C8fY43oYVQdBs8TlhKUZItSM5kPU/5htVdLs9zzKli92jymYGstdBKNAam/1
         bLeG9o5iXIW1iIoIEHYw1fJ4a312pEXcoDtZ0Mc/LrAl6cG1vdQWD79ateZ1I00fpmuS
         mPbCEQ2LbkFZIN/7mNC7C1MZKZVduua5Bf1XH/0aY7QSS5TjAqUwFw+wc+YWwkjDU1rz
         Di4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHlLt6aWAsdCI5Y5mp+WVK1u7mkTRlfHIjBLtpnt7a4=;
        b=viP3CY2qF11tkcwb5tJUPkkeM1MDHqHBgalza2cuPqcNXApLs44VrEyZTk1QgwmDa4
         RLZCt3XWPu/9pcVlTzUDIWoDMs9CIb+VwLVQzJh2fyQcYjIB40FeynW2vEbBtpPXrzIH
         tZ//jXmTfuCIsJvPmXBsz2GVwp8THHyCcTrYzvqWQUaucbjCbbzuyEG62EMhkCRAyygu
         2hSOYE+x1XaO31/BhaHPxWIdQ+L5DeqrpmorCTgfUS0ocTp69j0Jkk8IG9PMOnWpcWK0
         wy1QxboIakOfEI5ME3pcGzjt4uuh5JWmc+EJnTv4otvXkNGLpb58QfaLBB/ImHXmsVac
         lvtw==
X-Gm-Message-State: ANoB5pkym1KEXhaUKFydx/M9OFYTT19ppUpO851Z2T+FsaF2Vpzj0xsR
        rQdGNmMwt/AyFcbc2mUAWOk=
X-Google-Smtp-Source: AA0mqf7bB1fsNiUIfGt54Z28MHiEvcKog5d25ZWm3PH+b8dbVs0v+JXrmwc6bMqO4MSlV0D5vUHxMQ==
X-Received: by 2002:a62:2702:0:b0:572:8766:598b with SMTP id n2-20020a622702000000b005728766598bmr77349901pfn.21.1670531294542;
        Thu, 08 Dec 2022 12:28:14 -0800 (PST)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b00189b2b8dbedsm15105213plh.228.2022.12.08.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:28:14 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v3 4/4] selftests: Add selftests for cachestat
Date:   Thu,  8 Dec 2022 12:28:08 -0800
Message-Id: <20221208202808.908690-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221208202808.908690-1-nphamcs@gmail.com>
References: <20221208202808.908690-1-nphamcs@gmail.com>
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

Test cachestat on a newly created file, /dev/ files, and /proc/ files.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   7 +
 .../selftests/cachestat/test_cachestat.c      | 186 ++++++++++++++++++
 5 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index baa081a1fe52..1b8bc6151e86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4558,6 +4558,7 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/cachestat.c
+F:	tools/testing/selftests/cachestat/test_cachestat.c

 CADENCE MIPI-CSI2 BRIDGES
 M:	Maxime Ripard <mripard@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 0464b2c6c1e4..3cad0b38c5c2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -4,6 +4,7 @@ TARGETS += amd-pstate
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
+TARGETS += cachestat
 TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += clone3
diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
new file mode 100644
index 000000000000..d6c30b43a4bb
--- /dev/null
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_cachestat
diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
new file mode 100644
index 000000000000..04e84fd7d8ce
--- /dev/null
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := test_cachestat
+
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -Wall
+
+include ../lib.mk
diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
new file mode 100644
index 000000000000..bb767147d08f
--- /dev/null
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/kernel.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+
+#include "../kselftest.h"
+
+static const char * const dev_files[] = {
+	"/dev/zero", "/dev/null", "/dev/urandom",
+	"/proc/version", "/proc"
+};
+
+/*
+ * Open/create the file at filename, (optionally) write random data to it
+ * (exactly num_pages), then test the cachestat syscall on this file.
+ *
+ * If test_fsync == true, fsync the file, then check the number of dirty
+ * pages.
+ */
+bool test_cachestat(const char *filename, bool write_random, bool create,
+	bool test_fsync, int num_pages, int open_flags, mode_t open_mode)
+{
+	int cachestat_nr = 451;
+	size_t PS = sysconf(_SC_PAGESIZE);
+	int filesize = num_pages * PS;
+	bool ret = true;
+	int random_fd;
+	long syscall_ret;
+	struct cachestat cs;
+
+	int fd = open(filename, open_flags, open_mode);
+
+	if (fd == -1) {
+		ksft_print_msg("Unable to create/open file.\n");
+		goto out;
+	} else {
+		ksft_print_msg("Create/open %s\n", filename);
+	}
+
+	if (write_random) {
+		char data[filesize];
+
+		random_fd = open("/dev/urandom", O_RDONLY);
+
+		if (random_fd < 0) {
+			ksft_print_msg("Unable to access urandom.\n");
+			ret = false;
+			goto out1;
+		} else {
+			int remained = filesize;
+			char *cursor = data;
+
+			while (remained) {
+				ssize_t read_len = read(random_fd, cursor, remained);
+
+				if (read_len <= 0) {
+					ksft_print_msg("Unable to read from urandom.\n");
+					ret = false;
+					goto out2;
+				}
+
+				remained -= read_len;
+				cursor += read_len;
+			}
+
+			/* write random data to fd */
+			remained = filesize;
+			cursor = data;
+			while (remained) {
+				ssize_t write_len = write(fd, cursor, remained);
+
+				if (write_len <= 0) {
+					ksft_print_msg("Unable write random data to file.\n");
+					ret = false;
+					goto out2;
+				}
+
+				remained -= write_len;
+				cursor += write_len;
+			}
+		}
+	}
+
+	syscall_ret = syscall(cachestat_nr, fd, 0, filesize,
+		sizeof(struct cachestat), &cs, 0);
+
+	ksft_print_msg("Cachestat call returned %ld\n", syscall_ret);
+
+	if (syscall_ret) {
+		ksft_print_msg("Cachestat returned non-zero.\n");
+		ret = false;
+
+		if (write_random)
+			goto out2;
+		else
+			goto out1;
+
+	} else {
+		ksft_print_msg(
+			"Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicted: %lu, Recently Evicted: %lu\n",
+			cs.nr_cache, cs.nr_dirty, cs.nr_writeback,
+			cs.nr_evicted, cs.nr_recently_evicted);
+
+		if (write_random) {
+			if (cs.nr_cache + cs.nr_evicted != num_pages) {
+				ksft_print_msg(
+					"Total number of cached and evicted pages is off.\n");
+				ret = false;
+			}
+		}
+	}
+
+	if (test_fsync) {
+		if (fsync(fd)) {
+			ksft_print_msg("fsync fails.\n");
+			ret = false;
+		} else {
+			syscall_ret = syscall(cachestat_nr, fd, 0, filesize,
+				sizeof(struct cachestat), &cs, 0);
+
+			ksft_print_msg("Cachestat call (after fsync) returned %ld\n",
+				syscall_ret);
+
+			if (!syscall_ret) {
+				ksft_print_msg(
+					"Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicted: %lu, Recently Evicted: %lu\n",
+					cs.nr_cache, cs.nr_dirty, cs.nr_writeback,
+					cs.nr_evicted, cs.nr_recently_evicted);
+
+				if (cs.nr_dirty) {
+					ret = false;
+					ksft_print_msg(
+						"Number of dirty should be zero after fsync.\n");
+				}
+			} else {
+				ksft_print_msg("Cachestat (after fsync) returned non-zero.\n");
+				ret = false;
+
+				if (write_random)
+					goto out2;
+				else
+					goto out1;
+			}
+		}
+	}
+
+out2:
+	if (write_random)
+		close(random_fd);
+out1:
+	close(fd);
+
+	if (create)
+		remove(filename);
+out:
+	return ret;
+}
+
+int main(void)
+{
+	for (int i = 0; i < 5; i++) {
+		const char *dev_filename = dev_files[i];
+
+		if (test_cachestat(dev_filename, false, false, false,
+			4, O_RDONLY, 0400))
+			ksft_test_result_pass("cachestat works with %s\n", dev_filename);
+		else
+			ksft_test_result_fail("cachestat fails with %s\n", dev_filename);
+	}
+
+	if (test_cachestat("tmpfilecachestat", true, true,
+		true, 4, O_CREAT | O_RDWR, 0400 | 0600))
+		ksft_test_result_pass("cachestat works with a normal file\n");
+	else
+		ksft_test_result_fail("cachestat fails with normal file\n");
+
+	return 0;
+}
--
2.30.2
