Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F476F3CFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEBFfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:35:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C8172D
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:35:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaed87d8bdso16066575ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683005748; x=1685597748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WalWNBbqLP5+H0yr5WCCK7jHS95uZC4dq+Re1T637XE=;
        b=S6dGmVSsgrHaEr0TUBQULNWA571DsS9PU8wYJmxTdyAfFKX5QzPWj2G39ZuDwKD/dZ
         CpW/WrbXbGM7nss6yYYrNrjaWa+hlMdP+Gr04koV0DYIqUDXDbqnV85ODGmAuEupk5uN
         DEk4JmyqMPXutFY1NLeUx2QFZPM1MckjDc82OOHnNWHQ+IfzHCbS/mISMopMzzaZ5Ley
         /+u0dqewctMvnkSqz9vRCmO4IBkWt7yJiBrb5ROnqhe38hES6+bkB1XfRQQBbrZoe9S6
         JiDDLZqGBWtZVDVgxBIZA9jmW2arcgMqahWBFdvkH/GmHBQriD1LgK4dACkw0bVH2Biu
         0fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683005748; x=1685597748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WalWNBbqLP5+H0yr5WCCK7jHS95uZC4dq+Re1T637XE=;
        b=PoWVDkXlgRmfhn8BWs2j4ys6bwr9ToCLoSro3Ae2jyJ+Vn5QiKUypVfQmMM/9vatdm
         rK21coyyAmOXfJJBq7Ltdbm8gr3ZvQe1Pi8Ux/2ZW4FYuaQamv+nNtI/ucTxr2vGfP5x
         lDlLGVlCkiT6UthtGTTBmfdYfhT3UeQ4/7VJeE/JPZWkzrpoCQaxDI59YLK2NVYK/Szu
         oJYIFS409b5iR9uGaWC/G6At5P5yZl4YldCqJ7STC/czZ+MnoMxfJ3MdW9nenONkU+zD
         3sFW31/Vf2/6LiaDGiZQ5+9LN60n22YNT4tpKfJELawAwM56a8Foqu2ilROf5z4vCUKK
         fnmQ==
X-Gm-Message-State: AC+VfDy+duOT+0WUR+9XSjD8ZWRSUyQzj+ksQABBUFvyzize2P2ZOv6k
        L+8CVJ5jjap2OqFtfU+rTg43ew==
X-Google-Smtp-Source: ACHHUZ74rhSOrYkhGkK2AaUtssN912iRZKoGc466lxGT7AqULsRjX6hsaMu1K2GGcRE1jlHuRsSc9g==
X-Received: by 2002:a17:903:1248:b0:1a6:a6e7:8846 with SMTP id u8-20020a170903124800b001a6a6e78846mr18260120plh.40.1683005748053;
        Mon, 01 May 2023 22:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm18870369plk.168.2023.05.01.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 22:35:47 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        vkoul@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v10 0/4] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Tue,  2 May 2023 11:05:30 +0530
Message-Id: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

Changes since v9:
-----------------
- v9 can be seen here: https://lore.kernel.org/linux-arm-msm/20230501192432.1220727-1-bhupesh.sharma@linaro.org/
- Addressed review comments from Dmitry on v9, regarding register size
  and pcs_misc offset handling. Also collected his R-Bs.

Changes since v8:
-----------------
- v8 can be seen here: https://lore.kernel.org/linux-arm-msm/20230410171010.2561393-1-bhupesh.sharma@linaro.org/
- Added driver change for new bindings used for sm6115 / qcm2290
  devices.

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

Bhupesh Sharma (4):
  dt-bindings: phy: qcom,qmp-usb: Drop legacy bindings and move to newer
    one (SM6115 & QCM2290)
  phy: qcom-qmp-usb: add support for updated qcm2290 / sm6115 binding
  arm64: dts: qcom: sm6115: Add USB SS qmp phy node
  arm64: dts: qcom: qrb4210-rb2: Enable USB node

 .../phy/qcom,msm8996-qmp-usb3-phy.yaml        | 27 ------------
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 44 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts      | 24 ++++++++++
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++-
 .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 22 ++++++++++
 7 files changed, 118 insertions(+), 34 deletions(-)

-- 
2.38.1

