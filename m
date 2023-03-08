Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE66B0D84
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjCHPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjCHPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:53:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16A8C969;
        Wed,  8 Mar 2023 07:53:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x34so16951542pjj.0;
        Wed, 08 Mar 2023 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcraofrhRDAdrHGa0UzQfcfeN59LkTANHVsK7xkfU0Q=;
        b=hpCfI9KDoIpsurVFvi6JvaCUXX5V8whc+Mt2IXW2uSOKz1Q5dxdtHiQPVq9AM6tUPq
         sCk6nrAsOY0qx5qi93O60+KSvFUlcqYXolDmY6IaV1mxU2SPBhwXNjArN22qgCeWCJJe
         fSRxj7YAkbEoJg+AsCJxxqqPGDHWTusIaKafAqQARUTvnru8GsWdU19lLWZjfZMnLG5q
         2aGL4M/jwCBSO49iC5E4wCZyOeonSOiwMDtNWhIQAZqezZ/H8I9KLd5FmTgctqbptQGE
         b0Jp2fx5HIZ7CuqdQOX1R9PbAc2Yj9x8cvWgU9S1PS2hlr985tWoNfwGVqQ33VOxtSUd
         DmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcraofrhRDAdrHGa0UzQfcfeN59LkTANHVsK7xkfU0Q=;
        b=HQwvOd87B4n0IyDqxeTo3G0i8ngpq+Fu14wO8uX4lSrcLTEW1ZTKhyRQG36VBFIDau
         suGwatpe4GPus16R6X2S4IUEg/ry9OnJxXuIeMvyFTun+LO/fDjaguZSoE0LGwTAJaF5
         fvSPJTtQuMXx4Emcd+LUq+LYwQ9lRcbWB3dXcNnrDJUveeMQPAE7AIzRckMJIByxwPOc
         g2GFbOmWnSRUy9ACOgshVsCPKJzYGgZQDAwwVg3ddBqqwtvxPgQSbd8mWHNt6e6RB58M
         djoWZg46qQEBXIWqL5+HQ7OxvK9F9+yXiIrEEcuohgES87weuj0wFfGfasQS7QR0Mq+J
         qZlQ==
X-Gm-Message-State: AO0yUKU8tb0JC9zRVHk5JLqSGdniWXg5CupAXGYlxA0nExIEB8D1xPWB
        YZZdreLW0dr3l0RM8YZEX0XAQ+a7C+M=
X-Google-Smtp-Source: AK7set/2eF5m88UMlszgcFp7cgo5yOQOxbJycIrpK9ko8JpPSABVkued0J6pMJtqfFLipyBKXl6Sjw==
X-Received: by 2002:a17:903:22c5:b0:198:fded:3b69 with SMTP id y5-20020a17090322c500b00198fded3b69mr23560954plg.53.1678290815231;
        Wed, 08 Mar 2023 07:53:35 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b001991942dde7sm9951550plk.125.2023.03.08.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:53:34 -0800 (PST)
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
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 03/15] dma-buf/fence-chain: Add fence deadline support
Date:   Wed,  8 Mar 2023 07:52:54 -0800
Message-Id: <20230308155322.344664-4-robdclark@gmail.com>
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
2.39.2

