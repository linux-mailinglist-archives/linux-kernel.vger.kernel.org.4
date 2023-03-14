Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991A6B8E21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCNJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCNJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:06:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD39439E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:06:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p20so15820813plw.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112; t=1678784765;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPpteo4ATSQTlt2Uy78H8BKjTtinyxmpjlM7PoSosZg=;
        b=Pp4J/V6FY45kA6usKh8NUctMPLBOoqaNIk1WFypJT66NbWWiolcuOj3MZN+23hp6HQ
         yuT7e1MK9c+sO+R704pmH4VDSY294tzQeM2+jxIeLZlpSr8KE2wzNeRgrNWlCl4Xzplc
         t/z5pKZMEgyl1WyfW++KzjsL89fd0uASsVdImEI+x4Aej++H+P9LID9Z3biiJl2SdkEd
         5csDXRXa34u8beuubYGzp/IoDzY0vkP0IuYhfbPDeONb6Y/DxCSK67i5ULaglnnQOJtq
         qUIppMym29nO2bQ9++l9MjjuZ5czHD0PK353GASnrzStsAoMjrXrvPxu6Cb9B1sMqmJd
         d3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678784765;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPpteo4ATSQTlt2Uy78H8BKjTtinyxmpjlM7PoSosZg=;
        b=ouqBLmC64sTo91TAEB/zT2HNCyLa/aSVuunLDfsubaUQfHxBqcE+LY/17NK9j82dMu
         jnBue1T+bqJ48gfJuEAbyFOn9/MxvIw4aPSnU1G9wiKPr6FxDv6AVZNPI96XROo4CvaV
         FiTETDRMylIn7fv4RbAeBFPnFnS65bo84lubSIS6esjaYgxOPPN26xWf7778wGgxkgwk
         0KniZp5j8nOvBn7GMeJepEA1HmgMmD8w51dmDgEqpiGsTHILfHkVC4QZeTd9UYz8ACQd
         DLLwT6XDnDkh8Ex5Hhgqgdr3Nhkb+kkrHkdpcq8WfkcWd/f3Ftk+Apef9UdijsXOGUN2
         mqzw==
X-Gm-Message-State: AO0yUKXEYl6zVEjNbmSomgJKwJmsw54ssA9G8T6j8oWDfbOOubt7g6Fh
        irmVvF46rutvjv6j01UcezuQRA==
X-Google-Smtp-Source: AK7set/rk3VGLbn93Pv/v2rMpU8p4stZP/MT6KR6NI3Piu73cpz/RU21gXZRGfhpSi6eXQ4J4A+cog==
X-Received: by 2002:a17:903:2341:b0:19c:d5c7:e3df with SMTP id c1-20020a170903234100b0019cd5c7e3dfmr43233579plh.8.1678784765501;
        Tue, 14 Mar 2023 02:06:05 -0700 (PDT)
Received: from chromeos.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0019f11a68c42sm1192586ple.297.2023.03.14.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:06:05 -0700 (PDT)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     neil.armstrong@linaro.org, sam@ravnborg.org, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Subject: [PATCH 2/2] drm/panel: support for STARRY 2081101QFH032011-53G MIPI-DSI panel
Date:   Tue, 14 Mar 2023 17:05:49 +0800
Message-Id: <20230314090549.11418-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STARRY 2081101QFH032011-53G is a 10.1" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index c924f1124ebc..783234ae0f57 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1131,6 +1131,103 @@ static const struct panel_init_cmd auo_b101uan08_3_init_cmd[] = {
 	{},
 };
 
+static const struct panel_init_cmd starry_qfh032011_53g_init_cmd[] = {
+	_INIT_DCS_CMD(0xB0, 0x01),
+	_INIT_DCS_CMD(0xC3, 0x4F),
+	_INIT_DCS_CMD(0xC4, 0x40),
+	_INIT_DCS_CMD(0xC5, 0x40),
+	_INIT_DCS_CMD(0xC6, 0x40),
+	_INIT_DCS_CMD(0xC7, 0x40),
+	_INIT_DCS_CMD(0xC8, 0x4D),
+	_INIT_DCS_CMD(0xC9, 0x52),
+	_INIT_DCS_CMD(0xCA, 0x51),
+	_INIT_DCS_CMD(0xCD, 0x5D),
+	_INIT_DCS_CMD(0xCE, 0x5B),
+	_INIT_DCS_CMD(0xCF, 0x4B),
+	_INIT_DCS_CMD(0xD0, 0x49),
+	_INIT_DCS_CMD(0xD1, 0x47),
+	_INIT_DCS_CMD(0xD2, 0x45),
+	_INIT_DCS_CMD(0xD3, 0x41),
+	_INIT_DCS_CMD(0xD7, 0x50),
+	_INIT_DCS_CMD(0xD8, 0x40),
+	_INIT_DCS_CMD(0xD9, 0x40),
+	_INIT_DCS_CMD(0xDA, 0x40),
+	_INIT_DCS_CMD(0xDB, 0x40),
+	_INIT_DCS_CMD(0xDC, 0x4E),
+	_INIT_DCS_CMD(0xDD, 0x52),
+	_INIT_DCS_CMD(0xDE, 0x51),
+	_INIT_DCS_CMD(0xE1, 0x5E),
+	_INIT_DCS_CMD(0xE2, 0x5C),
+	_INIT_DCS_CMD(0xE3, 0x4C),
+	_INIT_DCS_CMD(0xE4, 0x4A),
+	_INIT_DCS_CMD(0xE5, 0x48),
+	_INIT_DCS_CMD(0xE6, 0x46),
+	_INIT_DCS_CMD(0xE7, 0x42),
+	_INIT_DCS_CMD(0xB0, 0x03),
+	_INIT_DCS_CMD(0xBE, 0x03),
+	_INIT_DCS_CMD(0xCC, 0x44),
+	_INIT_DCS_CMD(0xC8, 0x07),
+	_INIT_DCS_CMD(0xC9, 0x05),
+	_INIT_DCS_CMD(0xCA, 0x42),
+	_INIT_DCS_CMD(0xCD, 0x3E),
+	_INIT_DCS_CMD(0xCF, 0x60),
+	_INIT_DCS_CMD(0xD2, 0x04),
+	_INIT_DCS_CMD(0xD3, 0x04),
+	_INIT_DCS_CMD(0xD4, 0x01),
+	_INIT_DCS_CMD(0xD5, 0x00),
+	_INIT_DCS_CMD(0xD6, 0x03),
+	_INIT_DCS_CMD(0xD7, 0x04),
+	_INIT_DCS_CMD(0xD9, 0x01),
+	_INIT_DCS_CMD(0xDB, 0x01),
+	_INIT_DCS_CMD(0xE4, 0xF0),
+	_INIT_DCS_CMD(0xE5, 0x0A),
+	_INIT_DCS_CMD(0xB0, 0x00),
+	_INIT_DCS_CMD(0xCC, 0x08),
+	_INIT_DCS_CMD(0xC2, 0x08),
+	_INIT_DCS_CMD(0xC4, 0x10),
+	_INIT_DCS_CMD(0xB0, 0x02),
+	_INIT_DCS_CMD(0xC0, 0x00),
+	_INIT_DCS_CMD(0xC1, 0x0A),
+	_INIT_DCS_CMD(0xC2, 0x20),
+	_INIT_DCS_CMD(0xC3, 0x24),
+	_INIT_DCS_CMD(0xC4, 0x23),
+	_INIT_DCS_CMD(0xC5, 0x29),
+	_INIT_DCS_CMD(0xC6, 0x23),
+	_INIT_DCS_CMD(0xC7, 0x1C),
+	_INIT_DCS_CMD(0xC8, 0x19),
+	_INIT_DCS_CMD(0xC9, 0x17),
+	_INIT_DCS_CMD(0xCA, 0x17),
+	_INIT_DCS_CMD(0xCB, 0x18),
+	_INIT_DCS_CMD(0xCC, 0x1A),
+	_INIT_DCS_CMD(0xCD, 0x1E),
+	_INIT_DCS_CMD(0xCE, 0x20),
+	_INIT_DCS_CMD(0xCF, 0x23),
+	_INIT_DCS_CMD(0xD0, 0x07),
+	_INIT_DCS_CMD(0xD1, 0x00),
+	_INIT_DCS_CMD(0xD2, 0x00),
+	_INIT_DCS_CMD(0xD3, 0x0A),
+	_INIT_DCS_CMD(0xD4, 0x13),
+	_INIT_DCS_CMD(0xD5, 0x1C),
+	_INIT_DCS_CMD(0xD6, 0x1A),
+	_INIT_DCS_CMD(0xD7, 0x13),
+	_INIT_DCS_CMD(0xD8, 0x17),
+	_INIT_DCS_CMD(0xD9, 0x1C),
+	_INIT_DCS_CMD(0xDA, 0x19),
+	_INIT_DCS_CMD(0xDB, 0x17),
+	_INIT_DCS_CMD(0xDC, 0x17),
+	_INIT_DCS_CMD(0xDD, 0x18),
+	_INIT_DCS_CMD(0xDE, 0x1A),
+	_INIT_DCS_CMD(0xDF, 0x1E),
+	_INIT_DCS_CMD(0xE0, 0x20),
+	_INIT_DCS_CMD(0xE1, 0x23),
+	_INIT_DCS_CMD(0xE2, 0x07),
+	_INIT_DCS_CMD(0X11),
+	_INIT_DELAY_CMD(120),
+	_INIT_DCS_CMD(0X29),
+	_INIT_DELAY_CMD(80),
+	{},
+};
+
 static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct boe_panel, base);
@@ -1497,6 +1594,32 @@ static const struct panel_desc boe_tv105wum_nw0_desc = {
 	.init_cmds = boe_init_cmd,
 };
 
+static const struct drm_display_mode starry_qfh032011_53g_default_mode = {
+	.clock = 165731,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 100,
+	.hsync_end = 1200 + 100 + 10,
+	.htotal = 1200 + 100 + 10 + 100,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 14,
+	.vsync_end = 1920 + 14 + 10,
+	.vtotal = 1920 + 14 + 10 + 15,
+};
+
+static const struct panel_desc starry_qfh032011_53g_desc = {
+	.modes = &starry_qfh032011_53g_default_mode,
+	.bpc = 8,
+	.size = {
+		.width_mm = 135,
+		.height_mm = 216,
+	},
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.init_cmds = starry_qfh032011_53g_init_cmd,
+};
+
 static int boe_panel_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -1667,6 +1790,9 @@ static const struct of_device_id boe_of_match[] = {
 	{ .compatible = "innolux,hj110iz-01a",
 	  .data = &inx_hj110iz_desc
 	},
+	{ .compatible = "starry,2081101qfh032011-53g",
+	  .data = &starry_qfh032011_53g_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_of_match);
-- 
2.17.1

