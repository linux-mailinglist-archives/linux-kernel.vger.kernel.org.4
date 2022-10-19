Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5E603FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiJSJhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiJSJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:30:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A68C97D4;
        Wed, 19 Oct 2022 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170843; x=1697706843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4cl4AhnNeNw4BJarfN1NFenzpHPoBPllDdEre7J9jGg=;
  b=EYpWsTzeiMUPSWammoSAy3PZlY3z5Y6A6VFGOIdPFeYxJE+Y5j758mRL
   +wRiUE8m6Ul/XSB/OpM2XclGqTyB7s932vBomyBaO8GtqLqJTh9y3gyH4
   uf5/jvNiamhWw85oeEj7BNx0raId+Cg/IA6hitU1iKzt3FpVNyiYlqRxf
   TPVqh4jasts/5WF/mT5Xis3uVOa/F7c8GGZIjxO8vt1CaqQtkUsAaXQJ0
   CLP6qglwTjTgfl4m5WzCGKWTUW5Vf7g3sCk99+tsPWd2NG3limucxc0I4
   zB7EsiNTv38sixuXYkO9GgtmHraLDmBvE7yxq+nisiFGONUBGbg9GAeMz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910885"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910885"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118606"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118606"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/44] serial: ar933x: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:16 +0300
Message-Id: <20221019091151.6692-10-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/ar933x_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 925484a42c82..4c3d04c6826a 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -425,8 +425,7 @@ static void ar933x_uart_tx_chars(struct ar933x_uart_port *up)
 
 		ar933x_uart_putc(up, xmit->buf[xmit->tail]);
 
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
+		uart_xmit_advance(&up->port, 1);
 	} while (--count > 0);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
2.30.2

