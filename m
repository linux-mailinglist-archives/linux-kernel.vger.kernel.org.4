Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786C63F740
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLASMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLASMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:12:07 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A14EB7DDD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:12:07 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id m15so1097270ilq.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8OpHlPRST08skeh7BHSZbFN09k6AB6QzxLidf3Pxy0=;
        b=AS0uFZT7AMQnrCsnu0myce/68PNqhpRsA5u5f4LRNoWMlDHGfdkpnX4Bi7cN5cdYGb
         xqdvKOmhCzI+5xIdNOa7IXXJKN76QUhQ5bEE0TGc9TT1CzwQWBwxaBo9dcoAm2EXczuO
         BWbTIe5bxzNBixBo+grxsNP/S6uE+oBHuP7FwcSGjYpqt9pNgmik/w/epK7az0/nTi6J
         SU1JdTULxEiQvzxCmGA4dAqUAdR7cFcERSrlB3wYXqjxQcTWauNZkbX3up+4lfaLMAno
         nD9XRVUYifvWGAzNsFQcvl/jDfoyDKtULpSDCOxy/rpRlexRJGGOuiApfmzFdFHr2iUL
         J55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8OpHlPRST08skeh7BHSZbFN09k6AB6QzxLidf3Pxy0=;
        b=pK6sOFTzgIU/vqAVuCSOipkY0uDCRd0YLzWusWPvM7sS0p8juvdMkKXF/ovetjuiBI
         gd+drR9dTr8VKwgKq1yTXp3XbUyqgobls6GC20RvST3PUFEwuflnd3K+VzzYfhQgi1hP
         vB/nhYn4DFlqU+RnhGfXWYn4FLoKZvsebMa41jcuigNQ4KjiWpmcdDXRdfZ9C7CZRiau
         BtIsAs/cMFHhWHPhfl1zF5Hs5g2vKO+B6kwIdS0oo0dn0gf0xjND2gNcrJNTuwhqlquO
         miXZvNWyEHZ2M8viatTe8tpfm/FyhMY4D9/CS+tPc5GCHGXVv8YbQKz1aOm29lmtirhV
         Whtw==
X-Gm-Message-State: ANoB5pmHo03BWj47nD3D8nPW1whf6PBhS7c8xlI9JDY0Rb37kO2AjQjs
        p/iOz8Zg9XBCzlubQql8Tz08gBrCoFnuluCK
X-Google-Smtp-Source: AA0mqf74rtsrKXEuoo2caUTbU7JNHXUXS1+uampBMqsW7Usq/+Os6d15vXnGS1Vl1qTyLEypX5XlLQ==
X-Received: by 2002:a92:d689:0:b0:303:2806:1ca0 with SMTP id p9-20020a92d689000000b0030328061ca0mr5247364iln.247.1669918326690;
        Thu, 01 Dec 2022 10:12:06 -0800 (PST)
Received: from m1max.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y21-20020a027315000000b00374fe4f0bc3sm1842028jab.158.2022.12.01.10.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:12:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     soheil@google.com, willemdebruijn.kernel@gmail.com,
        stefanha@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] eventpoll: split out wait handling
Date:   Thu,  1 Dec 2022 11:11:52 -0700
Message-Id: <20221201181156.848373-4-axboe@kernel.dk>
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

In preparation for making changes to how wakeups and sleeps are done,
move the timeout scheduling into a helper and manage it rather than
rely on schedule_hrtimeout_range().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 68 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 64d7331353dd..888f565d0c5f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1762,6 +1762,47 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 	return ret;
 }
 
+struct epoll_wq {
+	wait_queue_entry_t wait;
+	struct hrtimer timer;
+	bool timed_out;
+};
+
+static enum hrtimer_restart ep_timer(struct hrtimer *timer)
+{
+	struct epoll_wq *ewq = container_of(timer, struct epoll_wq, timer);
+	struct task_struct *task = ewq->wait.private;
+
+	ewq->timed_out = true;
+	wake_up_process(task);
+	return HRTIMER_NORESTART;
+}
+
+static void ep_schedule(struct eventpoll *ep, struct epoll_wq *ewq, ktime_t *to,
+			u64 slack)
+{
+	if (ewq->timed_out)
+		return;
+	if (to && *to == 0) {
+		ewq->timed_out = true;
+		return;
+	}
+	if (!to) {
+		schedule();
+		return;
+	}
+
+	hrtimer_init_on_stack(&ewq->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	ewq->timer.function = ep_timer;
+	hrtimer_set_expires_range_ns(&ewq->timer, *to, slack);
+	hrtimer_start_expires(&ewq->timer, HRTIMER_MODE_ABS);
+
+	schedule();
+
+	hrtimer_cancel(&ewq->timer);
+	destroy_hrtimer_on_stack(&ewq->timer);
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
  *           event buffer.
@@ -1782,13 +1823,15 @@ static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, struct timespec64 *timeout)
 {
-	int res, eavail, timed_out = 0;
+	int res, eavail;
 	u64 slack = 0;
-	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
+	struct epoll_wq ewq;
 
 	lockdep_assert_irqs_enabled();
 
+	ewq.timed_out = false;
+
 	if (timeout && (timeout->tv_sec | timeout->tv_nsec)) {
 		slack = select_estimate_accuracy(timeout);
 		to = &expires;
@@ -1798,7 +1841,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * Avoid the unnecessary trip to the wait queue loop, if the
 		 * caller specified a non blocking operation.
 		 */
-		timed_out = 1;
+		ewq.timed_out = true;
 	}
 
 	/*
@@ -1823,7 +1866,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 				return res;
 		}
 
-		if (timed_out)
+		if (ewq.timed_out)
 			return 0;
 
 		eavail = ep_busy_loop(ep);
@@ -1850,8 +1893,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * performance issue if a process is killed, causing all of its
 		 * threads to wake up without being removed normally.
 		 */
-		init_wait(&wait);
-		wait.func = ep_autoremove_wake_function;
+		init_wait(&ewq.wait);
+		ewq.wait.func = ep_autoremove_wake_function;
 
 		write_lock_irq(&ep->lock);
 		/*
@@ -1870,10 +1913,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 */
 		eavail = ep_events_available(ep);
 		if (!eavail) {
-			__add_wait_queue_exclusive(&ep->wq, &wait);
+			__add_wait_queue_exclusive(&ep->wq, &ewq.wait);
 			write_unlock_irq(&ep->lock);
-			timed_out = !schedule_hrtimeout_range(to, slack,
-							      HRTIMER_MODE_ABS);
+			ep_schedule(ep, &ewq, to, slack);
 		} else {
 			write_unlock_irq(&ep->lock);
 		}
@@ -1887,7 +1929,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 */
 		eavail = 1;
 
-		if (!list_empty_careful(&wait.entry)) {
+		if (!list_empty_careful(&ewq.wait.entry)) {
 			write_lock_irq(&ep->lock);
 			/*
 			 * If the thread timed out and is not on the wait queue,
@@ -1896,9 +1938,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * Thus, when wait.entry is empty, it needs to harvest
 			 * events.
 			 */
-			if (timed_out)
-				eavail = list_empty(&wait.entry);
-			__remove_wait_queue(&ep->wq, &wait);
+			if (ewq.timed_out)
+				eavail = list_empty(&ewq.wait.entry);
+			__remove_wait_queue(&ep->wq, &ewq.wait);
 			write_unlock_irq(&ep->lock);
 		}
 	}
-- 
2.35.1

