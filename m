Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC15607379
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJUJJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJUJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:08:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1D1A3E09
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:08:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1540785wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=rjuKSGV50wTNMTGg13pBdWijHuHSlBBgwS9gcRtk9h4=;
        b=HD23P+1/uGFBYkEyS+rdMW0i4V8LCgolsxrEDB6++mLvwlfpyqkIkwoYGwUz1UkQZW
         +Mme4JOWml98FLAU0wAFGspagU8CqS7FjOWZGFMSkSfrlh32ITc3hRfF79HjRiWJt/7/
         WRFFypPzagOQrxJc2qHTbFtb4BBKxlncOM9IRdJ0E3qa8/L/vuw37N1CwABbJo8yyq2k
         IwQ3sIS7k2Uo9AN48fnyijrqq6wSkwgjPlfUFWmghJDlpS2RiZlE+eoyxg/mYZLOvJ/+
         2+GGR3YrxcnvGzsh3Z/FiAX0w1T1p63TTVSCztFpABBCJr9u36Izq1kPJ46rrpap6yGB
         o53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjuKSGV50wTNMTGg13pBdWijHuHSlBBgwS9gcRtk9h4=;
        b=BaxWYMfSuGeVKzw+yrxq080p8ZC2FgaCtdwrf1/EjkLzhssibo9TmpQ84Unlhsg0W1
         7dGRr3k7OPNrYT3GRAAP2HUtsQNTYTo9vWoIGVs/5cS5stlE9AguXcm94xF79Neu/CzF
         ie15U1YyNisEeDxWQ2xzWnf75uSsD25K5stlbCR+ckbts0XPXGaaSs31tTVxcb4G9Gnu
         J//czcYVpgbJYEmsFVIBXWylq2MEh2kyElF5BXt6iuG/yGdQo6HfsjM8/L8wGTae57jc
         SWPIfIw1VBZNK4p3tY1PUP48XUQ6jQf/A4ve4QUuw8g91aVvc0wOG2LxkCU1MIvzyCXX
         DdWA==
X-Gm-Message-State: ACrzQf2yAkEWc4zwUqFewxngoQfqtGgx/TvMwfWoch7f4kxMCHbkv8OS
        +wE/X/Z5Fdetdq2B9XoFAArgxg==
X-Google-Smtp-Source: AMsMyM6bIFqppyQVJfbAz5vhEyejiuXMtlNwdPV+afz+Cg7hK1XpWReSLStbAczvDnPcqTKn5Jh74Q==
X-Received: by 2002:a05:600c:3384:b0:3c6:f25a:96e9 with SMTP id o4-20020a05600c338400b003c6f25a96e9mr20487867wmp.112.1666343328648;
        Fri, 21 Oct 2022 02:08:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003c6f27d275dsm2230286wmn.33.2022.10.21.02.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:08:48 -0700 (PDT)
Subject: [PATCH v4 00/11] arm: qcom: mdm9615: first round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABxhUmMC/43NywrCMBAF0F8pWTuSR5O2rvwPcZHHtA20KSRaFOm/O7gTF3Y13Av3zIsVzBELO1
 UvlnGNJS6JQn2omB9tGhBioMwkl5J3soU5zJ0RGsINih9xttDHBxYwJtSBe+8a3zBaO1sQXLbJj7RP
 92micozltuTn59sq6Fz+w6sADs6gUbYJvcD2PMVk83Jc8sCuhK5yJyQJapveoastcq1+ILUTUgRpJY LVWnql6y9o27Y3tggEz1YBAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 21 Oct 2022 11:06:36 +0200
Message-Id: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Changes in v4:
- patch 1: None
- patch 2: None
- patch 3: None
- patch 4: None
- patch 5: Added reviewed-by tag
- patch 6: Fix descriptions, Added reviewed-by tags
- patch 7: None
- patch 8: None
- patch 9: Added acked-by tag
- patch 10: None
- patch 11: None
- Link to v3: https://lore.kernel.org/r/20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org

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
