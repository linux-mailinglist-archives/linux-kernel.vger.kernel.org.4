Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BC6FE4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjEJUMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbjEJUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:12:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9FE10C3;
        Wed, 10 May 2023 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1eItkrSnBXDxwAy/pbcSMdyZKnv054ktdoQQCOFc/k0=;
        t=1683749533; x=1684959133; b=PrntjE60vMfUngjv6eSjAfhwfFxtup2Qrxk37uYUhspoLiD
        FiTXzmEDo96wSQgbNAKH6OR/Km/AbVMWNulQxnxEWlgq6vQr9Jm3+lfagjV/8HCZbrjKcwgDb/SoA
        64EF5GkB53jfNwu6jS09AjEOf2ZhRk/Klowr55QeS2imJDxvnyIsb74LqVc0w2oyg5RFywpNpzKYJ
        Z0BNCX7fUh9TAJ1a4yObnsFilBKuEl0u45tJhbtbufhf8u40PzbxXuEJrFFFtzkfAcmQ/vPSEe5uY
        GFO1Hzfhf+97Ritgpw57nZr/Gcz70RPX9dzQ36W90uHRiFOvvhV/bD3/bZaGACNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwqAS-005aH5-2u;
        Wed, 10 May 2023 22:12:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 1/3] workqueue: support pausing ordered workqueues
Date:   Wed, 10 May 2023 22:12:03 +0200
Message-Id: <20230510220918.1dc654070530.Ia49f779e11c2814294ea7f8bb29f825fb840be51@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510201205.308542-1-johannes@sipsolutions.net>
References: <20230510201205.308542-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add some infrastructure to support pausing ordered
workqueues, so that no work items are executing nor
can execute while the workqueue is paused.

This can be used to simplify locking between work
structs and other processes (e.g. userspace calls)
when the workqueue is paused while other code is
running, where we can then more easily avoid issues
in code paths needing to cancel works.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - fix bug with new_max_active no being used
 - don't unify pause/resume
 - looked at unifying pause/freeze, but the conditions
   are very different so I didn't find a plausible way
---
 include/linux/workqueue.h |  4 +++
 kernel/workqueue.c        | 54 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ac551b8ee7d9..7a76d27d325f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -340,6 +340,7 @@ enum {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+	__WQ_PAUSED		= 1 << 20, /* internal: workqueue_pause() */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
@@ -475,6 +476,9 @@ extern void show_all_workqueues(void);
 extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
+void workqueue_pause(struct workqueue_struct *wq);
+void workqueue_resume(struct workqueue_struct *wq);
+
 /**
  * queue_work - queue work on a workqueue
  * @wq: workqueue to use
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..12e8b003568f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3863,12 +3863,18 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	struct workqueue_struct *wq = pwq->wq;
 	bool freezable = wq->flags & WQ_FREEZABLE;
 	unsigned long flags;
+	int new_max_active;
 
-	/* for @wq->saved_max_active */
+	/* for @wq->saved_max_active and @wq->flags */
 	lockdep_assert_held(&wq->mutex);
 
+	if (wq->flags & __WQ_PAUSED)
+		new_max_active = 0;
+	else
+		new_max_active = wq->saved_max_active;
+
 	/* fast exit for non-freezable wqs */
-	if (!freezable && pwq->max_active == wq->saved_max_active)
+	if (!freezable && pwq->max_active == new_max_active)
 		return;
 
 	/* this function can be called during early boot w/ irq disabled */
@@ -3882,7 +3888,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	if (!freezable || !workqueue_freezing) {
 		bool kick = false;
 
-		pwq->max_active = wq->saved_max_active;
+		pwq->max_active = new_max_active;
 
 		while (!list_empty(&pwq->inactive_works) &&
 		       pwq->nr_active < pwq->max_active) {
@@ -4642,6 +4648,48 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 }
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
 
+/**
+ * workqueue_pause - pause a workqueue
+ * @wq: workqueue to pause
+ *
+ * Pause (and flush) the given workqueue so it's not executing any
+ * work structs and won't until workqueue_resume() is called.
+ */
+void workqueue_pause(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	mutex_lock(&wq->mutex);
+	wq->flags |= __WQ_PAUSED;
+
+	for_each_pwq(pwq, wq)
+		pwq_adjust_max_active(pwq);
+	mutex_unlock(&wq->mutex);
+
+	flush_workqueue(wq);
+}
+EXPORT_SYMBOL_GPL(workqueue_pause);
+
+/**
+ * workqueue_resume - resume a paused workqueue
+ * @wq: workqueue to resume
+ *
+ * Resume the given workqueue that was paused previously to
+ * make it run work structs again.
+ */
+void workqueue_resume(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	mutex_lock(&wq->mutex);
+	wq->flags &= ~__WQ_PAUSED;
+
+	for_each_pwq(pwq, wq)
+		pwq_adjust_max_active(pwq);
+	mutex_unlock(&wq->mutex);
+}
+EXPORT_SYMBOL_GPL(workqueue_resume);
+
 /**
  * current_work - retrieve %current task's work struct
  *
-- 
2.40.1

