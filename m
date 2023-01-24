Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B0679906
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjAXNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjAXNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:17:22 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144333D08C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t18so1028106wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcsiQs+yEKP/R93zQ24MnM+VOqwbIKPtvzI1bM864qQ=;
        b=I2pP7/1u15jyyBRHBmMiScxaj7BUA8Y+HhNNygeSvme5jcP3ppDrFPMseFvC7ZxKd5
         a16Ki+tRfvr7BnHkwTnB+flPrG9KjOuZcTX7hK6mqo2uacc7XIfFW12Tvj00hHg2gHSU
         3xg8OcNxYkt+ylotmu6Ckn6JxeXyDYQNrjXg9GRtJ0nGrQmXFlA1psh17bw37OLIXmDW
         2yutzjCpJOkY+JsgI/MEox3omysfyTKtdGHabsSe4j2I/Y50eee92mNMrKpPYY2LmuQt
         YDCWbtAMzHGFnAwkOPevDRtG1KkHN1cVTY6SOHpGyME/PvjhDsVZh+nGzXvSrDRD3aIn
         fwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcsiQs+yEKP/R93zQ24MnM+VOqwbIKPtvzI1bM864qQ=;
        b=adf2gscja6Nz7c8ubH7NER7UN1GBRG69MYxItXm0bE9YOIte/BWCDIpAmyRUEXRgbL
         0UpoDxeCQ6RhhS2iJmghHcs6CEbKRi9mqx7zy9zQU9YivtmuCCgDZvF4zBGrm1ORRqtq
         Q4dc/hg3jxb0MkqJVc08ix7DbSgSKu+6kkU34/LgxZvwZMrk1dV+pZdZumSoQ6YoN+GE
         xohSL6zozGwn/RKNZL/4e7Vtvf4+GUrodHS5wFAl/o8uF6u6rCcLIhPAApXulPsHrv2B
         GedNMrpZOnWt9pYJfyFasEYUEGNiUND+Ut4t+wvCS7XAo7898qt3ncNMIRnd2tROY+wr
         IbKw==
X-Gm-Message-State: AFqh2krEf/YIiWGKtu2LS1o/I4xU34ZwoPh7N+6k0jgeQKKlLu4wz3Ee
        YizR7e25WEUdiqdaoHZFipGteg==
X-Google-Smtp-Source: AMrXdXvUdyhgSj74U0J5ooc22dmAfWAPbinzKmfbffJWkBJ0WotFrA3jV94Jm3QF4/pywu4AP5QWVg==
X-Received: by 2002:a5d:4446:0:b0:2ba:c946:868b with SMTP id x6-20020a5d4446000000b002bac946868bmr23432108wrr.23.1674566237463;
        Tue, 24 Jan 2023 05:17:17 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfb5ebf8cfsm49427wrp.21.2023.01.24.05.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:17:17 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v11 0/6] Add LVTS thermal architecture
Date:   Tue, 24 Jan 2023 14:17:11 +0100
Message-Id: <20230124131717.128660-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

The LVTS (Low Voltage Thermal Sensor) driver is capable of monitoring
multiple hot points. For that, it contains 7 thermal control blocks
dedicated to specific devices on the die. Each control block can handle
up to 4 sensors. 

The thermal controller supports several interrupts. One for the cold
trip point, the hot trip point, the return to the normal trip point,
and a specific programmable trip point to monitor the temperature
dynamically.

The temperature measurement can be done in two ways, the immediate mode
where the temperature read is instantaneous and the filtered mode where
the controller uses, by configuration, an average of a set of values
removing the minimum and the maximum.

Finally, it is composed of 2 finite-state machines responsible for
the state of the temperature (cold, hot, hot 2 normal, hot hot),
the triggering of the interrupts, and the monitoring of the temperature.

As requested, the thermal driver has been reworked to reduce
the complexity of the code. At this time, the 4 little CPUs and
the 4 big CPUs are supported by the thermal driver.They are described
in a data structure and more devices can be added later.
The calibration routine has been simplified also.

The series provide the following changes:
 - Move the Mediatek drivers inside a dedicated folder as their number
   is increasing
 - Add the DT bindings for the controller
 - Add the efuse node for the mt8195
 - The LVTS driver
 - The thermal zones description in the DT

Changelog:
  v11:
     - Rebase on top of "thermal/linux-next" :
       base=0d568e144ead70189e7f16066dcb155b78ff9266
     - Remove unsupported SoC (mt8192) from dt-binding definition
     - Fix coding style issues :
       - Move litterals to define
       - Add interrupt macros
       - Remove wildcard : only mt8195 is supported for now

  v10:
     - Rebase on top of "thermal/linux-next" : thermal-v6.3-rc1
     - Rework the LVTS driver
     - Add the thermal trip temperature and cooling devices
       for the sensors supported by the driver

  v9:
     - Rebase on top of 6.0.0-rc1
     - Fix coding style issues
     - Fix commit titles and commit messages
     - Update dt-bindings :
     - Add "allOf:if:then:"
     - Use mt8192 as example (instead of mt8195)
     - Fix dt-binding errors
     - Fix DTS errors

  v8:
     - Fix coding style issues
     - Rebase on top of next-20220803
     - Add multi-instance support :
       - Rewrite DT-binding and DTS :
         - Add DT-binding and DTS for LVTS_v4 (MT8192 and MT8195)
           - One LVTS node for each HW Domain (AP and MCU)
         - One SW Instance for each HW Domain
         - Add a Kconfig sub-menu entry for LVTS and LVTS_v4 SoCs
     - Replace platform_get_resource by platform_get_mem_or_io to get
       Base Address
     - Replace platform_get_resource by platform_get_irq to get
       Interrupt Number
     - Add "lvts_" prefix to functions and structs

 v7:
     - Fix coding style issues
     - Rewrite dt bindings
       - was not accurate
       - Use mt8195 for example (instead of mt8192)
       - Rename mt6873 to mt8192
       - Remove clock name
     - Rebased on top of to series:
       - patchwork.kernel.org/project/linux-mediatek/list/?series=637849
       - patchwork.kernel.org/project/linux-pm/list/?series=639386

 v6:
     - Remove temperature aggregation (it will be added in another
       series)
     - Update the way to read the temperature (read one sensor
       instead of all)
     - Add support of mt8195

  v5:
     - Use 'git mv' for the relocated file.

  v4:
     - Rebase to kernel-v5.13-rc1

  v3:
     - change the expression in the lvts_temp_to_raw to dev_s64.

  v2:
     - Rebase to kernel-5.11-rc1.
     - sort headers
     - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
     - disconstruct the api of lvts_read_tc_msr_raw.
     - add the initial value max_temp = 0 and compare e.q.
       in the lvts_read_all_tc_temperature.
     - add the return with an invalid number in the lvts_init.

Balsam CHIHI (6):
  thermal/drivers/mediatek: Relocate driver to mediatek folder
  dt-bindings/thermal/mediatek: Add LVTS thermal controllers dt-binding
    definition
  arm64/dts/mt8195: Add efuse node to mt8195
  thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver
  arm64/dts/mt8195: Add thermal zones and thermal nodes
  arm64/dts/mt8195: Add temperature mitigation threshold

 .../thermal/mediatek,lvts-thermal.yaml        |  107 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  272 ++++
 drivers/thermal/Kconfig                       |   14 +-
 drivers/thermal/Makefile                      |    2 +-
 drivers/thermal/mediatek/Kconfig              |   36 +
 drivers/thermal/mediatek/Makefile             |    2 +
 .../auxadc_thermal.c}                         |    2 +-
 drivers/thermal/mediatek/lvts_thermal.c       | 1261 +++++++++++++++++
 include/dt-bindings/thermal/mediatek-lvts.h   |   19 +
 9 files changed, 1703 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h


base-commit: 0d568e144ead70189e7f16066dcb155b78ff9266
-- 
2.34.1

