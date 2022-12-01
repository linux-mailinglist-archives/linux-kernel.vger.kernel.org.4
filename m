Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9C63F4B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiLAQD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiLAQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:03:54 -0500
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32255B393D;
        Thu,  1 Dec 2022 08:03:53 -0800 (PST)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 4D22D1C0049;
        Thu,  1 Dec 2022 17:03:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
        by srv01.abscue.de (Postfix) with ESMTPSA id 367D91C0048;
        Thu,  1 Dec 2022 17:03:51 +0100 (CET)
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
Subject: [PATCH v2 0/3] drm/tiny: panel-mipi-dbi: Support separate I/O voltage supply
Date:   Thu,  1 Dec 2022 17:02:42 +0100
Message-Id: <20221201160245.2093816-1-otto.pflueger@abscue.de>
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

Changes in v2:
 - Don't list power-supply in the properties section of
   panel-mipi-dbi-spi.yaml because it is already in panel-common.yaml

Otto Pflüger (3):
  drm/mipi-dbi: Support separate I/O regulator
  drm/tiny: panel-mipi-dbi: Read I/O supply from DT
  dt-bindings: display: panel: mipi-dbi-spi: Add io-supply

 .../bindings/display/panel/panel-mipi-dbi-spi.yaml |  8 +++++++-
 drivers/gpu/drm/drm_mipi_dbi.c                     | 14 ++++++++++++++
 drivers/gpu/drm/tiny/panel-mipi-dbi.c              |  5 +++++
 include/drm/drm_mipi_dbi.h                         |  7 ++++++-
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
2.30.2
