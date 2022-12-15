Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E9F64E02F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLOSFv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Dec 2022 13:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:05:49 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC871146F;
        Thu, 15 Dec 2022 10:05:47 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id pa22so2994999qkn.9;
        Thu, 15 Dec 2022 10:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGpUneIdX+cNSoH7B/PLnvFFwhFd167VknZlRywLm+w=;
        b=Jr8pYMgI6lCPNPUfpzEGmnueBucZRYEX9/VrEIQiPWqGlGEViOekdw2JIRC1V5I7pv
         Pjv+nm/ypDnIzdAmUtIlckmOm5xVD+ds2FTKRHMe4f6PEXfkbJARhLuIvgNiln/mT6+Z
         kGpAmTCYGSOTKu+3RLVLxjMl1+RkO486PxtsdBAO9H+aCCbasUMjS7s5w5elJdwE+iTI
         xx9aON1zm/ITGP83Ko5HQRpo1B91mzHhKpXkHUOygqTS992svu7tmb3IIg+IjOWUu9fH
         rfTJTFXpRwIaxeM9SrEVDj4dCWx+I3DPv74nnhICDS9E3GxFthozNds2mej49CBkmMdT
         jj7w==
X-Gm-Message-State: ANoB5pmdoFB0QUYggSRlGvA73PfSepvvgTKbQ+XUZ9MkWHavaMlZLZcK
        jCEd5p6MX07HzncJxRfDVVJlLCmOidd6mF/UlUwEnaqUKfI=
X-Google-Smtp-Source: AA0mqf4SH0GZnM1tg9CXMGxFgDz93NTIdLZ2xAMEW2rxbq+vMEEKNTAXkYarWnp+IE8lBKoI/B8u8W+k2DylfEksOUY=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr84429469qki.23.1671127546727; Thu, 15
 Dec 2022 10:05:46 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Dec 2022 19:05:35 +0100
Message-ID: <CAJZ5v0hu5P+xmLnwhTN1S1mXfUC0ZNzPdiuK_1Ebq29x8aa8Ug@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.2-rc1-2

with top-most commit bd7bcc4f963c8898176ad864288959375154e038

 Merge tag 'thermal-v6.2-rc1' of
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 75b15aa0d83ec835082129b62e8cb9a44703ad72

 Merge branch 'thermal-intel'

to receive more thermal control updates for 6.2-rc1.

These are updates of assorted thermal drivers, mostly for ARM
platforms, generally isolated and fairly straightforward, and
the recent Intel HFI driver fix for systems without HFI support.

Specifics:

 - Avoid clearing the HFI status bit on systems without HFI support
   which triggers unchecked MSR access errors (Srinivas Pandruvada).

 - Add sm8450 and sm8550 QCom compatible string to DT bindings (Luca
   Weiss, Neil Armstrong).

 - Use devm_platform_get_and_ioremap_resource on the ST platform to
   group two calls into a single one (Minghao Chi).

 - Use GENMASK instead of bitmaps and validate the temperature after
   reading it in the imx8mm_thermal driver (Marcus Folkesson).

 - Convert generic-adc-thermal to DT schema (Rob Herring).

 - Fix debug print message with inverted logic in the k3_j72xx_bandgap
   driver (Keerthy).

 - Fix memory leak on thermal_of_zone_register() failure (Ido Schimmel).

 - Add support for IPQ8074 in the tsens thermal driver along with the DT
   bindings (Robert Marko).

 - Fix and rework the debugfs code in the tsens driver (Christian
   Marangi).

 - Add calibration and DT documentation for the imx8mm driver (Marek
   Vasut).

 - Add DT bindings and compatible for the Mediatek SoCs mt7981 and
   mt7983 (Daniel Golle).

 - Don't show an error message if it happens at probe time while it
   will be deferred on the QCom SPMI ADC driver (Johan Hovold).

 - Add HWMon support for the imx8mm board (Alexander Stein).

 - Remove pointless include from the power allocator governor (Christophe
   JAILLET).

 - Add interrupt DT bindings for QCom SoCs SC8280XP, SM6350 and SM8450
   (Krzysztof Kozlowski).

 - Fix inaccurate warning message for the QCom tsens gen2 (Luca Weiss).

 - Demote error log of thermal zone register to debug in the tsens QCom
   driver (Manivannan Sadhasivam).

 - Consolidate the the efuse values and the errata handling in the TI
   Bandgap driver (Bryan Brattlof).

 - Document Renesas RZ/Five as compatible with RZ/G2UL in the DT
   bindings (Lad Prabhakar).

 - Fix the irq handler return value in the LMh driver (Bjorn Andersson).

 - Delete empty platform remove callback from imx_sc_thermal (Uwe
   Kleine-König).

Thanks!


---------------

Alexander Stein (1):
      thermal/drivers/imx8mm: Add hwmon support

Bjorn Andersson (1):
      thermal/drivers/qcom/lmh: Fix irq handler return value

Bryan Brattlof (6):
      thermal/drivers/k3_j72xx_bandgap: Simplify k3_thermal_get_temp() function
      thermal/drivers/k3_j72xx_bandgap: Use bool for i2128 erratum flag
      thermal/drivers/k3_j72xx_bandgap: Remove fuse_base from structure
      thermal/drivers/k3_j72xx_bandgap: Map fuse_base only for erratum
workaround
      dt-bindings: thermal: k3-j72xx: elaborate on binding description
      dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range

Christian Marangi (3):
      thermal/drivers/qcom/tsens: Init debugfs only with successful probe
      thermal/drivers/qcom/tsens: Fix wrong version id dbg_version_show
      thermal/drivers/qcom/tsens: Rework debugfs file structure

Christophe JAILLET (1):
      thermal/core/power allocator: Remove a useless include

Daniel Golle (1):
      dt-bindings: thermal: mediatek: add compatible string for MT7986
and MT7981 SoC

Geert Uytterhoeven (1):
      thermal: ti-soc-thermal: Drop comma after SoC match table sentinel

Ido Schimmel (1):
      thermal/of: Fix memory leak on thermal_of_zone_register() failure

Johan Hovold (1):
      thermal: qcom-spmi-adc-tm5: suppress probe-deferral error message

Keerthy (1):
      thermal/drivers/k3_j72xx_bandgap: Fix the debug print message

Krzysztof Kozlowski (1):
      dt-bindings: thermal: qcom-tsens: narrow interrupts for
SC8280XP, SM6350 and SM8450

Lad Prabhakar (1):
      dt-bindings: thermal: rzg2l-thermal: Document RZ/Five SoC

Luca Weiss (2):
      dt-bindings: thermal: tsens: Add sm8450 compatible
      thermal/drivers/qcom/temp-alarm: Fix inaccurate warning for gen2

Manivannan Sadhasivam (1):
      thermal/drivers/qcom: Demote error log of thermal zone register to debug

Marcus Folkesson (2):
      thermal/drivers/imx8mm_thermal: Use GENMASK() when appropriate
      thermal/drivers/imx8mm_thermal: Validate temperature range

Marek Vasut (2):
      dt-bindings: thermal: imx8mm-thermal: Document optional nvmem-cells
      thermal/drivers/imx: Add support for loading calibration data from OCOTP

Minghao Chi (1):
      thermal/drivers/st: Use devm_platform_get_and_ioremap_resource()

Neil Armstrong (1):
      dt-bindings: thermal: qcom-tsens: Add compatible for sm8550

Rob Herring (1):
      dt-bindings: thermal: Convert generic-adc-thermal to DT schema

Robert Marko (4):
      dt-bindings: thermal: tsens: Add ipq8074 compatible
      thermal/drivers/tsens: Add support for combined interrupt
      thermal/drivers/tsens: Allow configuring min and max trips
      thermal/drivers/tsens: Add IPQ8074 support

Srinivas Pandruvada (1):
      thermal: intel: Don't set HFI status bit to 1

Uwe Kleine-König (1):
      thermal/drivers/imx_sc_thermal: Drop empty platform remove function

---------------

 .../bindings/thermal/generic-adc-thermal.yaml      |  84 ++++++++++
 .../bindings/thermal/imx8mm-thermal.yaml           |   7 +
 .../bindings/thermal/mediatek-thermal.txt          |   2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  81 ++++++++--
 .../devicetree/bindings/thermal/rzg2l-thermal.yaml |   2 +-
 .../bindings/thermal/thermal-generic-adc.txt       |  95 -----------
 .../bindings/thermal/ti,j72xx-thermal.yaml         |  35 +++-
 drivers/thermal/gov_power_allocator.c              |   1 -
 drivers/thermal/imx8mm_thermal.c                   | 180 ++++++++++++++++++++-
 drivers/thermal/imx_sc_thermal.c                   |   6 -
 drivers/thermal/intel/therm_throt.c                |   5 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |  67 ++++----
 drivers/thermal/qcom/lmh.c                         |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   8 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   3 +-
 drivers/thermal/qcom/tsens-8960.c                  |   3 +
 drivers/thermal/qcom/tsens-v0_1.c                  |   3 +
 drivers/thermal/qcom/tsens-v1.c                    |   3 +
 drivers/thermal/qcom/tsens-v2.c                    |  20 +++
 drivers/thermal/qcom/tsens.c                       |  68 +++++---
 drivers/thermal/qcom/tsens.h                       |   8 +-
 drivers/thermal/st/stm_thermal.c                   |   4 +-
 drivers/thermal/thermal_of.c                       |   8 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
 24 files changed, 510 insertions(+), 187 deletions(-)
