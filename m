Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1226A22D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBXUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBXUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647760D5E;
        Fri, 24 Feb 2023 12:02:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so355830pja.5;
        Fri, 24 Feb 2023 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=DXggLen98SswuMy6LWqXGQsVk+Kl+HCfw0GV1eAOFvn+k5vSTK02Ocr5Lbsyxv6vfh
         G20mSjTIjOf259aIQo9lioVuf2337pFt9wQRSOGi8YqoroNnPJKx2D4Mr0xHfHSxCGT7
         akg3hVHnOWkFuSiethSqYeWo7JDzOhnrfIoSCv7bq9Cg9YoLldU3y0kGrbBbMx0pQ+2p
         08cG5QwY8KRM5ilt4+qiozXhQ1XkMPB9i3dsYB6XbH95KMc8X6/uhu8+apx8JqhHqY4x
         6FZc7CMmgBc7sW4c5ct5na3F6MPDyh0tfN48fiZnvYPLT38xxShI5xvb/D2DWLAmHqBB
         a37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=Fr21Vkn14CSnmQWfOhtfpxTQw4cakxAXDQSWQQKJN4aI5lmtW690oMQ4c4Au03i2eu
         0ZEPgGGdYCbslUrr0uqslk/rfCJeIaoGT8NtSl+US8gRwdJXTiIX3VLd0uydGK/2ZH2r
         D5wTKxQg+qJoFjw0V9vjEU01UvtsDPDXTDRuuvQGRfujer5Q7BA8dgrp4eqrQlTTJXtG
         hDlGIIVQY+vR2pUBtxViFCqI3ZlzrHBbVkgWSqLVXdhUAUklsMXudPddMc9+nmPH8f+A
         fmCofRHW5gDWffKZguBBBkgMiT14GNFcLa/zAbt/8SUuqV9s3SGruTDrcCeZtq/lKwpu
         DEcg==
X-Gm-Message-State: AO0yUKX6CkI8qO3KhA+Auq/Qy8p308gacl6RLxP+Dbx7cfIXskOnabRA
        rgt6UUTiXY62VtDxKxdoWLA=
X-Google-Smtp-Source: AK7set+7gPv2NZgQnRNjYEEsoK8icNOajvOd/YFLS5f1LxWqWPzjxCeauf+X33arB9Ab3jCkqEV4GA==
X-Received: by 2002:a17:90b:33cf:b0:237:b92f:39d1 with SMTP id lk15-20020a17090b33cf00b00237b92f39d1mr644702pjb.0.1677268925626;
        Fri, 24 Feb 2023 12:02:05 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090abf9000b0023440af7aafsm61128pjs.9.2023.02.24.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:05 -0800 (PST)
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
Subject: [PATCH v6 03/15] dma-buf/fence-chain: Add fence deadline support
Date:   Fri, 24 Feb 2023 12:01:31 -0800
Message-Id: <20230224200155.2510320-4-robdclark@gmail.com>
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

