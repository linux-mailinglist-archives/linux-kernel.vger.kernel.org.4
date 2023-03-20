Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6F6C0DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCTJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCTJzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:55:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040C5BB5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x17so14132578lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679306114;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLcRecY4IurzeYGepE8N1+JONZ5XYr+wjjJNzOWAqBY=;
        b=HDoNBMSCxam0/t+IGp2epNMQAJJ5tUHM384qKl5sewn/e7sZZz8G//l0WjQGZ9Y0Hu
         MNfWTjcmCW8TaXaHvrHG1CyGWLzTm8U5zwY14JLETPIt+b537SqNtl4hzl6ZSWkSQj9H
         u5sP5KjumCZitZeUKfzimfI3EbobnA5rN26jszFk42YVNZchEkaKOXI+NX0RY8OcsSmR
         gc48XGUclmJLnpEhAEex34qOIarSP8bcwebuRmhEYvuor94Z0Liw29g0PRw20rhD3J/U
         GRue9v3d5c8J4uga5nn4Dha3qkV6eRVaeq9RmY1X/NAGQui5CvSoHZwWafDtbD0duIZq
         t8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306114;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLcRecY4IurzeYGepE8N1+JONZ5XYr+wjjJNzOWAqBY=;
        b=0PsWH+UiYlrUdc2x4BzmSZP+WeE06PalyFaFWb6bQsRtSuLokuJl0T7x02F+24XR58
         X7x7tX54hMZfQlFDc/lIOiy8Vo522pCZAul7ScxTGUfjWj7ZJrYzjmYgaIIXpeWq8Yc0
         8cyawPz3sB52sV9APxYU02tAR+wCtxXG+Eh9fgJrs0S0OMp9aKuOLSb1az75R/noKBqN
         PRxmnInHzjI2+bnKVWWRmOba48wHciSUee93m5ZSidef9PSlTWap8U4UVo/b7G5yplju
         JaHp5gnnTpQOP6ZPNLz08/+PfzBkPziMlXMaKkBT4/A3qVsqTHZm5GWC6sJtMuQ5tYDY
         hvXQ==
X-Gm-Message-State: AO0yUKUL0kMQDvcYjgqx7ZG89Gv1tNSMR6FwMeQX7YN6BUrMDxA00pQS
        pnZWvwNc1H7Pf4Apw7skxz9tQMBHeglsvimRAL8=
X-Google-Smtp-Source: AK7set+nwU6isBHx8JOiQQkLLqlKYNWzFoGlQOBBzIDvTgOy7DPWByuQtSAP1zptVBwRdRH8luzvmA==
X-Received: by 2002:ac2:51cc:0:b0:4e7:fa8a:886e with SMTP id u12-20020ac251cc000000b004e7fa8a886emr5392863lfm.51.1679306114054;
        Mon, 20 Mar 2023 02:55:14 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004e792045b3dsm1640104lfm.106.2023.03.20.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:55:13 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/9] Mass convert GPIO IRQ chips to be immutable part 2
Date:   Mon, 20 Mar 2023 10:55:07 +0100
Message-Id: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHstGGQC/x2N0QrCMAwAf2Xk2UDXqRR/RXxI22gDto5kijD27
 3Y+HsdxKxirsMFlWEH5Iyav1mE8DJAKtQej5M7gnZ/cNJ5Ran0vFJ+Mqchs6JGyDy7kGNzpCL2
 LZIxRqaWyl5VsYd3FrHyX7392vW3bD6EzupF8AAAA
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robert Richter <rric@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on my first series with this second series
concluding all the low-hanging immutable irqchip conversions
in the GPIO subsystem. These are all I could easily
convert.

The remaining irqchips are not using the GPIOLIB_IRQCHIP
for one or another reason, or too complex for me to
deal with. Mostly they are using generic irqchip, and
I guess those are fine as-is.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (9):
      gpio: rda: Convert to immutable irq_chip
      gpio: siox: Convert to immutable irq_chip
      gpio: stmpe: Convert to immutable irq_chip
      gpio: thunderx: Convert to immutable irq_chip
      gpio: tqmx86: Convert to immutable irq_chip
      gpio: visconti: Convert to immutable irq_chip
      gpio: xgs-iproc: Convert to immutable irq_chip
      gpio: xilinx: Convert to immutable irq_chip
      gpio: xlp: Convert to immutable irq_chip

 drivers/gpio/gpio-rda.c       | 22 +++++++------
 drivers/gpio/gpio-siox.c      | 75 ++++++++++++++++++++++---------------------
 drivers/gpio/gpio-stmpe.c     |  8 +++--
 drivers/gpio/gpio-thunderx.c  | 26 +++++++++------
 drivers/gpio/gpio-tqmx86.c    | 28 +++++++++++-----
 drivers/gpio/gpio-visconti.c  | 50 ++++++++++++++++++++++-------
 drivers/gpio/gpio-xgs-iproc.c | 32 ++++++++++++------
 drivers/gpio/gpio-xilinx.c    | 23 ++++++++-----
 drivers/gpio/gpio-xlp.c       | 14 ++++++--
 9 files changed, 181 insertions(+), 97 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230316-immutable-chips-2-ad2808db8054

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

