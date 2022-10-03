Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777315F306A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJCMrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJCMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:47:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F213D5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8357B81085
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC24C433C1;
        Mon,  3 Oct 2022 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664801217;
        bh=GOQxJhTtRu45EvdELau6ISOM6i38kGc8sd/y6homOYU=;
        h=From:To:Cc:Subject:Date:From;
        b=I1cXOUXca4Vv2u2ESM+EbgCwR/aFdqhLt6Z4e9RO7knk2eyLAGGqeiTImmzaYbuMK
         6jVldcMFfVbqIEdOYDYY2E6TzTxbcvrFAktQ487Ql7Ye9S9YKXC0ceadBsstytEje4
         gTWngCKL7JbnZKtAQY7DLzSxCcH0gK5H2qv0LifhnN5s9zpSGDpARJczBvLS5pGiGS
         sVpwGgmkrum4hCXaAJ3QB9sgkzXCKmij6G01/MR4K0mFlJGtV6871/aj2ScLNsv+Cg
         q96NKGzOrZmNVqyu8u4yy6STtH5mE/6hMXbJ4DvjqJSuTQGxmQa9QWZS6eBPba1fHX
         pXF+0eIlW3vcw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.1
Date:   Mon, 03 Oct 2022 13:46:45 +0100
Message-Id: <20221003124657.1AC24C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.1

for you to fetch changes up to 392cc0a4a0c4b25534f3148b192f18be468f67bd:

  dt-bindings: gpio-regulator: add vin-supply property support (2022-09-29 15:20:15 +0100)

----------------------------------------------------------------
regulator: Updates for v6.1

The core work this time around has mostly been around the code to manage
regulator modes, simplifying the interface for configuring modes to not
take account of the voltage and as a side effect resolving a
bootstrapping issue on systems where we can't read the voltage from the
regulator.  Otherwise it's been quite a quiet release with some new
drivers and a devm helper:

 - Make the load handling in the Qualcomm RPMH regulators much more
   idiomatic and general cleanups to the handling of load configuration.
 - devm helper for a combined get and enable operation.
 - Support for MediaTek MT6331, Qualcomm PM660, 660L and PM6125, Texas
   Instruments TPS65219.

----------------------------------------------------------------
Andrew Halaney (1):
      regulator: dt-bindings: qcom,rpmh: Indicate regulator-allow-set-load dependencies

AngeloGioacchino Del Regno (4):
      regulator: Add bindings for MT6331 regulator
      regulator: Add driver for MT6331 PMIC regulators
      regulator: Add bindings for MT6332 regulator
      regulator: Add driver for MT6332 PMIC regulators

Axel Lin (2):
      regulator: tps65219: Fix .bypass_val_on setting
      regulator: tps65219: Fix is_enabled checking in tps65219_set_bypass

Christian Kohlschütter (1):
      regulator: core: Remove "ramp_delay not set" debug message

Christian Kohlschütter (2):
      regulator: core: Resolve supply name earlier to prevent double-init
      regulator: core: Fix regulator supply registration with sysfs

Dmitry Torokhov (2):
      regulator: bd71815: switch to using devm_fwnode_gpiod_get()
      regulator: bd9576: switch to using devm_fwnode_gpiod_get()

Douglas Anderson (3):
      regulator: qcom-rpmh: Implement get_optimum_mode(), not set_load()
      regulator: core: Require regulator drivers to check uV for get_optimum_mode()
      regulator: core: Don't err if allow-set-load but no allowed-modes

Iskren Chernev (13):
      regulator: qcom_spmi: Improve formatting of if-then blocks
      regulator: qcom_spmi: Document PM6125 PMIC
      regulator: qcom_smd: Sort compatibles alphabetically
      regulator: qcom_smd: Document PM6125 PMIC
      regulator: qcom_spmi: Add support for HFSMPS regulator type
      regulator: qcom_spmi: Add support for LDO_510 and FTSMPS
      regulator: qcom_spmi: Sort pmics alphabetically (part 1)
      regulator: qcom_spmi: Sort pmics alphabetically (part 2)
      regulator: qcom_spmi: Add PM6125 PMIC support
      regulator: qcom_smd: Sort pmics alphabetically (part 1)
      regulator: qcom_smd: Sort pmics alphabetically (part 2)
      regulator: qcom_smd: Sort pmics alphabetically (part 3)
      regulator: qcom_smd: Add PM6125 RPM regulators

Jerome Neanne (4):
      regulator: dt-bindings: Add TI TPS65219 PMIC bindings
      regulator: drivers: Add TI TPS65219 PMIC regulators support
      regulator: gpio: Add input_supply support in gpio_regulator_config
      dt-bindings: gpio-regulator: add vin-supply property support

Jiapeng Chong (2):
      regulator: of: Fix kernel-doc
      regulator: of: Fix kernel-doc

Linus Walleij (1):
      regulator: qcom_rpm: Fix circular deferral regression

Mark Brown (6):
      Merge remote-tracking branch 'regulator/for-5.20' into regulator-6.0
      Devm helpers for regulator get and enable
      Use devm helpers for regulator get and enable
      Add support for TI TPS65219 PMIC.
      PM6125 regulator support
      MediaTek Helio X10 MT6795 - MT6331/6332 Regulators

Matti Vaittinen (3):
      regulator: Add missing devm_* functions to devres.rst
      regulator: Add devm helpers for get and enable
      docs: devres: regulator: Add new get_enable functions to devres.rst

Patrick Rudolph (1):
      regulator: core: Prevent integer underflow

Richard Acayan (2):
      regulator: qcom-rpmh: add pm660 and pm660l pmics
      regulator: qcom,rpmh: add pm660 and pm660l pmics

Rob Herring (1):
      regulator: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes

Yang Li (1):
      regulator: drivers: Remove unnecessary print function dev_err()

Yang Yingliang (1):
      regulator: tps65219: change tps65219_regulator_irq_types to static

ye xingchen (1):
      regulator: max597x: Remove the unneeded result variable

 .../devicetree/bindings/regulator/dlg,da9121.yaml  |   1 +
 .../bindings/regulator/gpio-regulator.yaml         |   3 +
 .../bindings/regulator/maxim,max77802.yaml         |   1 +
 .../bindings/regulator/maxim,max8997.yaml          |   1 +
 .../regulator/mediatek,mt6331-regulator.yaml       | 273 +++++++++++
 .../regulator/mediatek,mt6332-regulator.yaml       | 112 +++++
 .../bindings/regulator/mt6315-regulator.yaml       |   1 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  40 ++
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |  26 +-
 .../bindings/regulator/qcom,spmi-regulator.yaml    |  33 ++
 .../bindings/regulator/qcom-labibb-regulator.yaml  |  16 +
 .../regulator/richtek,rt4801-regulator.yaml        |   1 +
 .../bindings/regulator/rohm,bd71815-regulator.yaml |   1 +
 .../devicetree/bindings/regulator/ti,tps65219.yaml | 173 +++++++
 Documentation/driver-api/driver-model/devres.rst   |  11 +
 MAINTAINERS                                        |   1 +
 drivers/regulator/Kconfig                          |  27 ++
 drivers/regulator/Makefile                         |   3 +
 drivers/regulator/bd71815-regulator.c              |   7 +-
 drivers/regulator/bd9576-regulator.c               |  17 +-
 drivers/regulator/core.c                           |  98 ++--
 drivers/regulator/devres.c                         | 164 +++++++
 drivers/regulator/gpio-regulator.c                 |  15 +
 drivers/regulator/max597x-regulator.c              |   5 +-
 drivers/regulator/mt6331-regulator.c               | 507 +++++++++++++++++++++
 drivers/regulator/mt6332-regulator.c               | 422 +++++++++++++++++
 drivers/regulator/of_regulator.c                   |   2 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  71 ++-
 drivers/regulator/qcom_rpm-regulator.c             |  24 +-
 drivers/regulator/qcom_smd-regulator.c             | 400 +++++++++-------
 drivers/regulator/qcom_spmi-regulator.c            | 378 +++++++++++----
 drivers/regulator/ti-abb-regulator.c               |   2 +-
 drivers/regulator/tps65219-regulator.c             | 411 +++++++++++++++++
 include/linux/regulator/consumer.h                 |  27 ++
 include/linux/regulator/gpio-regulator.h           |   2 +
 include/linux/regulator/mt6331-regulator.h         |  46 ++
 include/linux/regulator/mt6332-regulator.h         |  27 ++
 37 files changed, 2991 insertions(+), 358 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
 create mode 100644 drivers/regulator/mt6331-regulator.c
 create mode 100644 drivers/regulator/mt6332-regulator.c
 create mode 100644 drivers/regulator/tps65219-regulator.c
 create mode 100644 include/linux/regulator/mt6331-regulator.h
 create mode 100644 include/linux/regulator/mt6332-regulator.h
