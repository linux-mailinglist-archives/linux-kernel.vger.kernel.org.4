Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5669BC19
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBRVP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBRVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:15:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9ED13D5F;
        Sat, 18 Feb 2023 13:15:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cn10so1525118pjb.3;
        Sat, 18 Feb 2023 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=JKPBLpJuYtLP9cldFiCcQBESYKJDPCCdxK2p8Ufr/e7ac14X4XAWa/I6jS0fPcj37e
         mhzcsytchZq64j98/Us4f7wzBg+VXTi9kp+Pj/z+xtBTZuKHhnwMzlDgvm0NGFuD54vP
         mmQswfaDmO6rYjuZSDKBgBjdq0vsXkie19jhYNv5i1BGWHBWM7NX/4ETw6yeOF7xB3GN
         FrwTqOjuiorsAywFwh1DQOYvaS+co3s4W2mzUtcHg0bSQVy1W3TUeSCSkuPmMlttZ+Wr
         hHNWbwf4g+DyHKjq/TFRzJ377BMMdS4VH1igUJ9gBhzQOBjfsepQgOj3FLty/WL/fu7f
         v+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MohZmh6ZcfzJn1OmRfs/o8+oM4ZPKLi2FB+4LPpL34o=;
        b=Hs4sdWJcs3S26P0VXXf5su7WPoeqZ4c+Y/gsjoo+dndMJInQRO4p89dWf9W24H/WmY
         LKrUTd1RtU8ce7Jpi75KNhkiIiOf7SeaHJjmxdbWXQUz9xEVu7GAufRA8UmUl+M6aEJb
         SCrftPGA7kN3ygezwZF9jY0b3X4dz/FJyFnoo9mzTZqjEKsKe1Q/Qg8El4c8vmXAipLw
         4A9snxkizUYOJnlIYnNtV9PccVqxcfNduM5AalJNM+nAasB+nsiaPYsz0qlfbJkhPddZ
         dbgfEHT2AKD/5Pw3dsz086LCsjK5eHlHBb//cZWLEmb1JcX8ACClntzevO/sd6tK4RDN
         /OXA==
X-Gm-Message-State: AO0yUKUR/1NbDMJhUKf4yv0+arwfZ+F1beXhaVoGAnjY9dbS+X8sGPZ0
        RnWQFf/oMemFQ54qD2QfZu8=
X-Google-Smtp-Source: AK7set+pq4QfLfFdfKgM6Wa+2NuPdUfpQy5kKDnaTLTht3wfRp9ww2c0n1JEFd40cSQfgefDzy4Kyw==
X-Received: by 2002:a17:902:8601:b0:199:e58a:61c2 with SMTP id f1-20020a170902860100b00199e58a61c2mr4201310plo.29.1676754951096;
        Sat, 18 Feb 2023 13:15:51 -0800 (PST)
Received: from localhost (c-73-67-135-195.hsd1.or.comcast.net. [73.67.135.195])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b0019a6cce2060sm5104473plb.57.2023.02.18.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 13:15:50 -0800 (PST)
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
Subject: [PATCH v4 02/14] dma-buf/fence-array: Add fence deadline support
Date:   Sat, 18 Feb 2023 13:15:45 -0800
Message-Id: <20230218211608.1630586-3-robdclark@gmail.com>
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

