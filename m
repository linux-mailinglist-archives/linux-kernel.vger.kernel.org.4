Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBED6023E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJRFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJRFld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD4A3F69;
        Mon, 17 Oct 2022 22:41:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pq16so13004993pjb.2;
        Mon, 17 Oct 2022 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg1dNJF1vhKWQF5OI6LtaWfps2s1BCKrpVH4Il7rIdQ=;
        b=O95+mzHEcle2Ir6v0uacACuy02++l9p0omhzJtlOZhaUOCfzfMRpr6PHgmTCaPrP73
         RiNvXFopkCF0RpH6YTipn9qSU4snxvXBTBFdNA6j7qaMS04d3MRn6cR+iTO8OT6sKuSk
         0p1W2NWPkEdxkQ7eL02U9TTLZI53eI+pHjHcRv3xL8gTEehwI0J/2gcZiOIULLBot69c
         eN3YERgjVVeNVoDXFUBCu6XAncWUaOMkPZ2TK+dAIGNKpGpIgh2yn2u7fgaGHIHO5+hs
         H4acQX76HiAl87hNKkf858IFZiMj79BzLi7P6ENsdjmhKnl8iCrDr6vgAYtVQ5p9vlb8
         VTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg1dNJF1vhKWQF5OI6LtaWfps2s1BCKrpVH4Il7rIdQ=;
        b=jNUedwNXZbM/j+AR8rA7WbCUXF5UP8d34H8U5rj/Q9i7f0YkJ41lifbKzgYPBuuSG0
         U182CQf6bEOvejVjgsncr4FAPI112Sx/8nx4XHZX2zEimUD6ZTWNKJjZaiNYRPcgYYIJ
         E7y/AD7s/IcHhJBTFSh6WUqqabuR3tslSz3PYse6Iu0/mSKdwvIOJULvO0z2eju0UxKs
         PxT8/lkE5nHjijdazL4iI1gz1w397kUf0D3st6Nvnv4QJ0PIlqu71VuYbVA2u/8hnAEe
         Ov1dqCJeUTtwyDViP1V2w/nmmHAv4t/YbPdWckWLGKLe+yPNE3sG1s9swOyyE6ph36Bd
         LaZQ==
X-Gm-Message-State: ACrzQf3nvu88pitCmVt0OGSEoEZMF1AIZchb0piphQlHIizUHedymeVS
        j/PSYDOII9FaDzYgHqKSPs0=
X-Google-Smtp-Source: AMsMyM5TXIErFU1qFPq8kS0hh969nSm3FNAZmi0hgmHSHZ9HOAFSf5JXBUNzhXCfwoX9Fw7Hni8JZg==
X-Received: by 2002:a17:90b:2691:b0:20c:d655:c67d with SMTP id pl17-20020a17090b269100b0020cd655c67dmr37605795pjb.36.1666071683285;
        Mon, 17 Oct 2022 22:41:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:22 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 04/10] gpiolib: of: add quirk for locating reset lines with legacy bindings
Date:   Mon, 17 Oct 2022 22:41:05 -0700
Message-Id: <20221011-gpiolib-quirks-v3-4-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

Some legacy mappings used "gpio[s]-reset" instead of "reset-gpios",
add a quirk so that gpiod API will still work on unmodified DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 7d4bbf6484bc..2b5d1b3095c7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -382,9 +382,18 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		 */
 		const char *compatible;
 	} gpios[] = {
+#if !IS_ENABLED(CONFIG_LCD_HX8357)
+		/* Himax LCD controllers used "gpios-reset" */
+		{ "reset",	"gpios-reset",	"himax,hx8357" },
+		{ "reset",	"gpios-reset",	"himax,hx8369" },
+#endif
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
+#if !IS_ENABLED(CONFIG_PCI_LANTIQ)
+		/* MIPS Lantiq PCI */
+		{ "reset",	"gpios-reset",	"lantiq,pci-xway" },
+#endif
 
 		/*
 		 * Some regulator bindings happened before we managed to
@@ -399,6 +408,13 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3007" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3104" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3106" },
+#endif
 #if IS_ENABLED(CONFIG_SPI_GPIO)
 		/*
 		 * The SPI GPIO bindings happened before we managed to

-- 
b4 0.11.0-dev-5166b
