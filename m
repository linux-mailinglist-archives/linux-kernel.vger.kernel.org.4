Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44F6A1D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBXOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBXOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:31:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0C658C2;
        Fri, 24 Feb 2023 06:31:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so2939466pjq.0;
        Fri, 24 Feb 2023 06:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNofJp4wMqA2VfCsJx6wfp/b0aZENLqy14bJKQPsQ4E=;
        b=U+1kD109eqLvwhOloE42bEF9k2iwCeSSpw3JmLmk1gIF8AwHjRsqlA7uSP2boMDGeq
         sntK9/A6cOh5kEQeavy3Q21VrGzSeyzlf9NZDNirhFJBx2dZCoZiLRw0scJHYzdnPVe3
         LqOyw4VZ3RTpaze9AyIjLoTlIZNLm2f4HPPc+YVF6TLwUKlgAM+Drf2/ybDlRmL6m+eQ
         CWUIAfBdnmKJLT/yJjhNZIS8x6WRl5WJOVV8YSOOsyyV3ufbpTTHaTjz72EKles6Lapa
         5UwXO3aznNDMVSqD4DCpeU7wl3h4RfYkjA1Gx1cd3A/LdR4qk/k1/0jCJshIispLoysa
         qNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNofJp4wMqA2VfCsJx6wfp/b0aZENLqy14bJKQPsQ4E=;
        b=iFCscM8hyTqt5n/LkAn5n+N8UJauEQbXx/6dsKDe8pdKtp4Rb+uvfqLNbZTMCE1c4o
         zPtS4kYwRzSkYwXFlCp5TxpHZLAZEDfXK3w66Ec9Ueg32Bh80ieeRAO4ZnfMlhuwrQK8
         EtaEe++BIOryNpwoa+8MvmKPB4UwCQRzpbPs6qGleJk04GIZ/M1cmiO3rwMrqHdez2NU
         6fOPv/j6fIHjS3szs8xr++4y15ddFK/wVA2BvBqXTgaRHs+7k8znRAgFQsbf6727ID8m
         tXfGZaFxZ6fkA6gscTUzIizlLzFukILwPuowu3d0kttC8thC+lZ4El3450wn5vrvlS5/
         R5ng==
X-Gm-Message-State: AO0yUKU2VRDek5fCD+vme17jMxsbwugCfKF9cVYW4nOZ0QFkzSkrJEvu
        7E6XmE0KRc/SyfXnA9OnmpM=
X-Google-Smtp-Source: AK7set+xHAGOtL52nCuKYwrbgKocNstcQ6DXT0BodtMCgxOQbqo+DitysBApCdSbKzf53W+3lp3nEQ==
X-Received: by 2002:a17:90b:38c2:b0:22c:816e:d67d with SMTP id nn2-20020a17090b38c200b0022c816ed67dmr18626121pjb.24.1677249115826;
        Fri, 24 Feb 2023 06:31:55 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id ik15-20020a170902ab0f00b0019af9a6bf8dsm3160703plb.19.2023.02.24.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 06:31:55 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     mudongliangabcd@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH v2] usb: gadget: udc: replace kzalloc with devm_kzalloc in mv_udc_probe and add a check for this allocation.
Date:   Fri, 24 Feb 2023 22:31:48 +0800
Message-Id: <20230224143148.60-1-void0red@gmail.com>
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
v2 -> v1: replace kzalloc with devm_kzalloc

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

