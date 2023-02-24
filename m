Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD926A1D48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBXOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBXOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:11:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552E2729;
        Fri, 24 Feb 2023 06:11:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so11844630plh.2;
        Fri, 24 Feb 2023 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4kmb//j1ktNG8kl3LbBuVMKD6p3YK/069wRAvDgHWw=;
        b=TcykMEl4to/JjtbhkrUHlTHPm5OIwKQNzidGIJV3kJapLfMnsNFHseNN9NXO6b2nJz
         B1UzPZqqe6tA26FZiJ8VSsb+xBAoTe7k60p3Dg5ll0n4GVUqwJ26mGaGan2TdY328z80
         /+Qe/ZAGoxHJvU5DGd3Yc9gx9vO3IJzWNXL6mZHr29Edm/Au4vu0w8c+xMKyq3Q+hUq5
         cQyHKZhuKo5Yx+ogT9ttbo31fhCgkiYvQHZi9661d4QACXATmfYUojCGHYzSK5pgA19g
         2zfkSoix7jnQkEvCOMW7eoDNGWtGqvsvYsCWkZ9tmlK0auK0ccLU1t6vu9dxGKMdm+Wy
         Kz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4kmb//j1ktNG8kl3LbBuVMKD6p3YK/069wRAvDgHWw=;
        b=qFlejRBMmfBTYOz2wNu/vHFGLVY1uoLZ/reSdp6l4Mdze3AlgvCKivoyMDyyNxetuu
         NjJ011Y2lj4UeFdGtI9oOrS8C1t8A141I3kODmbrlhZVDpqkJGdIieSjTUhi15x/xSnY
         GF+k/Dny6QLjLCMAC9K9aUIt44zr4neeZ86gqpUvEV1b61HvH1WjKb91wxM1CufBb34I
         9Wl7sQesBP/ov6tMx9t2rep0xfbU30SYCsJ+q+uj/ytv5OC0Zzr/Te/a7f23lWttdqh3
         vUwT9z9rRn1il4OKvLbAq57jBO6Wmj41efcz+eHws8JCezpptS+Z5TV9zWVmYuRffbak
         VUvQ==
X-Gm-Message-State: AO0yUKWYJBE6xFPkReDbmSztVkIXgJpj2XoskFxF8kBbuGJGWssfi7j7
        TmIZWNazyE2qh7+5wcwZEoQ=
X-Google-Smtp-Source: AK7set+xkQFO/+y6zEMhXljQhHYgwsZF7Qo4nigJo/50lXTVh9KGLsdPo8H/xnZ+J7HS5WypVvYxLg==
X-Received: by 2002:a05:6a20:9151:b0:cc:5917:c4e3 with SMTP id x17-20020a056a20915100b000cc5917c4e3mr4355844pzc.48.1677247868953;
        Fri, 24 Feb 2023 06:11:08 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id p25-20020a637f59000000b004eecc3080f8sm7115745pgn.29.2023.02.24.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:11:07 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     mudongliangabcd@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH v2] usb: gadget: udc: replace kzalloc with devm_kzalloc in mv_udc_probe and add a check for this allocation.
Date:   Fri, 24 Feb 2023 22:11:01 +0800
Message-Id: <20230224141101.73-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
References: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

This driver uses the unified memory management api, so replace
kzalloc with devm_kzalloc to avoid a memory leak and add a check
for this allocation.

Reported-by: eriri <1527030098@qq.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b397f3a84..08474c08d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2229,7 +2229,11 @@ static int mv_udc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&udc->status_req->queue);
 
 	/* allocate a small amount of memory to get valid address */
-	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.34.1

