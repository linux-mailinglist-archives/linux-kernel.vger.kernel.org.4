Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5737601483
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJQRQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJQRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:16:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2906E2C9;
        Mon, 17 Oct 2022 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026976; x=1697562976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oq9lfr47wRzD1O5V9gnT0VqegzfjTTYOexE9V2H6pyw=;
  b=IFvhxOg2n8YJYpGH16hD9OG/hb4lXoD8/EG4D2azOtN+3vMLUpdDLQvG
   sKMqkLAthrs9xOLbUKdBWimw9T0nqRudPCN9AW87CJQ7+5H+JPFdcx72w
   ZbAZpNCuVzaca9Nl09OC9RxoTVsWQTRXylbtZlQTt6fKGqj6n2b/ylXhK
   a0cyL69w9o+huVNNCudZ0xAwPPJRRXqE1B8aiACDHzREYIimjQwB720jj
   fbq/+g2UVI19lAJdLoC+63ggP6SlK+XS5c1ZfdFtFMN2vwCbhjJt7QUUG
   /PRrN4uQaYIVxIa9CMdsd9hb7kYAwnAZE4OItJ2lXAoWpmOIkzASVGH+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="286255403"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="286255403"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="579449586"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="579449586"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2022 10:16:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3688B26D; Mon, 17 Oct 2022 20:16:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_core: Use str_enabled_disabled() helper
Date:   Mon, 17 Oct 2022 20:16:33 +0300
Message-Id: <20221017171633.65275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use str_enabled_disabled() helper instead of open coding the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94fbf0add2ce..80a2fc2fbd4d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -32,6 +32,7 @@
 #include <linux/nmi.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #ifdef CONFIG_SPARC
@@ -1175,8 +1176,8 @@ static int __init serial8250_init(void)
 
 	serial8250_isa_init_ports();
 
-	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
-		nr_uarts, share_irqs ? "en" : "dis");
+	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %s\n",
+		nr_uarts, str_enabled_disabled(share_irqs));
 
 #ifdef CONFIG_SPARC
 	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
-- 
2.35.1

