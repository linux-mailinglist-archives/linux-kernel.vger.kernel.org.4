Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867B5B8A21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiINOO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiINOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:14:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED27653;
        Wed, 14 Sep 2022 07:14:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w20so3195323ply.12;
        Wed, 14 Sep 2022 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ocPUhQ7OBcduPbHu7i7Q6uCtqSpEiO9mYjpvwrjHSrU=;
        b=O8wvaWEqLL1t3LzrppvIU3K3DamCenQ7WgK3GMrIEz/hFW/AEzzbqueTe0Ax9ftCFZ
         /OJK+P6TDMuvHouMturAUk6/oPUn4wrs2lC1DFpra8VFiFJG1dths2WeplKS2Ro2ZZO4
         XVkrCigwE9ZQMmcn3c7jFHMLNRK/xLL5IY2dzdnQMjJZWqXLoGvGxcn4eYicr0h4co1D
         C9jnZLs7Hw/qqafQ7ER4TveclMylQdyhwr4adEsOcGU/xQAJhuL3siuEUMwx52L5gdmf
         vnyc+GcrY3Ot64GAwC+s1HwRCF0T8NpI0ANRMNB6gmtSnQatBss4YAcMShy8WfvK0wGG
         fFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ocPUhQ7OBcduPbHu7i7Q6uCtqSpEiO9mYjpvwrjHSrU=;
        b=eKmakddBEkQREzspfJRthaTJyzhHEMQJDbdbNCfH7reY6UveN2dW3J0HvaoZCIQUXH
         ZgLEVprzoskc0rrn4X6+ItxbpxpDzvfLpQ3nB/J4YYPchHixkAtI6LBT4rzIFJVVV6De
         K3K3HsGoJ7P0VFaLPhoSfUcXM2NbTpsm4OyhiSUCOiAjVx5g48gyBp/uIKevNA+u0jSd
         qID70D/r0k8alccaIPIdjUWjFqZndLyeL+rShqy1VNSdtcYzj2fNciYPzPyYKMAKAZZz
         fEH5zA8/p9kuJYhJsOJSf6e0xOnmCVjaoYtxawjp91L6vj8qWMei7ZKx7L7x7OyJiPTD
         bHOA==
X-Gm-Message-State: ACrzQf36QVlvhwzh44nh9Uz1jWNEwIDan6rsHE6lDaroCDGX1jRQC541
        CHrPi+eZg9TJI0YsBy5nNLY=
X-Google-Smtp-Source: AMsMyM4xYEvk4HqDFT0iYLxNQAkRbcLni2YcyHUxIXAP7eHDKzlB6g1Wx4T39e8KYmBJZPf7J+2dzg==
X-Received: by 2002:a17:90a:7c07:b0:202:7292:900e with SMTP id v7-20020a17090a7c0700b002027292900emr4988557pjf.37.1663164875609;
        Wed, 14 Sep 2022 07:14:35 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017839e5abfasm6480624plh.263.2022.09.14.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:14:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: auo-pixcir-ts - do not force rising edge interrupt trigger
Date:   Wed, 14 Sep 2022 07:14:26 -0700
Message-Id: <20220914141428.2201784-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hard-coding rising edge as the interrupt trigger, let's rely on
the platform (ACPI, DT) to configure the interrupt properly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/auo-pixcir-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index c3bce9fb2c94..4960a50f59ea 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -612,7 +612,7 @@ static int auo_pixcir_probe(struct i2c_client *client,
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, auo_pixcir_interrupt,
-					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					  IRQF_ONESHOT,
 					  input_dev->name, ts);
 	if (error) {
 		dev_err(&client->dev, "irq %d requested failed, %d\n",
-- 
2.37.2.789.g6183377224-goog

