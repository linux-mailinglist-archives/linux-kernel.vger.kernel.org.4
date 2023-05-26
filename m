Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586D711E49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjEZDGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjEZDGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:06:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B16EE;
        Thu, 25 May 2023 20:06:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-775ebe161c5so36749139f.1;
        Thu, 25 May 2023 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685070373; x=1687662373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4m+SxN0F0Y0gWSy4hAB1qq6hSK5gmQVgTqdKocNkWU=;
        b=G1+4wtnmneykm0K9b15UIaGEHefo++3tYOvy4KDpO0mPXGGmTm3ssccTpYpL1czgTP
         gjYAvksSX14t7webtghb/eVRD9Uo3MHm5AZ2oRmb6aJReJLafMSZjYRz+mb6Q++ADstk
         WkXiT/Khi4NtMFg8/jZ3A34BKnpsrazY3gU5SyEtQfWpGsGFHhhngAYoGlWeN5NOgDYn
         GjRiSo0L/7lQsH6aSCuH0KLb5C+J3KzynHTaRmkVI+sJnktZFTN1PYwFdRBgB9tYnZDC
         ZPTGU16O+b6e2nR4lLpJW4NeTu0ugd0oTdrfGAXB75twYltBpJHSSP+RkqYhOkA0OKC/
         3vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685070373; x=1687662373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4m+SxN0F0Y0gWSy4hAB1qq6hSK5gmQVgTqdKocNkWU=;
        b=EVP4+LGBwQyfwDWMcjXhvbg07c94HNLK+A2M3pSe4EQZ1wv9/4MscbrK6IfKgicJzA
         2+kTRjZFEcjISQh2zgDZNrXDtL2A4QG2kQ9WiJu8d4dG8MVGpE1m8EWQMWTsjuAglBRn
         OyLsLYZemf6TigDhfEorkoCY3F2SB2Oeb6Tn8sHEk0VmmyZ9kilHbGTL98FsM74MG9PE
         avNOKa9RGZ9PouJPECxkn74fPozNGwmdPzBs2K0LFe9Oq3+3a3QauZEusdSJwVfsLljc
         43OTVp7pekE7kvZaEBbYT8ChiI4JJylqOh/uGe9hxUxS5wMjwfHX+4/O7lxxaxv69Pym
         ah7A==
X-Gm-Message-State: AC+VfDxn5AJ/YlBrAxrqrjnpJU+CpzjyodxjQ6sdl1lvk64DgJJnotVM
        lRRMCBYemX4JPtouGe07J4Y=
X-Google-Smtp-Source: ACHHUZ5HJkcQcD7QtO9eES+T8k3Crv2uiCgxRg2hT82XCPydi0MG+xerjTM7CtFCCYRzVQVpmA7bRQ==
X-Received: by 2002:a05:6602:180f:b0:76c:4db8:c1ea with SMTP id t15-20020a056602180f00b0076c4db8c1eamr119297ioh.10.1685070373034;
        Thu, 25 May 2023 20:06:13 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:3dd9:3f6c:9922:6420])
        by smtp.gmail.com with ESMTPSA id i2-20020a5e8502000000b007702f55116fsm363189ioj.38.2023.05.25.20.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 20:06:12 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Inki Dae <inki.dae@samsung.com>,
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
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Thu, 25 May 2023 22:05:55 -0500
Message-Id: <20230526030559.326566-4-aford173@gmail.com>
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

Make the pll-clock-frequency optional.  If it's present, use it
to maintain backwards compatibility with existing hardware.  If it
is absent, read clock rate of "sclk_mipi" to determine the rate.
Since it can be optional, change the message from an error to
dev_info.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index ead922c3ce9f..307f1c20cfb9 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1719,11 +1719,11 @@ static const struct mipi_dsi_host_ops samsung_dsim_ops = {
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
@@ -1736,19 +1736,27 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
 	u32 lane_polarities[5] = { 0 };
 	struct device_node *endpoint;
 	int i, nr_lanes, ret;
+	struct clk *pll_clk;
 
 	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
-				       &dsi->pll_clk_rate);
-	if (ret < 0)
-		return ret;
+				       &dsi->pll_clk_rate, 1);
+	/* If it doesn't exist, read it from the clock instead of failing */
+	if (ret < 0) {
+		dev_dbg(dev, "Using sclk_mipi for pll clock frequency\n");
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

