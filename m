Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2165C471
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjACQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjACQ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:59:39 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817E412D31
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xnsILhgbGTIfPEYE6RKFK2VhHpdsOwIbKPY7NWU3suM=; b=Xxsb8olBBhvLNZjhVcaGkPpsE3
        INNuU2k9vTPJQd0uwpxcT+rA/as81eG4YHMSitNy9JKCJcM28XaOPGpK7bwTAm/GsrsY4UQLN39sF
        2reuK5a+r66lSmYH5g9nRB2fFHhljxk0VpRYuxiOZbu0EgWxVNQuHshovLtCAvrutJE5KJ2IpJddT
        PZnMiP5zbNTsi5ARuHv6v1JkmdM5ZNKeZSy/ZwpBdhSoF3oBYLngWPhsvfQBXdNEl1aRxHd9ruU/y
        Mg1l8TUr4/2cOGubhE5BXDCPjLEJpOw+6c13e0YrrcJKweVsiC6Y3Ky0+gonwD9NZ3EJXR+I3Q0HF
        KnQ9d8lA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33956 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pCkdR-0005cY-87; Tue, 03 Jan 2023 16:59:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pCkdQ-004hv8-7U; Tue, 03 Jan 2023 16:59:32 +0000
In-Reply-To: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 4/5] nvmem: core: fix cleanup after dev_set_name()
    Bartosz Golaszewski <bgolaszewski@baylibre.com>,Gaosheng Cui <cuigaosheng1@huawei.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,Maxime Ripard <mripard@kernel.org>, Hector Martin <marcan@marcan.st>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCkdQ-004hv8-7U@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 03 Jan 2023 16:59:32 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dev_set_name() fails, we leak nvmem->wp_gpio as the cleanup does not
put this. While a minimal fix for this would be to add the gpiod_put()
call, we can do better if we split device_register(), and use the
tested nvmem_release() cleanup code by initialising the device early,
and putting the device.

This results in a slightly larger fix, but results in clear code.

Note: this patch depends on "nvmem: core: initialise nvmem->id early"
and "nvmem: core: remove nvmem_config wp_gpio".

Fixes: 5544e90c8126 ("nvmem: core: add error handling for dev_set_name")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/nvmem/core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 843e2f5696e6..19497f555e07 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -772,15 +772,17 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	nvmem->id = rval;
 
+	nvmem->dev.type = &nvmem_provider_type;
+	nvmem->dev.bus = &nvmem_bus_type;
+	nvmem->dev.parent = config->dev;
+
+	device_initialize(&nvmem->dev);
+
 	if (!config->ignore_wp)
 		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(nvmem->wp_gpio)) {
-		ida_free(&nvmem_ida, nvmem->id);
-		rval = PTR_ERR(nvmem->wp_gpio);
-		kfree(nvmem);
-		return ERR_PTR(rval);
-	}
+	if (IS_ERR(nvmem->wp_gpio))
+		goto err_put_device;
 
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
@@ -791,9 +793,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->stride = config->stride ?: 1;
 	nvmem->word_size = config->word_size ?: 1;
 	nvmem->size = config->size;
-	nvmem->dev.type = &nvmem_provider_type;
-	nvmem->dev.bus = &nvmem_bus_type;
-	nvmem->dev.parent = config->dev;
 	nvmem->root_only = config->root_only;
 	nvmem->priv = config->priv;
 	nvmem->type = config->type;
@@ -821,11 +820,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		break;
 	}
 
-	if (rval) {
-		ida_free(&nvmem_ida, nvmem->id);
-		kfree(nvmem);
-		return ERR_PTR(rval);
-	}
+	if (rval)
+		goto err_put_device;
 
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
@@ -836,7 +832,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
-	rval = device_register(&nvmem->dev);
+	rval = device_add(&nvmem->dev);
 	if (rval)
 		goto err_put_device;
 
-- 
2.30.2

