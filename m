Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457E869CB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjBTMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBTMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B591C338
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6518560E33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56B8C433D2;
        Mon, 20 Feb 2023 12:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896915;
        bh=z6ZAk/aZqoP3M/Jdn4qB71Qde9iJsRMdQIEllZtNeXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9qKAj4HXTLmXuTAcL8mdBRliasDKZz5QoFZupa/ML1Vxlc1S+l6fMCyzCy1IAdEm
         ymVagJrjN9JFEYpyuQySH9rGKMbqt7ZSBak79l0YtAfmStxYpaY+UVCgVDtbu8UbE3
         O8Lf56aWy9eJE5FlukisaR08fzlsS8OYGVRvBvHioKtJIjKzvqkagQsR8qvUYV8Z52
         yHGVTeslR920YEHkubXVff9O39L6rWBgfhp9A9mlKnlz165J4HuXHz5xy0IoQDx2pI
         7FzTb0xk/cMipk9Jy03FjgqdHyCNstrlFOtn8FPi47dCgclKhdluyXy253ud8GJjpt
         1BRUQNQqHXfIg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 7/7] selftests/proc: Remove idle time monotonicity assertions
Date:   Mon, 20 Feb 2023 13:41:29 +0100
Message-Id: <20230220124129.519477-8-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220124129.519477-1-frederic@kernel.org>
References: <20230220124129.519477-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to broken iowait task counting design (cf: comments above
get_cpu_idle_time_us() and nr_iowait()), it is not possible to provide
the guarantee that /proc/stat or /proc/uptime display monotonic idle
time values.

Remove the selftests that verify the related wrong assumption so that
testers and maintainers don't spend more time on that.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/proc/.gitignore       |  2 -
 tools/testing/selftests/proc/Makefile         |  2 -
 .../testing/selftests/proc/proc-uptime-001.c  | 45 -----------
 .../testing/selftests/proc/proc-uptime-002.c  | 79 -------------------
 tools/testing/selftests/proc/proc-uptime.h    | 60 --------------
 5 files changed, 188 deletions(-)
 delete mode 100644 tools/testing/selftests/proc/proc-uptime-001.c
 delete mode 100644 tools/testing/selftests/proc/proc-uptime-002.c
 delete mode 100644 tools/testing/selftests/proc/proc-uptime.h

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index a156ac5dd2c6..448db45f08dc 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -13,8 +13,6 @@
 /proc-self-wchan
 /proc-subset-pid
 /proc-tid0
-/proc-uptime-001
-/proc-uptime-002
 /read
 /self
 /setns-dcache
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..22ff9341f97c 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -16,8 +16,6 @@ TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 TEST_GEN_PROGS += proc-subset-pid
 TEST_GEN_PROGS += proc-tid0
-TEST_GEN_PROGS += proc-uptime-001
-TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 TEST_GEN_PROGS += self
 TEST_GEN_PROGS += setns-dcache
diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
deleted file mode 100644
index 781f7a50fc3f..000000000000
--- a/tools/testing/selftests/proc/proc-uptime-001.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
- *
- * Permission to use, copy, modify, and distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-// Test that values in /proc/uptime increment monotonically.
-#undef NDEBUG
-#include <assert.h>
-#include <stdint.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "proc-uptime.h"
-
-int main(void)
-{
-	uint64_t start, u0, u1, i0, i1;
-	int fd;
-
-	fd = open("/proc/uptime", O_RDONLY);
-	assert(fd >= 0);
-
-	proc_uptime(fd, &u0, &i0);
-	start = u0;
-	do {
-		proc_uptime(fd, &u1, &i1);
-		assert(u1 >= u0);
-		assert(i1 >= i0);
-		u0 = u1;
-		i0 = i1;
-	} while (u1 - start < 100);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
deleted file mode 100644
index 7d0aa22bdc12..000000000000
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
- *
- * Permission to use, copy, modify, and distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-// Test that values in /proc/uptime increment monotonically
-// while shifting across CPUs.
-#undef NDEBUG
-#include <assert.h>
-#include <errno.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include <stdint.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include "proc-uptime.h"
-
-static inline int sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *m)
-{
-	return syscall(SYS_sched_getaffinity, pid, len, m);
-}
-
-static inline int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *m)
-{
-	return syscall(SYS_sched_setaffinity, pid, len, m);
-}
-
-int main(void)
-{
-	unsigned int len;
-	unsigned long *m;
-	unsigned int cpu;
-	uint64_t u0, u1, i0, i1;
-	int fd;
-
-	/* find out "nr_cpu_ids" */
-	m = NULL;
-	len = 0;
-	do {
-		len += sizeof(unsigned long);
-		free(m);
-		m = malloc(len);
-	} while (sys_sched_getaffinity(0, len, m) == -1 && errno == EINVAL);
-
-	fd = open("/proc/uptime", O_RDONLY);
-	assert(fd >= 0);
-
-	proc_uptime(fd, &u0, &i0);
-	for (cpu = 0; cpu < len * 8; cpu++) {
-		memset(m, 0, len);
-		m[cpu / (8 * sizeof(unsigned long))] |= 1UL << (cpu % (8 * sizeof(unsigned long)));
-
-		/* CPU might not exist, ignore error */
-		sys_sched_setaffinity(0, len, m);
-
-		proc_uptime(fd, &u1, &i1);
-		assert(u1 >= u0);
-		assert(i1 >= i0);
-		u0 = u1;
-		i0 = i1;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/proc/proc-uptime.h b/tools/testing/selftests/proc/proc-uptime.h
deleted file mode 100644
index dc6a42b1d6b0..000000000000
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
- *
- * Permission to use, copy, modify, and distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-#undef NDEBUG
-#include <assert.h>
-#include <errno.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-#include "proc.h"
-
-static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
-{
-	uint64_t val1, val2;
-	char buf[64], *p;
-	ssize_t rv;
-
-	/* save "p < end" checks */
-	memset(buf, 0, sizeof(buf));
-	rv = pread(fd, buf, sizeof(buf), 0);
-	assert(0 <= rv && rv <= sizeof(buf));
-	buf[sizeof(buf) - 1] = '\0';
-
-	p = buf;
-
-	val1 = xstrtoull(p, &p);
-	assert(p[0] == '.');
-	assert('0' <= p[1] && p[1] <= '9');
-	assert('0' <= p[2] && p[2] <= '9');
-	assert(p[3] == ' ');
-
-	val2 = (p[1] - '0') * 10 + p[2] - '0';
-	*uptime = val1 * 100 + val2;
-
-	p += 4;
-
-	val1 = xstrtoull(p, &p);
-	assert(p[0] == '.');
-	assert('0' <= p[1] && p[1] <= '9');
-	assert('0' <= p[2] && p[2] <= '9');
-	assert(p[3] == '\n');
-
-	val2 = (p[1] - '0') * 10 + p[2] - '0';
-	*idle = val1 * 100 + val2;
-
-	assert(p + 4 == buf + rv);
-}
-- 
2.34.1

