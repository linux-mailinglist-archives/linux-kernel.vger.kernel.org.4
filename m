Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678B5EDFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiI1PUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiI1PUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:20:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAAA558C9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id a8so20849572lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+AW8Is1FVTDso//LQSgbOHL1fMk2euaPSX4JNKxWqmE=;
        b=PkBVVwPBc/ukSWATfGW4f47280k0JWhj5Oq60rhLuWqSQ7crRaBJGhiBuyCXUnz628
         eBM6jXnKh7zjygxkIW8+gU+OvLeVxexNCa8xDJadVukAebqyJGlzr8N3UEHzwaMwaQyI
         t2Zdq3WrRT7Riz8Y/sNbmjfvw31yfzlnuCxBteJM/D/+xOVZLd6czNDWQ4fp76YBBgrF
         2voisIdVU3NErGEytTsItUC+0HmimUzJkCWdRr3OWfsKtpEej4fepQpquDwaiu2LdTTB
         ni0sK/oXfzmOstty93omDfa+d0+oHw21TV3XBaGFkeEuhphOMZTvmpRjYus4m2jm757+
         973Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+AW8Is1FVTDso//LQSgbOHL1fMk2euaPSX4JNKxWqmE=;
        b=dJRSr1ZvxyOktuzqEvm3WV9Qza7X5NZZSQCZAwvYKmL4Ob3xQiDMim1KqrMTtoBWTO
         WYy5OrQc8WYT+d3In5hi9qRctmcEjMKYQ0LS7h0ixtw8FNzwoIaNiK3EPfzs6z/j30aD
         KLu9ErI76b6+RSE8WiCaXUXPZtfesiTdjSS40pUqXqI3qQeQDaONnzHA+P4A7H8JhtPj
         tbKNd4U2Q9i5CXe8qfZhcMtQTYsgiaQowii0fkm+MTpMQ0ajNDLEt2yJw/XazVPp/bRy
         gHeyeck2ml8JZANaeMS+vUff2UzJr+aWGGTnXJufxYvR6yQuZBTST4xkLqX8FCPqZxef
         SI8A==
X-Gm-Message-State: ACrzQf0RwtvgaUXdmGilSm2oHXXuIr1rRe331138T5dUuNfGYAlYKfcw
        UbKM/AdCc1yUwHsqG6BfIetJVw==
X-Google-Smtp-Source: AMsMyM5YtSktaVdhZs9z/wCj0AI6G8xAEWaPYa5/QuIed9G0+M5ewA4ekcCzfhAvb/UC+7hzod/Ddw==
X-Received: by 2002:a19:5e4f:0:b0:497:aa47:86b8 with SMTP id z15-20020a195e4f000000b00497aa4786b8mr12346955lfi.261.1664378431688;
        Wed, 28 Sep 2022 08:20:31 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b00497a41b3a42sm503023lfq.88.2022.09.28.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:20:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/11] arm64/slimbus/dt-bindings: convert to DT Schema, minor cleanups
Date:   Wed, 28 Sep 2022 17:20:16 +0200
Message-Id: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Hi,

Changes since v1
================
1. Fix commit title typo (Steev).
2. Add Rb/Tb tags.

Dependencies
============
No dependencies. Binding patches are independent from DTS.

Best regards,
Krzysztof

Krzysztof Kozlowski (11):
  arm64: dts: qcom: sdm845: drop unused slimbus properties
  arm64: dts: qcom: msm8996: drop unused slimbus reg-mames
  arm64: dts: qcom: sdm845: correct slimbus children unit addresses
  arm64: dts: qcom: mms8996: correct slimbus children unit addresses
  arm64: dts: qcom: sdm845: drop unused slimbus dmas
  arm64: dts: qcom: msm8996: drop unused slimbus dmas
  arm64: dts: qcom: sdm845: align node names with DT schema
  arm64: dts: qcom: msm8996: align node names with DT schema
  dt-bindings: slimbus: convert bus description to DT schema
  dt-bindings: slimbus: qcom,slim: convert to DT schema
  dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema

 .../devicetree/bindings/slimbus/bus.txt       |  60 ---------
 .../bindings/slimbus/qcom,slim-ngd.yaml       | 120 ++++++++++++++++++
 .../bindings/slimbus/qcom,slim.yaml           |  86 +++++++++++++
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  84 ------------
 .../bindings/slimbus/slim-qcom-ctrl.txt       |  39 ------
 .../devicetree/bindings/slimbus/slimbus.yaml  |  95 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  18 ++-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  16 +--
 8 files changed, 315 insertions(+), 203 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml

-- 
2.34.1

