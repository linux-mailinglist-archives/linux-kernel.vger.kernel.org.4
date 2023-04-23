Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653A76EBF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDWMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDWMNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 08:13:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A581733
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763ae18986cso45292739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682251977; x=1684843977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8jgcM/QeE+Y8+Tr1jy98fVl4Bmm9q0XNJC4VTJTM+4=;
        b=JLzNHOnxE/Vlwa1HzZoN9UvluDSoAkJFGjmilwdrZTHODn/B7WZdQo7WJVxGLOdN7P
         41iUIe9L5ctu6NXqWhWF/1BN6smV+7uv+21u4sE/cuNMlSTkM/7HegdzxECGDsXkwpqf
         3UZiJe9PYRE7ni885DRXTw9Y7+unExr9OxeBkQ3V8RiTgFTtRHKVLzfLsZLFWYUpOR4Y
         jz+GeF5+kA/+aBsfgbJLeN6tCtFltbkAsZAtSWChw2el75ZYa0P2JtRGNvw8bPlQtO4Y
         ZEwyr3AgNLNfZrvwn97aAw/SQs/eXhWhuI4J14L30r1VywENs6jB2cczfwXedgy5Pneh
         11Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682251977; x=1684843977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8jgcM/QeE+Y8+Tr1jy98fVl4Bmm9q0XNJC4VTJTM+4=;
        b=hFJ7Eo8AWdSE7DCmBj5YPSW3+tKzMMyro15ld4AGGK1iH9dfjnIwO38pr6jEK0euYH
         nfFL/+Bjz7PQkJf0733m6DTp+1gsBVqoXeQ1BetoXNOxwaWwrEKsLXBKBLDZHNe8Lipb
         UCJMaOeeACgw7DigNTXWUV74T9R+NF/kahH2A3C4sAwaT3SQ/t59byC21pyHWqaYO2mV
         IHIFmfds1Y+9A0KU+u5HYD+H5xeDpLAKE19O+0Y6JUZq4HjJPH1T/Zp+2Xhv5FPDJMGK
         iyJS6WGIgtbPxSwbIqIk+ozDpBYNHL0k5uzZ7wHbxkt2c2/qDmw++cWE7nN5moX6g+S9
         P3XQ==
X-Gm-Message-State: AAQBX9dGuHzlGHcZT73tOvZE+kjLHuu6rdHpT6ctg1/xhsbbee4c+LT4
        0tq7+MLQ5FFWJp+fEUh1/2k=
X-Google-Smtp-Source: AKy350ajJ9p8UuNCdHf/nb41YNZSCy7QL46641e67mbV4AIeXZePMPVquMYo6Rj4SZM0+ArxtubmcQ==
X-Received: by 2002:a92:cd4f:0:b0:329:bba2:781e with SMTP id v15-20020a92cd4f000000b00329bba2781emr3531026ilq.17.1682251977351;
        Sun, 23 Apr 2023 05:12:57 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b473:5d7c:4c2:75d7])
        by smtp.gmail.com with ESMTPSA id u11-20020a02230b000000b00411a1373aa5sm1612155jau.155.2023.04.23.05.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 05:12:56 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com, l.stach@pengutronix.de,
        Adam Ford <aford173@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Sun, 23 Apr 2023 07:12:29 -0500
Message-Id: <20230423121232.1345909-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423121232.1345909-1-aford173@gmail.com>
References: <20230423121232.1345909-1-aford173@gmail.com>
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
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index adb9c13c5f7f..5b6e7825b92f 100644
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

