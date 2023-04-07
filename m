Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83696DB46E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDGTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDGTtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:49:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79660619F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:49:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o32so24524484wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680896949; x=1683488949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCgc0caK5Xs5U4mf8hkv15BqkAxmIAeXDBU0CENhNDc=;
        b=rUKGrE3p2bH1l4raLAQ/BNRssEKT2AxVAJb/+cyzWyElJs395p3XxjL2KIQQeA2RAN
         EVR9Nj8E7fRbUmKsAbG7LV2GWgbp51TsAs5Ue8p3PgTIpBQzrAR4uYdu1ktcuFAWcXp8
         960Fkq4DSDrA815upLB+lFDDHxW57yQc8vnwFIr0KWvQTiPiQM4SSdmtkuZ5adLUMqy4
         FE3r7vbFchf+GfsYAx7SVWz3psNjdZnczxuJ1UQ92zLn42jMk1ihtBDE4qHDvNgz8Eyc
         05ph+Dx+gljXgW5qNgLPpyGBYiOvFmO7R4N+9EplLUarz91K2kgS7piCrt1Eu5O0sWx4
         vOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896949; x=1683488949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCgc0caK5Xs5U4mf8hkv15BqkAxmIAeXDBU0CENhNDc=;
        b=PCwiJD6ANeH0QfSGqIfrDuF8EKdal6GaVXfhRCxqcqSQxtvaghmGrLNx5Sm3nPO93d
         0loF2fosA52e+hwkFjnRBPgY3sthE1OU4b2QdaVfH5lqcOCrqoxLuEg0/5I/GY/PqLFu
         MiyUeN3q6+5Ie1+jEbplYM066aF+4S2DjGg0dq/rj1fUGvdnSfM2AmcqWDVR56yWtv6l
         KJpuYDID3K/ssuQTJkIcVJh6wzEdRenXiOGyI7wrZ5WvflrhQs6Z1KforfLN24eyNco4
         yoUnNfRTLbXcV6xk6OAMbhdViYoz3/xZiclLPijbFqnwFRe0uoVowFmft9t++7pU/+c4
         x4zQ==
X-Gm-Message-State: AAQBX9cTbcI6vOUOm0ackzxFZFYG+52NtL+AHlBWknVhpoPY1tzzFtUl
        BMylIB7Z2RC09H3hieQgOpwemQ==
X-Google-Smtp-Source: AKy350bDz0Isl09iPEarkNVsV8XNLNdBoTYwZBjBPLzFPfKZzPOGpBUdblklnJSNwvmRsN9F7EpqiA==
X-Received: by 2002:a05:600c:b58:b0:3f0:4428:94fa with SMTP id k24-20020a05600c0b5800b003f0442894famr2114790wmr.26.1680896948695;
        Fri, 07 Apr 2023 12:49:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm9429551wmo.44.2023.04.07.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:49:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v9 0/4] Add MSM8939 SoC support with two devices
Date:   Fri,  7 Apr 2023 20:49:00 +0100
Message-Id: <20230407194905.611461-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V9:
- Fixes name of tsens
  s4 is not present
  s4->s5
  s5->s6
  s6->s7
  s7->s8
  s8->s9
  I erroneously thought the last sensor needed to be brought in but,
  as has been pointed out to me, the last sensor isn't used, so
  no need to support the reading and reassembly of the non-contiguous
  calibration data - Stephan/Dmitry

- pronto/s//wcnss - Stephan

- tulip dr_mode = "otg" not dr_mode = "device"
  I set the value to device for debug purposes but the role-switch
  works just fine and should be upstream - Stephan

- fixed alphabetisation in pm8939-8916.dtsi - bod

Bootable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-04-07-msm8939-nocpr 
Previous: https://lore.kernel.org/linux-arm-msm/20230330153222.2875121-1-bryan.odonoghue@linaro.org/

git diff linux-next-23-03-27-msm8939-nocpr -- arch/arm64/boot/dts/qcom/*39*

V8:
- Addresses all of Stephan's comments from v7
- Moves M4 Aqua display to a separate series
- Retains s4_p1/p2 done on purpose I believe
- Adds Konrad's RB as indicated

Bootable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-03-27-msm8939-nocpr 
Previous: https://lore.kernel.org/lkml/20230223153655.262783-1-bryan.odonoghue@linaro.org/

V7:
- Addresses all of Konrad's asks on V6
- Adds Konrad's RB for patch #3
Bootable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-02-23-msm8939-nocpr
Previous: https://lore.kernel.org/lkml/20230222120411.55197-2-bryan.odonoghue@linaro.org/T/

V6:
- Adds Krzysztof's Ack for Square vendor addition - Krzysztof
- Incorporates all of Stephan's comments from V5, including
  dropping CPR dummy given the dependent patch [1] has been merged, now.

Bootable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-02-21-msm8939-nocpr
Previous: https://lore.kernel.org/lkml/20230206012336.2130341-1-bryan.odonoghue@linaro.org/T/
[1]: https://lore.kernel.org/linux-arm-msm/20230208153913.24436-2-ansuelsmth@gmail.com/

V5:
- Adds Square as a vendor - Krzysztof

- typec_pd: usb-pd@38 - Krzysztof

- Drops gcc clock controller extension. It looks like phy0 actually
  provides a PLL to phy1 for its byte clock. - Bryan, Krzysztof, Stephan

- Adds RB Konrad as indicated - Konrad

- wcnss VDDMX_AO -> VDDMX - Bjorn

- Adds dsi_phy0 as clock-parent to dsi1

- mdss interconnect drops Androidism "register-mem" - Stephan

- cpu power-domain. I've retained the "dummy" cpr reference to
  satiate dtbs_check [1] but renamed &vreg_cpr_stub to remove any confusion
  between now and when we finish off CPR on 8939.

Bootable: https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-02-02-msm8939-nocpr
Previous: https://lore.kernel.org/linux-arm-msm/20230123023127.1186619-1-bryan.odonoghue@linaro.org/
[1] https://lore.kernel.org/linux-arm-msm/20230126150026.14590-1-ansuelsmth@gmail.com/ 

V4:
- Adds Krzysztof's RB to snoc-mm
- Re-orders alphabetically missed nodes in previous iteration - Bjorn
- Adds LK address/size cells comment - Bjorn

- Left _AO for wcnss as downstream reference uses this - Bjorn/Bryan
- Uses qcom,ids.h and QCOM_ID_SOCNAME for qcom,msm-id - Bjorn
- Revises comment from "Regulator" to "Power supply" - Bjorn
- Leaves dummy power-domain reference in cpu defintion as this

- Relabels "cpu" to "CPU" to be more consistent with other dtsi - Bryan
- Moves msm8939 gcc to its own yaml file to capture 8939 specific form - Bryan

  is a required property and the dt checker complains - Stephan/Bryan
- Removes CPR entries from qfprom - Stephan
- Left MDSS interconnects. I don't see a bug to fix here - Stephan/Bryan
- power-domain in MDSS - dropped its not longer required after
  commit a6f033938beb ("dt-bindings: msm: dsi-controller-main: Fix power-domain constraint") - Stephan
- Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
  Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
  GCC_BYTE1_CFG_RCGR : SRC_SEL
  Root Source Select
  000 : cxo
  001 : dsi0_phy_pll_out_byteclk
  010 : GPLL0_OUT_AUX
  011 : gnd
  100 : gnd
  101 : gnd
  110 : gnd
  111 : reserved - Stephan/Bryan

- pm8916_l16 -> pm8916_l6 in dsi definition, typo - Konrad
- Moved regulator_set_load location - Konrad

Previous: https://lore.kernel.org/lkml/20230118050948.bibhq26s6sgzullg@builder.lan/T/
Bootable: https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=linux-next-23-01-23-msm8939-nocpr

V3:
- Happily I don't currently depend on any other series to be merged.
  Bjorn and Chanwoo picked up everything I need to unblock this series. ＼(^o^)／

- Moves xo_board to RPM/PMIC clock gated CXO, not including rpmcc: obvs - Konrad/Bjorn
- qcom,msm-id = <239 0> - left as in V2 valid according to Sony references - bod
- cpu-release-addr - as stated below we rely on lk2nd to take the second cluster
  out of reset - bod
- smem child node update - Konrad
- Whitespace updates - Konrad
- gpu no interconnect - Konrad - No bod
- 19.2 MHz dropped from timer@b020000 - Konrad
- Added vreg_dummy comment - Konrad
- sdc_pins grouped - Konrad
- startup-delay-us = <0> - left as is
- bias - added no-bias - Konrad
- :g/msmgpio/s//tlmm/g - Konrad
- mdss/s//display-controller - Konrad
- l11 set-load - Korad

- l12 upper voltage raised to 3.3v since this is what the
  downstream kernel says when I boot and interrogate it - bod

- sdhc@address - Discussed with Krzysztof and implemented as discussed
- snoc-mm fix - Discussed with Krzysztof implemented if:then:else:not
- dtc -I dtb -fs apq8039-t2.dtb prodcues
  /soc@0/i2c@78b5000: duplicate unit-address
  as does every other component that uses this polymorphic dts node
- Renamed type-c i2c port manager IC to "typec" - Krzysztof

  /smsm/hexagon@1: Missing #address-cells in interrupt provider
  Same output as other upstream and recently upstreamed SoCs
  I left these alone for now

link: https://lore.kernel.org/lkml/20230103010904.3201835-1-bryan.odonoghue@linaro.org/T/
bootable: https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=linux-next-23-01-16-msm8939-nocpr

V2:
- Sorts core dtsi node list by address followed by alpahbetical sorting
  within address sorted nodes - Bjorn
- Drops use of 8916-pins - Bjorn
- Adds msm8939-pm8916.dtsi - Stephan
- Fixes every dts splat from previous submission minus non-converted
  .txt compat strings [1] and one yaml error in Bjorn's tree not in -next yet
- I haven't applied Dmitry's change for tsens since that's not been
  picked up yet
- Picks up a number of suggestions and fixes from Stephan Gerhold and Vincent Knecht

- Depends on

  Applied:
  [PATCH v4 0/7] remoteproc: qcom_q6v5_mss: Add MSM8909 and MSM8953 
  https://lore.kernel.org/linux-arm-msm/167216232800.738877.17567287056128563074.b4-ty@kernel.org/

  [PATCH v6 0/5] remoteproc: qcom: Add support for pronto-v3
  https://lore.kernel.org/linux-arm-msm/167216232801.738877.15895916910585144737.b4-ty@kernel.org/

  [PATCH v6 00/18] mdss-dsi-ctrl binding and dts fixes
  https://lore.kernel.org/linux-arm-msm/167233461766.1099840.17628700245792986354.b4-ty@kernel.org/

  Awaiting application:
  https://lore.kernel.org/linux-arm-msm/20221228133058.213886-1-bryan.odonoghue@linaro.org/

- Previous
  https://lore.kernel.org/linux-arm-msm/20220419010903.3109514-1-bryan.odonoghue@linaro.org/

- Bootable tree
  https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=linux-next-23-01-03-msm8939-no-cpr

- [1] DTC_CHK arch/arm64/boot/dts/qcom/apq8039-t2.dtb

  Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
  qcom/apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible:0: 'qcom,idle-state-spc' is not one of ['arm,idle-state', 'riscv,idle-state']
        From schema: Documentation/devicetree/bindings/cpu/idle-states.yaml
  qcom/apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible: ['qcom,idle-state-spc', 'arm,idle-state'] is too long
        From schema: Documentation/devicetree/bindings/cpu/idle-states.yaml
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /cpus/idle-states/cpu-sleep-0: failed to match any schema with compatible: ['qcom,idle-state-spc', 'arm,idle-state']

  Documentation/devicetree/bindings/iommu/qcom,iommu.txt
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1ef0000: failed to match any schema with compatible: ['qcom,msm8916-iommu', 'qcom,msm-iommu-v1']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1ef0000/iommu-ctx@4000: failed to match any schema with compatible: ['qcom,msm-iommu-v1-ns']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1ef0000/iommu-ctx@5000: failed to match any schema with compatible: ['qcom,msm-iommu-v1-sec']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1f08000: failed to match any schema with compatible: ['qcom,msm8916-iommu', 'qcom,msm-iommu-v1']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1f08000/iommu-ctx@1000: failed to match any schema with compatible: ['qcom,msm-iommu-v1-ns']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/iommu@1f08000/iommu-ctx@2000: failed to match any schema with compatible: ['qcom,msm-iommu-v1-ns']

  arch/arm64/boot/dts/qcom/pm8916.dtsi f5d7bca55425c8
  qcom/apq8039-t2.dtb: pmic@0: 'extcon@1300' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
        From schema: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

  Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/spmi@200f000/pmic@1/audio-codec@f000: failed to match any schema with compatible: ['qcom,pm8916-wcd-analog-codec']

  yaml documentation error not yet in -next
  arm64/boot/dts/qcom/apq8039-t2.dtb: remoteproc@4080000: qcom,halt-regs:0: [33] is too short
        From schema: Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml

  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/usb@78d9000: failed to match any schema with compatible: ['qcom,ci-hdrc']

  Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt:            compatible = "qcom,kpss-acc-v2";
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b088000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b098000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b0a8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b0b8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b188000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b198000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b1a8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']
  arch/arm64/boot/dts/qcom/apq8039-t2.dtb:0:0: /soc@0/clock-controller@b1b8000: failed to match any schema with compatible: ['qcom,kpss-acc-v2']

V1:
This series adds in MSM8939 SoC support with two supported devices.

- CPU
  MSM8939 is a non-PSCI compliant device. As such in the downstreaming
  shipped image custom code is used to bring non-boot cores out of reset.

  This drop specifies the boot-method as spin-table instead and is
  completely standard. To accomplish this, we rely on lk2nd.

  https://github.com/msm8916-mainline/lk2nd/pull/142

- Serial
- i2c
- USB
- eMMC
- MDP/DSI
- WiFi
- Bluetooth

What's not included

- CPR
  We have CPR working in a 4.19 kernel quite well but for now it feels like
  putting the cart before the horse to gate the SoC and boards on CPR.

- Venus
  I've been told this works but I haven't tried it myself and right now
  consider it maybe working but probably not 100%.

- Sound
  We have a copy-exactly from the 4.19 kernel here in the DTS.
  I haven't run the sound through any sort of reasonable test.
  Vincent Knecht has some PostmarketOS kernels which use a 5.17 version of
  this DTS to get sound up so, I think sound is in good shape.

- CAMSS
  There are slight differences between msm8916 and msm8939 for CAMSS. It
  doesn't feel like tons of work but, right now it is work we haven't even
  started.

- Devices
  I've booted on the Square device obviously and this is my regular
  hardware for upstream development. I've also booted on the Sony Xperia M4
  Aqua including mutli-core bring-up, WiFi and ADB.

Dependencies for this drop:

qcom-cpufreq-nvmem: Add msm8939 with some fixups
link: https://lore.kernel.org/linux-arm-msm/20220418162226.2983117-1-bryan.odonoghue@linaro.org/T/#t

Fix apq8016 compat string
link: https://lore.kernel.org/linux-arm-msm/20220418230956.3059563-1-bryan.odonoghue@linaro.org/T/#t

dt-bindings: soc: qcom: smd-rpm: Fix missing MSM8936 compatible
link: https://lore.kernel.org/linux-arm-msm/20220418231857.3061053-1-bryan.odonoghue@linaro.org/T/#u

Bootable tree here:
https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=v5.18-rc2%2bapq8039-without-cpr

Bryan O'Donoghue (3):
  arm64: dts: qcom: Add msm8939 SoC
  arm64: dts: qcom: Add Square apq8039-t2 board
  arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua

Stephan Gerhold (1):
  arm64: dts: qcom: Add msm8939-pm8916.dtsi include

 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/apq8039-t2.dts       |  492 ++++
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi  |   82 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts |  184 ++
 arch/arm64/boot/dts/qcom/msm8939.dtsi         | 2452 +++++++++++++++++
 5 files changed, 3212 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi

-- 
2.39.2

