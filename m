Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF068D88C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjBGNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjBGNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:10:33 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8BB9008
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:10:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so6136436wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHHYbQWTXArEvDpNJJ6Ec38YulVcoF1CmHnyxseWv/o=;
        b=hrcPy6lygRPAqNPp68oWhIxCSjNXqTBb2jThr91mU4GdhIGg5lgoVAkT2PFKb6fkZy
         j4Zky8tzxae7gzFiXjCl1drM8rV2Mo68ORaRjdAN9xmPrghlyXq9F8ytzewbZbJLOFuK
         pkKSlHA+7B537tTMOqrcqqZB4oEdXfqD5HbZo6U8mOFZ/y4hOpuvrg2PXygmle8V4okp
         jjQS/8aEPPY40umBsIfahaJ4TMmqSIwGQ7QLaaJG/R78l8Kmf4pFaqRYyNQ9UIz9UQIb
         OtKV5RRPA4hm7Vl/+2M2NAKG548KJHiO42bQ8tcglt46HugQkNRPjPX3uQhj7AENIsl9
         WnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHHYbQWTXArEvDpNJJ6Ec38YulVcoF1CmHnyxseWv/o=;
        b=xAKTMTG/tvwucj5htLkfU9WWAijx+CKLL8o/+1p7asffzCLWUJ2ml0yVrDO/l2aQmg
         c+m9GYO0VFNcxaT+LiR8TWMTSwyDyTQ3DF9YBg7FqD2MPbX+tkjBZ4XManUb1DZs3Vch
         WX6oJDlx1I/rEA7I8KQ2QIn1lMlsKNIrEpj67sDPzG/x+Rj9jVd8KaYhjUO/4asrNQHS
         tlH2thRsuxBozVB3kJZMdqbJYk5jKWRsHPVKSPuUSpLXNzbXWXyWeVejAtHJguglnR/i
         NGqtWZw/fzd9wqtmfIsLCXDrs7zdmokn7PwuCcf6lkG9QLZl71OUMDN0IwpQQUnNHlpZ
         yp3Q==
X-Gm-Message-State: AO0yUKXTis+X+yzDtTWQj36vPq0GN14PT1lTwVck9y/KcbhsWcW+QF/4
        taw2QTDh8LCpi5hzeLCtmKi8+w==
X-Google-Smtp-Source: AK7set/NeaJsE2/DeX3qJwmT1gppnlE6SerKN9vJUe16meTPZ2wNwdqPqcVk2AdedAW9/4jQ5iyPrQ==
X-Received: by 2002:a05:600c:18a0:b0:3df:3bd6:63e5 with SMTP id x32-20020a05600c18a000b003df3bd663e5mr2932315wmp.12.1675775400789;
        Tue, 07 Feb 2023 05:10:00 -0800 (PST)
Received: from t480-bl003.civfrance.com (58.188.158.77.rev.sfr.net. [77.158.188.58])
        by smtp.gmail.com with ESMTPSA id g24-20020a7bc4d8000000b003df30c94850sm17987385wmk.25.2023.02.07.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:10:00 -0800 (PST)
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
Subject: [PATCH v13 0/6] Add LVTS Thermal Architecture
Date:   Tue,  7 Feb 2023 14:09:52 +0100
Message-Id: <20230207130958.608305-1-bchihi@baylibre.com>
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
  v13:
     - Rebase on top of "thermal/linux-next" :
       base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
     - Fix coding style issues
       - Remove "__init" from all functions
       - Remove "lvts_ctrl_enable" and "lvts_ctrl_disable" wrappers
       - Use "dev_err_probe" instead of "dev_dbg" in "lvts_probe"
     - Fix subject prefix
     - Add "mt8192" to dt-binding definition
     - Change dt-binding license to "GPL-2.0-only OR BSD-2-Clause"
     - Fix debugfs mutli-instance support

  v12:
     - Fix subject prefix
     - Add dual licenses to dt-binding
     - Rename "include/dt-bindings/thermal/mediatek-lvts.h"
       to "include/dt-bindings/thermal/mediatek,lvts-thermal.h"

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
  thermal: drivers: mediatek: Relocate driver to mediatek folder
  dt-bindings: thermal: mediatek: Add LVTS thermal controllers
  arm64: dts: mt8195: Add efuse node to mt8195
  thermal: drivers: mediatek: Add the Low Voltage Thermal Sensor driver
  arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
  arm64: dts: mediatek: mt8195: Add temperature mitigation threshold

 .../thermal/mediatek,lvts-thermal.yaml        |  142 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  272 ++++
 drivers/thermal/Kconfig                       |   14 +-
 drivers/thermal/Makefile                      |    2 +-
 drivers/thermal/mediatek/Kconfig              |   37 +
 drivers/thermal/mediatek/Makefile             |    2 +
 .../auxadc_thermal.c}                         |    2 +-
 drivers/thermal/mediatek/lvts_thermal.c       | 1224 +++++++++++++++++
 .../thermal/mediatek,lvts-thermal.h           |   19 +
 9 files changed, 1702 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
 create mode 100644 drivers/thermal/mediatek/Kconfig
 create mode 100644 drivers/thermal/mediatek/Makefile
 rename drivers/thermal/{mtk_thermal.c => mediatek/auxadc_thermal.c} (99%)
 create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
 create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h


base-commit: a2c81dc59d41e92362ab7d41d0c15471ea50637d
-- 
2.34.1

