Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF26E358A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjDPHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPHEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:04:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B851FDA;
        Sun, 16 Apr 2023 00:04:10 -0700 (PDT)
Date:   Sun, 16 Apr 2023 07:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681628648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+f7GdkF3JQ90ONxa0bAHxG1+bv8XBIUSxJ2AMx2Jcs=;
        b=RjO8dFSOFAYWrePhcpxPCF/kqL4KX/eq3g2PbL0f9i2S+PK2tJ8DZnN6etwcDBO/f4HUyh
        TwfAaryS0nS0xuBO/F7jQYCo2Z6NL3sbubFJWKCz/jt6BjJdaX0lJYNlF5x8UG8DX1Qr6Y
        brvP/VfSninVYjCJLotLWjRcahfQIU1JnTc2TYNHjtQq1+Y1arbFbZf+0df6mX3VrFnlrC
        AU4xKmsl82STSqGK/YaunsO6B+Y16Dc5Wkk6DMEYSGFCdOcJjjrhcCzGefuhAf/l3ZrRAK
        j/hdZ6DszFl5f1VI2qE9DMZWViqWMs1GSuXzmPjTiERu8FfhwYD+QeALODfynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681628648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+f7GdkF3JQ90ONxa0bAHxG1+bv8XBIUSxJ2AMx2Jcs=;
        b=W90zU+QVXka4kilzFI+qrSHVmps1ETX55nVUKbkCmRYFZzfb6nDQ9UytiAlTaJoAtthBBG
        W+52q3eXSEAsdjAA==
From:   "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timers/posix_timers: Test delivery of
 signals across threads
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230316123028.2890338-2-elver@google.com>
References: <20230316123028.2890338-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <168162864799.404.9782456748146333366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e797203fb3ba8c0ed2f4a8800d626c9d54fedfbf
Gitweb:        https://git.kernel.org/tip/e797203fb3ba8c0ed2f4a8800d626c9d54fedfbf
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Thu, 16 Mar 2023 13:30:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 16 Apr 2023 09:00:18 +02:00

selftests/timers/posix_timers: Test delivery of signals across threads

Test that POSIX timers using CLOCK_PROCESS_CPUTIME_ID eventually deliver
a signal to all running threads.  This effectively tests that the kernel
doesn't prefer any one thread (or subset of threads) for signal delivery.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230316123028.2890338-2-elver@google.com

---
 tools/testing/selftests/timers/posix_timers.c | 77 ++++++++++++++++++-
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0ba5000..8a17c0e 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -188,6 +188,80 @@ static int check_timer_create(int which)
 	return 0;
 }
 
+int remain;
+__thread int got_signal;
+
+static void *distribution_thread(void *arg)
+{
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+	return NULL;
+}
+
+static void distribution_handler(int nr)
+{
+	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
+		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
+}
+
+/*
+ * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
+ * timer signals. This primarily tests that the kernel does not favour any one.
+ */
+static int check_timer_distribution(void)
+{
+	int err, i;
+	timer_t id;
+	const int nthreads = 10;
+	pthread_t threads[nthreads];
+	struct itimerspec val = {
+		.it_value.tv_sec = 0,
+		.it_value.tv_nsec = 1000 * 1000,
+		.it_interval.tv_sec = 0,
+		.it_interval.tv_nsec = 1000 * 1000,
+	};
+
+	printf("Check timer_create() per process signal distribution... ");
+	fflush(stdout);
+
+	remain = nthreads + 1;  /* worker threads + this thread */
+	signal(SIGALRM, distribution_handler);
+	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
+	if (err < 0) {
+		perror("Can't create timer\n");
+		return -1;
+	}
+	err = timer_settime(id, 0, &val, NULL);
+	if (err < 0) {
+		perror("Can't set timer\n");
+		return -1;
+	}
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
+			perror("Can't create thread\n");
+			return -1;
+		}
+	}
+
+	/* Wait for all threads to receive the signal. */
+	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
+
+	for (i = 0; i < nthreads; i++) {
+		if (pthread_join(threads[i], NULL)) {
+			perror("Can't join thread\n");
+			return -1;
+		}
+	}
+
+	if (timer_delete(id)) {
+		perror("Can't delete timer\n");
+		return -1;
+	}
+
+	printf("[OK]\n");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	printf("Testing posix timers. False negative may happen on CPU execution \n");
@@ -217,5 +291,8 @@ int main(int argc, char **argv)
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
 		return ksft_exit_fail();
 
+	if (check_timer_distribution() < 0)
+		return ksft_exit_fail();
+
 	return ksft_exit_pass();
 }
