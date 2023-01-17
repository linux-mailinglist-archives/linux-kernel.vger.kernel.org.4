Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B278966D49E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjAQCwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjAQCwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:52:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CE2CC4C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q8so9414531wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dHRXjMJSDxHRu7emKOz4UI6MQ5VAk52HN19c5JOeWo=;
        b=C5uC5ywR4oirsJCMssBCz7KIb9aZCxRSPmDZY1x5aFltu1gE3NzEKlDxWHmoW8Jzmu
         cHqlO0WxIFbGp5icZiKkuQX2U+Xg2oxPzIjjsBNCULFk+7Ith/mCBQmlFfzk+sJmTCds
         0nVKBkXvcHGiXkgQS1RoBK2y9ItQc2E0HIqNcCtHKPB0mY41P7pi9ad93vxZM4lfmuKo
         KSi6D9kuUWGEl/FV5ORDis4x1j/UyV25kCBkhTL/QmUyd6AKjzRgZE3oBhxvU/xMeFSf
         5Yqgq6u7zNb04NyRpUlojsTExAFdp4lRuE2pc1zx4/S9FJ+yPR0tCoDMSPtb1K3QkymY
         8U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dHRXjMJSDxHRu7emKOz4UI6MQ5VAk52HN19c5JOeWo=;
        b=ItrbnrDkr/31PcMEesR1evcmqouASAXv5HZl7SqEAqqM/4PYK7wAkOJI6tGiiQ9XH+
         nsj+BJ7ebTOQrL/UdbWmAd3Cns8x/mHSdK55qPrGBUx2RJsoxxiBpjl2AEpdcg4NY5HL
         YkZ+y3nE7iZFOeLzE3xEC2BnCbk+EyMlLAGhgu0BVuA8OHwo/kfQU/YxS7Wwy0MUoRsk
         3xgPHxHRW6mc8wkxR/6mQZ96AU6lKWPNmlKFk9uP5Knhyc1a8RwyOFFuBoxjhsNTtqpz
         5yUz3T7xcwWvhzNhMcoteaXoZDELPSki8HgNJgEcBRkGMo6NQc2MpAfRiZSIVmcarAbC
         iCaw==
X-Gm-Message-State: AFqh2koA77GHEej2Tlt53+coL09vZfZARKEfEmXj+cGyg5mOvjWjuLBb
        hdoZtfBcx060F2XhqoZBVzZ54Q==
X-Google-Smtp-Source: AMrXdXsF8DbHOktw2O7UU6ZEErXwdFci+66NVZbO9GBuHcqJyjoNSe101Eh2FnFQ2NIzH7de4Sr1og==
X-Received: by 2002:a05:600c:1e15:b0:3da:acb1:2f09 with SMTP id ay21-20020a05600c1e1500b003daacb12f09mr8334545wmb.19.1673923729622;
        Mon, 16 Jan 2023 18:48:49 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6bd12ac27sm39482660wmq.37.2023.01.16.18.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:48:49 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v3 0/8] Add MSM8939 SoC support with two devices
Date:   Tue, 17 Jan 2023 02:48:38 +0000
Message-Id: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Bryan O'Donoghue (7):
  dt-bindings: arm: qcom: Document MSM8939 SoC binding
  dt-bindings: soc: qcom: smd-rpm: Exclude MSM8936 from glink-channels
  dt-bindings: interconnect: Exclude all non msm8939 from snoc-mm
  clk: qcom: smd-rpm: msm8936: Add PMIC gated RPM_SMD_XO_*
  arm64: dts: qcom: Add msm8939 SoC
  arm64: dts: qcom: Add Square apq8039-t2 board
  arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua

Stephan Gerhold (1):
  arm64: dts: qcom: Add msm8939-pm8916.dtsi include

 .../devicetree/bindings/arm/qcom.yaml         |    8 +
 .../bindings/interconnect/qcom,rpm.yaml       |   73 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/apq8039-t2.dts       |  555 ++++
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi  |   82 +
 .../qcom/msm8939-sony-xperia-kanuti-tulip.dts |  466 ++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi         | 2393 +++++++++++++++++
 drivers/clk/qcom/clk-smd-rpm.c                |    2 +
 9 files changed, 3551 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi

-- 
2.38.1

