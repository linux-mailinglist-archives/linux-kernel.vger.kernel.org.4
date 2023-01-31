Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06968264F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjAaIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjAaIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:25:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D5F3B0D4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:25:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02BFDB81A0A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C0FC433EF;
        Tue, 31 Jan 2023 08:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675153505;
        bh=RtmuTq5OHnGLeEYC2dmIQ+MQrc9DTxQd1PUggq7HCe8=;
        h=From:To:Cc:Subject:Date:From;
        b=HLYNvKJ2ugjHkQzsTisgHdPxKK8CfPoT0eT3JEMEru9BpZ9iqa0PU3BcNMVs6MMEk
         GKpYSpCxGP6ACscVcjmUdO+5iQU1U8xQwkq+WhzZ5pxFszRvNXXlnzhF+P4yJixLEO
         vutlfMNlhvjqXOGO+bJke9RqHrqiKWJyfiksQu+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] driver core: platform: removed unneeded variable from __platform_driver_probe()
Date:   Tue, 31 Jan 2023 09:24:58 +0100
Message-Id: <20230131082459.301603-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=gregkh@linuxfoundation.org; h=from:subject; bh=RtmuTq5OHnGLeEYC2dmIQ+MQrc9DTxQd1PUggq7HCe8=; b=owGbwMvMwCRo6H6F97bub03G02pJDMk3LkSu2xYfOVGkUmGz6AxPvn83+PlLPKU/TZ345F1TX/P3 VTvXdMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBETl9kmCvwUfbi6/eFt5ZxHtxd9q uvyDi77jLDgrYc3i3aNkIGc6d86qqVdrbgc3nBDQA=
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

In the reworking of the function __platform_driver_probe() over the
years, it turns out that the variable 'code' does not actually do
anything or mean anything anymore and can be removed to simplify the
logic when trying to read and understand what this function is actually
doing.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 262555b83bed..423874269f9d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -906,7 +906,7 @@ static int platform_probe_fail(struct platform_device *pdev)
 int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 		int (*probe)(struct platform_device *), struct module *module)
 {
-	int retval, code;
+	int retval;
 
 	if (drv->driver.probe_type == PROBE_PREFER_ASYNCHRONOUS) {
 		pr_err("%s: drivers registered with %s can not be probed asynchronously\n",
@@ -932,7 +932,7 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 
 	/* temporary section violation during probe() */
 	drv->probe = probe;
-	retval = code = __platform_driver_register(drv, module);
+	retval = __platform_driver_register(drv, module);
 	if (retval)
 		return retval;
 
@@ -944,11 +944,11 @@ int __init_or_module __platform_driver_probe(struct platform_driver *drv,
 	 */
 	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
 	drv->probe = platform_probe_fail;
-	if (code == 0 && list_empty(&drv->driver.p->klist_devices.k_list))
+	if (list_empty(&drv->driver.p->klist_devices.k_list))
 		retval = -ENODEV;
 	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
 
-	if (code != retval)
+	if (retval)
 		platform_driver_unregister(drv);
 	return retval;
 }
-- 
2.39.1

