Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ACD66D975
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjAQJNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbjAQJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:12:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5A8680;
        Tue, 17 Jan 2023 01:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946352; x=1705482352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I6INK+vllASz81Q/lAEuJEpKu7fwlusgKRFEwe90IfM=;
  b=QD/FvUTv6JtxPOCdXkBhnBVVfwu5c54KemDggwyhiIzpyZvBKv6lon63
   DiGqUqD8ryFsUAS6b74GTpBTtF2IMIO3vlM1z4jROCoY+7gkp3KK7mt28
   A0yFzGee91rWKJbfEGNWZyo48cHGCgss5QoeznTjiefegsJksF2VA3FRd
   Qq1f0RW1pXYskPQpK8nzj6vcNdnssLlmUR//Q+TjNUsTafottw5H6//jL
   8rXK5QH+hA9XWdNSz9v9WJjh3x3fG61ScFjT0OggGo9UuphIm0ceXj0qq
   3aAKstzOp2MmhZAkvJEUDbAhrsJxblYRXjPd2II3wx3ew39v6I/NSVjmz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324700999"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324700999"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174119"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174119"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:47 -0800
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
Subject: [PATCH v4 05/12] serial: Convert uart_{,port_}startup() init_hw param to bool
Date:   Tue, 17 Jan 2023 11:03:51 +0200
Message-Id: <20230117090358.4796-6-ilpo.jarvinen@linux.intel.com>
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

