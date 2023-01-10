Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8E664B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjAJSjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjAJShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:37:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6394C983FC;
        Tue, 10 Jan 2023 10:33:08 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso10826643wmq.1;
        Tue, 10 Jan 2023 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl8lBWv7buHCR9gMhXnIz+zvhX/T9gnX9dlIEfcocLw=;
        b=Q/skHsxHvgm7rQBUYu43CLugTzLuL2JZiUMS8bMUgbf923x73PqUYoUrp/NHYPlIsi
         HnItvWvSWaT/XxaSu2tvlfu3oWv+IQ3kXKsN7yCTYBfZjYC0VBc8AYy8HNv066Dg27f+
         rElNAh8n4wbS7vPFXSLOOJ0R7M9PUWG+j7U1shlXkfAoGJ7VQJxpB94V8Bt8VUwOGutk
         iE81B4UzjgFBDt8Jq+PUs35UxRvEA9nCxFV4bIG//Gv8rhrhEMVXqgjzU1iU6oH82V5T
         RTzutAAkjyvT+nud1DzpCK7ho1vcw92FABtrUCcZJZZkU3Cmp06UJXaXn2T8/s2ZsbvW
         A9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl8lBWv7buHCR9gMhXnIz+zvhX/T9gnX9dlIEfcocLw=;
        b=r4nGDtvTeCIArQ9IxM785s8sPDd8WI2EgAVLTRaObUIzJSAML1xNyMw/mGrtUuBQdt
         vFM3f9ko+nGipLvgA5BhdxDq+ycPv2rEdTQh85JEwHHRGR2XaGbXnN8Sq7C2Dye4sSrF
         HAPQJq3/djzs9R8i83JSUfFAQD4+ggefODm2uxreYPHkmRczW6IxIsGaHHpm3HDVFSZ+
         D3Xv+te5DPVmMHrvXneEk6cT7WIssp4iygj8s68hOJuSiMu/QsXUXHH1JP7QAPDV4hXU
         nKlDFmvMhck+wThrqDB53KaHx7oB/mSfcJHuHJOc/7+X9LlpVQg8IA+jLuDQ+LdbrK2S
         BHDA==
X-Gm-Message-State: AFqh2koYS0QOiSO3/sPnVIZhJrhwMd6upabi2zQzdzxy/aWk/RST9zrB
        6rnaqEFIKnBFufOWVNEPNFs=
X-Google-Smtp-Source: AMrXdXsvLt9GmGGCOdUU1CprDUR8igLSAF5NW8gfxnfeVYmBc5QMjCvtZSfPmkdrDzu/cSiBrLrQlQ==
X-Received: by 2002:a05:600c:3d12:b0:3d2:392b:3165 with SMTP id bh18-20020a05600c3d1200b003d2392b3165mr49651677wmb.12.1673375586760;
        Tue, 10 Jan 2023 10:33:06 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm19927757wmr.21.2023.01.10.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:06 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 0/6] Krait Documentation conversion
Date:   Tue, 10 Jan 2023 19:32:53 +0100
Message-Id: <20230110183259.19142-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series convert the krait-cc and the kpps-acc/gcc Documentation to
yaml.

This series comes form a split of a bigger series that got too big and
now hard to review.

While they are still more or less wrong and doesn't really reflect real
driver implementation, they are converted to prepare for a fixup later
when dts and driver are finally fixed.

Minor changes are done to the kpss-gcc driver and minor fixes are done to
the various affected dts to fix dtbs_check warning with the new introduced
schema.

Also fix kpss-acc dtbs_check warning.

v6:
- Split kpss-acc to separate v1 and v2 schema (thing changed from
  simple clock controller to a power domain in later SoCs)
- Fix whitespace error (extra new line at the end of the file)
- rebase on top of linux-next/master
v5:
- rebase on top of linux-next/master
v4:
- Fix error from kpss-acc schema
- Fix dtbs_check warning from kpss-acc
- Improve kpss-gcc for apq8064
v3:
- Update all Sob
- Rework kpss-gcc Documentation with the new finding
- Fix dtbs_check warning
v2:
- Fix bot error by adding missing #clock-cells

Changelog for previous series "Modernize rest of the krait drivers"
that was split to smaller series (only Documentation changes):
v7:
- Rework kpss-gcc Documentation (split patch for pure conversion and
  tweaks)
v6:
- Address comments from Rob
- Fix warning from make dtbs_check
v5:
- Address comments from Krzysztof
v4:
- Fix more dt-bindings bug errors
v3:
- Split Documentation files for kpss and krait-cc
v2:
- fix missing new line on patch 16 (krait-cc patch)

Christian Marangi (6):
  dt-bindings: clock: Convert qcom,krait-cc to yaml
  dt-bindings: arm: msm: Convert and split kpss-acc driver Documentation
    to yaml
  dt-bindings: arm: msm: Rework kpss-gcc driver Documentation to yaml
  ARM: dts: qcom: fix various wrong definition for kpss-gcc node
  ARM: dts: qcom: fix various wrong definition for kpss-acc-v1
  ARM: dts: qcom: fix various wrong definition for kpss-acc-v2

 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -----------
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ----------
 .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++
 .../bindings/clock/qcom,kpss-gcc.yaml         | 88 +++++++++++++++++++
 .../bindings/clock/qcom,krait-cc.txt          | 34 -------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++
 .../bindings/power/qcom,kpss-acc-v2.yaml      | 47 ++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi           | 21 ++++-
 arch/arm/boot/dts/qcom-apq8084.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           | 12 ++-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi           | 13 ++-
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 12 ++-
 15 files changed, 334 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
 create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml

-- 
2.37.2

