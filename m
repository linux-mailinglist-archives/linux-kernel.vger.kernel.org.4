Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E00600B44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiJQJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C917B4F38D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u10so17619077wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=O+n1ShhbA3PkDMv6oI8//0dSStEO0rpZ1E2GZxrwNJ8=;
        b=HzCBvEHKjBcVmbQFOvVkERzzPABe7O7NENhDfrw0HMRw6qyH06kygUDFtLeJyHm2Aq
         QF1IQIiIZ3FXmdMUKUreeqV8oX4IJ4TGTvWOTxtuazqx8oqMWpjIdO97IVlcULLhwewT
         k1prn+CrKXDt7xI9vPmBoru4G3jgBsJG0v0NCYX/XAGh7OCNUw4IVpncfcVhKohVVlMH
         IBX+m4vqdjXEQ0Frt/bG+Zv1rUZpf5qHDS+xXWT0WcF6MRv6HABab0u7E+2a3Cn7GnM4
         yaBDa+tv2183b0NJkoX2CEQgRB1brnBeOyxWDJGu3JmxODXPkHXnkT26aORgZVVlZy1+
         12LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+n1ShhbA3PkDMv6oI8//0dSStEO0rpZ1E2GZxrwNJ8=;
        b=YRsOZJPpfavPPScqhcT6Tz9LeXCuvl76TLxLTUjYDhNRWjyn1hOz67HhKzqtlIu0Ly
         AjhVi92zwRejuFX1DcyEpkPbRlBcVhK3sgThsImN0Xet1EWBtPPt9L0FCFYLWHzfaHge
         vy+8oNC69UxKK7CzlAgcJkotBWJZ7ykFPCRwoeFjMW4Khi1LpDTbSaw/LTtNZrHOLfwM
         m7fPu7K/NicFkja9dvJLnBEPBsq/IxyKK7XJ1rjU74zjjkxeFFgXPhfaPJ4OeWFnzWVN
         HnfslJEKUXxUP1Xfq8zULS2LFO2HeOc6FxRu9oBrbwCr4MywB1WM3L99zMJ/NCylH0ET
         aAdw==
X-Gm-Message-State: ACrzQf3GR3Qg0uSAbO3zTO5dIJzRbGqpXTMBHfF5kWSMx+ZJNlv+HWW5
        vzWidc6sXxlRSgX5gLc3z7d8PA==
X-Google-Smtp-Source: AMsMyM7YAZPUOp3/N4bb1ClCSRlKmQTiZXyMsVlV7C8McCl56kkVkE6PGiXgXZnx+PnQ8yoCFcTByA==
X-Received: by 2002:a5d:408e:0:b0:22e:650a:ec4b with SMTP id o14-20020a5d408e000000b0022e650aec4bmr5866330wrp.212.1665999929194;
        Mon, 17 Oct 2022 02:45:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:28 -0700 (PDT)
Subject: [PATCH v3 00/11] arm: qcom: mdm9615: first round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIADUkTWMC/43NTQrDIBAF4KsE152iJtGkq96jdOHPJAqJgqbSEnL3SnddtavhPXjf7CRj8pjJpd
 lJwuKzj6GG9tQQ41SYEbytmXDKOR35AKtdR8F6sBtk43BVMPknZhDCdpYao6WRpK61ygg6qWBc3YfH
 stTS+bzF9Pp8K6ye22+4MKCgBYpWSTsxHK6LDyrFc0wzuVe08D8hXqFBThp1p5D27Rd0HMcbg3sd4A 0BAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:25 +0200
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first round of trivial bindings & DT fixes for the MDM9615 platform.

This first round focuses on trivial changes, the remaining work will
mainly be .txt to .yaml transition of old qcom pmic & co device bindings.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
To: Satya Priya <quic_c_skakit@quicinc.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-rtc@vger.kernel.org
Dependencies: None
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Rebased on v6.1-rc1
- patch 1: Added reviewed-by tag
- patch 2: Fixes typo in commit msg and added precision about why MIT was selected
- patch 3: Added reviewed-by tag
- patch 4: None
- patch 5: Drop second example node
- patch 6: Drop Andy, fix interrupts desc and fix example indentation
- patch 7: Fix commit msg wrap & add reviewed-by tag
- patch 8: Reword commit msg & add reviewed-by tag
- patch 9: Reword commit msg & add reviewed-by tag
- patch 10: None
- patch 11: Added reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org

Changes in v2:
- patch 1: switch to move from swir.txt to qcom.yaml
- patch 2: use MIT licence instead of X11 licence
- patch 3: move reg after compatible
- patch 4: added Krzysztof's review
- patch 5: split into 5 changes:
  - document qcom,pm8921 as fallback of qcom,pm8018
  - convert qcom,pm8921-pwrkey to dt-schema
  - document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
  - drop unused PM8018 compatible
  - drop unused pm8018 RTC compatible
- patch 6: None
- patch 7: Reworded commit log based on Dmitry's wording on similar patches
- Link to v1: https://lore.kernel.org/r/20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org

---
Neil Armstrong (11):
      dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board documentation to qcom.yaml
      arm: dts: qcom: mdm9615*: add SPDX-License-Identifier
      arm: dts: qcom: mdm9615: add missing reg in cpu@0 node
      arm: dts: qcom: mdm9615: remove invalid spi-max-frequency gsbi3_spi node
      dt-bindings: mfd: qcom-pm8xxx: document qcom,pm8921 as fallback of qcom,pm8018
      dt-bindings: input: qcom,pm8921-pwrkey: convert to dt-schema
      dt-bindings: rtc: qcom-pm8xxx: document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
      mfd: qcom-pm8xxx: drop unused PM8018 compatible
      rtc: pm8xxx: drop unused pm8018 compatible
      arm: dts: qcom: mdm9615: remove invalid interrupt-names from pl18x mmc nodes
      arm: dts: qcom: mdm9615: remove useless amba subnode

 Documentation/devicetree/bindings/arm/qcom.yaml    |   6 +
 Documentation/devicetree/bindings/arm/swir.txt     |  12 --
 .../bindings/input/qcom,pm8921-pwrkey.yaml         |  75 +++++++++++++
 .../bindings/input/qcom,pm8xxx-pwrkey.txt          |  46 --------
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  33 +++++-
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  16 ++-
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  39 +------
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |  39 +------
 arch/arm/boot/dts/qcom-mdm9615.dtsi                | 121 +++++++--------------
 drivers/mfd/qcom-pm8xxx.c                          |   1 -
 drivers/rtc/rtc-pm8xxx.c                           |   1 -
 11 files changed, 159 insertions(+), 230 deletions(-)
---
base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
change-id: 20220928-mdm9615-dt-schema-fixes-66d4d0ccb7c7

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
