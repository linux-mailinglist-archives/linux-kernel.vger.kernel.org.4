Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630DC69BC2C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBRVQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBRVPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:15:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280015C8C;
        Sat, 18 Feb 2023 13:15:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a5-20020a17090a70c500b00236679bc70cso13689pjm.4;
        Sat, 18 Feb 2023 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=792an2SD05nhQRGBlD0Pg2RQ7VfR74mQEP4A4mqZ6Pk=;
        b=HM20qQN2yIU6PxWiMZEoSu3nueB6cRdZunRf/0WsasLxrWwG6jTJzi54FYZ5B5NZGd
         oiDKEt41GpKHkAkJ5gTVtA1j+PltUu0tI95VttL8G5W+qQnSbySKu7+cSjvKNge6QQ5J
         Pj2F3mRJmuteKR/t3CJoExZNh0GN57mlIvR6bySQe8r5eZLlOCXNqZxX5bjf/dupH9z3
         IXqeOipa7lBiO9XbbbNImG/WCaemmgM46GgIE8Xh55pnP/LLLgxjXjr+DHt1NcdxFObQ
         14PQ97rq81/QGaBdPs+HGfOyKwPzT8UnCAi8zNIuZLDmVStTVtSKfIFcJehu18xb5BVp
         cE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=792an2SD05nhQRGBlD0Pg2RQ7VfR74mQEP4A4mqZ6Pk=;
        b=XmkjRTJUMuQzArRsYXYU+r3c9jw5UfF6rsTbn/sri85sibNdmoOzRFssTXU0cl4J2W
         BKqioXKYAkiT2mLOnHKYpLTZ4QS5RCWcRvhhmG8ZdS+rbxE9KQeNVofrWMEo4u6oL8mt
         awB+MsNmNQmjM41pkoqsCRDG458NJgsITQPKnFn2VZ6L9MHEKi89V9zNRsqjwE1yFQZI
         8N1J+uduDsYiWGbc7OU1SiS+5uDU3aBNA/WB252mRSisZyE1Pp7iwpipMDxtuST4jcXy
         jI/e5drvU5l68Sr/QLM56zvBLqTHZZ3oZ/+kd/SOwvR6diwShDYh4MUvewU+MpXoF3jI
         ZNiA==
X-Gm-Message-State: AO0yUKUj+K6wHyY473ZTULIS/PG4Xv8t0MhoodRJi3gFk7HcovHn5Mif
        L49ojjq/waezaNh6jM2s+Ck=
X-Google-Smtp-Source: AK7set/QRHtfFq0gaLBBtupUc42V0jJFczyxE24VpZirzrpITI3ga4mB8wxlcDavsOCQ4hY8/UcUUA==
X-Received: by 2002:a17:90a:357:b0:233:f990:d646 with SMTP id 23-20020a17090a035700b00233f990d646mr1577488pjf.35.1676754953521;
        Sat, 18 Feb 2023 13:15:53 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id bv21-20020a17090af19500b00231261061a5sm1254130pjb.5.2023.02.18.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:53 -0800 (PST)
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
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 04/14] dma-buf/dma-resv: Add a way to set fence deadline
Date:   Sat, 18 Feb 2023 13:15:47 -0800
Message-Id: <20230218211608.1630586-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
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

Add a way to set a deadline on remaining resv fences according to the
requested usage.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/dma-resv.c | 19 +++++++++++++++++++
 include/linux/dma-resv.h   |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 1c76aed8e262..0c86f6d577ab 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -684,6 +684,25 @@ long dma_resv_wait_timeout(struct dma_resv *obj, enum dma_resv_usage usage,
 }
 EXPORT_SYMBOL_GPL(dma_resv_wait_timeout);
 
+/**
+ * dma_resv_set_deadline - Set a deadline on reservation's objects fences
+ * @obj: the reservation object
+ * @usage: controls which fences to include, see enum dma_resv_usage.
+ * @deadline: the requested deadline (MONOTONIC)
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

