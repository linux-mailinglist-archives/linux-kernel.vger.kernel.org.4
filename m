Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD267470B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjASXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjASXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:14:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347F93C6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:12:51 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so2800785pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RYDaQakvnKQMHYWcGZyFzWZGbJWcAlfnMO9tuHV3GY=;
        b=epTqo8/GH4R2BQ1E41zW0K2lvL4E85jVpNh1kazLjYlZomZHpWFKvEFc4KP/4voUKd
         oDhHR+qTm44ZJMscqbp0SfNGv8dpLTjJrGf6zc9u+k8MfUxoYkzAysCdAXkEfhNF6cvx
         Yusdvp/Sk+TielCZ2tVy0bscV2eA4K9apqu6MUQS/L9VxcZM8E/baAL3equmOEof5AQ4
         saznbLELNR8lgHkg19njvaR0GnJTyBSF7VdEizP2eN9BDYX6R/hrdTgzNMstSSK+Lf4d
         V/yV6c4o9Bi6TZf5W4nbd+Ypxyd1T+J47XylPXDPYDy4kBBagHLd6Vc5ULBejQ4lDZQw
         rPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RYDaQakvnKQMHYWcGZyFzWZGbJWcAlfnMO9tuHV3GY=;
        b=XRS/fJI1oMBKZ13pHKrlyeJIfbbLFRYbcsCHNCDPIIN5F1ueb+JepT3THS6/2WkNAj
         aVfwmTmuiuwtEgxMMiTMbNSXLhkQqGtCT7PA9gxgmItdqeYuwOYYu2nP4UwStcVwbr7n
         SSvYd9E8wUghW4EHh2WbZCkrUhceAUAdUkNywVEnxOuK/J1ExsSYCi2/NRX8cy3W3z4G
         8FZxsMPVT5jXBWmGCzHYn0WJwgq6+zIJKek444GnVAbEaiud9BlmnNa6Oy55uJ4Eq6Yn
         IvJ3Zy0UVKWqNRMKXbqBqEuNHsrLwIVmFRJ7oxc8H5CViNyAwjq0LOdgkaR7XPs94xIC
         ag5A==
X-Gm-Message-State: AFqh2koZP8DiPBZPaBfk1BT0hEgqrtWArASiN5jb2rjzBomYh2Oz+3Zh
        OEpJYl7GX0EMMOA9jIzDSoLBaYXtAuk=
X-Google-Smtp-Source: AMrXdXtKgRFPXBVj7R54nnGbw4vB8/Vr/7TKyDxmjIzRogqEFN1wo2iKN7Ikw9yCjJDzqEPqZPq7ZA==
X-Received: by 2002:a05:6a00:1d23:b0:58d:a91d:e9f8 with SMTP id a35-20020a056a001d2300b0058da91de9f8mr11154285pfx.18.1674169970704;
        Thu, 19 Jan 2023 15:12:50 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z189-20020a6233c6000000b0058de3516c3esm4241259pfz.142.2023.01.19.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:12:50 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Mao Huang <littlecvr@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        linux-mediatek@lists.infradead.org (moderated list:DRM DRIVERS FOR
        MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/mediatek: Drop unbalanced obj unref
Date:   Thu, 19 Jan 2023 15:12:55 -0800
Message-Id: <20230119231255.2883365-1-robdclark@gmail.com>
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

In the error path, mtk_drm_gem_object_mmap() is dropping an obj
reference that it doesn't own.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 9b3d15d3a983..f961c7c7456b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -169,8 +169,6 @@ static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj,
 
 	ret = dma_mmap_attrs(priv->dma_dev, vma, mtk_gem->cookie,
 			     mtk_gem->dma_addr, obj->size, mtk_gem->dma_attrs);
-	if (ret)
-		drm_gem_vm_close(vma);
 
 	return ret;
 }
-- 
2.38.1

