Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2582B6BD4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCPQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:09:27 -0400
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 09:09:26 PDT
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net [37.140.190.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB08A64;
        Thu, 16 Mar 2023 09:09:26 -0700 (PDT)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 3BF0310AA90A;
        Thu, 16 Mar 2023 18:55:46 +0300 (MSK)
Received: from vla1-2f6a8787997a.qloud-c.yandex.net (vla1-2f6a8787997a.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:35a1:0:640:2f6a:8787])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 3762F6F40007;
        Thu, 16 Mar 2023 18:55:46 +0300 (MSK)
Received: by vla1-2f6a8787997a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 8tmDo6Yck8c1-N43cg4iV;
        Thu, 16 Mar 2023 18:55:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1678982145;
        bh=BQReFTG2lcPA75b18D8vey98+5FpL4ag8kMta6cDrLc=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=EtPFiL6PpQMV+ji65NctGCy9xESd+yPzBu6Tdgj0JcTt5nT2pLC38luwMnLIpu3kp
         2N9hKaF2o+tkeK2jFkADZtZIoq4eqoP/QwDSeu4E6lOPwIalzbB0EHSZjsPRiIaU2u
         RzAuBJfL4zXWqlquxs41W3qMqcCO3sX/pxIynifE=
Authentication-Results: vla1-2f6a8787997a.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Valery Zabrovsky <valthebrewer@yandex.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valery Zabrovsky <valthebrewer@yandex.ru>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Felipe Balbi <balbi@ti.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] usb: gadget: net2280: fix NULL pointer dereference
Date:   Thu, 16 Mar 2023 18:53:55 +0300
Message-Id: <20230316155356.13391-1-valthebrewer@yandex.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In net2280_free_request():
If _ep is NULL, then ep is NULL and is dereferenced
while trying to produce an error message.
The patch replaces dev_err() with pr_err() which works fine.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9ceafcc2b3ad ("usb: gadget: net2280: print error in ep_ops error paths")
Signed-off-by: Valery Zabrovsky <valthebrewer@yandex.ru>
---
 drivers/usb/gadget/udc/net2280.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 1b929c519cd7..a027d1323993 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -584,8 +584,7 @@ static void net2280_free_request(struct usb_ep *_ep, struct usb_request *_req)
 
 	ep = container_of(_ep, struct net2280_ep, ep);
 	if (!_ep || !_req) {
-		dev_err(&ep->dev->pdev->dev, "%s: Invalid ep=%p or req=%p\n",
-							__func__, _ep, _req);
+		pr_err("%s: Invalid ep=%p or req=%p\n", __func__, _ep, _req);
 		return;
 	}
 
-- 
2.34.1

