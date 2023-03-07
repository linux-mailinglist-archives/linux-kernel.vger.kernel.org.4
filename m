Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680C56ADFF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCGNGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjCGNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:05:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45445AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:05:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n2so16924398lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1r1zyYA9t+QO+JcvGnUo/RuruD1eWdYkbb9TESedm0=;
        b=XI0UmKS1DqsLREENXEyfQRgiR7jhCtGsIzKxy49toW+kuBW4SQlQoHVh0hwV6jFcu+
         aYbUbgsFyN8oj7PPp3WcL7Z+4F+Y094WggSBSS8z7xY8qPeUN+l160jmOr9Y1LqPqvqR
         wR+mqRS3HlNIGJLI0cGBYiV4m/pVb3+pheIdC5rg6RwjNpDB+UyT89JZ8zC3s8HHi5Ug
         RzKh+pgaU5eyNQr6uSTb7kraNJTBjxGsxAtXkqsFGbP3YA3jEMaBgHB4DWd2ZX8l5i+i
         hl9GEpV2AMq7t9uy18J8uHMpSIul0CNfP4FqaSw7oV536zICcuz4cUiypiBR31J2CElz
         QRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1r1zyYA9t+QO+JcvGnUo/RuruD1eWdYkbb9TESedm0=;
        b=gan2ZCsHXuVLoeb0fWOFLz3zMPQUhbNsdRm0+MNEALLtawdjmuqamlknEeP4f57kTv
         N3AmnmA7bBJ++6hfI/paXQLVd/CQ5iQ5v9xQAaou5EsZzNcJ34nXqO53NDaehj2CUJIk
         e7ISmz9zpryc9VcckAuTonIbPSYXuQnAW3zp2tirxitrac5nlVmbNnG8Isca09w+3Gt/
         hYVnRPajJCkiFtK9seY13rjWRMxbo1KqG5Fql0QdIsIuZIjNUNmrutval1pV05x3HqXc
         ta7/B4KUJaNk0hAdYf0M/Ya/bvVioYK0jRDPyoYxJvzP+Rrv6MvTlDKk87C1mrfC6QMA
         tmBw==
X-Gm-Message-State: AO0yUKXas0+oiEFC6ROJHYhctV0t1V3L7fd+4sMBbbJUwPLqL23ZRjvl
        4GE7NOC6hGHBMRa0QukTjEb0vw==
X-Google-Smtp-Source: AK7set8LiewOjfSfMDSVpT8vLK4Kc41jk8YyNSr17wtiD84vpf6AnEv3OouhhoZf4ap+crKisrs+/g==
X-Received: by 2002:a19:7418:0:b0:4cc:73ff:579a with SMTP id v24-20020a197418000000b004cc73ff579amr3664898lfe.38.1678194299039;
        Tue, 07 Mar 2023 05:04:59 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004caf992bba9sm2030548lfn.268.2023.03.07.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:04:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Mar 2023 14:04:55 +0100
Subject: [PATCH v2 13/16] gpio: omap: Drop irq_base
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v2-13-d6b0e3f2d991@linaro.org>
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
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
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

The OMAP1 at one point was using static irqs but that time is gone,
OMAP1 uses sparse irqs like all other multiplatform targets so this
static allocation of descriptors should just go.

Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-omap.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f5f3d4b22452..1cbd040cf796 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -992,7 +992,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 	struct gpio_irq_chip *irq;
 	static int gpio;
 	const char *label;
-	int irq_base = 0;
 	int ret;
 
 	/*
@@ -1024,19 +1023,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 	}
 	bank->chip.ngpio = bank->width;
 
-#ifdef CONFIG_ARCH_OMAP1
-	/*
-	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
-	 * irq_alloc_descs() since a base IRQ offset will no longer be needed.
-	 */
-	irq_base = devm_irq_alloc_descs(bank->chip.parent,
-					-1, 0, bank->width, 0);
-	if (irq_base < 0) {
-		dev_err(bank->chip.parent, "Couldn't allocate IRQ numbers\n");
-		return -ENODEV;
-	}
-#endif
-
 	/* MPUIO is a bit different, reading IRQ status clears it */
 	if (bank->is_mpuio && !bank->regs->wkup_en)
 		irqc->irq_set_wake = NULL;
@@ -1047,7 +1033,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 	irq->default_type = IRQ_TYPE_NONE;
 	irq->num_parents = 1;
 	irq->parents = &bank->irq;
-	irq->first = irq_base;
 
 	ret = gpiochip_add_data(&bank->chip, bank);
 	if (ret)

-- 
2.34.1

