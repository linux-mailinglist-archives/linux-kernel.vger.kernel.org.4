Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A7675923
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjATPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjATPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:53:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BCCD23C;
        Fri, 20 Jan 2023 07:53:25 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:39c:df77:ee30:30ed])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1516D660230B;
        Fri, 20 Jan 2023 15:53:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674230004;
        bh=Cp5VUuqqJWZfxAGM2uaTUY9gCqzgtCRO8doDbJe8GqU=;
        h=From:To:Cc:Subject:Date:From;
        b=M9FJRCXumXZyllfBUymJDAg/xqqBxgux2WaLhsqhCKIrAjfXjcilBwr7G1XiPTcbg
         9sHeggBzESOuYrHxZDbzQ2iRMtL/okHAY2zis9Nrkq9J4i/cvMbvJIJtQmilvUzzh/
         BCupkNeJhvg3EJj+bXpTuEAKvx3+pacIZI8A1hR513p7pwVSy6bqy1j1IMuOC4Zz3P
         TTr74jFzrH8J/ShW9G7RPd4jAOSYzWikhEUFmcy43YO4aWUQ+6xPVSWYRE7nYxZNRb
         Aua1yVCinmdNZ9p2wpiW4EvHBwBuZLWWzDqmV9QUQRtaMKDBGdMRQKjqaq6AJg2kV6
         nqhNuUrOK0PNw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] drm: exynos: Make g2d_open() and g2d_close() static
Date:   Fri, 20 Jan 2023 16:53:17 +0100
Message-Id: <20230120155317.819786-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "no previous prototype" warning when compiling with W=1 by making
the functions static like the ones above them.

Fixes: eb4d9796fa34 ("drm/exynos: g2d: Convert to driver component API")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
index 74ea3c26dead..4631c0579fb9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
@@ -34,11 +34,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_device *dev, void *data,
 	return -ENODEV;
 }
 
-int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
+static int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
 {
 	return 0;
 }
 
-void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
+static void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
 { }
 #endif
-- 
2.34.1

