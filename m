Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD556F8D62
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEFBJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjEFBJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:09:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D14359E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:09:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760ecf3424bso59251039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683335389; x=1685927389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S57aMfOKN4Ufu1gBwss42JtDuspNMJN7ZH7N5B2pZmI=;
        b=pzLeMW86eJOcyTJ1zfq7cQdlDIMTNuIxITfI+ssm6oxpDpjFhaa8waxO5nNzRTwZkt
         9YovPBhp7wzV7dpVQWHDJYDHovSgitGjS19usf5fFKHzV3k/TCc4pS9KwP3sHFF3VhCW
         X/XVrxFKC/W4XFZOAoTljDxGifOqBp9N2qGq0q823PHtn7utIu9LMhtgq/iYaOBGBODI
         UhvMqyiqde4sBmfJtIILbaQZ+X17DfpdSq/HkSyz9mJiol0yzjPtgxt/6D09fWCYm80E
         JELBdWoJWGi0SGgrAUWmUyMc/bjgdvu4Xk8XNGcOyM0b7ENPtIzM96nN6PIcQHjCGwpv
         kYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683335389; x=1685927389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S57aMfOKN4Ufu1gBwss42JtDuspNMJN7ZH7N5B2pZmI=;
        b=dEL+KKYamQKZeGmIZPJ5pXuYSZLAs9cIlw6LBsJKH6TSwZT64APQoM+vKrq7gb+Ow9
         9LMSKzrV5zC7p/9ruRGZBX4Z7alMQoXz5Tc3Swo5UISjqofVUWnwykylE1b79+REApl4
         YaOdmj25ymJYKN3fKKWgqWpewdUZdp+TXR+cthSgTfnI7BE9gZwfxEuKyJSwsyBCCZen
         LmrGbVuSw5AqqYlWywLwR9LZiG3MF9MHTTVgFqIFrNIP72EK9bFscZr3CK8L+O+v3iOz
         Ljsn60OWgnyjY5LVD3Ngar3auEC2Kc70kJGZ6XWtkNK5OFifm1eEpy7FwvHSIn2rHViT
         y0Wg==
X-Gm-Message-State: AC+VfDyRKObvOjRCqc7jfXgbvuTZAAs5oXjQXA2Jf4o4+nt1c6ZeQhxB
        wippf8Hja5OrctFFy1aB07w=
X-Google-Smtp-Source: ACHHUZ4JmXPdFUiUhXujk/P6gRbELBNJwCIN+oaZt9D2m9RqlgSbvf/tSL/tMVfVR9CVBNusYK+lgA==
X-Received: by 2002:a6b:fc18:0:b0:760:c072:d276 with SMTP id r24-20020a6bfc18000000b00760c072d276mr1949513ioh.21.1683335388666;
        Fri, 05 May 2023 18:09:48 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:34a2:3894:45cc:c002])
        by smtp.gmail.com with ESMTPSA id r11-20020a5e950b000000b00760ed929d0bsm335735ioj.2.2023.05.05.18.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 18:09:48 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Fri,  5 May 2023 20:09:31 -0500
Message-Id: <20230506010933.170939-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506010933.170939-1-aford173@gmail.com>
References: <20230506010933.170939-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support variable DPHY timings, it's necessary
to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
can be used to determine the nominal values for a given resolution
and refresh rate.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index f076a09afac0..82c68b042444 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY_MIPI_DPHY
 	help
 	  The Samsung MIPI DSIM bridge controller driver.
 	  This MIPI DSIM bridge can be found it on Exynos SoCs and
-- 
2.39.2

