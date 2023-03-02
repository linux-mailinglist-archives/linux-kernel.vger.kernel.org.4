Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879C6A8D71
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjCBXyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCBXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:54:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C351C16323;
        Thu,  2 Mar 2023 15:54:06 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so4445601pjb.3;
        Thu, 02 Mar 2023 15:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677801246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=NUH74MoMlFjyHOoQOc3Tof5RqeryUU+TpxADwdecLbscsf67tEJFGhdRs5OWz2/eTD
         TiLDpF0n8UeoLj2nlfhjnUo8HWIroTQsFdMjRz3T8ZqPaP+qGQXWYPlzbuX5L2PKmK2A
         0jC6PSe+O7Q2xNLrCnTVKAUdK3IXA7sY0mler06fvzHsOkx+hfv+ibsPiqd2d9neDEgs
         w/RMn11V5lkdSlkYR+t6K3Zoh6Qlc8CBHrHcs+E9+BSxFMdEs6ht9x3dpgxcLNnK/RYU
         L6QanlZS1tad8ALNEB7qe3o8tbuTg/z0in+tZN4tPjzXP7abOw6YrX5drli2n2JuAPdO
         tZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677801246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4ehVbwCT75xnP/ECU7XAGaXEnBwLlSeDxhb5qTgwac=;
        b=Zzlfj0FuQHlSrMKEGVjCwGZu190XV1aUeNWKjsyW7yfTSjP7EbuuCruE+H3JPb90T2
         45Ujf49g7hv6vtG29wNKZ4QyhwJ3hxz/PQvG9kwQOrPkIm5hIAl1fZuGKt3pDiAEx2e4
         WTEoLKJBBqO9tS5sEZ7TdhbNBpRH4D0dKFKPUfFWBJNoNywZzG2OXJcPxHFsjNuTX9a5
         DWrf31IZ1BITDrRSVSUdewXjuIPKcqrlDdAgi77QNeQiIc+13RRqT3p+zZa2C0bDridz
         x7BV7YPw1uuzra8a/W5qoEsOa4rbAKd49fD9f8f1oE6xFPFtAWXBsAeA0yejocq1JquB
         2/fw==
X-Gm-Message-State: AO0yUKU+2zUVPCxBntGs8G2fL4/nOSNzns/LcSfwn8pUiyOzmXIRJBFe
        nNeR0GXaEL1Gja/+M2PLn4o=
X-Google-Smtp-Source: AK7set9yFD6Y5yJLKU6vm3DlNq9ITibopHzdU7+nBSZ1Vfy3oUeJJSkMSehminR0BguhikQjch98Ig==
X-Received: by 2002:a17:902:ea0c:b0:19a:727e:d4f3 with SMTP id s12-20020a170902ea0c00b0019a727ed4f3mr4273475plg.5.1677801244532;
        Thu, 02 Mar 2023 15:54:04 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id ka3-20020a170903334300b0019e21d2ed2esm226622plb.88.2023.03.02.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 15:54:04 -0800 (PST)
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
Subject: [PATCH v9 03/15] dma-buf/fence-chain: Add fence deadline support
Date:   Thu,  2 Mar 2023 15:53:25 -0800
Message-Id: <20230302235356.3148279-4-robdclark@gmail.com>
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

