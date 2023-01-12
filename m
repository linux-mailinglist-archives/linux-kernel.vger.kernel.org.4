Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310A667CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjALRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjALRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:45:57 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500952749;
        Thu, 12 Jan 2023 09:04:35 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 52CCC78036C;
        Thu, 12 Jan 2023 18:04:17 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: [RFC PATCH 4/4] testing: add a getrandom() GRND_TIMESTAMP vDSO demonstration/benchmark
Date:   Thu, 12 Jan 2023 18:02:36 +0100
Message-Id: <ee7dec1ec967c38080c44f73246e9b8636b8b624.1673539719.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1673539719.git.ydroneaud@opteya.com>
References: <cover.1673539719.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link: https://lore.kernel.org/all/cover.1673539719.git.ydroneaud@opteya.com/
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 tools/testing/crypto/getrandom/Makefile       |   4 +
 .../testing/crypto/getrandom/test-getrandom.c | 307 ++++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 tools/testing/crypto/getrandom/Makefile
 create mode 100644 tools/testing/crypto/getrandom/test-getrandom.c

diff --git a/tools/testing/crypto/getrandom/Makefile b/tools/testing/crypto/getrandom/Makefile
new file mode 100644
index 000000000000..1370b6f1ae94
--- /dev/null
+++ b/tools/testing/crypto/getrandom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+test-getrandom: test-getrandom.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -I ../../../../usr/include/ -O2 -Wall -Wextra -o $@ $^ -ldl
diff --git a/tools/testing/crypto/getrandom/test-getrandom.c b/tools/testing/crypto/getrandom/test-getrandom.c
new file mode 100644
index 000000000000..311eef503f50
--- /dev/null
+++ b/tools/testing/crypto/getrandom/test-getrandom.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Yann Droneaud. All Rights Reserved.
+ */
+
+#include <dlfcn.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/random.h>
+
+static size_t pagesz;
+static size_t discarded;
+
+typedef ssize_t(*getrandom_fn) (void *, size_t, int);
+
+static bool grnd_timestamp;
+static getrandom_fn getrandom_vDSO;
+
+static ssize_t getrandom_syscall(void *buffer, size_t size, int flags)
+{
+	return syscall(SYS_getrandom, buffer, size, flags);
+}
+
+static ssize_t timestamp(getrandom_fn _getrandom, uint64_t *grnd_ts,
+			 size_t size)
+{
+	ssize_t ret;
+
+	ret = _getrandom(grnd_ts, size, GRND_TIMESTAMP);
+	if (ret < 0) {
+		fprintf(stderr,
+			"getrandom(,,GRND_TIMESTAMP) failed: %ld (%s)\n", -ret,
+			strerror((int)-ret));
+		return -1;
+	}
+
+	return ret;
+}
+
+static void fetch(getrandom_fn _getrandom, void *buffer, size_t size)
+{
+	ssize_t ret;
+
+	ret = _getrandom(buffer, size, 0);
+	if (ret < 0) {
+		fprintf(stderr, "getrandom(,,0) failed: %ld (%s)\n", -ret,
+			strerror((int)-ret));
+		exit(EXIT_FAILURE);
+	}
+}
+
+struct rng {
+	uint64_t grnd_ts;
+	size_t availsz;		/* available bytes in buffer */
+	size_t buffersz;	/* buffer size */
+	uint8_t buffer[];
+};
+
+static struct rng *rng;
+
+static void init_rng(void)
+{
+	int r;
+	ssize_t s;
+	void *p;
+
+	r = getpagesize();
+	if (r == -1) {
+		fprintf(stderr, "getpagesize() failed: %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+
+	pagesz = (size_t)r;
+
+	p = mmap(NULL, pagesz, PROT_READ | PROT_WRITE,
+		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (p == MAP_FAILED) {
+		fprintf(stderr, "mmap() failed: %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+
+	r = madvise(p, pagesz, MADV_DONTDUMP | MADV_WIPEONFORK);
+	if (r == -1) {
+		fprintf(stderr, "madvise() failed: %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
+
+	r = mlock(p, pagesz);
+	if (r == -1)
+		fprintf(stderr, "mlock() failed: %d\n", errno);
+
+	rng = p;
+
+	s = timestamp(getrandom_syscall, &rng->grnd_ts, sizeof(rng->grnd_ts));
+	if (s == -1)
+		return;
+
+	printf("getrandom() support GRND_TIMESTAMP\n");
+
+	grnd_timestamp = true;
+}
+
+static void init_vdso(void)
+{
+	void *h;
+	void *p;
+
+	h = dlopen("linux-vdso.so.1", RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!h) {
+		fprintf(stderr, "failed to open vDSO: %s\n", dlerror());
+		return;
+	}
+
+	p = dlsym(h, "__vdso_getrandom");
+	if (!p) {
+		fprintf(stderr, "getrandom() not found in vDSO: %s\n",
+			dlerror());
+		return;
+	}
+
+	printf("found getrandom() in vDSO at %p\n", p);
+
+	getrandom_vDSO = p;
+}
+
+/*
+ * 1) check timestamp isn't expired
+ * 2) if expired or there's not enough data in buffer
+ *     a) if expired, reset buffer size,
+ *     b) fetch new random stream
+ *     c) check timestamp
+ *     d) if expired, reset buffer size, go to b)
+ *
+ */
+static void ensure(getrandom_fn _getrandom, size_t request)
+{
+	ssize_t r;
+
+	r = timestamp(_getrandom, &rng->grnd_ts, sizeof(rng->grnd_ts));
+	switch (r) {
+	case 0:	/* timestamp didn't change */
+		/* enough available random bytes ? */
+		if (rng->availsz >= request)
+			return;
+
+		/* increase buffer size when drained */
+		if (rng->buffersz < pagesz - sizeof(*rng))
+			rng->buffersz *= 2;
+
+		/* no less than 32 */
+		if (rng->buffersz < 32)
+			rng->buffersz = 32;
+
+		/* no more than a full page minus the rng structure */
+		if (rng->buffersz > pagesz - sizeof(*rng))
+			rng->buffersz = pagesz - sizeof(*rng);
+
+		break;
+
+	case sizeof(rng->grnd_ts):	/* timestamp did change, random bytes must be discarded */
+		rng->buffersz = 32;	/* reset size */
+		break;
+
+	default:
+		fprintf(stderr, "unexpected timestamp size %zd\n", r);
+		exit(EXIT_FAILURE);
+	}
+
+	/* keep fetching if timestamp is updated */
+	for (;;) {
+		if (rng->availsz)
+			discarded += rng->availsz;
+
+		fetch(_getrandom, rng->buffer, rng->buffersz);
+		rng->availsz = rng->buffersz;
+
+		r = timestamp(_getrandom, &rng->grnd_ts, sizeof(rng->grnd_ts));
+
+		switch (r) {
+		case 0:	/* timestamp didn't change between previous check and last fetch */
+			return;
+
+		case sizeof(rng->grnd_ts):	/* timestamp did change, random bytes just fetched must be discarded */
+			rng->buffersz = 32;	/* reset size */
+			continue;	/* retry again */
+
+		default:
+			fprintf(stderr, "unexpected timestamp size %zd\n", r);
+			exit(EXIT_FAILURE);
+		}
+	}
+}
+
+/* arc4random() */
+static void get_direct(getrandom_fn _getrandom)
+{
+	uint32_t v;
+	fetch(_getrandom, &v, sizeof(v));
+}
+
+static void get_pooled(getrandom_fn _getrandom)
+{
+	ensure(_getrandom, sizeof(uint32_t));
+	rng->availsz -= sizeof(uint32_t);
+}
+
+static inline struct timespec timespec_sub(const struct timespec *a,
+					   const struct timespec *b)
+{
+	struct timespec res;
+
+	res.tv_sec = a->tv_sec - b->tv_sec;
+	res.tv_nsec = a->tv_nsec - b->tv_nsec;
+	if (res.tv_nsec < 0) {
+		res.tv_sec--;
+		res.tv_nsec += 1000000000L;
+	}
+
+	return res;
+}
+
+#define SAMPLES 13
+#define VALUES (16 * 1024 * 1024)
+
+static void test_direct(getrandom_fn _getrandom, const char *method)
+{
+	struct timespec start, end, diff;
+
+	for (int i = 0; i < SAMPLES; i++) {
+		clock_gettime(CLOCK_MONOTONIC, &start);
+
+		for (uint32_t j = 0; j < VALUES; j++)
+			get_direct(_getrandom);
+
+		clock_gettime(CLOCK_MONOTONIC, &end);
+
+		diff = timespec_sub(&end, &start);
+
+		printf("== direct %s getrandom(), %u u32, %lu.%09lu s, %.3f M u32/s, %.3f ns/u32\n",
+		       method, VALUES, diff.tv_sec, diff.tv_nsec,
+		       VALUES / (1000000 *
+				 (diff.tv_sec +
+				  (double)diff.tv_nsec / 1000000000UL)),
+		       (double)(diff.tv_sec * 1000000000UL +
+				diff.tv_nsec) / VALUES);
+	}
+}
+
+static void test_pooled(getrandom_fn _getrandom, const char *method)
+{
+	struct timespec start, end, diff;
+
+	for (int i = 0; i < SAMPLES; i++) {
+		discarded = 0;
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+
+		for (uint32_t j = 0; j < VALUES; j++)
+			get_pooled(_getrandom);
+
+		clock_gettime(CLOCK_MONOTONIC, &end);
+
+		diff = timespec_sub(&end, &start);
+
+		printf("== pooled %s getrandom(), %u u32, %lu.%09lu s, %.3f M u32/s, %.3f ns/u32, (%zu bytes discarded)\n",
+		       method, VALUES, diff.tv_sec, diff.tv_nsec,
+		       VALUES / (1000000 *
+				 (diff.tv_sec +
+				  (double)diff.tv_nsec / 1000000000UL)),
+		       (double)(diff.tv_sec * 1000000000UL +
+				diff.tv_nsec) / VALUES,
+		       discarded);
+	}
+}
+
+int main(void)
+{
+	printf("getrandom(,,GRND_TIMESTAMP) test\n");
+
+	init_rng();
+	init_vdso();
+
+	while (1) {
+		test_direct(getrandom_syscall, "syscall");
+
+		if (getrandom_vDSO)
+			test_direct(getrandom_vDSO, "vDSO");
+
+		if (grnd_timestamp)
+			test_pooled(getrandom_syscall, "syscall");
+
+		if (getrandom_vDSO && grnd_timestamp)
+			test_pooled(getrandom_vDSO, "vDSO");
+	}
+
+	return 0;
+}
-- 
2.37.2

