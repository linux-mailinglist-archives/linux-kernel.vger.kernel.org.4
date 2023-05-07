Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8676F98FF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjEGOsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:47:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041931208D
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 07:47:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso7036687a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683470876; x=1686062876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PBw+x9bvNtvt7zmxEBMLA8rMP4RbJHux+PW551gPw/Y=;
        b=AwInZtYbyq8MwNv/nmioV0/vEWMEkbmPYAXUNEB0pSDGTtmJrkEJirty3CUOkW0L6Q
         i/LwNUWeJZ7LAq22+3vPajyEeXdRjOHUWMv7Gf0fFmkjM0ipTyK6NWG+ch9bAdoNLY0U
         IURXOWqoQkWthEWtaYaZatybZDSHLg+EsGTHPzgTSGMgNVgXhhxhMvCGUgXzKRRJZA1J
         jLteEs5cBokvh1Yxd5m1vcTKZlfksAArtrZGr4fUy+VsiqjB2wLVCpq1cugD4qiARq1f
         T9r/21qTg4pWhVPVF81JXGhU7ryq/IlGoL9N1DJ1dKv6O8cXNEfVKeC6f6vAmxB+NoDc
         FvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683470876; x=1686062876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBw+x9bvNtvt7zmxEBMLA8rMP4RbJHux+PW551gPw/Y=;
        b=fZIMssiQXAhLmzXRS5mXuduwlvhizeitMQt/v6Oi++n/EZkRPd+ZBBt5It1z1a6MOl
         9yZsZfRmO0M6VMvGvCYY46BzUvcTv3QOvgBu7A1r4EzODOCnLWfRvqGs8wuSbmmk3VSj
         01i2CMVm2bw1Qqj4wgzgu2+3DuH8u889d2JSe7sYfyvQ09byAGKUqoAwtiyoQaxdV45k
         acusLxHjzXCOpmHSHRErckQKmOzJOI/6q9LILASGC1MC1txcDbBNUgrYp/eHltki2UXz
         rKV28aIjIiohIUfSdgM6X5itdXuFx1ZZl6BsmToA3iUftMcGaukMPMEx7swyDSldupMI
         IQCQ==
X-Gm-Message-State: AC+VfDwT+Y3jw2Zvt1UdoCI+ZNSVbSBxjB41COcZ+RVNV3iO9BF0V+fa
        h9W+QMFjBOp+mEd3AFkGNKXVaw==
X-Google-Smtp-Source: ACHHUZ6TCPbXEZFv7aTp7aqWDp1eF0qYHjb6r45RdoMNpf0N9RbftBDpLEB9W6gEbGIkLV9Aqg2awQ==
X-Received: by 2002:a17:907:3e8a:b0:94e:c142:df98 with SMTP id hs10-20020a1709073e8a00b0094ec142df98mr7721629ejc.60.1683470876419;
        Sun, 07 May 2023 07:47:56 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:1757:b51a:9965:e81])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906051700b00960005e09a3sm3752899eja.61.2023.05.07.07.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 07:47:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: g2d: staticize stubs in header
Date:   Sun,  7 May 2023 16:47:53 +0200
Message-Id: <20230507144753.192959-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stubs for !CONFIG_DRM_EXYNOS_G2D case in the header should be static
inline:

  drivers/gpu/drm/exynos/exynos_drm_g2d.h:37:5: warning: no previous prototype for ‘g2d_open’ [-Wmissing-prototypes]
  drivers/gpu/drm/exynos/exynos_drm_g2d.h:42:6: warning: no previous prototype for ‘g2d_close’ [-Wmissing-prototypes]

Fixes: eb4d9796fa34 ("drm/exynos: g2d: Convert to driver component API")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.h b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
index 74ea3c26dead..1a5ae781b56c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.h
@@ -34,11 +34,11 @@ static inline int exynos_g2d_exec_ioctl(struct drm_device *dev, void *data,
 	return -ENODEV;
 }
 
-int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
+static inline int g2d_open(struct drm_device *drm_dev, struct drm_file *file)
 {
 	return 0;
 }
 
-void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
+static inline void g2d_close(struct drm_device *drm_dev, struct drm_file *file)
 { }
 #endif
-- 
2.34.1

