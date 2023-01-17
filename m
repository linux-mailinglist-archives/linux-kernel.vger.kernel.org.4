Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8429166D96F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbjAQJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjAQJLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:11:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790D3B67D;
        Tue, 17 Jan 2023 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946334; x=1705482334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aq/Xj7/nsyjOJJNoCoUIoSWFh6jWuFSd4E8dlq/Esx8=;
  b=AReY+Ew9qkchlS/ttPlPArFkQYX0YN6B8tWbIKRheQSk487juT0eP5sn
   JWYLR/tgg7/V6v0rSvs8NZIPxPiI4IgwMGYkxdf+VNCuxt51niygcqTUD
   boc17MfWyxmebhNltGaoNZTT6qohhGRq6vY52b/ajht68vkK+fPIhxnED
   s7TIQ1xuIC9o9MJzBp35jwcTvdsUstI6vtj97E+cfJL9tXxbLyar7caee
   F6eS/79DOE/zPaCCiN1ekidxwGAnLIdUei0475/v0PyyaUv7zC50n+9GH
   GZMaaOA04VvBhSny3H8dz0NbKVGmOcmyuy5GDh8Z7dxwwDOt9uj8JMU2W
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324700966"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324700966"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174096"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174096"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:39 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 03/12] tty: Cleanup tty_port_set_active() bool parameter
Date:   Tue, 17 Jan 2023 11:03:49 +0200
Message-Id: <20230117090358.4796-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
References: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make callers pass true/false consistently for bool val.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/amiserial.c          |  2 +-
 drivers/tty/serial/serial_core.c |  4 ++--
 drivers/tty/synclink_gt.c        |  6 +++---
 drivers/tty/tty_port.c           | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index f8cdce1626cb..460d33a1e70b 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1329,7 +1329,7 @@ static void rs_hangup(struct tty_struct *tty)
 	rs_flush_buffer(tty);
 	shutdown(tty, info);
 	info->tport.count = 0;
-	tty_port_set_active(&info->tport, 0);
+	tty_port_set_active(&info->tport, false);
 	info->tport.tty = NULL;
 	wake_up_interruptible(&info->tport.open_wait);
 }
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f9564b1e3dfb..c881fefa3d97 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1827,7 +1827,7 @@ static void uart_hangup(struct tty_struct *tty)
 		spin_lock_irqsave(&port->lock, flags);
 		port->count = 0;
 		spin_unlock_irqrestore(&port->lock, flags);
-		tty_port_set_active(port, 0);
+		tty_port_set_active(port, false);
 		tty_port_tty_set(port, NULL);
 		if (uport && !uart_console(uport))
 			uart_change_pm(state, UART_PM_STATE_OFF);
@@ -1945,7 +1945,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	 */
 	ret = uart_startup(tty, state, 0);
 	if (ret > 0)
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 
 	return ret;
 }
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 2b96bf0ecafb..81c94906f06e 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -694,7 +694,7 @@ static void hangup(struct tty_struct *tty)
 	info->port.count = 0;
 	info->port.tty = NULL;
 	spin_unlock_irqrestore(&info->port.lock, flags);
-	tty_port_set_active(&info->port, 0);
+	tty_port_set_active(&info->port, false);
 	mutex_unlock(&info->port.mutex);
 
 	wake_up_interruptible(&info->port.open_wait);
@@ -3169,7 +3169,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 		return 0;
 	}
 
@@ -3226,7 +3226,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open--;
 
 	if (!retval)
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 
 	DBGINFO(("%s block_til_ready ready, rc=%d\n", tty->driver->name, retval));
 	return retval;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 0c00d5bd6c88..469de3c010b8 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -403,7 +403,7 @@ void tty_port_hangup(struct tty_port *port)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
-	tty_port_set_active(port, 0);
+	tty_port_set_active(port, false);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
 	wake_up_interruptible(&port->open_wait);
@@ -518,14 +518,14 @@ int tty_port_block_til_ready(struct tty_port *port,
 	 * the port has just hung up or is in another error state.
 	 */
 	if (tty_io_error(tty)) {
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 		return 0;
 	}
 	if (filp == NULL || (filp->f_flags & O_NONBLOCK)) {
 		/* Indicate we are open */
 		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 		return 0;
 	}
 
@@ -588,7 +588,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 	port->blocked_open--;
 	spin_unlock_irqrestore(&port->lock, flags);
 	if (retval == 0)
-		tty_port_set_active(port, 1);
+		tty_port_set_active(port, true);
 	return retval;
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
@@ -695,7 +695,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 		wake_up_interruptible(&port->open_wait);
 	}
 	spin_unlock_irqrestore(&port->lock, flags);
-	tty_port_set_active(port, 0);
+	tty_port_set_active(port, false);
 }
 EXPORT_SYMBOL(tty_port_close_end);
 
-- 
2.30.2

