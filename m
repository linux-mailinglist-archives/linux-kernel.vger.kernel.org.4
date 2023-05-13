Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5489701A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 23:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjEMVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 17:43:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334E2720
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 14:43:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf21bb42bso80106785ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684014200; x=1686606200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFqA5Fp34TBgSDS7XHhZzOf9NoT5Y8oq5mDAcsTBZAs=;
        b=gXOXeb7IbsL1IVT9HYI3Ylm4h7MveCHnqhIqzLOa3oZHd3/5AlWRU5fUzCHLiqvcwk
         tSj5sCU4GIpN8rsERESGywaoILF2epo7S69nNb5RlHrDuXqMBTHLxmiEyXpzlphJJdXX
         O5fuu/EKBazBNGcGehwI0oYvLeOiBjYHVOX9CcwLRZrFzmSC7FObAkNUHnVZyoTN/l/+
         XOrsRPDBpoayOfS/cCmzc2cBoMHg4g6K7n8kIb3kmuJzyiOWzuoHG2zW364FpfSpHMDU
         DmrJhbP693mbcz1hyWDUJEAStIQJ7w5d+M3QDQ2kFViZ/48Pr5PMt+dHxB+K+6k26MO3
         I2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684014200; x=1686606200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFqA5Fp34TBgSDS7XHhZzOf9NoT5Y8oq5mDAcsTBZAs=;
        b=ltnZzEaZk7nkgoxGXxOTPWbCPY4ofaMCEqIchL8frXrBUcoQMvuS+Ia8ygyq8s3XIi
         tgxoIU5N7KYWcjCs26XXNc5Ehmc0ojARv5NjtlQMjQSohd09eCZoOCDFWjucdEjteZYD
         enNpZqCuWCWa6Nz3ieA4vW6xAQAPmCJZwSNeHcF2nOIog3TXMUsjTTeLEaByIkfR4P2e
         zJ01ncvJ/SeoqXPau9Kab5ZbNSp9VYNnMdoyio08sbC+DvspgirjSRFU8SJ/hZaGRthn
         ZXOR04RY2fwtUo3zIwf0kqPzHErzdr2OZvNWsav1AzkveOHXbXm7KQNe07Se3+5TXeUY
         rNig==
X-Gm-Message-State: AC+VfDxMAVstxqzNmRAAFI43HYyJN3FNmvepXF14r26SpFh+r0youLT9
        3q5d6Lf6pbQ2a80NLgZVMP2mP6fduzhUPg==
X-Google-Smtp-Source: ACHHUZ4ttVT9tp2heOUWTFqiLtK8SrrSIzByFLnlIsU3687NFfgUYS6VlNZ5nFgd1uQZ5yogM8BN0A==
X-Received: by 2002:a05:6a20:7d8d:b0:101:166:863f with SMTP id v13-20020a056a207d8d00b001010166863fmr24264699pzj.23.1684014199568;
        Sat, 13 May 2023 14:43:19 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b00634dde2992bsm9060328pff.132.2023.05.13.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 14:43:18 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] axis-fifo: use devm_kasprintf for device name
Date:   Sun, 14 May 2023 03:10:27 +0530
Message-Id: <20230513214029.122689-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Replaces devm_kzalloc and snprintf combo.
- Also made the fops alignment proper.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..8b46699efb34 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -720,11 +720,11 @@ static int axis_fifo_close(struct inode *inod, struct file *f)
 }
 
 static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	.open = axis_fifo_open,
+	.owner   = THIS_MODULE,
+	.open    = axis_fifo_open,
 	.release = axis_fifo_close,
-	.read = axis_fifo_read,
-	.write = axis_fifo_write
+	.read    = axis_fifo_read,
+	.write   = axis_fifo_write
 };
 
 /* read named property from the device tree */
@@ -820,10 +820,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
 	/* allocate device wrapper memory */
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
@@ -861,7 +857,9 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	if (!device_name)
+		return -ENOMEM;
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
 
 	/* ----------------------------
-- 
2.34.1

