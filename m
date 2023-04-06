Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CED6DA1AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjDFTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDFTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:42:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583AC94;
        Thu,  6 Apr 2023 12:42:05 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CF0966031C6;
        Thu,  6 Apr 2023 20:42:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680810123;
        bh=yXXWajJ4GPqM5jvTaguIrcB7ajP3dLstwHJTYguFBkU=;
        h=From:To:Cc:Subject:Date:From;
        b=Rb3Mr9yUPJ/ymU8Agor3jSMm6xDEJK2be+Tf80RQT/jyYbUo2AnwO43/BsKN8Cuon
         tsbtk5X+2uIrE60/lz4hLHicrbdMlM+X2fA/FaAITAXQhw6Ne5tR1WFo2YecZSTwvA
         fCNyl9xLI0VMrz6UlOgxQW9hpWpQoU5O6zc35qzZqbVskJhsbGsZJixv1XcDZuQFcy
         SBIOoD2/XcslgOWpybTIzKdp42u6lM3dq9pW74n8Swb0XllibOwNbki8UwaDLamRd6
         SFZZBymVK7JWMhtV/QlqpAHNanhuEOliM2GWaMmVhIYm/DKcTwomF+lA+JvjEfuy+B
         MNDv/fZl1fSBQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 0/8] Add support for Rockchip RK860X regulators
Date:   Thu,  6 Apr 2023 22:41:50 +0300
Message-Id: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces support for the Rockchip RK860X regulators, 
while also providing a few fixes and improvements to the existing fan53555 
driver.

RK8600/RK8601 are quite similar to the FAN53555 regulators.

RK8602/RK8603 are a bit different, having a wider output voltage
selection range, from 0.5 V to 1.5 V in 6.25 mV steps. They are used 
in the Rock 5B board to power the ARM Cortex-A76 cores and the NPU.

Changes in v3:
 - Improved PATCH v2 1/8, as suggested by Krzysztof
 - Added Acked-by from Krzysztof in PATCH v3 1/8
 - v2: https://lore.kernel.org/lkml/20230406171806.948290-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Dropped the rk8601 and rk8603 entries from the device_id arrays 
   in PATCH 8/8 and updated the bindings accordingly in PATCH 1/8,
   per Krzysztof's review
 - v1: https://lore.kernel.org/lkml/20230405194721.821536-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (8):
  regulator: dt-bindings: fcs,fan53555: Add support for RK860X
  regulator: fan53555: Explicitly include bits header
  regulator: fan53555: Fix wrong TCS_SLEW_MASK
  regulator: fan53555: Remove unused *_SLEW_SHIFT definitions
  regulator: fan53555: Make use of the bit macros
  regulator: fan53555: Improve vsel_mask computation
  regulator: fan53555: Use dev_err_probe
  regulator: fan53555: Add support for RK860X

 .../bindings/regulator/fcs,fan53555.yaml      |  21 +-
 drivers/regulator/fan53555.c                  | 203 ++++++++++++++----
 2 files changed, 171 insertions(+), 53 deletions(-)

-- 
2.40.0

