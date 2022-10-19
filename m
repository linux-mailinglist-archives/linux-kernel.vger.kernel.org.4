Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DC603FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiJSJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiJSJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:34:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B344CE4;
        Wed, 19 Oct 2022 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170912; x=1697706912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQJoRuNRdeIpnDk2ac87eJh17oqgdcNVue8yLDhtyxs=;
  b=NXU1U4yJd3rTUR9GE3weNUpfEhpPcLCST84mO4QLdlUt4JvbHQQ0gpz0
   2rQ0gPU/kQN9XYJy0kbYB5GPaHOXidIPiUum1kW/sGxFnpFEsoFkB6V7b
   Rzq2vaoja1cKILnV1zsF68XT7woM0KYZilKj2NUl2F0ZjkVJItFWPRpiI
   uNETJSmkxFynVTHYBCkASzUNRsOd/hA5w8K0jWjyTcXZuAYDmeht5LYs6
   g2a9rwpTpynxIdDiXdA/4uycBkf1Yh45yMWHnA+SHEJZLrxRW7MJDI3hM
   PdMfbHBRJgeEzI5q98rZvQkCAx3ffekJ93Tuu1uMfeHPe2lzvtb/k+qz6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911284"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911284"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119215"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119215"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 34/44] serial: stm32: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:41 +0300
Message-Id: <20221019091151.6692-35-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/stm32-usart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index dfdbcf092fac..24def72b2565 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -596,8 +596,7 @@ static void stm32_usart_transmit_chars_pio(struct uart_port *port)
 		if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
 			break;
 		writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
+		uart_xmit_advance(port, 1);
 	}
 
 	/* rely on TXE irq (mask or unmask) for sending remaining data */
@@ -673,8 +672,8 @@ static void stm32_usart_transmit_chars_dma(struct uart_port *port)
 
 	stm32_usart_set_bits(port, ofs->cr3, USART_CR3_DMAT);
 
-	xmit->tail = (xmit->tail + count) & (UART_XMIT_SIZE - 1);
-	port->icount.tx += count;
+	uart_xmit_advance(port, count);
+
 	return;
 
 fallback_err:
-- 
2.30.2

