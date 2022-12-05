Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BC642F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiLERwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiLERvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6B01E70C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:51:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl24so11522185plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Han8q7FoqziKRrDCsnqa8WckqolCToj11E76NTsZ6WI=;
        b=hEPkWYZKlr36zkFuUBGQYmt3IUTD8l8z6Yjwu8TNj40vcXhAKSX3UvOySIlQHS8Fqq
         Z+Sz2xOdpuUi1XqQ6wf9TDuMMIJbGWAAuwatsfpzVTtec0Ub9WRKnRo82eZyJNdY/6Wo
         T8xRy+dlnmznXSjVCmnBCW8RPMao/atFS0S8rHLzqjheoIJF3/pAaKvdRCJWeUD3OJPh
         zQ3KhRaPf6IFWA/LZ3na5eLTbVahhmR1oElaoIjwGY5LAd/sxizjsCGCAmxmCIKGxw1p
         zxcsF86E3UsuzpemuIIkBhOtgMUsd+zoSyhbcyVvXdnxVUgWDr5ISafhrEHZsFfM3C0Y
         T6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Han8q7FoqziKRrDCsnqa8WckqolCToj11E76NTsZ6WI=;
        b=TYS9c869+WbyEE6yr8savoEUnzOvnMG7ZrULAl1tstbgs2jn9VYs4++FmissLBhk3d
         XBKyw93zHlpnkmElnI7u5srhyvQVwW11addGEwIANAN1i7TIBSICoJEWlyjQPf+TRFD4
         jDDwHWMOtFs2WXIHo+bUU0g4nO25X8kFK69U/Z0PhHJYJRMkqs9g5hLNXBJyc3kMJDal
         Eoct8JP1jI53omKKBWa6uBbB0Rgk2seR4ZCJ6oBsSCWD/9lLuocZR947uug07dQqX+Jr
         hChuNHUeYPwfv+Tm5vt0YhNw2/1WLwbUdikRGzwZMKyG3te05cc4HSuJR4DFS9SjMywI
         FfIA==
X-Gm-Message-State: ANoB5pmhPWBGqYgDZjhuMPd5kacZxDmFEbMXXPhQ8u3x3VWHKJjfBTRg
        9S+KMDXa8mBruIueBnV6kH8=
X-Google-Smtp-Source: AA0mqf5lvaQy63EDV2t6S9BrgJR2GdaVOFzC/2UQZ+U6GNvKP7plvXWwuWiTfq/65vZrehbecl7LBQ==
X-Received: by 2002:a17:902:f092:b0:189:9b43:a082 with SMTP id p18-20020a170902f09200b001899b43a082mr32749897pla.95.1670262708507;
        Mon, 05 Dec 2022 09:51:48 -0800 (PST)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id r19-20020a6560d3000000b0043c732e1536sm8576715pgv.45.2022.12.05.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:51:48 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v2 4/4] selftests: Add selftests for cachestat
Date:   Mon,  5 Dec 2022 09:51:40 -0800
Message-Id: <20221205175140.1543229-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205175140.1543229-1-nphamcs@gmail.com>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
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
index 000000000000..120f42ba3a5d
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
+		sizeof(struct cachestat), &cs);
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
+				sizeof(struct cachestat), &cs);
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
