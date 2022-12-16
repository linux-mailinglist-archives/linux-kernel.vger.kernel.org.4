Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEC64F1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiLPTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiLPTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54AE1DF28
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u5so3420674pjy.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG5G46Dbq/DHdzwesOF9acAVNcEs0Ihso0tlt5RXEDY=;
        b=IlNGRJD0CfpCZopuQj0zx3wiL9mEdOdjBgo8LYmiixyfVsvodQD3G17SCag7559LB/
         wzsGFpoucql6ygf+0dXVQvr4S8m0LrRE1He51KvpOFCyaTJipOl8YmPoMmU2lCAJ11YC
         jNY1pyk8F81zcvT7PUaYRgg/1U6I3fDJiR0RYLB2PY/9No/UcfscBQOQQ4llZF5O6GQk
         0Rw+dZiCRftK/N0/ohUnhgXUXhghWrUXG1wcgUO5rzYZHt9AldvmZ/IW0RRc6TBJOpbj
         zNh0fixBQEjyA8NqUYtZR7Q30Ed5zuevo9RA/KCNl12jKSBjd9dcl0UeQIs4ojstqXq5
         69Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG5G46Dbq/DHdzwesOF9acAVNcEs0Ihso0tlt5RXEDY=;
        b=Pwx6RP8vJcvuKacgHzVBKyTOh/A0aATgDD2NNJDDfjpgpAmdZE7fTx1rJQP/vz41En
         qFr+BxfemE5hiB3JYUbiZTkltXEnP4N0exY9jqVBsXj/B4SBeDqDxF9OoaPSYFlEx2ai
         yqCv5dsafpoh9RU1+8Am423bL3xiO3UtWnm4w6LuRcvSNVqo5fcWuYO3jWmCkDu4ip+M
         YNQbj2rw249826u0cyvWlG3eTkAfuHweQwmOYAtKzfw9ei2PBz06Wm91uHY5IwFShr0w
         I0pG2h/CMy+H/XKJUX+23Zb13FuCnelHdPOk5a1GSNxj62szbXOK1hFNJqYrK8uX6dSv
         pUSA==
X-Gm-Message-State: ANoB5pmnzUNaWLdkTR3KaZD5iBIWnPUvlCq5Uh6fLLez67SkwxMEt02r
        550X/1LWWpJLRqwcu316TcQ=
X-Google-Smtp-Source: AA0mqf5FoztQexQfQdSJIWGJK9aDJEbyVQ/FROsDqdU0nFxl3K8eMaanyqse1wFokhcNfP6FZsw0Bw==
X-Received: by 2002:a17:902:b20c:b0:189:3308:9a2b with SMTP id t12-20020a170902b20c00b0018933089a2bmr31666146plr.7.1671218516079;
        Fri, 16 Dec 2022 11:21:56 -0800 (PST)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f34d00b0017a032d7ae4sm1986580ple.104.2022.12.16.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:21:55 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v4 4/4] selftests: Add selftests for cachestat
Date:   Fri, 16 Dec 2022 11:21:49 -0800
Message-Id: <20221216192149.3902877-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216192149.3902877-1-nphamcs@gmail.com>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
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
Also test on a shmem file (which can also be tested with huge pages
since tmpfs supports huge pages).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS                                   |   7 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cachestat/.gitignore  |   2 +
 tools/testing/selftests/cachestat/Makefile    |   8 +
 .../selftests/cachestat/test_cachestat.c      | 259 ++++++++++++++++++
 5 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/cachestat/.gitignore
 create mode 100644 tools/testing/selftests/cachestat/Makefile
 create mode 100644 tools/testing/selftests/cachestat/test_cachestat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a198da986146..792a866353ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4552,6 +4552,13 @@ S:	Supported
 F:	Documentation/filesystems/caching/cachefiles.rst
 F:	fs/cachefiles/
 
+CACHESTAT: PAGE CACHE STATS FOR A FILE
+M:	Nhat Pham <nphamcs@gmail.com>
+M:	Johannes Weiner <hannes@cmpxchg.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	tools/testing/selftests/cachestat/test_cachestat.c
+
 CADENCE MIPI-CSI2 BRIDGES
 M:	Maxime Ripard <mripard@kernel.org>
 L:	linux-media@vger.kernel.org
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
index 000000000000..fca73aaa7d14
--- /dev/null
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := test_cachestat
+
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -Wall
+CFLAGS += -lrt
+
+include ../lib.mk
diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
new file mode 100644
index 000000000000..3f5cd5695c51
--- /dev/null
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <linux/kernel.h>
+#include <linux/mman.h>
+#include <sys/mman.h>
+#include <sys/shm.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include "../kselftest.h"
+
+static const char * const dev_files[] = {
+	"/dev/zero", "/dev/null", "/dev/urandom",
+	"/proc/version", "/proc"
+};
+static const int cachestat_nr = 451;
+
+void print_cachestat(struct cachestat *cs)
+{
+	ksft_print_msg(
+	"Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicted: %lu, Recently Evicted: %lu\n",
+	cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
+	cs->nr_evicted, cs->nr_recently_evicted);
+}
+
+bool write_exactly(int fd, size_t filesize)
+{
+	char data[filesize];
+	bool ret = true;
+	int random_fd = open("/dev/urandom", O_RDONLY);
+
+	if (random_fd < 0) {
+		ksft_print_msg("Unable to access urandom.\n");
+		ret = false;
+		goto out;
+	} else {
+		int remained = filesize;
+		char *cursor = data;
+
+		while (remained) {
+			ssize_t read_len = read(random_fd, cursor, remained);
+
+			if (read_len <= 0) {
+				ksft_print_msg("Unable to read from urandom.\n");
+				ret = false;
+				goto close_random_fd;
+			}
+
+			remained -= read_len;
+			cursor += read_len;
+		}
+
+		/* write random data to fd */
+		remained = filesize;
+		cursor = data;
+		while (remained) {
+			ssize_t write_len = write(fd, cursor, remained);
+
+			if (write_len <= 0) {
+				ksft_print_msg("Unable write random data to file.\n");
+				ret = false;
+				goto close_random_fd;
+			}
+
+			remained -= write_len;
+			cursor += write_len;
+		}
+	}
+
+close_random_fd:
+	close(random_fd);
+out:
+	return ret;
+}
+
+/*
+ * Open/create the file at filename, (optionally) write random data to it
+ * (exactly num_pages), then test the cachestat syscall on this file.
+ *
+ * If test_fsync == true, fsync the file, then check the number of dirty
+ * pages.
+ */
+bool test_cachestat(const char *filename, bool write_random, bool create,
+		bool test_fsync, unsigned long num_pages, int open_flags,
+		mode_t open_mode)
+{
+	size_t PS = sysconf(_SC_PAGESIZE);
+	int filesize = num_pages * PS;
+	bool ret = true;
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
+		if (!write_exactly(fd, filesize)) {
+			ksft_print_msg("Unable to access urandom.\n");
+			ret = false;
+			goto out1;
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
+		goto out1;
+
+	} else {
+		print_cachestat(&cs);
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
+				print_cachestat(&cs);
+
+				if (cs.nr_dirty) {
+					ret = false;
+					ksft_print_msg(
+						"Number of dirty should be zero after fsync.\n");
+				}
+			} else {
+				ksft_print_msg("Cachestat (after fsync) returned non-zero.\n");
+				ret = false;
+				goto out1;
+			}
+		}
+	}
+
+out1:
+	close(fd);
+
+	if (create)
+		remove(filename);
+out:
+	return ret;
+}
+
+bool test_cachestat_shmem(void)
+{
+	size_t PS = sysconf(_SC_PAGESIZE);
+	size_t filesize = PS * 512 * 2; /* 2 2MB huge pages */
+	int syscall_ret;
+	off_t off = PS;
+	size_t compute_len = PS * 512;
+	char *filename = "tmpshmcstat";
+	struct cachestat cs;
+	bool ret = true;
+	unsigned long num_pages = compute_len / PS;
+	int fd = shm_open(filename, O_CREAT | O_RDWR, 0600);
+
+	if (fd < 0) {
+		ksft_print_msg("Unable to create shmem file.\n");
+		ret = false;
+		goto out;
+	}
+
+	if (ftruncate(fd, filesize)) {
+		ksft_print_msg("Unable to trucate shmem file.\n");
+		ret = false;
+		goto close_fd;
+	}
+
+	if (!write_exactly(fd, filesize)) {
+		ksft_print_msg("Unable to write to shmem file.\n");
+		ret = false;
+		goto close_fd;
+	}
+
+	syscall_ret = syscall(cachestat_nr, fd, off, compute_len,
+		sizeof(struct cachestat), &cs, 0);
+
+	if (syscall_ret) {
+		ksft_print_msg("Cachestat returned non-zero.\n");
+		ret = false;
+		goto close_fd;
+	} else {
+		print_cachestat(&cs);
+		if (cs.nr_cache + cs.nr_evicted != num_pages) {
+			ksft_print_msg(
+				"Total number of cached and evicted pages is off.\n");
+			ret = false;
+		}
+	}
+
+close_fd:
+	shm_unlink(filename);
+out:
+	return ret;
+}
+
+int main(void)
+{
+	int ret = 0;
+
+	for (int i = 0; i < 5; i++) {
+		const char *dev_filename = dev_files[i];
+
+		if (test_cachestat(dev_filename, false, false, false,
+			4, O_RDONLY, 0400))
+			ksft_test_result_pass("cachestat works with %s\n", dev_filename);
+		else {
+			ksft_test_result_fail("cachestat fails with %s\n", dev_filename);
+			ret = 1;
+		}
+	}
+
+	if (test_cachestat("tmpfilecachestat", true, true,
+		true, 4, O_CREAT | O_RDWR, 0400 | 0600))
+		ksft_test_result_pass("cachestat works with a normal file\n");
+	else {
+		ksft_test_result_fail("cachestat fails with normal file\n");
+		ret = 1;
+	}
+
+	if (test_cachestat_shmem())
+		ksft_test_result_pass("cachestat works with a shmem file\n");
+	else {
+		ksft_test_result_fail("cachestat fails with a shmem file\n");
+		ret = 1;
+	}
+
+	return ret;
+}
-- 
2.30.2
