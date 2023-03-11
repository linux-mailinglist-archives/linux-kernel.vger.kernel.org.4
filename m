Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72266B5ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCKLN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCKLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA2A13DE3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x3so30652211edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wsjEFg411f3j1GspmCDAJvrOGJIOzP6/PbM4Sd3D2A=;
        b=XhfSoLEog6AUz2J6PG6GYohg6cYoVFocyuaGxSFjpkU1pCGqvxorZPijHHSMQi/xKo
         /P0LizNb/zLTXk+vbMrXMpGlmU+jdQg9dAiHeT8/aCRS1sbq6HffoLTmD1eu2YwMS/IX
         sGWA2Y7kTrdUsfwemZA10Gc43Rln2DPpIUAymagKYYysvnv0ZlUBY1Y8/0xWSsB0iOAa
         RAyY7ZOUWIpAX/CnRWX4PdK6wCHSLVHpqv47VIufbYQPX7BYtdCqnYDsQ2HiOT+BgoX1
         TM9CKg3QC0oqE9ZS/8HLT++P2NsNRrZ7VLUs0EbKFvIh6Im+cCvKfF4NPdtAWmOf4MKj
         wQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wsjEFg411f3j1GspmCDAJvrOGJIOzP6/PbM4Sd3D2A=;
        b=0rQvTln3g5U4jnoSXWtijvqn9YZ/zXz2+D8ZMPXJHiGbTRLk1ECqG4qwOqECHIP2rn
         QfbOIotP/mea1bXPUbS6RkpZxObQxXxEgV+BpOxtE+WGhID4ZiqKI3+tG08lilKHthZ6
         Oe3+c1wDJB7kBx/yx8z38y3hPcvn8OYYc03XBJZHQrPG2+qwGvEvJU2r1WHr3rr0V5GH
         lkuUOE25KJgoRj7uVe3N3JBshXuEWHo3NuoCrH4GlmM72IqFsFNL2sVRslBdAB7CWAIF
         Kzwcd/9X8cr4m86cBO36vl9NjpFgKV4ivXHoRqJeQ/kqidEi5XchYF7A4wOqSMMqA8Y+
         3fiw==
X-Gm-Message-State: AO0yUKXei+re4Xc5JJ0WbBenhkAcrRJsZXywjwET6kiTH3+MjFDpYM7A
        mgZmIx3yj6RCbn6UF7HzoIVuyQ==
X-Google-Smtp-Source: AK7set8+yT6UzSrYOGn3LNs3My65y6SinT09SwukP5nlfb5NWOHN8GOPBLSL/652xN3+evwtWbuaFA==
X-Received: by 2002:a17:906:7f8c:b0:921:5cce:6592 with SMTP id f12-20020a1709067f8c00b009215cce6592mr1057307ejr.59.1678533195246;
        Sat, 11 Mar 2023 03:13:15 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b008ee95ccfe06sm973189ejv.119.2023.03.11.03.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:14 -0800 (PST)
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
Subject: [PATCH 6/8] gpio: sama5d2-piobu: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:13:05 +0100
Message-Id: <20230311111307.251123-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/gpio/gpio-sama5d2-piobu.c:230:34: error: ‘sama5d2_piobu_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-sama5d2-piobu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sama5d2-piobu.c b/drivers/gpio/gpio-sama5d2-piobu.c
index 3e95da717fc9..767c33ae3213 100644
--- a/drivers/gpio/gpio-sama5d2-piobu.c
+++ b/drivers/gpio/gpio-sama5d2-piobu.c
@@ -236,7 +236,7 @@ MODULE_DEVICE_TABLE(of, sama5d2_piobu_ids);
 static struct platform_driver sama5d2_piobu_driver = {
 	.driver = {
 		.name		= "sama5d2-piobu",
-		.of_match_table	= of_match_ptr(sama5d2_piobu_ids)
+		.of_match_table	= sama5d2_piobu_ids,
 	},
 	.probe = sama5d2_piobu_probe,
 };
-- 
2.34.1

