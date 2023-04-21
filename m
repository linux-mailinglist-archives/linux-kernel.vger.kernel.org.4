Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4676EAE40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjDUPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjDUPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:43:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5A125BF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3023a56048bso1426523f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682091822; x=1684683822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW+ZUAXLkCPmnHoH/QEWH9O+WPgZx65WOCCFjz1CHAM=;
        b=nb+hBMdcrVgPdTEAAlhH8tvqLPcAcJz+qsG46asq6w5gBoiU5xFayTkS7/4G+oltwJ
         XSZuXpr+7JFOUgx0PcxT6Wqcfgp1YnxK2AYDwOi/zC8lIFKuzqnXRTNNShhLITdvV7ZS
         tVuFm9N04qTVemGS43Bnm1XLQyJmX+05/tgvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091822; x=1684683822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW+ZUAXLkCPmnHoH/QEWH9O+WPgZx65WOCCFjz1CHAM=;
        b=GX8gkNvCopWyErXYWX55vNDPxUG7x9VV9bY9mSoxygMv51nYIb+GT6flA0yMnWlemC
         76aLkhaNU9Vc7HAbGVGJOwOmqT2CHiR+sPVDzWlJimGN/MzHFhUhDO+cJ2/2jAPS+CYo
         LFtZslIRTaX9rztDhDO2gZw5M3sjUZ/BRe8gHnkZY1JbKoqvFXlKvbh9Rpac4e4w1bUM
         uVimARs0JSUoXDrOviOTM/KrOengL0RNWMP/FKmziQJOqOQh1ierGGZeyWblQDeZhgjv
         gBzxKPq41G3PpoSnnF/qsdG2w6FwTGNKxC77zCEdb4k1EUye9z9ihlJRcY/355+MJBDz
         X7Ww==
X-Gm-Message-State: AAQBX9eUr46XxzVX6w6qX9mlb1JMz+3LOJ75Qqf3OAhI/j4U67byQVHL
        RsMi3Halbl/4QSmSWCqUx9LeP0zNOnfTjX0Jbhd+eg==
X-Google-Smtp-Source: AKy350aUqpOsGEUBPKmap982V3lMw+ed8+6wFN3e0Ia5CaZJ75H/BTx+qZ+ozLC13BwPYgKq1yWzWw==
X-Received: by 2002:a5d:6e02:0:b0:2fd:98a8:e800 with SMTP id h2-20020a5d6e02000000b002fd98a8e800mr4176367wrz.7.1682091822487;
        Fri, 21 Apr 2023 08:43:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.127.129])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b002e51195a3e2sm4651609wrw.79.2023.04.21.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:43:41 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 7/7] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
Date:   Fri, 21 Apr 2023 17:43:08 +0200
Message-Id: <20230421154308.527128-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Tianma TM041XDHG01 utilizes the Ilitek ILI9805 controller.

Add this panel's initialzation sequence and timing to ILI9805 driver.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 53 ++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 749959e10d92..cd187b0b1998 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -89,6 +89,36 @@ static const struct ili9805_instr gpm1780a0_init[] = {
 	ILI9805_INSTR(0, 0xB9, 0x02, 0x00),
 };
 
+static const struct ili9805_instr tm041xdhg01_init[] = {
+	ILI9805_INSTR(100, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
+		      ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3),
+	ILI9805_INSTR(100, 0xFD, 0x0F, 0x13, 0x44, 0x00),
+	ILI9805_INSTR(0, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x01,
+		      0x01, 0x30, 0x01, 0x01, 0x30, 0x01, 0x01),
+	ILI9805_INSTR(0, 0xB8, 0x74),
+	ILI9805_INSTR(0, 0xF1, 0x00),
+	ILI9805_INSTR(0, 0xF2, 0x00, 0x58, 0x40),
+	ILI9805_INSTR(0, 0xFC, 0x04, 0x0F, 0x01),
+	ILI9805_INSTR(0, 0xEB, 0x08, 0x0F),
+	ILI9805_INSTR(0, 0xe0, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
+	ILI9805_INSTR(0, 0xe1, 0x01, 0x0d, 0x15, 0x0e, 0x0f, 0x0f, 0x0b, 0x08, 0x04,
+		      0x07, 0x0a, 0x0d, 0x0c, 0x15, 0x0f, 0x08),
+	ILI9805_INSTR(10, 0xc1, 0x15, 0x03, 0x03, 0x31),
+	ILI9805_INSTR(10, 0xB1, 0x00, 0x12, 0x14),
+	ILI9805_INSTR(10, 0xB4, 0x02),
+	ILI9805_INSTR(0, 0xBB, 0x14, 0x55),
+	ILI9805_INSTR(0, MIPI_DCS_SET_ADDRESS_MODE, 0x0a),
+	ILI9805_INSTR(0, MIPI_DCS_SET_PIXEL_FORMAT, 0x77),
+	ILI9805_INSTR(0, 0x20),
+	ILI9805_INSTR(0, 0xB0, 0x00),
+	ILI9805_INSTR(0, 0xB6, 0x01),
+	ILI9805_INSTR(0, 0xc2, 0x11),
+	ILI9805_INSTR(0, 0x51, 0xFF),
+	ILI9805_INSTR(0, 0x53, 0x24),
+	ILI9805_INSTR(0, 0x55, 0x00),
+};
+
 static inline struct ili9805 *panel_to_ili9805(struct drm_panel *panel)
 {
 	return container_of(panel, struct ili9805, panel);
@@ -239,6 +269,20 @@ static const struct drm_display_mode gpm1780a0_timing = {
 	.vtotal = 480 + 2 + 4 + 10,
 };
 
+static const struct drm_display_mode tm041xdhg01_timing = {
+	.clock = 26227,
+
+	.hdisplay = 480,
+	.hsync_start = 480 + 10,
+	.hsync_end = 480 + 10 + 2,
+	.htotal = 480 + 10 + 2 + 36,
+
+	.vdisplay = 768,
+	.vsync_start = 768 + 2,
+	.vsync_end = 768 + 10 + 4,
+	.vtotal = 768 + 2 + 4 + 10,
+};
+
 static int ili9805_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -343,8 +387,17 @@ static const struct ili9805_desc gpm1780a0_desc = {
 	.height_mm = 65,
 };
 
+static const struct ili9805_desc tm041xdhg01_desc = {
+	.init = tm041xdhg01_init,
+	.init_length = ARRAY_SIZE(tm041xdhg01_init),
+	.mode = &tm041xdhg01_timing,
+	.width_mm = 42,
+	.height_mm = 96,
+};
+
 static const struct of_device_id ili9805_of_match[] = {
 	{ .compatible = "giantplus,gpm1790a0", .data = &gpm1780a0_desc },
+	{ .compatible = "tianma,tm041xdhg01", .data = &tm041xdhg01_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9805_of_match);
-- 
2.32.0

