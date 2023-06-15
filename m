Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDCF7320DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjFOUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFOUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:21:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852592101
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:21:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so11057015e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686860506; x=1689452506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKBaB/9E61orl2m+5DjkcFtTpmNkTOXhn6/2KzxDt8E=;
        b=ooRn7P/3nfvzdMKi01LrsE9k9ILxzSQBhQFr5AUVnFXqvhXiQGOtXZnyTeH3yPqOlG
         ME3qSxWOTsVIor8/HBW4rznQBIyB6wKPBaRAaZTw3vHGkBZ/A26f7x/LZGhPfVo60s/V
         Mk+svDS0wfQNBNGXA2Tgx0iMiIlph0XLSVv8lkn/ihlQ0LW9SWyZFsYrnJp06DpDNHO/
         LqQLqpftykWL54nwlWYqrtVOeEMC+EaNsnKvf/KfifPXTtNZ/zf9u511maK1NNRv1IaS
         MqFCQ42lvHld/nar7kFhmpUh8sOicw4NYlt/IKtGF0kGQiAYvTR9ZuQCUuV8VHQzLVqO
         5rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686860506; x=1689452506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKBaB/9E61orl2m+5DjkcFtTpmNkTOXhn6/2KzxDt8E=;
        b=gDeqz/RiH7uPUewh1Q9DzklGC08fV9XDfPMez4zvECjZKiLpQjA+UwBKnY4QOZNLrh
         7ZGz+rfhUOJHPmdArrCgbtzG1MPkSIrcvlDsC8KkEjm4iBmfcvIEIhMs7/OdCV8nhP3/
         in0Sgwd1qUkxVPifGGzVZOoh5kzLe9Ft3m7atocpNNxlRFSHq26EktNknrPzKxRHAeTS
         u5KizV6eX/mlzh8aVT4HgzFww8G9kRf+PbTl0WYtcK5iSNfvPTZD01k7vA6AynbjNPU9
         OQ8OjE8PNUtbyVSJplmyfEsN4XmpzZdd0NnFIZsQscbvBhD4Wp+PYOfk8gzYBxx04oFt
         LGPA==
X-Gm-Message-State: AC+VfDz7Ah4uy+buqH0/DWmDMKTHJfs6pmN1YgjT2QehSALtnmWcdXiQ
        e8yhuKBkxBye0KPOn7UrmLZyxg==
X-Google-Smtp-Source: ACHHUZ4jCI6ENoZXpgGJ7CtbJ9sh9OfpRjutmpGobIkqDyDHRSTCIkpwNLdYH2zs1Tf2v3zimOKfoQ==
X-Received: by 2002:ac2:4985:0:b0:4f3:a485:919a with SMTP id f5-20020ac24985000000b004f3a485919amr10251508lfl.57.1686860505791;
        Thu, 15 Jun 2023 13:21:45 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b004f3946030fasm2736470lfm.68.2023.06.15.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:21:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 22:21:38 +0200
Subject: [PATCH 2/2] drm/panel: boe-tv101wum-nl6: Drop surplus prepare
 tracking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-fix-boe-tv101wum-nl6-v1-2-8ac378405fb7@linaro.org>
References: <20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org>
In-Reply-To: <20230615-fix-boe-tv101wum-nl6-v1-0-8ac378405fb7@linaro.org>
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
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

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index d19d30e134dd..412d4d99aec6 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -50,8 +50,6 @@ struct boe_panel {
 	struct regulator *avee;
 	struct regulator *avdd;
 	struct gpio_desc *enable_gpio;
-
-	bool prepared;
 };
 
 static int boe_tv110c9m_init(struct mipi_dsi_device *dsi)
@@ -1286,9 +1284,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 {
 	struct boe_panel *boe = to_boe_panel(panel);
 
-	if (!boe->prepared)
-		return 0;
-
 	if (boe->desc->discharge_on_disable) {
 		regulator_disable(boe->avee);
 		regulator_disable(boe->avdd);
@@ -1307,8 +1302,6 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->pp3300);
 	}
 
-	boe->prepared = false;
-
 	return 0;
 }
 
@@ -1317,9 +1310,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct boe_panel *boe = to_boe_panel(panel);
 	int ret;
 
-	if (boe->prepared)
-		return 0;
-
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
@@ -1357,8 +1347,6 @@ static int boe_panel_prepare(struct drm_panel *panel)
 		}
 	}
 
-	boe->prepared = true;
-
 	return 0;
 
 poweroff:

-- 
2.34.1

