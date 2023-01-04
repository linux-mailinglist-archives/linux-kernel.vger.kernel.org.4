Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1B65D6FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbjADPQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjADPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:15:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281912AEA;
        Wed,  4 Jan 2023 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845353; x=1704381353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDoL7FOyUUIFfG78pUESx3o8vuaKpREkODVrRIazBhM=;
  b=PaUP/1mEb6ORTqiF1UN4pf3zRPnuLKVvP0fzm+VSB5UwIy7EAWHLgucu
   i95KRVuxkQaX95fHdZSxERRhC1aVC9tG+GH47dkj11hck/b5N/cpUXMcr
   /CBMuDos3J2rMEQ2jC1e0CU6DpxyOnKr5lmWj0omeclaqI5RxDpY8bfSk
   zrs4iTy9tUB4ev+BXaJkpYHZdnKgaOUCv5Dzm8av7oW5Do4iRXURouq9a
   o23YHVKb65HXE8vwKqqfihD5wWAEQkoiIEM9NXoPZKwFWeH1NoqaKwEj/
   8lJmZLPbfjTb856dCNhaZ18yOX0QuZ/V7A49BzYHID+mckoT+tux8wUZO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644320"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700729"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700729"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:50 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/10] tty: Cleamup tty_port_set_suspended() bool parameter
Date:   Wed,  4 Jan 2023 17:15:23 +0200
Message-Id: <20230104151531.73994-3-ilpo.jarvinen@linux.intel.com>
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

Make callers pass true/false consistently for bool val.

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

