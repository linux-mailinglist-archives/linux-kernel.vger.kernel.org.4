Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08457743FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjF3Q3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjF3Q32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:29:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D53C22
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:29:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso307048f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688142565; x=1690734565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLQomoWqlEuvut1iVqbbj5exi8ubZWITHtJI3sKzn+8=;
        b=cmgqLpfuvG+if0xbg3zKjJmHd0RdVwXPeIhGpqg1MY4MUogkWDggmX3vNdUceKIQ5e
         J4OQRqLWYhUrTFtpVRdOqJFoNtQURpTCsF9Tua/BR6KVH1Z5uwzkti3gQkxVZQNu9lRG
         0UvJt7czJeoYcSJ5N35jxfpqhWtKcFRfOosQSBu2m8MgCzhs/kJf+QIMSu7DQDxLglis
         VHTPmRYqqhZvvwdiGkLc8dcZE7EKNa4nksg57/BOwLD/22L91EVszEl8D9AkIUQxybIL
         gqvCFsZ2zb/8p+mdWlkttwzh5I94B7T5p4POfgvwOsRQtcTyvJHPy7rfVsMzeI3JC4fb
         V2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688142565; x=1690734565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLQomoWqlEuvut1iVqbbj5exi8ubZWITHtJI3sKzn+8=;
        b=ZvjTXZuf6d+VIvuctIiNtzStvt3FRELFYSyje2Qja4icFeZX/iTroW6qdw4K6vQg+S
         58paCH7vsqAEo9+iJHHtjgAg7z4raE+QNqjiFIcnUEHP94N75lvF1grnEb+4x6EVezSl
         IAKcKT96xVy8/9kS5fRzshuS+afJIdmXH65FFc6hrZVKhwsle8dlwLkTidkqxNJIaVfx
         qAPlGowsUF5hdoWZevGiKHxC0PG5ze16pDn1s2ifPmRONqvI8jRxlhU2Yjj0vo9Vfsqs
         ieEIW/3a56SMr8xfoEfx2ffAdG/gU7Sllaeytm/i58pOsHoVQexLRfJGSYr5iWfIiLmi
         9gKQ==
X-Gm-Message-State: ABy/qLbviqpTZuG6xtqyR5lFV85sQlVyIksS4sFOmE5xgHCW8PhxL6we
        Lp6Br+qAl1AV9PUwUICzTQFATQ==
X-Google-Smtp-Source: APBJJlFauMJrbtEhAPnBe75TN+jmd6XzbnZMpUxj/sIL52hxut6neaSf+FGnEne95dLchbEIkdRBZg==
X-Received: by 2002:adf:cc86:0:b0:314:1244:7fe5 with SMTP id p6-20020adfcc86000000b0031412447fe5mr2455634wrj.55.1688142565225;
        Fri, 30 Jun 2023 09:29:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm18835836wrb.84.2023.06.30.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:29:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 30 Jun 2023 18:29:12 +0200
Subject: [PATCH v6 5/9] drm/meson: gate px_clk when setting rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-5-fd2ac9845472@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v6-0-fd2ac9845472@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+pwHqu7ZxC7Ri6gVdtmlOTLk1wyBSRQ1FGdiXUQUWjE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknwLbtNANq+/HzXMwO/oD3Ticr4j3+8MstaXiDrlk
 AGLwCXWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ8C2wAKCRB33NvayMhJ0Zt2D/
 9ruyKKElwSqnsoH9WgUG+bQVpc7hi+zAfq714A1xl/IfX6w66J92C407oo1AmST/B7W8nthq2Icl64
 fRZYduun8JHmQE4z82jK3SzdIIXIOe7MJbgZTQbewAwmgbWlWR6uDh8j3KWL5moO/Qn+HAceY6AMBW
 Xz89TrKd6lZYNbksxR3ZdREBUFa3kEbzpKPvuCib1FrsHu3FY/kBVjcZxRBvFXFeyNQwyLVTI9Ww3a
 7iuy5hJlISdeqkRwCOqHDSezEKlfVlCO6vbGEeR5elF2Q0gxfuT+Po/bLLroDP7UuQmtxTna04hF5T
 nuRILRb4+2cb5eOV4392RcLaquxbFdYT+UmaBX3L+7xhDUU9gNciuwNmeR2aIaBEjhqzIHVCbMwyuQ
 vqVhlJM6+M4LPZhy0qXpZuQsuvyinYOY8EcWTWP9taudTNuOD3KD95VMkEpj9ZLoaZojc2ULEZ01oO
 /jwv3hk0TeDgVP72XKk85vJbYGC1xMLkll8XGFDhFOvKHO3B4DEWLkrkyzh2bBS8+VJjh7W42QNzpw
 OuqBk4nmoVKOS0rgHsbN3u0I2sGwFzntG1CU0IDTyfEaI+5kCL/SjIMz6M13N0O4R0zZB6Ak33fDwo
 HUMEub2+IlcdqBVY5vf0vzpRJPzCKd7VO91ARFOBj8+1GAiTwBAlDqcemXpw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the px_clk when setting the rate to recover a fully
configured and correctly reset VCLK clock tree after the rate
is set.

Fixes: 77d9e1e6b846 ("drm/meson: add support for MIPI-DSI transceiver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
index 57447abf1a29..dc63d2d813a9 100644
--- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
+++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
@@ -94,6 +94,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	clk_disable_unprepare(mipi_dsi->px_clk);
 	ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 1000);
 
 	if (ret) {
@@ -102,6 +103,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	clk_prepare_enable(mipi_dsi->px_clk);
+	if (ret) {
+		dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock (ret %d)\n", ret);
+		return ret;
+	}
+
 	switch (mipi_dsi->dsi_device->format) {
 	case MIPI_DSI_FMT_RGB888:
 		dpi_data_format = DPI_COLOR_24BIT;

-- 
2.34.1

