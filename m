Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177669F705
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjBVOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjBVOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249F38EB6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC6C2B815C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60642C4339E;
        Wed, 22 Feb 2023 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077237;
        bh=3ds3/cTbh0yU84XZ4nwDnOjFVf7ivtfK68suy9ql4Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/SXFOf0UVWM/2lQuF9pRCQJD7/Qjp1ltLC72UF7I04QPqLkTNXiYIUbh83lE8D6P
         qI/1/V3Rz/i9ea+1Q7TIPhxLJC0epNbZysQD2oisZBi73sQYcCq8mBgRma8Mv4S8KI
         79IkEWklYyfvR/pp5se81yl7XOoFJZ50LTqpYdgtEHNd4klwuarw0kxpeDfNnr3zmJ
         LqBU2SnACBrx2yZ5SKNg3m9UjybeHnfUTlc8GatJcYbBnJE3YsVNSgvPMSJLS7FHg/
         M9dIgk/6Kf7kqCTGT7u45sBjDL//mMflCmQpOjNH+k/XnbdQf2cyCbbY1Jg6OGcI9E
         FF1NHlqN4bxfw==
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
Subject: [PATCH 8/8] selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME) VS /proc/uptime monotonicity
Date:   Wed, 22 Feb 2023 15:46:49 +0100
Message-Id: <20230222144649.624380-9-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222144649.624380-1-frederic@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first field of /proc/uptime relies on the CLOCK_BOOTTIME clock which
can also be fetched from clock_gettime() API.

Improve the test coverage while verifying the monotonicity of
CLOCK_BOOTTIME accross both interfaces.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../testing/selftests/proc/proc-uptime-001.c  | 21 ++++++++++++++----
 .../testing/selftests/proc/proc-uptime-002.c  | 22 +++++++++++++++----
 tools/testing/selftests/proc/proc-uptime.h    | 12 ++++++++++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
index 35bddd9dd60b..f335eec5067e 100644
--- a/tools/testing/selftests/proc/proc-uptime-001.c
+++ b/tools/testing/selftests/proc/proc-uptime-001.c
@@ -13,9 +13,9 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that boottime value in /proc/uptime increments monotonically.
-// We don't test idle time monotonicity due to broken iowait task
-// counting, cf: comment above get_cpu_idle_time_us()
+// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
+// monotonically. We don't test idle time monotonicity due to broken iowait
+// task counting, cf: comment above get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <stdint.h>
@@ -27,7 +27,7 @@
 
 int main(void)
 {
-	uint64_t start, u0, u1;
+	uint64_t start, u0, u1, c0, c1;
 	int fd;
 
 	fd = open("/proc/uptime", O_RDONLY);
@@ -35,10 +35,23 @@ int main(void)
 
 	u0 = proc_uptime(fd);
 	start = u0;
+	c0 = clock_boottime();
+
 	do {
 		u1 = proc_uptime(fd);
+		c1 = clock_boottime();
+
+		/* Is /proc/uptime monotonic ? */
 		assert(u1 >= u0);
+
+		/* Is CLOCK_BOOTTIME monotonic ? */
+		assert(c1 >= c0);
+
+		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
+		assert(c0 >= u0);
+
 		u0 = u1;
+		c0 = c1;
 	} while (u1 - start < 100);
 
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime-002.c b/tools/testing/selftests/proc/proc-uptime-002.c
index 7ad79d5eaa84..ae453daa96c1 100644
--- a/tools/testing/selftests/proc/proc-uptime-002.c
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -13,9 +13,10 @@
  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
-// Test that boottime value in /proc/uptime increments monotonically
-// while shifting across CPUs. We don't test idle time monotonicity
-// due to broken iowait task counting, cf: comment above get_cpu_idle_time_us()
+// Test that boottime value in /proc/uptime and CLOCK_BOOTTIME increment
+// monotonically while shifting across CPUs. We don't test idle time
+// monotonicity due to broken iowait task counting, cf: comment above
+// get_cpu_idle_time_us()
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
@@ -43,10 +44,10 @@ static inline int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned lo
 
 int main(void)
 {
+	uint64_t u0, u1, c0, c1;
 	unsigned int len;
 	unsigned long *m;
 	unsigned int cpu;
-	uint64_t u0, u1;
 	int fd;
 
 	/* find out "nr_cpu_ids" */
@@ -62,6 +63,8 @@ int main(void)
 	assert(fd >= 0);
 
 	u0 = proc_uptime(fd);
+	c0 = clock_boottime();
+
 	for (cpu = 0; cpu < len * 8; cpu++) {
 		memset(m, 0, len);
 		m[cpu / (8 * sizeof(unsigned long))] |= 1UL << (cpu % (8 * sizeof(unsigned long)));
@@ -70,8 +73,19 @@ int main(void)
 		sys_sched_setaffinity(0, len, m);
 
 		u1 = proc_uptime(fd);
+		c1 = clock_boottime();
+
+		/* Is /proc/uptime monotonic ? */
 		assert(u1 >= u0);
+
+		/* Is CLOCK_BOOTTIME monotonic ? */
+		assert(c1 >= c0);
+
+		/* Is CLOCK_BOOTTIME VS /proc/uptime monotonic ? */
+		assert(c0 >= u0);
+
 		u0 = u1;
+		c0 = c1;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/proc/proc-uptime.h b/tools/testing/selftests/proc/proc-uptime.h
index ca55abeb0ccc..730cce4a3d73 100644
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -19,9 +19,21 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <time.h>
 
 #include "proc.h"
 
+static uint64_t clock_boottime(void)
+{
+	struct timespec ts;
+	int err;
+
+	err = clock_gettime(CLOCK_BOOTTIME, &ts);
+	assert(err >= 0);
+
+	return (ts.tv_sec * 100) + (ts.tv_nsec / 10000000);
+}
+
 static uint64_t proc_uptime(int fd)
 {
 	uint64_t val1, val2;
-- 
2.34.1

