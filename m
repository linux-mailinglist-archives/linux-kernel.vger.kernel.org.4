Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F01B60B7B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiJXTbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiJXT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:29:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD4FFF8F;
        Mon, 24 Oct 2022 11:00:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-109.ewe-ip-backbone.de [91.96.59.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF4716602830;
        Mon, 24 Oct 2022 17:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666630556;
        bh=7HmGEeUycu9JUOAzQUWsfe2Icu5JIRazyOm+DZSY+30=;
        h=From:To:Cc:Subject:Date:From;
        b=jQ9R/puRhj5UJrIR+0rGBUm+ADPfk77O0r9TOrfMOfg+xjwVeaiMA2tf357DsmjVo
         b0yUD41zMqbrthlg4k/Lm6qrQxhdGxV3B0aHmbYFBCibv+FA/YyVfuq4361pZuSr6m
         4LYh0FZh+/xnmYmQSJ1OLGPXhM7JoxKpooFZQwrvaSJybjKIW88gHR6/WwgDmpSHBZ
         oIDeriLZQY6C2gN243+X+tIr8Z2qrjwlNX3JXwQ5I7eAkSravupCKl2/h0fcGSikfD
         VD7JUwx+wYIEn3oY2p2couV6ch6MRVIVNindJYWRoURfSzailfPhjvxQCcGxh8BzCZ
         Kagmzz5+sU2GA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id EE5C8480AEC; Mon, 24 Oct 2022 18:55:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 0/6] Convert HYM8563 RTC binding to YAML
Date:   Mon, 24 Oct 2022 18:55:43 +0200
Message-Id: <20221024165549.74574-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This converts HYM8563 binding to YAML and fixes
the existing DTs.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20221021170605.85163-1-sebastian.reichel@collabora.com/
 * Added patches fixing the existing devicetrees (Rob Herring)
 * Dual licensed the binding (Krzysztof Kozlowski)
 * Added maxItems for clock-output-names (Krzysztof Kozlowski)

-- Sebastian

Sebastian Reichel (6):
  arm64: dts: rockchip: fix node name for hym8563 rtc
  arm64: dts: rockchip: remove clock-frequency from rtc
  arm: dts: rockchip: fix node name for hym8563 rtc
  arm: dts: rockchip: remove clock-frequency from rtc
  arm64: dts: meson: remove clock-frequency from rtc
  dt-bindings: rtc: convert hym8563 bindings to json-schema

 .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
 .../bindings/rtc/haoyu,hym8563.yaml           | 56 +++++++++++++++++++
 arch/arm/boot/dts/rk3036-evb.dts              |  3 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts      |  2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi         |  3 +-
 arch/arm/boot/dts/rk3288-miqi.dts             |  3 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts     |  3 +-
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi       |  1 -
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |  1 -
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     |  1 -
 .../dts/amlogic/meson-gxm-minix-neo-u9h.dts   |  1 -
 .../dts/rockchip/rk3368-orion-r68-meta.dts    |  3 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  3 +-
 .../boot/dts/rockchip/rk3399-roc-pc-plus.dts  |  3 +-
 .../dts/rockchip/rk3399pro-vmarc-som.dtsi     |  3 +-
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   |  1 -
 .../boot/dts/rockchip/rk3568-rock-3a.dts      |  1 -
 17 files changed, 65 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml

-- 
2.35.1

