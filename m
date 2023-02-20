Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9769D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjBTUTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:19:24 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BDBCDDD;
        Mon, 20 Feb 2023 12:19:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x24so1263173pfn.7;
        Mon, 20 Feb 2023 12:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=eNWnZdY7bb0sIPeM/dP+nfuIuObMIanncbZ+NRD8X1XJMJ3PtrtrWEi9KbjDnT/8w/
         4868uK4c3a+o7f87mCfBXFuvYydQ0cuDb9mH/m5cPTpxn/qovKcax5YMahSlLSjYQWnj
         cOhgi+GA0fYpdhHXJew7nHx03aK8aUQ8p5ZFGvXeOjgRTpbbfDaG4dcHiobo8k+1cZdr
         rdBw52ruPwcHMxTkGp2qw/JKV4NNoevhSbXnwZWXIRBNhlsTWdgG+NiAWOZqCVkeVTPm
         EKNybgNSFZ+jaB3UZq7n3CyDCiF7d7P5sjMF/me3F6e407AydxnfmvvF+ZJZ22/xu8M0
         auhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=CPN4K3/0BnxjgG2IYQ8jvbFoEHvz5drnR62avxUgOV7usC/q+ZqbTNi2OaG7G91YAm
         hxBudnpqPzy3dguEDzvuz/HU8BtDJhTn4y7PKLwsoSRrZx6MEzRWgp+ZangG1elQAIqK
         8zJlzgsUqqXs5OrPeaqp9hmvAFsb9DR0LykRBmGfGxl+mmUzoG6Q6GIoYxQ6LHOy0diD
         JxGtKMFf+ZDus418fsYTnDy/KmuwsNCSawtiecOLxBU/PH3bTv3coni4pto08iN6tp9T
         PmY3EWqUQJrprOLm2ZKMpV44oo44NLis3ZQ4pJR0c0rECi87boUP0YYfWR6aNma4Qb0U
         LHxg==
X-Gm-Message-State: AO0yUKU8dxfyL8eqqhHdXUe5V8ZKg5PYFvSAK8+Jwaly+bb6OZGQDfFD
        mvr9yvakLa3G4n/3BQO10/4=
X-Google-Smtp-Source: AK7set/IEnsknqrg1Kvv1r90ECUxuHVfyDcG96xSfQIiNKkRh0eFALUg+af5KU3PpovvGnGW2S9fJw==
X-Received: by 2002:a62:52d7:0:b0:5a9:d4fa:d3c7 with SMTP id g206-20020a6252d7000000b005a9d4fad3c7mr2485352pfb.7.1676924362392;
        Mon, 20 Feb 2023 12:19:22 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78754000000b005a9bf65b591sm7029643pfo.135.2023.02.20.12.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:19:22 -0800 (PST)
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
Subject: [PATCH v5 02/14] dma-buf/fence-array: Add fence deadline support
Date:   Mon, 20 Feb 2023 12:18:49 -0800
Message-Id: <20230220201916.1822214-3-robdclark@gmail.com>
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

Propagate the deadline to all the fences in the array.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-array.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 5c8a7084577b..9b3ce8948351 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -123,12 +123,23 @@ static void dma_fence_array_release(struct dma_fence *fence)
 	dma_fence_free(fence);
 }
 
+static void dma_fence_array_set_deadline(struct dma_fence *fence,
+					 ktime_t deadline)
+{
+	struct dma_fence_array *array = to_dma_fence_array(fence);
+	unsigned i;
+
+	for (i = 0; i < array->num_fences; ++i)
+		dma_fence_set_deadline(array->fences[i], deadline);
+}
+
 const struct dma_fence_ops dma_fence_array_ops = {
 	.get_driver_name = dma_fence_array_get_driver_name,
 	.get_timeline_name = dma_fence_array_get_timeline_name,
 	.enable_signaling = dma_fence_array_enable_signaling,
 	.signaled = dma_fence_array_signaled,
 	.release = dma_fence_array_release,
+	.set_deadline = dma_fence_array_set_deadline,
 };
 EXPORT_SYMBOL(dma_fence_array_ops);
 
-- 
2.39.1

