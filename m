Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47A68F337
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBHQe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjBHQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:34:24 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D82B2B2;
        Wed,  8 Feb 2023 08:34:23 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso1780306ooo.2;
        Wed, 08 Feb 2023 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3NLFPMpnZb+miJhy2+iFm0INrDfxWTo0LlkjNOUCi9o=;
        b=PiGPC4/nea7pctVNxbi6ZvRwtz6qW2xC2KTattYqWNIARqnkmWfqXiNOzJwT/RZqwc
         2E525oYGiLdVPQ7Yc7Gm/XD1z3CwZXnrvdVE3Kt9SBrIecT/DstQnSJgoTk+eWh1C8w3
         Gtnw9ZW4FLlCqYAJeQ1N5LbEI8K9/8KMPGgxEVd4wvgxKtmOd/SCHEKwpR0CJXKt1cym
         oseEs+zUnvsaF+78HHzW+8sS88nvwrrhBUc6UQAAp6Cvf63WaMxgHIYf6Kh9F+tYMQ5M
         vJYXBKaY4Wghavls9eesmPvPPeISWUTyV8qioeia1yNzBWio3TBtf6W378ROV/arFlGf
         /3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NLFPMpnZb+miJhy2+iFm0INrDfxWTo0LlkjNOUCi9o=;
        b=3xHFoJc2tKNUDgp6pa0t/XqRUZFO91AEuaWQ0QLjs87AzP0djUFdQjOExZCK47a+cW
         2+B9SUWywG28sdMcne+jyXBNgCRN6zBGJjIuPnmrrsQds+MGprG3viBlgiUpl1hHrGcA
         F2FFfB7IqqAThxIUPCQccF9guW2sfTAukOCT/HuBHbU4ZJd86SqfuSqZNSbdjMX5q+Ny
         bhxr4ARqjn6GvGCh4nkRWRfBu5inUGQIHGVKSA8MPDprbQ9nZGoxuu0LugoPad5KA3b4
         spAqiXCIxcZObwq1TcOhtlyXAeADrSbk4SDU5KiKSjiPsepEuOBE84/geXKCSoXEAaar
         ++vQ==
X-Gm-Message-State: AO0yUKWt+8jtjIcE1NLFoEcpf+cP1VW/98AzxauBUenP/nBv17HKqccu
        4oc/E3plHxUQPT3J17zosN7zEvs8ENw=
X-Google-Smtp-Source: AK7set+Eo/3CGpyueJ8ifKatcamILHyEtR20MglqVLcSVWtl7ipuQoLMU7kPBNA2BWWi7lh3oufSVQ==
X-Received: by 2002:a4a:b6c8:0:b0:517:3f56:d292 with SMTP id w8-20020a4ab6c8000000b005173f56d292mr2569784ooo.1.1675874062470;
        Wed, 08 Feb 2023 08:34:22 -0800 (PST)
Received: from jassi-Alienware-x17-R2.. (wnpgmb0311w-ds01-45-177-228.dynamic.bellmts.net. [206.45.177.228])
        by smtp.gmail.com with ESMTPSA id g26-20020a4ab81a000000b0051a72e69e24sm5930214oop.37.2023.02.08.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:34:21 -0800 (PST)
From:   jassisinghbrar@gmail.com
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        stern@rowland.harvard.edu, Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] usb: gadget: udc: max3420_udc: fix serialized access
Date:   Wed,  8 Feb 2023 10:34:18 -0600
Message-Id: <20230208163418.342210-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Jassi Brar <jaswinder.singh@linaro.org>

 The mutex 'spi_bus_mutex' should be used, instead of the spin-lock,
while changing the state of the kernel-thread. Also changing the
usb-gadget state need not be protected by a spin-lock.
 This should fix the Smatch static checker warning
    warn: sleeping in atomic context

Fixes: 48ba02b2e2b1 ("usb: gadget: add udc driver for max3420")
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/usb/gadget/udc/max3420_udc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index ddf0ed3eb4f2..3666cc44f4e7 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -501,13 +501,16 @@ static irqreturn_t max3420_vbus_handler(int irq, void *dev_id)
 	unsigned long flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
+
 	/* its a vbus change interrupt */
 	udc->vbus_active = !udc->vbus_active;
 	udc->todo |= UDC_START;
+
+	spin_unlock_irqrestore(&udc->lock, flags);
+
 	usb_udc_vbus_handler(&udc->gadget, udc->vbus_active);
 	usb_gadget_set_state(&udc->gadget, udc->vbus_active
 			     ? USB_STATE_POWERED : USB_STATE_NOTATTACHED);
-	spin_unlock_irqrestore(&udc->lock, flags);
 
 	if (udc->thread_task)
 		wake_up_process(udc->thread_task);
@@ -1298,15 +1301,14 @@ static int max3420_probe(struct spi_device *spi)
 static void max3420_remove(struct spi_device *spi)
 {
 	struct max3420_udc *udc = spi_get_drvdata(spi);
-	unsigned long flags;
 
 	usb_del_gadget_udc(&udc->gadget);
 
-	spin_lock_irqsave(&udc->lock, flags);
+	mutex_lock(&udc->spi_bus_mutex);
 
 	kthread_stop(udc->thread_task);
 
-	spin_unlock_irqrestore(&udc->lock, flags);
+	mutex_unlock(&udc->spi_bus_mutex);
 }
 
 static const struct of_device_id max3420_udc_of_match[] = {
-- 
2.34.1

