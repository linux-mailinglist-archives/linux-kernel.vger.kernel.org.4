Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B26A2736
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBYEL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 23:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYEL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 23:11:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA006628ED;
        Fri, 24 Feb 2023 20:11:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c1so1514709plg.4;
        Fri, 24 Feb 2023 20:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pBEzpVd+snu5F2T0uV1kL07YHenLWu8FxH3t2VC2cg=;
        b=mYyz2gyWDoRuHWtmyk2M3qcjPcj+6c3fcMQDYYI6zlWiLrqHDbrzc/o6nEE+cIt2Av
         CZS0dZh4hye5IvjPsO+NUscM/CmxPLA4em51lQ+dZpgCaoKyz08QVqS5c22pMNq32BfC
         6VtwVb4Cfmdu5RGIWbSu3PHkeuOxpXKD380Tsj/DTel2i7Lef1AkAxIgKQ4IlQqsUSSt
         3ginx2UA+PejVsSf4okhnw19jiSmp9wwmTaZhIfsNS5z8/I+GKg0qrdTya9EaCHBfO/n
         f8L2pV0R4euYBJfn8712YKdLsAaz0ouW/xjUOXwCAa6STvGQaYFbwKKAH6ydG6jEz64m
         ad1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pBEzpVd+snu5F2T0uV1kL07YHenLWu8FxH3t2VC2cg=;
        b=u5BWmhnABKZpgo4AKNAbg91MHCs3TcFTxtMtv9Qe7OKpllcanz/JyWYpaQdf975J7E
         ltfqzVK+TfehFTUZjoJ4G/aGlMj531IsbIyPYnFNSqSFN6ZpmFWi3Kcs4lZcsIbTmCM7
         l8kTrem0vZ2cGazbvdaEZzSQ+QNh4dr+VgChC9kS3QLYEWf6ukUtTFnL7gIGtW2BHN6c
         UAGoG23wItf73WN9ZlfDoVCPMajzqt6jlcd4ffQRXpnQxwsDerVkL3Rmdj8siFrkc1vb
         DpLgdgOTnH3w3d3j6D2IA3moVfePb7tijfJve3QbLIH8t9y7Y7eHmIdDCihsva554wcD
         xKhA==
X-Gm-Message-State: AO0yUKXhMBSdBftPB91orVbNalqHkHVxRpR0qBs3sDZf7EJM6wWx/ugD
        wMVz2cEX1sVmiDjyQpXIzOUgqXP3ZgF75ztgJi8=
X-Google-Smtp-Source: AK7set/glCBFSw0P8vlJ0unVVzMrpzs4wfa6R4gYRagEqe285TdkZwTuzii2Xazd7vwjKIzB2G6n8Q==
X-Received: by 2002:a17:90b:224f:b0:234:236f:1a8d with SMTP id hk15-20020a17090b224f00b00234236f1a8dmr21307777pjb.14.1677298314223;
        Fri, 24 Feb 2023 20:11:54 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b0022bfcf5d297sm2268428pjk.9.2023.02.24.20.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 20:11:53 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     sergei.shtylyov@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mudongliangabcd@gmail.com,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH v3 1/2] usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
Date:   Sat, 25 Feb 2023 12:11:48 +0800
Message-Id: <20230225041149.136-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <17383b82-5e1c-837c-d05f-67a3a024cace@gmail.com>
References: <17383b82-5e1c-837c-d05f-67a3a024cace@gmail.com>
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

Even an 8-byte kzalloc will fail when we don't have enough memory,
so we need a nullptr check and do the cleanup when it fails.

Reported-by: eriri <1527030098@qq.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081

Signed-off-by: Kang Chen <void0red@gmail.com>
---
v3 -> v2: split the patch into two
v2 -> v1: replace kzalloc with devm_kzalloc

 drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b397f3a84..6dd6d52de 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.34.1

