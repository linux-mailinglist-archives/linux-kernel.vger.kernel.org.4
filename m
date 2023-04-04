Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9CD6D6A83
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbjDDRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjDDRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A195BA3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so133624761edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyKUqzjTOS4NtnX4zkx/hkORtB7SmmNghDilqsPIWHE=;
        b=PweQcIJph41f6Ud2YWqxtd4OZYP7DsTJMVCpchAWMks95EFNcz925CzpqCPc23EO46
         0C6vuO2x4bR8eqjzE3LC1MX5AGL5lBjHzlGapi8uxIYVtRT5rYY2TC2QlwIfu8JZ2XgK
         VJbzdW9yb0B0DOczw2Klplq6XdMfefPMF6U8OXDy03awozo67cswU9yJqutFs+9D/YjP
         hiADlmMbv92DCOK5D2+QxVyUidTm34BjlQSJRQOFhgoOH/g8Qk4mjeiAVIEn3V26zLl4
         qfEC1gIqtGVtiTAchGTxkXKQTzim/GCaxtvnMhd4y8wtwjSLouVsBa4mVfV0pGKPIbnh
         xLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyKUqzjTOS4NtnX4zkx/hkORtB7SmmNghDilqsPIWHE=;
        b=5oKUfKtU4P1JZpX1cu6IYoDlTABIO3FMSsWbLs2GIkkuRf9JQPg4u+Iz70nAP3yGTL
         zcOJ4k6t+geDCllx12dgEtCpn+yj/+3qdXGoEyYTTuBHsFoY6NBJajqFdDjvBLjTdMaL
         YCpZDaEwHeQbaXamTHdkPh7Ac5g86bXqjwCqvBm2PRrfi3Iao8VNwuzr400MUQ34O3zk
         Bms4Mx9a5loooBOBAnNwsMbzVjK+vD1/+Vhm9qTSBC7s6IWApjScxZwtShX/ygxfIMkL
         mFkqL7Nvp7+RW5o6dHHgcYuVAhBEmPmYAYXZBhKJl3+7qkQOhhgsBIcutxkGHJstvjFB
         0gyA==
X-Gm-Message-State: AAQBX9d86LpzxRYRNUVis7ihP0kperZLzIM1WAnRK9pZPUHTgQyOLiD9
        IWTOv0n0QslB9AvUG/qgBlUslA==
X-Google-Smtp-Source: AKy350aHo0Zarrj6I6c/SdCpH4cEPlwnImtQHdOmdUqwJc5wMeC36wlOZk+NHu0QSqOvujRHBFCL4g==
X-Received: by 2002:a17:906:718f:b0:948:d1af:3a11 with SMTP id h15-20020a170906718f00b00948d1af3a11mr286864ejk.50.1680628993561;
        Tue, 04 Apr 2023 10:23:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 37/40] nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
Date:   Tue,  4 Apr 2023 18:21:45 +0100
Message-Id: <20230404172148.82422-38-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Stop open-coding the module init/exit functions. Use the
module_nvmem_layout_driver() instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/sl28vpd.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 9370e41bad73..9cc1715c2fd5 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -146,19 +146,7 @@ struct nvmem_layout sl28vpd_layout = {
 	.of_match_table = sl28vpd_of_match_table,
 	.add_cells = sl28vpd_add_cells,
 };
-
-static int __init sl28vpd_init(void)
-{
-	return nvmem_layout_register(&sl28vpd_layout);
-}
-
-static void __exit sl28vpd_exit(void)
-{
-	nvmem_layout_unregister(&sl28vpd_layout);
-}
-
-module_init(sl28vpd_init);
-module_exit(sl28vpd_exit);
+module_nvmem_layout_driver(sl28vpd_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-- 
2.25.1

