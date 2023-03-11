Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4896B5ADB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCKLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCKLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4D14210
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:17 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so30620129edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV/dLCNcysuQ7CKaIgag1w22Gn4yS1/4xn0PDWGs4Eo=;
        b=aewFZRIKniBekuXeMaGJNez/58uZHOVwAjNPwR+B2kHBdCJ63CkilQSENhCJYv1pG8
         zcdnWH8Q+yGhNsdegLlOpHWz7AwkjhUo95EFhrKrhmzfm1bOy3rn2FLD0oFpAV7LWLEj
         v3vF0mvNf0CiJkdaUGzWtA0y0C65mtU2nG6C7ACOubceuA5VnzGpt7TduSKrg1nOpJRr
         ia6lVsJaLdTEQsL1KCrPsaeT7F1X85eZ/ho87my7n2LIlKlqaRn762ULmRFIxorqevxu
         JVa0UPmb8expOEojDdKdP9vfyvMKf7Aja4zcK8MX/wkFeoGATANvM2Dl7hg0aqiNPoxQ
         Zqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV/dLCNcysuQ7CKaIgag1w22Gn4yS1/4xn0PDWGs4Eo=;
        b=Aq/YccW3UuOZL0VVijEKGzke1r9z9wUWtK2E97kq9sfcEabxolvHTFhYsdv2JdrYL3
         HXv2hegc5LSqr2hEkWB5ccYLAHygu48UN4pn2HSm1Hebacm0qfH528jEjWYzg5Fp3D35
         E6gCx/Apd+7vKIT3SP6Yw1Szj0ZTcUXvrsN5psjOqiCFdQQhwK/cBmGx7VN2BKNSM6Ez
         BgiiS7EBOAX9Axu4ln4oV/FbRHEwRSCQQbXeAI3BANbLg5mVoiSfIf3rpcku6jTfKp3V
         SMyH2V+sME/XsJw01ZKYkbNHUbbdamhfXGihQHkIRbRJj3UgRuwrzKEobznIyNEaNJ9P
         /2UQ==
X-Gm-Message-State: AO0yUKXzVHidemvKJKd50OyErpz/e4qAROSpxWWq+PTFB4CNjU37Nil5
        PSzrq56Iaoq/D/A3e3Tze5n9Tg==
X-Google-Smtp-Source: AK7set+zT8di1EH1vwo5WQtIvhf3MGOHHVEN7hy7axJP4iQDi22LYOiHLEsY77pHOuQpGOh2MpfNuA==
X-Received: by 2002:aa7:d78e:0:b0:4fa:d75c:16c6 with SMTP id s14-20020aa7d78e000000b004fad75c16c6mr515662edq.38.1678533196359;
        Sat, 11 Mar 2023 03:13:16 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b008ee95ccfe06sm973189ejv.119.2023.03.11.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] gpio: xra1403: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:06 +0100
Message-Id: <20230311111307.251123-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/gpio/gpio-xra1403.c:198:34: error: ‘xra1403_spi_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-xra1403.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 49c878cfd5c6..51d6119e1bb4 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -195,7 +195,7 @@ static const struct spi_device_id xra1403_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, xra1403_ids);
 
-static const struct of_device_id xra1403_spi_of_match[] = {
+static const struct of_device_id xra1403_spi_of_match[] __maybe_unused = {
 	{ .compatible = "exar,xra1403" },
 	{},
 };
-- 
2.34.1

