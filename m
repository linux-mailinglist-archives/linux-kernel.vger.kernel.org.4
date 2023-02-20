Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5C69D4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBTUTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBTUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:27 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989518B3A;
        Mon, 20 Feb 2023 12:19:24 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c32so1341124pgc.7;
        Mon, 20 Feb 2023 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5If47abMxVvdOGe/2jH89dN5UVVTGLmcg6EQzMCdPac=;
        b=YzeOmopCn0gh++/gAGcFEfcXWPP1jVMzasozIMD7Gnkw8K3NyhlEHe1zc8el3aD0Vx
         CIjGOhfZLHb/eeQuNytwDrZu2MoSPDSzBx0NkJozDbP/hff1JNpcf2JBAIZfOu4xeUEk
         +zOyP81obkNmacqYNnkI/8yrUexPNt23g3fRPvuMaEXgoQIpCMGtdvsH2gFRg7OLk4HQ
         DlyJkIqao3kfB+qsI6mVx2PKcGPpW6oE1VQU/ZgJ4BErwqSEE0o8LhrAJChvdIFMFXmY
         FFXESxU7CgmFAJRaj8/2sXKYQmNzH+0DmG3t+TEr8o4FPil3h4k4nq2uUgFAqGXt3R3M
         6feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5If47abMxVvdOGe/2jH89dN5UVVTGLmcg6EQzMCdPac=;
        b=cV9WMwpx/JmzxJXfTZC+76cmvnKxjfXjeQaelB5iQqDRcrXgi8eCgwx9T1x4c0PvKy
         5G4mB/rj01B6PGdEkEcv/eZs67L79jq17cojxx5rOQaENPBRpy9PB4ivqCco1PUr27Xj
         oQAEpkB2u1Nim/jLEzLiLL4DkcmpEY7rnB0FB9BmZnvhQ7s1gFud0TWPNqHUMoRd3Rpf
         48pqIXR6PqtbJn27fHJaQJ/yGoIYXwpH00bsIQsOHxJMKiDIp7RII3B1Mjeh2PhbuL6P
         8tGY7jVOaWFfUDSoVh/6FL0S/XxBENWpWxFxJxDrbXWDs7nLrU1EbiJ/J8MQLfhfOjeF
         cQcQ==
X-Gm-Message-State: AO0yUKV8HOb4jVGAmxuM+gh+PcNhEP1L3qG3ExEuTCllF0Kt988EmZnF
        el8pnSvpFPfC1/O2UtWQMj0=
X-Google-Smtp-Source: AK7set9GUlIkvZiMMJHbL1YlDHIQPYuqsE3eGFqhvDr4pSZzxB82JJDY+CxjmHJJWkP5dBcF/eD+Jw==
X-Received: by 2002:a62:7911:0:b0:5a9:c16f:b4ea with SMTP id u17-20020a627911000000b005a9c16fb4eamr1495085pfc.7.1676924363589;
        Mon, 20 Feb 2023 12:19:23 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id c6-20020a62e806000000b00593e4e6516csm390202pfi.124.2023.02.20.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:23 -0800 (PST)
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
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 03/14] dma-buf/fence-chain: Add fence deadline support
Date:   Mon, 20 Feb 2023 12:18:50 -0800
Message-Id: <20230220201916.1822214-4-robdclark@gmail.com>
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

Propagate the deadline to all the fences in the chain.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com> for this one.
---
 drivers/dma-buf/dma-fence-chain.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a0d920576ba6..4684874af612 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -206,6 +206,18 @@ static void dma_fence_chain_release(struct dma_fence *fence)
 	dma_fence_free(fence);
 }
 
+
+static void dma_fence_chain_set_deadline(struct dma_fence *fence,
+					 ktime_t deadline)
+{
+	dma_fence_chain_for_each(fence, fence) {
+		struct dma_fence_chain *chain = to_dma_fence_chain(fence);
+		struct dma_fence *f = chain ? chain->fence : fence;
+
+		dma_fence_set_deadline(f, deadline);
+	}
+}
+
 const struct dma_fence_ops dma_fence_chain_ops = {
 	.use_64bit_seqno = true,
 	.get_driver_name = dma_fence_chain_get_driver_name,
@@ -213,6 +225,7 @@ const struct dma_fence_ops dma_fence_chain_ops = {
 	.enable_signaling = dma_fence_chain_enable_signaling,
 	.signaled = dma_fence_chain_signaled,
 	.release = dma_fence_chain_release,
+	.set_deadline = dma_fence_chain_set_deadline,
 };
 EXPORT_SYMBOL(dma_fence_chain_ops);
 
-- 
2.39.1

