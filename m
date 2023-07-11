Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9A74E7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjGKHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGKHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:25:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037F10FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992b27e1c55so654671066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689060293; x=1691652293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldbk7xLpFOB3wCnK+tsupp7O8c/p1x/Bm1IetfW9AlI=;
        b=L/rnDHmJ17PrZ5VqsKFLoRY5xluqgw+zr1cfhGvQnDJOiTjjm3ZKrbthIu92zrNhtd
         LFz2HnEVPcrMPENKFYUN1Qk4d6GlmzlZIbAHHMEbdBjRlnL0gBpFfXhVyqSXWOJDY0JP
         s//q0nNhOH2xisfAUaLjIv9Rq6O62BwJSxzZ+ow7QBBrrlmfN0mlw3TaXkudJg9ZmgbL
         Nw1M0l4dh/fgJL2tlgt8pu9r+cDUCtMxCBNgkorKjNz4dJO1coQoZaYyqQWaXd/1K9s3
         ZHmdTSQNiM6amY6qouOiefTLhOThom7akyZv+OewUokTWfgjCO7LPkMjI/m1pMVOlUpr
         eBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060293; x=1691652293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ldbk7xLpFOB3wCnK+tsupp7O8c/p1x/Bm1IetfW9AlI=;
        b=HxTX/+v3WIAlD83kupFW0s5esQ/3i6LU0RJhf5Zq3O+yRvGqDo+/gpBy9s96a+fWhS
         8lvOhACurZBL/Q2gc5fsYNWySNiIO0dA5w7y68rUpISKSdZ1qfx1nczP0BW47lS4juI6
         YbElp2eA6iqRa7KYEcRuWa6LjKbB622NJgDZe/G20SyMcaoMWEO32wJo3VGbXlSMfR1c
         /1wRilFoLpIpMjG2F+UqOhCi1Bz0CB8xwLPSthWlBm+hFCLD+HIn6zQ8XrwTfHaRSL4/
         BaF1Ho/zV7UH5MY4Anql703c9zI+jiyqWL5ouk8qEU6lbJpskC3R5RjOmFb4lqRQwNb5
         akfA==
X-Gm-Message-State: ABy/qLa2+nlzfIQv36BbjmDsBhAvEzqMmooioJCyblBU5ywo2TKl18aQ
        i2iChhn4Vn2pPR1i2jWM2MkHcg==
X-Google-Smtp-Source: APBJJlHhfoOc84FtHVXz1DcmlEuisRTHYTafMAd34Khzbo10dUyC/XXQU02y4Yt/KROkX0ofMaeBqA==
X-Received: by 2002:a17:906:f1d0:b0:992:527:8466 with SMTP id gx16-20020a170906f1d000b0099205278466mr12774296ejb.76.1689060292724;
        Tue, 11 Jul 2023 00:24:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id se18-20020a170906ce5200b0099329b3ab67sm763758ejb.71.2023.07.11.00.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 00:24:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] Input: bcm-keypad - Correct dev_err_probe() error
Date:   Tue, 11 Jul 2023 09:24:49 +0200
Message-Id: <20230711072449.43569-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass proper PTR_ERR as dev_err_probe() argument.

Fixes: a2c795b696b2 ("Input: bcm-keypad - simplify with dev_err_probe()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202306261505.wTjCXRIO-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/input/keyboard/bcm-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index 05b09066df84..bcc480ff7c3b 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -367,7 +367,7 @@ static int bcm_kp_probe(struct platform_device *pdev)
 	/* Enable clock */
 	kp->clk = devm_clk_get_optional(&pdev->dev, "peri_clk");
 	if (IS_ERR(kp->clk)) {
-		return dev_err_probe(&pdev->dev, error, "Failed to get clock\n");
+		return dev_err_probe(&pdev->dev, PTR_ERR(kp->clk), "Failed to get clock\n");
 	} else if (!kp->clk) {
 		dev_dbg(&pdev->dev, "No clock specified. Assuming it's enabled\n");
 	} else {
-- 
2.34.1

