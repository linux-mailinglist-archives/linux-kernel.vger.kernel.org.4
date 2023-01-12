Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267D667989
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjALPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbjALPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31F548593
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso15365769wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eWDyoKHBFUvFef0M8aMXHWc3vZP4l1W+59M7RIL4k8=;
        b=2k0Q66TJM6ZdCiCnaz6dci8qLsscm01j1v48pmTDfPWhJAV0a7z7vQ6x6WScy/SlRL
         rt0+9o1PnxALwFiPgK+my6rkFK2dCkFHzhQgMfnqHklfv0ftTmWXWfrLOtIaaUANOIA9
         8djxvPZyypGmxHlk1vLEKunkV8QHpeLqWa/UEjPDItso4pNSac67zLmBcRD3tmZ9kupv
         giZ6JDJNy8dkpKZFeUzgNCtarRj2igfYDGPGmGAUPyCuFOEXnh300yZoH09EZjZGxYMl
         fpMAjdGbIa2WZVfObkRoZCxqH+1GlCtCoipjuVmbRIJLBr4Q1s4zP7hz5VaQ5LLgr9AR
         8EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eWDyoKHBFUvFef0M8aMXHWc3vZP4l1W+59M7RIL4k8=;
        b=kE/p4dFq1oYSnxBoNUsVxN1/w/KaAkVrZGjJQnr5k/8aNTN+tSDMkbuF4mBRQXK6kK
         YdBEopljBWb73yYaFBAJ7CiF0174z5qnYKKWz1EkzErvroQdYK03FI27z/t6nL6VPd5y
         s9wGEYLKKCr+3GaqpwIhaN8p3hGihD0L6qx0MHPp3mLclez05lT7pBxWH4pIOrpbgPNg
         9c64oh+MsYVARWsCQCXVdBuegn9hy1FvpZqHdLcNZaOrp4sKqvfbHEF99wMsyzI4SHe4
         JMZSyzB5boaSZ7W1LXIKbmPPMey1ru6of9nEwpNZ5VCrjmVu2yOjqNY07eX2llo+mhHL
         px4Q==
X-Gm-Message-State: AFqh2kpGJCi+TCNkHcwSPCzcyTBB8nRdauAKpIZGGPwzjhR1LUdOeFJj
        4l/5u20liOgthRxd5LbiVSbbPA==
X-Google-Smtp-Source: AMrXdXsQnB+daHOKSUGnTX+2xpNJiQ/ioCPcrA3tqxJTpITi8JOBE+Lz76UOTLm0SCGSH0pjN5n5GA==
X-Received: by 2002:a05:600c:1e8c:b0:3d6:2952:679b with SMTP id be12-20020a05600c1e8c00b003d62952679bmr55319960wmb.34.1673537393008;
        Thu, 12 Jan 2023 07:29:53 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id l24-20020a1ced18000000b003d99da8d30asm26395909wmh.46.2023.01.12.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:29:52 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH v10 0/6] Add LVTS thermal architecture
Date:   Thu, 12 Jan 2023 16:28:49 +0100
Message-Id: <20230112152855.216072-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
  v10:
     - Rebase on top of "thermal/linux-next"
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
  dt-bindings/thermal/mediatek: Add dt-binding document for LVTS thermal
    controllers
  arm64/dts/mt8195: Add efuse node to mt8195
  thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver
  arm64/dts/mt8195: Add thermal zones and thermal nodes
  arm64/dts/mt8195: Add temperature mitigation threshold

 .../thermal/mediatek,lvts-thermal.yaml        |  140 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  256 ++++
 drivers/thermal/Kconfig                       |   14 +-
 drivers/thermal/Makefile                      |    2 +-
 drivers/thermal/mediatek/Kconfig              |   36 +
 drivers/thermal/mediatek/Makefile             |    2 +
 .../auxadc_thermal.c}                         |    2 +-
 drivers/thermal/mediatek/lvts_thermal.c       | 1244 +++++++++++++++++
 include/dt-bindings/thermal/mediatek-lvts.h   |   19 +
 9 files changed, 1703 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h

-- 
2.34.1

