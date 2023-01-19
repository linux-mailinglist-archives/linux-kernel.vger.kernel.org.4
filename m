Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB696739A0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjASNLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjASNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:11:05 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931AE7F996;
        Thu, 19 Jan 2023 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TcKOFs0Yh57RnWuxPcj7FheziyDoms7tarPYcXv91uw=; b=aZ3OO57IVX+BXPBDWSs2BuaEsc
        7e7izMk+YkqDqseGyi9Kw0QJ2y2RBitk1MXYCLrmJnpKJ32WStKO8DySqTJOpGt9xP8aNKvRcGvOv
        uJFjbqbBz0RTpos5ONOIy50SCcDD0WCLfAzYhvZyMQvpzQ1sELt/1hAMBkcnnajrqmbBwm4y38aJC
        N0uNM8sHG5rmJQ0icbA0fIGh71b3W638/4T1YIu2Q8Pal/8Ivqf2+xXUcbcCqc1JpU86ykO0TK7PS
        Zobm67WwOkVfbMHyN03UmtgbytoFwfStjFWj44LCpC0MdKSrNy/DuBvXEc7UoWwAVT8CB2U6QoENT
        F9JvgYag==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pIUfe-000zLh-Vz; Thu, 19 Jan 2023 15:09:35 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] gpu: host1x: Implement job tracking using DMA fences
Date:   Thu, 19 Jan 2023 15:09:19 +0200
Message-Id: <20230119130921.1882602-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119130921.1882602-1-cyndis@kapsi.fi>
References: <20230119130921.1882602-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

In anticipation of removal of the intr API, implement job tracking
using DMA fences instead. The main two things about this are
making cdma_update schedule the work since fence completion can
now be called from interrupt context, and some complication in
ensuring the callback is not running when we free the fence.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/cdma.c          | 14 +++++++--
 drivers/gpu/host1x/cdma.h          |  2 ++
 drivers/gpu/host1x/hw/channel_hw.c | 48 +++++++++++++++++-------------
 drivers/gpu/host1x/job.c           | 12 ++++++--
 include/linux/host1x.h             |  6 ++--
 5 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 103fda055394..bc821b0ed908 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -490,6 +490,15 @@ void host1x_cdma_update_sync_queue(struct host1x_cdma *cdma,
 	host1x_hw_cdma_resume(host1x, cdma, restart_addr);
 }
 
+static void cdma_update_work(struct work_struct *work)
+{
+	struct host1x_cdma *cdma = container_of(work, struct host1x_cdma, update_work);
+
+	mutex_lock(&cdma->lock);
+	update_cdma_locked(cdma);
+	mutex_unlock(&cdma->lock);
+}
+
 /*
  * Create a cdma
  */
@@ -499,6 +508,7 @@ int host1x_cdma_init(struct host1x_cdma *cdma)
 
 	mutex_init(&cdma->lock);
 	init_completion(&cdma->complete);
+	INIT_WORK(&cdma->update_work, cdma_update_work);
 
 	INIT_LIST_HEAD(&cdma->sync_queue);
 
@@ -679,7 +689,5 @@ void host1x_cdma_end(struct host1x_cdma *cdma,
  */
 void host1x_cdma_update(struct host1x_cdma *cdma)
 {
-	mutex_lock(&cdma->lock);
-	update_cdma_locked(cdma);
-	mutex_unlock(&cdma->lock);
+	schedule_work(&cdma->update_work);
 }
diff --git a/drivers/gpu/host1x/cdma.h b/drivers/gpu/host1x/cdma.h
index 12c4327c4df0..7fd8168af4f9 100644
--- a/drivers/gpu/host1x/cdma.h
+++ b/drivers/gpu/host1x/cdma.h
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/list.h>
+#include <linux/workqueue.h>
 
 struct host1x_syncpt;
 struct host1x_userctx_timeout;
@@ -69,6 +70,7 @@ struct host1x_cdma {
 	struct buffer_timeout timeout;	/* channel's timeout state/wq */
 	bool running;
 	bool torndown;
+	struct work_struct update_work;
 };
 
 #define cdma_to_channel(cdma) container_of(cdma, struct host1x_channel, cdma)
diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index 732abe0750ff..8a3119fc5a77 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -278,6 +278,14 @@ static void channel_program_cdma(struct host1x_job *job)
 #endif
 }
 
+static void job_complete_callback(struct dma_fence *fence, struct dma_fence_cb *cb)
+{
+	struct host1x_job *job = container_of(cb, struct host1x_job, fence_cb);
+
+	/* Schedules CDMA update. */
+	host1x_cdma_update(&job->channel->cdma);
+}
+
 static int channel_submit(struct host1x_job *job)
 {
 	struct host1x_channel *ch = job->channel;
@@ -285,7 +293,6 @@ static int channel_submit(struct host1x_job *job)
 	u32 prev_max = 0;
 	u32 syncval;
 	int err;
-	struct host1x_waitlist *completed_waiter = NULL;
 	struct host1x *host = dev_get_drvdata(ch->dev->parent);
 
 	trace_host1x_channel_submit(dev_name(ch->dev),
@@ -298,14 +305,7 @@ static int channel_submit(struct host1x_job *job)
 	/* get submit lock */
 	err = mutex_lock_interruptible(&ch->submitlock);
 	if (err)
-		goto error;
-
-	completed_waiter = kzalloc(sizeof(*completed_waiter), GFP_KERNEL);
-	if (!completed_waiter) {
-		mutex_unlock(&ch->submitlock);
-		err = -ENOMEM;
-		goto error;
-	}
+		return err;
 
 	host1x_channel_set_streamid(ch);
 	host1x_enable_gather_filter(ch);
@@ -315,31 +315,37 @@ static int channel_submit(struct host1x_job *job)
 	err = host1x_cdma_begin(&ch->cdma, job);
 	if (err) {
 		mutex_unlock(&ch->submitlock);
-		goto error;
+		return err;
 	}
 
 	channel_program_cdma(job);
 	syncval = host1x_syncpt_read_max(sp);
 
+	/*
+	 * Create fence before submitting job to HW to avoid job completing
+	 * before the fence is set up.
+	 */
+	job->fence = host1x_fence_create(sp, syncval);
+	if (WARN(IS_ERR(job->fence), "Failed to create submit complete fence")) {
+		job->fence = NULL;
+	} else {
+		err = dma_fence_add_callback(job->fence, &job->fence_cb,
+					     job_complete_callback);
+	}
+
 	/* end CDMA submit & stash pinned hMems into sync queue */
 	host1x_cdma_end(&ch->cdma, job);
 
 	trace_host1x_channel_submitted(dev_name(ch->dev), prev_max, syncval);
 
-	/* schedule a submit complete interrupt */
-	err = host1x_intr_add_action(host, sp, syncval,
-				     HOST1X_INTR_ACTION_SUBMIT_COMPLETE, ch,
-				     completed_waiter, &job->waiter);
-	completed_waiter = NULL;
-	WARN(err, "Failed to set submit complete interrupt");
-
 	mutex_unlock(&ch->submitlock);
 
-	return 0;
+	if (err == -ENOENT)
+		host1x_cdma_update(&ch->cdma);
+	else
+		WARN(err, "Failed to set submit complete interrupt");
 
-error:
-	kfree(completed_waiter);
-	return err;
+	return 0;
 }
 
 static int host1x_channel_init(struct host1x_channel *ch, struct host1x *dev,
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index b2761aa03b95..3ed49e1fd933 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -88,9 +88,15 @@ static void job_free(struct kref *ref)
 	if (job->release)
 		job->release(job);
 
-	if (job->waiter)
-		host1x_intr_put_ref(job->syncpt->host, job->syncpt->id,
-				    job->waiter, false);
+	if (job->fence) {
+		/*
+		 * remove_callback is atomic w.r.t. fence signaling, so
+		 * after the call returns, we know that the callback is not
+		 * in execution, and the fence can be safely freed.
+		 */
+		dma_fence_remove_callback(job->fence, &job->fence_cb);
+		dma_fence_put(job->fence);
+	}
 
 	if (job->syncpt)
 		host1x_syncpt_put(job->syncpt);
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index dc55d9d3b94f..db6cf6f34361 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-direction.h>
+#include <linux/dma-fence.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -288,8 +289,9 @@ struct host1x_job {
 	u32 syncpt_incrs;
 	u32 syncpt_end;
 
-	/* Completion waiter ref */
-	void *waiter;
+	/* Completion fence for job tracking */
+	struct dma_fence *fence;
+	struct dma_fence_cb fence_cb;
 
 	/* Maximum time to wait for this job */
 	unsigned int timeout;
-- 
2.39.0

