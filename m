Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8803969F70A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjBVOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBVOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEB3C781
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD4D612FC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B842CC4339C;
        Wed, 22 Feb 2023 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077234;
        bh=Y8JxDtLzBbykmpbzPSKug0UQ8gYai1KJkaFJDQJ6g9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ucf5hOIwqMVgXUZUJPSIqcTzk8UXkIhjg9lURzfKGg5BVAYGcrekCEyCjTKRHul9b
         sSWYME9oC2gyhBP8dnf2Fpdp0FuFx0ndMd1bMLNcR7f/l9pDuWktgLnxtHGPIaCAcd
         YgqyfxLG2Befj3Y2d8/wNrjyPc2/Hceb7s3qxUS3k5HrLwFAY+FAaxL/ws5IXWLu6W
         41x55tBJoa3nL1XAEkDTEIZMXro3VFn5WVxpdMV+FY7opHdqcZD49XMpSCgBMqOeWX
         0aKZZeIjeL33wBFumEr9uGShDHC/+oTQ1ZX1vujlLNHxvUyRf2biOOi14C/RtOP8eF
         +eydlKhZeJBrg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 7/8] selftests/proc: Remove idle time monotonicity assertions
Date:   Wed, 22 Feb 2023 15:46:48 +0100
Message-Id: <20230222144649.624380-8-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222144649.624380-1-frederic@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
MIME-Version: 1.0
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

Remove the assertions that verify the related wrong assumption so that
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
 tools/testing/selftests/proc/proc-uptime-001.c | 12 ++++++------
 tools/testing/selftests/proc/proc-uptime-002.c | 13 ++++++-------
 tools/testing/selftests/proc/proc-uptime.h     | 16 ++--------------
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
index 781f7a50fc3f..35bddd9dd60b 100644
--- a/tools/testing/selftests/proc/proc-uptime-001.c
+++ b/tools/testing/selftests/proc/proc-uptime-001.c
@@ -13,7 +13,9 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that values in /proc/uptime increment monotonically.
+// Test that boottime value in /proc/uptime increments monotonically.
+// We don't test idle time monotonicity due to broken iowait task
+// counting, cf: comment above get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <stdint.h>
@@ -25,20 +27,18 @@
 
 int main(void)
 {
-	uint64_t start, u0, u1, i0, i1;
+	uint64_t start, u0, u1;
 	int fd;
 
 	fd = open("/proc/uptime", O_RDONLY);
 	assert(fd >= 0);
 
-	proc_uptime(fd, &u0, &i0);
+	u0 = proc_uptime(fd);
 	start = u0;
 	do {
-		proc_uptime(fd, &u1, &i1);
+		u1 = proc_uptime(fd);
 		assert(u1 >= u0);
-		assert(i1 >= i0);
 		u0 = u1;
-		i0 = i1;
 	} while (u1 - start < 100);
 
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
index 7d0aa22bdc12..7ad79d5eaa84 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -13,8 +13,9 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that values in /proc/uptime increment monotonically
-// while shifting across CPUs.
+// Test that boottime value in /proc/uptime increments monotonically
+// while shifting across CPUs. We don't test idle time monotonicity
+// due to broken iowait task counting, cf: comment above get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
@@ -45,7 +46,7 @@ int main(void)
 	unsigned int len;
 	unsigned long *m;
 	unsigned int cpu;
-	uint64_t u0, u1, i0, i1;
+	uint64_t u0, u1;
 	int fd;
 
 	/* find out "nr_cpu_ids" */
@@ -60,7 +61,7 @@ int main(void)
 	fd = open("/proc/uptime", O_RDONLY);
 	assert(fd >= 0);
 
-	proc_uptime(fd, &u0, &i0);
+	u0 = proc_uptime(fd);
 	for (cpu = 0; cpu < len * 8; cpu++) {
 		memset(m, 0, len);
 		m[cpu / (8 * sizeof(unsigned long))] |= 1UL << (cpu % (8 * sizeof(unsigned long)));
@@ -68,11 +69,9 @@ int main(void)
 		/* CPU might not exist, ignore error */
 		sys_sched_setaffinity(0, len, m);
 
-		proc_uptime(fd, &u1, &i1);
+		u1 = proc_uptime(fd);
 		assert(u1 >= u0);
-		assert(i1 >= i0);
 		u0 = u1;
-		i0 = i1;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime.h b/tools/testing/selftests/proc/proc-uptime.h
index dc6a42b1d6b0..ca55abeb0ccc 100644
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -22,7 +22,7 @@
 
 #include "proc.h"
 
-static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
+static uint64_t proc_uptime(int fd)
 {
 	uint64_t val1, val2;
 	char buf[64], *p;
@@ -43,18 +43,6 @@ static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
 	assert(p[3] == ' ');
 
 	val2 = (p[1] - '0') * 10 + p[2] - '0';
-	*uptime = val1 * 100 + val2;
 
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
+	return val1 * 100 + val2;
 }
-- 
2.34.1

