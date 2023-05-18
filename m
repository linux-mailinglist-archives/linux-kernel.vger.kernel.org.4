Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81992708444
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEROwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjEROwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:52:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE44ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:52:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae763f9c0bso2066705ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684421524; x=1687013524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ruq/Ywhniwz2wuJubZoPfwzby3RDyAXkxxglK53ZUJw=;
        b=N1ZgO1d689rsieyP7SA0NjCb2E4BHwBum86VY4w4VXvX3JA2AAIoKeyVuTnC8qac4c
         4Buv5U+g74H40WFcEiScbvS3SOJy7T3q4lD+UUAH9hj3Gf9dDKxYOxd16GqMeTikonkD
         87h03NxtLcj2h31IsfC5piAbvJ9n1iJxbyRsqTnqLDVo9XMbRn1E3zgTDJjjX6S5EYOm
         P9KgJH1xg7hCSSCnCZcDr0q51HNXdWKhrTtaMgclwDQ+pGoI0K1f38kMkOm08fYkR207
         JwOF/Fm4zpUpPwtUNYqyeahPQzYKYwmED6cSWiqH+ZALxtGOACQnLKFyXQTV6AErB88U
         vQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684421524; x=1687013524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ruq/Ywhniwz2wuJubZoPfwzby3RDyAXkxxglK53ZUJw=;
        b=bQmM/cvEtmXrZhlwgw7sGcxmBdVY6Woir90GFXgHWMZHBqcpfYpxUvyH2iR0wraIrE
         9jfsheiD2brfWGBWP8MC60xhQ//+3VF4bFluTYyKxFCM3tFvxUjFOQ9LTMbZtk7+Q0VB
         Rpd46Sio0gDrcGQGnCLGeGweTtMKiaoe3ex59ykCDlNdw0t7yTitK4wg2uZRIKiYIdCA
         7kxJgaT43Y8Sakeyj+PyHgOKbdeaylKqpxnMv3M8fzACk8XWQP5IHDoMhDDEyOirlmvy
         iWUIQX7kOTLIDxFzU0PUdw4jyRfsIaVjQJnjuLWH3pllWxw4Io6/zFc/vlHedrklf7W6
         KhfQ==
X-Gm-Message-State: AC+VfDymR4LCN6lPnML1iVDya5SEh7/I2DoXHs7LYGYgW79rlXud1HMA
        +6KqXfGWg8kTpPrW315tG6c=
X-Google-Smtp-Source: ACHHUZ6uJgpLnQHI+VVzbFAn/3rWSLWG2ukFMlyVufPY05bqlAlbkliLhE8tEzKxD1Gcx67LKfFhxw==
X-Received: by 2002:a17:902:b218:b0:1ad:fc06:d7c0 with SMTP id t24-20020a170902b21800b001adfc06d7c0mr2889304plr.1.1684421523753;
        Thu, 18 May 2023 07:52:03 -0700 (PDT)
Received: from redkillpc.. ([49.207.202.99])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001ac741dfd29sm1506647plb.295.2023.05.18.07.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 07:52:03 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com
Cc:     dan.carpenter@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        oe-kbuild@lists.linux.dev, Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 1/2] axis-fifo: use devm_kasprintf() for allocating formatted strings
Date:   Thu, 18 May 2023 20:21:53 +0530
Message-Id: <20230518145154.33377-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
References: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
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

Also fix an old smatch warning reported by lkp introduced by commit
d2d7aa53891e. In the mentioned commit we had used "%pa" format specifier
for a void* type and hence smatch complained about its use instead of
"%p".

Fixes: d2d7aa53891e ("staging: axis-fifo: convert to use miscdevice")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305150358.nt1BkbXz-lkp@intel.com/
Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
V2 -> V3: Fix smatch warnings from kernel test robot
V1 -> V2: Split into logical commits and fix commit message

 drivers/staging/axis-fifo/axis-fifo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7a21f2423204..d71bdc6dd961 100644
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
@@ -857,7 +853,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
 	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	device_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%pa", DRIVER_NAME, &r_mem->start);
+	if (!device_name) {
+		rc = -ENOMEM;
+		goto err_initial;
+	}
 	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
 
 	/* ----------------------------
@@ -906,8 +906,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	if (rc < 0)
 		goto err_initial;
 
-	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
-		 &r_mem->start, &fifo->base_addr, fifo->irq);
+	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%p, irq=%i\n",
+		 &r_mem->start, fifo->base_addr, fifo->irq);
 
 	return 0;
 

base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
-- 
2.34.1

