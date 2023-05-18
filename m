Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4F708C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjERXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjERXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:06:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFAE10C6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76fd7c2aa67so201574039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684451203; x=1687043203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWvWiGJr56z9q9APTKrg8aD2bb2PPBSrUeKO9a/g3Js=;
        b=lA2Hqp+kdUMi3SHJQhTJWIgUTYRSIEEdfqnkzxCCwotAVtB/AxpD5T4O4WlqQfLSSc
         TNKqGHcYPppZs3tON5lhOhtGj/wqSExd/PoIrXZ6Bym/9wi+zX6lOH4uzTzzCd6851E5
         HaAHxOeBEDshdCjEWDYVVsMKwVuwYn/j7CDgHImKhsMH8QOMJ96BEVK+FhMgJop7gwpe
         zIhddlTDCY9YCP2Zymz1ScYcErRfvgyu9GKH8wCBtWsRhTVY9BMiE+1+kJUwEddCjTJg
         /SJMs1PB0B6d3vMfeUqyUvQa1m1BH82zfVJzmx869Qpv70W8Zqiv0Nq6Gz77x2EpsMVA
         qf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684451203; x=1687043203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWvWiGJr56z9q9APTKrg8aD2bb2PPBSrUeKO9a/g3Js=;
        b=jyNFikIKKJlIeg30zzAWaQTgjnezwhIFg1ZYbZqkYAf36caMFdhoD++L/pqgVatsw8
         BWw7K51PifOQ7fnZM+wwg0PoSDPdUg+dIbs+LQFwuiDeUesukTtjdJ7ygde+tixwAef8
         WmUG5JjjihU+28MbE3ufQUkrmP1K4htllFHaJw9NfGPa1L/njtrtCJrb6aJmlKKnhgZ5
         qZ2vjgUTxa/bTK3gsE/uPM8yMQtkZ1YxisLD4ptMvbwMqu2qJKqRUWizGc5GHYmIpu6/
         eL7ZEE8dgBe+EEyIJT6VK2UMxv+0lQ3lh5W7SK0/xGfBozP8Hokx8anllNNaBUrq8c/h
         gwTQ==
X-Gm-Message-State: AC+VfDwReqByneaorCB2PSrbxk+dGCI+R9snTjzlEQFJB2ssAgToycyx
        Ztrq34qw2WIz1vp860YPzEg=
X-Google-Smtp-Source: ACHHUZ6UOA1UEJhODzAvIyiNHCg4anOQmr91WME3HC/ntTLIZIcCmlm6eZTphfApwiECNFz0oopiGA==
X-Received: by 2002:a92:d142:0:b0:334:9ab1:b3c3 with SMTP id t2-20020a92d142000000b003349ab1b3c3mr5243548ilg.19.1684451202844;
        Thu, 18 May 2023 16:06:42 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:56b8:635c:4c7a:15b1])
        by smtp.gmail.com with ESMTPSA id z12-20020a92cd0c000000b003317ebbc426sm635897iln.47.2023.05.18.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:06:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V7 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Thu, 18 May 2023 18:06:23 -0500
Message-Id: <20230518230626.404068-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518230626.404068-1-aford173@gmail.com>
References: <20230518230626.404068-1-aford173@gmail.com>
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
 drivers/gpu/drm/bridge/samsung-dsim.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index bf4b33d2de76..6f012016068a 100644
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

