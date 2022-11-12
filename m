Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A115D626A25
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiKLPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiKLPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:19:59 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB01A82A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so4884939wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap2jtLcVXjGUxCK1ExvNFdVQ5+yTHfCLRbLs7VE5qzs=;
        b=Wa8gR8dxTsB9aBeo9EOvBSB5wnOpwbFnbNSss0twylMwCRJaAwPuJ1R3wlev5GGayg
         uEscH1BofmP9pBKc8TpaqOpzhH9s6WaboIaDyo39go3TA/YxQX3QYOIhfi9Eelbiczjk
         aY0n1WJsAClc815GTEMdEwcXcqvx/jvK1qIvugA3z4G5qMFm62qnRFfivfxeyPiPr7uq
         iwSkSCVMZ2Ur7eOUgAwEA7XJFp8OnIKSnhbryoOwwUjXhFQIU8ZvOVY6BR8zQ0Xgs0mH
         aDQzSImPREnYZrdAl//hKp+fDv80EIxl+PpC/+BY/BgKB2YzqMLhaVhlfIAmMCtqLqXL
         gXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap2jtLcVXjGUxCK1ExvNFdVQ5+yTHfCLRbLs7VE5qzs=;
        b=H+VMJi/MWD6bPI4xYws4CgV781n0uKKNWeLa6Dp9pwADETNmn1wMottqEz3rHMytl3
         mNMNGswwhu/23eWkscYqxSc5jfZaLpohlNYX2MeMzqbgu94L39N8KQDFVHMoCeN2XjSD
         Bk0oi/tdXFWvhPXTCdPVkMpm46IPR1IooFYLMzu8XT8xXsXdHfHMsQf0yMsODKbeY7fn
         7hvj2Sut6Rj52wGMxuEESrRGKaAE+i3s0HH94ae2WnTSngNbztRzPtkhDBumocEiYKgo
         FBJakoglZ1zmKgydHHdIHf6y269AW1Wy8sGLqk4Hi6y2Q0BfWX4yGrui0lCL/QoQTUWi
         3TCA==
X-Gm-Message-State: ANoB5pkS5h5LyS+uiWaSHUtcA94k1NtirB51akhWFOqUslsGA2WDjD2C
        CP5r3YJVXBKowPDPe4MAILM=
X-Google-Smtp-Source: AA0mqf5bOBbPUFnCu5eXhAwvqF7hO0snkQhVP3/uHN9qaP+T9rxZMK0RDxSiWVqGV2ASkQvUOSNcgQ==
X-Received: by 2002:a05:600c:44ca:b0:3cf:89c5:c241 with SMTP id f10-20020a05600c44ca00b003cf89c5c241mr3954405wmo.204.1668266390188;
        Sat, 12 Nov 2022 07:19:50 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002368f6b56desm5460994wro.18.2022.11.12.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:19:49 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 14/18] mfd: sprd-sc27xx-spi: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:18:31 +0000
Message-Id: <20221112151835.39059-15-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d05a47c5187f..a4a9b81a952b 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -181,11 +181,10 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	ddata->irq_chip.name = dev_name(&spi->dev);
 	ddata->irq_chip.status_base =
 		pdata->irq_base + SPRD_PMIC_INT_MASK_STATUS;
-	ddata->irq_chip.mask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
+	ddata->irq_chip.unmask_base = pdata->irq_base + SPRD_PMIC_INT_EN;
 	ddata->irq_chip.ack_base = 0;
 	ddata->irq_chip.num_regs = 1;
 	ddata->irq_chip.num_irqs = pdata->num_irqs;
-	ddata->irq_chip.mask_invert = true;
 
 	ddata->irqs = devm_kcalloc(&spi->dev,
 				   pdata->num_irqs, sizeof(struct regmap_irq),
-- 
2.38.1

