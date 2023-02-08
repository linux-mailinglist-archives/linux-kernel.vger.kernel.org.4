Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752E68F6ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjBHSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBHSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:34:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EE25282
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:34:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r18so415661wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLfDY/quHnwUCouz6Bzp+GXo+tVo6iB/nHd1i/j58GI=;
        b=bIhsmexHY4yKfObCkcb5kstFWmxUpIVr63TYSAvIjRXcuZkkHdGJWBJacJPjfPdvM2
         GX2fUWokn0vCe7y4tCQkD8U88dvs1Fp18M/A64L4MwAhjkDh/bBpxiQZAVpXYPn9zSXj
         NmbkIShSG5ZvIIkUbEX1B3TMhkyhe/oB1yF4r9+V1jHhO11G1CLxBaSl42hadmGJ0jAD
         0rzFV39/3m/uwklzHpHMTX1hVuce6Y7zb6VMf4PEcmSQ4difoQeXk0+lAGueQb+t1QMg
         N6nj7OPxQYYI7jbTyln4VlhvFPO4OPQw5eM8cjnZxrXGq4wO3ezQlCRnM3Vc2jrpaIU/
         CggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLfDY/quHnwUCouz6Bzp+GXo+tVo6iB/nHd1i/j58GI=;
        b=gyprzTGWTH6yw3+MnoxUMcO3AG/sUilez3/cKGiQTUSXGpC/IHx99dhjuQD2JmdTXk
         IWxKSp9SbKGjZYYQxXVMiYvUqxUjiooPoePNZ9dcK5RFER4Mw/N/CE1/pgGiMV4VtLLN
         mPqjLAsBpg5TGBNbaVvec6X/EUKvizgX6WpHFH70oI/bMTockID9b5u46nvjdxn9skH6
         dgSTTxwvF1gaaslEyGLvdnXsbUNAR/NJMWEZsuX3+kUwhWz1jQVUS3P9po2i6cCaMLUt
         22wypqlOWpTToZreuI7YuijyMkkBfwSd3ZMuowLjWZWjbV/Ynw4jOMmv8F1WIh6ZH+vL
         cpog==
X-Gm-Message-State: AO0yUKWEDxRaYRQrm50fSDKy2MvllwjxgVBtrq9X55sDv4TVT9pXsqAJ
        +iQuxDtlJay15323G/Zi4pabhA==
X-Google-Smtp-Source: AK7set/xGUde5OfzB9OcfQ3EaMRQi9l5zhARcOoWUXWrZgCo0SpvATGeWPaXwf+8PBILopotmrlw/A==
X-Received: by 2002:a05:600c:18a6:b0:3e0:e77:3056 with SMTP id x38-20020a05600c18a600b003e00e773056mr7370990wmp.30.1675881273976;
        Wed, 08 Feb 2023 10:34:33 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v1-20020adf8b41000000b002be505ab59asm14591304wra.97.2023.02.08.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:34:33 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v6 0/6] sm8550: Add USB HC and PHYs support
Date:   Wed,  8 Feb 2023 20:34:15 +0200
Message-Id: <20230208183421.2874423-1-abel.vesa@linaro.org>
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

This patchset adds support for USB for Qualcomm SM8550 platform.

This patchset is based on top of the following patchset:
[1] https://lore.kernel.org/all/20230208180020.2761766-1-abel.vesa@linaro.org/

Changes since v5:
 * rebased on top of [1]

Changes since v4:
 * dropped the dts/dtsi patches as there is no change needed to what is
   already merged
 * rebased on top of next-20230206 which has Luca's patches for SM6350,
   like Johan suggested

Abel Vesa (6):
  dt-bindings: phy: Add qcom,snps-eusb2-phy schema file
  phy: qcom: Add QCOM SNPS eUSB2 driver
  dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Document SM8550
    compatible
  phy: qcom-qmp: pcs-usb: Add v6 register offsets
  phy: qcom-qmp: Add v6 DP register offsets
  phy: qcom-qmp-combo: Add support for SM8550

 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |   1 +
 .../bindings/phy/qcom,snps-eusb2-phy.yaml     |  74 +++
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 409 ++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h    |  31 ++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   4 +
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c    | 422 ++++++++++++++++++
 8 files changed, 944 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c

-- 
2.34.1

