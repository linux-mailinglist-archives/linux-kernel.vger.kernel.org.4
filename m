Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39A67D398
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjAZRyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjAZRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:54:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0545B583;
        Thu, 26 Jan 2023 09:54:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso6052760pjj.1;
        Thu, 26 Jan 2023 09:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaOZQvWhqFGfMeSz4AFcJuI7rpVT7E7rM49XqO7Em38=;
        b=B/hYSsq9sCErp5rDPvVr4tJZvj+AMACENONgac2ZHeKYTg5HcOk8v/Ra4+sLpoHDCN
         sf0Vc3OFvtz84eaLWSTvobQmwPBtll1NGXXWhsN6j7VXK6QJWGPc2q7Ca4n0R9e+kZhK
         3rbkmHSDCRJrv6xtcM9b20P/NAcAb8uputKsq9cNv2RKYylLLv6bginLr6Nu+azutNNa
         UFRODEVRGFwjY4anWiVS0tixCyjhXTMlpZbRVbyIFNF0CodKJReJvltx1bQbPa2fDSgh
         3GJBgQm3aqx6L6X052/CPnlDgoc8RnlIb571T9NI4rx3YP87S3mKzIZHRuIrP8Rnba+O
         A6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaOZQvWhqFGfMeSz4AFcJuI7rpVT7E7rM49XqO7Em38=;
        b=RDTG2bhzOt8ZJxvQeDFiCsae3fVwTefxCQhIOTaCG+8pj22S/k1tzReNtiOb+pUKjd
         rNKy/7pxpQ6fRKGcnaWfU8OJqiogJBYfw82UZMYwqEqMC/y9/27UcOSsjfBxSxLUvopB
         ziA+tq7ZPZnHFCCDSX5zv1gEYWz7kQGpIR5jpL3D5NTMM/i/nqPUDhdkMV3EF24DNfJj
         JBhCf2HP5v2kcYMG+UIGKa2gYqqlEUl22akrgRpBLLbjc4v6HQ8hkpgO4hLvy0w9Y5/Y
         /1YpP5TLBV06hUW/2vkOhP0feI6jrkq2kZbHrEFA59/KFQysppSYlKYnFKyugyt6qGZS
         SNbQ==
X-Gm-Message-State: AO0yUKUPDynPaO0pbLE8Yt1g5Wr6HTmpgy6RtsW8/OC2I2geP3+7sKgF
        TgzBWF251gCxcn8f/U3vuZg=
X-Google-Smtp-Source: AK7set9O6cvVx82fGPK3KuyR93xYpfhlMkOJuPTZJ2hj314mdLTUIDVqwddhIl6jgHEVNuRjrCjH0g==
X-Received: by 2002:a17:902:e1c5:b0:193:33d4:d509 with SMTP id t5-20020a170902e1c500b0019333d4d509mr2227706pla.30.1674755640857;
        Thu, 26 Jan 2023 09:54:00 -0800 (PST)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709028f8100b001888cadf8f6sm1278794plo.49.2023.01.26.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:54:00 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v8 3/3] selftests: Add selftests for cachestat
Date:   Thu, 26 Jan 2023 09:53:56 -0800
Message-Id: <20230126175356.1582123-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126175356.1582123-1-nphamcs@gmail.com>
References: <20230126175356.1582123-1-nphamcs@gmail.com>
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
 .../selftests/cachestat/test_cachestat.c      | 260 ++++++++++++++++++
 5 files changed, 278 insertions(+)
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
index 000000000000..dc2894028eee
--- /dev/null
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -0,0 +1,260 @@
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
+static const int cstat_version = 1; /* first version */
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
+		cstat_version, &cs, 0);
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
+				cstat_version, &cs, 0);
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
+		cstat_version, &cs, 0);
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
