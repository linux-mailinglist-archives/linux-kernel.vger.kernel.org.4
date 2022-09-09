Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277215B3E57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiIIRzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIIRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:55:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CAA4B3E;
        Fri,  9 Sep 2022 10:55:30 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-168-128.ewe-ip-backbone.de [95.33.168.128])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3247E6601FC8;
        Fri,  9 Sep 2022 18:55:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662746129;
        bh=7TnVqnon4UAn7JB3xq9K4nrPV6Vo8oDa7oevNzXh83Y=;
        h=From:To:Cc:Subject:Date:From;
        b=okzH1X54k5Cj0ry+TEPFU2jUMNkfebG1Es7yKCtoHHro2gRNrQGKAjS9WVmwg11zf
         mh8DH+5lHc72ix0VK45M+RP0s/ox1Au4FK4B9GfW5jfzixUq4CNLl4qglNNBFR67Zr
         4uNTBJq1/Pa73GVy3VV1cgzCePwYNNXVckdHdPPYvBi3Az0TF3CG2vvgi8iSKZ1WUS
         Rv9Ups4C8tGLczWsgA9D0+O7Pz84lJCD9903E84Vb62QMhr/iD0722IlRF2mzE4S1F
         dpHeli8h6XlUVZCVAbGVp0TaakMaHhlob2KRU5UUKxoiqCCF3sBOHPZFbfyG6XB2Z6
         f9m+pS/1WH9NA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 122C7480165; Fri,  9 Sep 2022 19:55:27 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 00/14] Introduce RK806 Support
Date:   Fri,  9 Sep 2022 19:55:08 +0200
Message-Id: <20220909175522.179175-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
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

The Rockchip RK3588 Evaluation Boards use SPI connected RK806
PMICs. Downstream this is handled by a new driver, but apart
from being SPI connected this chip is quite similar to the
ther Rockchip PMICs (also RK806 is promoted to also support
I2C). Thus this series instead updates RK808.

Changelog since PATCHv2:
 * https://lore.kernel.org/all/20220908003107.220143-1-sebastian.reichel@collabora.com/
 * Change DT binding to not allow nldo-reg6
 * Fix DT binding to check for [np]ldo-reg instead of [np]ldo_reg
 * remove rk806_get_voltage_sel_regmap in favour of regulator_get_voltage_sel_regmap
 * drop rk806_set_voltage in favour of regulator_set_voltage_sel_regmap
 * use regulator_set_ramp_delay_regmap
 * drop possibly incorrect printing of chip id register address in case of errors

Changelog since PATCHv1:
 * https://lore.kernel.org/all/20220831215437.117880-1-sebastian.reichel@collabora.com/
 * Collect Acked-by
 * Avoid if/else checks for regulator id in rk806 regulator driver
 * Fix indentation in DTS example section of the rk806 binding
 * Use absolute path for regulator.yaml referencing in the rk806 binding
 * Reduce pattern for DCDC regulators to only allow 1-10
 * replace uppercase name with lowercase ones in regulator names
 * replace _ with - in regulator names

-- Sebastian

Sebastian Reichel (14):
  mfd: rk808: convert to device managed resources
  mfd: rk808: use dev_err_probe
  clk: RK808: reduce 'struct rk808' usage
  regulator: rk808: reduce 'struct rk808' usage
  rtc: rk808: reduce 'struct rk808' usage
  mfd: rk808: replace 'struct i2c_client' with 'struct device'
  mfd: rk808: split into core and i2c
  dt-bindings: mfd: add rk806 binding
  mfd: rk8xx: add rk806 support
  pinctrl: rk805: add rk806 pinctrl support
  regulator: rk808: Use dev_err_probe
  regulator: expose regmap_find_closest_bigger
  regulator: rk808: add rk806 support
  ASoC: rk817: Remove 'select REGMAP_I2C'

 .../bindings/mfd/rockchip,rk806.yaml          | 388 ++++++++++++++++
 drivers/clk/clk-rk808.c                       |  34 +-
 drivers/mfd/Kconfig                           |  19 +
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}         | 343 +++++---------
 drivers/mfd/rk8xx-i2c.c                       | 203 +++++++++
 drivers/mfd/rk8xx-spi.c                       | 128 ++++++
 drivers/pinctrl/pinctrl-rk805.c               | 189 +++++++-
 drivers/regulator/helpers.c                   |  20 +-
 drivers/regulator/rk808-regulator.c           | 410 ++++++++++++++++-
 drivers/rtc/rtc-rk808.c                       |  47 +-
 include/linux/mfd/rk808.h                     | 417 +++++++++++++++++-
 include/linux/regulator/driver.h              |   2 +
 sound/soc/codecs/Kconfig                      |   1 -
 14 files changed, 1895 insertions(+), 310 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c

-- 
2.35.1

