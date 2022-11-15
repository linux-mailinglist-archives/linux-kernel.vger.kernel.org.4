Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9862957D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiKOKNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiKOKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:13:24 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409224F26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:12:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso12737349wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=HYUPzUV+S9Fy+mYwzh6CSP3umqa+7In6uixG2u9bF/E=;
        b=a0+qfMKXjIvovlIGHjkV1WfW7ga7PZy0Eqh9MfJis5SerHAAdrfO/Ln3EtAEoo5TOA
         NQb7EA5x5abu8j73no53C9tyB4hAw0HJBzCNTCZfLloLil87NNOiG+wXo6CiMEIwFCZ/
         FwbNptzJsJUShD3S+B6D6PWEBtDIP/d8ftIhU5qqlMnOSiaR9vtbrnhmUJ8xoRe9rU7x
         xiJTFkXDspL5NEyspZtI7Y9/ZVHGLzpU2jVUTg86Pz+ma1hog9R/WXgxyg4p3xoP+Duu
         kSBpMX1LF5nd3+hWLuux0lCHjIqyHdm0Tsa2kSlD7gdAqf8eR2qjpQ6O9KdswyQyOwrT
         v0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYUPzUV+S9Fy+mYwzh6CSP3umqa+7In6uixG2u9bF/E=;
        b=ci+Hg5T45Yi0Kw8a6szfujKqWc43hnJkg83RDUAdR/4p/LXicFoIIQKv4FdHn17O/6
         H/wg5FeDLB2U6ydH31cblApOLXUkBZ0EZaHS85Qj6QYuReVDoi17Ty4jBj1z2sfq3/Yu
         RMWjkh0rEygu6IBtlyiO79YerGUimsOp8iwWfAVjPLXAHNo3A9cEzzIVCoyyG6Wr1Aob
         tbwD2lu7HCIeRcXlBe/jnLMjEGdYfEArVbEHIkvOrzwXWISFDUOP6KLrrz2qu4CAU1/d
         /5LDp/mvEhgqqKnYxHcKX9pQgJITYI+Oht0YxFthE3/GFabnBuduW9BjuCrdyJykIS38
         Vu1w==
X-Gm-Message-State: ANoB5plDAXsW4K0cypgxZJEGRVqXvjd6iKHkVX2Gk7QRm3Mv1pjzUiwt
        fUqBmM16TFHeatQqR/1aaLUIvA==
X-Google-Smtp-Source: AA0mqf6cqFMpLe4sdsSvweZOEAkruMlMvbfcomg5LEJX/mo3qjW1mryzLkhdNwpXKrX1k455qG5wHg==
X-Received: by 2002:a7b:cb89:0:b0:3cf:8a44:e1eb with SMTP id m9-20020a7bcb89000000b003cf8a44e1ebmr891215wmi.189.1668507157277;
        Tue, 15 Nov 2022 02:12:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003b492753826sm15165154wmb.43.2022.11.15.02.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:12:36 -0800 (PST)
Subject: [PATCH v4 0/2] arm: qcom: mdm9615: second round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIABJmc2MC/43NTQrCMBAF4KtI1kYmv1pX3kNcTNPRBtJUEi1I6d0d3IkLuxreg/fNLCqVSFUcN7
 MoNMUax8zBbjci9JhvJGPHWWjQWgE4OXRD45WT95jDoyT5wiFJZa4uqAPazqDgaYuVZFswh57H+ZkS
 l32sj7G8Pq8mxef8R52UBAmhDQCeNBo4pZixjLux3MSFxUmvUTQr3jRX8nsE29KPYtYohhVyBNZ5a5 u9+lKWZXkDb0ygeUoBAAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 15 Nov 2022 11:12:34 +0100
Message-Id: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a second round of bindings & DT fixes for the MDM9615 platform.

This second round focuses on less trivial changes like pinctrl & regulators bindings,
the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.

Dependencies: None

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Removed applied patches
- Removed "-ipc" from bindings file name and removed IPC from title & description
- Added the review tags from v3 after file renaming & title/description change, after Lee's acceptation
- Link to v3: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org

Changes in v3:
- Path 1: Removed from serie because applied
- Path 2: None
- Path 3: Added reviewed-by tag
- Path 4: Fixed dt-schema title and added unevaluatedProperties
- Path 5: Various schema fixes, uses same naming as other dt-schema for qcom regulators
- New patch added changing regulators names of msm8660 to conform to bindings
- Link to v2: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org

Changes in v2:
- Rebased on v6.1-rc1
- Patch 1: Fixed bindings and aligned with Krysztof's series
- Patch 2: Rewrote patch title and added reviewed-by tag
- Patch 3: Added reviewed-by tag
- Patch 4: Moved to end, added support for (regulators|-regulators) sudnode
- Patch 5: Fixed schema description and added missing unevaluatedProperties in patternProperties
- Patch 6: Dropped & squashed with patch 4
- Link to v1: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org

---
Neil Armstrong (2):
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 ++++++++++
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 101 ++++++++
 3 files changed, 229 insertions(+), 283 deletions(-)
---
base-commit: 19d64985796125c5e3820c3db995c5df6d13d6dc
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
