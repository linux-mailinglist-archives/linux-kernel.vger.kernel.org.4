Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F67639C80
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK0TOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0TOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:14:53 -0500
X-Greylist: delayed 869 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 11:14:52 PST
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8ADC741;
        Sun, 27 Nov 2022 11:14:52 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 100F81C0049;
        Sun, 27 Nov 2022 20:14:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id E780C1C0048;
        Sun, 27 Nov 2022 20:14:50 +0100 (CET)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH 1/4] drm/mipi-dbi: Support separate I/O regulator
Date:   Sun, 27 Nov 2022 20:14:30 +0100
Message-Id: <20221127191433.1363395-2-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DBI specification defines separate vdd (panel power) and
vddi (I/O voltage) supplies. Displays that require different voltages
for the different supplies do exist, so the supplies cannot be
combined into one as they are now. Add a new io_regulator property to
the mipi_dbi_dev struct which can be set by the panel driver along
with the regulator property.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 14 ++++++++++++++
 include/drm/drm_mipi_dbi.h     |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index a6ac56580876..047cab93a041 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -427,6 +427,8 @@ void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe)
 
 	if (dbidev->regulator)
 		regulator_disable(dbidev->regulator);
+	if (dbidev->io_regulator)
+		regulator_disable(dbidev->io_regulator);
 }
 EXPORT_SYMBOL(mipi_dbi_pipe_disable);
 
@@ -652,6 +654,16 @@ static int mipi_dbi_poweron_reset_conditional(struct mipi_dbi_dev *dbidev, bool
 		}
 	}
 
+	if (dbidev->io_regulator) {
+		ret = regulator_enable(dbidev->io_regulator);
+		if (ret) {
+			DRM_DEV_ERROR(dev, "Failed to enable I/O regulator (%d)\n", ret);
+			if (dbidev->regulator)
+				regulator_disable(dbidev->regulator);
+			return ret;
+		}
+	}
+
 	if (cond && mipi_dbi_display_is_on(dbi))
 		return 1;
 
@@ -661,6 +673,8 @@ static int mipi_dbi_poweron_reset_conditional(struct mipi_dbi_dev *dbidev, bool
 		DRM_DEV_ERROR(dev, "Failed to send reset command (%d)\n", ret);
 		if (dbidev->regulator)
 			regulator_disable(dbidev->regulator);
+		if (dbidev->io_regulator)
+			regulator_disable(dbidev->io_regulator);
 		return ret;
 	}
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 14eaecb1825c..e4efbd8ffc9d 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -122,10 +122,15 @@ struct mipi_dbi_dev {
 	struct backlight_device *backlight;
 
 	/**
-	 * @regulator: power regulator (optional)
+	 * @regulator: power regulator (Vdd) (optional)
 	 */
 	struct regulator *regulator;
 
+	/**
+	 * @io_regulator: I/O power regulator (Vddi) (optional)
+	 */
+	struct regulator *io_regulator;
+
 	/**
 	 * @dbi: MIPI DBI interface
 	 */
-- 
2.30.2
