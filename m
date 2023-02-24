Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900896A22BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjBXUCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBXUCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:02:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A5231DC;
        Fri, 24 Feb 2023 12:02:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ky4so653694plb.3;
        Fri, 24 Feb 2023 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=gBGdyrytMMtai+cnotBNgRYWcmeJ847XewFJda51kAb8/nryk4VPWYeo6WnGeqr/ib
         Z38zXiOt2/PJaBNCvg4J8afTwkAatILSkWbllJFbchya9js70V1jArUtpb+vMbf/HJQz
         Piksuw8wgQW0HYiOiOjb3ZlarmynmgNYPnVZYSbh+DcSulVoaUJbM4Z1uMon2TM+hM/h
         XUuOhPtP8rFevkNUXLE0ul0iQJsF1f01tHxkpRaZKqPabY8u4JtExrgzG74Uk/xhu4y8
         YsaNjOjrBaQKRI1R46XA9Cj0cGHyVKwC80ge8zynfJ+/CN37pPfFjF7FwmHJO6fyS0xW
         bVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=Py3qe73vtBDNV0qw4NvDbKOkOGFcHmG9pYbLZGXkSo/3X4vs7ZwGhjBNtn38UnwFYb
         sBRv/thCMKgYr4pnmxz2sigdtEdHEWQhCHvs2qmfULuDgyl8KNjv3vtm1stJ0tEIRGjP
         PTOM95EpDDj/gu1IBtVVKkW8ns79k5Ty8A6GJkJ1v/edbindoTnu0EW2ckEyXF8UcUR1
         ZxqcEbU8oyvyN1QRWi4BhbiDIsmpXlboiSOxs5JNuccnQ1GkTb2FEyd53Jbzo5tcyZn7
         CD4/Lim6O4SCPDW8PyG/ueDFCTY3owp77iyfT7b/5L5JSR6d+fNKPReYF6d9K+5iYYBY
         /1EQ==
X-Gm-Message-State: AO0yUKVw76oZukqUlmxw/cg3GNToZ9NDU378DJFkcyRyevxUyuZ+yzTZ
        6vatzL954ItzDX2n4PyUpVc=
X-Google-Smtp-Source: AK7set/Kb1gXpnZFU2Ydyaifih98zDZ6wbcQF//PkQ/+Dlh0wE5fq6Lk5cn+4EktKB1GNubNLYLuDw==
X-Received: by 2002:a17:902:d4ce:b0:19a:b6bf:1e16 with SMTP id o14-20020a170902d4ce00b0019ab6bf1e16mr19838114plg.51.1677268923860;
        Fri, 24 Feb 2023 12:02:03 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b0019cb131b8a5sm4769703plb.32.2023.02.24.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:02:03 -0800 (PST)
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
Subject: [PATCH v6 02/15] dma-buf/fence-array: Add fence deadline support
Date:   Fri, 24 Feb 2023 12:01:30 -0800
Message-Id: <20230224200155.2510320-3-robdclark@gmail.com>
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

