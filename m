Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778D96A2735
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBYEMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 23:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBYEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 23:11:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066D628F0;
        Fri, 24 Feb 2023 20:11:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso161909pjs.3;
        Fri, 24 Feb 2023 20:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4owclU3ejHWTEBuLrWhmLUuMH4WIISFFiTFNymBI7Y=;
        b=XkXxmFCYN7J+EoOtMaOQ75oMQcI7DH+npbo5aKGb913jCYH5IDgaZJighknRR9l9MZ
         RjcCtZubPi7lS+Cvw0o7qun+Qjlcy4FjPk39fggbafNS2y2gyqzefGIkY7she/fSeKJb
         5nEXlJBNE1+FhEar5aZwhLRrfesQvMLUj5oUY6LL7T0X39xvzMZIrsZAr/gwbUI4d5hf
         ypzTLEFTYPNRQqi9+s7Vq7R5GGGKC89oonwEXWWzj86OSF52ZbS3gpLZdFMSdMttD5oI
         8QfJRN+VQDVxhrfaOCut+Hs1/Nm7cN+jYFWLUroC8fJA3XsToxsGMZsaYqHPuI63+4XY
         ngow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4owclU3ejHWTEBuLrWhmLUuMH4WIISFFiTFNymBI7Y=;
        b=L6xFKe5uIITBSEmoEKNaUUIbHPceGrAQrqTHY0WQkE6vhY4sUNemhPPu76mwfV5Ldw
         g4BMa7rhv0W9g17abUJLE2icOCpaa8A1gS8o9oNr1ocoeKLYSiNwVPm/jSLSGYvxfVDB
         nI5o6c2euz2FS3/gfKZZpwXjTgph81/6rduR/moVp0MNk/3yWfj4u0nVPSvkv6oNlZ1p
         CVfkpBkFrXBu4iR8scMWqBmZ9I+nG0lZT6GZo3VDPPdGyz7/4LIJlg3mcujNqLXP7GN6
         faRzHR6RJzFrHKm1iNhxsJlE1FQKDUV/Nmo60jYwueMF8esZ64+FlKTgz7K/vIkf/QBV
         x0ew==
X-Gm-Message-State: AO0yUKVICz9+OrSI8AqLmn2w1RmDVfAuzTx+3VHWMS5XPAnBHf7NhYY4
        broNPeGMdbhISwtN/XokQCs=
X-Google-Smtp-Source: AK7set/8B5cAFbTMo3lBGyP+0mWWSByS646Gyb/Crx81sNDpGrdDvkNjGBBEKyHYtwH5lez5mtxgow==
X-Received: by 2002:a17:90b:38ce:b0:236:704d:ab8c with SMTP id nn14-20020a17090b38ce00b00236704dab8cmr19553076pjb.26.1677298316923;
        Fri, 24 Feb 2023 20:11:56 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b0022bfcf5d297sm2268428pjk.9.2023.02.24.20.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 20:11:56 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     sergei.shtylyov@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mudongliangabcd@gmail.com,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH v3 2/2] usb: gadget: udc: replace kzalloc with devm_kzalloc in mv_udc_probe
Date:   Sat, 25 Feb 2023 12:11:49 +0800
Message-Id: <20230225041149.136-2-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230225041149.136-1-void0red@gmail.com>
References: <17383b82-5e1c-837c-d05f-67a3a024cace@gmail.com>
 <20230225041149.136-1-void0red@gmail.com>
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
kzalloc with devm_kzalloc to avoid a memory leak.

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Link: https://lore.kernel.org/all/CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com

Signed-off-by: Kang Chen <void0red@gmail.com>
---
v3 -> v2: split the patch into two
v2 -> v1: replace kzalloc with devm_kzalloc

 drivers/usb/gadget/udc/mv_udc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index 6dd6d52de..08474c08d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2229,7 +2229,7 @@ static int mv_udc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&udc->status_req->queue);
 
 	/* allocate a small amount of memory to get valid address */
-	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
 	if (!udc->status_req->req.buf) {
 		retval = -ENOMEM;
 		goto err_destroy_dma;
-- 
2.34.1

