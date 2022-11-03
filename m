Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B8617A57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiKCJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:58:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37E1098
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:58:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so1441644plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FblFuHeX62O54gDte9P0+RFishu5673s8IE4V3s7Dek=;
        b=fQ/Bijpbz3QnQ6t7UgDN/8gHpBG5kkdUczACNrcYD2MInKuesA/4z5R1+cAVIU/dqo
         aCJXdDlbKNQTr0mni0dzEViSJOMwRURg4f4HxCHZs4vtCGCLB/nnwPq1fIU40OVArKqu
         kO0GmvHbLaMYyzcPaoNKb6ovb5hvvyfKZNuyPAI/Z7LcfbPxvZxTLTjk2+53Z5TmGh3R
         Z5TurYqhFb77aF+myL18WIrLtvHlkyorKbXMFIhB+H7mWpkC9Eh9cAStzoJc8xuRwKMK
         34NfI/zO2/EjqwZWL7aIp1bm3ke2B0ArEbWK02DuggGfSqfSRSP0+IzbHvOyfuKN+Fa2
         GCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FblFuHeX62O54gDte9P0+RFishu5673s8IE4V3s7Dek=;
        b=lMnooxZgyBSsq8t9o0ru3bhUHkbBUMhi/xsY6vL77KzbwduLUiH6oQksZ14BVO9Jjf
         b7eBnctRc16bCuZXans/E6Ry6svUBu6BtXOZ0EylGFVWC7mY0eiJUH7Gw50uIpB+bWTS
         C82SKf3z5nALwQCIJ08TNUuqFg5Kx9NQCb8N0wXCRojxZxgaxSAipJmXwOjkbraMe5uP
         2rNJq3lf1+ra7Tmw/9TVDPC4sgxpFCR9w0wCfXrE8/oPZ/dKd22djpd6X1rSrfPi9reC
         VBYbJKsclzScOK8zeMRQFmNH+FgHnknJAhpViAtslfC2PeUOX7nNqZ5+cfXj1En/7Yed
         XWkg==
X-Gm-Message-State: ACrzQf1AqxBUVgBaq9W8xBMfgPSzhnO/U/xTAE5tNbP8KM4JTXi9Qsa/
        ziyyzEqaFoDDKunR8D5isP6JGhkWzG+a
X-Google-Smtp-Source: AMsMyM5VVQeEhBGZzXmlQGDmk7tapy7IRVyUm5w6rqKsuXwgBueFhXsgiMcHmMGtKLxqF4BGbWwHRA==
X-Received: by 2002:a17:902:690a:b0:17a:32d:7acc with SMTP id j10-20020a170902690a00b0017a032d7accmr29703452plk.18.1667469502831;
        Thu, 03 Nov 2022 02:58:22 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b00186c54188b4sm161670plf.240.2022.11.03.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:58:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 00/12] sc8280xp-pmic updates and X13s thermal zone support
Date:   Thu,  3 Nov 2022 15:27:58 +0530
Message-Id: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds below updates to sc8280xp-pmics:

PM8280_{1/2}:
- Temp alarm
- Thermal zones
- VADC channels
- ADC_TM5 channels

PMK8280:
- ADC7 block
- VADC channels
- TM5 block

PMR735A:
- VADC channels

Also adds the thermal zone support to Lenovo X13s based on the thermistor
SYS_THERM6 that provides the laptop skin temperature.

The sc8280xp-pmics is based on the new PMIC7 architecture. In this, all the
ADC/TM5 measurements are collected by the primary PMIC PMK8280 from other
slave PMICs PM8280_{1/2}, PMR735A using the Programmable Boot Sequence (PBS)
and exposed them over the individual channels.

PMK8280 uses the Slave ID (SID) for identifying each slave PMICs in a system.
This ID is not static for each PMIC but rather set for each platform by the
hardware designers. So this series allows the configurable SID by modifying the
binding to accept SID values instead of hardcoding them.

This series is tested on Lenovo X13s laptop by monitoring the temperature of
the 8 on-board thermistors through IIO interface. The thermal zone support is
validated by adding loads to the CPUs and making sure the skin temperature stays
below the threshold provided in DT.

NOTE: This series requires fwnode support to QCOM_SPMI_ADC5 driver [1] for making
use of the full node name for IIO channels. Since the support is already in
mainline, it should just work. But for older kernels, the IIO channels and
thus the SPMI_ADC5 driver will fail to probe.

Thanks,
Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/iio/adc/qcom-spmi-adc5.c?id=4f47a236a23d9f18d018a2f6639daad476d2a3f2

Changes in v4:

* Got rid of "label" properties from ADC nodes and used common node names. The
  ADC5 driver in mainline now uses the full node name for registering the IIO
  channels. So "label" or unique node name is not required.

Changes in v3:

* Used thermistor index in node names for VADC channels. This is required by IIO
* Collected reviews
* Rearranged the dt properties (Konrad)

Changes in v2:

* Fixed issues reported by Krzysztof and "make dtbs_check"
* Collected reviews from Krzysztof
* Added the Lenovo X13s thermal zone patch

Manivannan Sadhasivam (12):
  dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for channels
  arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2}
    PMICs
  arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/2}
    PMICs
  arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN input
  arm64: dts: qcom: sc8280xp-pmics: Add PMK8280 ADC7 block
  arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK8280
  arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
  arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
  arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} VADC channels
  arm64: dts: qcom: sc8280xp-x13s: Add PMR735A VADC channel
  arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} ADC_TM5 channels
  arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 199 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  84 ++++++++
 .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   |  90 ++++----
 4 files changed, 329 insertions(+), 50 deletions(-)

-- 
2.25.1

