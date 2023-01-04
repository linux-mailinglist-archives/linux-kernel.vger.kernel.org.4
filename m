Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615865D706
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbjADPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbjADPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:16:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289BE167FA;
        Wed,  4 Jan 2023 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845362; x=1704381362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pMvCSqx3PAMTPEbaidZApfUuzWFE4oF2FcTwm2mVLI=;
  b=NaZ0rDrziHPBEqzby2YUcI0fkj0S/7ssKbEwoVbpW0qQpB6bvo5BueIW
   CQSvUbCxYQoRif4Fk/ko8j87s54EFp9yFlIrW8Vx7FVSTNMRUqwLkxbec
   IeSH9V6L8xURUP3EmTSphnbP12Ph+6SmE03FE/UDRLQUcSpx97mIoh9o1
   TdRwiBxe1a+rzv+S/b7A43GTmPszj5oBW/yXxOuOW8GqF6mUfJWEg/jZ8
   qe4beaOav/6MvwDmewqnqaUWl5g/khanYMUnOiRgpwMzAWDTchkDObNjC
   NoQeJo5II+7lF1pji9dSAo3rVVV7BH7fUCOXWXVFYoLznHucbaZNyEuwG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644364"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644364"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700784"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700784"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:59 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/10] serial: Convert uart_{,port_}startup() init_hw param to bool
Date:   Wed,  4 Jan 2023 17:15:26 +0200
Message-Id: <20230104151531.73994-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert init_hw parameter in uart_startup() and uart_port_startup() to
bool as code treats them like bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c881fefa3d97..a0260a40bdb9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -181,8 +181,7 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
  */
-static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+static int uart_port_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)
 {
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long flags;
@@ -253,8 +252,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	return retval;
 }
 
-static int uart_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+static int uart_startup(struct tty_struct *tty, struct uart_state *state, bool init_hw)
 {
 	struct tty_port *port = &state->port;
 	int retval;
@@ -997,7 +995,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			uart_change_speed(tty, state, NULL);
 		}
 	} else {
-		retval = uart_startup(tty, state, 1);
+		retval = uart_startup(tty, state, true);
 		if (retval == 0)
 			tty_port_set_initialized(port, true);
 		if (retval > 0)
@@ -1165,7 +1163,7 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 		 */
 		uport->ops->config_port(uport, flags);
 
-		ret = uart_startup(tty, state, 1);
+		ret = uart_startup(tty, state, true);
 		if (ret == 0)
 			tty_port_set_initialized(port, true);
 		if (ret > 0)
@@ -1943,7 +1941,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * Start up the serial port.
 	 */
-	ret = uart_startup(tty, state, 0);
+	ret = uart_startup(tty, state, false);
 	if (ret > 0)
 		tty_port_set_active(port, true);
 
-- 
2.30.2

