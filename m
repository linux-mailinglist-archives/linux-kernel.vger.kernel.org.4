Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DED46B0D82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjCHPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjCHPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:53:35 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D935DCAE;
        Wed,  8 Mar 2023 07:53:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h8so18034488plf.10;
        Wed, 08 Mar 2023 07:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRbyMbeEc1g04CNRPycSMV1Llvla2kLsSk+TytIEmsk=;
        b=E8F1gMxoQi0pjd5J8Y6jydRjSAIw7Rqa8bmWluE0DJDyJZamKjSmyYHmicDKUAwwOC
         DQnKhprOqhc0JTNy+sNnE+urwNiknzVmXk5HUXLv/5fJW1DelsQr9V6lzlC2C/fBuROh
         dQlC9fHbBdG8RGLCVsgfvMowoZ2Tl2CmLHqlPv8EjfQxnvTBDu/RpJJx7iFwMlFw2PyV
         xPv4elub5ZEWEK3KKrtxxxySXJKaza7NBM6oYqynNIPvldcOtpF8ekHdqQYc+CKou2ta
         q0eWopDJcM86skChVL/X3tfUtoAE/NnPmjB29i3AHiXjxIjt05hzj6/+bqxy3PBQ2wAb
         0PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRbyMbeEc1g04CNRPycSMV1Llvla2kLsSk+TytIEmsk=;
        b=3v3XdKnxqmBCoxKux0rFDYZnKkQLTBiOJ5uEdr50yp045eqp6tXhoXiG1NWCDL076m
         cS5IZHi4vnCbCs5LvVSIvbhdoSpqF8O3ngTuCX7jbv9i8MMAXD/3jz+/Xryo2IhLVbrk
         kYuvs+5TZScIDtWI2r8qqDb+FWxHPDRBxc7ki/KW1No2guetGGSIIzV72/ibQ4Cxyujk
         skH2zbDh2ZzINW0VhwM2ZhER5z9zI/eKrrV9hYLFatTeXPxivWkrs+LjBIMA3MHdwPVL
         kr6nR7kPE1EmFi6YhbkhU8eoRNE63NETVe2fZUeCPzt8p1ys8luNkeUBBsoK5PaXcTQU
         OEHQ==
X-Gm-Message-State: AO0yUKVFk2mUbIE82QGOqy8IcIzTDinybnG67EbanNfaCmthdyDMMAHX
        GVvk4jKKld7O8lfyKw9vL/0=
X-Google-Smtp-Source: AK7set99fLa+QCsE+WaWRDGxHZu+A8+0MlNPxutv5RXA+vhBhaw33wHVVnezivT/H0yLgb50ZxOFTQ==
X-Received: by 2002:a17:903:41c3:b0:19e:699e:9b64 with SMTP id u3-20020a17090341c300b0019e699e9b64mr23933457ple.65.1678290813286;
        Wed, 08 Mar 2023 07:53:33 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jx15-20020a170903138f00b0019468fe44d3sm9996583plb.25.2023.03.08.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:53:32 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 02/15] dma-buf/fence-array: Add fence deadline support
Date:   Wed,  8 Mar 2023 07:52:53 -0800
Message-Id: <20230308155322.344664-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308155322.344664-1-robdclark@gmail.com>
References: <20230308155322.344664-1-robdclark@gmail.com>
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
2.39.2

