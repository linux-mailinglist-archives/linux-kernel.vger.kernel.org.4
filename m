Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C956040FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJSKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJSKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:31:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DBF01B7;
        Wed, 19 Oct 2022 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666174228; x=1697710228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uap1H5nY8QhFUnLKuQGsMA8Ds5ys9SXkfxi++zVNE9A=;
  b=iSHRQhncCe/alRTg0MGmpt0EZLSKGBYOD6Iwas3YExkNeO/ObPzsBYYe
   8xEktxeXw1sOi2bEkh3GxWOtnK5SUj9ARyWQalEz5opgHJKVuehXRHVVB
   Zj4dDULjmqYIQlcoTBwfI3jgE098YlpoTgK80h632soecMBSPCPOIE57e
   2Hz9/j4nREaDPoFEszSH1QADlpSUOk4jgv76MGRBxivfZD+JzYQxY1j+I
   hXxGKIdg7jhoVLcIHoWIJs6qWKm1mjjTQ2mm5EQlHLAnsMdHUKrczAHck
   3nkNFNxJolOBl5jGRevZvW8JuvkiSZ4EBx+Rt/BnivUEsvnKsaFdd4BbM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368407296"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="368407296"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119270"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119270"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 37/44] serial: sunsab: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:44 +0300
Message-Id: <20221019091151.6692-38-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/sunsab.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 99608b2a2b74..94db67f21abf 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -266,8 +266,7 @@ static void transmit_chars(struct uart_sunsab_port *up,
 	for (i = 0; i < up->port.fifosize; i++) {
 		writeb(xmit->buf[xmit->tail],
 		       &up->regs->w.xfifo[i]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
+		uart_xmit_advance(&up->port, 1);
 		if (uart_circ_empty(xmit))
 			break;
 	}
@@ -453,8 +452,7 @@ static void sunsab_start_tx(struct uart_port *port)
 	for (i = 0; i < up->port.fifosize; i++) {
 		writeb(xmit->buf[xmit->tail],
 		       &up->regs->w.xfifo[i]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
+		uart_xmit_advance(&up->port, 1);
 		if (uart_circ_empty(xmit))
 			break;
 	}
-- 
2.30.2

