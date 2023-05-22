Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17C070C466
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjEVRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbjEVRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:34:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B0109;
        Mon, 22 May 2023 10:34:33 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A51266058F2;
        Mon, 22 May 2023 18:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684776871;
        bh=2crkjF5hGrNF5+uW+vKBwvLEXML84W1Sv3l++t7Q9ZA=;
        h=From:To:Cc:Subject:Date:From;
        b=FredDntETk0AslrVHCX+RH6xREF10lt453u7qYeN4hyQLhYZJw4JMZx0VVkHzdndQ
         OnrnnyGJu1TFLUTjoYP7nmih2gIzpkZodMYwAaXkEZMpUtwwzKvlmWqglhxh7Rv65J
         zsXEHrvGl6U3+a/kGpoRjn3Jdgd1rbPAcm28WzKHsx7xzUitbnWmSkmf+1FR2YH9VF
         ZysJ7OrbLg1Tvnji5swHCthwiKBHYH6ovufwOqbHu0AmUbyALT+IawhGawIUk6Q1s5
         xPfkNs1fTgk31iaSpbJyErXTFQxtOgzv8Qk6gBqOlrm5KQeueqCb0DdOWEmPa58e1H
         XBeDgviuGmdlg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8950E4805CC; Mon, 22 May 2023 19:34:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 0/6] Add RK3588 SATA support
Date:   Mon, 22 May 2023 19:34:17 +0200
Message-Id: <20230522173423.64691-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This enables SATA support for RK3588.

Changes since PATCHv1:
 * https://lore.kernel.org/all/20230413182345.92557-1-sebastian.reichel@collabora.com/
 * Rebase to v6.4-rc1
 * Collect Acked-by for syscon DT binding update
 * Use ASIC clock description suggested by Serge Semin
 * Also add RBC clock (not used by RK3588)
 * Add extra patch narrowing down the allowed clocks for RK356x and RK3588

-- Sebastian

Sebastian Reichel (6):
  dt-bindings: soc: rockchip: add rk3588 pipe-phy syscon
  dt-bindings: ata: ahci: add RK3588 AHCI controller
  dt-bindings: ata: ahci: dwc: enforce rockchip clocks
  dt-bindings: phy: rockchip: rk3588 has two reset lines
  arm64: dts: rockchip: rk3588: add combo PHYs
  arm64: dts: rockchip: rk3588: add SATA support

 .../bindings/ata/snps,dwc-ahci-common.yaml    |  8 +-
 .../bindings/ata/snps,dwc-ahci.yaml           | 40 +++++++--
 .../phy/phy-rockchip-naneng-combphy.yaml      |  8 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 44 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 90 +++++++++++++++++++
 6 files changed, 183 insertions(+), 8 deletions(-)

-- 
2.39.2

