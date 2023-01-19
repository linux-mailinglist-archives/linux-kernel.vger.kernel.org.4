Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803D3674430
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjASVU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjASVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:19:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C3A9592
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:13:23 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 78so2595939pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXQAX4zgQIEcR46hfecs8ivLI9Fp7qzLdoZtzRMFxAM=;
        b=LeGGy9TXclqavq1GJEP5BeJuqLAP77mJj9M/dx+YZB1k8oz48n4eWPGqVlYjqDCLRE
         41YHxOMQmIPn4GecoCfNdSfjX7LtOwzw481wfJI+TUHrlJT0YXSVbMTSxk7vLqaMm35k
         isUkT8z/Zm8eLWKwPPOPPE3qKEIo5tMt4u/U9Z2tA27ZMD9AbBVh5NaY8RcniOdcvUMi
         pyrAFAChvhZharJnDgULt0wPu06u8xTrPVKuwTv/MbeonFQrYfzcIF/B0ce5rWIFQ39h
         ubIZ7WeGiuR3cNGBk8p1LMXvjgWovU46wbhWELbGrWsie3y+NdQUdLbxAI2m+8DqNVzX
         1Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXQAX4zgQIEcR46hfecs8ivLI9Fp7qzLdoZtzRMFxAM=;
        b=DeXByVsi6G8qchel4ltwQh0eHqjOljWXDcm8q7Mz1+bxdkefjUe1DVX8kC3tYKz8ba
         WxkhQt1bwjvSXNXKTdrUjdwWKikCy4VJdxaOwdjfCif9tcbXfyXdqYta299ZaeYStkmS
         GcsbriEwMmygMxIG2YjfZGKRn/NRRwDf7LvdD2wJkFpjdsgFZ2d+63cPw197snMMB9BA
         SO4vMxJ3sjbWpm23nKCsOBLrnLGBNeLvJF2sPKi5f1gX+Fv9XxQ1d8tT/iZR3ISO3G6k
         WLAfdvGhOQqRFxN04Q8Gf74fhtwd/Kh+wZ4f0f53bpoi3IrqTJv8EjYSQzUxGWGWTk4z
         +mQA==
X-Gm-Message-State: AFqh2kpx+BGdlxa88d+Qs/NEuQ5osPRqiTT5edMluPFub2RRHOBiTWsY
        vysY2PeHXGBuLEv7PUTAmiE=
X-Google-Smtp-Source: AMrXdXumu9XC7Z8ZOUJf2HdYTRDa5zAIDrKrYOpAsbDGhZlQd+VrdxHeJwh7Lw8m+T9WViOxlLj1cw==
X-Received: by 2002:a05:6a00:f91:b0:583:319a:4413 with SMTP id ct17-20020a056a000f9100b00583319a4413mr13329053pfb.24.1674162800057;
        Thu, 19 Jan 2023 13:13:20 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b00581172f7456sm7056240pfg.56.2023.01.19.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:13:19 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/dma: Drop unbalanced obj unref
Date:   Thu, 19 Jan 2023 13:13:25 -0800
Message-Id: <20230119211325.2851211-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

In the error path, drm_gem_dma_mmap() is dropping an obj reference that
it doesn't own.

Fixes: f5ca8eb6f9bd ("drm/cma-helper: Implement mmap as GEM CMA object functions")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index 1e658c448366..784356d6f39d 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -544,8 +544,6 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 				  dma_obj->dma_addr,
 				  vma->vm_end - vma->vm_start);
 	}
-	if (ret)
-		drm_gem_vm_close(vma);
 
 	return ret;
 }
-- 
2.38.1

