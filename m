Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEE6F0D69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjD0Upv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0Ups (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:45:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DB3ABC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so1352011266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682628344; x=1685220344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k9dCctWANQe/yEgS6tS+0M8nlHpydDuo0y2/2pb4aE=;
        b=NQgjyC4xn/Uej85mqcMFusgacST3cB5Z7SBtNd98Z10faKY6VMJ3EhbjgaIlTrwPlN
         AmmDe6Uzg8BXmwDnPtLGQ4zkAlZ9AfSYWf3MQzUi1LSDes0If5aWc7M/CRPMxb5nkk/H
         Un5NIvV4OPhgBJBBZWZ4pOrBPRskv/Z9jCMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628344; x=1685220344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k9dCctWANQe/yEgS6tS+0M8nlHpydDuo0y2/2pb4aE=;
        b=F6aE2CdhwGN5BMfcxgsTH6cgcTbLqhyROH20QCR4td2O2aeo9BWRZAQC8/ttx96PbQ
         V50uoD/xsLXC5+CrmJWOVGSeERMwhgnyotV22VmiEfPGSJKaGtu1NjmPr0/XGX2l/pdy
         Y5FpyZAk3up8aDya14EhADrShJHk0QgYqUWQuoYDgGlWfEQaBZlR9ObvX4Xf/GYBVDkJ
         Mz6weuJEBjTPxnK7SzLiLJpeMVjj+UEdwVWyCsOfWvhlMK7JriRIz1CsWPRTzHkQT04i
         1HsXLr4ybFnxnZ+v76haaz/N31XfFWF9ezZY5EulrFmwxI+gNEWIz5Z2GEG789mp9bfH
         DtDg==
X-Gm-Message-State: AC+VfDzCypynZLiWnDWiHab+14dyBmjDsWYH4RMH1qyyoFWWJkMGaUdS
        9EfNxkMg3AqZZeTg2q4/LD/GjbiDySrvF3RS8yZ+gQ==
X-Google-Smtp-Source: ACHHUZ7Pu2xm4uXxSJcjBpr1Hhq7iFPzZY8LJppkL07oeAowkmx49KIhfg1j3b4w/tixepn51IrZ7A==
X-Received: by 2002:a17:907:7fa1:b0:94e:fe77:3f47 with SMTP id qk33-20020a1709077fa100b0094efe773f47mr4225933ejc.67.1682628344213;
        Thu, 27 Apr 2023 13:45:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-5-99-194.retail.telecomitalia.it. [87.5.99.194])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906bc4c00b00947ed087a2csm10171360ejv.154.2023.04.27.13.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:45:43 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-can@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Subject: [PATCH v2 0/5] can: bxcan: add support for single peripheral configuration
Date:   Thu, 27 Apr 2023 22:45:35 +0200
Message-Id: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The series adds support for managing bxCAN controllers in single peripheral
configuration.
Unlike stm32f4 SOCs, where bxCAN controllers are only in dual peripheral
configuration, stm32f7 SOCs contain three CAN peripherals, CAN1 and CAN2
in dual peripheral configuration and CAN3 in single peripheral
configuration:
- Dual CAN peripheral configuration:
 * CAN1: Primary bxCAN for managing the communication between a secondary
   bxCAN and the 512-byte SRAM memory.
 * CAN2: Secondary bxCAN with no direct access to the SRAM memory.
   This means that the two bxCAN cells share the 512-byte SRAM memory and
   CAN2 can't be used without enabling CAN1.
- Single CAN peripheral configuration:
 * CAN3: Primary bxCAN with dedicated Memory Access Controller unit and
   512-byte SRAM memory.

The driver has been tested on the stm32f769i-discovery board with a
kernel version 5.19.0-rc2 in loopback + silent mode:

ip link set can[0-2] type can bitrate 125000 loopback on listen-only on
ip link set up can[0-2]
candump can[0-2] -L &
cansend can[0-2] 300#AC.AB.AD.AE.75.49.AD.D1


Changes in v2:
- s/fiter/filter/ in the commit message
- Replace struct bxcan_mb::primary with struct bxcan_mb::cfg.
- Move after the patch "can: bxcan: add support for single peripheral configuration".
- Add node gcan3.
- Rename gcan as gcan1.
- Add property "st,can-secondary" to can2 node.
- Drop patch "dt-bindings: mfd: stm32f7: add binding definition for CAN3"
  because it has been accepted.
- Add patch "ARM: dts: stm32f429: put can2 in secondary mode".
- Add patch "dt-bindings: net: can: add "st,can-secondary" property".

Dario Binacchi (5):
  dt-bindings: net: can: add "st,can-secondary" property
  ARM: dts: stm32f429: put can2 in secondary mode
  ARM: dts: stm32: add pin map for CAN controller on stm32f7
  can: bxcan: add support for single peripheral configuration
  ARM: dts: stm32: add CAN support on stm32f746

 .../bindings/net/can/st,stm32-bxcan.yaml      | 19 ++++-
 arch/arm/boot/dts/stm32f429.dtsi              |  1 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi        | 82 +++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi              | 47 +++++++++++
 drivers/net/can/bxcan.c                       | 34 +++++---
 5 files changed, 168 insertions(+), 15 deletions(-)

-- 
2.32.0

