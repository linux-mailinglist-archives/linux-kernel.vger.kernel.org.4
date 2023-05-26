Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E1711E48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjEZDG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEZDGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:06:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2989FB;
        Thu, 25 May 2023 20:06:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77493b3d18cso37810139f.0;
        Thu, 25 May 2023 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685070375; x=1687662375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=hTACl7CnYTgFZvkWvYBZrZeC0sxZ9bLXte3Z0EFktq8iG/vgVQqMph4F1VcpAFS267
         XSQJu7EqS2BOx9zZDEV0kFe3Rx7bgw4kHSSkXZqOkB5U4Fb6wfe/TL1u6hBUNgdaqKZW
         ik7zbD6ZKTeBTrrE/Xvn9OmH29NcwcQokR2bl1ZLwL3G9US1wB0JX8AFbkeqpfE2O2aV
         AmXUm3nugXR69dB6TsSN6vzXSEkoU+xI0qZFhjuhVeoCp9FoPE8nQ91gR7z7mH4knuBQ
         EZzIzMFY4+WbgvSNY4oCfBDz7grCFfVMAd6zh5iArrdffJwzHPebujAWu5B/v4fsblia
         DE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685070375; x=1687662375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o9sUAx3iK/A4vzjmFl/tQ6LFFXKGPJqcsBJSVqCXEY=;
        b=adzVQQYWoX/P1qdF1XgdvayTZ0TwBJIQiwdcfy7OdRJMzHuOFm9t6UUSYmyOumYArU
         Pu3y78GyigjS6sxFHQfqDkkW0ShW93Ykntyp9Zqb4klm03hIFUgn2Fs6iA66y2GdSoi0
         MpvcbyzZgvqXoNod5sgUfGAETzZ3MwhSS2bppyYBMHpDIYP79GfyaKpb7Tt0DciSt9up
         K+zhGv9VaLUKDitJF7+WlOnQpWCd822tptIbaNOtFccVa9ueE+pFZWn9gGTr7NBo/K3f
         ekP3iwN4wVqK5Rz3xJO0UJzur2fgHWtC8eJejlkZiosi53RSWtVk+R5yb/07J7tep7XR
         OBqA==
X-Gm-Message-State: AC+VfDxATb5ez02mbxT0xiSJhpKbokOvkqQJzHXuYYWmfpZJmAPJk8WS
        iI1OQjlVuamBMJ/tXAxDRN4=
X-Google-Smtp-Source: ACHHUZ6ruY5h/u2nCZOxRF7M4+/wrfRmDfGCm2TEpMYrYd1j+/ULSUIf1H5LvzwyT6edBzO5cnul8A==
X-Received: by 2002:a5e:de07:0:b0:760:ebf0:bdfa with SMTP id e7-20020a5ede07000000b00760ebf0bdfamr180015iok.2.1685070375064;
        Thu, 25 May 2023 20:06:15 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:3dd9:3f6c:9922:6420])
        by smtp.gmail.com with ESMTPSA id i2-20020a5e8502000000b007702f55116fsm363189ioj.38.2023.05.25.20.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 20:06:14 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 4/7] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Thu, 25 May 2023 22:05:56 -0500
Message-Id: <20230526030559.326566-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526030559.326566-1-aford173@gmail.com>
References: <20230526030559.326566-1-aford173@gmail.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
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

