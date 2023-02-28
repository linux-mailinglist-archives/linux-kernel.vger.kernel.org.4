Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3A6A6301
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjB1W6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB1W6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:58:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B51367E4;
        Tue, 28 Feb 2023 14:58:42 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s17so6668721pgv.4;
        Tue, 28 Feb 2023 14:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677625122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=hjK19G1y+9t6kEMLTgqI6C/R9VHYBU8KBYhFV7faYo5HB8p84Etyo1UAtA4iWCe1Hw
         uvND31JQjTYo2r32ygNrWaVDjWv/k3qvc7jrwqSIvMOAvHHpN8jKYTOwjzjPEBwJF+xk
         fixbNihhLTq9GC9AHCP7pa2dUcgktiXvIpq6ywnlV8qD4FM2Cf4nmfnqsdyA+tM9x6dC
         PUZLj+wlw7lH/NXnxKpo3cMYVn1Az9DXvTODKEgwKa2d8nXZplZnzfnMCiBrQ/52lH1z
         G/Ib2B5EMaZT8bcidj1SSHKcOYNFX+rk8Z++HJWMFKHxBKm9i//i20Kz4CS16SO3CIxl
         uL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677625122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=HigY3gRter5nkc/Ef4g72R0aTrj/Mw/WGQqpGJbo18JZH9Wzz5i8W/xKq85HrpzU+p
         myskEdaIOp3k49g4STDg2Jj6aN3nyNSg8uKFC0RX27kXyMOZr199dmz8jqvES8AloTPz
         9x4GP2DDEc9N5aDHCO/vZyygVp4whgMwwgh7hwKGQ8oFCGvkl7V+JtpRBqlZKO0kHElY
         sRh599uVYk9BIUopZ1bimh9rGXkvF6y+amho7Rvje5O68xPBxFUopaAJt6nyeysvyQ7t
         SBCeGfn7sFF8esl857nN5yrnFQ1+Bjv6M6hgJif6hlrnfxO7pWIUjFElculRX8/NThAZ
         ULHg==
X-Gm-Message-State: AO0yUKUVa5XpfVMiczWUa6D7pf5B0kSnwcDTr+VCJFJj9XVJjxo584Td
        c987mgmDCb03accUfZwASSM=
X-Google-Smtp-Source: AK7set+hi0qZn6Ym8wkRncFCDDbYo/eyvE+1U2XGQCuwaskjeQT9FqYxsMx6ZcsoNBBDuF7tCnd7MQ==
X-Received: by 2002:a05:6a00:3002:b0:5ff:f1df:d82f with SMTP id ay2-20020a056a00300200b005fff1dfd82fmr4217882pfb.1.1677625121947;
        Tue, 28 Feb 2023 14:58:41 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b005813f365afcsm6552280pfd.189.2023.02.28.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:58:41 -0800 (PST)
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
Subject: [PATCH v8 02/16] dma-buf/fence-array: Add fence deadline support
Date:   Tue, 28 Feb 2023 14:58:06 -0800
Message-Id: <20230228225833.2920879-3-robdclark@gmail.com>
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

