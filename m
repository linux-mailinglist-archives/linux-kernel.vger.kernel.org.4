Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578461F177
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKGLHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiKGLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:07:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316AA18386;
        Mon,  7 Nov 2022 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667819246; x=1699355246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtD5WjXlvt+YGgcDoYJMysEl6WyGK5Ld+p1WXJ0fxvY=;
  b=n28fkNWLHfIASasA6zjuz0HHBIObVZ3prF4BeJY27HUS16Jl5gXbKbeW
   G/sn44dMeIPapAxm/pxzVB3aUgiUkywnrj3VzMjPo+lckKfvb+hh0LzM3
   xakZdCJad2TZQ/vV1LD0URjhAwO/SeVn7GqVXyx9yw04dS3bQTQC9d+j1
   UFIDxhzPbAVPIJSbO5U7HSpbePdJGrBdTqquedKMK9lTL3NXw+KbLK0Gm
   8YCbD3CAKpmEv9qZcQJVx5DrRXujjF/SHwVQ/bVfrfRITkJsuqTkyP8Wn
   BpIqCNghusdhthPp9jkRxMXlBIxeRmmj06ca5mgPGwZx7hMZGZZZD7QIY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290773022"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290773022"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:07:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="586932344"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="586932344"
Received: from gschoede-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.46.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:07:23 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     stable <stable@kernel.org>
Subject: [PATCH 2/4] serial: 8250_lpss: Configure DMA also w/o DMA filter
Date:   Mon,  7 Nov 2022 13:07:06 +0200
Message-Id: <20221107110708.58223-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
References: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the platform doesn't use DMA device filter (as is the case with
Elkhart Lake), whole lpss8250_dma_setup() setup is skipped. This
results in skipping also *_maxburst setup which is undesirable.
Refactor lpss8250_dma_setup() to configure DMA even if filter is not
setup.

Cc: stable <stable@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 44cc755b1a29..ed281445a97d 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -277,8 +277,10 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 	struct dw_dma_slave *rx_param, *tx_param;
 	struct device *dev = port->port.dev;
 
-	if (!lpss->dma_param.dma_dev)
-		return 0;
+	if (!lpss->dma_param.dma_dev) {
+		dma = port->dma;
+		goto confonly;
+	}
 
 	rx_param = devm_kzalloc(dev, sizeof(*rx_param), GFP_KERNEL);
 	if (!rx_param)
@@ -289,16 +291,20 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 		return -ENOMEM;
 
 	*rx_param = lpss->dma_param;
-	dma->rxconf.src_maxburst = lpss->dma_maxburst;
-
 	*tx_param = lpss->dma_param;
-	dma->txconf.dst_maxburst = lpss->dma_maxburst;
 
 	dma->fn = lpss8250_dma_filter;
 	dma->rx_param = rx_param;
 	dma->tx_param = tx_param;
 
 	port->dma = dma;
+
+confonly:
+	if (dma) {
+		dma->rxconf.src_maxburst = lpss->dma_maxburst;
+		dma->txconf.dst_maxburst = lpss->dma_maxburst;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

