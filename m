Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA1745D04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGCNWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:22:00 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1DE3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:21:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6994a8ce3so65305441fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688390517; x=1690982517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dmkv6C+3q0OhDNXDylTCb+3rSuoihy22b5khGTWPfYY=;
        b=x56IXe8RIxnYL1+6pw4NtYfv1qktWK03Hq4LtRYerU8753MlMMPlbfiYQu112xui2F
         Yat4bSpDBts7bX0CwkfuEbJTpa2E8QqxQrFYOdq43hC913JaII1dpWGPB+y+9exS0KoC
         XeLezG/yqBg/w1SzEhw69RYK7Az1UoFjzGVJkiyp669P2tn5iX99KvLDYM7vIECcswcP
         duATm8LgyLut7Yp1B9HJOb+yGUo24OVNgeLnh/U8b9CkRzmv4XLrjS7nacIM9fGBtOd1
         PJdMHZg87m4VXTNWl5bNYOijkYnVOikgDKxRSofwGAwPyrjV2UyA5ZZ83VJRwLKPNdVG
         qyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390517; x=1690982517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmkv6C+3q0OhDNXDylTCb+3rSuoihy22b5khGTWPfYY=;
        b=YXjh98d0dX3qqrcRBltWOfPW8kIHUYXDmMSttdXhBZHFOFqN1WRWIiu5acR1A4cz6f
         FPEz4nVTEOqXoLJrQM4PU1uKQRif8kzxvScpu8cDwBt18lK+qDtfbv6QkTYdYaFtlp4A
         tP3zcMgZ05okUxeZU4968TMDNu6YERUJ8dL9aESgtCrp24xqOkxiADFZ8YMNbHZ0IyQS
         KIVVSmeM871kYhWRDS2GkpvFBPtbjG5aGvDrd35hoOIb6m/5706zm4EpmrOhPjdt/iyq
         N1eAy4MNzKGPHsMgHAlg6lrIm7BRXp/z8TeF47GeSqiIfvBPSb0gshatoQ612PqEQ/vF
         +ySQ==
X-Gm-Message-State: ABy/qLa5M+bYVb/l7GV0iEgVCcRGWpa/0d28UwLMkBLB9zbaDxAO7y2C
        RBE3GQJ9IeiGNmhPmsuJT9cZsw==
X-Google-Smtp-Source: APBJJlEJ9liFnDdgt5zlbz3HnNnpx+fVn7iFxhT8RwbTd+Zf3sz9814lDIWRJDoGqZPUxu6XwYc2gQ==
X-Received: by 2002:a2e:9f4d:0:b0:2b6:bd09:4d64 with SMTP id v13-20020a2e9f4d000000b002b6bd094d64mr6888676ljk.34.1688390517732;
        Mon, 03 Jul 2023 06:21:57 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u10-20020a2e9f0a000000b002b6b7a98c4bsm3535238ljk.77.2023.07.03.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:21:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 03 Jul 2023 15:21:50 +0200
Subject: [PATCH v3 2/4] drm/panel: boe-tv101wum-nl6: Drop surplus prepare
 tracking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-fix-boe-tv101wum-nl6-v3-2-bd6e9432c755@linaro.org>
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM panel core already keeps track of if the panel is already
prepared so do not reimplement this.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 6fd4c9507c88..358918e0f03f 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -51,8 +51,6 @@ struct boe_panel {
 	struct regulator *avee;
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
-
-	bool prepared;
 };
 
 static int boe_tv110c9m_init(struct mipi_dsi_device *dsi)
@@ -1748,9 +1746,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 
-	if (!boe->prepared)
-		return 0;
-
 	if (boe->desc->discharge_on_disable) {
 		regulator_disable(boe->avee);
 		regulator_disable(boe->avdd);
@@ -1769,8 +1764,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->pp3300);
 	}
 
-	boe->prepared = false;
-
 	return 0;
 }
 
@@ -1779,9 +1772,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (boe->prepared)
-		return 0;
-
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
@@ -1823,8 +1813,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 		}
 	}
 
-	boe->prepared = true;
-
 	return 0;
 
 poweroff:

-- 
2.34.1

