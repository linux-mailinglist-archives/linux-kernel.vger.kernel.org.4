Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA672DA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjFMHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbjFMHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:05:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107810F9;
        Tue, 13 Jun 2023 00:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686639897; x=1718175897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2AtW6y3EN8O+q/fnZWh+rQwVGxKOSUVLNaK9VlQDLHg=;
  b=kSwpxEXu/LxluCk0Nws7fDAtOsvy5vsbQ/TW0/tZzsflN1GD0NLLNrAR
   r+kQN+m5pGFkpW5d7lfHKphJ7TAzbgqz7p5cHnvtJs4Fgv5nXdmFBBnbM
   XdP9hZVdkdmmoZuQ/7oURboFbKaECyWn5urC00q9CvzpK8e2xMTlAFsP6
   YK/LKznNnat+S+LnJgLte32uIDaXFrVxYIpk2BuJyTyo6RqHs8nSAFdaz
   D/UT7jwiKYLUVeWL7ssipFJrpsfqKt2pKD5g1NqKkAR/bYxmwKUY2Bazv
   ZXmD5cC0xode2Fix1zyeiLUaYFSRQHkQg6m62EL6sW+pw/Qi3VV7BXByP
   w==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="215783313"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:04:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:04:55 -0700
Received: from che-lt-i67131.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:04:47 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan <manikandan.m@microchip.com>
Subject: [PATCH 0/9] Add support for XLCDC to sam9x7 SoC family.
Date:   Tue, 13 Jun 2023 12:34:17 +0530
Message-ID: <20230613070426.467389-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikandan <manikandan.m@microchip.com>

This patch series aims to add support for XLCDC IP of sam9x7 SoC family
to the DRM subsystem.XLCDC IP has additional registers and new
configuration bits compared to the existing register set of HLCDC IP.
The compatible string "microchip,sam9x7-xlcdc", defined for sam9x7 SoC
family helps to differentiate the XLCDC and existing HLCDC code
within the same driver.

Durai Manickam KR (2):
  drm: atmel-hlcdc: Define SAM9X7 XLCDC specific registers
  drm: atmel-hlcdc: add compatible string check for XLCDC and HLCDC

Manikandan Muralidharan (7):
  dt-bindings: mfd: Add bindings for SAM9X7 LCD controller
  mfd: atmel-hlcdc: Add compatible for SAM9X7 HLCD controller
  drm: atmel-hlcdc: add LCD controller layer definition for SAM9X7
  drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats

 .../devicetree/bindings/mfd/atmel-hlcdc.txt   |   1 +
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 167 ++++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 105 ++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  | 113 +++++++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 315 ++++++++++++++----
 drivers/mfd/atmel-hlcdc.c                     |   1 +
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 7 files changed, 609 insertions(+), 103 deletions(-)

-- 
2.25.1

