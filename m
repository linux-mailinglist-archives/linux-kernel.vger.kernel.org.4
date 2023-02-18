Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2569BC22
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBRVQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBRVPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:15:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B051421C;
        Sat, 18 Feb 2023 13:15:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w1so1556887plq.10;
        Sat, 18 Feb 2023 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5If47abMxVvdOGe/2jH89dN5UVVTGLmcg6EQzMCdPac=;
        b=CNTa3icUd804RiMnh5GApmZCXhp0f7037aAPuvfSQytTW0npuSY78gEtlHqHCmn8NW
         5eyb8k4NDi+V7FS2GFNTsCMCbwtF/ltNdJ1R8lKpXjwlSuW/xA05CvMqFBhSSu07MEsU
         JH2yxu12s/Sag2BEmE1hSCDB+qldNLfSTvnE6oWJFCK0Mmjy4N6LpwoNiHLpYA46vDhq
         FKyzDBMCupniEDosM2D/oX5huHqWv+fGKFcFhLGvsIObJuL5txuSIxuJcq6Ha7jB3e5N
         8lvmchf4xOKnqQmPJFYTIwbQW4VQVAXjRPv2OhBvHAUvo9YyVyaFKXVLfvp2bURupKsZ
         whYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5If47abMxVvdOGe/2jH89dN5UVVTGLmcg6EQzMCdPac=;
        b=1TunnlKQ7+DPFjBFegJL80VVTLUFzQkPzyHKgKHlf34e4lcb0nPcQO/aHTtad1IoC8
         Qwzz9fXKtGc8NxRfiLbRfjLLScwzdYTBJn3XC2cXLnSyyhIn0xcom3jw2XOVmIh3fy4I
         ykknZFGk74Rjh5ZjoFva1Ovu/uhZZVm33BA5ZD1X62NZDFXGxE3OYURU+YkLkksxqOzD
         rz3JalsUWQny8mmJhOjtd2m9tIPTtRI3EjVQPchfE33HtKPKoSZzDC45JXHRXGFRdoLF
         LhSlWBWvjEZGFLpkkD4eDDnkmgMnpEJ2qukAa1/CB//VUnmpbytOkBw5Oh6pZWDcRh5J
         ZsQA==
X-Gm-Message-State: AO0yUKXRHCOiU0gCB2D86m2tfZjfBM2cv8tHa4GLkrfv0f9VaT1raSyT
        DwDq0uMGVka9l7SUJzh7Cd4=
X-Google-Smtp-Source: AK7set8+pwmvlN4/RTpTbvPrSu6bTCkr/ysSnaWTuvTnV/TRfDp/g41/uigNU2EfzQvt83CM+JnvNw==
X-Received: by 2002:a17:902:f9cc:b0:19a:fd85:1891 with SMTP id kz12-20020a170902f9cc00b0019afd851891mr1808045plb.14.1676754952290;
        Sat, 18 Feb 2023 13:15:52 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019aafc42328sm236770plc.153.2023.02.18.13.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:51 -0800 (PST)
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
Subject: [PATCH v4 03/14] dma-buf/fence-chain: Add fence deadline support
Date:   Sat, 18 Feb 2023 13:15:46 -0800
Message-Id: <20230218211608.1630586-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230218211608.1630586-1-robdclark@gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
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

