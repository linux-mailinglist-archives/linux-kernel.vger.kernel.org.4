Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E4733B53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjFPVHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344628AbjFPVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:07:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3793AB2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:07:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso1604702e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686949635; x=1689541635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAo6M7XHJBrfklypM5Ydm/bWCFc3N7r9+ZjeSM9TSy0=;
        b=k/Sg37jL0bq8yOMnp79UbvHBjt/7KKPymeGh/fBXXj6dJmWMl/4+revRUDn6ChXzp4
         KPCcp+B7oZcB4dt+SysRVrwaufHRtvFXdDeGYMeV78WAi2zeZ6DO3IJQxT5WmiuypECP
         Du0Jx/+JIJNE1elgIgub+YQ2PDbkG8QQ0Znwlejk2PAGUl8ddsKGDqwPaza3INmqaBoY
         iyHUtvLriP7D67QJR1UXjk3vQqxNQM3ttN810zdOfhujLYxyHysbhnp0CbekEoB43zUj
         Fc+0O8kxGO1svHijaIzFPHF3zZl9h31qR46Nm/8EkIIXd0KFqet99MRdyXUvmJHwYAi4
         UJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686949635; x=1689541635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAo6M7XHJBrfklypM5Ydm/bWCFc3N7r9+ZjeSM9TSy0=;
        b=JYQEJZjoyUtP5KSl4w1EZG1NmIsgjHf+6COPIeSZ61s1AmCCX8f8QUdfBz8XZWI0sT
         u45XfY/s6qCDXvJ3DIKu/hYgPfXbkeB+aZJ23TiI87Uch1e9KKpoRn9gdjJ+e85jINbA
         Ktgi3AwLzMRLns0GCA3AfIcthoM5TTWENypi0wemarPpg31q3AKr9thyGiI8+fySpFRL
         bIMFRmM9TYRIMqE6Y7SUKaZ8wAPRg2dOGdjOl4tEPHkey2bLqES7DmZ6nubWFo6Q8vCp
         MrkCWaJnUfwKRt4CxXaBYlpvsyWR0AJ88Cyo+Hv1X3w3Y+Sp43CeYakB7uGu0n+pvbL3
         WcLA==
X-Gm-Message-State: AC+VfDzBui6+/FuoZmvX3sZUTtsn46G5B6BQCbiktWWm3F/vHIbadCUq
        KH/7KW3xM0eLlthC5MKJ8FxmvA==
X-Google-Smtp-Source: ACHHUZ4+SQbd2m6icfnTivo60KcD45f/CeVUsqg3Gi8AdecA6lgIgSMsMavQrT9Q+Cwj1EnhqMMprA==
X-Received: by 2002:a05:6512:3129:b0:4f7:5d1b:4c24 with SMTP id p9-20020a056512312900b004f75d1b4c24mr2385493lfd.17.1686949635108;
        Fri, 16 Jun 2023 14:07:15 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id r12-20020ac24d0c000000b004f4ce9c9338sm3180909lfi.283.2023.06.16.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 14:07:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 23:07:12 +0200
Subject: [PATCH v2 2/2] drm/panel: boe-tv101wum-nl6: Drop surplus prepare
 tracking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-fix-boe-tv101wum-nl6-v2-2-457d7ece4590@linaro.org>
References: <20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org>
In-Reply-To: <20230615-fix-boe-tv101wum-nl6-v2-0-457d7ece4590@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index bc806d420ca7..24fbc1629e40 100644
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

