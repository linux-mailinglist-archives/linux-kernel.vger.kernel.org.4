Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FF36F93CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjEFTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEFTZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:25:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E618DC0
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 12:25:25 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-766692684e1so82767939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683401125; x=1685993125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S57aMfOKN4Ufu1gBwss42JtDuspNMJN7ZH7N5B2pZmI=;
        b=C5YRUTGAIGAFgGAu4PBTFHndyHZlpRW9iseYYOnAlzieoDG83oSp281kyw/IY4sM7Q
         Gi5HmZFQ2siulihfaq0s2rTbqcVyI7811vAuYqw7ymKcfzrJSHvIQXc0m6NO79KmNI3H
         IV6Vy5Ry4/7UJcZDm/gSozUsCakwfFTC270kO7b/viwsg/xLGlL03i7XoF/xQsKlR+YB
         LI6xUeCtFq5GI8Tu4Y/RZ6nNXBSwaYfn3wyDCiO1aWVJn8CvUNRC/BqAtJ4TeSiviSqR
         UP7rfZKbMlAwyH7F11m2uJt+qfGBlyNv2b0lWqYZVu79uqbibWpb9g16flcgm/kdFrct
         sTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683401125; x=1685993125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S57aMfOKN4Ufu1gBwss42JtDuspNMJN7ZH7N5B2pZmI=;
        b=QnyVskzn/V141EaDIAZ5rpki6wgQUEIeXnV5CV5WA0L1iACUH9iXje4asuplXozSUL
         QM5oRcO37pS5QYaroCiOdIQX/a9SiQTHCrIS15B4aKzttiq29Pr+J29qsfGLfzV1nvlE
         BWP/kn1tM748dP6cmtH9zxPuLxBzxytTK5kmJA1NwxWLDYVdIlY/lUk3IoMDfakp7c+J
         BYT923lPp4ntC2nXDMhrccHfa8EOQHE3J7fyBMZ7XUcO8cerLynAVjpJq3W2BEV9BozU
         hb8X2//evKPb0IpeAXDuP+VCOyv5NrmrZgbYx2gn+mrtCZXUJT13azM3iMJeZWOivGez
         BCeQ==
X-Gm-Message-State: AC+VfDzQE91/S/76C4venfYJt+hljPzxT9bxJ+6biIJbjEq+OnrZVIGq
        0iQCpAycSlttGLMQXbrZcu8=
X-Google-Smtp-Source: ACHHUZ47U37rVifyXkRt2NUsekfY8Sh0y6GR0wjeK/VrAAobXnAIzwUieChhF/Z+wsG02VUs35UrWA==
X-Received: by 2002:a92:ce91:0:b0:331:9c03:dada with SMTP id r17-20020a92ce91000000b003319c03dadamr3185984ilo.13.1683401125026;
        Sat, 06 May 2023 12:25:25 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:5e49:1bed:79d0:5c25])
        by smtp.gmail.com with ESMTPSA id z18-20020a05663822b200b0041631393ac9sm847824jas.18.2023.05.06.12.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 12:25:24 -0700 (PDT)
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
Subject: [PATCH V5 4/6] drm: bridge: samsung-dsim: Select GENERIC_PHY_MIPI_DPHY
Date:   Sat,  6 May 2023 14:24:51 -0500
Message-Id: <20230506192453.725621-5-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230506192453.725621-1-aford173@gmail.com>
References: <20230506192453.725621-1-aford173@gmail.com>
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

