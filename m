Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D0C6C520B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCVRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCVRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:15:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0965C42;
        Wed, 22 Mar 2023 10:15:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p16so11981364wmq.5;
        Wed, 22 Mar 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIgxYOCHY5hpYpnaBL4KUYD99zfVheHS3DgjQH5qt3c=;
        b=dQY5pOOKQlo1q5JREC81HNhiIEkO1mEpKC5WnzIZLsKI29QX/y5R2w6uZKcTVY8NOR
         vYw4gBpLP6GT8wgEVGRMECN0x8dZHXD3m27ZBpGFFpscqwanoGTnfpjHARpfE4qIhlsk
         6RjvKpCtGi7bnQpLFaTwcRTwH/Q+yEtFt74u+4CkG9qMNmp2SJzoYsP5FQjxv0YoFeP7
         lIp1zm+RCi8GySTio4t34HplFJtoaiVilCvBquzaVzPKrP0K0oeEtJS04Gswf6iJBCDe
         mZnvK/8g4G7Bc/Wq6dnGstmEJRQAftrK1yjp/Ih7N06iXS2qXOYgKRll9MCflhpeCkWV
         6fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIgxYOCHY5hpYpnaBL4KUYD99zfVheHS3DgjQH5qt3c=;
        b=vXupdqjvP74W3rS7NQGhV1QKD0x9tYmXvKmkpTiQfRF+wuMrcTt9+SB7S2m18DrATd
         yknPcmX1RcfBdU5xB/gPLCMWd+G0TUe6iCNloRTyB9s9+orq9Sp9Y1Ny8yaQsWIBZwvS
         Y+T15XmJvi8gSxnPaf3uC+OYj2W3ztNdIckuYSKqs3GmdZnt+aE8BUV/DBCngYYJxAdG
         xg2K91cRmA7DPq6ktyJv80hv9ZdmO9kP2NQeGmM9v8k9bhV321cNIcknmuFGcMMhljkA
         Xygy9120CKvJB76cZWRdCtnPO3hToymcY1E/85S3mJZlSSBRs0U8qJSHBrUXH7DCO9uh
         TSXQ==
X-Gm-Message-State: AO0yUKWAGYUKSa9l/IfbfL1PaEmOhsCIfbGLqLdl8pPZRnsHMBz2TPw+
        +WfaUmSZXHtwphrL8+IZOV4=
X-Google-Smtp-Source: AK7set/iqN8xEJjKarGcYm7XOUyyYBEzKJayk22TXhKsOQrtfmH0+q2ioC5+Q9j2H5en+lS7nNh3aA==
X-Received: by 2002:a7b:cb53:0:b0:3ea:d620:570a with SMTP id v19-20020a7bcb53000000b003ead620570amr173400wmj.38.1679505321379;
        Wed, 22 Mar 2023 10:15:21 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ee11ac2288sm8414333wmo.21.2023.03.22.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:15:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 0/4] clk: add BCM63268 timer clock and reset
Date:   Wed, 22 Mar 2023 18:15:11 +0100
Message-Id: <20230322171515.120353-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom BCM63268 has a timer clock and reset controller which has the
following layout:
  #define POR_RESET_STATUS            (1 << 31)
  #define HW_RESET_STATUS             (1 << 30)
  #define SW_RESET_STATUS             (1 << 29)
  #define USB_REF_CLKEN               (1 << 18)
  #define UTO_EXTIN_CLKEN             (1 << 17)
  #define UTO_CLK50_SEL               (1 << 16)
  #define FAP2_PLL_CLKEN              (1 << 15)
  #define FAP2_PLL_FREQ_SHIFT         12
  #define FAP1_PLL_CLKEN              (1 << 11)
  #define FAP1_PLL_FREQ_SHIFT         8
  #define WAKEON_DSL                  (1 << 7)
  #define WAKEON_EPHY                 (1 << 6)
  #define DSL_ENERGY_DETECT_ENABLE    (1 << 4)
  #define GPHY_1_ENERGY_DETECT_ENABLE (1 << 3)
  #define EPHY_3_ENERGY_DETECT_ENABLE (1 << 2)
  #define EPHY_2_ENERGY_DETECT_ENABLE (1 << 1)
  #define EPHY_1_ENERGY_DETECT_ENABLE (1 << 0)

v4: add changes suggested by Stephen Boyd.
v3: add missing <linux/io.h> include to fix build warning
v2: add changes suggested by Stephen Boyd.

Álvaro Fernández Rojas (4):
  dt-bindings: clk: add BCM63268 timer clock definitions
  dt-bindings: reset: add BCM63268 timer reset definitions
  dt-bindings: clock: Add BCM63268 timer binding
  clk: bcm: Add BCM63268 timer clock and reset driver

 .../clock/brcm,bcm63268-timer-clocks.yaml     |  40 ++++
 drivers/clk/bcm/Kconfig                       |   9 +
 drivers/clk/bcm/Makefile                      |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c          | 215 ++++++++++++++++++
 include/dt-bindings/clock/bcm63268-clock.h    |  13 ++
 include/dt-bindings/reset/bcm63268-reset.h    |   4 +
 6 files changed, 282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

-- 
2.30.2

