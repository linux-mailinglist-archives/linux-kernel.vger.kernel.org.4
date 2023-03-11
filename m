Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC8B6B5B11
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCKLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCKLSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:18:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8513B96C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so30817734edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpnl+M2V2t2M7c/qkafGNUaGGwLh5ogi8KYJ5aST0kE=;
        b=oZIZ+nJU4slGa50z6O78H0tyD/xLRPVEOBUaJdUoEEnz21Xx3mbPG7xOx2Qte97FCv
         GmYDIU1hVWAZaYfPstmUZNC3wsiCi8MTBspYw5Y1GCh0UtgJy4Bgyl76gy9D9qP7nQLm
         VtwSYx+Bkon0NEvL3ByZ7SReB2UJyLslm5gUrvzU0LWnZJaWcNQnMT9AqKUzIHTVLk9E
         HVrLFf+KmsdFezSt6vk/ElxBYwo2rPpoNAHFV8+uPvf/em5lOiOMXjtxb8zvDyUQqtT8
         3IZlKL22RoNsEpT3AC5K4bPxR66ZqWcPWrCUEGz/0hHn/1QsDPnR5ceNM2N9JhirLeNm
         bGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qpnl+M2V2t2M7c/qkafGNUaGGwLh5ogi8KYJ5aST0kE=;
        b=y1PfuqFkWPvN6OMPElOHt4URv52eOS+M4hoK1m8r/v66F7d24dYsSmFWVi/a5Ldemk
         9IEEafQoE9+tPwaaMFPOyqv5ztTKpdZVw/ZQU5hV8yXRE8Rmb11GLQPrV841dMtCNhfX
         utNvbwM7YXof0ScciGPtwV/vf97xeq24lvv/baK+PO6pn77+Xl8P44vL62S+2RQRoasq
         ru1Ej46NhtnWCnRlnwlJ0bV/k2U/xGBIB6MAqg+f5XZpP+duiiyrYnl3cdqIBPNZK27w
         KeC+vXZ7X7kPbto3RBLGzu5+mpIiBsrAVEy4sq2Bgu/6c953OtMctfHdnuG4kPlv0uBP
         eddg==
X-Gm-Message-State: AO0yUKW65Xe8ckDj4ugKBdhvi4GlLkmBc42/gOhx16KqotziUuwQz1cC
        syeTWcNEkWA4sO/rBIrir0RqfQ==
X-Google-Smtp-Source: AK7set9KNp37LBqWH1gDs6hjlXv137prGkMKtwyJMdZE4Z4A/Iw9cURwWdEd4HtjX6znK6gNcmr5rw==
X-Received: by 2002:a17:907:80e:b0:90b:53f6:fd8b with SMTP id wv14-20020a170907080e00b0090b53f6fd8bmr35888669ejb.31.1678533390764;
        Sat, 11 Mar 2023 03:16:30 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906939700b008c5075f5331sm981016ejx.165.2023.03.11.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:16:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] mfd: atmel-smc: Mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:16:28 +0100
Message-Id: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/mfd/atmel-smc.c:326:34: error: ‘atmel_smc_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/atmel-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index f3bad2b52f17..e560066e5885 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -323,7 +323,7 @@ static const struct atmel_hsmc_reg_layout sama5d2_reg_layout = {
 	.timing_regs_offset = 0x700,
 };
 
-static const struct of_device_id atmel_smc_ids[] = {
+static const struct of_device_id atmel_smc_ids[] __maybe_unused = {
 	{ .compatible = "atmel,at91sam9260-smc", .data = NULL },
 	{ .compatible = "atmel,sama5d3-smc", .data = &sama5d3_reg_layout },
 	{ .compatible = "atmel,sama5d2-smc", .data = &sama5d2_reg_layout },
-- 
2.34.1

