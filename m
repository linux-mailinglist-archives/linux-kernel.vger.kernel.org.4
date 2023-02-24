Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C26A22D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjBXUCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBXUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98F231C4;
        Fri, 24 Feb 2023 12:02:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so401604pjz.1;
        Fri, 24 Feb 2023 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=h7cN33BrnH1bRUCoetglj/sOcYD45HkKi2VY5Gkd+phwRLedbcNJ3G7XFtE6917xBT
         egahxBduMjZRCnpuWY3YsHe+AbNZP/laI8eWmju9ZiLHFdQ9wrcNvcl7Vjl7ZtO6oLzJ
         SdFZJWaZTn33EW8pzn0d4b45438murDXudjvRYRH2QNsde4cnb9hByzs0ZcKzLYJBhEC
         e6/7C84Nk+9lpNUdlWkPs3AXmcjg3wkMUejblQsYzcoaFsoam4xVY5ESubkpfDesHDZ6
         2SzU5vXLc4Qlpxf0R8BE1FQNmnExqiINgfQmeMIpzCaSxUKI7GXztEOuO9JuCiWjpJK1
         mbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=pOPLnM1wQ0d7rKIn26hMxMidqP4KiT4TKCWSRRaqaZTL5aOXDdkAEfFyhEWR0HYyez
         4S8X28qI1tdeF1+LvJTZA1U/ZZvFnglqVjLRvIJqsPSRyVOQUZHKQiwIc7+yii6h37Sj
         QLBJkc1AnPUkTW6ud29m7dCUQaflFk4d3JV8BMi9AEbIPqhL1cJMiovUDWRdGoya4Ecw
         hDMPlVfF9ttyvvVptl6LsIeReTPueUbm7ILqXDkTOvpdAHuT3ghERh1T52dEasSLkbQQ
         LDb0pn45+P0gYsg5SnlDiEMAbEK7lDHD4JBT9gE37wTU/vRabhBavmybqvGEVBct8yMQ
         53hA==
X-Gm-Message-State: AO0yUKV9h+6bKALiUgTOg7K9FqWo/gWs5Gf5mILCGNP8s1ob+7vJQEgE
        C+33k6vcQyR6hYV3m9lLCWA=
X-Google-Smtp-Source: AK7set/OZA8f7pCtrbvKrWL0jPkHBC+o6LrHYg0KBjQGKxwuHHwYGtipmZlC2NhUCG1w5or8Xu19Nw==
X-Received: by 2002:a05:6a20:748c:b0:cc:50cd:e0bc with SMTP id p12-20020a056a20748c00b000cc50cde0bcmr1032966pzd.10.1677268927405;
        Fri, 24 Feb 2023 12:02:07 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78097000000b0058d54960eccsm8964196pff.151.2023.02.24.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:07 -0800 (PST)
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
Subject: [PATCH v6 04/15] dma-buf/dma-resv: Add a way to set fence deadline
Date:   Fri, 24 Feb 2023 12:01:32 -0800
Message-Id: <20230224200155.2510320-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224200155.2510320-1-robdclark@gmail.com>
References: <20230224200155.2510320-1-robdclark@gmail.com>
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

