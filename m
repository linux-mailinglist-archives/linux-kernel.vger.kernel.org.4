Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A819603FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiJSJia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiJSJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:32:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5408A326C2;
        Wed, 19 Oct 2022 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170874; x=1697706874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6im4WR1jwm2SaUMp4yqSHc+iYJF+/hkOu+zBY1CN4E=;
  b=gmnO7QBJTkZg/Xh9xeUXtlAfTWSBMyvWyKJUSaHjq/LIwJfvEXfdYZzH
   idNhD4gLJWn7u41WFkvzriNR8S2GVoWo/4tT4kyOmFQvGqV8YiaClBXi0
   decuznTpp5pmhwbvB26FH/mlHcYjXBZnwfJGDfmaYJvWEbWdSQMvY7Ssi
   5l+ko2fWcxN7ehUHqyJ5i/HQn0KnnaCNkcfdVkpr2boj1ZIHBh7AxMVl4
   j/0Vk9qAvwk0gHn03P1ZbxWo2y1z/pYGK9AY5WR1fOShXzOON67vZl1xw
   HyV1Akpst7RIy4JTIs8gY3urHcfRw1GVM8G/iL0SqLpkbPgSTI0bPW/8G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910997"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910997"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118812"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118812"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/44] serial: ip22zilog: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:25 +0300
Message-Id: <20221019091151.6692-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/ip22zilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index dd0a8915ce4f..b1f27e168135 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -409,8 +409,7 @@ static void ip22zilog_transmit_chars(struct uart_ip22zilog_port *up,
 	ZSDELAY();
 	ZS_WSYNC(channel);
 
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	up->port.icount.tx++;
+	uart_xmit_advance(&up->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
@@ -609,8 +608,7 @@ static void ip22zilog_start_tx(struct uart_port *port)
 		ZSDELAY();
 		ZS_WSYNC(channel);
 
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 			uart_write_wakeup(&up->port);
-- 
2.30.2

