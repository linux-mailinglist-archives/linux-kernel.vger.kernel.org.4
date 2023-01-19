Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C46673FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjASR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjASR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:28:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EB47D67A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:28:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1811598wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qzug9pLoxRuQXnYlv7XgDcrHUWACV82JptfG9Z4/D4s=;
        b=QbQ+xtuogSjENXvuyQHvcBc+32t2eHBeMI6TM7rGc5E/n9VjD0JiQ0xDLxWk5JLDiW
         9n+vkvnjzxKrkmxQapT8ZQNJtTHYsILzs6i3pCjsdvGuPWWgPXt7QcCnLlXIM7TJ34ZF
         fRQCrzHfsE4fUlpI4OmgUk7WTZdRGcVN4seKNiS7lxLB823RToSOFSNliSV3CpNQTepO
         giBfIh3YKY85HDfCjhPB2EFSRlcT90XANR9Ua0VVH8fR1/JVYZU2be/HrujPTe6mw2UA
         KlJTx8w4VH+DFQq07YrJ3O2Uek8o/MEr7UUPvSjJkbr9TcWbsoKA1D+sCtZOQLkbiOth
         lgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzug9pLoxRuQXnYlv7XgDcrHUWACV82JptfG9Z4/D4s=;
        b=eokkC8CvcK4UkDNC7qFI7jtQ0dfbTIpUXG46X5l9jlBIXJ3ijWhGlWvF1ulnfWqRNG
         CSwo5n10EPB1J3idUaDGzcTIxvxT5hBQb1i63UAs0yp5Hc6OYa6aJEHwPxmprkqpLxud
         +WUbWRDr0jDKD232o+yV+1+FZ+JH4koMQWpXtZuYKoEDvKrTpJeMf7PZi0rWVvoV/+8s
         +EGkyL6CHCqUPhUapYcvnxLDCF7+rHGrZ8EN0uO5ewY4A8QCxJZ9WJSM915AIZYF7M11
         sTJHPaKZkVeFWCrXlwifIWi5hy2QyBydjJouo9VEtzOrdsael4F9Ik5Ur9ufCrzpGCBf
         l8Ow==
X-Gm-Message-State: AFqh2krCeRe3uzZ58F0NE3vlNIwWUn/7qBS4Wonx7RCF04vSJKoAzvth
        VRtnExMoJj8AHXzc7D+wIf/JiW6CB8At8cSQ
X-Google-Smtp-Source: AMrXdXvE4JbSwyhINg/vGJhV3TJVbuG9yiJGQSLKxogSjADoupUFsnQPqxFTdf59WZc19Q/vzSxYNw==
X-Received: by 2002:a05:600c:1c01:b0:3da:fc07:5e80 with SMTP id j1-20020a05600c1c0100b003dafc075e80mr14344237wms.12.1674149316600;
        Thu, 19 Jan 2023 09:28:36 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm124186wmo.0.2023.01.19.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:28:36 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 19 Jan 2023 18:28:20 +0100
Subject: [PATCH v2 2/2] spi: spidev: add new mediatek support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230118-mt8365-spi-support-v2-2-be3ac97a28c6@baylibre.com>
References: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
In-Reply-To: <20230118-mt8365-spi-support-v2-0-be3ac97a28c6@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=61svYXCZ66IwrOCd3PQBt6hGhHxViuxrH5xxuI0gaAc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjyX3BZ7lIoc0AZFKip7TYkMJRfcUdwbQhZSjn7YMf
 k4V70euJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8l9wQAKCRArRkmdfjHURaGzEA
 Cse+twuYNDKqhiv19vFcsZ60OAjlW4CXdtrhyIL2bHptTaSOg7JyNtOnjB01lKA0ya6rS+u2nW9j4o
 hlc+8MaBCChk5X+kzT6BM85SGzs5eHxzRPtmmjklTRsc0xFcfxK5kxtNc+WWGfK7YqjjkYNF1KEm9L
 M9yThVqXvmICYWj/Pmf+fxPlIcKby79BQV3eb6yAPIkRbhjO12OrzYxwDyNlctmY8QNEu2ZCWsq1j1
 rylE9a+t4Ell965hDseNAepDxAYyP5WtRHb5CbPfQEWlAVYJES1wf93kp6mCqZivGj5ZiU4jgfVchT
 O/hHqW4bnnEty1df+gn6fma7UIRbGPUQ+5b4CF2ptY32XBGzz3QLNwSX4u9GS94GUeynGFKT8e9Us2
 JjB8I+Y5DRMU6ux8selSaxjEnPDzi6T1TjstPjxaqIlKf28oTc+HW/1JyyGUa/EnD6CuKTRxBJcaeG
 AkbykIGzMz2FmUoj6DeUanMvm7On3ePP/H/IE5i/Pyf1N+Sz9HoWuu9iFpM32VjqbKiKdGsBy1UEOE
 +l+qx1H/8f5znJAgGMHPZ7jC8xxfLqrqKFpjje0QnYATaTStBGDizhldbyKbgle80Dsplt1P6ly3kl
 zOSUllGmhlkbclA+RUuAPROB1nqFcWFwMD8j09sCT46hgHJOxKH/jVhOMadw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "mediatek,genio" compatible string to support Mediatek
SPI controller on the genio boards.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..e23b825b8d30 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
+	{ .name = "genio" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "mediatek,genio", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);

-- 
b4 0.10.1
