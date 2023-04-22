Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33426EBB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDVUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDVUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD226B2;
        Sat, 22 Apr 2023 13:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E6BA6146B;
        Sat, 22 Apr 2023 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB110C433D2;
        Sat, 22 Apr 2023 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196628;
        bh=a2pmQKhWvqek1TX2Y5M9kp9YI0QTZuxBZ8Pn1du4Q14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTdf1W/fhgUsR36kxaQSiJtoiR0FUIqR3aEKF1oR7hKnc5ccdAN/vjXf/171iKs8S
         /IUpoe7vueYk3sl2ueUv2v4kwD4JDp7HNTN8AIMjYXVCFQFx200rUzXx/cswDw3S5T
         Cs0n4GQHE8ONmawLjvCHehhC88dpXxqvVokRDX0zkzJ9iGb9+lRe6IFdjyl99ZwIqg
         F5yM99O8cGdls2LnruIVq5sgXLacc6Mnk2SVhyEetE3+TKfozolG7jEf+oIqlUZ0Kx
         XFEcjpEZr6X11UBcABurU+9vvVOB96bryMOC3rrKgLa5sJregtRzpcUu6MIcpwX5kh
         Q0zeFG0IzG7cw==
Received: by mercury (Postfix, from userid 1000)
        id 0DE791066CC1; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
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
Subject: [PATCH v2 03/13] drm/panel: sitronix-st7789v: add SPI ID table
Date:   Sat, 22 Apr 2023 22:50:02 +0200
Message-Id: <20230422205012.2464933-4-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

