Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C266603FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJSJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiJSJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:31:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416133A0D;
        Wed, 19 Oct 2022 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170874; x=1697706874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LfL2WHC8lVbuBm2BucTh8bRu07F0VUCsL+ehIqnzvLQ=;
  b=C1T4Uh848/LNXZCBVMsJ68TyzjgPsMnXDyQjI0quNQj27Ovgl2BmWclx
   g/sbaiC95w+fGCJ5KGrUFZgFslvQE2vZD5aacuKe77GuyzGi+LTCpm0ew
   9kScLtqg4zN0RhuD6C8Ey9aDS204swe3pH7SvJbxeFZqtZY+1ExTzpiYu
   1uyYKV8nsnYZ2X+Kg/mdO//jSCCn9XX+Y4LIX0Gfxxlmxz8Qlhb6ZF3F5
   WgUA6+fjlZRLPIkugFjxkEmKsmwqbrr6kPjF7D8xP0l91eIIWI79b+Qgw
   xUZOh2zg13KlxbYVLiAwQY+Po641iqr/modAc2D5NSI/z/Xo/MYWXOcBh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910983"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118794"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118794"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 17/44] serial: imx: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:24 +0300
Message-Id: <20221019091151.6692-18-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/imx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 05b432dc7a85..a7548d0a1aee 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -563,8 +563,7 @@ static inline void imx_uart_transmit_buffer(struct imx_port *sport)
 		/* send xmit->buf[xmit->tail]
 		 * out the port here */
 		imx_uart_writel(sport, xmit->buf[xmit->tail], URTX0);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
+		uart_xmit_advance(&sport->port, 1);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -590,9 +589,7 @@ static void imx_uart_dma_tx_callback(void *data)
 	ucr1 &= ~UCR1_TXDMAEN;
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	/* update the stat */
-	xmit->tail = (xmit->tail + sport->tx_bytes) & (UART_XMIT_SIZE - 1);
-	sport->port.icount.tx += sport->tx_bytes;
+	uart_xmit_advance(&sport->port, sport->tx_bytes);
 
 	dev_dbg(sport->port.dev, "we finish the TX DMA.\n");
 
-- 
2.30.2

