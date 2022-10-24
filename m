Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496E060B61B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiJXSsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiJXSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:47:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D21120BF8;
        Mon, 24 Oct 2022 10:28:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y10so7023428wma.0;
        Mon, 24 Oct 2022 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vrMEaRTOwjPGYos2d/zehtmsU3IkMfRxjv+/1fbd3Q=;
        b=VKJ1G1o7+2+SQele4larDZ/2K25UrUVVp54Nrve6h20LExDBaKHIClcbBnpbrrzvyk
         WnWyToK5iRYdzsch3pSLsG9Hqwe8ZjdpZKvuIE33xS/WfWt+GK7OMY6gPqIJ7u/9X5es
         KxKivLyP7x9AmhjGc8iwzBixaN4zLaD6rREhMrdm84TnLUvF1dUgQv3nHZicWWEJWrwT
         soU1/txlsKhDtZwzOfy96JWzJn6olk6EIXZMh86SH0shMUspuBx5cS/xVRtlvye6uKiq
         78fTBDDQfXkpdKrIZlsvgJOXcrQLaU6Nnz9OunF0l6uFeL6OR/y1cYRyclV8VLnXLK93
         6btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vrMEaRTOwjPGYos2d/zehtmsU3IkMfRxjv+/1fbd3Q=;
        b=gcuoiVl/tAvF7hVCLgPxnWAuXxLcWXrGA3ARSvq/4BPNw7TH+XdSTlXxMR4VVcQVV2
         FU++KDQP2zwIF8UfLvFTvPK4uF/tvONcN/wEuACEQlH/94/RzwHuaapvyz56EPeuC+4h
         d+vmrVkhN7NcJMGrFaTshyNMWuC1QYvTwVfHATaDRc94OiyV5Z92erkM7gJ5siUr+GsX
         +0vD+NirsdRRePvnZ7LD3KfZgyuhohGf1d9sB/Izx0CIgitQci9szkfVWpcPvzHZyoQG
         oF4eEhurFBcFiaZCnRo0NXUXp0UGvE28QqP/9H8VG4pVlnLBh5iGameVi3G74rQCRCz/
         UjSw==
X-Gm-Message-State: ACrzQf2jJn9/Hs6Qt5Ggky22oFjAmpssHKKdhHK7PLsmhRDRkcATgXjt
        CQ1gbUvCoNHtm0q6/ZJUon+YVWwD77l02HD7
X-Google-Smtp-Source: AMsMyM46DTJTSuuP9DKHEnco5O7iTBp1tIwmtk2u/tX203ZYgVIXhOZKuUbIOH6/cBGqYy2PNgPhfA==
X-Received: by 2002:a05:600c:3b11:b0:3c6:c02d:babb with SMTP id m17-20020a05600c3b1100b003c6c02dbabbmr42613493wms.69.1666617328451;
        Mon, 24 Oct 2022 06:15:28 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe307000000b0022cbf4cda62sm32201847wrj.27.2022.10.24.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:15:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: samsung: remove variable pin
Date:   Mon, 24 Oct 2022 14:15:27 +0100
Message-Id: <20221024131527.2156810-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable pin is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 625cb1065eaf..78b7bd133566 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -509,7 +509,6 @@ static int s3c24xx_eint_init(struct samsung_pinctrl_drv_data *d)
 		struct s3c24xx_eint_domain_data *ddata;
 		unsigned int mask;
 		unsigned int irq;
-		unsigned int pin;
 
 		if (bank->eint_type != EINT_TYPE_WKUP)
 			continue;
@@ -534,7 +533,7 @@ static int s3c24xx_eint_init(struct samsung_pinctrl_drv_data *d)
 
 		irq = bank->eint_offset;
 		mask = bank->eint_mask;
-		for (pin = 0; mask; ++pin, mask >>= 1) {
+		for (; mask; mask >>= 1) {
 			if (irq >= NUM_EINT)
 				break;
 			if (!(mask & 1))
-- 
2.37.3

