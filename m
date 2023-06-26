Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930673E663
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjFZR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFZR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:26:14 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB7AB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:26:13 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3457cba78f3so14844575ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687800372; x=1690392372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAa9/qyqoIOUnYhC99LNfoissbeamAdrpMuCz28sW8s=;
        b=H7zijVZ9COkKnC8EPRrq0SG3bgmwwD4JD/ym7AGril6FAWmKwYPiTnmRm+uTCXiYrV
         3Cnd/INrDqhDJQToc37RsQd2bw0lUmbz+L+2LIur1mo3m0/akE1hqdtuxAyNSTPgqyD6
         Vyh/o6lP7U5Hh0EVqcqKGizcYaT9V4qIO6tg06VvRIMpBBaEYlQwLXZfbjOGfAteYyuG
         imlXyaxx5bK9XHbXUYCPhZsaXZri/2yMPFRMyTbKAjTGKAY4H5H5Y15qjeILlxgzn4fD
         3QpHy9j4aDe8fF+A+ja630+GEGHBJ7Svrc4nFrTZ3ZM+Fk8bmf+kVQjFHeNEtDpFG41H
         ViFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800372; x=1690392372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAa9/qyqoIOUnYhC99LNfoissbeamAdrpMuCz28sW8s=;
        b=igByy/ZI/B5ENEYYVml4evCfy8xBprzWcHmWRJCEGqgobooj7B197GUmlud4PYuvgM
         fXu19lOfvG4yLnlOX1BvhE0oolU63Ti5RN+KYWCBq0ZpNFgG+O2CzUgJz3NwvXyl+G3q
         8jhJlNX//aJQRiBo/F8ET4yW4ViNfvfOXQjbyugNpQrkB5/mOk/F5WVC0OFTjgJpdkfU
         z3+3VBLk/2Xley9bnR8AgaPIBSXtZ42CaL5RCDJQuSE0Ezlvt3jfsjrR9n5aUvNr9S7i
         ixQbgOpQnJQfFbHBtzcBmcz3qxvm/62xc0m9TsF+ssCrQ5nECUotTjBxW0S3b7aotXmp
         65Kw==
X-Gm-Message-State: AC+VfDyyGnSZqgp1yBQRG6EvznFtwwf7fSQGLzFpBI3OiAq/ZAfQHVqZ
        PXaGb7ah2G/swKROACsMaTzliw==
X-Google-Smtp-Source: ACHHUZ6RhZwQfHzkxUhFwFFWIzRQlw5p95P6F2U2d7QYXTJkZAt/nhSYpUch6hK1aPN88nc7hZ+DmQ==
X-Received: by 2002:a92:d30e:0:b0:340:72d1:69a with SMTP id x14-20020a92d30e000000b0034072d1069amr31425660ila.28.1687800372473;
        Mon, 26 Jun 2023 10:26:12 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7838f000000b0066a6059d399sm4026648pfm.116.2023.06.26.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:26:11 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] gpio: sifive: Support IRQ wake
Date:   Mon, 26 Jun 2023 10:26:08 -0700
Message-Id: <20230626172608.2978505-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each pin drives a separate interrupt in the parent IRQ domain, so there
is no need to set IRQCHIP_MASK_ON_SUSPEND.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/gpio/gpio-sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 98939cd4a71e..c2653313f3a2 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -150,6 +150,7 @@ static const struct irq_chip sifive_gpio_irqchip = {
 	.irq_disable	= sifive_gpio_irq_disable,
 	.irq_eoi	= sifive_gpio_irq_eoi,
 	.irq_set_affinity = sifive_gpio_irq_set_affinity,
+	.irq_set_wake	= irq_chip_set_wake_parent,
 	.flags		= IRQCHIP_IMMUTABLE,
 	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
-- 
2.40.1

