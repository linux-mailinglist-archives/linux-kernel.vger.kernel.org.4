Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3135F245D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJBRop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJBRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:44:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0B0B05;
        Sun,  2 Oct 2022 10:44:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j71so1861852pge.2;
        Sun, 02 Oct 2022 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=vWxkdvQXMwCnjWanfCVPEaYFDFc9vK9pxBkSUDnu3pc=;
        b=qc2UcTTakvjf5JMZupcWbGY12ghU4xS5tPvwmrLYIU5FSlqe7CYBKXp+wUnR+f1LTs
         vwBLNyVCuPW+WAa4hGx9OhQJP10/AkulXnd2o3ZSqsNXCdVbCMHYHy2nBKUwtXrdsdNr
         9ySegKydeyQhEhkitLasGb0XK+Rp5LhimeBNlFZ+X9k7oRrlE4n2ahNet8W15N0Pcl4n
         pLmiMOVw/hZ+BfK4OytCLovAuBCB0bwSoZptbOr7kR4dONhbEe0ZjbPK75bFcxLoiySd
         guRgZTmNLYbqbSD4XlfSfoHPIe8zqChZxPNv9R7qT6x/TpJ94ySOWoTgiiCjT8N4xrrh
         FAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=vWxkdvQXMwCnjWanfCVPEaYFDFc9vK9pxBkSUDnu3pc=;
        b=Fn4nBBIblkMya/WtN6Wtt7gMxrN5KchTIgzE6ONhuyCjSovoj0MV2NLwpE9CIfHkmI
         +BdMol9C/PQK7106jDbgO9EtywOlneYpabkN07VhOi9N9FOUjY0aDKvI/g+KQLI5jPl6
         gKzqPCFZgbfAgeHUp2iI29H9Sg2J0nsgSsMxwVwUIeGbyuJbo4wbC6vfsA+bDbXg7Bq4
         iot+oU7p7WjOHjqwAX8flCEd6+Abs7cSE7QvxE9so94u4cA8+HmImdFBrcTFfswEwobi
         PFSU8AvYO8e/mEFjSacCyFEGY/E6dMyPCw7ii4nzAvKSF1TBFQXKvWtSdlV1jkjQ9vCu
         aFkw==
X-Gm-Message-State: ACrzQf07pdBN3DqctApnGJ4nGaxAO+7vePU7zuHP5wq2+XG9xk/XZ6P7
        bmd2fcu6EccoQkiAdpoQTDs0tcfleAlDcA==
X-Google-Smtp-Source: AMsMyM67A1bSvkqNsyWLJleYOEeibaR75Qs/gz7Y219GSTH0wjAR5Lww05LieI4yMmkDh2QgZqewYQ==
X-Received: by 2002:a05:6a00:234a:b0:542:f9f2:72e5 with SMTP id j10-20020a056a00234a00b00542f9f272e5mr18813404pfj.34.1664732674534;
        Sun, 02 Oct 2022 10:44:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m13-20020a65564d000000b00442c70b659esm4091002pgs.91.2022.10.02.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 10:44:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH] usb: gadget: uvc: Fix clearing of vdev
Date:   Sun,  2 Oct 2022 10:44:30 -0700
Message-Id: <20221002174430.3065870-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4ce9ed835bc ("usb: gadget: uvc: ensure the vdev is unset")
introduced code to clear the video device on video device registration.
However, it uses sizeof(uvc->video) instead of sizeof(uvc->vdev) to clear
uvc->vdev. This may result in the following build error.

In function 'fortify_memset_chk',
    inlined from 'uvc_register_video'
    at drivers/usb/gadget/function/f_uvc.c:424:2:
include/linux/fortify-string.h:301:25: error:
	call to '__write_overflow_field' declared with attribute warning:
		detected write beyond size of field

The problem is exposed by commit 9b91a6523078 ("usb: gadget: uvc: increase
worker prio to WQ_HIGHPRI") which increases the size of struct uvc_video.

Fixes: e4ce9ed835bc ("usb: gadget: uvc: ensure the vdev is unset")
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/gadget/function/f_uvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index e6948cf8def3..836601227155 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -421,7 +421,7 @@ uvc_register_video(struct uvc_device *uvc)
 	int ret;
 
 	/* TODO reference counting. */
-	memset(&uvc->vdev, 0, sizeof(uvc->video));
+	memset(&uvc->vdev, 0, sizeof(uvc->vdev));
 	uvc->vdev.v4l2_dev = &uvc->v4l2_dev;
 	uvc->vdev.v4l2_dev->dev = &cdev->gadget->dev;
 	uvc->vdev.fops = &uvc_v4l2_fops;
-- 
2.36.2

