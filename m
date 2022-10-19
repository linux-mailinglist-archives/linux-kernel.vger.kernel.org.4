Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465396040F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJSKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJSKbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:31:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C3AF88DC;
        Wed, 19 Oct 2022 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666174229; x=1697710229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p42rOfnZnHhgK9jNlKlAN4axRBz7sA1fIz/kLTAn/VI=;
  b=VBUn/5XIyfNLtCoq+zx2C3lT6FkFTIIMVqwVUK56DfMuIOkiEUCXyKUX
   62B4CHfGBK1MyDvlDHpmItWDdWM2949pZ5tqjM5B/Gw+MwSE6V0lXSL0i
   COtF7oa88OctW35Rn6M8iEnDcPOKnh55+zR1mi+NFatQfxqdHG+Me22kJ
   qlt0jlyp86pOcdX3K7484Cqwqp6BaRtcnJJvc02qRLR2dFdYfCINwvwKU
   F2/JjbKMn7PXYgIoi0oyIAVlzyng733GXr90CnAJ1suxA+BlSyJv6OyKN
   sGwjklfoUnqJI6CxDnmLkD9tAG/MhYESlZE8vPgtX4zz0veCGAD7n3sbN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368407318"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="368407318"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119300"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119300"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 39/44] serial: sunzilog: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:46 +0300
Message-Id: <20221019091151.6692-40-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 87425290687d..ccb809216e94 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -508,8 +508,7 @@ static void sunzilog_transmit_chars(struct uart_sunzilog_port *up,
 	ZSDELAY();
 	ZS_WSYNC(channel);
 
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	up->port.icount.tx++;
+	uart_xmit_advance(&up->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&up->port);
@@ -709,8 +708,7 @@ static void sunzilog_start_tx(struct uart_port *port)
 		ZSDELAY();
 		ZS_WSYNC(channel);
 
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 			uart_write_wakeup(&up->port);
-- 
2.30.2

