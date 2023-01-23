Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B767863C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjAWTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjAWTZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:25:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C262684;
        Mon, 23 Jan 2023 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674501935; x=1706037935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jn06hBZFhvvnzBpPCBigXwHR/0Hpu5dt4n5dAWV7Zy0=;
  b=a1Y7dBrBHuS4N04nXn2PxVacSAGJ7iW8sNNKiZ5k8uz6pQfwL8E+8Kgw
   wawuyezqwJScuy1W/eWvx84eLViVs7QRoZ06r/JwhwVrw8+OijKIUp3y2
   0E4bkszG0vQ5EQGyM8LYADTXSx6pitvK7loglBkYMpwSmnagfpINhpHH1
   IVVnKArCtC22Rkw3ikGlW6AXihakF8th5kFfYqudLyORMiK0fw24ChOkB
   U23XU36l2bRmuVi3jXoLdve0/paTq5XrGNlXcJYEr4cJau9C6Vrz5SmaQ
   9009s9USuzaiaqSlZrecgMw1UckiuD0JEG63QQqAAOmxJhJQNH0/TEfgX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328215111"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328215111"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 11:25:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="750549548"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="750549548"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jan 2023 11:25:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9BD17119; Mon, 23 Jan 2023 21:26:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: liteuart: Remove a copy of UART id in private structure
Date:   Mon, 23 Jan 2023 21:26:04 +0200
Message-Id: <20230123192604.81452-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct liteuart_port keeps tracking of UART ID which is also
saved in the struct uart_port as line member. Drop the former one
and use the latter everywhere.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Depends on
https://lore.kernel.org/linux-serial/20230123191741.79751-1-andriy.shevchenko@linux.intel.com/

 drivers/tty/serial/liteuart.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 562892395570..80de3a42b67b 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -46,7 +46,6 @@
 struct liteuart_port {
 	struct uart_port port;
 	struct timer_list timer;
-	u32 id;
 	u8 irq_reg;
 };
 
@@ -314,7 +313,6 @@ static int liteuart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	uart->id = dev_id;
 	/* values not from device tree */
 	port->dev = &pdev->dev;
 	port->iotype = UPIO_MEM;
@@ -334,7 +332,7 @@ static int liteuart_probe(struct platform_device *pdev)
 	return 0;
 
 err_erase_id:
-	xa_erase(&liteuart_array, uart->id);
+	xa_erase(&liteuart_array, dev_id);
 
 	return ret;
 }
@@ -342,10 +340,10 @@ static int liteuart_probe(struct platform_device *pdev)
 static int liteuart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
-	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned int line = port->line;
 
 	uart_remove_one_port(&liteuart_driver, port);
-	xa_erase(&liteuart_array, uart->id);
+	xa_erase(&liteuart_array, line);
 
 	return 0;
 }
-- 
2.39.0

