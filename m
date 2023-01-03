Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12B965BD56
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbjACJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjACJmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:42:42 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918D2D2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4fMNHgZDzPHb49xSU4TUscrYEmRUetsr0RmDQrt06rI=; b=mNrk/czourWWRaA79ofmXCfNmP
        /eYQUwcpOXo0e3atgF/tTg29ftLZxbOJl2rjaBotIrtBedMULRz5kaWblLEEZQRRuyRyPgZcWDBdD
        VgRUF51F4ZgV9vokiZ0WqFLwVnIoWID7wiLPROknCsAM3usgBzslc/TNzUutRrYDnXVjrKiM9FjQo
        dwU7YhfRQmvreef1WmtQGyseBrCYI0PSiUaW0RQlaUxLAqwatUxxXxqnzYz0vc1bpuPMXFAcd0DcO
        2z6ru8pEYVMQ2navBfm8J0vGJyJU0qFOewO5tuvybMZsLnKxXhnLY0hCUWzHz+yycyMiiOeMuFA3C
        FasNF7TQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37962 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pCdoZ-0005AA-88; Tue, 03 Jan 2023 09:42:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pCdoY-0044aT-A5; Tue, 03 Jan 2023 09:42:34 +0000
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: fix registration vs use race
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCdoY-0044aT-A5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 03 Jan 2023 09:42:34 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX6 CPU frequency driver sometimes fails to register at boot time
due to nvmem_cell_read_u32() sporadically returning -ENOENT.

This happens because there is a window where __nvmem_device_get() in
of_nvmem_cell_get() is able to return the nvmem device, but as cells
have been setup, nvmem_find_cell_entry_by_node() returns NULL.

The occurs because the nvmem core registration code violates one of the
fundamental principles of kernel programming: do not publish data
structures before their setup is complete.

Fix this by making nvmem core code conform with this principle.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/nvmem/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..6b89fb6fa582 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -835,22 +835,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.groups = nvmem_dev_groups;
 #endif
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_register(&nvmem->dev);
-	if (rval)
-		goto err_put_device;
-
 	if (nvmem->nkeepout) {
 		rval = nvmem_validate_keepouts(nvmem);
 		if (rval)
-			goto err_device_del;
+			goto err_put_device;
 	}
 
 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-			goto err_device_del;
+			goto err_put_device;
 	}
 
 	if (config->cells) {
@@ -867,6 +861,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_register(&nvmem->dev);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -876,8 +876,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-err_device_del:
-	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
 
-- 
2.30.2

