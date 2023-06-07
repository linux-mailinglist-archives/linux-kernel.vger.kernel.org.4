Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F7A725BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbjFGKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjFGKsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:48:13 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C051C10EC;
        Wed,  7 Jun 2023 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Reply-To:
        Content-ID:Content-Description;
        bh=l/zVS58cvAcEWC+l4J5gkSm4eGpLkpBXWoGcuN8ztvU=; b=oXe6aY4Ltjr9nd5GOoBRHVqWCA
        ekpw4HVFlN4iDZgHRHIqOJ8WXWQMyH4DXEMjMTaCM67+GDv4AbDydFRzM5XiclHtRxZuHw+e+MdZj
        kY/FEDPO5qeZ0QRI7pf4irii+wJvkUCGhTm4n2hkXobZPVOlIVdsjeuNOXHxaOI92GVFPQEBy/SgS
        pT7Moxb35Pqro0ba0tCteibwgxCqtT4KR4QvppA6rWhEnpdB5oIcZucdo/Hw4keM5kYKcVc7fc3Vt
        +IZX2hUdnI/xXUJkD/yFmsW2F4OooNIJLwUeqOYgDesMHvlk10Y6Ts97Tmdd6jG9DhBvJZwSs+dMG
        mfExv4wA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q6qhm-0069NL-If; Wed, 07 Jun 2023 12:47:54 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v5 0/6] thermal: qcom: tsens: Fix MDM9607, add MSM8909
Date:   Wed, 07 Jun 2023 12:47:43 +0200
Message-Id: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9ggGQC/6WPO27DMBBEr2Kwzgr8iJLpKvcIXFDS2iQskcIuI
 yQxdPfQblIEqVK+Bd7M7F0wUkQWp8NdEG6RY04V7MtBjMGnK0KcKgsttZFWHmHh5eikg8KYGLr
 eGN9NrbIDiuoMnhEG8mkM1Urv81yPK+ElfjxL3s6VL5QXKIHQ/0QbZZU0zspGd70zqgcFXHCtG
 5orUsjz9HpDSrecvnAtzZiXR1+IXDJ9Pudv7aPgX3F/fLm1IGFySrlO63FQ7pd73vf9G7EHnUJ
 MAQAA
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the MDM9607 thermal sensor support consistent with Qualcomm's
vendor kernel (msm-3.18) by applying the correct default slope values
and adding "correction factors" to the factory calibration values in the
fuses. Use the same functionality to add the very similar MSM8909 SoC to
the tsens driver.

---
Changes in v5:
- Rebase on top of MSM8226 series that way applied by Daniel
  (https://lore.kernel.org/linux-arm-msm/4097223e-5297-1536-18bb-512ef28c8329@linaro.org/)
- Add review tags from Dmitry
- Link to v4: https://lore.kernel.org/r/20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com
Changes in v4:
- Mostly just resend, explicitly initialize zero values for
  the MSM8909 p1/p2_calib_offset for better clarity (Konrad)
- Link to v3: https://lore.kernel.org/r/20230315103950.2679317-1-stephan.gerhold@kernkonzept.com
Changes in v3:
- Drop now unused definition reported by kernel test robot
Changes in v2:
- Rewrite on top of per-sensor nvmem cell changes that landed in 6.3
- Add patches to fix existing support for MDM9607

---
Stephan Gerhold (6):
      thermal: qcom: tsens: Drop unused legacy structs
      thermal: qcom: tsens-v0_1: Fix mdm9607 slope values
      thermal: qcom: tsens-v0_1: Add mdm9607 correction offsets
      dt-bindings: thermal: qcom-tsens: Drop redundant compatibles
      dt-bindings: thermal: qcom-tsens: Add MSM8909 compatible
      thermal: qcom: tsens-v0_1: Add MSM8909 data

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  23 +----
 drivers/thermal/qcom/tsens-v0_1.c                  | 101 +++++++++++++--------
 drivers/thermal/qcom/tsens-v1.c                    |  22 -----
 drivers/thermal/qcom/tsens.c                       |  19 +++-
 drivers/thermal/qcom/tsens.h                       |   6 +-
 5 files changed, 88 insertions(+), 83 deletions(-)
---
base-commit: 7e25e9706bbade1b3dc670fad44a920d087064df
change-id: 20230508-msm8909-tsens-6733a6d415be

Best regards,
-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

