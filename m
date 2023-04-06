Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099A6DA2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjDFUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDFUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:31:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869F349CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:31:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jw24so4214693ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Cj6dH8SQdnU185Yyyy6Om9VdNmKCPrXJ/wOeykSuMs=;
        b=taN5aF85T0o4DOEA7zGLC9x48hE/Ll4x8ZFWRhnpOle/x0WjymESe4p4Z14BHa4S9c
         uw7oNg/Q29YXzTtqcl9Czi8nNczbJMDfMKL24RxQLPQ4i7gS2T3RgrLsNbgbf+VAwqnm
         kCTb7lsCxP9ItySfzSsSSg9XA7o/XysqdOeSgmklm8S772pjBQT+JEFaumzsPFB7Z7Kq
         ttNNTzWPBGiJpGKT0WSXACkCsMquvcdtgYxpUaltczVIRYNkiqm57VeXX06xfnl++FmI
         gmxj3nq/pcX+gvNwXJxO0eKcWnKI5uuzQyY9KAyvy8nG+tI3TfEqTkyzFK+8IztYVtiX
         M02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Cj6dH8SQdnU185Yyyy6Om9VdNmKCPrXJ/wOeykSuMs=;
        b=ZOX1+IEF8Ja0PdCPyQsfbzULnKh1u1CyR1TLtE79k34lwN/hhZ49WyoHBfSkcr5LQh
         g3VmhXhg9h8ME74bETk32lBp4yTf5QSP6R3z1U/teoo+ZajC5qGw+mJm/p3IGOX237Hz
         BSsvmwiFm1UTBtgAZVV/7+3ar/93HpYbAiExweLxMDdBLwbmq1cB8o6xNf4/nkODK4It
         5QEky2jG3GXE/xJoI3x7zIkhh79fBTymZXJJnahLqWZB25J0iNkTS/jA0bdItSQzadJs
         eoIV/AsPpwVTJAnIA3MbGwTa04KOzTiXhHmgctku60IzaqmZ8Mm9Du4zYSd0p6f54fNO
         q6Lw==
X-Gm-Message-State: AAQBX9c94dZA9LSCHKubcwS6TNZwoQPArpm13fTKG/haVRq5/aIix2Ja
        MtvdiRA93Xu6ouHA4Egh/z2wbQ==
X-Google-Smtp-Source: AKy350aYtbUbdh6UH+nAWn66ZLqv4AwXcyRo/pi+U+xLfe5lXoD+dmiqBL9fEc9v7hXlsmZb2JD7bg==
X-Received: by 2002:a17:906:c795:b0:922:8fc9:d235 with SMTP id cw21-20020a170906c79500b009228fc9d235mr6270842ejb.9.1680813074873;
        Thu, 06 Apr 2023 13:31:14 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b0092bea699124sm1210330ejo.106.2023.04.06.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:31:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/68] hwmon: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:29:55 +0200
Message-Id: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first patch constifies the hwmon_channel_info pointers in the core, so all
the drivers can be updated - all patches here depend on the first one.

If the approach is fine, I will later update other subsystems.

Best regards,
Krzysztof

Krzysztof Kozlowski (68):
  hwmon: constify pointers to hwmon_channel_info
  hwmon: adm1177: constify pointers to hwmon_channel_info
  hwmon: adm9240: constify pointers to hwmon_channel_info
  hwmon: adt7411: constify pointers to hwmon_channel_info
  hwmon: adt7470: constify pointers to hwmon_channel_info
  hwmon: adt7x10: constify pointers to hwmon_channel_info
  hwmon: aht10: constify pointers to hwmon_channel_info
  hwmon: aquacomputer: constify pointers to hwmon_channel_info
  hwmon: as370: constify pointers to hwmon_channel_info
  hwmon: axi-fan: constify pointers to hwmon_channel_info
  hwmon: bt1-pvt: constify pointers to hwmon_channel_info
  hwmon: corsair: constify pointers to hwmon_channel_info
  hwmon: dell-smm: constify pointers to hwmon_channel_info
  hwmon: drivetemp: constify pointers to hwmon_channel_info
  hwmon: emc2305: constify pointers to hwmon_channel_info
  hwmon: ftsteutates: constify pointers to hwmon_channel_info
  hwmon: gxp-fan: constify pointers to hwmon_channel_info
  hwmon: i5500_temp: constify pointers to hwmon_channel_info
  hwmon: ina238: constify pointers to hwmon_channel_info
  hwmon: ina3221: constify pointers to hwmon_channel_info
  hwmon: intel-m10-bmc: constify pointers to hwmon_channel_info
  hwmon: jc42: constify pointers to hwmon_channel_info
  hwmon: k10temp: constify pointers to hwmon_channel_info
  hwmon: k8temp: constify pointers to hwmon_channel_info
  hwmon: lan966x: constify pointers to hwmon_channel_info
  hwmon: lm75: constify pointers to hwmon_channel_info
  hwmon: lm83: constify pointers to hwmon_channel_info
  hwmon: lm95241: constify pointers to hwmon_channel_info
  hwmon: lm95245: constify pointers to hwmon_channel_info
  hwmon: lochnagar: constify pointers to hwmon_channel_info
  hwmon: ltc2947: constify pointers to hwmon_channel_info
  hwmon: ltc2992: constify pointers to hwmon_channel_info
  hwmon: ltc4245: constify pointers to hwmon_channel_info
  hwmon: ltq-cputemp: constify pointers to hwmon_channel_info
  hwmon: max127: constify pointers to hwmon_channel_info
  hwmon: max31730: constify pointers to hwmon_channel_info
  hwmon: max31760: constify pointers to hwmon_channel_info
  hwmon: max31790: constify pointers to hwmon_channel_info
  hwmon: max6620: constify pointers to hwmon_channel_info
  hwmon: max6621: constify pointers to hwmon_channel_info
  hwmon: max6650: constify pointers to hwmon_channel_info
  hwmon: mc34vr500: constify pointers to hwmon_channel_info
  hwmon: mcp3021: constify pointers to hwmon_channel_info
  hwmon: mlxreg: constify pointers to hwmon_channel_info
  hwmon: nct7904: constify pointers to hwmon_channel_info
  hwmon: npcm750-pwm: constify pointers to hwmon_channel_info
  hwmon: ntc_thermistor: constify pointers to hwmon_channel_info
  hwmon: nzxt: constify pointers to hwmon_channel_info
  hwmon: oxp-sensors: constify pointers to hwmon_channel_info
  hwmon: peci: constify pointers to hwmon_channel_info
  hwmon: powr1220: constify pointers to hwmon_channel_info
  hwmon: raspberrypi: constify pointers to hwmon_channel_info
  hwmon: sbrmi: constify pointers to hwmon_channel_info
  hwmon: sbtsi_temp: constify pointers to hwmon_channel_info
  hwmon: sch5627: constify pointers to hwmon_channel_info
  hwmon: sht4x: constify pointers to hwmon_channel_info
  hwmon: sl28cpld: constify pointers to hwmon_channel_info
  hwmon: smpro: constify pointers to hwmon_channel_info
  hwmon: sparx5-temp: constify pointers to hwmon_channel_info
  hwmon: sy7636a: constify pointers to hwmon_channel_info
  hwmon: tmp102: constify pointers to hwmon_channel_info
  hwmon: tmp103: constify pointers to hwmon_channel_info
  hwmon: tmp108: constify pointers to hwmon_channel_info
  hwmon: tmp464: constify pointers to hwmon_channel_info
  hwmon: tmp513: constify pointers to hwmon_channel_info
  hwmon: tps23861: constify pointers to hwmon_channel_info
  hwmon: w83627ehf: constify pointers to hwmon_channel_info
  hwmon: w83773g: constify pointers to hwmon_channel_info

 Documentation/hwmon/hwmon-kernel-api.rst |  6 +++---
 drivers/accel/habanalabs/common/hwmon.c  |  2 +-
 drivers/hwmon/adm1177.c                  |  2 +-
 drivers/hwmon/adm9240.c                  |  2 +-
 drivers/hwmon/adt7411.c                  |  2 +-
 drivers/hwmon/adt7470.c                  |  2 +-
 drivers/hwmon/adt7x10.c                  |  2 +-
 drivers/hwmon/aht10.c                    |  2 +-
 drivers/hwmon/aquacomputer_d5next.c      |  2 +-
 drivers/hwmon/as370-hwmon.c              |  2 +-
 drivers/hwmon/axi-fan-control.c          |  2 +-
 drivers/hwmon/bt1-pvt.c                  |  4 ++--
 drivers/hwmon/corsair-cpro.c             |  2 +-
 drivers/hwmon/corsair-psu.c              |  2 +-
 drivers/hwmon/dell-smm-hwmon.c           |  2 +-
 drivers/hwmon/drivetemp.c                |  2 +-
 drivers/hwmon/emc2305.c                  |  2 +-
 drivers/hwmon/ftsteutates.c              |  2 +-
 drivers/hwmon/gxp-fan-ctrl.c             |  2 +-
 drivers/hwmon/hwmon.c                    |  4 ++--
 drivers/hwmon/i5500_temp.c               |  2 +-
 drivers/hwmon/ina238.c                   |  2 +-
 drivers/hwmon/ina3221.c                  |  2 +-
 drivers/hwmon/intel-m10-bmc-hwmon.c      | 10 +++++-----
 drivers/hwmon/jc42.c                     |  2 +-
 drivers/hwmon/k10temp.c                  |  2 +-
 drivers/hwmon/k8temp.c                   |  2 +-
 drivers/hwmon/lan966x-hwmon.c            |  2 +-
 drivers/hwmon/lm75.c                     |  2 +-
 drivers/hwmon/lm83.c                     |  2 +-
 drivers/hwmon/lm95241.c                  |  2 +-
 drivers/hwmon/lm95245.c                  |  2 +-
 drivers/hwmon/lochnagar-hwmon.c          |  2 +-
 drivers/hwmon/ltc2947-core.c             |  2 +-
 drivers/hwmon/ltc2992.c                  |  2 +-
 drivers/hwmon/ltc4245.c                  |  2 +-
 drivers/hwmon/ltq-cputemp.c              |  2 +-
 drivers/hwmon/max127.c                   |  2 +-
 drivers/hwmon/max31730.c                 |  2 +-
 drivers/hwmon/max31760.c                 |  2 +-
 drivers/hwmon/max31790.c                 |  2 +-
 drivers/hwmon/max6620.c                  |  2 +-
 drivers/hwmon/max6621.c                  |  2 +-
 drivers/hwmon/max6650.c                  |  2 +-
 drivers/hwmon/mc34vr500.c                |  2 +-
 drivers/hwmon/mcp3021.c                  |  2 +-
 drivers/hwmon/mlxreg-fan.c               |  2 +-
 drivers/hwmon/nct7904.c                  |  2 +-
 drivers/hwmon/npcm750-pwm-fan.c          |  2 +-
 drivers/hwmon/ntc_thermistor.c           |  2 +-
 drivers/hwmon/nzxt-kraken2.c             |  2 +-
 drivers/hwmon/nzxt-smart2.c              |  2 +-
 drivers/hwmon/oxp-sensors.c              |  2 +-
 drivers/hwmon/peci/cputemp.c             |  2 +-
 drivers/hwmon/peci/dimmtemp.c            |  2 +-
 drivers/hwmon/powr1220.c                 |  2 +-
 drivers/hwmon/raspberrypi-hwmon.c        |  2 +-
 drivers/hwmon/sbrmi.c                    |  2 +-
 drivers/hwmon/sbtsi_temp.c               |  2 +-
 drivers/hwmon/sch5627.c                  |  2 +-
 drivers/hwmon/sht4x.c                    |  2 +-
 drivers/hwmon/sl28cpld-hwmon.c           |  2 +-
 drivers/hwmon/smpro-hwmon.c              |  2 +-
 drivers/hwmon/sparx5-temp.c              |  2 +-
 drivers/hwmon/sy7636a-hwmon.c            |  2 +-
 drivers/hwmon/tmp102.c                   |  2 +-
 drivers/hwmon/tmp103.c                   |  2 +-
 drivers/hwmon/tmp108.c                   |  2 +-
 drivers/hwmon/tmp464.c                   |  2 +-
 drivers/hwmon/tmp513.c                   |  2 +-
 drivers/hwmon/tps23861.c                 |  2 +-
 drivers/hwmon/w83627ehf.c                |  2 +-
 drivers/hwmon/w83773g.c                  |  2 +-
 include/linux/hwmon.h                    |  2 +-
 74 files changed, 82 insertions(+), 82 deletions(-)

-- 
2.34.1

