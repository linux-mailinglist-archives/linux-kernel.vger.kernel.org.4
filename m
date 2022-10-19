Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF7C604300
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiJSLQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiJSLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:13:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A91849A4;
        Wed, 19 Oct 2022 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666176077; x=1697712077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vdv0VnfyYwVYEDCfG1dVBcwwKynwA8leh0TjEqYcP/I=;
  b=MDQuY+5Z0026YJUDu9smcGPNJONUIpXoDbbqztdsU9ZEamHJlnIXEH6B
   8BrD6ETUNlGq1P1hGbTIbYhZyQyLSB7CuLqZhyrvdYc4EdYTsVj+5yUNu
   1EhZiZmwtj32QW+aZxwdtpgU1yLV9wdT0Jm30yJJYGjU0KidxCiar+OX8
   VME3vmx97W06HsUaHUbcebJCL7j8Cfg7K0jU7DmUkwxPz2Rgo24uFaLiF
   KJ33NB2cLjWQebV3pyopDUvGnQVeUgbT26XHPTEAsX/qB7mwOuOlTTz8Z
   2U5iQGc6NrZh5ISp2CXlI/1PQAqYXXuLWWFoBhxXmmnqUuf7OakTkDsvb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370573974"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="370573974"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119391"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119391"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 43/44] serial: xuartps: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:50 +0300
Message-Id: <20221019091151.6692-44-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/xilinx_uartps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2eff7cff57c4..01d8027e64fd 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -326,9 +326,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
 
 		writel(xmit->buf[xmit->tail], port->membase + CDNS_UART_FIFO);
-
-		port->icount.tx++;
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		uart_xmit_advance(port, 1);
 		numbytes--;
 	}
 
-- 
2.30.2

