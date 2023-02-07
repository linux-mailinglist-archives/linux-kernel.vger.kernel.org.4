Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E168D9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjBGN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjBGN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:56:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B637B4A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:56:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o18so13638414wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZVy6UETjo48T8sbWkjn8fWSpf7jaH8RRC1DRDpNkX8=;
        b=DXafruirc1KWzQxIKCu5wqiV6RseMKBRfEAUw6h4nDf9bvj5qF5DuxctY42EIn8PBP
         DSF11ev9bfgds55L88Umbi5Vx1TS4tH1Hgu2PTu2NubZUUJFquouZ5qadV9tl0Dcm6Vq
         2fQfVkxkHGCX4wqK1ViBYx950Rfp2WZt1/o89xbICzO+1RwerYLAxtfM3cAO0LJIYRgG
         FH/XGH3YOfCnViE5eqhxuxToliylvf9d/M+ivvvR8u86cPZhJGkWlz4WhD+PHBNbjXeW
         lrSkvlCF9MjmDIYBbr+/YPUXTkQBm5Ufs4jNai3TWNXn4m3WvXXrEYW+XVJo4bB/oTy8
         1Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZVy6UETjo48T8sbWkjn8fWSpf7jaH8RRC1DRDpNkX8=;
        b=ahi/MNDkuMs+x/EZAqzkVC9L1DOYel4I6rbNcoYRN2GjyLyGQqixwCjHQjO+WWiXFj
         28veSgQzLdxDk5ZdQKhAwU/bMclB79ifrgr9kps8ZJXA3C5ptxVNbMJdo8nosHSQfsdM
         S/F0C4C6HeeXGUG6T1thWP3h47+Hmo1ut/aKwVsWMRH0OCVk0U6Ry7K89ybHCJIBu2UP
         09FqZd7XIqYbdqzIgTcXdK9AUBqmoiYXUL+RwjHb0rKnalNA30DeFvaDJXFenYNPcwC7
         Uugzdwg3FsEFytw4nAB9Usr5od0i9wxf7mKCAPI7298E4hjOXfheDSRCLXI2wZqyTep8
         HfDQ==
X-Gm-Message-State: AO0yUKXh1TjBX8VhjcW5WCU8YntxIU2fWdwh7VSwbltGyX4smUio4VuZ
        3nBPE4BQc4F+GgfdA+FncHx/mQ==
X-Google-Smtp-Source: AK7set91Op9UQN4lc/XoWrfKxdUUccdREuCUJsx0iI1vqbpMl3cZEbxrNCdDV0wR7zpkr7cLv4vfsw==
X-Received: by 2002:a5d:5745:0:b0:2bf:e528:336b with SMTP id q5-20020a5d5745000000b002bfe528336bmr2881141wrw.38.1675778155250;
        Tue, 07 Feb 2023 05:55:55 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d59aa000000b002be5401ef5fsm11611312wrr.39.2023.02.07.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:55:54 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] sm8550: Add support for eUSB2 repeater
Date:   Tue,  7 Feb 2023 15:55:44 +0200
Message-Id: <20230207135551.1418637-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the eUSB2 repeater found in pmic PM8550B,
used along with SM8550. Since there is no dedicated generic framework
for eUSB2 repeaters, the most appropriate subsystem to model it is the
generic phy. This patchset also adds support for such repeater to the
eUSB2 PHY found in SM8550. Basically, the eUSB2 PHY will have its own
"phy" which is actually a repeater.

This patchset is based on the following patchset:
https://lore.kernel.org/all/20230207114024.944314-1-abel.vesa@linaro.org

Changes since v3:
 * This time is a normal patchset, rather than an RFC
 * reversed the order of patches 1 and 2, in order to make the repeater
   schema available for the pmic schema update

Changes since v2:
 * moved the bindings qcom,spmi-pmic patch before the repeater schema
   patch in order to avoid the repeater schema validation failure due to
   phy pattern property not being found in qcom,spmi-pmic schema

Changes since v1:
 * the repeater driver is implemented now as a PHY rather than adding
   a new generic framework for USB repeaters

Abel Vesa (5):
  dt-bindings: phy: Add qcom,snps-eusb2-repeater schema file
  dt-bindings: mfd: qcom,spmi-pmic: Add pattern property for phy
  dt-bindings: phy: qcom,snps-eusb2-phy: Add phys property for the
    repeater
  phy: qcom: Add QCOM SNPS eUSB2 repeater driver
  arm64: dts: qcom: sm8550-mtp: Add eUSB2 repeater node

Neil Armstrong (2):
  phy: qcom: phy-qcom-snps-eusb2: Add support for eUSB2 repeater
  arm64: dts: qcom: pm8550b: Add eUSB2 repeater node

 .../bindings/mfd/qcom,spmi-pmic.yaml          |   4 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml     |   5 +
 .../phy/qcom,snps-eusb2-repeater.yaml         |  48 ++++
 arch/arm64/boot/dts/qcom/pm8550b.dtsi         |   6 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts       |   7 +
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 259 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c    |  19 +-
 9 files changed, 357 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c

-- 
2.34.1

