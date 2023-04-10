Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B76DC9C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDJRK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJRK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:10:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78532682
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:10:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so10450489pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681146620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCbIblIYxd1RoPaHWqrob6eFeH3aWHVNQ4+Mn4FxgT4=;
        b=iY1dyo8B1KuXKb4CR8siFrdPdE7V04bbmicUP06JHAb/LUwfIRE3cbLW7n+FzGe4bF
         uPJq3bVljTp3bZXjaJ4s2blU0xX9M8UyNSzkk3aL/Pvbm9use+vtQ1KXBQy6OO1SP8Gv
         a1HIjG+fKWrG0IeDy67u2F2p9FaN0IbXSoMQdycs5qFj71bqa8ONaOEIZF6EHM2JUFH7
         oCkIAeg9vajdK9wwHS1rMaUqtiMxKlKxTTu8tgfcW0NA2mezDng0vKso0RxSiTAoRSSU
         /izDE8Ru0yqPcq6Us1Fj9d2kvquv8BtLdP2v1cc05lIhGArHl/yz9oS28KzIhp0waxTA
         5U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCbIblIYxd1RoPaHWqrob6eFeH3aWHVNQ4+Mn4FxgT4=;
        b=ljOKj5bWRC29ie/OAGSF19+G2/SNSzYpPD77k/CQ3GO0TgK+cAWBmeT5y+VnCB/IHB
         zT75V0jJKIJf4hHuzdP4PuPZdpPkc8pCR4BA44LMFPkqDtwbsQZX4r5gIrFqopfxKlxv
         79U4FOfRcNTViDKE3D43cuFzeielBvkqDNF5pmIfGf/vyyDFDac2VDTLiV5377bxdNLS
         RC5BMtxvdqT7NloYDz6rzDjqe60e+iqF0zn4S8sWH44bv0T/Ld08TMUNILiJy1D8Guic
         9rSFZkCu+FDBEkU4McrenqkjI0XxSAwGwRxU3isQqAdmvukXS8TjvSDm8QgPQBsdXgbP
         wOag==
X-Gm-Message-State: AAQBX9dJAvmx4OcILKsrWPKvHsLlaEP/WqrURjEe+xacYi1kZHHiW54Z
        Zdz8AyAnUhgsxF8ss31lMOBNNg==
X-Google-Smtp-Source: AKy350Ya/nSe91SuTZPm7XeJEaQOdImxghVZMquW7RmXi1HY3dcEHJ4qAUO55wSypXR1QRf0ZgFS+g==
X-Received: by 2002:a05:6a20:4c28:b0:cb:91ee:dca0 with SMTP id fm40-20020a056a204c2800b000cb91eedca0mr11004890pzb.41.1681146619915;
        Mon, 10 Apr 2023 10:10:19 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id q11-20020a63cc4b000000b0050bc4ca9024sm7187818pgi.65.2023.04.10.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:10:19 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v8 0/2] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Mon, 10 Apr 2023 22:40:08 +0530
Message-Id: <20230410171010.2561393-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v7:
-----------------
- v7 can be seen here: https://lore.kernel.org/linux-arm-msm/20230409200934.2329297-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry and added "pipe clk".

Changes since v6:
-----------------
- v6 can be seen here: https://lore.kernel.org/linux-arm-msm/20230407061122.2036838-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Bjorn and Dmitry and dropped old bindings in this
  version.

Changes since v5:
-----------------
- v5 can be seen here: https://lore.kernel.org/linux-arm-msm/20230405191633.1864671-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry and made [PATCH 1/2] compatible with his 
  'split away legacy USB+DP code' series:
  <https://patchwork.kernel.org/project/linux-phy/cover/20230324215550.1966809-1-dmitry.baryshkov@linaro.org>

Changes since v4:
-----------------
- v4 can be seen here: https://lore.kernel.org/linux-arm-msm/20230401154725.1059563-1-bhupesh.sharma@linaro.org/ 
- Collected Krzysztof's Ack for [PATCH 1/2].
- Added more descriptive commit logs as per Dmitry's comments on v4.

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20221215094532.589291-4-bhupesh.sharma@linaro.org/
- Fixed v4 as per the downstream driver code: https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
SoC. For the previous versions of this patch there were conversations
on irc as to whether this was a 'qcom,usb-ssphy-qmp-usb3-or-dp' or a
'qcom,usb-ssphy-qmp-dp-combo' as per downstream code and hardware
documentation.

But after a careful look at downstream dtsi (see [1]) it appears that
this indeed is a 'qcom,usb-ssphy-qmp-usb3-or-dp' phy and not a
'dp-combo' phy.

[1]. https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/bengal-usb.dtsi#296

Bhupesh Sharma (2):
  dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer
    one (SM6115 & QCM2290)
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        | 27 ------------
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 44 ++++++++++++++++---
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++-
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 5 files changed, 72 insertions(+), 34 deletions(-)

-- 
2.38.1

