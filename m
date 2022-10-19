Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D396604302
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJSLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJSLNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:13:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925B1849BF;
        Wed, 19 Oct 2022 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666176074; x=1697712074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2fcH1RckItYB1DaGqrWXRre2uW8qfw9sV3lZLqMJ7X8=;
  b=G2691YPDasMFCMSvlZSpdjJ/xrwYnFcNF0uZydlaYeO1SSiIp0CGOdD2
   ElrETi/VnJiJHh6cvncLdcuIGlITtNe9K8EjJUDXKa3qfbNIey8chZMfq
   Z4XRXOdmb0zlfGR3aYwzH9ZtY2wejwTMLlxEPIRszxSH/rMXbdnrCYNDv
   MJZTEhY6mJjB9kIgLTVIETAfvyoizGk6dRtZ2G6xdkdu81Q3pTOx8c8gB
   MFqssdO1Sh48wJaSXdGl/sWXLECQ8kTn0wfDbAGcs8aMh2avSCThr375C
   lO/RS+rAM004maMn/JLhTGlFAGPFJINXHr2ADQ+EtAOpYrh73+C19jIMl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370573944"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="370573944"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119331"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119331"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 41/44] serial: uartlite: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:48 +0300
Message-Id: <20221019091151.6692-42-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/uartlite.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index eca41ac5477c..94584e54ebbe 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -203,8 +203,7 @@ static int ulite_transmit(struct uart_port *port, int stat)
 		return 0;
 
 	uart_out32(xmit->buf[xmit->tail], ULITE_TX, port);
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
-	port->icount.tx++;
+	uart_xmit_advance(port, 1);
 
 	/* wake up */
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
2.30.2

