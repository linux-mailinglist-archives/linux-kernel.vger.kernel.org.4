Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2F6B5F19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCKRg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCKRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:36:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B74DBF3;
        Sat, 11 Mar 2023 09:35:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q65-20020a17090a17c700b0023b3ad9572cso1321908pja.5;
        Sat, 11 Mar 2023 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678556121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hNSHVjc/0wTeCW3nY6/+a9GNb2nn01SoihN24q763w=;
        b=qozX8RZWE3nHsqGuYQWSGXKqdwuAcYURpfSiPFM9IP29zTKQOtipy8O/GmxSMJd7GU
         G2eiwcoB+mZyXyLDDUXpvQ7FntLF34u0AGf6oVPRNvrgFPSQwnLthOpkXclgCkzIqykt
         XsFgRCjAXEqj4EvvpW6GGf+KBFrVNZHFygWILrctRWcxZJnKTE9DyEZcwP1YvleOa+DC
         2VgJC3j67jilPpeIrAebn3TD7PpNA+M808wXx+2MqDd0zqNtlM6oAtz198FTC6Q43b3b
         YUVGwybEQz8Kyf3aPaizKZdRKVASFecfZMRWiPpeNxvucRWy6vbAyz/rshPX/NcgukYy
         vGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hNSHVjc/0wTeCW3nY6/+a9GNb2nn01SoihN24q763w=;
        b=HNMXZpz+hUSMN8ZfpbL7VJSk4IZUeCI3kUsem4AHEdiJnwnBpyTiR3UrXCOKwutU3Z
         bhDPshBfMkUo1Md6VvWTa/Rmnt47V0i77qc58XJfln7lwkydAHtyyToog4WlKgUNYq00
         YC+GnrByeJIKm67qStXufvTa6t6aCFSN+Q548JTskuKIyhcaID8WRJ4zoULCcOMlhvU/
         jdqTHlKQAZ55KBIBdl1aBk5R7SX4ujuOt85iRI62XWhZthgy55SSQ5PoCq3ZYqvkFIRu
         6OO/CS8A5EK4DQGgauy6G0zk3zIqnzE8BXIts1kgTiYdn4dvaqaJo0IDjWzqypvu7ePK
         oQmg==
X-Gm-Message-State: AO0yUKUozpxTn+QHhAyc6s/0FrO4Demsr0sYWgQcN9rTw6OtBnRQeHh6
        mJ9qvYf8sih3tJMeW2hH+Vs=
X-Google-Smtp-Source: AK7set/92Kp+D6kfQAUn3G1hZMxs+D8jdl0o6Nhu2rBS+JMWAaAnTBNrnC1jHmBus8UctLlXZ2k6Xw==
X-Received: by 2002:a05:6a20:1589:b0:cc:3f87:a80c with SMTP id h9-20020a056a20158900b000cc3f87a80cmr33316270pzj.3.1678556120656;
        Sat, 11 Mar 2023 09:35:20 -0800 (PST)
Received: from localhost ([2601:1c0:5080:d9fa:9b45:95de:f47d:f85e])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7815a000000b005d72e54a7e1sm1702285pfn.215.2023.03.11.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:35:20 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dma-buf/dma-fence: Add dma_fence_init_noref()
Date:   Sat, 11 Mar 2023 09:35:11 -0800
Message-Id: <20230311173513.1080397-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311173513.1080397-1-robdclark@gmail.com>
References: <20230311173513.1080397-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add a way to initialize a fence without touching the refcount.  This is
useful, for example, if the fence is embedded in a drm_sched_job.  In
this case the refcount will be initialized before the job is queued.
But the seqno of the hw_fence is not known until job_run().

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/dma-fence.c | 43 ++++++++++++++++++++++++++++---------
 include/linux/dma-fence.h   |  2 ++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 74e36f6d05b0..97c05a465cb4 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -989,28 +989,27 @@ void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq)
 EXPORT_SYMBOL(dma_fence_describe);
 
 /**
- * dma_fence_init - Initialize a custom fence.
+ * dma_fence_init_noref - Initialize a custom fence without initializing refcount.
  * @fence: the fence to initialize
  * @ops: the dma_fence_ops for operations on this fence
  * @lock: the irqsafe spinlock to use for locking this fence
  * @context: the execution context this fence is run on
  * @seqno: a linear increasing sequence number for this context
  *
- * Initializes an allocated fence, the caller doesn't have to keep its
- * refcount after committing with this fence, but it will need to hold a
- * refcount again if &dma_fence_ops.enable_signaling gets called.
- *
- * context and seqno are used for easy comparison between fences, allowing
- * to check which fence is later by simply using dma_fence_later().
+ * Like &dma_fence_init but does not initialize the refcount.  Suitable
+ * for cases where the fence is embedded in another struct which has it's
+ * refcount initialized before the fence is initialized.  Such as embedding
+ * in a &drm_sched_job, where the job is created before knowing the seqno
+ * of the hw_fence.
  */
 void
-dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
-	       spinlock_t *lock, u64 context, u64 seqno)
+dma_fence_init_noref(struct dma_fence *fence, const struct dma_fence_ops *ops,
+		     spinlock_t *lock, u64 context, u64 seqno)
 {
 	BUG_ON(!lock);
 	BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
+	BUG_ON(!kref_read(&fence->refcount));
 
-	kref_init(&fence->refcount);
 	fence->ops = ops;
 	INIT_LIST_HEAD(&fence->cb_list);
 	fence->lock = lock;
@@ -1021,4 +1020,28 @@ dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 
 	trace_dma_fence_init(fence);
 }
+EXPORT_SYMBOL(dma_fence_init_noref);
+
+/**
+ * dma_fence_init - Initialize a custom fence.
+ * @fence: the fence to initialize
+ * @ops: the dma_fence_ops for operations on this fence
+ * @lock: the irqsafe spinlock to use for locking this fence
+ * @context: the execution context this fence is run on
+ * @seqno: a linear increasing sequence number for this context
+ *
+ * Initializes an allocated fence, the caller doesn't have to keep its
+ * refcount after committing with this fence, but it will need to hold a
+ * refcount again if &dma_fence_ops.enable_signaling gets called.
+ *
+ * context and seqno are used for easy comparison between fences, allowing
+ * to check which fence is later by simply using dma_fence_later().
+ */
+void
+dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
+	       spinlock_t *lock, u64 context, u64 seqno)
+{
+	kref_init(&fence->refcount);
+	dma_fence_init_noref(fence, ops, lock, context, seqno);
+}
 EXPORT_SYMBOL(dma_fence_init);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index d54b595a0fe0..f617c78a2e0a 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -279,6 +279,8 @@ struct dma_fence_ops {
 	void (*set_deadline)(struct dma_fence *fence, ktime_t deadline);
 };
 
+void dma_fence_init_noref(struct dma_fence *fence, const struct dma_fence_ops *ops,
+			  spinlock_t *lock, u64 context, u64 seqno);
 void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
 		    spinlock_t *lock, u64 context, u64 seqno);
 
-- 
2.39.2

