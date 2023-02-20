Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7469D4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBTUTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBTUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAE1A679;
        Mon, 20 Feb 2023 12:19:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so1637091pjn.1;
        Mon, 20 Feb 2023 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=TLl/TPdqwtRVyveoqEQwyAPlXFgjLvNAuBIDILQ7Oea8iShNEbj69MwDSh/ZP2fh6c
         TV1oOrQe0ax0dddlxozQsiJDUBwCnQRl3HXHq47Nn4DMjkNY4G2zL+SVcy36iMieZbup
         afcG/xfi/AK0Meeb6pxNWibWBy77ENmfnk+NDvcNXQYxyLEBF2gE5SyMvWisXrYlPfWP
         MTsyf12mxXXsXfO9FE5gvS40BYBJ2pdxeef8KaLJMLJgpTDxzdVKVgB6ALvJC8MEuDJ4
         4oYX/Nhw3xsvftd2XfRdtU9Svkyxdl7GrHIR1Fwh1pBSL35Gzh5tgAZR9tpSjJu/Sq+p
         Dtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUhwCn+Xf/Lh0tYXdZ7kyW7NLgJoG2FRHZEn6JIAUnU=;
        b=KHrnKazFo8AukGGEGTI++Tzv2FzL+tlXoOtKa7bfy8887/pQ2ePUV+wYV3lzWlj72l
         hSP1SYYJwd8pPFL18hYZOtOU5vp99H6LaTwFk9VWd+vwYltpECNmgtSwnBW18u0iYOMy
         OLdeELvYONRJKLwfefugrO1GqW0CjiMjZiuReWRFKUNOLKsJM7cG9zitYnjUu77m/kT1
         9G80vnP6zcV7wY6G9xQ3BOhtUj6PECQr3XgogdVzvylHWApawS/ftiOVTrreWiUp3Yig
         cHvNHDrngKvZvF4sV5ua8gDRXpQ40i7W61g8GkCq2QTPZz8Xs+B+FYI+kFaFcSyEDMoT
         +ytw==
X-Gm-Message-State: AO0yUKWS/2EQRsf2qRFlGXLFG24+yi7axckyEV1ydlvK1NS26utbAtf+
        F5mzCrh4uT+ueBZ/ulRZYkk=
X-Google-Smtp-Source: AK7set91Mua/G9JK+x+xMWNddOlWiq3csiO2OiGxMIoS16V6T9Bxz3GsDOwmPM60j3SHNpJw0pgOLg==
X-Received: by 2002:a17:903:1d2:b0:19a:a815:2868 with SMTP id e18-20020a17090301d200b0019aa8152868mr2217276plh.44.1676924365081;
        Mon, 20 Feb 2023 12:19:25 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id je13-20020a170903264d00b0019a74afe97dsm8306264plb.187.2023.02.20.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:24 -0800 (PST)
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 04/14] dma-buf/dma-resv: Add a way to set fence deadline
Date:   Mon, 20 Feb 2023 12:18:51 -0800
Message-Id: <20230220201916.1822214-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220201916.1822214-1-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
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

