Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37B649FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiLLNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLLNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:16:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF088C13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:16:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 721DAB80D3B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF5CC433F0;
        Mon, 12 Dec 2022 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670850965;
        bh=ofS8xrEi/A4TW0gnM9hNihNDdwnhZuk+ZHdsBGx8xzs=;
        h=From:To:Cc:Subject:Date:From;
        b=Usd7cHjV3LjMpIeSL0SsPtQbspEGDfvhIO0QAPPK0roKIdRLj6sJQVHOWExiIt3kP
         M8khPc3gnj54azEKy1NiOZTOPeR7utUmldPb26aKVxi4qp2Wz44KCgFawGN8FOs8Sq
         KBWcNULM3pxWhmZ6kN68xM+3/RYItynJ3/pctsHhKCHtXlG5puR/gFefDN50DhRDh9
         JZ1J7rRvGvgdt454PF/vihw1080PqPgEvvcTszA6wVf9yeoWRYIEVmaNcRlDaTRPjj
         mXc543cIwHys7PWA5cY0YLAElwBntzdsifeVP3EWlF5nOVOe+CklNjMzU9RBNfyZmy
         uD3BIiQ7UIllw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.2
Date:   Mon, 12 Dec 2022 13:15:53 +0000
Message-Id: <20221212131604.BBF5CC433F0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.2

for you to fetch changes up to 8f3cbcd6b440032ebc7f7d48a1689dcc70a4eb98:

  regulator: core: Use different devices for resource allocation and DT lookup (2022-12-08 13:02:37 +0000)

----------------------------------------------------------------
regulator: Updates for v6.2

Quite a quiet release for regulator, the diffstat is dominated by the
I2C migration to probe_new() and the newly added MT6357 driver.  We've
just one framework addition and the rest is all new device support,
fixes and cleanups.

The framework addition is an API for requesting all regulators defined
in DT, this isn't great practice but has reasonable applications when
there is generic code handling devices on buses where the bus
specification doesn't include power.  The immediate application is MDIO
but I believe there's others, it's another API that'll need an eye
keeping on it for undesirable usage.

 - An API for requesting all regulators defined in DT.
 - Conversion of lots of drivers to the I2C probe_new() API.
 - Support for Mediatek MT6357, Qualcomm PM8550, PMR735a and
   Richtek RT6190.

There's a cross tree merge with the I2C tree in order to use the new
i2c_client_get_device_id() helper in the conversions to probe_new().

----------------------------------------------------------------
Abel Vesa (2):
      regulator: dt-bindings: qcom,rpmh: Add compatible for PM8550
      regulator: qcom-rpmh: Add support for PM8550 regulators

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

ChiYuan Huang (3):
      regulator: Add bindings for Richtek RT6190 regulator
      regulator: rt6190: Add support for Richtek RT6190 regulator
      regulator: core: Use different devices for resource allocation and DT lookup

Corentin Labbe (1):
      regulator: Add of_regulator_bulk_get_all

Fabien Parent (2):
      regulator: dt-bindings: Add binding schema for mt6357 regulators
      regulator: add mt6357 regulator

Jean Delvare (1):
      regulator: Drop obsolete dependencies on COMPILE_TEST

Johan Hovold (1):
      regulator: dt-bindings: qcom,rpmh: clean up example indentation

Konrad Dybcio (4):
      regulator: qcom_smd: Add PMR735a regulators
      regulator: qcom,smd: Document PMR735a
      regulator: qcom_smd: Fix PMR735a S3 regulator spec
      regulator: qcom-rpmh: Fix PMR735a S3 regulator spec

Mark Brown (8):
      Add support for Richtek RT6190 36V 4-wwtich regulator
      regulator: Add DT support for regulator-output connectors
      regulator: Add of_regulator_bulk_get_all()
      Merge branch 'i2c/client_device_id_helper-immutable' of https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux into regulator-6.2
      regulator: ROHM BDxxxxx minor print improvements
      regulator: qcom-rpmh: Add support for PM8550
      Merge tag 'v6.1-rc4' into regulator-6.2
      Add MediaTek MT6357 PMIC support

Matti Vaittinen (4):
      lib/test_linear_ranges: Use LINEAR_RANGE()
      regulator: bd718x7: Drop unnecessary info print
      regulator: bd71815: bd71828: bd9576: Use dev_err_probe()
      regulator: bd718x7: Use dev_err_probe()

Peng Wu (1):
      regulator: of: fix a NULL vs IS_ERR() check in of_regulator_bulk_get_all()

Richard Fitzgerald (2):
      regulator: arizona-micsupp: Don't hardcode use of ARIZONA defines
      regulator: arizona-micsupp: Don't use a common regulator name

Rob Herring (1):
      dt-bindings: Add missing 'unevaluatedProperties' to regulator nodes

Rui Zhang (1):
      regulator: core: fix use_count leakage when handling boot-on

Sebastian Reichel (2):
      regulator: rk808: reduce 'struct rk808' usage
      regulator: rk808: Use dev_err_probe

Uwe Kleine-König (22):
      regulator: da9121-regulator: Convert to i2c's .probe_new()
      regulator: lp3972: Convert to i2c's .probe_new()
      regulator: lp8755: Convert to i2c's .probe_new()
      regulator: max1586: Convert to i2c's .probe_new()
      regulator: max8649: Convert to i2c's .probe_new()
      regulator: max8952: Convert to i2c's .probe_new()
      regulator: pca9450-regulator: Convert to i2c's .probe_new()
      regulator: rpi-panel-attiny-regulator: Convert to i2c's .probe_new()
      regulator: tps51632-regulator: Convert to i2c's .probe_new()
      regulator: tps6286x-regulator: Convert to i2c's .probe_new()
      regulator: ad5398: Convert to i2c's .probe_new()
      regulator: lp872x: Convert to i2c's .probe_new()
      regulator: ltc3589: Convert to i2c's .probe_new()
      regulator: max8660: Convert to i2c's .probe_new()
      regulator: max8973-regulator: Convert to i2c's .probe_new()
      regulator: tps62360-regulator: Convert to i2c's .probe_new()
      regulator: tps65023-regulator: Convert to i2c's .probe_new()
      regulator: act8865-regulator: Convert to i2c's .probe_new()
      regulator: fan53555: Convert to i2c's .probe_new()
      regulator: isl6271a-regulator: Convert to i2c's .probe_new()
      regulator: pfuze100-regulator: Convert to i2c's .probe_new()
      regulator: pv88080-regulator: Convert to i2c's .probe_new()

Wang ShaoBo (1):
      regulator: core: use kfree_const() to free space conditionally

Yang Yingliang (4):
      regulator: docs: add missing helper
      regulator: core: fix unbalanced of node refcount in regulator_dev_lookup()
      regulator: core: fix module refcount leak in set_supply()
      regulator: core: fix resource leak in regulator_register()

Yuan Can (1):
      regulator: qcom-labibb: Fix missing of_node_put() in qcom_labibb_regulator_probe()

Zev Weiss (3):
      regulator: devres: Add devm_regulator_bulk_get_exclusive()
      regulator: Add regulator-output binding
      regulator: userspace-consumer: Handle regulator-output DT nodes

 .../devicetree/bindings/mfd/max77650.yaml          |   2 -
 .../devicetree/bindings/mfd/mediatek,mt6360.yaml   |   9 -
 .../bindings/power/supply/mt6360_charger.yaml      |   2 +-
 .../bindings/regulator/max77650-regulator.yaml     |   1 +
 .../devicetree/bindings/regulator/max8660.yaml     |   6 +-
 .../regulator/mediatek,mt6357-regulator.yaml       | 294 ++++++++++++
 .../bindings/regulator/mt6360-regulator.yaml       |  12 +-
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  36 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |   3 +
 .../bindings/regulator/regulator-output.yaml       |  39 ++
 .../bindings/regulator/richtek,rt6190.yaml         |  79 ++++
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 drivers/i2c/i2c-core-base.c                        |  14 +
 .../platform/x86/intel/int3472/clk_and_regulator.c |   3 +-
 drivers/regulator/Kconfig                          |  30 +-
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/act8865-regulator.c              |   6 +-
 drivers/regulator/ad5398.c                         |   6 +-
 drivers/regulator/arizona-micsupp.c                |  20 +-
 drivers/regulator/bd71815-regulator.c              |  10 +-
 drivers/regulator/bd71828-regulator.c              |  21 +-
 drivers/regulator/bd718x7-regulator.c              |  53 +--
 drivers/regulator/bd9576-regulator.c               |  54 ++-
 drivers/regulator/core.c                           |  63 ++-
 drivers/regulator/da9121-regulator.c               |   5 +-
 drivers/regulator/devres.c                         |  68 ++-
 drivers/regulator/fan53555.c                       |   6 +-
 drivers/regulator/fan53880.c                       |  16 +-
 drivers/regulator/internal.h                       |   2 +
 drivers/regulator/isl6271a-regulator.c             |   6 +-
 drivers/regulator/lp3972.c                         |   5 +-
 drivers/regulator/lp872x.c                         |   5 +-
 drivers/regulator/lp8755.c                         |   5 +-
 drivers/regulator/ltc3589.c                        |   6 +-
 drivers/regulator/max1586.c                        |   5 +-
 drivers/regulator/max8649.c                        |   5 +-
 drivers/regulator/max8660.c                        |   6 +-
 drivers/regulator/max8952.c                        |   5 +-
 drivers/regulator/max8973-regulator.c              |   6 +-
 drivers/regulator/mp886x.c                         |   2 +-
 drivers/regulator/mt6357-regulator.c               | 453 +++++++++++++++++++
 drivers/regulator/of_regulator.c                   |  94 +++-
 drivers/regulator/pca9450-regulator.c              |   5 +-
 drivers/regulator/pfuze100-regulator.c             |   6 +-
 drivers/regulator/pv88080-regulator.c              |   6 +-
 drivers/regulator/qcom-labibb-regulator.c          |   1 +
 drivers/regulator/qcom-rpmh-regulator.c            |  83 +++-
 drivers/regulator/qcom_smd-regulator.c             |  33 ++
 drivers/regulator/rk808-regulator.c                |  26 +-
 drivers/regulator/rpi-panel-attiny-regulator.c     |   5 +-
 drivers/regulator/rt6190-regulator.c               | 495 +++++++++++++++++++++
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/regulator/sy8106a-regulator.c              |   4 +-
 drivers/regulator/sy8824x.c                        |   2 +-
 drivers/regulator/sy8827n.c                        |   4 +-
 drivers/regulator/tps51632-regulator.c             |   5 +-
 drivers/regulator/tps62360-regulator.c             |   6 +-
 drivers/regulator/tps6286x-regulator.c             |   5 +-
 drivers/regulator/tps65023-regulator.c             |   6 +-
 drivers/regulator/userspace-consumer.c             |  60 ++-
 include/linux/i2c.h                                |   1 +
 include/linux/regulator/consumer.h                 |  10 +
 include/linux/regulator/driver.h                   |   3 +-
 include/linux/regulator/mt6357-regulator.h         |  51 +++
 include/linux/regulator/userspace-consumer.h       |   1 +
 include/linux/soc/qcom/smd-rpm.h                   |   2 +
 lib/test_linear_ranges.c                           |  13 +-
 67 files changed, 2013 insertions(+), 288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6357-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
 create mode 100644 drivers/regulator/mt6357-regulator.c
 create mode 100644 drivers/regulator/rt6190-regulator.c
 create mode 100644 include/linux/regulator/mt6357-regulator.h
