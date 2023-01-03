Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B365C470
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjACQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjACQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:59:27 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD5012AE8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZS5H2asUTLZlbBEYJrrAV+i8ORfv/vUr4mwUuUH/Xa4=; b=u0FP7KO7xgXz/q1vqsICXY31OM
        nDIij8oKF/E3R0qNscFrCaRYqUMysaVqsCwQTNOmKL3Cgvk57s7EqYOGNkVugAMnYh9T5khmIqofQ
        7W4tMPkyYz4TU3oqGZd6LhN2u/U7cd/xa2j2CnCUDBQqJXU7KEJ7JaHSnPp19GK3ohsCAPW24A/hb
        MU//WZZowbzKQdORkN0AH03mo+D6PEHyntsfZHr6/3pLYT8eV/u+gkwanHt7pNWK010jCMdwo3Qw/
        3Qh6bCteN03nxKE82MSpUS7X52sjCaMS3leR5xxk5uHaIrFoN7qMJVkYAIus25xDtwPhAVdKxI4q5
        yuF63Fgg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32796 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pCkdG-0005c7-Vh; Tue, 03 Jan 2023 16:59:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pCkdG-004huq-0l; Tue, 03 Jan 2023 16:59:22 +0000
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
Subject: [PATCH v3 2/5] nvmem: core: initialise nvmem->id early
    Bartosz Golaszewski <bgolaszewski@baylibre.com>,Gaosheng Cui <cuigaosheng1@huawei.com>,Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,Maxime Ripard <mripard@kernel.org>, Hector Martin <marcan@marcan.st>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCkdG-004huq-0l@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 03 Jan 2023 16:59:22 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error path for wp_gpio attempts to free the IDA nvmem->id, but
this has yet to be assigned, so will always be zero - leaking the
ID allocated by ida_alloc(). Fix this by moving the initialisation
of nvmem->id earlier.

Fixes: f7d8d7dcd978 ("nvmem: fix memory leak in error path")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/nvmem/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bf11e0c36d60..c1a40d9c3825 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -770,6 +770,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		return ERR_PTR(rval);
 	}
 
+	nvmem->id = rval;
+
 	if (config->wp_gpio)
 		nvmem->wp_gpio = config->wp_gpio;
 	else if (!config->ignore_wp)
@@ -785,7 +787,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
 
-	nvmem->id = rval;
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
 		nvmem->owner = config->dev->driver->owner;
-- 
2.30.2

