Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA09471083D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjEYJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjEYJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:03:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62333195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:03:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so2321125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685005430; x=1687597430;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYMdS4W4N0xwAoPb8PeUMR2257czRWSttZ9zPAtyhjU=;
        b=cWC2chZ38o3WioSon3DB+UowsUGimisgq83DdtqvLCSXahW7tFSqPy0wOhws8adp/W
         M6SIILH+rBXGXibAEwauRzc4AYxN79G2TtgMB2BFwy7rf9r41ce8q/EkSQd7jiQbYyfO
         1tfDAhDrdeHHUA6MvmUUf4OzwuxjJkwCYEnT/uWGq6g/nu7HdCq9khpuU+ZdCHTDYUBN
         gi1kZ8H/M4xFbMVUuB3wm8RT9GxC2uaySgHrnHdxCUdsPe4pnsdmozioCJDFjqfFoU3X
         086rz3ta47a07Vr9zmUO3SiBzSQiyidu1/cxDQhL5tjDm9nNGLGlvSMxQVGRhQmM+4Gc
         6RbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685005430; x=1687597430;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYMdS4W4N0xwAoPb8PeUMR2257czRWSttZ9zPAtyhjU=;
        b=bqiqxyLConMcSkXf9S93CwSZtvBV0GtYSwDLJ4WQq5YzLhSLNSC9Wj2dOr0bv5Saei
         CfSTBFZh78vLo0XXfOEWA1wVAACzYKKF7uHt9cpDE5ivkt3SP5LvZwTVvjBwyrCY4WFq
         vjM2aGlNLayXT9izgcIYLH9rq2/4qDvFdoRrbhJZFSqpvHwtph5bVvELNf2FHaeNq0Q6
         9RanieA+B/vBpL8IRqxkKYZzcHGQsaMZZNndHNB+4Yb6N30yTxCW1+HDO82Xw91ghEr0
         x+ZHnQMoyYLlksWjHGKzvUbYasNDNzglOLWsOcZMJWZ/4mPlWA1aNGbhV1+Zr0O6ke+o
         zKIA==
X-Gm-Message-State: AC+VfDw3eiWdpIQA1Pmi1ISYA87/1zibP7DEY8Sx8DiWZz6ZCqgA9Qz3
        xTX2pI4cf9KNB1NIqnb4EX286g==
X-Google-Smtp-Source: ACHHUZ6Djwi5myjTsK9abqcYcH7Sre7fdm6loFPmXPkLK9oMmY/uwfh+dPbSeKKvEwKiOorlp5EA3w==
X-Received: by 2002:a1c:7705:0:b0:3f6:3e9:e8fc with SMTP id t5-20020a1c7705000000b003f603e9e8fcmr1756328wmi.10.1685005429892;
        Thu, 25 May 2023 02:03:49 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003f603b8eb5asm1396646wme.7.2023.05.25.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:03:47 -0700 (PDT)
Date:   Thu, 25 May 2023 12:03:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mfd: tps6594: Fix an error code in probe()
Message-ID: <49f7cd8f-f7eb-40f1-91e8-291620c684df@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These error paths accidentally return success when they should return
-EINVAL.

Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mfd/tps6594-i2c.c | 2 +-
 drivers/mfd/tps6594-spi.c | 2 +-
 2 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps6594-i2c.c b/drivers/mfd/tps6594-i2c.c
index 449d5c61bc9f..50a3cd03b3b0 100644
--- a/drivers/mfd/tps6594-i2c.c
+++ b/drivers/mfd/tps6594-i2c.c
@@ -222,7 +222,7 @@ static int tps6594_i2c_probe(struct i2c_client *client)
 
 	match = of_match_device(tps6594_i2c_of_match_table, dev);
 	if (!match)
-		return dev_err_probe(dev, PTR_ERR(match), "Failed to find matching chip ID\n");
+		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
 	crc8_populate_msb(tps6594_i2c_crc_table, TPS6594_CRC8_POLYNOMIAL);
diff --git a/drivers/mfd/tps6594-spi.c b/drivers/mfd/tps6594-spi.c
index a938a191744f..f4b4f37f957f 100644
--- a/drivers/mfd/tps6594-spi.c
+++ b/drivers/mfd/tps6594-spi.c
@@ -107,7 +107,7 @@ static int tps6594_spi_probe(struct spi_device *spi)
 
 	match = of_match_device(tps6594_spi_of_match_table, dev);
 	if (!match)
-		return dev_err_probe(dev, PTR_ERR(match), "Failed to find matching chip ID\n");
+		return dev_err_probe(dev, -EINVAL, "Failed to find matching chip ID\n");
 	tps->chip_id = (unsigned long)match->data;
 
 	crc8_populate_msb(tps6594_spi_crc_table, TPS6594_CRC8_POLYNOMIAL);
-- 
2.39.2

