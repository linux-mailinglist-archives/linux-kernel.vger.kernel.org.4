Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D46BF63D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCQXYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:24:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B63399C4;
        Fri, 17 Mar 2023 16:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFD9FB8271D;
        Fri, 17 Mar 2023 23:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D6CC433D2;
        Fri, 17 Mar 2023 23:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679095440;
        bh=a2pmQKhWvqek1TX2Y5M9kp9YI0QTZuxBZ8Pn1du4Q14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YswHAzC7nKZ15q/r11zI/x/msEanukF5qbiQVlo9kmxcb4imSfUdgxHC9nQVQlKmp
         htOtDJTCF5ahTyuAPLjbLuCZcsSLe3+oE2LiWMed61UxmDvDhmkr5hl3+eTrYiOaub
         hTjygRfkTY9+6NMGVsHon8iQHSS3RrNPdxFoCwzUKpfMfQ2uopFDRtv1CEbl7pLs6C
         Ddy41hsOte1nfpEaXYN55KkmWz2hG2+xQSyomJHDrBTDMuYc1o3QfVoc6vE+XbV20I
         BYB7NnV3phVhss+f+0IEh2lXGjap2VQbGX/pIzE9kdQTR+u+lfdpUB9MyHux/k1xWS
         6QAvDo2OohBlw==
Received: by mercury (Postfix, from userid 1000)
        id DD4561062101; Sat, 18 Mar 2023 00:23:57 +0100 (CET)
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
Subject: [PATCHv1 3/7] drm/panel: sitronix-st7789v: add SPI ID table
Date:   Sat, 18 Mar 2023 00:23:51 +0100
Message-Id: <20230317232355.1554980-4-sre@kernel.org>
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

SPI device drivers should also have a SPI ID table.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index bbc4569cbcdc..e4d8dea1db36 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -394,6 +394,12 @@ static void st7789v_remove(struct spi_device *spi)
 	drm_panel_remove(&ctx->panel);
 }
 
+static const struct spi_device_id st7789v_spi_id[] = {
+	{ "st7789v" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, st7789v_spi_id);
+
 static const struct of_device_id st7789v_of_match[] = {
 	{ .compatible = "sitronix,st7789v" },
 	{ }
@@ -403,6 +409,7 @@ MODULE_DEVICE_TABLE(of, st7789v_of_match);
 static struct spi_driver st7789v_driver = {
 	.probe = st7789v_probe,
 	.remove = st7789v_remove,
+	.id_table = st7789v_spi_id,
 	.driver = {
 		.name = "st7789v",
 		.of_match_table = st7789v_of_match,
-- 
2.39.2

