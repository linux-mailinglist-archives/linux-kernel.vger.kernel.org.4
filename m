Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7472BC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjFLJaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjFLJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:29:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FB1A1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso41418625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561865; x=1689153865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtFss3/4BWnZx7BK6rTdWa1DuApsa4mA3kKtcIcOXC4=;
        b=qLJytdt6Jb/yVXsOZ6i6XGX8DjxK7ccMzfD1qS6kYgg8kta38u9WMlXXUab9tHe+YF
         K/ACwxglRzoF8jM6P1rF9+Ps5zpHWb4gIAiIB8L0DD7wQucMjDngSXyODnCyQ/XuJnxZ
         nDSIkg03r3lFVp/DfGV7PlLS6/gdgMWHdBwV9xrKYmPp4Ix5ADWRxT1D9s+DSFlU0BF+
         XCGfRDHbr8rlCR3wCnBtDqpED95AsNwmBjVAcdYwcKLoCDQZ7UzlvYNVfZ2xFhNAoZf6
         QigJ1LWe9B8J+1NmzCzmWHPrW9M+lR0OnYMO5XzU7BetZ902d+e18mzW32Tjru6XU2pp
         4u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561865; x=1689153865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtFss3/4BWnZx7BK6rTdWa1DuApsa4mA3kKtcIcOXC4=;
        b=j4Ul18M4TibQgbjhCE1CjBExl/LNJ5AOH+TK+b/v8herHTiXaWHtbtlMfjw+YZxwhc
         XQxNOZDm1O5S8gg5sCDZjOh5x01TepHHdg1v5x5LxP2VM5r4ltU6802hZkdM36IV95Kg
         k9lGkyagmZhu6k5Q0M2VltyZDwcv0UG1wnFyI0PHXwO10iAdtC26/t+VLt2kbLW7ofAO
         VNvQU5so1ArJplL47/DdQhzz0wWaapn1uIWoupIC3WRXkMTmhWyxkz4FTzvpXqCHFtqt
         TXeGVe+pAtvfWWUHDyCZkSFJlsDxo0ap0IJhEkWxX7MYQdGupBOn245wz3Xe4tnFqisg
         i1/g==
X-Gm-Message-State: AC+VfDxv4wSzyz1wbVHgYpeVTad9qszacgbe5LissDe9jWvMundqk24c
        LPFT4i2dqhXE5TXCyfDEkiIvIA==
X-Google-Smtp-Source: ACHHUZ7jVY7WsrzBMbHCfUmR81pNeDeuO6Gb3yzNkzIgysAxxoKNzVSDsJJSKjHa4n/KMAp302GrIQ==
X-Received: by 2002:a7b:cd8a:0:b0:3f4:1cd8:3e99 with SMTP id y10-20020a7bcd8a000000b003f41cd83e99mr6686652wmj.28.1686561865141;
        Mon, 12 Jun 2023 02:24:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/26] arm64: qcom: sa8775p-ride: enable the first ethernet port
Date:   Mon, 12 Jun 2023 11:23:29 +0200
Message-Id: <20230612092355.87937-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are three ethernet ports on sa8775p-ride. This series contains changes
required to enable one of the two 1Gb ports (the third one is 10Gb). We need
to add a new driver for the internal SerDes PHY, introduce several extensions
to the MAC driver (while at it: tweak coding style a bit etc.) and finally
add the relevant DT nodes.

Bartosz Golaszewski (26):
  phy: qualcomm: fix indentation in Makefile
  dt-bindings: phy: describe the Qualcomm SGMII PHY
  phy: qcom: add the SGMII SerDes PHY driver
  arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
  net: stmmac: dwmac-qcom-ethqos: shrink clock code with devres
  net: stmmac: dwmac-qcom-ethqos: rename a label in probe()
  net: stmmac: dwmac-qcom-ethqos: tweak the order of local variables
  net: stmmac: dwmac-qcom-ethqos: use a helper variable for &pdev->dev
  net: stmmac: dwmac-qcom-ethqos: add missing include
  net: stmmac: dwmac-qcom-ethqos: add a newline between headers
  net: stmmac: dwmac-qcom-ethqos: remove stray space
  net: stmmac: dwmac-qcom-ethqos: add support for the optional serdes
    phy
  net: stmmac: dwmac-qcom-ethqos: make the rgmii clock optional
  net: stmmac: dwmac-qcom-ethqos: add optional phyaux clock
  net: stmmac: dwmac-qcom-ethqos: add support for the optional
    phy-supply
  net: stmmac: dwmac-qcom-ethqos: prepare the driver for more PHY modes
  net: stmmac: dwmac-qcom-ethqos: add support for SGMII
  net: stmmac: add new switch to struct plat_stmmacenet_data
  dt-bindings: net: snps,dwmac: add compatible for sa8775p ethqos
  dt-bindings: net: qcom,ethqos: add description for sa8775p
  net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p
    platforms
  arm64: dts: qcom: sa8775p-ride: add the SGMII PHY node
  arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
  arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
  arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
  arm64: dts: qcom: sa8775p-ride: enable ethernet0

 .../devicetree/bindings/net/qcom,ethqos.yaml  |  14 +-
 .../devicetree/bindings/net/snps,dwmac.yaml   |   3 +
 .../phy/qcom,sa8775p-dwmac-sgmii-phy.yaml     |  52 ++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     | 109 +++++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  39 ++
 arch/arm64/configs/defconfig                  |   1 +
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 273 ++++++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   3 +-
 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     | 446 ++++++++++++++++++
 include/linux/stmmac.h                        |   1 +
 12 files changed, 890 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sa8775p-dwmac-sgmii-phy.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-sgmii-eth.c

-- 
2.39.2

