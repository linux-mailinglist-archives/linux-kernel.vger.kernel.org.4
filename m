Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9172FEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbjFNMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbjFNMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:33:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B862AC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:33:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg8-00017G-2F; Wed, 14 Jun 2023 14:32:48 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg6-007LpO-DZ; Wed, 14 Jun 2023 14:32:46 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q9Pg5-00HUJe-Iv; Wed, 14 Jun 2023 14:32:45 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: display: panel: mipi-dbi-spi: add shineworld lh133k compatible
Date:   Wed, 14 Jun 2023 14:32:16 +0200
Message-Id: <20230614123222.4167460-3-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shineworld LH133K is a 1.3" 240x240px RGB LCD with a MIPI DBI
compatible SPI interface.
The initialization procedure is quite basic with the exception of
requiring inverted colors.
A basic mipi-dbi-cmd[1] script to get the display running thus looks
like this:

    $ cat shineworld,lh133k.txt
    command 0x11 # exit sleep mode
    delay 120

    # The display seems to require display color inversion, so enable it.
    command 0x21 # INVON

    # Enable normal display mode (in contrast to partial display mode).
    command 0x13 # NORON
    command 0x29 # MIPI_DCS_SET_DISPLAY_ON

    $ mipi-dbi-cmd shineworld,lh133k.bin shineworld,lh133k.txt

[1]: https://github.com/notro/panel-mipi-dbi

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index 9b701df5e9d28..c07da1a9e6288 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -67,6 +67,7 @@ properties:
     items:
       - enum:
           - sainsmart18
+          - shineworld,lh133k
       - const: panel-mipi-dbi-spi
 
   write-only:
-- 
2.39.2

