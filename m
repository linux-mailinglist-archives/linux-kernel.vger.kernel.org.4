Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03189663FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjAJMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbjAJMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:03:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1058F82;
        Tue, 10 Jan 2023 04:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352200; x=1704888200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUGs6q4BLTPG+Jnm0pLx052cqoyjzXq6iLnZ73u1afk=;
  b=CxbQkj5NP03tEN2sfk4QAsDBk7Vbf58CpPCHFHZ/0I8ajd70rwc9tm35
   30Po02HjQ58kI0a90etEB8i1gDxPKDIzOeNOl9XGHAL/JjJZtokDS6wHT
   ZEuvNhXQkH3x87l1SeBN7qMn5Ls39d5BT3bw82Mmwz3RLGF+4LooSoagi
   4nWLpPvA37XScWg0Njd18QZIqCKVEwjIVp+GdWHSPM8ajMk9pHoHrxTsV
   j4YfeMVHTNjOJg2uxrT8j3YLO+sMdpVU8FgWIj9Nw8PRTMXJdDUtZwAWC
   mLF3RZQRvd8+Og1KB+rT4rb8TfCm23CTbikqIoFIY7bNw1q89tZcD+To9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350053"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350053"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799406836"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799406836"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:17 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/13] serial: Convert uart_{,port_}startup() init_hw param to bool
Date:   Tue, 10 Jan 2023 14:02:18 +0200
Message-Id: <20230110120226.14972-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert init_hw parameter in uart_startup() and uart_port_startup() to
bool as code treats them like bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c881fefa3d97..f7074ac02801 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -182,7 +182,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
  * will be serialised by the per-port mutex.
  */
 static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+			     bool init_hw)
 {
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long flags;
@@ -254,7 +254,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 }
 
 static int uart_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+			bool init_hw)
 {
 	struct tty_port *port = &state->port;
 	int retval;
@@ -997,7 +997,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			uart_change_speed(tty, state, NULL);
 		}
 	} else {
-		retval = uart_startup(tty, state, 1);
+		retval = uart_startup(tty, state, true);
 		if (retval == 0)
 			tty_port_set_initialized(port, true);
 		if (retval > 0)
@@ -1165,7 +1165,7 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 		 */
 		uport->ops->config_port(uport, flags);
 
-		ret = uart_startup(tty, state, 1);
+		ret = uart_startup(tty, state, true);
 		if (ret == 0)
 			tty_port_set_initialized(port, true);
 		if (ret > 0)
@@ -1943,7 +1943,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * Start up the serial port.
 	 */
-	ret = uart_startup(tty, state, 0);
+	ret = uart_startup(tty, state, false);
 	if (ret > 0)
 		tty_port_set_active(port, true);
 
-- 
2.30.2

