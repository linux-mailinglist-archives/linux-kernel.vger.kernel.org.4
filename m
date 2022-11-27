Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76E639C82
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiK0TQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0TQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:16:54 -0500
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC69D2CF;
        Sun, 27 Nov 2022 11:16:53 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 5E5981C004C;
        Sun, 27 Nov 2022 20:16:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id 4A9271C004B;
        Sun, 27 Nov 2022 20:16:52 +0100 (CET)
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
Subject: [PATCH 2/4] drm/tiny: panel-mipi-dbi: Read I/O supply from DT
Date:   Sun, 27 Nov 2022 20:14:31 +0100
Message-Id: <20221127191433.1363395-3-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221127191433.1363395-2-otto.pflueger@abscue.de>
References: <20221127191433.1363395-2-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support platforms with a separate I/O voltage supply, set the new
io_regulator property along with the regulator property of the DBI
device. Read the I/O supply from a new "io-supply" device tree
property.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 955a61d628e7..353356ee0397 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -297,6 +297,11 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(dbidev->regulator),
 				     "Failed to get regulator 'power'\n");
 
+	dbidev->io_regulator = devm_regulator_get(dev, "io");
+	if (IS_ERR(dbidev->io_regulator))
+		return dev_err_probe(dev, PTR_ERR(dbidev->io_regulator),
+				     "Failed to get regulator 'io'\n");
+
 	dbidev->backlight = devm_of_find_backlight(dev);
 	if (IS_ERR(dbidev->backlight))
 		return dev_err_probe(dev, PTR_ERR(dbidev->backlight), "Failed to get backlight\n");
-- 
2.30.2
