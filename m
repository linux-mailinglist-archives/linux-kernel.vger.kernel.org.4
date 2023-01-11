Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89D665DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbjAKOYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbjAKOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:24:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70651B1CA;
        Wed, 11 Jan 2023 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447051; x=1704983051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I6INK+vllASz81Q/lAEuJEpKu7fwlusgKRFEwe90IfM=;
  b=mj5SvfYe+/pZrKXRzr6ejYyaIg2m5e/ETmg6PDRFw3A77akLheC91Wkv
   9NRUgmAsLPSHs6oMsLOT8Y3skSKHk+5i84RJeJIXVrTmSWlGeyW/ZZUYX
   svv2wyARh1ibf+XLkBQOQ0mDBFYEzRe2CfqF2+3QZ0oUuw5212MKnrlPr
   LE69Q1zVDZuXfWe5PMoG1/KlBUHr8JUXz8MA2KTYKSFx3gcAWYTTfTLOD
   JRR4yMAF3d1LFJHViqCPPDYEGDTZZfQmg91aGIY1b2TgFsUGn9tR+FBkM
   fQTm/ZIf68vp0zjTfyXIMftFrhESpm0ci6yijNQLUyqjjZT5d/PLgyaD4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793552"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607381870"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607381870"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:08 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 05/13] serial: Convert uart_{,port_}startup() init_hw param to bool
Date:   Wed, 11 Jan 2023 16:23:23 +0200
Message-Id: <20230111142331.34518-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
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

Convert init_hw parameter in uart_startup() and uart_port_startup() to
bool as code treats them like bool.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

