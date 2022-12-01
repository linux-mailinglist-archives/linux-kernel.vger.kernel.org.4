Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BC63F4D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiLAQHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiLAQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:07:29 -0500
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E840CB68D1;
        Thu,  1 Dec 2022 08:06:49 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 8F9CA1C004C;
        Thu,  1 Dec 2022 17:06:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id 7FFB21C004B;
        Thu,  1 Dec 2022 17:06:48 +0100 (CET)
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
Subject: [PATCH v2 2/3] drm/tiny: panel-mipi-dbi: Read I/O supply from DT
Date:   Thu,  1 Dec 2022 17:02:44 +0100
Message-Id: <20221201160245.2093816-3-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201160245.2093816-1-otto.pflueger@abscue.de>
References: <20221201160245.2093816-1-otto.pflueger@abscue.de>
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
