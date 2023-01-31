Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BA682650
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjAaIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAaIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:25:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5949A3B0DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D021E612E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C543DC433EF;
        Tue, 31 Jan 2023 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675153516;
        bh=F1oXVOG/G5R87LGJbW98rwPjWbBIBnHqxHXX0+MontQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF8/3THWoIANAxJrGRuxiPzPISUirh6sUuYV5ua3A5AAvSzQGkF3q/RO1E7TIDURz
         ntbuNvUUT2FO0OLG58vCouk/+gi0LQdfnGsoYWe2RhFlpXPT3MAHQKapREJS3vB1ni
         uMGmglITwfiVc6CcvpBQPCx6/wjthDkujx1JvMSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: platform: simplify __platform_driver_probe()
Date:   Tue, 31 Jan 2023 09:24:59 +0100
Message-Id: <20230131082459.301603-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131082459.301603-1-gregkh@linuxfoundation.org>
References: <20230131082459.301603-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=gregkh@linuxfoundation.org; h=from:subject; bh=F1oXVOG/G5R87LGJbW98rwPjWbBIBnHqxHXX0+MontQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMk3LkS/Fp4uXRy0K18ya+/V35ZSxmKTrtdxWa12S93r8Wfb ndR3HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR/q8MCzbd2vCxr7+HzzK/7ax+5a 996c86HBnmqVw87J6hNXHS0/KjWq+OzYkuNmO/BwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__platform_driver_probe() pokes around in some bus and driver private
lists and locks in a way that is not needed at all.  The code only wants
to know if a device was bound to the driver that was registered, so walk
all devices on the bus to see if there was a match.  If there is not a
match, return an error.  This is the same logic as was originally
present, but just done in a simpler and more obvious way that is not a
layering violation.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 423874269f9d..77510e4f47de 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -883,6 +883,13 @@ static int platform_probe_fail(struct platform_device *pdev)
 	return -ENXIO;
 }
 
+static int is_bound_to_driver(struct device *dev, void *driver)
+{
+	if (dev->driver == driver)
+		return 1;
+	return 0;
+}
+
 /**
  * __platform_driver_probe - register driver for non-hotpluggable device
  * @drv: platform driver structure
@@ -936,20 +943,17 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 	if (retval)
 		return retval;
 
-	/*
-	 * Fixup that section violation, being paranoid about code scanning
-	 * the list of drivers in order to probe new devices.  Check to see
-	 * if the probe was successful, and make sure any forced probes of
-	 * new devices fail.
-	 */
-	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
+	/* Force all new probes of this driver to fail */
 	drv->probe = platform_probe_fail;
-	if (list_empty(&drv->driver.p->klist_devices.k_list))
-		retval = -ENODEV;
-	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
 
-	if (retval)
+	/* Walk all platform devices and see if any actually bound to this driver.
+	 * If not, return an error as the device should have done so by now.
+	 */
+	if (!bus_for_each_dev(&platform_bus_type, NULL, &drv->driver, is_bound_to_driver)) {
+		retval = -ENODEV;
 		platform_driver_unregister(drv);
+	}
+
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__platform_driver_probe);
-- 
2.39.1

