Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED36A4B07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjB0TgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjB0Tfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:35:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7400E93F6;
        Mon, 27 Feb 2023 11:35:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oj5so3365467pjb.5;
        Mon, 27 Feb 2023 11:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=X/q1O+ZjV77fFoFmlutTEvpBGJueKF62goh9oezUzKs0YuCwyml4JbObsSCKbJT7JJ
         Ui2mwUw8xWQ5zAfkS8BdHCASqtnYmQkZXr/bJed/zVD5wE9mniBdhWRVLkle/VxdlecU
         EYBRwij8IxedCpNP6P8fBKe0OxTQeT6uksuCmf1kLP2B0/+VLWcxVR3r9hf9HstT29wZ
         NRbPkx+hAiOd2Ot9e6+DDrHanEKhBYQjZqGn7kUviCnLWtHhYm8bUrnS+Nyr9cHEFBRD
         L00cCCQln0V7zr854vwSpgsMzu6N3GTblVnUK03+zodB8MxhMlB0d5BP1fJZFRj+eSqq
         l76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=6BaM3Gw7ipj1cSEZ6T7/UmNh2z86f9EAHwAd8cuMnklxENyRbrBfGdejDSBtNvSh1q
         KRd5rT8+sqZb+OGudZq+aUcYmVdlcncnrnc5VvuJdC6oHkWm33nV+3JInJr2oZqy/rNU
         9PJxEHusqy04Osi8mXZAJSCpDW/Ykg+Ii4CodQRs7FEgrwxeHPxZdeV4rs9mXLZBrChL
         chwJKUnKqETYGZjkqKBaFzUgGp7QcKVgT/L07EbWZUNaCu664NO4SguK+P7J8Bo6M4Sc
         9XxfGIA4yJD3SnKHE+0qirVPpEAH6rUIHUgypKpkXvveSvNAXR29QvuHP+Pl4e/nGV9j
         QVag==
X-Gm-Message-State: AO0yUKVKUuxne4NN+0YnWz4+0y+J1WWS+SqPpjwxw4xhsHCBipcgZWGX
        PJc8SYCMHz8VzeqFKpLxjNs=
X-Google-Smtp-Source: AK7set9N4lsFjy2RVODKG+NOcQZxVca6+ZqrLKo0+d5nuJz3ER974n1Njl6HYvE9R2QPaFG+ddOexA==
X-Received: by 2002:a05:6a20:12ce:b0:cc:1996:9828 with SMTP id v14-20020a056a2012ce00b000cc19969828mr538145pzg.34.1677526552835;
        Mon, 27 Feb 2023 11:35:52 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id z9-20020a656109000000b004d4547cc0f7sm4322113pgu.18.2023.02.27.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 11:35:52 -0800 (PST)
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
Subject: [PATCH v7 02/15] dma-buf/fence-array: Add fence deadline support
Date:   Mon, 27 Feb 2023 11:35:08 -0800
Message-Id: <20230227193535.2822389-3-robdclark@gmail.com>
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

