Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6833C69F3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBVMBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjBVMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:01:48 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6553538032
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:01:43 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c02eea4dso98654127b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8o3pJCIsbKHYK4QxN/c8k8ZbgMH244wreI3in8ggE10=;
        b=qCao9UvR3lJq5LEpNfBYNnBw+NE7SSDItGZkUXW/mt3K3vOLYFpVp41V0z4Ohf4M/q
         CKI6dF/A/xXkMzhKFIGUgdTO3rIFIHyVyHDiqVPqLbpi6hqZsoDf3NZbJCOtfBf1V750
         Eo27xZOx32TtfmTHkVC4G04Pqjir9oPDoAjNoGpeltChVKuKRwqrV8FPIDlcqkYyHV2K
         UG245cl2ghjCgVI/pDkUcDJSZHKfsZiYA7ELOVgy5PNlGOWYBXD6aUoxcmJSeCqnA60X
         nZFZCGHmovR9lHU/B0+86RETKmcuHsUGttMgpBQmGQnf0CzzFSkmzYfVx2lvpTbteSgE
         rGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o3pJCIsbKHYK4QxN/c8k8ZbgMH244wreI3in8ggE10=;
        b=Ae7zZ754mMJTIqHXliH7Y7AMIobliceQB79HuaDhu9B1uHNZTvsCiNlZmmQ02murHz
         khK+0Gjc1e9gWSZO3dt7J+BE73nvAEr7GY+9cQMgy8S68eYuB6/E71U4JEiPh9OnvanK
         Sk/xp8Ck1YFGaK+pdLdP5+KrBTBjs+Ez3m8Cygrnb8fK/Bt81mtL+PMsq2GWgSuqOyzR
         RzpC58z2prh5xTKPquYA6dGIgNbhn9qFqMFS1yb+IpNd+ZoEBBpphzY66SNitcMReawh
         iavS3fVp+1yOXIAPLvD6rLRaxIlVs+shhTxS6uQ47o4bC6BZ074XTsLiNnuJauUJrXyp
         qmhw==
X-Gm-Message-State: AO0yUKUIyuVX7hqTHBRM15I5mlyf9vRcXsTd/mdIveR379PjuqR8rgV0
        9sHQBSkNe6s7CWdM38SptsFyOmp/wZUJPUn3MFuBs7FEtBsRcrxr/H4=
X-Google-Smtp-Source: AK7set+I9yvUgsTMKP+Q14xXA0XgHXg6IMpqWXsxrBuhdaPynDdaQj0QgtdcOTyyi+OPQzCpfQzEvb2RGSYCwjyZt7o=
X-Received: by 2002:a81:ac5c:0:b0:533:9b80:a30e with SMTP id
 z28-20020a81ac5c000000b005339b80a30emr915933ywj.10.1677067302370; Wed, 22 Feb
 2023 04:01:42 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Feb 2023 13:01:31 +0100
Message-ID: <CACRpkdY_jnEF=qcrkqtZHQ7U=8CmY5Uaz61STHw0nYF_p6-PRg@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v6.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the big pull request for v6.3 pin control.

The details are in the signed tag as usual, nothing special,
notably a lot of new Qualcomm hardware is supported, a
RISC-V reference SoC and then some cleanups both in
code and device tree bindings.

I think at some point there was a small conflict in the
MAINTAINERS file, but I don't see it now.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2=
:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.3-1

for you to fetch changes up to 099f37a539e616f762241ab999495fb8aa2f5971:

  pinctrl: qcom: Add support for i2c specific pull feature (2023-02-10
23:47:07 +0100)

----------------------------------------------------------------
Core changes:

- Add PINCTRL_PINFUNCTION() macro and use it in several
  drivers.

New drivers:

- New driver for the StarFive JH7110 SoC "sys" and "aon"
  (always-on) pin controllers. (RISC-V.)

- New subdriver for the Qualcomm QDU1000/QRU1000 SoC pin
  controller.

- New subdrivers for the Qualcomm SM8550 SoC and LPASS
  pin controllers.

- New subdriver for the Qualcomm SA8775P SoC pin controller.

- New subdriver for the Qualcomm IPQ5332 SoC pin controller.

- New (trivial) support for Qualcomm PM8550 and PMR735D PMIC
  pin control.

- New subdriver for the Mediatek MT7981 SoC pin controller.

Improvements:

- Several cleanups and refactorings to the Intel drivers.

- Add 4KOhm bias support to the Intel driver.

- Use the NOIRQ_SYSTEM_SLEEP_PM_OPS for the AT91 driver.

- Support general purpose clocks in the Qualcomm MSM8226 SoC.

- Several conversions to use the new I2C .probe_new() call.

- Massive clean-up of the Qualcomm Device Tree YAML schemas.

- Add VIN[45] pins, groups and functions to the Renesas
  r8a77950 SoC driver.

----------------------------------------------------------------
Abel Vesa (3):
      dt-bindings: pinctrl: qcom: Add SM8550 pinctrl
      pinctrl: qcom: Add SM8550 pinctrl driver
      pinctrl: qcom: Add support for i2c specific pull feature

Adam Skladowski (1):
      pinctrl: qcom: pinctrl-msm8976: Correct function names for wcss pins

Andy Shevchenko (45):
      pinctrl: intel: Introduce INTEL_COMMUNITY_*() to unify community macr=
os
      pinctrl: alderlake: Replace ADL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: broxton: Replace BXT_COMMUNITY() by INTEL_COMMUNITY_SIZE()
      pinctrl: cannonlake: Replace CNL_COMMUNITY() by INTEL_COMMUNITY_GPPS(=
)
      pinctrl: cedarfork: Replace CDF_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: denverton: Replace DNV_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: elkhartlake: Replace EHL_COMMUNITY() by INTEL_COMMUNITY_GPPS=
()
      pinctrl: emmitsburg: Replace EBG_COMMUNITY() by INTEL_COMMUNITY_GPPS(=
)
      pinctrl: geminilake: Replace GLK_COMMUNITY() by INTEL_COMMUNITY_SIZE(=
)
      pinctrl: icelake: Replace ICL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: jasperlake: Replace JSL_COMMUNITY() by INTEL_COMMUNITY_GPPS(=
)
      pinctrl: lakefield: Replace LKF_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: lewisburg: Replace LBG_COMMUNITY() by INTEL_COMMUNITY_SIZE()
      pinctrl: meteorlake: Replace MTL_COMMUNITY() by INTEL_COMMUNITY_GPPS(=
)
      pinctrl: tigerlake: Replace TGL_COMMUNITY() by INTEL_COMMUNITY_GPPS()
      pinctrl: sunrisepoint: Replace SPT_COMMUNITY() by INTEL_COMMUNITY_*()
      pinctrl: intel: Always use gpp_num_padown_regs in the main driver
      pinctrl: intel: Convert to generic_handle_domain_irq()
      pinctrl: intel: Add default case to intel_config_set_pull()
      pinctrl: intel: Deduplicate some code in intel_config_set_pull()
      pinctrl: intel: Add definitions to all possible biases
      pinctrl: intel: Add ~4k bias support
      pinctrl: intel: Use same order of bit fields for PADCFG2
      pinctrl: intel: Define maximum pad number in the group
      pinctrl: Introduce struct pinfunction and PINCTRL_PINFUNCTION() macro
      pinctrl: intel: Make use of struct pinfunction and PINCTRL_PINFUNCTIO=
N()
      pinctrl: baytrail: Convert to use new memeber in struct intel_functio=
n
      pinctrl: cherryview: Convert to use new memeber in struct intel_funct=
ion
      pinctrl: lynxpoint: Convert to use new memeber in struct intel_functi=
on
      pinctrl: merrifield: Convert to use new memeber in struct intel_funct=
ion
      pinctrl: moorefield: Convert to use new memeber in struct intel_funct=
ion
      pinctrl: intel: Get rid of unused members in struct intel_function
      pinctrl: pinmux: Drop duplicate error message in pinmux_select()
      pinctrl: samsung: Do not mention legacy API in the code
      pinctrl: mediatek: Remove duplicate assignment of of_gpio_n_cells
      pinctrl: qcom: lpass-lpi: Remove duplicate assignment of of_gpio_n_ce=
lls
      pinctrl: sunplus: sppctl: Remove duplicate assignment of of_gpio_n_ce=
lls
      pinctrl: digicolor: Remove duplicate assignment of of_gpio_n_cells
      pinctrl: digicolor: Use proper headers and drop OF dependency
      pinctrl: Proofreading and updating the documentation accordingly
      gpiolib: Check "gpio-ranges" before calling ->add_pin_ranges()
      pinctrl: bcm2835: Remove of_node_put() in
bcm2835_of_gpio_ranges_fallback()
      pinctrl: bcm2835: Switch to use ->add_pin_ranges()
      Revert "gpiolib: of: Introduce hook for missing gpio-ranges"
      pinctrl: qcom: Unify accessing to device fwnode

Arnd Bergmann (1):
      pinctrl: at91: convert to NOIRQ_SYSTEM_SLEEP_PM_OPS

Ar=C4=B1n=C3=A7 =C3=9CNAL (6):
      pinctrl: ralink: rename variables which point out the pin group
      dt-bindings: pinctrl: mt7620: add proper function muxing binding
      dt-bindings: pinctrl: mt7621: add proper function muxing binding
      dt-bindings: pinctrl: rt2880: add proper function muxing binding
      dt-bindings: pinctrl: rt305x: add proper function muxing binding
      dt-bindings: pinctrl: rt3883: add proper function muxing binding

Bagas Sanjaya (1):
      pinctrl: Proofreading and updating the documentation (part 2)

Bartosz Golaszewski (1):
      dt-bindings: pinctrl: describe sa8775p-tlmm

Basavaraj Natikar (1):
      pinctrl: amd: Add Z-state wake control bits

Bernhard Rosenkr=C3=A4nzer (1):
      dt-bindings: pinctrl: add bindings for Mediatek MT8365 SoC

Biju Das (1):
      dt-bindings: pinctrl: renesas: Add RZ/G2L POEG binding

Claudiu Beznea (1):
      pinctrl: at91: use devm_kasprintf() to avoid potential leaks

Daniel Golle (2):
      dt-bindings: pinctrl: add bindings for MT7981 SoC
      pinctrl: add mt7981 pinctrl driver

Geert Uytterhoeven (2):
      pinctrl: renesas: r8a779g0: Fix alignment in GPSR[678]_* macros
      pinctrl: renesas: r8a77950: Add VIN[45] pins, groups, and functions

Guodong Liu (2):
      pinctrl: mediatek: Initialize variable pullen and pullup to zero
      pinctrl: mediatek: Initialize variable *buf to zero

Jianlong Huang (4):
      dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl
      dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
      pinctrl: starfive: Add StarFive JH7110 sys controller driver
      pinctrl: starfive: Add StarFive JH7110 aon controller driver

Johan Jonker (1):
      dt-bindings: pinctrl: rockchip,pinctrl: mark gpio sub nodes of
pinctrl as deprecated

Kathiravan T (2):
      dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
      pinctrl: qcom: Introduce IPQ5332 TLMM driver

Krzysztof Kozlowski (21):
      dt-bindings: pinctrl: qcom,sm8450-tlmm: correct gpio-line-names size
      dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: add input-enable
and bias-bus-hold
      dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO hogs
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: correct pins pattern
      dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: add input-enable
and bias-bus-hold
      dt-bindings: pinctrl: qcom,sm6350-tlmm: add gpio-line-names
      dt-bindings: pinctrl: qcom,sm8350-tlmm: add gpio-line-names
      dt-bindings: pinctrl: qcom,sm6350-tlmm: correct pins pattern
      dt-bindings: pinctrl: qcom,sm8350-tlmm: correct pins pattern
      dt-bindings: pinctrl: qcom: allow nine interrupts on SM6350
      dt-bindings: pinctrl: qcom,sm8350: add input-disable
      dt-bindings: pinctrl: qcom,msm8226: correct GPIO name pattern
      dt-bindings: pinctrl: qcom,msm8909: correct GPIO name pattern and exa=
mple
      dt-bindings: pinctrl: qcom,sm6375: correct GPIO name pattern and exam=
ple
      dt-bindings: pinctrl: qcom,msm8953: correct GPIO name pattern
      dt-bindings: pinctrl: qcom,sdx55: correct GPIO name pattern
      dt-bindings: pinctrl: qcom,msm8994: correct number of GPIOs
      dt-bindings: pinctrl: qcom: correct gpio-ranges in examples
      dt-bindings: pinctrl: qcom,sm8550-lpass-lpi-pinctrl: add SM8550 LPASS
      pinctrl: qcom: pinctrl-sm8550-lpass-lpi: add SM8550 LPASS
      dt-bindings: pinctrl: qcom: lpass-lpi: correct GPIO name pattern

Lad Prabhakar (2):
      pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
      pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks

Linus Walleij (5):
      pinctrl: at91: Tag suspend/resume __maybe_unused
      Merge tag 'qcom-pinctrl-6.3' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel
      Merge tag 'renesas-pinctrl-for-v6.3-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'intel-pinctrl-v6.3-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel
      Merge tag 'qcom-pinctrl-6.3-2' of
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into
devel

Luca Weiss (1):
      pinctrl: qcom: msm8226: Add General Purpose clocks

Lukas Bulwahn (1):
      pinctrl: mxs: avoid defines prefixed with CONFIG

Matti Lehtim=C3=A4ki (1):
      dt-bindings: pinctrl: msm8226: Add General Purpose clocks

Melody Olvera (2):
      dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000 pinctrl
      pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver

Miaoqian Lin (2):
      pinctrl: stm32: Fix refcount leak in stm32_pctrl_get_irq_domain
      pinctrl: rockchip: Fix refcount leak in rockchip_pinctrl_parse_groups

Neil Armstrong (2):
      dt-bindings: pinctrl: qcom,pmic-gpio: document pm8550, pm8550b,
pm8550ve, pm8550vs, pmk8550 & pmr735d
      pinctrl: qcom: spmi-gpio: add support for pm8550 & pmr735d gpio contr=
ol

Peng Fan (1):
      dt-bindings: pinctrl: imx8m: Integrate duplicated i.MX 8M schemas

Rob Herring (3):
      dt-bindings: pinctrl: qcom,pmic-mpp: Rename "mpp" child node
names to "-pins$"
      dt-bindings: pinctrl: mediatek: Fix child node name patterns
      pinctrl: at91: fix deferred probing support

Uwe Kleine-K=C3=B6nig (4):
      pinctrl: da850-pupd: Drop empty platform remove function
      pinctrl: thunderbay: Drop empty platform remove function
      pinctrl: mcp23s08: Convert to i2c's .probe_new()
      pinctrl: sx150x: Convert to i2c's .probe_new()

Yadu MG (1):
      pinctrl: qcom: add the tlmm driver sa8775p platforms

ye xingchen (1):
      pinctrl: nomadik: remove duplicate included header files

 ...,imx8mm-pinctrl.yaml =3D> fsl,imx8m-pinctrl.yaml} |   24 +-
 .../bindings/pinctrl/fsl,imx8mn-pinctrl.yaml       |   84 -
 .../bindings/pinctrl/fsl,imx8mp-pinctrl.yaml       |   84 -
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.yaml       |   84 -
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |   12 +-
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  |    8 +-
 .../bindings/pinctrl/mediatek,mt7981-pinctrl.yaml  |  475 ++++++
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |    8 +-
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  |  197 +++
 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml        |  134 ++
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml        |    4 +-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |   10 +-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |    8 +-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |    6 +-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     |   10 +-
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     |    4 +-
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |   18 +
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |    4 +-
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml        |    4 +-
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      |    4 +-
 .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml        |  134 ++
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml        |  138 ++
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      |    4 +-
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml        |    4 +-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |   10 +-
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |    4 +-
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      |    4 +-
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |    4 +-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      |   15 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |    6 +-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml          |    4 +-
 .../bindings/pinctrl/qcom,sm6115-tlmm.yaml         |    4 +-
 .../bindings/pinctrl/qcom,sm6125-tlmm.yaml         |    4 +-
 .../bindings/pinctrl/qcom,sm6350-tlmm.yaml         |   27 +-
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |    8 +-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      |    4 +-
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |    2 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |    6 +-
 .../bindings/pinctrl/qcom,sm8350-tlmm.yaml         |   18 +-
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |    8 +-
 .../bindings/pinctrl/qcom,sm8450-tlmm.yaml         |    6 +-
 .../pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     |  148 ++
 .../bindings/pinctrl/qcom,sm8550-tlmm.yaml         |  163 ++
 .../bindings/pinctrl/qcom,tlmm-common.yaml         |    5 +-
 .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml    |  633 ++++++-
 .../bindings/pinctrl/ralink,mt7621-pinctrl.yaml    |  205 ++-
 .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml    |   86 +-
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml    |  236 ++-
 .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml    |  205 ++-
 .../bindings/pinctrl/renesas,rzg2l-poeg.yaml       |   86 +
 .../bindings/pinctrl/rockchip,pinctrl.yaml         |    4 +-
 .../pinctrl/starfive,jh7110-aon-pinctrl.yaml       |  124 ++
 .../pinctrl/starfive,jh7110-sys-pinctrl.yaml       |  142 ++
 Documentation/driver-api/pin-control.rst           |  498 +++---
 MAINTAINERS                                        |    8 +-
 drivers/gpio/gpiolib-of.c                          |    5 -
 drivers/gpio/gpiolib.c                             |    8 +
 drivers/pinctrl/Kconfig                            |    2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   10 +-
 drivers/pinctrl/freescale/pinctrl-mxs.c            |    6 +-
 drivers/pinctrl/freescale/pinctrl-mxs.h            |    6 +-
 drivers/pinctrl/intel/pinctrl-alderlake.c          |   18 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   10 +-
 drivers/pinctrl/intel/pinctrl-broxton.c            |   31 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |   31 +-
 drivers/pinctrl/intel/pinctrl-cedarfork.c          |   13 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |    6 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |   13 +-
 drivers/pinctrl/intel/pinctrl-elkhartlake.c        |   24 +-
 drivers/pinctrl/intel/pinctrl-emmitsburg.c         |   13 +-
 drivers/pinctrl/intel/pinctrl-geminilake.c         |   21 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |   35 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   74 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   55 +-
 drivers/pinctrl/intel/pinctrl-jasperlake.c         |   13 +-
 drivers/pinctrl/intel/pinctrl-lakefield.c          |   13 +-
 drivers/pinctrl/intel/pinctrl-lewisburg.c          |   12 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |    8 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |    6 +-
 drivers/pinctrl/intel/pinctrl-meteorlake.c         |   23 +-
 drivers/pinctrl/intel/pinctrl-moorefield.c         |    6 +-
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |   37 +-
 drivers/pinctrl/intel/pinctrl-tigerlake.c          |   30 +-
 drivers/pinctrl/mediatek/Kconfig                   |    5 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-moore.c           |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt7981.c          | 1048 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |    1 -
 drivers/pinctrl/mediatek/pinctrl-paris.c           |    5 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |    2 -
 drivers/pinctrl/pinctrl-amd.c                      |    7 +
 drivers/pinctrl/pinctrl-amd.h                      |    1 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |    4 +-
 drivers/pinctrl/pinctrl-at91.c                     |   44 +-
 drivers/pinctrl/pinctrl-da850-pupd.c               |    6 -
 drivers/pinctrl/pinctrl-digicolor.c                |   10 +-
 drivers/pinctrl/pinctrl-mcp23s08_i2c.c             |    5 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |    1 +
 drivers/pinctrl/pinctrl-sx150x.c                   |    6 +-
 drivers/pinctrl/pinctrl-thunderbay.c               |    7 -
 drivers/pinctrl/pinmux.c                           |    4 +-
 drivers/pinctrl/qcom/Kconfig                       |   50 +
 drivers/pinctrl/qcom/Makefile                      |    5 +
 drivers/pinctrl/qcom/pinctrl-ipq5332.c             |  861 ++++++++++
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |    1 -
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    9 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm8226.c             |   11 +-
 drivers/pinctrl/qcom/pinctrl-msm8976.c             |    8 +-
 drivers/pinctrl/qcom/pinctrl-qdu1000.c             | 1274 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sa8775p.c             | 1537 ++++++++++++++++=
+
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c    |  240 +++
 drivers/pinctrl/qcom/pinctrl-sm8550.c              | 1790 ++++++++++++++++=
++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    8 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |    2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |    2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |    2 +-
 drivers/pinctrl/ralink/pinctrl-mt7620.c            |  164 +-
 drivers/pinctrl/ralink/pinctrl-mt7621.c            |   48 +-
 drivers/pinctrl/ralink/pinctrl-rt2880.c            |   28 +-
 drivers/pinctrl/ralink/pinctrl-rt305x.c            |   82 +-
 drivers/pinctrl/ralink/pinctrl-rt3883.c            |   44 +-
 drivers/pinctrl/renesas/pfc-r8a77950.c             |  244 +++
 drivers/pinctrl/renesas/pfc-r8a779g0.c             |  112 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |   25 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +-
 drivers/pinctrl/starfive/Kconfig                   |   33 +
 drivers/pinctrl/starfive/Makefile                  |    4 +
 .../pinctrl/starfive/pinctrl-starfive-jh7110-aon.c |  177 ++
 .../pinctrl/starfive/pinctrl-starfive-jh7110-sys.c |  449 +++++
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |  982 +++++++++++
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h |   70 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    1 +
 drivers/pinctrl/sunplus/sppctl.c                   |    1 -
 .../dt-bindings/pinctrl/starfive,jh7110-pinctrl.h  |  137 ++
 include/linux/gpio/driver.h                        |   12 -
 include/linux/pinctrl/pinctrl.h                    |   20 +
 147 files changed, 12945 insertions(+), 1355 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{fsl,imx8mm-pinctrl.yaml
=3D> fsl,imx8m-pinctrl.yaml} (76%)
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
 delete mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yam=
l
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-poeg.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7981.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5332.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qdu1000.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sa8775p.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8550.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
 create mode 100644 include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
