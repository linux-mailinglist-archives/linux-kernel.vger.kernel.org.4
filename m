Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB56F93C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEFTZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEFTZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:25:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42B1890C
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 12:25:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760f8ffb27fso67414439f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683401123; x=1685993123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGf6Qk2Pei70JszeZYr/InGuWclnzPcF9rdeGDlmncY=;
        b=JLwKPoBSNRMUtTPYh7/CnJk9JmGEJ5tz3DzL9yMvjoqGGURAH5xCA4E3WtTxZguuTm
         Ds1vWVLs7AW5lNv3uQsEof/mdHS3H59aNxD7gBDSXRRA8+f1swi1NCAsZGHgo05t+4v3
         ac2zQUSAQcWNtGNKli2H8xwOa2SDUtbc7zHKjfyaJOR5ewgvVXymFUoyIinX7o/qvtLo
         VBjatTgTXT+dRpFPqjvG8XsZ+swa32UK8txY15LY+Y2vwVXkUuMoA/6RhOPhljU6MWmJ
         uBNWh8avyOfvZlxLF/fR7BMGPKoabDpQqf/jmdKRB06C2KaQ7sk/XmWYKIscoGOsUoWt
         O6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683401123; x=1685993123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGf6Qk2Pei70JszeZYr/InGuWclnzPcF9rdeGDlmncY=;
        b=KX2Td/g+7WZiu68hhhXIkH8QeiJLKlVxIef0SpZY970UDTIpp4JnoqBjp3a6SMb6nP
         4d95SwAMorA/iD5mv7rqSMWFUSwuLM1dGjI2eolPZLBM6f6xKNfpYa2FDhnS2b+k21xx
         j5oPxbjdCSBWnNB794BkcIC4IRwuJjwA2uUAmBxkygzQzPnXXrtmu6WYzGuLzSG52D5Q
         WtbHR+Es+Ysm8gvcVtNbckwvlK/WOGwe/cSREbcES9+oTu14I1MDVciz4uRe/BZeKIwc
         Qt3qVfd+DrXzLGgmzlZCjwTHHXdv+7OWDTzrxhfdit92zkrimULjab7gvTiLUQMhEnvb
         4C/g==
X-Gm-Message-State: AC+VfDww+2T9zmYjdFSk83tr/SoPc7vd+bEdnolt0dERtHuOz/+Tgi2P
        UKH1DqyUnzn5WHoeIBUPUks=
X-Google-Smtp-Source: ACHHUZ7OI6Q6k4RbKjfIoaHz6zbC3YTaTSfFLXggOj9V7CFy7kWCWRvWIHiVgGHKdgWGH8konC7j5w==
X-Received: by 2002:a6b:e311:0:b0:769:b812:c536 with SMTP id u17-20020a6be311000000b00769b812c536mr3769889ioc.5.1683401123363;
        Sat, 06 May 2023 12:25:23 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:5e49:1bed:79d0:5c25])
        by smtp.gmail.com with ESMTPSA id z18-20020a05663822b200b0041631393ac9sm847824jas.18.2023.05.06.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 12:25:22 -0700 (PDT)
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
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Sat,  6 May 2023 14:24:50 -0500
Message-Id: <20230506192453.725621-4-aford173@gmail.com>
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

Make the pll-clock-frequency optional.  If it's present, use it
to maintain backwards compatibility with existing hardware.  If it
is absent, read clock rate of "sclk_mipi" to determine the rate.
Since it can be optional, change the message from an error to
dev_info.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index bf4b33d2de76..08266303c261 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1712,11 +1712,11 @@ static const struct mipi_dsi_host_ops samsung_dsim_ops = {
 };
 
 static int samsung_dsim_of_read_u32(const struct device_node *np,
-				    const char *propname, u32 *out_value)
+				    const char *propname, u32 *out_value, bool optional)
 {
 	int ret = of_property_read_u32(np, propname, out_value);
 
-	if (ret < 0)
+	if (ret < 0 && !optional)
 		pr_err("%pOF: failed to get '%s' property\n", np, propname);
 
 	return ret;
@@ -1726,20 +1726,29 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 {
 	struct device *dev = dsi->dev;
 	struct device_node *node = dev->of_node;
+	struct clk *pll_clk;
 	int ret;
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
-				       &dsi->pll_clk_rate);
-	if (ret < 0)
-		return ret;
+				       &dsi->pll_clk_rate, 1);
+
+	/* If it doesn't exist, read it from the clock instead of failing */
+	if (ret < 0) {
+		dev_info(dev, "Using sclk_mipi for pll clock frequency\n");
+		pll_clk = devm_clk_get(dev, "sclk_mipi");
+		if (!IS_ERR(pll_clk))
+			dsi->pll_clk_rate = clk_get_rate(pll_clk);
+		else
+			return PTR_ERR(pll_clk);
+	}
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
-				       &dsi->burst_clk_rate);
+				       &dsi->burst_clk_rate, 0);
 	if (ret < 0)
 		return ret;
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
-				       &dsi->esc_clk_rate);
+				       &dsi->esc_clk_rate, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2

