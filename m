Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74F68C9CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBFWxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFWxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:53:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF5199C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:53:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-527501b56ffso74370857b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1rkGNVs7WDfSpT+SwQD/kpwhi7O949Lzsng+1IjE21k=;
        b=XSiua1bl6LVvey69Z4SsKZl8F075/BE5eJHroXFekoqJMxQBrtD+oDN6iC64sUb+g4
         VJgmdoCxRvE5cuOq/MPXs0S/HLNEGCdPejIILd0yb0gWNts5uLlSSkL2vDrtDKf2T8bM
         PN52AeAUPmMhppxldWZnBVpntFafqsCt/BdKlPUZusdjL8oCJ+uWTB+eWE/ElCVfsd9X
         AUsqUovPw2vsaGHb18xvDx2BcPhkjUaRjygnTjaCYRFM6Row4OdZf6clEWCkHx31GhxD
         wexROl5F73Hvy47MLdtZZBXDt1PUdTjrVY66zq9YBbwsj107vJUi/R4Xopa95Jw/VOID
         F66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rkGNVs7WDfSpT+SwQD/kpwhi7O949Lzsng+1IjE21k=;
        b=0O3olmSfpQjUbGRvVxfE0MOO6LvrEWCtlweKwylOzNpJTPr+oOHPJCSzqZqHV7qRzm
         /Wuggfmn8cAnrV7XHcbAQbOff51m0gxLgbO8QkHOP1722s7/U5dGT+YiMm3gtpVp5OCN
         LLKUsuul+9bZeTsbbvAQUgQYxAzB6zLmfApWg5doMYPj05SUc3l50EQ7Wit4Hc4hoYo+
         447PXj+B/dWVkOaofk3krvorQBmsm7m4FPMMKDeK0lyd2ASusvbKI72ANc3s9MGnvGRe
         HqoOI5Nl/wJ/G/Hev1uMtJJ+Xr0clpCPqdF8nf5RiMInykhhClhobeEQuhhfhVvHpAsb
         8cfw==
X-Gm-Message-State: AO0yUKX5M2oB4QhrlnuYhlMyAQ3Qnxfsq761iJ2MeVOcqjfRmam8hneH
        Lh+1qarJ+VcmSC/gwsrc4h3dsxA4/Kw=
X-Google-Smtp-Source: AK7set/utKFWNncKVUhLM0ZhV93y7FWHZMzZIY65yELOOeB+W406xg9A2xV0zszzZ+JwmpGLKfvIVqgtgR0=
X-Received: from xz2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:d01])
 (user=xnzhao job=sendgmr) by 2002:a0d:d346:0:b0:527:f2be:aa9e with SMTP id
 v67-20020a0dd346000000b00527f2beaa9emr114757ywd.15.1675724018154; Mon, 06 Feb
 2023 14:53:38 -0800 (PST)
Date:   Mon,  6 Feb 2023 22:52:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230206225258.2302954-1-xnzhao@google.com>
Subject: [PATCH] usb: gadget: dummyhcd: Fix use-after-free in dummy_free_request
From:   Xin Zhao <xnzhao@google.com>
To:     gregkh@linuxfoundation.org, jakobkoschel@gmail.com,
        rdunlap@infradead.org, ira.weiny@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xin Zhao <xnzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DummyHCD assume when dummy_free_request is called, the request
is already detached from request queues. It is correct in most
cases.
But when DummyHCD is detached from gadget configfs with pending
requests and some requests are still in pending queue,
dummy_free_request would free them directly.
Later on, dummy_udc_stop would iterate pending queue to release
the requests again.

Stacktrace for dummy_free_reqeust
```
kfree(const void * x) (slub.c:4200)
dummy_free_request(struct usb_ep * _ep, struct usb_request * _req) (dummy_hcd.c:691)
usb_ep_free_request(struct usb_ep * ep, struct usb_request * req) (core.c:201)
functionfs_unbind(struct ffs_data * ffs) (f_fs.c:1894)
ffs_func_unbind(struct usb_function * f) (f_fs.c:3614)
purge_configs_funcs(struct gadget_info * gi) (configfs.c:1303)
configfs_composite_unbind(struct usb_gadget * gadget) (configfs.c:1528)
usb_gadget_remove_driver(struct usb_udc * udc) (core.c:1436)
usb_gadget_unregister_driver(struct usb_gadget_driver * driver) (core.c:1585)
unregister_gadget(struct gadget_info * gi) (configfs.c:281)
gadget_dev_desc_UDC_store(struct config_item * item) (configfs.c:308)
flush_write_buffer(struct file * file, struct configfs_buffer * buffer, size_t count) (file.c:251)
```

Stacktrace of use-after-free
```
list_del_init(struct list_head * entry) (list.h:204)
nuke(struct dummy * dum, struct dummy_ep * ep) (dummy_hcd.c:344)
stop_activity(struct dummy * dum) (dummy_hcd.c:366)
dummy_udc_stop(struct usb_gadget * g) (dummy_hcd.c:1032)
usb_gadget_udc_stop(struct usb_udc * udc) (core.c:1141)
usb_gadget_remove_driver(struct usb_udc * udc) (core.c:1437)
usb_gadget_unregister_driver(struct usb_gadget_driver * driver) (core.c:1585)
unregister_gadget(struct gadget_info * gi) (configfs.c:281)
gadget_dev_desc_UDC_store(struct config_item * item) (configfs.c:308)
flush_write_buffer(struct file * file, struct configfs_buffer * buffer, size_t count) (file.c:251)
configfs_write_file(struct file * file)
```

Signed-off-by: Xin Zhao <xnzhao@google.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 899ac9f9c279..afead69d7487 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -679,7 +679,11 @@ static void dummy_free_request(struct usb_ep *_ep, struct usb_request *_req)
 	}
 
 	req = usb_request_to_dummy_request(_req);
-	WARN_ON(!list_empty(&req->queue));
+	if (!list_empty(&req->queue)) {
+		WARN_ON(1);
+		return;
+	}
+
 	kfree(req);
 }
 
-- 
2.39.1.519.gcb327c4b5f-goog

