Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D976EBB5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDVUvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDVUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEA2707;
        Sat, 22 Apr 2023 13:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE526154A;
        Sat, 22 Apr 2023 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62051C433A0;
        Sat, 22 Apr 2023 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196630;
        bh=1l9FZ20oEDWymbieoAwHPoR8F5js0yQ4cqzFrz8ZJSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3kFpcugwh6SrXrf0AACnC0GZ2ci4nyX29YS0xlBjJS6ybq/SvyXf8BimJnkCbq7R
         S19s7XEx5DSPc8x9xoDFPlvjSQ+zAZ0qPRq+STcYkqJ74xbrxhOPL8Kc3SFpF3V4my
         kjAkFm/kwmHVKEMmhOjwyf3P6WTfssnOQFaFa4Q+Iqq3zm0/ggL/dYkXrWJ056F+BK
         YSO7Y3h3NstiQIJvqEWe6hn45bRb9qkvz3cSPjMAx0VsDHxqxSwZe2JwiDSsr6oJ+N
         8f8x34oND6WJ+sqxQYN78YN6eC5igTfWChsqNHkw1S6zDR6YkWGogNIgQbgnJVhgPB
         k8BjjxiMgPB9w==
Received: by mercury (Postfix, from userid 1000)
        id 2058C1066CCE; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
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
Subject: [PATCH v2 11/13] drm/panel: sitronix-st7789v: avoid hardcoding invert mode
Date:   Sat, 22 Apr 2023 22:50:10 +0200
Message-Id: <20230422205012.2464933-12-sre@kernel.org>
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

While the default panel uses invert mode, some panels
require non-invert mode instead.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 6d155c6262f3..158623a8dfb7 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -112,6 +112,7 @@
 struct st7789_panel_info {
 	const struct drm_display_mode *mode;
 	u32 bus_format;
+	bool invert_mode;
 };
 
 struct st7789v {
@@ -171,6 +172,7 @@ static const struct drm_display_mode default_mode = {
 
 struct st7789_panel_info default_panel = {
 	.mode = &default_mode,
+	.invert_mode = true,
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
@@ -321,7 +323,13 @@ static int st7789v_prepare(struct drm_panel *panel)
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_NVGAMCTRL_VN61(0x1b)));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_NVGAMCTRL_VN62(0x28)));
 
-	ST7789V_TEST(ret, st7789v_write_command(ctx, MIPI_DCS_ENTER_INVERT_MODE));
+	if (ctx->info->invert_mode) {
+		ST7789V_TEST(ret, st7789v_write_command(ctx,
+						MIPI_DCS_ENTER_INVERT_MODE));
+	} else {
+		ST7789V_TEST(ret, st7789v_write_command(ctx,
+						MIPI_DCS_EXIT_INVERT_MODE));
+	}
 
 	ST7789V_TEST(ret, st7789v_write_command(ctx, ST7789V_RAMCTRL_CMD));
 	ST7789V_TEST(ret, st7789v_write_data(ctx, ST7789V_RAMCTRL_DM_RGB |
-- 
2.39.2

