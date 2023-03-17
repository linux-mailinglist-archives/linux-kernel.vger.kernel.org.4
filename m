Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139AE6BF643
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCQXYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCQXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68039B97;
        Fri, 17 Mar 2023 16:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3479B82721;
        Fri, 17 Mar 2023 23:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A925C4339B;
        Fri, 17 Mar 2023 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095442;
        bh=qSwlGWERs1iLO9M6K70WivJnuxc3M3Ft0dJO8xZoQJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1WGH2VKJyvt+F7JHvOFIyJ5SvuWReY+S9VwReaHbfTNZLQtXkyfHGqbUQto1YfUx
         x/kIM3OMLLVTzKOQx6Pg46IoCKgmzKzc2RgPRg2BWbwoJJCFiEJiQBcKUirI0GwPHB
         drtEdYfkMAea3oC2xqmKIq/XpOpT3KlCAv/SLuJVuU6v07AoKx2oTGip2mEX2128Yg
         Z89i0BOPSs+O32bGu+mjfAttK8qct9DkfVaCAd0DKN/fhYQgl72uKgW8xtVHaTzxsw
         fthTxzFDE/ov3bjmfy/S0zmyEAjmBBMVhy8FgbKwZiIMpqHvAIlF0cWK7zWx9i6UxK
         H/im055T+yKpQ==
Received: by mercury (Postfix, from userid 1000)
        id E186E1062105; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCHv1 5/7] drm/panel: sitronix-st7789v: make reset GPIO optional
Date:   Sat, 18 Mar 2023 00:23:53 +0100
Message-Id: <20230317232355.1554980-6-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317232355.1554980-1-sre@kernel.org>
References: <20230317232355.1554980-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset pin might not be software controllable from the SoC,
so make it optional.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index f7566551b5e2..1d43b8cc1647 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -369,7 +369,7 @@ static int st7789v_probe(struct spi_device *spi)
 	if (IS_ERR(ctx->power))
 		return PTR_ERR(ctx->power);
 
-	ctx->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset)) {
 		dev_err(&spi->dev, "Couldn't get our reset line\n");
 		return PTR_ERR(ctx->reset);
-- 
2.39.2

