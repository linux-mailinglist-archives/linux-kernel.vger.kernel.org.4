Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8774F70418A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343588AbjEOX5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245660AbjEOX5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:57:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E9B7D8B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-335598ae8b4so23943335ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684195050; x=1686787050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGf6Qk2Pei70JszeZYr/InGuWclnzPcF9rdeGDlmncY=;
        b=WKf6iKEwJW+JH+izv3pO5+TluFDpk3Irpt8sdgSFkTg5B7saI7UtoWlfkfvJWeN2NM
         0iBSxfrGgnV7E+nOnCebrSJmD2nJm2r3QTZ8zozl/alYnh6uj9quf9SAN/ynXBXu8aho
         A5Bur7Z2y32mMHU9vGyultqzxQILOmdnPDErhTiGDpXMt3rtUzpNZkx2fxvcFHt1+XoE
         gPgfDY+KvlDRQ2IELYjA9G4fA+XNMmKXOwEPQKl41jbYKWAesL0SscOkP3n7nKdM7Z46
         ZbDGf1h3Qp2OZod6tin4VmgfHwRVPKMI5MDCpV9EleTZ0iz07OZjwLEph4kpwmcFpgd/
         FeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195050; x=1686787050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGf6Qk2Pei70JszeZYr/InGuWclnzPcF9rdeGDlmncY=;
        b=dktssw9VDtrs558aHt9q03yUc9G7SxZ111qGH/DaGOtBvk4plF19mbRgd499QUiyZx
         nFkIgvBjpVXEtDMwJOVVQ3ejM0PoicRvUoiQDKZwGnjd4E9ZuNvr97268HR5Qmlr5b1/
         JesYGp6IMzbTCNCyiXMqp1O46/vqZtJViYDjsHlQqWp9CPFKvcVAxfSO1C3gr7/CbmfP
         8cjr0eFgN18frEU7h0XyYAj62JnzQB51QET6a2Tmku5Byt41aOERHhHEGSv0095aCcw2
         G4doxyjFpDBkvPXkFu9TxFexxOtwuasriTRr12F5QKry67ZMajkfxjUlUZEILPBXoUdS
         ZmYw==
X-Gm-Message-State: AC+VfDy8xRHgAu1+ddy+bcTfwYjaQUNgIZKVZ/SSZfm2RsF/cb04ZPis
        oHXDYWMFWKe45STi5FVXP4I=
X-Google-Smtp-Source: ACHHUZ6gow7oNVFca0dTRdxrmQ2bgjVa0JzeuaVFUGZPpOsvRN/GwpHmyuS5D5c53sAv932XgXy/eQ==
X-Received: by 2002:a05:6e02:4cd:b0:331:7d58:b296 with SMTP id f13-20020a056e0204cd00b003317d58b296mr23518638ils.12.1684195050425;
        Mon, 15 May 2023 16:57:30 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:61e0:9fee:1bca:ea3c])
        by smtp.gmail.com with ESMTPSA id f6-20020a056638112600b00411b5ea8576sm7427851jar.108.2023.05.15.16.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 16:57:30 -0700 (PDT)
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
Subject: [PATCH V6 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Mon, 15 May 2023 18:57:10 -0500
Message-Id: <20230515235713.232939-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515235713.232939-1-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
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

