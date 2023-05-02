Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1D6F3BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjEBBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjEBBIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:08:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5F35A8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 18:08:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-76937f5f9c5so44393739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 18:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989693; x=1685581693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhrMWjFte7goMFkthyl+3kO5kW7x7TcIvC2UAKwMf6E=;
        b=ID1JuvXXaLMCf95WTEkk2TJJKto2G0IwIyP5dukwdxsKvv6+k9wvTf0ZW/8rB6Iq9G
         Zr9cdfS0Zm+DAwfcYuSXj3csRRYTcq+dqgwfOOiWevPX6vSU8C8yq8DhL6Mn2SwZ5k5m
         6Gx+4MXd56NJr9DFfDZ3Wm0SsfSgXsUDx1sNzDzfAcWZ/0G9P7CtwcwnBPAG2kUe/fV+
         Q+t++OufgZxqNj1XmNls0xVCt/cYMiFq9CPQQv6tKwAnU1EdD4xWF+TPj+sSLixJZmH6
         cYS+sGVy/YHVhOYzIx2a1YkrWkqPdWwquZmf0cUr4AGdwbap/KgrtTcXTnJ947vaX1Jy
         UZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989693; x=1685581693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhrMWjFte7goMFkthyl+3kO5kW7x7TcIvC2UAKwMf6E=;
        b=YLEl3Wed4gEkPD6RjVu7EalPvagC8oaatcANFLL0aXi9TAaqpwwQeMZQSImlTv1AGq
         rCbWesWiKc4cP6kj9TDLN7el/XLvz0jK1C67XTBFKNqQc2CtMdDBmeGBzeOVSQVz25z5
         3jREaWf5NiiEQ5C5pcyR00oRST4OBopDiqoD+j7c9rE3pDzUHIFRa1OMdW/kKZuLrdD2
         urLKDWZcw4Poq8CGNU3Zc7RGg+pfYWwuToMWPuTaP4XsUgHHJi5Qp1n+MQ4BSN/2Dk8C
         NFwTvV4Ow78CU2rDslpOuQk9Ni58pBvPt48hAgA3/VFvqNhV7a1Y8hPoSx4SSd/i0Vqw
         xgEQ==
X-Gm-Message-State: AC+VfDytJ1QpWbhDP6LzWDuz0/Uv6Ua/adnD+SUrgFxZE7mN539riy7N
        EPSrmGf0XhQ/iZju/0fKwYQ=
X-Google-Smtp-Source: ACHHUZ6jgYXGX6mtJyfGHfUHNtSJtYe7P86rVbqtcMJ4m+zA6lQ0bmX9P7E+oHlh4NkdFCZqHx4ikA==
X-Received: by 2002:a6b:f007:0:b0:766:41fa:e26c with SMTP id w7-20020a6bf007000000b0076641fae26cmr11441794ioc.10.1682989692703;
        Mon, 01 May 2023 18:08:12 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:8257:a536:d7fc:1919])
        by smtp.gmail.com with ESMTPSA id f16-20020a056638329000b0040fb5d5429fsm4836329jav.131.2023.05.01.18.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:08:12 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
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
Subject: [PATCH V3 3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Mon,  1 May 2023 20:07:55 -0500
Message-Id: <20230502010759.17282-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502010759.17282-1-aford173@gmail.com>
References: <20230502010759.17282-1-aford173@gmail.com>
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

