Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1F633C95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiKVMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKVMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:35:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA55B849;
        Tue, 22 Nov 2022 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=VjcwKuzaca86AHSHKpSyWjgTPVgpR5kpdMTz8JABTVY=; b=hM6I+fMJWa/70IFhgoLB+YtUW5
        vWSJ5OfUrdfleSHIx64eNSpwDZU5bQQ2HobN9HAA7JodXGy9Sz4QleDt88qP79bjgAx3ngTOlLWbg
        JjTvUCiQPXMe5MBu9Fr8b62VETGbZeEhMv/1VLO9u1ctsonIVRA65EnQ7Ls6sQzaZGQevjf8FVz4c
        qJsqxwmG4JdQQUOpnEHjZitUXKZXe3j04a+HC0HnTEYxL/halirDjAaqNmB+A48FdzcaStvW8z+z7
        FHu5EvI3Ny02TkfNUKF3FSwF3OYZuBWc9NxJWuTHM+S4E9CvqM90xoqCS0C5ApkmYGcG7WOtUmmL9
        nJc/A1Fg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxSUt-0003da-Qx;
        Tue, 22 Nov 2022 12:35:32 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Keeping <john@metanate.com>, Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3/3] usb: gadget: f_hid: tidy error handling in hidg_alloc
Date:   Tue, 22 Nov 2022 12:35:23 +0000
Message-Id: <20221122123523.3068034-4-john@metanate.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122123523.3068034-1-john@metanate.com>
References: <20221122123523.3068034-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify error handling at the end of the function, reducing the risk of
missing something on one of the error paths.

Moving the increment of opts->refcnt later means there is no need to
decrement it on the error path and is safe as this is guarded by
opts->lock which is held for this entire section.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 6be6009f911e..a8da3b4a2855 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1269,18 +1269,14 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
 	mutex_lock(&opts->lock);
-	++opts->refcnt;
 
 	device_initialize(&hidg->dev);
 	hidg->dev.release = hidg_release;
 	hidg->dev.class = hidg_class;
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
-	if (ret) {
-		--opts->refcnt;
-		mutex_unlock(&opts->lock);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_unlock;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1291,14 +1287,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 						 opts->report_desc_length,
 						 GFP_KERNEL);
 		if (!hidg->report_desc) {
-			put_device(&hidg->dev);
-			--opts->refcnt;
-			mutex_unlock(&opts->lock);
-			return ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_put_device;
 		}
 	}
 	hidg->use_out_ep = !opts->no_out_endpoint;
 
+	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
 	hidg->func.name    = "hid";
@@ -1313,6 +1308,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
+
+err_put_device:
+	put_device(&hidg->dev);
+err_unlock:
+	mutex_unlock(&opts->lock);
+	return ERR_PTR(ret);
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
-- 
2.38.1

