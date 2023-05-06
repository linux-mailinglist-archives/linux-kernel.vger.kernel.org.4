Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AB96F8D5E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjEFBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEFBJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:09:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D27299
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:09:47 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-766692684e1so62741639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683335387; x=1685927387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTiSL1E6bfKEz7pNSl/LOCS+aAX7CEY8nuEetNXUOd0=;
        b=XNSm9S3yxEqDtgpW+PtYDrH+DJNAy3X/F9EDt6v7lR98kuF5GyeTDsTsDfxW+QHDVz
         1DWJcUMWHd21Z306tMdW2vOBe4k3lI3ewyXdwm0M+sSzjCq1oyRX6npJA0mZ1u4R3iFo
         G23Kn06Dp1q6siu91Upy+i3oi+9bhIMe/co5t2+38YR3RtKfulQNMtmyj4y8w+RHNjmY
         Qxlg+axHdxdRviaJdvCi23VA/2+mb1e6O1+tZZ7ZCQN0q5+CAGOr+9mJL8ffLwuyGFs4
         WZzqaEi/XkJKG48gTVervfQM/+CxtSwtpGAveYCcO5Zxy4626BbtLkr3DlWEJsmGPN6h
         RK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683335387; x=1685927387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTiSL1E6bfKEz7pNSl/LOCS+aAX7CEY8nuEetNXUOd0=;
        b=R/zt3p0S6eZvieYjXl2XGaMgrBsljzWxByxy2Qip09/JOR6E/5aaevYVyQWz+T5nWd
         Qu5Xkq4Kj85IvYYIeVsN4liWBDFE8x2WUlt51K6Mn0ccbW0YT/kCjRuOUDgwXMK9Uj8u
         wZRE+dZg2L9w3Df5E37nkW/aAK8TfRzGl0LZIZfZwwFGg3sUNgAkTOXIDqzRnslkr7W8
         j1pk36qonhVFf47ELHtzPsnTKkQmK65fwvrqjT6WMfCD7DY8/3GKrlmEPZqyucLzL7o/
         ymnfwckah9ZgzG4h/KGo/Ey9zWDwjU1Ogesz3R6b7MDz+9r8CgsmrzZ31Zz7VyoSsvYE
         PE4Q==
X-Gm-Message-State: AC+VfDyh5lgFYpgEuLVZztM84CtMZzUPYwHrCWrJIOJBX9/rjOhMr0Xa
        16wzruMFSxmrGtOa+0ODmvM=
X-Google-Smtp-Source: ACHHUZ79FwdiStBs1hly8eBBDkqB3tmEz9lbnHRpuDggMLN9t9sHyOSprIcnfTHCVjSXejEPMTm3AA==
X-Received: by 2002:a5d:9610:0:b0:763:8319:da01 with SMTP id w16-20020a5d9610000000b007638319da01mr1797755iol.5.1683335386866;
        Fri, 05 May 2023 18:09:46 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:34a2:3894:45cc:c002])
        by smtp.gmail.com with ESMTPSA id r11-20020a5e950b000000b00760ed929d0bsm335735ioj.2.2023.05.05.18.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 18:09:46 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH V4 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Fri,  5 May 2023 20:09:30 -0500
Message-Id: <20230506010933.170939-4-aford173@gmail.com>
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

Make the pll-clock-frequency optional.  If it's present, use it
to maintain backwards compatibility with existing hardware.  If it
is absent, read clock rate of "sclk_mipi" to determine the rate.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index bf4b33d2de76..2dc02a9e37c0 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 {
 	struct device *dev = dsi->dev;
 	struct device_node *node = dev->of_node;
+	struct clk *pll_clk;
 	int ret;
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
 				       &dsi->pll_clk_rate);
-	if (ret < 0)
-		return ret;
+
+	/* If it doesn't exist, read it from the clock instead of failing */
+	if (ret < 0) {
+		pll_clk = devm_clk_get(dev, "sclk_mipi");
+		if (!IS_ERR(pll_clk))
+			dsi->pll_clk_rate = clk_get_rate(pll_clk);
+		else
+			return PTR_ERR(pll_clk);
+	}
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
 				       &dsi->burst_clk_rate);
-- 
2.39.2

