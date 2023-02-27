Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5466A4B12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjB0TgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjB0Tf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C7D26862;
        Mon, 27 Feb 2023 11:35:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y10so4250729pfi.8;
        Mon, 27 Feb 2023 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=IofvGIg7v0q9/BHZLXdPmLDeSmgAtoZVqG+mXihE0S+0d+qzirH8kedP8BKu0RTXuS
         WitWaOJO2oIKRToZhZxyd9wfcHC82ufAnF8BC1jYHBhTOCrgUCwZ4ptcZAvi4AQE3Jho
         uSUaWKJ47rWHnfrdPF27UTTBvFW6YWQKPyGJISNQVvqlSHEMJnl34ew7vgnQtnuud02E
         Vvv4F3PAHKsRk48IU6rqkQEXl2FbUk8tfca4hYVLqCiHaMiQl0lzKCm4xPEHk9idCJo0
         BCfdvtnlDzG9WDnQcGETWzgxa8HYgHzqqquhYqHSFEnFDZfi7its/fdPp4JVw5c1M529
         DeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=OE/ACOJ3yzJ47mAbTrmt953uEuBQQWGRI4GnbfDYcFbs7zyEpKVOmt8B6RDUCF86B5
         HUxPusZ4a2VrxkQ/iQxBwZF/K8DLn3/kCFcw7gEiX3ilw3Qi/l7zghac6UM3xxNAzWXM
         opXQhSIQoO0byXpRQauhJtSwAVws1SOy5CW6C3HH1kQyMtW4jN3yIkxSl6u4YXa1iJxd
         +KW7ia/qJW89RnzBsP5bZ6Ib1uyWKh+p9AVt8EW/iKPp8z27PNEV6uOwTkRXrsyp9YRE
         kyGHol3s1+mqgHaPDTDEsocSNR6CNZ/ZCzhmRlyzoPl5XYywV2b3LZYp/9mImgYKeU/D
         P7rA==
X-Gm-Message-State: AO0yUKWKnXDf4My57VbXd/DX5JWoHl2Qsrst79C5AE3631SY1DuuEt3f
        /zi8wPG4kBBpsnXJtPFrMwE=
X-Google-Smtp-Source: AK7set91F4YWA4WtPX00cj5zkJ/hv6gTn+7Cs9PmKxfQ7w9oL83mOhSoeAYEpaP9wrPMrjVVEWI2vA==
X-Received: by 2002:a62:2903:0:b0:5a8:ab3d:3fe with SMTP id p3-20020a622903000000b005a8ab3d03femr47064pfp.16.1677526554748;
        Mon, 27 Feb 2023 11:35:54 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7868f000000b0058e1b55391esm4697531pfo.178.2023.02.27.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:35:54 -0800 (PST)
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
Subject: [PATCH v7 03/15] dma-buf/fence-chain: Add fence deadline support
Date:   Mon, 27 Feb 2023 11:35:09 -0800
Message-Id: <20230227193535.2822389-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227193535.2822389-1-robdclark@gmail.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
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

