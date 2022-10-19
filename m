Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8FD6040FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJSKcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJSKbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:31:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8D13E96;
        Wed, 19 Oct 2022 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666174225; x=1697710225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0dCpdfIWylLc1GOfauSgHmVL4IjSgKScyJXDK7zGd8U=;
  b=Yj7TgETkiEshYl9BKX1+arSwxMm9FaqO49d85PblMgfSeiVByMvW3Y0t
   ejWurCdPG4+JkKsQ+Nwiz2NxOJDMLRjWuFL8LOa7pYPyCntTDV8EIc6m7
   yecZpXD5lHmM/qlobCn21wTLFDgzJ4fgj4/ZqP+TAp8UteEZIz6DPWzCm
   IZk8NJwd5jmpptJjacnwmgGUK/fNBylFuiRicxVQzvXhQjHRo47yLQAmJ
   mFgxeuL7XdEOJtNd1l5egSc1t1m+fqTcqr8Jmz9OWVF5HWyq0cCsknSVB
   FF0wQd5HP3xgMZmwdgSy2Vv9lej/udVgEMhmLr8cWOvnXxwCSMjaFSdcA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368407274"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="368407274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119246"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119246"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 36/44] serial: sunplus-uart: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:43 +0300
Message-Id: <20221019091151.6692-37-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sunplus-uart.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 7afe61a0e72e..727942c43c45 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -216,9 +216,7 @@ static void transmit_chars(struct uart_port *port)
 
 	do {
 		sp_uart_put_char(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;
-		port->icount.tx++;
-
+		uart_xmit_advance(port, 1);
 		if (uart_circ_empty(xmit))
 			break;
 	} while (sunplus_tx_buf_not_full(port));
-- 
2.30.2

