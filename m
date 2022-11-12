Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F501626A31
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKLP1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiKLP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:27:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340B2BD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:27:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h10-20020a1c210a000000b003cfd7f339bdso563609wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mXXJcui9invCKSajdMsWFF65GV4m/GwJm6Tby6vEzEI=;
        b=WfmNsXilQB4YSgyzC3wLHUx7Xqyh/3a3GsizX78DobZ6sQHAVSbqttWXX77796Ohb5
         DipqAs/0xJ95K9KW41alK9xdUwe/mwwqapDq5rIdpSdygkYrirALKHO891RBIWmXR3OJ
         oZr5X93IYKmU3LPp/R9AzEM+JZ5PRjZVgKNBrk5pT0ISYKYWbVfiIPDvXnc5myjr8Z9l
         Dh5xWTg21c/D1hX4kMndJrbIIT0TO7i9TAwELEOvzzrD5w5NJqGLVLSEbUrHvxVyKmhm
         gMRob9Lu13O05bC087U+bFDYshUJyq0BqM09oDMB3IxH01vp/9LJSHjh4eeIM4F8k5Sn
         KIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXXJcui9invCKSajdMsWFF65GV4m/GwJm6Tby6vEzEI=;
        b=WMYQ0PJKv92H0sPuA0fMm1McokekY+jW87Qy+OdYPqOveCb5UYlUVOQS4CEXv0IU6L
         i/tsYuYTm/cmOIw9TgqTIi3GmxxgzFahZdHAcaYHBtcvIFbcL5L443fo5uWt/6Hc7p6W
         p+gTVXW0LrqFH0yTb2u+jMjUKgtXsgZCZZIM8IhpIS0dy9XRK2mMqxWuQDfj/zu5TtY5
         WbKOK8Nvpc8NEIWvHKHGQ5q+TAdO7exHW4V0xpltNNa9P7cX53oPqUsdqZVUpluiKiCz
         tT9nUjLhvq+SNXseGz3XEw7s7oTdU7ABxFWgW8kcRhwqDQCz9bFb3uCeOA+JdTjoka7l
         8Zig==
X-Gm-Message-State: ANoB5pnc7jFXxqQU9Ze5o2ApXMVFrayoxGcTIu/74nEsZpZOuDtoibog
        Wq1PaOKFboJ5zxZ+hAHud1Q=
X-Google-Smtp-Source: AA0mqf4BAarskj/YdALJOuxL9Oa6NyRbLlZDCfkhNPh+eYMRzvbNDYPY2kbWLDyszluEDKfAUrISXw==
X-Received: by 2002:a05:600c:160a:b0:3cf:54a5:b7ee with SMTP id m10-20020a05600c160a00b003cf54a5b7eemr4098707wmn.106.1668266819322;
        Sat, 12 Nov 2022 07:26:59 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003cfbbd54178sm19180982wms.2.2022.11.12.07.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:26:59 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: sl28cpld: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:27:01 +0000
Message-Id: <20221112152701.41990-1-aidanmacdonald.0x0@gmail.com>
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
 drivers/irqchip/irq-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb354413ffa..f2172240172c 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -65,8 +65,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
 	irqchip->chip.num_regs = 1;
 	irqchip->chip.status_base = base + INTC_IP;
-	irqchip->chip.mask_base = base + INTC_IE;
-	irqchip->chip.mask_invert = true;
+	irqchip->chip.unmask_base = base + INTC_IE;
 	irqchip->chip.ack_base = base + INTC_IP;
 
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
-- 
2.38.1

