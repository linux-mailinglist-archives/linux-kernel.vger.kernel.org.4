Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DE73BB43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFWPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjFWPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:11:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131D2D7C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5766e49d151so17938087b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687533048; x=1690125048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T40jLz8j0sR+fx+XMBB91BKek6keV7mMBCBlptKA/U8=;
        b=GnnRHZDe78YBLKXJsdQtn7wz3MkeuX+BclwIgqwJFM92Ezl8Gmz/QpSXK/IrbzRumx
         UCPt21Pys2hdv88fERmfDTCmDXa7lquNN3A9HTzsh6jP/LxNjSQ9QBmcAzFlvJIUL//R
         tiFvjot++QA5yrakJedMekfntctSIgo7XdYLzDffzizBo6h79Uqpu7Xzaz0EVaejgAx7
         OkB0v2UAeKvPpJTUWk0PGQN2kQuOKxGchi+pha+AvghMsYsGT4xnH4eBiEJm1VHaqg6l
         r1KGooFP6ySFnWuxCIHVNPsGFbzcv5Z6j6muXmoeq48xqlx5avSulHon1VMKeI6xhRu8
         O4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533048; x=1690125048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T40jLz8j0sR+fx+XMBB91BKek6keV7mMBCBlptKA/U8=;
        b=PJZzw/8M5WiB3S2LnxT/vUE70z3VceV4gO7DyKsMKTEC34XaKZHf6lQ8b2rszQfO6x
         SpyPrtHKQz23towyW0C9Ol7xnpWlzMY/s26nT5f9zMez8Z3U65UKrivcot69C2S6J1HE
         wWqbdIPhid20dEzLlJrjiECuYDFE0LMFYHXou+uCQXjqoXuxu9VTm7/md0QgIMeQIQuC
         cxX4+y6z4uAcL4m6pRhOWqWZ2C1/3RAL7msIqSP90ZBze8o+gMGZW1VWEq2mtNz0nCnj
         ONcjhjRdhTNVmF9x1y0YAmC0+iQb3Iv6JVBq0sElQXhTppmxhQ0khTzqXTO1iVvgplp2
         1mvA==
X-Gm-Message-State: AC+VfDxAOfAFvRhWO5OEN6ncBGY/DRacLLQKpojgZ5CJ9S21IuMhQ2EC
        wN7qY0Et1tN1PrZGu6zbYDNw1jnVUqS/
X-Google-Smtp-Source: ACHHUZ6xY5RzJ8jDAd/nnL1MFEmFnRw+b+2byYBxQxlp3osCgR5yLOzm7tYWrL9Eq5BCrSo55OJeCuPi3wlP
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:5d47:84a:2819:bba4])
 (user=kyletso job=sendgmr) by 2002:a05:690c:b92:b0:565:8b2e:b324 with SMTP id
 ck18-20020a05690c0b9200b005658b2eb324mr14438059ywb.3.1687533047959; Fri, 23
 Jun 2023 08:10:47 -0700 (PDT)
Date:   Fri, 23 Jun 2023 23:10:34 +0800
In-Reply-To: <20230623151036.3955013-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230623151036.3955013-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623151036.3955013-2-kyletso@google.com>
Subject: [PATCH v2 1/3] usb: typec: Set port->pd before adding device for typec_port
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        stable@vger.kernel.org
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

When calling device_add in the registration of typec_port, it will do
the NULL check on usb_power_delivery handle in typec_port for the
visibility of the device attributes. It is always NULL because port->pd
is set in typec_port_set_usb_power_delivery which is later than the
device_add call.

Set port->pd before device_add and only link the device after that.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
update v2:
- Add "Cc: stable@vger.kernel.org"

drivers/usb/typec/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index faa184ae3dac..3b30948bf4b0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2288,6 +2288,8 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	port->pd = cap->pd;
+
 	ret = device_add(&port->dev);
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
@@ -2295,7 +2297,7 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
-	ret = typec_port_set_usb_power_delivery(port, cap->pd);
+	ret = usb_power_delivery_link_device(port->pd, &port->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to link pd\n");
 		device_unregister(&port->dev);
-- 
2.41.0.162.gfafddb0af9-goog

