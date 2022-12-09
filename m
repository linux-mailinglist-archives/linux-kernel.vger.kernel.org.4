Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD16487BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLIR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLIR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:29:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC060B66
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:29:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so13112437ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzI0mSSXDiULYDkFXYMyFYk7pUZpjZLakH92fcemRT0=;
        b=avPhojfyAtEzYWjUqmN97DwPnMdwkhaZuk94QT4MgXiwryXE8hb1g9miVLLHqUYFP1
         jth0Q+Hoocw8uH3k5/I8Qm3zQlIWrg5JXJH6jVmmUwTxILt7dWi80KIxBkf+mKpLr7hq
         1tgQNCwBcUP9LG7xucdpxUC6h6HLop9xqEvCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzI0mSSXDiULYDkFXYMyFYk7pUZpjZLakH92fcemRT0=;
        b=EgRVifS8YOezdA4N9un84uSzHVFW8HnQ3DiZAk3T/a69MFldamTdHVBWk56BcQNx03
         /QqlPOQtyBQKDfs0oBWj0W/y/Sxo0SyBZMg+zHXrlLrzecDYRxsG/NSSRMy878ags4aa
         IN13WHeoyZvSZYM9V8IGDsN7ANbpqxA8zmROSb0XqIa7JpGnkcV5QTwRAhybFOrZ+tBw
         NEx2CmPpb/lvRGLPvt8KaYf4qVCB0FSv4WRCtm58ad2t5e4LmJt+2TvD9KWSu88JWXjN
         UefoWTQRMgHKVvP/XU1QEtbeC0Ct2XbPRuoGQj1DvOpcxAwdswNzgUL5rbaPREJZPb/x
         ssJA==
X-Gm-Message-State: ANoB5pkxHEwoS2KRlUs1gxwX7YJOuYprdQDwUJIBXF8OrNa1dDR18Gx1
        hGmm4a0eDT33Lo9qW+LK0dab3g==
X-Google-Smtp-Source: AA0mqf5z7MfBtkUdBD3PRrX7l81o13oYiH7M+1xcBgip7ajZdifaWsn2o7It0BqoH+YLqdJaLHTt4g==
X-Received: by 2002:a17:906:381:b0:78d:f455:c39b with SMTP id b1-20020a170906038100b0078df455c39bmr5747668eja.65.1670606944432;
        Fri, 09 Dec 2022 09:29:04 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id pk14-20020a170906d7ae00b0077016f4c6d4sm161154ejb.55.2022.12.09.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:29:04 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: u_ether: remove obnoxious warning messages
Date:   Fri,  9 Dec 2022 18:28:53 +0100
Message-Id: <20221209172853.2138941-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

There is really no need for the driver to unconditionally emit warnings
like this on every usage:

[    6.967283] using random self ethernet address
[    6.967294] using random host ethernet address

Since this is normal behaviour, just remove the messages altogether.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/usb/gadget/function/u_ether.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 8f12f3f8f6ee..3fdc913ef262 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -845,13 +845,11 @@ struct net_device *gether_setup_name_default(const char *netname)
 	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
 
 	eth_random_addr(dev->dev_mac);
-	pr_warn("using random %s ethernet address\n", "self");
 
 	/* by default we always have a random MAC address */
 	net->addr_assign_type = NET_ADDR_RANDOM;
 
 	eth_random_addr(dev->host_mac);
-	pr_warn("using random %s ethernet address\n", "host");
 
 	net->netdev_ops = &eth_netdev_ops;
 
-- 
2.37.3

