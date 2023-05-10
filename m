Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ACC6FE4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjEJUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjEJUMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:12:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD3412C;
        Wed, 10 May 2023 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qWyk6GJdeOpA9cYc7idGGRtfUrpn58e1afJFdAUjRa8=;
        t=1683749532; x=1684959132; b=P04XVtH77zDeBOPaL4Ukdoz7GXAM6WcHqde2za6fVWBx5jV
        dHl1UwdTKnHFFaUTIFn/E91+XqyZyCKm+ZOQOwyapPFcmdeWI1OE4n8JsKJ5HxOQrGIbhDZ/GCRRr
        BuJXGES2oLGnd8RgSchIZWEVQ9/OJev0swCfN1q13hUq/wIGM9jEH7kqS9rjt5cc0rUQjbgx2p9mx
        EVorD8rryiKIWsxv9XUaXpdVXWRgvqMtCX0DUEb1ECW0kjI4+T6I7AjLu778RAuNKLpxwb73dD9pC
        kjTs1vhqgrZMFmt9mDIyZtEAnyG8PN12rahON2xTz/K6Zk74YiCOFlg3YveVxB9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwqAT-005aH5-0u;
        Wed, 10 May 2023 22:12:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 2/3] wifi: cfg80211: add a workqueue with special semantics
Date:   Wed, 10 May 2023 22:12:04 +0200
Message-Id: <20230510220918.96de601f45f6.I28a06f59bf647db6dea519e6fca1894f94227d73@changeid>
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

The special semantics are that it's paused during wiphy_lock()
and nothing can run or even start running on it while that is
locked.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - dropped the previous workqueue locking patch
 - therefore, rework this to have a specific wiphy
   work struct (and delayed), which is maybe better
   anyway since it's (more) type-safe
---
 include/net/cfg80211.h | 109 +++++++++++++++++++++++++++-----
 net/wireless/core.c    | 138 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    |   6 ++
 net/wireless/nl80211.c |   8 ++-
 4 files changed, 245 insertions(+), 16 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f115b2550309..c9318ddf495e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5142,6 +5142,7 @@ struct wiphy_iftype_akm_suites {
 /**
  * struct wiphy - wireless hardware description
  * @mtx: mutex for the data (structures) of this device
+ * @mtx_fully_held: the mutex was held with workqueue pause/flush
  * @reg_notifier: the driver's regulatory notification callback,
  *	note that if your driver uses wiphy_apply_custom_regulatory()
  *	the reg_notifier's request can be passed as NULL
@@ -5351,6 +5352,9 @@ struct wiphy_iftype_akm_suites {
  */
 struct wiphy {
 	struct mutex mtx;
+#ifdef CONFIG_LOCKDEP
+	bool mtx_fully_held;
+#endif
 
 	/* assign these fields before you register the wiphy */
 
@@ -5669,31 +5673,108 @@ struct cfg80211_cqm_config;
  * wiphy_lock - lock the wiphy
  * @wiphy: the wiphy to lock
  *
- * This is mostly exposed so it can be done around registering and
- * unregistering netdevs that aren't created through cfg80211 calls,
- * since that requires locking in cfg80211 when the notifiers is
- * called, but that cannot differentiate which way it's called.
+ * This is needed around registering and unregistering netdevs that
+ * aren't created through cfg80211 calls, since that requires locking
+ * in cfg80211 when the notifiers is called, but that cannot
+ * differentiate which way it's called.
+ *
+ * It can also be used by drivers for their own purposes.
  *
  * When cfg80211 ops are called, the wiphy is already locked.
+ *
+ * Note that this makes sure that no workers that have been queued
+ * with wiphy_queue_work() are running.
  */
-static inline void wiphy_lock(struct wiphy *wiphy)
-	__acquires(&wiphy->mtx)
-{
-	mutex_lock(&wiphy->mtx);
-	__acquire(&wiphy->mtx);
-}
+void wiphy_lock(struct wiphy *wiphy) __acquires(&wiphy->mtx);
 
 /**
  * wiphy_unlock - unlock the wiphy again
  * @wiphy: the wiphy to unlock
  */
-static inline void wiphy_unlock(struct wiphy *wiphy)
-	__releases(&wiphy->mtx)
+void wiphy_unlock(struct wiphy *wiphy) __releases(&wiphy->mtx);
+
+struct wiphy_work;
+typedef void (*wiphy_work_func_t)(struct wiphy *, struct wiphy_work *);
+
+struct wiphy_work {
+	struct list_head entry;
+	wiphy_work_func_t func;
+};
+
+static inline void wiphy_work_init(struct wiphy_work *work,
+				   wiphy_work_func_t func)
 {
-	__release(&wiphy->mtx);
-	mutex_unlock(&wiphy->mtx);
+	INIT_LIST_HEAD(&work->entry);
+	work->func = func;
 }
 
+/**
+ * wiphy_work_queue - queue work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @work: the work item
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that the wiphy mutex will be
+ * held as if wiphy_lock() was called, and that it cannot be running
+ * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
+ * use just cancel_work() instead of cancel_work_sync(), it requires
+ * being in a section protected by wiphy_lock().
+ */
+void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work);
+
+/**
+ * wiphy_work_cancel - cancel previously queued work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work);
+
+struct wiphy_delayed_work {
+	struct wiphy_work work;
+	struct wiphy *wiphy;
+	struct timer_list timer;
+};
+
+void wiphy_delayed_work_timer(struct timer_list *t);
+
+static inline void wiphy_delayed_work_init(struct wiphy_delayed_work *dwork,
+					   wiphy_work_func_t func)
+{
+	timer_setup(&dwork->timer, wiphy_delayed_work_timer, 0);
+	wiphy_work_init(&dwork->work, func);
+}
+
+/**
+ * wiphy_delayed_work_queue - queue delayed work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @dwork: the delayable worker
+ * @delay: number of jiffies to wait before queueing
+ *
+ * This is useful for work that must be done asynchronously, and work
+ * queued here has the special property that the wiphy mutex will be
+ * held as if wiphy_lock() was called, and that it cannot be running
+ * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
+ * use just cancel_work() instead of cancel_work_sync(), it requires
+ * being in a section protected by wiphy_lock().
+ */
+void wiphy_delayed_work_queue(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork,
+			      unsigned long delay);
+
+/**
+ * wiphy_delayed_work_cancel - cancel previously queued delayed work
+ * @wiphy: the wiphy, for debug purposes
+ * @dwork: the delayed work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_delayed_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_delayed_work *dwork);
+
 /**
  * struct wireless_dev - wireless device state
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..357fd5425bff 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -408,6 +408,28 @@ static void cfg80211_propagate_cac_done_wk(struct work_struct *work)
 	rtnl_unlock();
 }
 
+static void cfg80211_wiphy_work(struct work_struct *work)
+{
+	struct cfg80211_registered_device *rdev;
+
+	rdev = container_of(work, struct cfg80211_registered_device, wiphy_work);
+
+	spin_lock_irq(&rdev->wiphy_work_lock);
+	while (!list_empty(&rdev->wiphy_work_list)) {
+		struct wiphy_work *wk;
+
+		wk = list_first_entry(&rdev->wiphy_work_list,
+				      struct wiphy_work, entry);
+		list_del_init(&wk->entry);
+		spin_unlock_irq(&rdev->wiphy_work_lock);
+
+		mutex_lock(&rdev->wiphy.mtx);
+		wk->func(&rdev->wiphy, wk);
+		mutex_unlock(&rdev->wiphy.mtx);
+	}
+	spin_unlock_irq(&rdev->wiphy_work_lock);
+}
+
 /* exported functions */
 
 struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
@@ -533,6 +555,15 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		return NULL;
 	}
 
+	rdev->wq = alloc_workqueue("%s", 0, 0, dev_name(&rdev->wiphy.dev));
+	if (!rdev->wq) {
+		wiphy_free(&rdev->wiphy);
+		return NULL;
+	}
+
+	INIT_WORK(&rdev->wiphy_work, cfg80211_wiphy_work);
+	INIT_LIST_HEAD(&rdev->wiphy_work_list);
+	spin_lock_init(&rdev->wiphy_work_lock);
 	INIT_WORK(&rdev->rfkill_block, cfg80211_rfkill_block_work);
 	INIT_WORK(&rdev->conn_work, cfg80211_conn_work);
 	INIT_WORK(&rdev->event_work, cfg80211_event_work);
@@ -1068,6 +1099,13 @@ void wiphy_unregister(struct wiphy *wiphy)
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
+	/*
+	 * flush again, even if wiphy_lock() did above, something might
+	 * have been reaching it still while the code above was running,
+	 * e.g. via debugfs.
+	 */
+	flush_workqueue(rdev->wq);
+
 	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
@@ -1093,6 +1131,10 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 {
 	struct cfg80211_internal_bss *scan, *tmp;
 	struct cfg80211_beacon_registration *reg, *treg;
+
+	if (rdev->wq) /* might be NULL in error cases */
+		destroy_workqueue(rdev->wq);
+
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
@@ -1564,6 +1606,102 @@ static struct pernet_operations cfg80211_pernet_ops = {
 	.exit = cfg80211_pernet_exit,
 };
 
+void wiphy_lock(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	workqueue_pause(rdev->wq);
+
+	mutex_lock(&wiphy->mtx);
+
+#ifdef CONFIG_LOCKDEP
+	wiphy->mtx_fully_held = true;
+#endif
+}
+EXPORT_SYMBOL(wiphy_lock);
+
+void wiphy_unlock(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(!wiphy->mtx_fully_held);
+#endif
+
+	workqueue_resume(rdev->wq);
+
+#ifdef CONFIG_LOCKDEP
+	wiphy->mtx_fully_held = false;
+#endif
+
+	mutex_unlock(&wiphy->mtx);
+}
+EXPORT_SYMBOL(wiphy_unlock);
+
+void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	if (list_empty(&work->entry))
+		list_add_tail(&rdev->wiphy_work_list, &work->entry);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+
+	queue_work(rdev->wq, &rdev->wiphy_work);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_queue);
+
+void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+
+#ifdef CONFIG_LOCKDEP
+	lockdep_assert_held(&wiphy->mtx);
+	WARN_ON_ONCE(!wiphy->mtx_fully_held);
+#endif
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	if (!list_empty(&work->entry))
+		list_del_init(&work->entry);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_cancel);
+
+void wiphy_delayed_work_timer(struct timer_list *t)
+{
+	struct wiphy_delayed_work *dwork = from_timer(dwork, t, timer);
+
+	wiphy_work_queue(dwork->wiphy, &dwork->work);
+}
+EXPORT_SYMBOL(wiphy_delayed_work_timer);
+
+void wiphy_delayed_work_queue(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork,
+			      unsigned long delay)
+{
+	if (!delay) {
+		wiphy_work_queue(wiphy, &dwork->work);
+		return;
+	}
+
+	dwork->wiphy = wiphy;
+	mod_timer(&dwork->timer, jiffies + delay);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_queue);
+
+void wiphy_delayed_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_delayed_work *dwork)
+{
+#ifdef CONFIG_LOCKDEP
+	lockdep_assert_held(&wiphy->mtx);
+	WARN_ON_ONCE(!wiphy->mtx_fully_held);
+#endif
+	del_timer_sync(&dwork->timer);
+	wiphy_work_cancel(wiphy, &dwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_cancel);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 7c61752f6d83..adb45fa38acb 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -108,6 +108,12 @@ struct cfg80211_registered_device {
 	/* lock for all wdev lists */
 	spinlock_t mgmt_registrations_lock;
 
+	struct workqueue_struct *wq;
+	struct work_struct wiphy_work;
+	struct list_head wiphy_work_list;
+	/* protects the list above */
+	spinlock_t wiphy_work_lock;
+
 	/* must be last because of the way we do wiphy_priv(),
 	 * and it should at least be aligned to NETDEV_ALIGN */
 	struct wiphy wiphy __aligned(NETDEV_ALIGN);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..1fb4978f7649 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1002,7 +1002,9 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			return PTR_ERR(*wdev);
 		}
 		*rdev = wiphy_to_rdev((*wdev)->wiphy);
-		mutex_lock(&(*rdev)->wiphy.mtx);
+		wiphy_lock(&(*rdev)->wiphy);
+		/* the conditional locking is too hard for sparse */
+		__release(&(*rdev)->wiphy.mtx);
 		rtnl_unlock();
 		/* 0 is the first index - add 1 to parse only once */
 		cb->args[0] = (*rdev)->wiphy_idx + 1;
@@ -1032,7 +1034,9 @@ static int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			rtnl_unlock();
 			return -ENODEV;
 		}
-		mutex_lock(&(*rdev)->wiphy.mtx);
+		wiphy_lock(&(*rdev)->wiphy);
+		/* the conditional locking is too hard for sparse */
+		__release(&(*rdev)->wiphy.mtx);
 		rtnl_unlock();
 	}
 
-- 
2.40.1

