Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B974F603FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiJSJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiJSJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:34:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938363DF1C;
        Wed, 19 Oct 2022 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170907; x=1697706907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TCKozR5BIs68DvWZSZOm+IJxNijydgnxhkgkhHpUBtI=;
  b=jcKLl2OFRlRvgVwK8Pc+H+sxcJ/Wc64aw/PtIjN3KsIHevWtL62bpzO5
   7hzgrtFgRXasUB4oYIuecke8znM0lNzLiLMO0lA7C5N4IqnGvdw11GvwH
   bhho9EyB/A2WbUxEgFpRLzJQuU/MKR6borzTTBkbuBnLyA1YuAcCWe703
   OtkHMtEXPmkk+SOq0WmAUzrACUflly4S8jCBzyn2uSMnrH8Sli5JX7hH6
   c6NsdmCzr1x3grKBCBl8IiVNfS+8BzgLY1awZOztWr4XXKMYIEFe/8efY
   W+TYLEzjg/sNOlWVOPkrNzb2dBQSboyVmp5sXc8AmOErmbnbKf8mQE//Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911267"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911267"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119177"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119177"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 32/44] serial: sh-sci: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:39 +0300
Message-Id: <20221019091151.6692-33-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/sh-sci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62f773286d44..a92a89780357 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1181,10 +1181,7 @@ static void sci_dma_tx_complete(void *arg)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	xmit->tail += s->tx_dma_len;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-
-	port->icount.tx += s->tx_dma_len;
+	uart_xmit_advance(port, s->tx_dma_len);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-- 
2.30.2

