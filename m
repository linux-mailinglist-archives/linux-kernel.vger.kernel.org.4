Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE366785F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjAWTRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:17:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6F65BD;
        Mon, 23 Jan 2023 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674501436; x=1706037436;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xUd5gtdKQP9i7qQAzIxAFPhsw1u+3g5bDp1G9zgUY9w=;
  b=R2t92l0rc6oq8nPlERA/18yUlUPwbDzM3gF4gPUR8YONlRwbhIPPxB/V
   ftrHJG5KqRscBVwbxelKowUurJ9gMlWh5Uyxj562e+i0Knzbq4cPC3Y1N
   nH03dh5kGWpVsUFGoiftA4WGm1m5PL5PRh7ChNB0Tt4nofumYJwnN40jp
   4qYclTEiu0cDYPWgsi9pFH+n+gANLrXk+7kyDjuRBXJB5j8S1333x8Dsb
   nj0nc+zUsfMOmLB7iN499o+lDZal+KjVK4rMk6CdgwD7PqOVtlkWExOQl
   psQczJLz9WH4BBBVLTHoa3kpLLoVtOmn5v5bPuIDyDUciSfBJmPYH1omH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="327385790"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="327385790"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:17:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611735871"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611735871"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2023 11:17:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B24F9119; Mon, 23 Jan 2023 21:17:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: liteuart: Don't mix devm_*() with non-devm_*() calls
Date:   Mon, 23 Jan 2023 21:17:41 +0200
Message-Id: <20230123191741.79751-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the probe we need to call all devm_*() first followed by
non-devm_*() calls. This is due to reversed clean up that
may happen in a wrong order otherwise. The driver currently
allocates xarray before calling
devm_platform_get_and_ioremap_resource(). While it's not an
issue in this certain case, it's still better to be pedantic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 192ad681de35..562892395570 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -286,37 +286,35 @@ static int liteuart_probe(struct platform_device *pdev)
 	struct xa_limit limit;
 	int dev_id, ret;
 
-	/* look for aliases; auto-enumerate for free index if not found */
-	dev_id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (dev_id < 0)
-		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
-	else
-		limit = XA_LIMIT(dev_id, dev_id);
-
 	uart = devm_kzalloc(&pdev->dev, sizeof(struct liteuart_port), GFP_KERNEL);
 	if (!uart)
 		return -ENOMEM;
 
-	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
-	if (ret)
-		return ret;
-
-	uart->id = dev_id;
 	port = &uart->port;
 
 	/* get membase */
 	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
-	if (IS_ERR(port->membase)) {
-		ret = PTR_ERR(port->membase);
-		goto err_erase_id;
-	}
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
 
 	ret = platform_get_irq_optional(pdev, 0);
 	if (ret < 0 && ret != -ENXIO)
-		goto err_erase_id;
+		return ret;
 	if (ret > 0)
 		port->irq = ret;
 
+	/* look for aliases; auto-enumerate for free index if not found */
+	dev_id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (dev_id < 0)
+		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
+	else
+		limit = XA_LIMIT(dev_id, dev_id);
+
+	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	uart->id = dev_id;
 	/* values not from device tree */
 	port->dev = &pdev->dev;
 	port->iotype = UPIO_MEM;
-- 
2.39.0

