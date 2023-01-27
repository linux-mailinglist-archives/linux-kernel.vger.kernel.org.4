Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5367EBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjA0Qy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjA0Qy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:54:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7E1C5AB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:54:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jm10so5559266plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJHn8+pSpwglQ2ylL3huswEVRt2vpqL4jH6sVFjg9vY=;
        b=kk0OOlr625FNfEaHBDqd0XDNDVjNqpiWEqLLgn/fC4Qrqb/VCsyTTtUlWSa9r/z5N0
         jUo+S93D/xHrJiiUw5OlfRmg2Qb7eYqSrvqF+6vwqjzOjLXFxlR0y26v5ruRu8D9qPOu
         AX97MQTJX3KX6JSnXTdwDgUxmp0ZPLguoQhSfCCouy1ha2VZdluDW4CoH7BK6EBpSus9
         t9cmqkChU3WN8hsU2hwy2v4rJ2JQaKPeY8TuARXnsE+qEu3TVKRh6WvpwhN+4eMaTrrD
         lZ6CyRcSEedX/rbGSxU02JgoCn20QKcs4fqzC5ZSSYeVL9CLzuQyPTD7dEtLUDPNkYu6
         HZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJHn8+pSpwglQ2ylL3huswEVRt2vpqL4jH6sVFjg9vY=;
        b=nH01t+oQ+FG2oeVdrAnBG16DBW9sA1SRbAb8OP0k7XFRPtvQoJ9reWiWvTht3m8jLX
         1+OKbrleqBfI7SZn37Fi82V3eVfRCVqxKbNa9q9a3P0oK4tw9LEvFuyVfrvvgVb5bKDn
         0FtnhE4aOl1+lcqRTRxMHC7ZOWpW5za1MU6TT8iSkMBA1kt9/MtTHwtQcOqO/HG/VVcI
         ydsSXmR1YfE72UGE/5bocYTM6ti0q5rIXSmdCiKXew1hcUkHACQZ47jpJy71yej7vxBS
         SSjzvyRH6ZEZbsfdX2DLMm2Cg5p6L0VyLKiI6XlFeONtvCHCLLg6IVs4IwU6BEB/KJyc
         DEEg==
X-Gm-Message-State: AFqh2kpBEbdX3G0Og7J4aU4ddZ+RboHoZoh/FQv/D051MqlyzpONa/yI
        bIy1zRpGarMb1Tay30DbLvQ=
X-Google-Smtp-Source: AMrXdXvbJYAaCNdJ8tWPyVy0sutAAlq8id5Jor0UBuLb4ou1Ou/KYQMgNdG31Nv8a6j0csqDu9fGGQ==
X-Received: by 2002:a17:903:2349:b0:195:e373:4c60 with SMTP id c9-20020a170903234900b00195e3734c60mr35905710plh.40.1674838444754;
        Fri, 27 Jan 2023 08:54:04 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902edd000b00196503dba7bsm1904267plk.293.2023.01.27.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:54:04 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Doug Anderson <dianders@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (moderated list:DRM DRIVERS FOR
        MEDIATEK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/mediatek: Remove unused GEM DMA header include
Date:   Fri, 27 Jan 2023 08:54:09 -0800
Message-Id: <20230127165409.3512501-1-robdclark@gmail.com>
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

No longer needed since the removal of dependency on DMA helper.

Fixes: 2ea8aec56bf1 ("drm/mediatek: Remove dependency on GEM DMA helper")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index cd5b18ef7951..7e2fad8e8444 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -20,8 +20,8 @@
 #include <drm/drm_fbdev_generic.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem.h>
-#include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
-- 
2.38.1

