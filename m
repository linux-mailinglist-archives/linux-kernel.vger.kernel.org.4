Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D96C3B49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCUUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCUUK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:10:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCE4AFDF;
        Tue, 21 Mar 2023 13:10:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v25so11483312wra.12;
        Tue, 21 Mar 2023 13:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94Bz1m6WdvaEL/5agO9/V0CXaR9YC7212sNHt1XbySI=;
        b=d3oG+nBR+sVrLC5EHXhXzwvxBcBt9C2Ay3KrQsIJZmWA9XZCXcxOremhAQRSaOnzjt
         AZl6Ux6lZuxUCWRdPbYbGHRJmmDrZGJiZPuAt9zLW9oeVPfRsDoIoOxjcB1mJ3aVNVrN
         DiHCsMe4EV3LSzzJhlmjqbKBhfOszXijggGEp8p3mlUHimI6vIanui3QDtEtfOOenDug
         lToZYMus42hVkl6rnXvbU+w+Sa6xAorYQXHbmpdNmtR81MN64s/Qan2gVrMj4Nbx/DoO
         +hYbVRpo1aGUMVmKV8ac+ZDRpNHXyRfMwRS87wWx1JLuSduydRAajNDnVfla0ztDSLGK
         j/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94Bz1m6WdvaEL/5agO9/V0CXaR9YC7212sNHt1XbySI=;
        b=NPHxxZVoU8LnoDZPl21IfyXlIgyPCmwjMzvBMhKEd5COZqp9Skyc5FJVvmil2lAlTr
         NZVWoQ/KGrN7lbso0X2c33MyhzSHh+krE/Zz1XS/OjjVmoVgzpbzWOollnKlWh/lz7/u
         cYUSwrg4IjQDIYJSLle+N8nj3euOmR9KPmKi2zGBHWt4jHhspRre41VyV65lZ/GYK+Ie
         ICFaueuteTuh8VkMdqrLsrQytmj3j/LrihCZFd6QIIO5FBcSECdDCEtXu2eUrB6LudGA
         SQqDHtq2A8GzZbkrnDLsvO/TdXbrJytxd66ip+4QHyCRWKPS9VEd9EvrkTyCPSfsLmE3
         jPaw==
X-Gm-Message-State: AO0yUKUzSeAmUKghOLsnGTjzx7vy0oH8AvZvj/+5O0QMI1lxw8qoAWxA
        JJwsJFV36oPQQhOdo3p439U=
X-Google-Smtp-Source: AK7set9ap9gQK0b90/s9CXp1we3TgqI8LpvPjCX5XBgJikHbf8j0P7vl9UcWy2AX3LpUI1avNweS9Q==
X-Received: by 2002:a5d:474d:0:b0:2c7:17e0:54f5 with SMTP id o13-20020a5d474d000000b002c717e054f5mr3371147wrs.13.1679429425689;
        Tue, 21 Mar 2023 13:10:25 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm12107693wrr.46.2023.03.21.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:10:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 0/4] clk: add BCM63268 timer clock and reset
Date:   Tue, 21 Mar 2023 21:10:18 +0100
Message-Id: <20230321201022.1052743-1-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315122605.28437-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Also excuse me for the delay in the v3, but I totally forgot about this...

v3: add missing <linux/io.h> include to fix build warning
v2: add changes suggested by Stephen Boyd.

Álvaro Fernández Rojas (4):
  dt-bindings: clk: add BCM63268 timer clock definitions
  dt-bindings: reset: add BCM63268 timer reset definitions
  dt-bindings: clock: Add BCM63268 timer binding
  clk: bcm: Add BCM63268 timer clock and reset driver

 .../clock/brcm,bcm63268-timer-clocks.yaml     |  40 +++
 drivers/clk/bcm/Kconfig                       |   9 +
 drivers/clk/bcm/Makefile                      |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c          | 232 ++++++++++++++++++
 include/dt-bindings/clock/bcm63268-clock.h    |  13 +
 include/dt-bindings/reset/bcm63268-reset.h    |   4 +
 6 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

-- 
2.30.2

