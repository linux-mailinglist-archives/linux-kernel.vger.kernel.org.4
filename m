Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02306E678C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjDROxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDROxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FFB46E;
        Tue, 18 Apr 2023 07:53:29 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6sWjK/1vBRPdFiB0bWblioUbBh8IBBuVDZSPm6isq4=;
        b=JL7SbDfBmTHRaOkrlEAAhpQst0PY37zwQTd19smMl+zbXLcPoQ0RKSOs9Sqv6UjkO3zqTj
        K9xj0s6jPT5JRfndwXDz0XBK3QZdevyIxucsDVzMv72q4K+Mr0eOZYNTmweKnxZrocVLbz
        IoVc5pl1mRsE+TAbEqaBFmxxI+YUpC58DICyUOg5BbQ/SWMtBkHNtXB00jR3WpiD+zMp7+
        Il7WpojK3rZ2cTpCKUEJdzMMSmXQwwl+l52ag9p6T9nlDzyeg9+hLyIcx04PSvdPbUArEJ
        frodeNKL3b5WEzO6QCG5IHhUrhp7q7MPEGOuj9vtKv0vGF5sIA+UiEqHlcdLKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6sWjK/1vBRPdFiB0bWblioUbBh8IBBuVDZSPm6isq4=;
        b=SaTiNSB11xZ+fzSJ63tz6T89byFobuZiIxk7P/VtBkzjMTFlYx4QXeqU5F9Cd30C/eIhgv
        LQi+CNeSh//+xLAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/proc: Assert
 clock_gettime(CLOCK_BOOTTIME) VS /proc/uptime monotonicity
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-9-frederic@kernel.org>
References: <20230222144649.624380-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960725.404.16948283844933816567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     263dda24fff0957f6b0a9abde2809122f7f0fad8
Gitweb:        https://git.kernel.org/tip/263dda24fff0957f6b0a9abde2809122f7f0fad8
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:13 +02:00

selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME) VS /proc/uptime monotonicity

The first field of /proc/uptime relies on the CLOCK_BOOTTIME clock which
can also be fetched from clock_gettime() API.

Improve the test coverage while verifying the monotonicity of
CLOCK_BOOTTIME accross both interfaces.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230222144649.624380-9-frederic@kernel.org

---
 tools/testing/selftests/proc/proc-uptime-001.c | 21 ++++++++++++----
 tools/testing/selftests/proc/proc-uptime-002.c | 22 +++++++++++++----
 tools/testing/selftests/proc/proc-uptime.h     | 12 +++++++++-
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
index 35bddd9..f335eec 100644
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
index 7ad79d5..ae453da 100644
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
index ca55abe..730cce4 100644
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
