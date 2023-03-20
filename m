Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A661F6C0DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCTJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCTJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:55:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2103902E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x17so14132761lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679306117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBy8uglh8gI3CtA/oUcnRDs25I4dMI2aaLdEiGdH3E4=;
        b=VJSWksEl6WxkHvKzPymzEi6mf3ZUeAsMB9WkGKvRi4yYReG0Nz/6sBKaHTNxqci5JY
         nqhyqfT+O4UI8OcnALy74NJgtnZkDTgmzaryyCzE18tQHFKDZaX/vCyj9bmzq4MQwEqm
         7JspHuKpDSc9if5ybl5cxPLcd/u09a8lpVxbPNjMNhC1EVybYUH2BndXo7a2u+IJ12Tg
         Q1W984RSdg1rOcpmKqad1UkvNu2z1qqFc0ZJCIlsvJj3EI3CeUk2I4EBv1NfTJt/teZh
         kfeqyDjdd2/ny+QZeNEIVEdYu9QSsg+sQxIsHwHcN+SGVLdMwzvc1TikYc5i4lF/FyMo
         KnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679306117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBy8uglh8gI3CtA/oUcnRDs25I4dMI2aaLdEiGdH3E4=;
        b=NTQPh6YyNDWMfSl+/t9UgiErwrA/rfk3D0CHnHblbg/4npFMmwibqUIATaJOj3Ybas
         D7Ml3GZ3Oew82h60SCksc388t/1UO/fRwmMYb8Htnm5bpSKHaI8YabCMN6SXlTEjx4k+
         iEDkm7TtRD14yfMQU6T7TH4sTBDSRmcP8/eIZddeFNLoJhOdiyeexpUqyKSAAuOrfSPi
         k2JIbIR7uT9e32zcvde6FddLcERpRV9z1rnUMqFuc8up5S/DbtHZQxMhkS2Bm+e0ojfN
         1s6GcfMrfnt9O960xglEX+QxHsZNhrG/ETahJbbfbbchlbcWONOW/0+uYC1d/fXGWt3F
         zYfA==
X-Gm-Message-State: AO0yUKVl3KJyCG7CuL67vsP80Ptsn7hHH6JhpVDZeZI/0RHXJVCG70jy
        A0T87rM3i7bWLoTCrgAT5I8HoQ==
X-Google-Smtp-Source: AK7set9qOc4rmnFzJJmDKRIXSY9dptpUANbsXnl/EmAKnXz6o60CYgbqOnnyCFdeWMHDggShDpHNzg==
X-Received: by 2002:a19:ee14:0:b0:4e9:ccff:daa6 with SMTP id g20-20020a19ee14000000b004e9ccffdaa6mr939758lfb.30.1679306117176;
        Mon, 20 Mar 2023 02:55:17 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b004e792045b3dsm1640104lfm.106.2023.03.20.02.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:55:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Mar 2023 10:55:10 +0100
Subject: [PATCH 3/9] gpio: stmpe: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230316-immutable-chips-2-v1-3-053d6ede831b@linaro.org>
References: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
In-Reply-To: <20230316-immutable-chips-2-v1-0-053d6ede831b@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-stmpe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 0fa4f0a93378..27cc4da53565 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -234,6 +234,7 @@ static void stmpe_gpio_irq_mask(struct irq_data *d)
 	int mask = BIT(offset % 8);
 
 	stmpe_gpio->regs[REG_IE][regoffset] &= ~mask;
+	gpiochip_disable_irq(gc, offset);
 }
 
 static void stmpe_gpio_irq_unmask(struct irq_data *d)
@@ -244,6 +245,7 @@ static void stmpe_gpio_irq_unmask(struct irq_data *d)
 	int regoffset = offset / 8;
 	int mask = BIT(offset % 8);
 
+	gpiochip_enable_irq(gc, offset);
 	stmpe_gpio->regs[REG_IE][regoffset] |= mask;
 }
 
@@ -357,13 +359,15 @@ static void stmpe_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	}
 }
 
-static struct irq_chip stmpe_gpio_irq_chip = {
+static const struct irq_chip stmpe_gpio_irq_chip = {
 	.name			= "stmpe-gpio",
 	.irq_bus_lock		= stmpe_gpio_irq_lock,
 	.irq_bus_sync_unlock	= stmpe_gpio_irq_sync_unlock,
 	.irq_mask		= stmpe_gpio_irq_mask,
 	.irq_unmask		= stmpe_gpio_irq_unmask,
 	.irq_set_type		= stmpe_gpio_irq_set_type,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 #define MAX_GPIOS 24
@@ -511,7 +515,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 		}
 
 		girq = &stmpe_gpio->chip.irq;
-		girq->chip = &stmpe_gpio_irq_chip;
+		gpio_irq_chip_set_chip(girq, &stmpe_gpio_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
 		girq->num_parents = 0;

-- 
2.34.1

