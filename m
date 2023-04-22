Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF66EBB51
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDVUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDVUud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF0626B0;
        Sat, 22 Apr 2023 13:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0941961455;
        Sat, 22 Apr 2023 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48683C4339E;
        Sat, 22 Apr 2023 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196630;
        bh=qSwlGWERs1iLO9M6K70WivJnuxc3M3Ft0dJO8xZoQJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WR0Y2Gkj8T3l8/g3V/e8fiXBUxcANbDupyE0B/Q659iKEKhTAQUZcsnarxo5od6si
         znbRTZLKLRJAY5+pyhzFutqtes/QWu1HbVXTrVIaEgsVq6n7tXtQLu+etq43fEJBEM
         j19RBI4qH8lknwNqM591bJGsClcnCr2TegH22VkgvW6XapB62heg1dP1UDQSvVT0wO
         bFAR2HdF67wIHIJoL51AWnF6UDK1EoCj6pGHTAopcp/DejPJL/sI3PkO3guXoDC9y8
         nrwUDxYkCjCkGClsi6Boyau1iv5tCPXkOIKOWACSf2pOCbVMaETq0qk4ZTXqbdzYPS
         tcAO0YLp6nSyA==
Received: by mercury (Postfix, from userid 1000)
        id 127C91066CC4; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
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
Subject: [PATCH v2 05/13] drm/panel: sitronix-st7789v: make reset GPIO optional
Date:   Sat, 22 Apr 2023 22:50:04 +0200
Message-Id: <20230422205012.2464933-6-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

