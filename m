Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A746E6790
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjDROxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjDROxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE38C678;
        Tue, 18 Apr 2023 07:53:29 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ITfUbOfV2vztKvWzmFN8WZkFvcN10ekh69DY+h23qs=;
        b=fBNDk/Fsjwlf/NZsXb9obBKndRsWYCVqjUeikpryrG4aJ324vw90Ie3ENAclS1fpsbhVMk
        dxRSWDkSyPpiMpXHlzvirwolVVP8GJ6eWx6WJ7m1dumoo1g38uy81Q28mVAGsicFD30J2g
        KWeZfduuP9hyZn+MRLyii1WlDadCcoN345AXXxAnfEkrx0sw1k4lEnFGNYiAI+1wiNRHhb
        ncmyoUVtA+p2cNTSKZmP9nobjhRLWjiwlMv2c/+Mbr7jkpVEdcvL4gUkhzCQUdbabngnzU
        qn8SJV/Y8XW03WAHUqzZBNXApxSTpZzwcSQHHRcn26qkcwAAfdmjQEg576uriQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ITfUbOfV2vztKvWzmFN8WZkFvcN10ekh69DY+h23qs=;
        b=7SHOyDkmtBEh1w/+U4WZzK47qGmLl5xwOLIMuX9js/XSXCOkRCLVGxjL5gyr/2+DJewgUi
        62xjWC6d5BRYJkDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/proc: Remove idle time monotonicity assertions
Cc:     Yu Liao <liaoyu15@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-8-frederic@kernel.org>
References: <20230222144649.624380-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960780.404.14266363355054554836.tip-bot2@tip-bot2>
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

Commit-ID:     270b2a679ea7be1ee2d84ea67751fb1ab15bcb20
Gitweb:        https://git.kernel.org/tip/270b2a679ea7be1ee2d84ea67751fb1ab15bcb20
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:13 +02:00

selftests/proc: Remove idle time monotonicity assertions

Due to broken iowait task counting design (cf: comments above
get_cpu_idle_time_us() and nr_iowait()), it is not possible to provide
the guarantee that /proc/stat or /proc/uptime display monotonic idle
time values.

Remove the assertions that verify the related wrong assumption so that
testers and maintainers don't spend more time on that.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230222144649.624380-8-frederic@kernel.org

---
 tools/testing/selftests/proc/proc-uptime-001.c | 12 ++++++------
 tools/testing/selftests/proc/proc-uptime-002.c | 13 ++++++-------
 tools/testing/selftests/proc/proc-uptime.h     | 16 ++--------------
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-uptime-001.c b/tools/testing/selftests/proc/proc-uptime-001.c
index 781f7a5..35bddd9 100644
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
index 7d0aa22..7ad79d5 100644
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
index dc6a42b..ca55abe 100644
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
