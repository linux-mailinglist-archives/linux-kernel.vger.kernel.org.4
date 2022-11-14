Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68C628174
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiKNNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbiKNNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:37:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E72D24F0D;
        Mon, 14 Nov 2022 05:37:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v7so7519122wmn.0;
        Mon, 14 Nov 2022 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWT+ji8Yb+Swwb/eh8dOGGW5IwdF58UzTtEgO7Ui6qE=;
        b=ZGnBDKOLkWNwQhH3G6OKosPy0cQ2MZ1Hu1xhDoOz+phUNTbFAEql/0Rq+kfTYX1r+u
         t43SUFn+y/1su4lClon9A+ZSejcHVi7gjHgU70YOZvx1cfbBeNuPL5XnVs4JZC7gNlIb
         BhnTeK1UwVY8gPh+wtxRRp3kWo11PB9K7nrFCsMcqchbeVJbKJLz5MS5mZc8u/TTaIW/
         h66aR22tLSMd1N9saQEHACFu66/LdQA7ROfQU1XSfB+EFTWP+AGHEXnplQRDnm/JvOya
         0qbi2/7CeP2U4yiP8t6gZbYLVsYHe5vcsV2qmejalnJXaFl/RIVSVAeBZ6FKvwqbw2fU
         AE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWT+ji8Yb+Swwb/eh8dOGGW5IwdF58UzTtEgO7Ui6qE=;
        b=q4XKTfUrCZHfHCud3Ofz3RUBXIoyX7dqX9BhjiVUnu9CCA0alV3W86HtC4L5tA8cTZ
         eDh14fVY4FyN9Vot4+NkrjL+yyzkKAXWitILzhZljueITFWtw8NmVCudAFcRdSgw5nUu
         x7Hjf2IjZunFCbNu38LSGefdOlEs7KjHr2SLAP4hKLxDBIsbcNG86anzR97d1HqZXzNJ
         EVTYNNoBdTowaGNuQxhj5Hrj6prtSpoiZnBJymOgVtEvIe89lEo32vH3OYReYTdwUull
         GK7keJh0K/BT8/7R8KS0ZupuGquFTk5NsHpJR6/NoAZkGaf0aVw0g5FQUcqZ4mLjoi87
         st7g==
X-Gm-Message-State: ANoB5pnI0J3gJuNndbcATzhrAeTvuEkLsEonmyZDI0aSZnbjJGok88Qu
        BsFgA9iC8wJ8eBZQJWAi5pcaMKiiKBM=
X-Google-Smtp-Source: AA0mqf4+IpKLWPs+M1T9sBAgIj2eJ+/ZHLX7caSyhZrBLLkysLeeRBuG9nbeq0mGThBZiPGGEg0UIg==
X-Received: by 2002:a1c:f611:0:b0:3c6:b7cc:79d2 with SMTP id w17-20020a1cf611000000b003c6b7cc79d2mr8156761wmc.42.1668433025780;
        Mon, 14 Nov 2022 05:37:05 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.3.89])
        by smtp.gmail.com with ESMTPSA id z25-20020a05600c221900b003c6c5a5a651sm12175001wml.28.2022.11.14.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:37:05 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: adc: ad4130: depend on GPIOLIB
Date:   Mon, 14 Nov 2022 15:36:49 +0200
Message-Id: <20221114133649.1737027-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes undefined references to 'gpiochip_get_data' and
'devm_gpiochip_add_data_with_key'.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5bdef39c5c6e ("iio: adc: ad4130: add AD4130 driver")
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8d719fbb6acc..63f80d747cbd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -24,6 +24,7 @@ config AD_SIGMA_DELTA
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
+	depends on GPIOLIB
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select REGMAP_SPI
-- 
2.38.1

