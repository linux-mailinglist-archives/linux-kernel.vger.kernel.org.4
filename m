Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5D6B1D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCIIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCIILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:11:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B0E1914;
        Thu,  9 Mar 2023 00:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349411; x=1709885411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UCn20Az7GPv1MH+6Zp/KBKOW/X6nkW75ErD/GRcZlfk=;
  b=IWy6OjSKLC1Q68vXcaZ55FVYEU85aRgQ9pMlR5wkdbeFtJhl2eHjW+At
   7SFmvdW8D0qoln3GMxm9Ay2L4ejqqhKCGworHjvALGK+1xOzAWiPVFTuK
   XzQ3S8jQYnLWeFhxFXDzkg5qnEBXosBF61gQ1Z7BzMxm79TsrKZDzLLp0
   /fido2WLMCbtB3Wdb15gcEEtoWxBKOGX+clOAiojtPqfV11ShuxXMS/OR
   +Cvv7x7JW4C9ZTWcER7uckxnO9Yu+Cshk13A5j9Lav2q+U6G+gjWjKgME
   N/6z4NThjZDrN//VJtYo7vCDpn2e69MtsXYV37gnb6aCwMp4QJ/+ng1+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853601"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746228001"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746228001"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:44 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/8] serial: Rename uart_change_speed() to uart_change_line_settings()
Date:   Thu,  9 Mar 2023 10:09:20 +0200
Message-Id: <20230309080923.11778-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
References: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_change_speed() changes more than just speed so rename it to more
generic uart_change_line_settings().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7201bbc44fa7..ecdc5d9cdb53 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -177,8 +177,8 @@ static void uart_port_dtr_rts(struct uart_port *uport, bool active)
 }
 
 /* Caller holds port mutex */
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-			      const struct ktermios *old_termios)
+static void uart_change_line_settings(struct tty_struct *tty, struct uart_state *state,
+				      const struct ktermios *old_termios)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct ktermios *termios;
@@ -277,7 +277,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		/*
 		 * Initialise the hardware port settings.
 		 */
-		uart_change_speed(tty, state, NULL);
+		uart_change_line_settings(tty, state, NULL);
 
 		/*
 		 * Setup the RTS and DTR signals once the
@@ -993,7 +993,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 				      current->comm,
 				      tty_name(port->tty));
 			}
-			uart_change_speed(tty, state, NULL);
+			uart_change_line_settings(tty, state, NULL);
 		}
 	} else {
 		retval = uart_startup(tty, state, true);
@@ -1655,7 +1655,7 @@ static void uart_set_termios(struct tty_struct *tty,
 		goto out;
 	}
 
-	uart_change_speed(tty, state, old_termios);
+	uart_change_line_settings(tty, state, old_termios);
 	/* reload cflag from termios; port driver may have overridden flags */
 	cflag = tty->termios.c_cflag;
 
@@ -2451,7 +2451,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			ret = ops->startup(uport);
 			if (ret == 0) {
 				if (tty)
-					uart_change_speed(tty, state, NULL);
+					uart_change_line_settings(tty, state, NULL);
 				spin_lock_irq(&uport->lock);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
-- 
2.30.2

