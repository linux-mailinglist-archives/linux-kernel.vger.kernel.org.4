Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F286B1D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCIIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCIIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:11:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370EE062B;
        Thu,  9 Mar 2023 00:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349414; x=1709885414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOuN9Fv5gO0pmI98uoE3O6yj9f/bKC+iD++4nKAJLCw=;
  b=PnfIP8wyW194aQblwRo4x1FqtG1poMmxv/R7XpWaBR+lumjCjODi+LZW
   bMwXH29CeILc3f/4IL/1XOShiVRr9FMER86sL/WoUwxepxK3fu8zX8aqb
   jv8imG36YFIHyDDjTeQn1Qi3ty0bWDYj9jcY4tRFDpaHTHQWlkDoI5rWj
   IcIKQj19NQSbt62Xywbs0cVxpCKHyr0NpfgHXMEDGF4dgqajxesNyOUZK
   +ZK2oBd4gF5ILMfdTO3vTnI2nMqgEcs2rplucv+KEhXq1QTdtDHg5OpEf
   mBNAkYNBQsxeh3GDUVh0R+4LANBpTloQkIwbtn2QZmT1H0HkfIaaUpVKo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853610"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746228010"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746228010"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:47 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/8] serial: Make hw_stopped bool
Date:   Thu,  9 Mar 2023 10:09:21 +0200
Message-Id: <20230309080923.11778-7-ilpo.jarvinen@linux.intel.com>
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

Convert hw_stopped in uart_port to bool because its more appropriate
type for how it is used.

Also convert the local variable in uart_change_line_settings() caching
old hw_stopped to bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 6 +++---
 include/linux/serial_core.h      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ecdc5d9cdb53..31b69e61e71d 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -182,7 +182,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct ktermios *termios;
-	int hw_stopped;
+	bool hw_stopped;
 
 	/*
 	 * If we have no tty, termios, or the port does not exist,
@@ -3304,13 +3304,13 @@ void uart_handle_cts_change(struct uart_port *uport, bool active)
 	if (uart_softcts_mode(uport)) {
 		if (uport->hw_stopped) {
 			if (active) {
-				uport->hw_stopped = 0;
+				uport->hw_stopped = false;
 				uport->ops->start_tx(uport);
 				uart_write_wakeup(uport);
 			}
 		} else {
 			if (!active) {
-				uport->hw_stopped = 1;
+				uport->hw_stopped = true;
 				uport->ops->stop_tx(uport);
 			}
 		}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 05d18a145b3a..66ecec15a1bf 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -553,7 +553,7 @@ struct uart_port {
 #define UPSTAT_AUTOXOFF		((__force upstat_t) (1 << 4))
 #define UPSTAT_SYNC_FIFO	((__force upstat_t) (1 << 5))
 
-	int			hw_stopped;		/* sw-assisted CTS flow state */
+	bool			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
-- 
2.30.2

