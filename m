Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A166FF135
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjEKMMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjEKMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:11:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26190AD33;
        Thu, 11 May 2023 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807072; x=1715343072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgSo5iUE5tQb+4UxGhuvzVjJhZnju7Zh1OoucPsBSwE=;
  b=PzW9E6suCyEpw58sI0OZ/euFbEs9cbvJIkGDzeI7EQuNdK1guBxWhV66
   AHKawcoXcPRTW46fYj9UhPOVP6C74UP5HV3mZa2Pp8DGIUVVPQ9l40MCh
   //d1stcWbNcFnOaY6MnxjG/4Ohj27l/RuQBdM2OUBajHLjkqPoB0ogmah
   eMie+960agn5YAk0SVWWqaEcOH6oQvURZIItBai8HrPrAGsWElzvdmzvI
   xxOdqN1XI+rfGGYeD4SiPl531PL1r+BE4ROgmrIa/df7DVnZgxMT6b97P
   dXRDThEZEwaMkl6YCB5x2rpdfhEO1LQUjZXOTvgmLU3QotcJrHUR+mdOk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839057"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839057"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921202"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921202"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:10:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/6] serial: 8250: Document uart_8250_port's ->dl_read/write()
Date:   Thu, 11 May 2023 15:10:25 +0300
Message-Id: <20230511121029.13128-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
References: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the struct uart_8250_port divisor latch function
pointers. Documentation is in kernel doc format but don't enable kernel
doc yet as many other fields remain undocumented.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/serial_8250.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 7b5d558e4e0c..d64e7bbe1f2f 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -90,8 +90,17 @@ struct uart_8250_em485 {
  * their own 8250 ports without registering their own
  * platform device.  Using these will make your driver
  * dependent on the 8250 driver.
+ *
+ * @dl_read: ``u32 ()(struct uart_8250_port *port)``
+ *
+ *	UART divisor latch read.
+ *
+ * @dl_write: ``void ()(struct uart_8250_port *port, u32 value)``
+ *
+ *	Write @value into UART divisor latch.
+ *
+ *	Locking: Caller holds port's lock.
  */
-
 struct uart_8250_port {
 	struct uart_port	port;
 	struct timer_list	timer;		/* "no irq" timer */
-- 
2.30.2

