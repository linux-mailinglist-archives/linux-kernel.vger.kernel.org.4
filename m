Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3963F748
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLASMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiLASMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:12:21 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C80B845D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:12:10 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id i80so1606003ioa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ9tl6KkNetvRAWXe2iAAf/ML4fBDffEt0E3CXrPzCE=;
        b=l4wGJmKVt1fPfhJvQBLb5fQkAKw+lUzYeSTILSbU6Uq+yHzEtXv1G/VdU4rETW2k0a
         WgEKMyF1NjMLgqGbaejKRlOXnP1hSlHSJYkJdgZAmu+SPy+TmPHkrSW13WnaxD5fgD8+
         IhvSF9aaSloA3mi1nq9od2wRv3ISoh12Uxm8LSdCFB7H3nEo8Iwfxn4v5r4LfT0JE7yD
         fnOP0lo0vweKMI4qLFDYINpw9TyXqgvMlnIhKZAEKAmKmUY8fq4/H6wW88GH4paIE4Xr
         UTHG/9PwV1oEImy4nEfT+GcIgYvHe9ohvof3nu5pVjQ0sd3+wMNkUItC4k8sRXIrWnBp
         n/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ9tl6KkNetvRAWXe2iAAf/ML4fBDffEt0E3CXrPzCE=;
        b=OhDoTtCEk2enzFGJn+i8gZrkXZ87NfdC6d4eTLcOGSeFU+0BgFoywLVI971LrNHN/F
         ME6+x1+YoDikahn+BprfMo2p4ML0i41TawqtlY9FwYk6BRmyxSxhUZBr3K0bjidJHQy1
         cS1vaFPIqEXuT7r2FO61CH9+8/RsDCJjxMyVh9/2blv/HUiyMu9Dm2e9+z4v0q4apAlP
         7awNbEL4qKmFvzKr9QSalXrLMYm/YV61UVlp2+CX5SjrxoBSP+2gJvpAiIfd7oIZtNbz
         w01ZKmlOkzGK7urCCcE7WSFCDVMPTebRa6kAfm78D4gDi/Sir9KsFgITwwd5p7dUVPos
         gQRw==
X-Gm-Message-State: ANoB5plkXyF6vdH9O48Z1vHaQCWZ6EB6h+m3evJuEHo2WCnOR0uQ/ZqX
        zFKw5yFNYrW5uitwiK/+ILw9qwadSX2RHHfj
X-Google-Smtp-Source: AA0mqf5zLJz/mgwfBZKobgUjeWoWZs1zCAXYSpLS0zfZhZNhS+w+fzJrMS6nQ2st8FUfaz6HwlAScw==
X-Received: by 2002:a6b:fb13:0:b0:6de:383e:4146 with SMTP id h19-20020a6bfb13000000b006de383e4146mr24784036iog.48.1669918329401;
        Thu, 01 Dec 2022 10:12:09 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b00374fe4f0bc3sm1842028jab.158.2022.12.01.10.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:12:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     soheil@google.com, willemdebruijn.kernel@gmail.com,
        stefanha@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/7] eventpoll: add support for min-wait
Date:   Thu,  1 Dec 2022 11:11:55 -0700
Message-Id: <20221201181156.848373-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201181156.848373-1-axboe@kernel.dk>
References: <20221201181156.848373-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary infrastructure to support a minimum wait for
reaping events, API for setting or applying a minimum wait will come
in the following patches.

For medium workload efficiencies, some production workloads inject
artificial timers or sleeps before calling epoll_wait() to get
better batching and higher efficiencies. While this does help, it's
not as efficient as it could be. By adding support for epoll_wait()
for this directly, we can avoids extra context switches and scheduler
and timer overhead.

As an example, running an AB test on an identical workload at about
~370K reqs/second, without this change and with the sleep hack
mentioned above (using 200 usec as the timeout), we're doing 310K-340K
non-voluntary context switches per second. Idle CPU on the host is 27-34%.
With the the sleep hack removed and epoll set to the same 200 usec
value, we're handling the exact same load but at 292K-315k non-voluntary
context switches and idle CPU of 33-41%, a substantial win.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 84 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 962d897bbfc6..daa9885d9c2b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -117,6 +117,9 @@ struct eppoll_entry {
 	/* The "base" pointer is set to the container "struct epitem" */
 	struct epitem *base;
 
+	/* min wait time if (min_wait_ts) & 1 != 0 */
+	ktime_t min_wait_ts;
+
 	/*
 	 * Wait queue item that will be linked to the target file wait
 	 * queue head.
@@ -217,6 +220,9 @@ struct eventpoll {
 	u64 gen;
 	struct hlist_head refs;
 
+	/* min wait for epoll_wait() */
+	unsigned int min_wait_ts;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
@@ -1747,6 +1753,32 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 	return to;
 }
 
+struct epoll_wq {
+	wait_queue_entry_t wait;
+	struct hrtimer timer;
+	ktime_t timeout_ts;
+	ktime_t min_wait_ts;
+	struct eventpoll *ep;
+	bool timed_out;
+	int maxevents;
+	int wakeups;
+};
+
+static bool ep_should_min_wait(struct epoll_wq *ewq)
+{
+	if (ewq->min_wait_ts & 1) {
+		/* just an approximation */
+		if (++ewq->wakeups >= ewq->maxevents)
+			goto stop_wait;
+		if (ktime_before(ktime_get_ns(), ewq->min_wait_ts))
+			return true;
+	}
+
+stop_wait:
+	ewq->min_wait_ts &= ~(u64) 1;
+	return false;
+}
+
 /*
  * autoremove_wake_function, but remove even on failure to wake up, because we
  * know that default_wake_function/ttwu will only fail if the thread is already
@@ -1756,27 +1788,37 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 				       unsigned int mode, int sync, void *key)
 {
-	int ret = default_wake_function(wq_entry, mode, sync, key);
+	struct epoll_wq *ewq = container_of(wq_entry, struct epoll_wq, wait);
+	int ret;
 
+	/*
+	 * If min wait time hasn't been satisfied yet, keep waiting
+	 */
+	if (ep_should_min_wait(ewq))
+		return 0;
+
+	ret = default_wake_function(wq_entry, mode, sync, key);
 	list_del_init(&wq_entry->entry);
 	return ret;
 }
 
-struct epoll_wq {
-	wait_queue_entry_t wait;
-	struct hrtimer timer;
-	ktime_t timeout_ts;
-	bool timed_out;
-};
-
 static enum hrtimer_restart ep_timer(struct hrtimer *timer)
 {
 	struct epoll_wq *ewq = container_of(timer, struct epoll_wq, timer);
 	struct task_struct *task = ewq->wait.private;
+	const bool is_min_wait = ewq->min_wait_ts & 1;
+
+	if (!is_min_wait || ep_events_available(ewq->ep)) {
+		if (!is_min_wait)
+			ewq->timed_out = true;
+		ewq->min_wait_ts &= ~(u64) 1;
+		wake_up_process(task);
+		return HRTIMER_NORESTART;
+	}
 
-	ewq->timed_out = true;
-	wake_up_process(task);
-	return HRTIMER_NORESTART;
+	ewq->min_wait_ts &= ~(u64) 1;
+	hrtimer_set_expires_range_ns(&ewq->timer, ewq->timeout_ts, 0);
+	return HRTIMER_RESTART;
 }
 
 static void ep_schedule(struct eventpoll *ep, struct epoll_wq *ewq, ktime_t *to,
@@ -1831,12 +1873,16 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	lockdep_assert_irqs_enabled();
 
+	ewq.min_wait_ts = 0;
+	ewq.ep = ep;
+	ewq.maxevents = maxevents;
 	ewq.timed_out = false;
+	ewq.wakeups = 0;
 
 	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
 		slack = select_estimate_accuracy(timeout);
+		ewq.timeout_ts = timespec64_to_ktime(*timeout);
 		to = &ewq.timeout_ts;
-		*to = timespec64_to_ktime(*timeout);
 	} else if (timeout) {
 		/*
 		 * Avoid the unnecessary trip to the wait queue loop, if the
@@ -1845,6 +1891,18 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		ewq.timed_out = true;
 	}
 
+	/*
+	 * If min_wait is set for this epoll instance, note the min_wait
+	 * time. Ensure the lowest bit is set in ewq.min_wait_ts, that's
+	 * the state bit for whether or not min_wait is enabled.
+	 */
+	if (!ewq.timed_out && ep->min_wait_ts) {
+		ewq.min_wait_ts = ktime_add_us(ktime_get_ns(),
+						ep->min_wait_ts);
+		ewq.min_wait_ts |= (u64) 1;
+		to = &ewq.min_wait_ts;
+	}
+
 	/*
 	 * This call is racy: We may or may not see events that are being added
 	 * to the ready list under the lock (e.g., in IRQ callbacks). For cases
@@ -1913,7 +1971,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * important.
 		 */
 		eavail = ep_events_available(ep);
-		if (!eavail) {
+		if (!eavail || ewq.min_wait_ts & 1) {
 			__add_wait_queue_exclusive(&ep->wq, &ewq.wait);
 			write_unlock_irq(&ep->lock);
 			ep_schedule(ep, &ewq, to, slack);
-- 
2.35.1

