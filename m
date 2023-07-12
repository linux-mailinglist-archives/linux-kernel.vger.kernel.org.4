Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1212A74FD22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGLCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:40:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9838F171F;
        Tue, 11 Jul 2023 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689129637; x=1720665637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQ+Ty7QCLmzuZeUmH8ApBFkuw242Jg4ATJz0g4JujM4=;
  b=PxYa3W/h5aTszJNsssfun5tqtwJ9e4qJe6tdLeupDgEwfqJwC0hrUveJ
   +1Eoljn1LNvykmhCrPlEba+b6zQM/JF1jhwV0RWSnjZcOtoyp615qZD42
   Kl4hNkr5/dQ/L4P+K/+1NEwFSL9UIXAawJWm1ajwznX/5h7ZVGvywXhsO
   3ZnXCtGmmAF87pWiW3MCrm+dAFfoyFxt8lazykIIc2eOSYxAZJZ2PhPv7
   5q38mE7FlV+A4IuvJStNj68mGL9P0rwe7R3Pqn9pBvN+EYbSR1mThyxtG
   vcw7F1LUtO8RCnQq0UxttWZtqgjGwRQm85Sy4kcO1ME0GDP1W8bH0z8aO
   w==;
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="234987599"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2023 19:40:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Jul 2023 19:40:36 -0700
Received: from che-lt-i67131.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 11 Jul 2023 19:40:27 -0700
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
        Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v2 0/9] Add support for XLCDC to sam9x7 SoC family.
Date:   Wed, 12 Jul 2023 08:10:08 +0530
Message-ID: <20230712024017.218921-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to add support for XLCDC IP of sam9x7 SoC family
to the DRM subsystem.XLCDC IP has additional registers and new
configuration bits compared to the existing register set of HLCDC IP.
The new compatible string "microchip,sam9x75-xlcdc" is defined for sam9x75
variant of the sam9x7 SoC family.The is_xlcdc flag under driver data helps
to differentiate the XLCDC and existing HLCDC code within the same driver.

changes in v2:
* Change the driver compatible name from "microchip,sam9x7-xlcdc" to
"microchip,sam9x75-xlcdc".
* Move is_xlcdc flag to driver data.
* Remove unsed Macro definitions.
* Add co-developed-bys tags
* Replace regmap_read() with regmap_read_poll_timeout() call
* Split code into two helpers for code readablitity.

Durai Manickam KR (1):
  drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC specific registers

Manikandan Muralidharan (8):
  dt-bindings: mfd: Add bindings for SAM9X75 LCD controller
  mfd: atmel-hlcdc: Add compatible for sam9x75 XLCD controller
  drm: atmel-hlcdc: add flag to differentiate XLCDC and HLCDC IP
  drm: atmel-hlcdc: add LCD controller layer definition for sam9x75
  drm: atmel_hlcdc: Add support for XLCDC in atmel LCD driver
  drm: atmel-hlcdc: add DPI mode support for XLCDC
  drm: atmel-hlcdc: add vertical and horizontal scaling support for
    XLCDC
  drm: atmel-hlcdc: add support for DSI output formats

 .../devicetree/bindings/mfd/atmel-hlcdc.txt   |   1 +
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 171 +++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  99 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h  |  48 +++
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 357 +++++++++++++++---
 drivers/mfd/atmel-hlcdc.c                     |   1 +
 include/linux/mfd/atmel-hlcdc.h               |  10 +
 7 files changed, 596 insertions(+), 91 deletions(-)

-- 
2.25.1

