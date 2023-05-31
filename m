Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22E67174A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjEaEC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjEaECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:02:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB8107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568c8fa027fso23385457b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 21:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685505730; x=1688097730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTATTkgvxztq9cna9gYn1cQG7KZBsx+3nMydlu+2mlE=;
        b=al+sJCyOmkaF/6ULIYjfy2VcVPz2C1bJQqcCbgFH/qdd7Y3x3ihhhi+6+rzdnEiUv8
         lWpn7yW5seO+rgx/NlgTtfMTIYxkGcVq+TSRBWky9mfQUVCpRWY93+2uS5MuaL75iEDA
         JQ10HgpgPVDpe+CX3mqaEzbLU4+OSdpKbgU8DULnbEDbNMZ98Xg5KZYbWZrFG/RMGaGR
         jTnl1guy/5DX8hhiygVrhV049zJ1vcM2cd3XqRd4+0afw78MpemU5/cde1on4KzSuR9e
         ipRGINz/G0pNg9bKudvd2xs9iSVvrJ7sMHbVynO6oRjOrqbl9maLQHug6QJH1nM5+8b2
         OqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685505730; x=1688097730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTATTkgvxztq9cna9gYn1cQG7KZBsx+3nMydlu+2mlE=;
        b=gpNjUX79sOxuzC8xgQYUb7hCBmjFlM0GKLJc5wV3MH/WEmOvA84QdDdECjbaBP9wQy
         kRbEoq7ksNWz1kO4FBXQi4j5yrZ+l5fc2NXTMbwcRlHEiBzDCqvvN2WYYz7y0mvY+ElU
         So8A12DimtVLZ2Zn3qkens0BGwUvqWON1SHwT78Xkuul4oMMG6OGPU3iiKebePGVbfsf
         SKR8RUXF+JSz2CZq3S62yIVBL1YNoBOPtrSjIcqhIsuS4cS3PdsHRqO01tE34lfinkGE
         iS6wfCDA3zd32IqGykAy4oSpq2JDZs9FVvyuLjij1+6qUDJKOK5OHcElomFB8qyTsLhf
         MfRw==
X-Gm-Message-State: AC+VfDy8HubpjWYNqfZZ65EiyXspj//PkfmorTglIpexRFqj1FMT7Jpw
        XNuPTiTGX5zE91Icisssf3ZOu+U4JIU=
X-Google-Smtp-Source: ACHHUZ4p0nM25uD1L98TaYBOU36BLpBLGMgEtVGS7cVeo7z12dgaiYwxkeFtmy9TSgo24jh7ThbNKIabBSM=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a81:b661:0:b0:565:ce25:2693 with SMTP id
 h33-20020a81b661000000b00565ce252693mr2529499ywk.3.1685505730774; Tue, 30 May
 2023 21:02:10 -0700 (PDT)
Date:   Wed, 31 May 2023 04:02:03 +0000
In-Reply-To: <20230531040203.19295-1-badhri@google.com>
Mime-Version: 1.0
References: <20230531040203.19295-1-badhri@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531040203.19295-3-badhri@google.com>
Subject: [PATCH v5 3/3] usb: gadget: udc: core: Prevent UDC from starting when unbound
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        colin.i.king@gmail.com, xuetao09@huawei.com,
        quic_eserrao@quicinc.com, water.zhangjiantao@huawei.com,
        peter.chen@freescale.com, balbi@ti.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Badhri Jagan Sridharan <badhri@google.com>,
        stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDC should neither be started nor pulled up unless the gadget driver is
bound. The new flag "allow_start" is now set by gadget_bind_driver()
and cleared by gadget_unbind_driver(). usb_gadget_udc_start_locked()
now checks whether allow_start is set before starting the UDC by
invoking the ->udc_start() callback.

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Cc: stable <stable@kernel.org>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v5 is the first version in this series.
---
 drivers/usb/gadget/udc/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 6ffe5fda8bb7..ac9d6186815d 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,6 +37,8 @@ static const struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
+ * @allow_start: Indicates whether UDC is allowed to start. Set/cleared by gadget_(un)bind_driver()
+ * after gadget driver is bound or unbound.
  * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
  * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
  * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
@@ -52,6 +54,7 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
+	bool				allow_start;
 	struct work_struct		vbus_work;
 	struct mutex			connect_lock;
 };
@@ -1204,6 +1207,9 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 	if (udc->started) {
 		dev_err(&udc->dev, "UDC had already started\n");
 		return -EBUSY;
+	} else if (!udc->allow_start) {
+		dev_err(&udc->dev, "UDC not allowed to start. Is gadget driver bound ?\n");
+		return -EIO;
 	}
 
 	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
@@ -1590,6 +1596,7 @@ static int gadget_bind_driver(struct device *dev)
 		goto err_bind;
 
 	mutex_lock(&udc->connect_lock);
+	udc->allow_start = true;
 	ret = usb_gadget_udc_start_locked(udc);
 	if (ret) {
 		mutex_unlock(&udc->connect_lock);
@@ -1630,6 +1637,7 @@ static void gadget_unbind_driver(struct device *dev)
 
 	cancel_work_sync(&udc->vbus_work);
 	mutex_lock(&udc->connect_lock);
+	udc->allow_start = false;
 	usb_gadget_disconnect_locked(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
-- 
2.41.0.rc0.172.g3f132b7071-goog

