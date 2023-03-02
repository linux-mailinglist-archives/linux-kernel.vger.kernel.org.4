Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F066A8D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCBXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCBXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42965158AF;
        Thu,  2 Mar 2023 15:54:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ky4so1006482plb.3;
        Thu, 02 Mar 2023 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=NgK5QtszZ34lTuRCDFR83nPJyn+DB4rxTP0xE2Tk42ck5MrS8xMf8+Res005BFWuUk
         OiuxWxoPYxy985tYupfANAIrsky/jHuQ0bpw0XrNrep1WFn2j77wuC2WfXhWBQrMh2KG
         evUciIFKtkiC5/Hmp/8FmBzb9+e5Vo7L6cnn6JIueIthHxAVhn335lRK8rGh5mGIius4
         Wa8k5qiZYL/4YmTU7abiVzfN5/DUGErsbDi1RVQ8/Tenm/Tt8tNy7WPC+INzuVg/caoS
         m+ubGaCAgoPAqn+oSkkBszkky6JbiZxyGBXxNkFY9Ckw1BDh1V34yYFBDyAdvi6yg4k8
         BRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=aLSMqimqURe1v3N40fvJemktFtcAcWXWl4UyvHJTmhtYI23nhuq1J0ySCTj1iMuwu3
         LM4YMFgVg9HF96tSQ2IRukJXJaUgUCmbIQF/XICzV1KXIDMZkCVcM9BBKmjSvzvMJl1L
         WklXI5GZAULy/BR0n4iRHRhgOpg3rcT4s5RSLAJPIjz6NNLtCqThmh4Hwqb28xB4jD07
         el6rJORFldSmPLvA9x3yteIFYGryuOXJ2LuRIrsXS9T0VbNMjRzeP6fgpKawLUlJkGp/
         l79UYkfkxusa+OD/VOBIP+Az4eP7X9cYGjNWy7XqyhlQpDeDqsEma0h5WUfgMLx0FqBN
         Me9g==
X-Gm-Message-State: AO0yUKViUN+mWhdnYTf3R4oZw5kw9jpY/MAgm5FtuXdOvMdM1N7ooRd6
        SAX9Gp3OjVhVYKlZrGylWtI=
X-Google-Smtp-Source: AK7set/jeW66C3SIqgDS1jGcRzwkcvjfPVt1xDGPtA139q1orfwZ9smn/0e+p7xdiCiKqaxbrcx5WA==
X-Received: by 2002:a05:6a20:12c3:b0:c7:40f8:73d3 with SMTP id v3-20020a056a2012c300b000c740f873d3mr261340pzg.33.1677801242601;
        Thu, 02 Mar 2023 15:54:02 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id 35-20020a631763000000b004ecd14297f2sm227996pgx.10.2023.03.02.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:02 -0800 (PST)
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
Subject: [PATCH v9 02/15] dma-buf/fence-array: Add fence deadline support
Date:   Thu,  2 Mar 2023 15:53:24 -0800
Message-Id: <20230302235356.3148279-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302235356.3148279-1-robdclark@gmail.com>
References: <20230302235356.3148279-1-robdclark@gmail.com>
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

