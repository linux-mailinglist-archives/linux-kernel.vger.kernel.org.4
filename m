Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30F0671558
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjARHrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjARHo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:44:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480963E2E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v6so48278817edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGi6nevtBEvlgNue4HrSz3FnhFRGHNrkieQvtpQFYHc=;
        b=YtWCclO174QhyaMA5EVNNQLEWZVxz+9FPz49LoHxX2km/CLtESfB+9DI3Ioq/2Axmz
         ZIdzk2YypknjThU/8BJSCfqmXhoEtefbk2or5M0kiK0rhsMybkXbKV92/dpwpewYjKMe
         ZW8gR0PdnL1d6aDKso6qqZKbCSYwjg5Ay2BQxN93YOG2scLrRlPBe9oYcWi02CteNDPK
         rJiAPrxMv1jqH8YvB4R/0C8J3dBUHG2xj7Y072Bm/LyyBCa4jiK4ztQnApC012ubxC1G
         PA3j01E5IQ+lkOUrNXKe6E0ppjHgCXo99HP3+/2YXjJsTgIMHjEf7Em9bbIcITNwnd9w
         1pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGi6nevtBEvlgNue4HrSz3FnhFRGHNrkieQvtpQFYHc=;
        b=idxpseY55+v1W3Md8pVLjD7ettCWg3TAdMcD9TysfA8cmIIGO39DV/7kK12Pw7wNvF
         GRAweSK4YtP2wDGmQqCWJnkTyT9d1BeJWyNOOm0TZDaOx6dOPm0+/mE6TyE5oPcD68Q2
         Yt1haYtOUe4knGtuwMOq/fml679UY3/lnZPRZk+CSGwYW+pGN9kLM6o8y39iqmADFmxi
         tDaoDfTZgUbvtZSzNnEP3rozvqx3qkiTwTz2bxnK4Z2AAGYG9EaU/uv9D7uO5ejUkp1f
         1B6yfvaDaS3oWZPGTAoGi4BoSaUZ+AeH+jrVC63CV6nm3JulQZT/7yJqvzYupDM6B5k3
         QymA==
X-Gm-Message-State: AFqh2kp9VfE2SMnNeiKFpNsMNEjPT6qA8ieAHEb2+MMqb06fX9G4zmDj
        cKV62FPdOj8TS2INW/iufuZ2ZQ==
X-Google-Smtp-Source: AMrXdXuwTSY8tCFZbjM9bYBnfxUsuHCctXu6vpXm8O9G6S2RSxRklk3QaVS88VNS2HuBjvhxm1j1+A==
X-Received: by 2002:a05:6402:3226:b0:498:1ca:80d0 with SMTP id g38-20020a056402322600b0049801ca80d0mr7193209eda.28.1674025777745;
        Tue, 17 Jan 2023 23:09:37 -0800 (PST)
Received: from fedora.local (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id bt16-20020a0564020a5000b00482e0c55e2bsm13596984edb.93.2023.01.17.23.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 23:09:37 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 08:09:20 +0100
Subject: [PATCH v2 6/7] usb: fotg210-udc: Assign of_node and speed on start
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-gemini-fotg210-usb-v2-6-100388af9810@linaro.org>
References: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
In-Reply-To: <20230103-gemini-fotg210-usb-v2-0-100388af9810@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabian Vogt <fabian@ritter-vogt.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the example set by other drivers to assign of_node
and speed to the driver when binding, also print bound
info akin to other UDC drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/fotg210/fotg210-udc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index 6a4b94d26951..4099e7453112 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -1015,6 +1015,10 @@ static int fotg210_udc_start(struct usb_gadget *g,
 	/* hook up the driver */
 	driver->driver.bus = NULL;
 	fotg210->driver = driver;
+	fotg210->gadget.dev.of_node = fotg210->dev->of_node;
+	fotg210->gadget.speed = USB_SPEED_UNKNOWN;
+
+	dev_info(fotg210->dev, "bound driver %s\n", driver->driver.name);
 
 	if (!IS_ERR_OR_NULL(fotg210->phy)) {
 		ret = otg_set_peripheral(fotg210->phy->otg,
@@ -1071,6 +1075,7 @@ static int fotg210_udc_stop(struct usb_gadget *g)
 
 	fotg210_init(fotg210);
 	fotg210->driver = NULL;
+	fotg210->gadget.speed = USB_SPEED_UNKNOWN;
 
 	spin_unlock_irqrestore(&fotg210->lock, flags);
 

-- 
2.39.0
