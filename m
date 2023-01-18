Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0258E670F64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjARBFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjARBEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:04:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8855D10A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l8so6466416wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywhGTUyzHWVWzLOmk83zcL5eWG5EU/x60/QYsq8hROc=;
        b=A6vsnmpiES0NIEHKcoh1knZS3MFrxmxTatoQRq6+oDn8SXhss+f7FH1989zZ5J6KRy
         IvuGvDSBTXFI7ioN+48Ds1pTxbUPPWH8GV4bFgQNFOtvXzWqpk/C0hIZFhVEAbJmBBsU
         IuX1rOrb9kJfH+iMLcWmcg9DkoddSgI+XlkqVqkTse/hbKYcZa4Nwi7YkbCPOKDlmwPL
         lAFUidN2A73gknAqiFW4MpVcrDAcLYpdRHpb6bqpnv3MYDEwCYvwfZgA8UkmFU6BvC3k
         Le704eFQUv8NbYDW435r2Fb+3+rfvT/cO1aIFRGUPsfy07CMKNkPBDd39uX6bDcECV3J
         uFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywhGTUyzHWVWzLOmk83zcL5eWG5EU/x60/QYsq8hROc=;
        b=YGLOobBKhScjRy59vVjLtAxwo0IudVNw7lhPB2kBMo49rGKGIIUeHObRRPdDrY40yM
         Hz5rWYqacbwetUwylaQWkp0+iNPHZU/lh9KWNEoY02jb2mCnbrrkHY2ARufb0nCFSUUP
         VMGsxYyCkcMybg7I2Mi+FF3QeedAdvFVqi+IVDEpHFBTl5WGEMthzIt3xzpwim2Dr074
         Vnd2xNsg6tbhs/2JDQPUgBFz8tKfBTHYYp0zb0fCuRvqNl/CnAwl9AVhJWtULG0ZSzej
         vKqURYPu8cFjt6oQ9rA3uPXt7LWVn8t5mUObRHWKehv7haqWrf975JquPgUibT+rCRrE
         vU7w==
X-Gm-Message-State: AFqh2kqC9nvA3unzBTqA9obRXabXMArzuEBWWUR1F/sSqCZJpm6ml5WZ
        uEag8xVwLWSYhODpSwYwvcvyhg==
X-Google-Smtp-Source: AMrXdXsOQ/BaxVBfMKqu6whWfXSPa3BIJBwcaMfYk8J4ghLiZyuFox/5HGike3B9xqO/10v01+c2yQ==
X-Received: by 2002:a05:600c:3b17:b0:3cf:7397:c768 with SMTP id m23-20020a05600c3b1700b003cf7397c768mr4665927wms.30.1674003211488;
        Tue, 17 Jan 2023 16:53:31 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm29609705wrx.21.2023.01.17.16.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:53:30 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/8] phy: qualcomm: Add PCIe support for SM8550
Date:   Wed, 18 Jan 2023 02:53:20 +0200
Message-Id: <20230118005328.2378792-1-abel.vesa@linaro.org>
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

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v2 of this patchset is:
https://lore.kernel.org/all/20230118003834.2330028-1-abel.vesa@linaro.org/

Changes since v2:
 * added back the binding compatible update patch

Abel Vesa (8):
  dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
  phy: qcom-qmp: pcs: Add v6 register offsets
  phy: qcom-qmp: pcs: Add v6.20 register offsets
  phy: qcom-qmp: pcs-pcie: Add v6 register offsets
  phy: qcom-qmp: pcs-pcie: Add v6.20 register offsets
  phy: qcom-qmp: qserdes-txrx: Add v6.20 register offsets
  phy: qcom-qmp: qserdes-lane-shared: Add v6 register offsets
  phy: qcom-qmp-pcie: Add support for SM8550 g3x2 and g4x2 PCIEs

 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |   2 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 371 ++++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h   |  15 +
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h    |  23 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h    |  16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h |  18 +
 .../phy-qcom-qmp-qserdes-ln-shrd-v6.h         |  32 ++
 .../phy-qcom-qmp-qserdes-txrx-v6_20.h         |  45 +++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |   6 +
 9 files changed, 528 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-ln-shrd-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h

-- 
2.34.1

