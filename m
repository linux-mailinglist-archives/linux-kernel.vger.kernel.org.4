Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8606B0D85
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCHPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjCHPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:53:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386F8FBE7;
        Wed,  8 Mar 2023 07:53:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u5so18051310plq.7;
        Wed, 08 Mar 2023 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0O2Ww3Cm9WKvcOgcLWcXNiHRtUzq1XNv4cTGeNjGUs=;
        b=cKLTDwB0Xy7r9Ppx1Na+PUt8wGSmaLtS7mPtyVg1TcoZtWLLqiD42GBRsgcTokYjk/
         +o52Z76Vk2/EJPDg6TOZPJ2wr0ebyu/jrWhY2t7jcssnmD56pgTiiS26e/5bAnsbCDkS
         dam2mgWt8Cn5zCaBaM6123GRms9tvWowVnSpqMr5pdj7aDaJkySCCEw2heRKqV8ZHn8n
         fsz0o9F0wOklPSEPkjTOc91tffQHuDWyaycUGr/IKUCWRhozjDBQybV/CKv8NcAaH6rI
         cov6SDsFDN4JEMZujhnJis1V8E65zeWDjoazY2pw+iN3gBWH1T21Ur6IfpIZWNu7NH1b
         8xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0O2Ww3Cm9WKvcOgcLWcXNiHRtUzq1XNv4cTGeNjGUs=;
        b=lTYszKffjolazsjJMGMki2NkeY9gX3s4gpiclNydpJbmFCFCEI6Tu1L+bgJWOF9DoE
         sXdQQjL796V8Ge37FCATSXk4gX7oYWYtWqQVEPGsVn0kY7QOzPUgXfgq6fAOfrbhAO9F
         O/3HvrMnojjmqo07V9wBQeIH6euTFYpsZYSJJ/2C9JeSJ5JD2vCzMdfRqKre9CNSdEnN
         xCJPn1dRL3Coy70I8ls8UF1OHKgYFoHt6FqVJE7ztkQigIpAhUt2rr31Uy70tHLOZy1p
         diLJopFjd4C2xU6fTfQAImFm9ynCyjqDraMcN/9ZtN3jFzAu+3s5R/37k9oSxv5Fxkh9
         wnVw==
X-Gm-Message-State: AO0yUKUUpGFKlj5SYcM87Vyqar9D6B7JoY9OUrOj3OssztmvOrjX6A1g
        O8quLXP3Ac4hu1yAnkd1dgI+62wGrfE=
X-Google-Smtp-Source: AK7set96zWJ64oh1bpggyeyTLr/2ieL59AK11mtNd342xYu679A/tHaLq9ev58BsNkm68KVtEeIcOg==
X-Received: by 2002:a17:902:e80d:b0:19c:cb64:dacc with SMTP id u13-20020a170902e80d00b0019ccb64daccmr23386540plg.61.1678290817169;
        Wed, 08 Mar 2023 07:53:37 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b0019e88d9bed3sm9969603plg.210.2023.03.08.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:53:36 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 04/15] dma-buf/dma-resv: Add a way to set fence deadline
Date:   Wed,  8 Mar 2023 07:52:55 -0800
Message-Id: <20230308155322.344664-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
References: <20230308155322.344664-1-robdclark@gmail.com>
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
2.39.2

