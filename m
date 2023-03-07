Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761C36ADFC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCGNFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCGNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:26 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D870193CD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:04:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so16923657lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpj9iowK+fUp1eAd8JepT37zZC9XqDcnhD9hDARq2kU=;
        b=JyrVtTmOCBIoOhyPdDdC18qctC1k7zocllhJ3F82qo4ju64IjASdsxHZ5LbSWxWdSp
         qVV8eZeaHm2+CzX6q/TqnSUbEV2PVAl5SPusA3wxaKCHCWuyAttPKXJ0x/OP1149kTxr
         tVYNUtMZrWK1zPFfefu7Er/bh5FEqV4Lj4prZaTVXMMt9Zjo05BF82u0KmHuold1L+7V
         fck0z0YSuJE1bKOiEm1jdwbd12qrmPoU30BMUs1D/LnnLypE3gF5ZcwyA/sblnsKXhgw
         LWP10pUJnyFXYuJNc9KUnuT7JI3l58FhKby2F/7bUkUJwtHissEnY1oATIKvFccvsb0W
         bIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpj9iowK+fUp1eAd8JepT37zZC9XqDcnhD9hDARq2kU=;
        b=ik3q1oN/VoCcvMAb022eFO3Ibe4unpnzz5lKTYc/eh5uGpAuS24WBZn14vrROp2VFb
         OLEICzm3E+Bgeyu3I+Z8KqBazYnnPrx6gFY2xt7GZyIe5MSMhpEwG4h+CurbAo2QBx1K
         6BdY9EOkPZCSbN+4t6/Ig4D9uvvyhYuLtBLxydschugwQqQb7tBtIC+dMuyhHog59Pj5
         RTSDMC9/+mPnjBTq4+e6vOZbvRfGfhBEAIMi/iGWTlIP97iOWpkLfoxvI94E7gYlEW6i
         xkFerzv9RfIvr9275EsZUElOOSfuANI97m7Eo/Y0WYE7hZ5kLqnaEp9BQdfeG2/SuB0S
         zl3w==
X-Gm-Message-State: AO0yUKUawcN0s5Lu7tiw9SeC8sMt/E/iUN3G2Lwou+B6nREzdFVOFaus
        pEkD8bMnEuvIOkgCSgFU5+Djnw==
X-Google-Smtp-Source: AK7set8ZBJPsO7wOSF+lK/f+NWLqzFtFZ2FzVIw604jMt6Euc+RP3smHoaHmTDJGMz9+VxRsPQSfyg==
X-Received: by 2002:ac2:483a:0:b0:4df:51a7:a92 with SMTP id 26-20020ac2483a000000b004df51a70a92mr3942917lft.11.1678194287438;
        Tue, 07 Mar 2023 05:04:47 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:47 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:44 +0100
Subject: [PATCH v2 02/16] gpio: adnp: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-2-d6b0e3f2d991@linaro.org>
References: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
In-Reply-To: <20230215-immutable-chips-v2-0-d6b0e3f2d991@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-adnp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index a6439e3daff0..9b01c391efce 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -307,6 +307,7 @@ static void adnp_irq_mask(struct irq_data *d)
 	unsigned int pos = d->hwirq & 7;
 
 	adnp->irq_enable[reg] &= ~BIT(pos);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
 }
 
 static void adnp_irq_unmask(struct irq_data *d)
@@ -316,6 +317,7 @@ static void adnp_irq_unmask(struct irq_data *d)
 	unsigned int reg = d->hwirq >> adnp->reg_shift;
 	unsigned int pos = d->hwirq & 7;
 
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
 	adnp->irq_enable[reg] |= BIT(pos);
 }
 
@@ -372,13 +374,15 @@ static void adnp_irq_bus_unlock(struct irq_data *d)
 	mutex_unlock(&adnp->irq_lock);
 }
 
-static struct irq_chip adnp_irq_chip = {
+static const struct irq_chip adnp_irq_chip = {
 	.name = "gpio-adnp",
 	.irq_mask = adnp_irq_mask,
 	.irq_unmask = adnp_irq_unmask,
 	.irq_set_type = adnp_irq_set_type,
 	.irq_bus_lock = adnp_irq_bus_lock,
 	.irq_bus_sync_unlock = adnp_irq_bus_unlock,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int adnp_irq_setup(struct adnp *adnp)
@@ -469,7 +473,8 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 			return err;
 
 		girq = &chip->irq;
-		girq->chip = &adnp_irq_chip;
+		gpio_irq_chip_set_chip(girq, &adnp_irq_chip);
+
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
 		girq->num_parents = 0;

-- 
2.34.1

