Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E22639C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiK0TFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0TFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:05:37 -0500
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Nov 2022 11:05:34 PST
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973DBE087;
        Sun, 27 Nov 2022 11:05:34 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 9173E1C0049;
        Sun, 27 Nov 2022 20:00:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id 7B5731C0048;
        Sun, 27 Nov 2022 20:00:21 +0100 (CET)
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
Subject: [PATCH 0/4] drm/tiny: panel-mipi-dbi: Support separate I/O voltage supply
Date:   Sun, 27 Nov 2022 19:59:44 +0100
Message-Id: <20221127185948.1361083-1-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yml,
the MIPI DBI specification defines two power supplies, one for powering
the panel and one for the I/O voltage. The panel-mipi-dbi driver
currently only supports specifying a single "power-supply" in the
device tree.

Add support for a second power supply defined in a new "io-supply"
device tree property to make the driver properly configure the voltage
regulators on platforms where separate supplies are used.

(Resent from a new email address with proper formatting)

Otto Pflüger (4):
  drm/mipi-dbi: Support separate I/O regulator
  drm/tiny: panel-mipi-dbi: Read I/O supply from DT
  dt-bindings: display: panel: mipi-dbi-spi: Add missing power-supply
  dt-bindings: display: panel: mipi-dbi-spi: Add io-supply

 .../bindings/display/panel/panel-mipi-dbi-spi.yaml | 11 ++++++++++-
 drivers/gpu/drm/drm_mipi_dbi.c                     | 14 ++++++++++++++
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |  5 +++++
 include/drm/drm_mipi_dbi.h                         |  7 ++++++-
 4 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.30.2
