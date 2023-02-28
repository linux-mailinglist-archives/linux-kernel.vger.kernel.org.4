Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB706A6306
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB1W6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjB1W6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:47 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826714497;
        Tue, 28 Feb 2023 14:58:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id a2so1667628plm.4;
        Tue, 28 Feb 2023 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=ZagXoGgot3rF1P+jOmf47rOJFpEPyUG8PwWfOLPRh3xSQUqeeHDID7n0sh9Q00CXC3
         sgTAdPcGx0vTAaf91U7QFRQd7BtzPU9/xzZDsh6+1971e+/qbZEV4cga/gyzupQeV8K0
         JtSSXHn8OFX+595H3ttUaMjri3lpZR1Qu5ue9p/fl15Spmpkv1pspaa/8iap75dnBL9Q
         EnhUyOhaR/b2xtpJelKtQ96TzFznKM+M3+8KNNxu73yr1RsQVXCsCEu/YCrCjgVl652J
         s83rIBMH4UG72ZcVEGSRMUU9NDtiOfl+jopPOZqjr96ypXHI03MMtB8OixiovnAuGT4Y
         fyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=eAESnMfUpt4bF/FfRGJSXnHdqFkI6xbAes9DPCyHvFfPu9rmD8Drc04NV41Xm5dlKS
         gHy8qzSHkFHCqNNxHAp/tdLgYq/xEpi2utEPuYLtlSgn8BZZwtHFlvbrhJOlHW9tQcKP
         QsPaKJqyMAezjbRv9s4EtlaUbjUsAWFPFhDuZLo8cmymHwNS+/Azdyimlvv/ITK8CY3g
         legP2Zn4YGZoyl2mnE5AOmW4tsVb0eQZEbh7Zq7l6qug/H15fd35XwDJap/1KQ5OPaD5
         mR/U+Sss668p9T1CDb+trVXAW9EcZzy2iLwPRmO2rrGSflwYCtrXx9A0RUjuFIaCdU8K
         BgVQ==
X-Gm-Message-State: AO0yUKXAcvG/O7mqBSZPGH86tBETPAcMHCRct7jbe0VWT6YcQKkuOW+k
        yaGm5au2YgKsE0hQrSRUsiQ=
X-Google-Smtp-Source: AK7set8hoLg5bctNWbZ+82twM3+oK6UKHMtI4y7UbnnGjn/K5pWj4/SUHfnn3a/bFr2b/Fa26YHa9Q==
X-Received: by 2002:a17:902:d507:b0:19c:e9c4:cc13 with SMTP id b7-20020a170902d50700b0019ce9c4cc13mr4994218plg.25.1677625124037;
        Tue, 28 Feb 2023 14:58:44 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b00198f73f9d54sm6996620pls.117.2023.02.28.14.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:43 -0800 (PST)
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
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 03/16] dma-buf/fence-chain: Add fence deadline support
Date:   Tue, 28 Feb 2023 14:58:07 -0800
Message-Id: <20230228225833.2920879-4-robdclark@gmail.com>
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

Propagate the deadline to all the fences in the chain.

v2: Use dma_fence_chain_contained [Tvrtko]

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com> for this one.
---
 drivers/dma-buf/dma-fence-chain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a0d920576ba6..9663ba1bb6ac 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -206,6 +206,17 @@ static void dma_fence_chain_release(struct dma_fence *fence)
 	dma_fence_free(fence);
 }
 
+
+static void dma_fence_chain_set_deadline(struct dma_fence *fence,
+					 ktime_t deadline)
+{
+	dma_fence_chain_for_each(fence, fence) {
+		struct dma_fence *f = dma_fence_chain_contained(fence);
+
+		dma_fence_set_deadline(f, deadline);
+	}
+}
+
 const struct dma_fence_ops dma_fence_chain_ops = {
 	.use_64bit_seqno = true,
 	.get_driver_name = dma_fence_chain_get_driver_name,
@@ -213,6 +224,7 @@ const struct dma_fence_ops dma_fence_chain_ops = {
 	.enable_signaling = dma_fence_chain_enable_signaling,
 	.signaled = dma_fence_chain_signaled,
 	.release = dma_fence_chain_release,
+	.set_deadline = dma_fence_chain_set_deadline,
 };
 EXPORT_SYMBOL(dma_fence_chain_ops);
 
-- 
2.39.1

