Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477516E2222
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDNL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:28:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA730F3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso16365210wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681471725; x=1684063725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIDUQVJxCuBLvWEmo5PDPRKv9hp0CiYs1b9iDMKkYME=;
        b=wVyHZo1fvuH4nbWYIxEUdT4xBU51XI3N0E11+IFjIoGEHEHUXhT7wiQZL66qA83o6b
         mo/McjvdNE+fpKdf4BlSEcZXSwe2Ywv3HwS0t/f7gFeSIVooOJaLpw9G2ofCqEww91v6
         Mm979Ck1CSsQ42aWOF+BccfAbWP8qBgN1ghKWpqnsC4MyF2xGcPO83wOrWU4BiFhrpkZ
         4RBkn/8JXWPcKeONcK9l32Of+I4j+zm+wpzKYw5PnVMw88C3/dZxIoPHHiQx2rt75bNn
         8VcyNclc0f6xmW+HgGsIOMVqkuxghCwuJCYm8QaKQPGL+S5t7JFYI+OpiaPsVE4Pm/Ji
         1DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471725; x=1684063725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIDUQVJxCuBLvWEmo5PDPRKv9hp0CiYs1b9iDMKkYME=;
        b=G8UFlRLU2z6lZwPXS5azvxJAL4x70ffrl0HQMWRPBbMzPqv/Qelc0ocDA/ykft169I
         xlXMkluLo8p84umVDp/3K6lvuyzubjGgf5ZRxp3PzexQ6fwjST0G3g9q6QG7LAnD81CQ
         wDRM6bGNtqWW2utgqn3ChDUI/2XP+PIdDOXr5kH72g7XrfPeyu+dZ7mVTx1+flUQWabk
         WUjXWvsnUqdVskzoQPzoCFQPC366xx4XYw2YqFUT0jLIpNZX9xGIg/EAji4svxc37YuM
         fpdggiZxUORS/uda9fDfRpHBjVU0i60UlOC/EqV9fPA2CGr0KqgF2GNaWGAngZVwhH0y
         /y3w==
X-Gm-Message-State: AAQBX9fEhMDLFoP/ppynEmet8j2aSbiw0m/qfGF9gpwTC34GNwZHZkjU
        rPvnJ4+uzdfaqFp7+NjfI7qUww==
X-Google-Smtp-Source: AKy350bUbeyHl/w0ojt5yCD+9eE5/S9aYBE+HqX2QoNgWBxNNynfQ8iwJfdcevEA9IcduoXqjzqQMQ==
X-Received: by 2002:a1c:4b0b:0:b0:3ef:4138:9eef with SMTP id y11-20020a1c4b0b000000b003ef41389eefmr4284414wma.36.1681471725203;
        Fri, 14 Apr 2023 04:28:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:eca6:27f0:42a5:8f07:826a:465d])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003ede06f3178sm4063745wmi.31.2023.04.14.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:28:44 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v2 0/5] arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
Date:   Fri, 14 Apr 2023 13:28:38 +0200
Message-Id: <20230414112843.1358067-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS6594 is a Power Management IC which provides regulators and others
features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
communicate through the I2C or SPI interfaces.
TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.

This should be applied on top of other patch series:
- https://lore.kernel.org/all/20230406075622.8990-1-jpanis@baylibre.com/
  For core MFD driver
- https://lore.kernel.org/lkml/20230414101217.1342891-1-eblanc@baylibre.com/
  For regulator driver

This serie adds device tree nodes for TI TPS6594 PMICs found in the
following boards:
- J721EXSOMXEVM:
  Link: https://www.ti.com/tool/J721EXSOMXEVM
- J721S2XSOMXEVM:
  Link: https://www.ti.com/tool/J721S2XSOMXEVM
- J7200XSOMXEVM:
  Link: https://www.ti.com/tool/J7200XSOMXEVM
- AM62A-SKEVM:
  Link: https://www.ti.com/tool/SK-AM62A-LP
- J784S4XEVM
  Link: https://www.ti.com/tool/J784S4XEVM

Changes since v1:
https://lore.kernel.org/lkml/20230329142948.833800-1-eblanc@baylibre.com/
- Harmonize regulators names across the different boards
- Adjust AVS voltage range
- Remove some outdated comments

Esteban Blanc (2):
  arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
  arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

Jerome Neanne (2):
  arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
  arm64: dts: ti: k3-j784s4-evm: Add support for TPS6593 PMIC

Julien Panis (1):
  arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts      |  95 +++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 175 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 171 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 213 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts     | 116 ++++++++++
 5 files changed, 770 insertions(+)

-- 
2.39.2

