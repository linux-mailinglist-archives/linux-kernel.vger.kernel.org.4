Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEA701D84
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjENNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjENNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:02:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952C2D4D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439f186366so7395996b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684069324; x=1686661324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go5sDeHWgIRTWlpjFAmfS/O0gabJcHfa+czJpZGJ7uc=;
        b=H3jA6TBOe0/k3zwh4ceqX9yAKSFAl74DcDo/vTriw5YFg/OwD1bnoNnMlX4i+Z9f3A
         EztT3flDJJr2hVVLAJsh3STO7bUmt5WdTyYPONA/4mPLnwYXyzLF1TadnSd2pSlS+miq
         Opwzzu6KjY3tNs8vf+uZXHFoGj4ijaB9wpVNV3wTcN2km/yxJigRToKpTxTX+Aeirrk+
         bm8cPaMGBTCtzpbmWKta1F6BzYV3Hat2Afa6mBdjelggK3kf/VNa+5pUbUxwShTBlWul
         IEfH3GEU5kajcSaO6Zxe//SRjE4wvKjKnQoZr/3picoqS2opCuCnIFH0sG1j0ZoK+37O
         4D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684069324; x=1686661324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=go5sDeHWgIRTWlpjFAmfS/O0gabJcHfa+czJpZGJ7uc=;
        b=Ohqtfi2qPTMh3spUQxlOP0Ws77UsA+nkNZdwbVYJ97U/5t7iYh/fDiXk7OdnC6Dl4t
         Q5mKX6fBAcGDYh4DvruDfO/1EUBrisYRfSN0toSA/RHDQd7SoTdOqFSAMxWx1VYzgOzg
         SMUvuvtaXwJ/blnWhhcBFQiewQQJ0D4OO3FYqVQy2ANjHKVVn5CK45ALGMrweMnJ7Q0X
         IDurWmPuFVyqgVgEu9j/GrbeGfLm02yDvGdgszcc08iVMUf/dIpTTBtkmBJvzARdGy45
         0GHre0iD41DOz3KfUXFw/rM+kn2uDSNL/oUt9C95i+g1vaVr3z/8a04IOeVBiT3EBBgN
         VgbQ==
X-Gm-Message-State: AC+VfDye9CVl0EXV/vDkuylN9+3qgvfmzn6wfA61B6YrdsW2cLbTYVpK
        w46QgXfmCOPw7pcjNcYoEGo=
X-Google-Smtp-Source: ACHHUZ7L+PNp68VGado16dQgmCiWZZn0n7EfRpzHISPa/LnbdMBBXDgV+ByyV/dt2HBW+29jfi+qHw==
X-Received: by 2002:a05:6a20:1441:b0:101:8cad:6db9 with SMTP id a1-20020a056a20144100b001018cad6db9mr22684357pzi.47.1684069324095;
        Sun, 14 May 2023 06:02:04 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id e35-20020a635463000000b0051b70c8d446sm9766146pgm.73.2023.05.14.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:02:03 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        prathubaronia2011@gmail.com
Subject: [PATCH v2 1/2] axis-fifo: use devm_kasprintf() for allocating formatted strings
Date:   Sun, 14 May 2023 18:31:47 +0530
Message-Id: <20230514130148.138624-2-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230514130148.138624-1-prathubaronia2011@gmail.com>
References: <2023051411-happier-mural-a8ef@gregkh>
 <20230514130148.138624-1-prathubaronia2011@gmail.com>
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

In various places, string buffers of a fixed size are allocated, and
filled using snprintf() with the same fixed size, which is error-prone.

Replace this by calling devm_kasprintf() instead, which always uses the
appropriate size.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7a21f2423204..7b3080202b31 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -816,10 +816,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
-	if (!device_name)
-		return -ENOMEM;
-
 	/* allocate device wrapper memory */
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
@@ -857,7 +853,9 @@ static int axis_fifo_probe(struct platform_device *pdev)
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

