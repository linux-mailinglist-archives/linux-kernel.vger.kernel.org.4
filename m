Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C0665DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbjAKOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjAKOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:24:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3513E9F;
        Wed, 11 Jan 2023 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447039; x=1704983039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/abY3EvdT/9LBFynpim0jdmH9McxhRPFImaHI0+/DE=;
  b=UIjyqdi3BN9L4IuMfCqblGC+eT35JJVmn9Pl34I9XNSdaUBeierao895
   m3DbaXu1YQJ4tW9zDaHfTw/O9X1tjdkMjDqtCmDH0LnzNYljhAfTsuvBK
   PlraWJqLabSBddseAX8ZjSBYGFy+Q9se7XKv3ehG5DAV/4+2onnyMawXZ
   GZLyzc/ggAKYmso205WIZhDG+BLNWfJr+4CtZvqMbt7g9FZKA8+BOowRP
   57Pz708O8zCSCQ/hw2CBcL6N1nOE1lxkfWReBTywqEyARg1nlbv+thXRa
   o/ENB31KOTDJACRGO5DEQvZM1zOujH5CCD++rfuf970ltflHG4E7waS5u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793478"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793478"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:23:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607381830"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607381830"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:23:55 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 02/13] tty: Cleamup tty_port_set_suspended() bool parameter
Date:   Wed, 11 Jan 2023 16:23:20 +0200
Message-Id: <20230111142331.34518-3-ilpo.jarvinen@linux.intel.com>
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

Make callers pass true/false consistently for bool val.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e049c760b738..f9564b1e3dfb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -312,7 +312,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
 	 * we don't try to resume a port that has been shutdown.
 	 */
-	tty_port_set_suspended(port, 0);
+	tty_port_set_suspended(port, false);
 
 	/*
 	 * Do not free() the transmit buffer page under the port lock since
@@ -1725,7 +1725,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
 	 * we don't try to resume a port that has been shutdown.
 	 */
-	tty_port_set_suspended(port, 0);
+	tty_port_set_suspended(port, false);
 
 	/*
 	 * Free the transmit buffer.
@@ -2346,7 +2346,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		int tries;
 		unsigned int mctrl;
 
-		tty_port_set_suspended(port, 1);
+		tty_port_set_suspended(port, true);
 		tty_port_set_initialized(port, false);
 
 		spin_lock_irq(&uport->lock);
@@ -2469,7 +2469,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			}
 		}
 
-		tty_port_set_suspended(port, 0);
+		tty_port_set_suspended(port, false);
 	}
 
 	mutex_unlock(&port->mutex);
-- 
2.30.2

