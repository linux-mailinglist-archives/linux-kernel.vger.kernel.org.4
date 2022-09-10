Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613E5B456C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIJJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIJJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:14:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3055167DF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bt10so6747587lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=MnFJqajPs9w5f0wSrYoTrh6QdL6OalF/XG7fSTrJrsM=;
        b=qEGQSAJ0Y1+A6G7HzR8kqLHxF5qrjFTyfOvB05i+lVHQbXe5GSugzi3ybCXHJKqEIP
         VJPe15RWqRUPEhcDFXZKOModnP6is6ycQRrOqhb6JzUmyzriOM7POX2QWmolnWx2iK6k
         yqd6lAj+dHCSzO+nSl1BT4qvbPkzTO7t9Zyv5ejy585AxhjVfTaqxRK7x1JOQTILiMIq
         /A0svW5ueD32DTuKGQRZwXiM9lmDlvszd0VLC9JVtc1Wx8wdoR4jMP1c/Lmk0klsw7GT
         u92ApASb2ZfXAe9ArYkL64jbRuDZa7sPEMt6usf789GGChiYeln0eepXRjnDGCLxU2im
         xAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=MnFJqajPs9w5f0wSrYoTrh6QdL6OalF/XG7fSTrJrsM=;
        b=jKKuIl62Ph678R1qEtENtEfrAqvogIAq69ZtRYrIl1A77Cu/pYTWLHs0sv5PN1IitY
         IedYCSj5DCswrF7f5nbf/SLpZSzXe+/QcqzWCBEvMCdVhnPxhzRxDWfR6vbpAFYSqyc7
         75EQ+wphHnRBs2kiTwMvziompp4emg5hAdEfRWYVXt+04eX65lRT8l0iz2/lAUY5bbBk
         4uWek8LXxzqjXxDzJg5xFm/6RxHH3yLVIBT36alu1LV9TiR0xDtL5aL9lHQ4arDMBlMD
         A4gmwHpwmC2Jh7NFrbCPE4zph3cgCWxmhvt4GHarzPlTHXxxnsszXuEqzYYO+6XaRTmq
         xE8Q==
X-Gm-Message-State: ACgBeo2B+HooaU2IChM/WzexZcRK3bSPE9IWGNx7j2W2ytKkz3sVK6p5
        qvFUCZqvkGRthw9gjMUKAWw6LQ==
X-Google-Smtp-Source: AA6agR7rvJSireVLEoJSasVipDhF0WWaCEg/d89wEbc83LWJO0cFxfvR1RYvLyQYSOsDVa+/rrGoFg==
X-Received: by 2002:a05:6512:3292:b0:497:e864:d913 with SMTP id p18-20020a056512329200b00497e864d913mr4550224lfe.132.1662801276977;
        Sat, 10 Sep 2022 02:14:36 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a19e016000000b0048b26d4bb64sm201552lfg.40.2022.09.10.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 02:14:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 00/15] ASoC/qcom/arm64: Qualcomm ADSP DTS and binding fixes
Date:   Sat, 10 Sep 2022 11:14:13 +0200
Message-Id: <20220910091428.50418-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependencies/merging
====================
1. The DTS patches are independent.
2. The binding patches should come together, because of context changes. Could
   be one of: Qualcomm SoC, ASoC or DT tree.

Changes since v3
================
1. Patch 9-10: re-order, so first apr.yaml is corrected and then we convert to
   DT schema. This makes patchset fully bisectable in expense of changing the same
   lines twice.
2. Patch 11: New patch.

Changes since v2
================
1. Patch 9: rename and extend commit msg.
2. Add Rb tags.

Changes since v1
================
1. Patch 9: New patch.
2. Patch 10: Correct also sound/qcom,q6apm-dai.yaml (Rob).
2. Patch 13: New patch.
3. Add Rb/Tb tags.

Best regards,
Krzysztof

Krzysztof Kozlowski (15):
  arm64: dts: qcom: sdm630: align APR services node names with dtschema
  arm64: dts: qcom: sdm845: align APR services node names with dtschema
  arm64: dts: qcom: sm8250: align APR services node names with dtschema
  arm64: dts: qcom: msm8996: fix APR services nodes
  arm64: dts: qcom: sdm845: align dai node names with dtschema
  arm64: dts: qcom: msm8996: align dai node names with dtschema
  arm64: dts: qcom: qrb5165-rb5: align dai node names with dtschema
  arm64: dts: qcom: sm8250: use generic name for LPASS clock controller
  dt-bindings: soc: qcom: apr: correct service children
  ASoC: dt-bindings: qcom,q6asm: convert to dtschema
  ASoC: dt-bindings: qcom,q6adm: convert to dtschema
  ASoC: dt-bindings: qcom,q6dsp-lpass-ports: cleanup example
  ASoC: dt-bindings: qcom,q6dsp-lpass-clocks: cleanup example
  ASoC: dt-bindings: qcom,q6apm-dai: adjust indentation in example
  dt-bindings: soc: qcom: apr: add missing properties

 .../bindings/soc/qcom/qcom,apr.yaml           | 112 ++++++++++++++++--
 .../bindings/sound/qcom,q6adm-routing.yaml    |  52 ++++++++
 .../devicetree/bindings/sound/qcom,q6adm.txt  |  39 ------
 .../bindings/sound/qcom,q6apm-dai.yaml        |  21 ++--
 .../bindings/sound/qcom,q6asm-dais.yaml       | 112 ++++++++++++++++++
 .../devicetree/bindings/sound/qcom,q6asm.txt  |  70 -----------
 .../sound/qcom,q6dsp-lpass-clocks.yaml        |  36 +++---
 .../sound/qcom,q6dsp-lpass-ports.yaml         |  64 +++++-----
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  10 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |   4 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |   8 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |   2 +-
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   8 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +-
 16 files changed, 346 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt

-- 
2.34.1

