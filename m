Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334CF6FB1BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjEHNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEHNhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:37:37 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127703488B;
        Mon,  8 May 2023 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:From:References:In-Reply-To:Sender:
        Reply-To:Content-ID:Content-Description;
        bh=ZiYNyYZW2PX1GsawJ1pBHCOLh0RTEIYbhy7d/KLFVEs=; b=XS1W6sPzQaVo5Lfz5EtL1xaUX2
        tZ7EapKk+HCmadsMPS0I8CsdL/oFQjRa44ngulQvMOdTa94/73FemElK/o7MyrFYdiSPThIl/Nruf
        n7onJn8/cJXeu5QM9HzsexpMBGTylIx4QgeB8/dyVgLRb+kTUsnd5zAuGTiVUd17ulQoLU+clQGHo
        8YF9XK7gj8gj5W9wRAwWz3shTijUQCNwaKXvW2Z3c5RaW20hAvXinPE++TW0t/c+FuvCIzxukL+3m
        AoDqQRWS2HvfmkRsw1PiJ5goj/MI9GxYDiczdNBnvdhWghYMRlG9OYnNvY9qXcvC2BDR7A1vE0a71
        oHRjbwCQ==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1pw0hF-009LZn-85; Mon, 08 May 2023 15:14:33 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH v4 0/6] thermal: qcom: tsens: Fix MDM9607, add MSM8909
Date:   Mon, 08 May 2023 15:13:37 +0200
Message-Id: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIL1WGQC/52Oyw6CMBREf8V0bUlLeYgr/8OwKHClDdCSeytRC
 f9uYePe5Zlk5szKCNACsetpZQiLJetdhOx8Yq3Rrgduu8gsFakSubjwiaZLJSoeCBzxolRKF10
 m8wZY7DSagDeoXWtiyz3HMYYzwsO+Dsm9jvxAP/FgEPRvWslcClXlIkmLslKy5JJTgDl+SHpA4
 8fuNgC6wbsPzCFp/bT7jKXg8X3cX7Jd8P9cvW3bF1438jcQAQAA
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
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 .../devicetree/bindings/thermal/qcom-tsens.yaml    | 23 +----
 drivers/thermal/qcom/tsens-v0_1.c                  | 99 +++++++++++++---------
 drivers/thermal/qcom/tsens-v1.c                    | 22 -----
 drivers/thermal/qcom/tsens.c                       | 19 ++++-
 drivers/thermal/qcom/tsens.h                       |  6 +-
 5 files changed, 84 insertions(+), 85 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230508-msm8909-tsens-6733a6d415be

Best regards,
-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth

