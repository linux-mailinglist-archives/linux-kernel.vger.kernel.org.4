Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4F604004
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiJSJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiJSJdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:33:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861711CFDA;
        Wed, 19 Oct 2022 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170890; x=1697706890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SnEG++lmkrZFM5w3ZM3z5ZQmAONQeCxSy4cYq4nyY8=;
  b=nksXm7A0T00mcQlfL2JHJplwSadkfPmz3sjQM7jvi3x0lo3wwBL1muEP
   ZofP6Ucew1S+pvAtrPbR5UAJGcrsz+wp3rOtwT20T3yFtmyeaFFQmaQQl
   jcIdWsYHT16GnIEQszatBMdOL3tpDoBVXde9tSKszaRZNFXGUB/Ahjlem
   Uy8tWBKvwfMbzjTTpb1oUjUSEYCVZXapsoxtwsynPyAAUYnWkE94kOBUK
   tTqUcVFzlouC/ah+72vAIVimxNW65Q9gkvdEGNLEE/XY3xopxV97zgz9x
   Cho84nnW/bcbV9FLDWvBuAK0GE/njbdTJTA33b4y4dH42wbGUOyNmC2DB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911187"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911187"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119003"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119003"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:45 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 26/44] serial: pmac_zilog: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:33 +0300
Message-Id: <20221019091151.6692-27-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/pmac_zilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index fe2e4ec423f7..13668ffdb1e7 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -410,8 +410,7 @@ static void pmz_transmit_chars(struct uart_pmac_port *uap)
 	write_zsdata(uap, xmit->buf[xmit->tail]);
 	zssync(uap);
 
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	uap->port.icount.tx++;
+	uart_xmit_advance(&uap->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
@@ -627,8 +626,7 @@ static void pmz_start_tx(struct uart_port *port)
 			return;
 		write_zsdata(uap, xmit->buf[xmit->tail]);
 		zssync(uap);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 			uart_write_wakeup(&uap->port);
-- 
2.30.2

