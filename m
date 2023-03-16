Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23C6BD998
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCPTzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCPTzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59DB79D0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so6584725pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPZAKt4i0w/TkBTTG91/TCTyra1gRS+Ieuy/HCm4Uuc=;
        b=RKAwUZh/HRmz+7EePFlPDfpUCZ2m06G45z1GXqh4uxV4DVo9tJzayEI12m+nLyects
         iLQgl9fOtjxD/ZdTPDgW9gwKjqH567KgpCjCvpiuK+EcDzRP2M56lSae4U7q0vKOW50V
         WYrjNDmLzaHWIeoOBRn2H4XpykikxmrsfnDWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPZAKt4i0w/TkBTTG91/TCTyra1gRS+Ieuy/HCm4Uuc=;
        b=MAPwQZDB4WezAT00D1c8BMXAfpJLlQq9AlZ49EHjhzQxXq8IrLzfJ3yvpuLxde/qec
         mbo0bjZlaRLzI6x5f6N02Hwxbv4gaguyZdhyKJkH69FdWDnaeVpMMiAYpccY6H6OcUdQ
         c+vqZODKMB8zAEFsCUvWh8NSTp6/Inok51sQdZsxCpcGo/J0QqXYKerRK800qS2hX4II
         dVr1By1MQ9dyHdpKRXFiDoCdzrdvk8qWk46xtRtEuN+5AvRlusrpXmVh3Mrv2fLYDg7F
         daT1gtq6+Z3ol5SX43i+zqftEzzJWjbyPfUBdp3RRDJk5u+r4YSw7Srn+s+4piNfvghU
         J8Dw==
X-Gm-Message-State: AO0yUKWwWVW5syDOs6BI5NIpYYVCBZnmNZnjK126slaCklU034E/u8hD
        z3dsQaAEhHSvTh1KtR+vpNpGw2VJ80vQ9l/tPNw=
X-Google-Smtp-Source: AK7set8x+S+phoHcn6Z3k9n+BoNqDxCJvof10LKkXUygsCkbNH7ibjJ4bkYk4/Ny9apMMCpCrXvtkQ==
X-Received: by 2002:a05:6a20:1327:b0:d4:4fbe:6d1f with SMTP id g39-20020a056a20132700b000d44fbe6d1fmr3797478pzh.53.1678996513176;
        Thu, 16 Mar 2023 12:55:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for everything in drivers/regulator
Date:   Thu, 16 Mar 2023 12:54:37 -0700
Message-Id: <20230316195444.3946980-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series directly follows from the discussion when I tried to turn
on PROBE_PREFER_ASYNCHRONOUS just for the fixed-regulator [1] and
attempts to switch everything in drivers/regulator over to async
probe.

Like the similar patch series I did for the MMC subsystem a few years
ago [2], I've split this patch series into batches corresponding to
drivers corresponding to actively maintained stable kernel trees with
the idea to break the patch series up somewhat.

Most of the description of this series is contained in the first patch
of the series and then the further patches simply refer back to the
first one. The logic and reasoning behind all the patches is exactly
the same.

As talked about in the first patch, it wouldn't be at all shocking if
this broke someone. Hopefully this doesn't cause too much of a
problem. Most of the problems expected would be real underlying bugs
that already existed and were just tickled by this change. If you're
facing a problem, it's fairly easy to force individual drivers back to
"synchronous" probing while the problem is tracked down and fixed.

I am opting _not_ to CC every single person involved in each of these
regulators on this patch series because I suspect that the mailing
lists couldn't handle CCing that many people. This should be on LKML
so hopefully people can find it there and respond to it that
way. Anyone who responds will get CCed on future versions, if there
are any.

For reference, the ugly script I used is here:
  import os
  import re

  for filename in os.listdir("."):
      found_subsys = False
      found_driver = False
      output = []
      for line in open(filename, "r").readlines():
          if "struct platform_driver" in line or \
             "struct i2c_driver" in line or \
             "struct spmi_driver" in line or \
             "struct spi_driver" in line:
              found_subsys = True
          if found_subsys and re.search(r"\t\.driver\s*=\s*{", line):
              found_driver = True
              found_subsys = False
          mo = re.search(r"(\s*)\.name(\s*)=", line)
          if found_driver and mo:
              if not line.endswith(",\n"):
                  line = line[:-1] + ",\n"
              output.append(line)

              if mo.group(2) == " ":
                  space = " "
              elif mo.group(2) == "\t":
                  # Best we can do
                  space = " "
              elif mo.group(2).startswith("\t"):
                  # Guess that removing one tab is right
                  space = mo.group(2)[1:]
              else:
                  # Guess it's all spaces
                  space = mo.group(2)[7:] + " "

              output.append("%s.probe_type%s= PROBE_PREFER_ASYNCHRONOUS,\n" % (mo.group(1), space))
              found_driver = False
          else:
              output.append(line)

      open(filename, "w").write("".join(output))

I manually split drivers up into groups based on the kernel they were
introduced in.

I've run a compile test against "allyesconfig" on amd64, arm32, and
arm64 with this and confirmed it compiled. I've booted this on a
sc7180-trogdor-lazor board and confirmed it booted OK and got the boot
speed improvements I expected and that dmesg was as expected.

[1] https://lore.kernel.org/r/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org.uk
[2] https://lore.kernel.org/r/20200903232441.2694866-1-dianders@chromium.org/


Douglas Anderson (7):
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in
    4.14
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and
    4.19
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.19 and
    5.4
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.4 and
    5.10
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.10 and
    5.15
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.15 and
    6.1
  regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer
    than 6.1

 drivers/regulator/88pg86x.c                    | 1 +
 drivers/regulator/88pm800-regulator.c          | 1 +
 drivers/regulator/88pm8607.c                   | 1 +
 drivers/regulator/aat2870-regulator.c          | 1 +
 drivers/regulator/ab8500-ext.c                 | 1 +
 drivers/regulator/ab8500.c                     | 1 +
 drivers/regulator/act8865-regulator.c          | 1 +
 drivers/regulator/act8945a-regulator.c         | 1 +
 drivers/regulator/ad5398.c                     | 1 +
 drivers/regulator/anatop-regulator.c           | 1 +
 drivers/regulator/arizona-ldo1.c               | 2 ++
 drivers/regulator/arizona-micsupp.c            | 2 ++
 drivers/regulator/as3711-regulator.c           | 1 +
 drivers/regulator/as3722-regulator.c           | 1 +
 drivers/regulator/atc260x-regulator.c          | 1 +
 drivers/regulator/axp20x-regulator.c           | 1 +
 drivers/regulator/bcm590xx-regulator.c         | 1 +
 drivers/regulator/bd71815-regulator.c          | 1 +
 drivers/regulator/bd71828-regulator.c          | 3 ++-
 drivers/regulator/bd718x7-regulator.c          | 1 +
 drivers/regulator/bd9571mwv-regulator.c        | 1 +
 drivers/regulator/bd9576-regulator.c           | 1 +
 drivers/regulator/cpcap-regulator.c            | 1 +
 drivers/regulator/cros-ec-regulator.c          | 1 +
 drivers/regulator/da903x-regulator.c           | 1 +
 drivers/regulator/da9052-regulator.c           | 1 +
 drivers/regulator/da9055-regulator.c           | 1 +
 drivers/regulator/da9062-regulator.c           | 1 +
 drivers/regulator/da9063-regulator.c           | 1 +
 drivers/regulator/da9121-regulator.c           | 1 +
 drivers/regulator/da9210-regulator.c           | 1 +
 drivers/regulator/da9211-regulator.c           | 1 +
 drivers/regulator/db8500-prcmu.c               | 1 +
 drivers/regulator/dummy.c                      | 1 +
 drivers/regulator/fan53555.c                   | 1 +
 drivers/regulator/fan53880.c                   | 1 +
 drivers/regulator/fixed.c                      | 1 +
 drivers/regulator/gpio-regulator.c             | 1 +
 drivers/regulator/hi6421-regulator.c           | 1 +
 drivers/regulator/hi6421v530-regulator.c       | 1 +
 drivers/regulator/hi6421v600-regulator.c       | 1 +
 drivers/regulator/hi655x-regulator.c           | 1 +
 drivers/regulator/isl6271a-regulator.c         | 1 +
 drivers/regulator/isl9305.c                    | 1 +
 drivers/regulator/lm363x-regulator.c           | 1 +
 drivers/regulator/lochnagar-regulator.c        | 1 +
 drivers/regulator/lp3971.c                     | 1 +
 drivers/regulator/lp3972.c                     | 1 +
 drivers/regulator/lp872x.c                     | 1 +
 drivers/regulator/lp873x-regulator.c           | 1 +
 drivers/regulator/lp8755.c                     | 1 +
 drivers/regulator/lp87565-regulator.c          | 1 +
 drivers/regulator/lp8788-buck.c                | 1 +
 drivers/regulator/lp8788-ldo.c                 | 2 ++
 drivers/regulator/ltc3589.c                    | 1 +
 drivers/regulator/ltc3676.c                    | 1 +
 drivers/regulator/max14577-regulator.c         | 1 +
 drivers/regulator/max1586.c                    | 1 +
 drivers/regulator/max20086-regulator.c         | 1 +
 drivers/regulator/max20411-regulator.c         | 1 +
 drivers/regulator/max597x-regulator.c          | 1 +
 drivers/regulator/max77620-regulator.c         | 1 +
 drivers/regulator/max77650-regulator.c         | 1 +
 drivers/regulator/max77686-regulator.c         | 1 +
 drivers/regulator/max77693-regulator.c         | 1 +
 drivers/regulator/max77802-regulator.c         | 1 +
 drivers/regulator/max77826-regulator.c         | 1 +
 drivers/regulator/max8649.c                    | 1 +
 drivers/regulator/max8660.c                    | 1 +
 drivers/regulator/max8893.c                    | 1 +
 drivers/regulator/max8907-regulator.c          | 1 +
 drivers/regulator/max8925-regulator.c          | 1 +
 drivers/regulator/max8952.c                    | 1 +
 drivers/regulator/max8973-regulator.c          | 1 +
 drivers/regulator/max8997-regulator.c          | 1 +
 drivers/regulator/max8998.c                    | 1 +
 drivers/regulator/mc13783-regulator.c          | 1 +
 drivers/regulator/mc13892-regulator.c          | 1 +
 drivers/regulator/mcp16502.c                   | 1 +
 drivers/regulator/mp5416.c                     | 1 +
 drivers/regulator/mp8859.c                     | 1 +
 drivers/regulator/mp886x.c                     | 1 +
 drivers/regulator/mpq7920.c                    | 1 +
 drivers/regulator/mt6311-regulator.c           | 1 +
 drivers/regulator/mt6315-regulator.c           | 1 +
 drivers/regulator/mt6323-regulator.c           | 1 +
 drivers/regulator/mt6331-regulator.c           | 1 +
 drivers/regulator/mt6332-regulator.c           | 1 +
 drivers/regulator/mt6357-regulator.c           | 1 +
 drivers/regulator/mt6358-regulator.c           | 1 +
 drivers/regulator/mt6359-regulator.c           | 1 +
 drivers/regulator/mt6360-regulator.c           | 1 +
 drivers/regulator/mt6370-regulator.c           | 1 +
 drivers/regulator/mt6380-regulator.c           | 1 +
 drivers/regulator/mt6397-regulator.c           | 1 +
 drivers/regulator/mtk-dvfsrc-regulator.c       | 1 +
 drivers/regulator/palmas-regulator.c           | 1 +
 drivers/regulator/pbias-regulator.c            | 1 +
 drivers/regulator/pca9450-regulator.c          | 1 +
 drivers/regulator/pcap-regulator.c             | 1 +
 drivers/regulator/pcf50633-regulator.c         | 1 +
 drivers/regulator/pf8x00-regulator.c           | 1 +
 drivers/regulator/pfuze100-regulator.c         | 1 +
 drivers/regulator/pv88060-regulator.c          | 1 +
 drivers/regulator/pv88080-regulator.c          | 1 +
 drivers/regulator/pv88090-regulator.c          | 1 +
 drivers/regulator/pwm-regulator.c              | 1 +
 drivers/regulator/qcom-labibb-regulator.c      | 1 +
 drivers/regulator/qcom-rpmh-regulator.c        | 1 +
 drivers/regulator/qcom_rpm-regulator.c         | 1 +
 drivers/regulator/qcom_smd-regulator.c         | 1 +
 drivers/regulator/qcom_spmi-regulator.c        | 1 +
 drivers/regulator/qcom_usb_vbus-regulator.c    | 1 +
 drivers/regulator/rc5t583-regulator.c          | 1 +
 drivers/regulator/rk808-regulator.c            | 3 ++-
 drivers/regulator/rn5t618-regulator.c          | 1 +
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 +
 drivers/regulator/rt4801-regulator.c           | 1 +
 drivers/regulator/rt4831-regulator.c           | 1 +
 drivers/regulator/rt5033-regulator.c           | 1 +
 drivers/regulator/rt5120-regulator.c           | 1 +
 drivers/regulator/rt5190a-regulator.c          | 1 +
 drivers/regulator/rt5739.c                     | 1 +
 drivers/regulator/rt5759-regulator.c           | 1 +
 drivers/regulator/rt6160-regulator.c           | 1 +
 drivers/regulator/rt6190-regulator.c           | 1 +
 drivers/regulator/rt6245-regulator.c           | 1 +
 drivers/regulator/rtmv20-regulator.c           | 1 +
 drivers/regulator/rtq2134-regulator.c          | 1 +
 drivers/regulator/rtq6752-regulator.c          | 1 +
 drivers/regulator/s2mpa01.c                    | 1 +
 drivers/regulator/s2mps11.c                    | 1 +
 drivers/regulator/s5m8767.c                    | 1 +
 drivers/regulator/sc2731-regulator.c           | 1 +
 drivers/regulator/sky81452-regulator.c         | 1 +
 drivers/regulator/slg51000-regulator.c         | 1 +
 drivers/regulator/sm5703-regulator.c           | 1 +
 drivers/regulator/stm32-booster.c              | 1 +
 drivers/regulator/stm32-pwr.c                  | 1 +
 drivers/regulator/stm32-vrefbuf.c              | 1 +
 drivers/regulator/stpmic1_regulator.c          | 1 +
 drivers/regulator/stw481x-vmmc.c               | 1 +
 drivers/regulator/sy7636a-regulator.c          | 1 +
 drivers/regulator/sy8106a-regulator.c          | 1 +
 drivers/regulator/sy8824x.c                    | 1 +
 drivers/regulator/sy8827n.c                    | 1 +
 drivers/regulator/ti-abb-regulator.c           | 1 +
 drivers/regulator/tps51632-regulator.c         | 1 +
 drivers/regulator/tps6105x-regulator.c         | 1 +
 drivers/regulator/tps62360-regulator.c         | 1 +
 drivers/regulator/tps6286x-regulator.c         | 1 +
 drivers/regulator/tps65023-regulator.c         | 1 +
 drivers/regulator/tps6507x-regulator.c         | 1 +
 drivers/regulator/tps65086-regulator.c         | 1 +
 drivers/regulator/tps65090-regulator.c         | 1 +
 drivers/regulator/tps65132-regulator.c         | 1 +
 drivers/regulator/tps65217-regulator.c         | 1 +
 drivers/regulator/tps65218-regulator.c         | 1 +
 drivers/regulator/tps65219-regulator.c         | 1 +
 drivers/regulator/tps6524x-regulator.c         | 1 +
 drivers/regulator/tps6586x-regulator.c         | 1 +
 drivers/regulator/tps65910-regulator.c         | 1 +
 drivers/regulator/tps65912-regulator.c         | 1 +
 drivers/regulator/tps68470-regulator.c         | 1 +
 drivers/regulator/twl-regulator.c              | 1 +
 drivers/regulator/twl6030-regulator.c          | 1 +
 drivers/regulator/uniphier-regulator.c         | 1 +
 drivers/regulator/userspace-consumer.c         | 1 +
 drivers/regulator/vctrl-regulator.c            | 1 +
 drivers/regulator/vexpress-regulator.c         | 1 +
 drivers/regulator/virtual.c                    | 1 +
 drivers/regulator/vqmmc-ipq4019-regulator.c    | 1 +
 drivers/regulator/wm831x-dcdc.c                | 4 ++++
 drivers/regulator/wm831x-isink.c               | 1 +
 drivers/regulator/wm831x-ldo.c                 | 3 +++
 drivers/regulator/wm8350-regulator.c           | 1 +
 drivers/regulator/wm8400-regulator.c           | 1 +
 drivers/regulator/wm8994-regulator.c           | 1 +
 178 files changed, 188 insertions(+), 2 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

