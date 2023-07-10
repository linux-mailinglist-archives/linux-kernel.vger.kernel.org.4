Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E937B74D963
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjGJO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjGJO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:58:48 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E6127
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:58:47 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so53338085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001125; x=1691593125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWtI3YZPxMpLtWckmqpTfWbdL3C0FhWNd5t88JNq3cE=;
        b=WqetpIGBBwWEhOFmVArSD9jWee/+2OG5iMQqq9ekkRRTF+tNe0mDMeiGcIYux6Y6uZ
         j85pTV9x/1bF7WMjVfc/HvCylI7WSo6y8JCuw3BJ3h3yLHkxwLb5sQyUnf9U230eyyP9
         5FOgjUD2kd0Myat5GAZBQwsP3oM2zhIKR4MV1cz0Y/NGexIVjNWVKWQzQA9IIZxj8/Ap
         2+yxoGNfIroczdRox6hL4ELTkcUHOGYh/aePxZ1v8magHqT9DaAk43ZZBgafjB9lJF9q
         mOJ7tPkJd1HthUJ+iEI05v4cWmv0gQFUcYuvL1Zym951RKw0N+GdqC67zp53zoQ2WoYZ
         KFiw==
X-Gm-Message-State: ABy/qLZpTX4wFE6iHgBIjGUunhR3qwYxaUZ97A34G8e82p7SV9RcZ1AG
        2qxGQ8uBavt1LbyquwsYmxE=
X-Google-Smtp-Source: APBJJlHDwpXSvWsd8XnQqBuIm7L3PwaZ/KeGRDCeVHnYiO32HCPnN+X38OvPQRwtQ5c+iH1RFYaPag==
X-Received: by 2002:a7b:c84c:0:b0:3fa:7b44:7195 with SMTP id c12-20020a7bc84c000000b003fa7b447195mr15654712wml.10.1689001125337;
        Mon, 10 Jul 2023 07:58:45 -0700 (PDT)
Received: from localhost.localdomain (aftr-62-216-205-175.dynamic.mnet-online.de. [62.216.205.175])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600c364600b003fc16ee2864sm47920wmq.48.2023.07.10.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:58:44 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rodr=C3=ADguez=20Barbarin=2C=20Jos=C3=A9=20Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] mcb: Do not add the mcb_bus_type to the mcb_bus itself
Date:   Mon, 10 Jul 2023 16:57:52 +0200
Message-Id: <20230710145752.14285-2-jth@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710145752.14285-1-jth@kernel.org>
References: <20230710145752.14285-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

When allocating a new mcb_bus the bus_type is added to the mcb_bus
itself, causing an issue when calling mcb_bus_add_devices().
This function is not only called for each mcb_device under the
mcb_bus but for the bus itself.

This causes a crash when freeing the ida resources as the bus numbering
gets corrupted due to a wrong cast of structs mcb_bus and mcb_device.

Make the release of the mcb devices and their mcb bus explicit.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 978fdfc19a06..d4535b8aea1d 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -251,6 +251,12 @@ int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(mcb_device_register, MCB);
 
+
+static void mcb_bus_unregister(struct mcb_bus *bus)
+{
+	device_unregister(&bus->dev);
+}
+
 static void mcb_free_bus(struct device *dev)
 {
 	struct mcb_bus *bus = to_mcb_bus(dev);
@@ -286,7 +292,6 @@ struct mcb_bus *mcb_alloc_bus(struct device *carrier)
 
 	device_initialize(&bus->dev);
 	bus->dev.parent = carrier;
-	bus->dev.bus = &mcb_bus_type;
 	bus->dev.type = &mcb_carrier_device_type;
 	bus->dev.release = &mcb_free_bus;
 
@@ -322,6 +327,7 @@ static void mcb_devices_unregister(struct mcb_bus *bus)
 void mcb_release_bus(struct mcb_bus *bus)
 {
 	mcb_devices_unregister(bus);
+	mcb_bus_unregister(bus);
 }
 EXPORT_SYMBOL_NS_GPL(mcb_release_bus, MCB);
 
-- 
2.40.1

