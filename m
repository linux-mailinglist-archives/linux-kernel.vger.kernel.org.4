Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE26A475A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjB0Qya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjB0Qy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:54:26 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522816AED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:25 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id ev13so4836358qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL8rTLnPI0v/Bf06uo5tSLz64haWBpxVRoB2gA76eRA=;
        b=VKAf7oy0X5iS4amGN3vs+O8lZCfYImCXu71dohaP3yvGeZE7rx+FWjJiffiXUV7KR1
         9fGoTzG1OmxvLWGvDNme/zf9aUe46VXBFNfDGcJDVK7zLbCioJOn0RQvEsmTM3FAvBaC
         5+JE+fQebeux8d5lGccVEeInYnY/3YCrilCxa9XQSPDJ1Pd7NQiApFjmNWvkOH1FR/Dz
         s2BDQV1bOlF1YAI3svRVXt+p9CntMHufYFIsdSwt57q9ZU9dz+3MTStgzvf2zIY84Kbu
         si6w2CyGLXfoBzbzIV8LhlhtvbWEk6cuJoHNQO8Cq1OMXsGMKhDHlDR6NhBLKgR2nkiv
         J7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL8rTLnPI0v/Bf06uo5tSLz64haWBpxVRoB2gA76eRA=;
        b=veqO25riz30BHlV5rxOqUMYmrSeMvnYxcMQi+kAsoVVo7K+lCWUGGncLYTgsZcDv7Z
         LtexML26pJHxMpkohaxDYyEm+3aO1DnAinr3R8bVjnXCJRO+IrlGMbCQt7wb9fR51kw9
         qBxti9Sc59t8HvRNOCwYzTfvBi9wcX34US8YNEx77um3OZUynMZdS7ejm5ZfsQ4gvHy9
         qiupMiPBXsKKG4PBbYEKjMbNdUnvOlsZPLO7NLde4XkcexQjOr5uNT1+O1ABl1aVrite
         fBA8dYhSf8iaEmk4dc0SLWak7FzcubuIDM9rrgEeMPgrT17v7FaRkmWEH/8dodiMzXFh
         8AWQ==
X-Gm-Message-State: AO0yUKW57o0kbgmZCm4LJxLEhhy1kJmSx+rZK0mXJbp2G/+QTHDomGRV
        adtoLRdX6/6CZh/WJiVUTSEWJw==
X-Google-Smtp-Source: AK7set8zLN1AA1N7+2q0wTgldIqfC342d5e7Pg8O4fzHJgoAE8tAxTig4vC3K43uw2zmIJDFNojFQw==
X-Received: by 2002:ad4:5d68:0:b0:56e:b251:a8e7 with SMTP id fn8-20020ad45d68000000b0056eb251a8e7mr401934qvb.2.1677516864521;
        Mon, 27 Feb 2023 08:54:24 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a098f00b0073b929d0371sm5238714qkx.4.2023.02.27.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:54:24 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/6] gpio: 104-dio-48e: Utilize no_status regmap-irq flag
Date:   Mon, 27 Feb 2023 11:45:23 -0500
Message-Id: <06fd817ac5549d039e9d04b227ca7b310f36aedb.1677515341.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677515341.git.william.gray@linaro.org>
References: <cover.1677515341.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-DIO-48E lacks an IRQ status register. Rather than use the Clear
Interrupt register as the status register, set the no_status flag to
true and thus avoid such a hack.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index a3846faf3780..fe3c93bfe4bd 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -195,13 +195,9 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 		return -ENOMEM;
 
 	chip->name = name;
-	/* No IRQ status register so use CLEAR_INTERRUPT register instead */
-	chip->status_base = DIO48E_CLEAR_INTERRUPT;
 	chip->mask_base = DIO48E_ENABLE_INTERRUPT;
 	chip->ack_base = DIO48E_CLEAR_INTERRUPT;
-	/* CLEAR_INTERRUPT doubles as status register so we need it cleared */
-	chip->clear_ack = true;
-	chip->status_invert = true;
+	chip->no_status = true;
 	chip->num_regs = 1;
 	chip->irqs = dio48e_regmap_irqs;
 	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
-- 
2.39.2

