Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED16A630A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjB1W66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjB1W6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:52 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637B37561;
        Tue, 28 Feb 2023 14:58:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z2so12075734plf.12;
        Tue, 28 Feb 2023 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=iGeMiebQfqsdLsgfABMInDPpT0eCDWnY0bzKQhv2CEK5EhNIGoZOLHqDdURijdTLsT
         +PiOl3C4N/66W6S4Zn1dpELV3QiV6uZw6GL7FtQmAqYXs/dp7KpDi1rY3SSGsRw2IuKJ
         MYDpJa/CAyYlfptDxaiFX5Sxk0RHd210tlZZzX/ENHFKYfyjSLeN83Jd673nhkqFlhks
         3lS6d83mRgRQLMOGjTQ4NIpV1LbsLGQj3ZY20dWXxMKTJl7wAGjuSYTymviyFVONhDQO
         /h1ixSkuGOQocfvMea8hCQFO6Q9jMGq0BUJ2pGhX06po7S3fI5IzEn/BykmD7GfNwsqN
         Cknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=2g594DGizPTLWE39PdXrzXBP+LHOdLhv4+wN2mHtRdmTG4zmnDeseySN05GseCpcxK
         ttFxyx/+gBQOep9PPlwQc3C4106N/WPySj9JPpKYOXSRQEzT0S5Z0/mAN5TlM+FYGthB
         /VSZd8wcPxR7rFJ7vjjSxjOvi4bC+V3tAnAviDfsFZbxlpXunUIbGmx8b06VPn413ag3
         I1W+FF++56XCP008n/xyqsesPbQlsVRMXW7zNQWhLJneLBTrOTbYqWFMMPFUIUxnXMt2
         e38Ydb8AxNTywfVtppY07AzezUjKJrT6cd7aFuSVCATNq4D3hkf15U1UxXn/gyAMyvNU
         YPTg==
X-Gm-Message-State: AO0yUKWX1oHX4vmSd4U1dzb8tNPTcOATCrv7wYv2orEUo6CMT/sMUZWL
        e00onrSVEzzugivDabn+nLo=
X-Google-Smtp-Source: AK7set/qSAFUDC45HBseJqwMlAjQHk2jNVtF8Z2udb0yAH2yK0d9B7OWEfmAbvw/WktVeXd6kfqeNw==
X-Received: by 2002:a17:903:2303:b0:19a:a546:2959 with SMTP id d3-20020a170903230300b0019aa5462959mr14042960plh.19.1677625126132;
        Tue, 28 Feb 2023 14:58:46 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902e98400b0019a82ff8c38sm7028424plb.29.2023.02.28.14.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:45 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 04/16] dma-buf/dma-resv: Add a way to set fence deadline
Date:   Tue, 28 Feb 2023 14:58:08 -0800
Message-Id: <20230228225833.2920879-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228225833.2920879-1-robdclark@gmail.com>
References: <20230228225833.2920879-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a way to set a deadline on remaining resv fences according to the
requested usage.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-resv.c | 22 ++++++++++++++++++++++
 include/linux/dma-resv.h   |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 1c76aed8e262..2a594b754af1 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -684,6 +684,28 @@ long dma_resv_wait_timeout(struct dma_resv *obj, enum dma_resv_usage usage,
 }
 EXPORT_SYMBOL_GPL(dma_resv_wait_timeout);
 
+/**
+ * dma_resv_set_deadline - Set a deadline on reservation's objects fences
+ * @obj: the reservation object
+ * @usage: controls which fences to include, see enum dma_resv_usage.
+ * @deadline: the requested deadline (MONOTONIC)
+ *
+ * May be called without holding the dma_resv lock.  Sets @deadline on
+ * all fences filtered by @usage.
+ */
+void dma_resv_set_deadline(struct dma_resv *obj, enum dma_resv_usage usage,
+			   ktime_t deadline)
+{
+	struct dma_resv_iter cursor;
+	struct dma_fence *fence;
+
+	dma_resv_iter_begin(&cursor, obj, usage);
+	dma_resv_for_each_fence_unlocked(&cursor, fence) {
+		dma_fence_set_deadline(fence, deadline);
+	}
+	dma_resv_iter_end(&cursor);
+}
+EXPORT_SYMBOL_GPL(dma_resv_set_deadline);
 
 /**
  * dma_resv_test_signaled - Test if a reservation object's fences have been
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 0637659a702c..8d0e34dad446 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -479,6 +479,8 @@ int dma_resv_get_singleton(struct dma_resv *obj, enum dma_resv_usage usage,
 int dma_resv_copy_fences(struct dma_resv *dst, struct dma_resv *src);
 long dma_resv_wait_timeout(struct dma_resv *obj, enum dma_resv_usage usage,
 			   bool intr, unsigned long timeout);
+void dma_resv_set_deadline(struct dma_resv *obj, enum dma_resv_usage usage,
+			   ktime_t deadline);
 bool dma_resv_test_signaled(struct dma_resv *obj, enum dma_resv_usage usage);
 void dma_resv_describe(struct dma_resv *obj, struct seq_file *seq);
 
-- 
2.39.1

