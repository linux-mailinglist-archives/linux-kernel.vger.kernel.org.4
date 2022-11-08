Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA2621044
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiKHMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiKHMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:20:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14413EBE;
        Tue,  8 Nov 2022 04:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667910015; x=1699446015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLWjR1QhfIzzz63zvvQ1hW3NXrVYq+1ORm+qFn4evPQ=;
  b=H+fztD5nJTicnbF1On56Tq8LoLYsdaCJGuhmoaVE3IFKNPOKl96xp6PH
   rqll8cGfJGG5xHGm6PQOCxEFo2e3+x2uVnQHR6rlMHcAHfuyyIdy/hVfd
   ESFNYyowpIjbxNDPqbpVu6l0nrKmxq8acMZBbvt9+XnKrwVn+DEo8pD+k
   CBOHujmuxVPGgqM6X7IGQOVYAEY/F6ydyNt83SawBh9M3CJlZF6gG4J+3
   cJ73Rm48QTUBTOAPgC5l6i5iOTyPqyHMXan7H8SUeE+kFXuZt1iZGMoSr
   15rs1LOeYIc+0HMD8MApSH3R7klwQIzmlvnVt9KzJo66wqalsQrw1qbht
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311834679"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="311834679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:20:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741932198"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="741932198"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:20:12 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Gilles BULOZ <gilles.buloz@kontron.com>, stable <stable@kernel.org>
Subject: [PATCH v2 2/4] serial: 8250_lpss: Configure DMA also w/o DMA filter
Date:   Tue,  8 Nov 2022 14:19:50 +0200
Message-Id: <20221108121952.5497-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108121952.5497-1-ilpo.jarvinen@linux.intel.com>
References: <20221108121952.5497-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/tty/serial/8250/8250_lpss.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 44cc755b1a29..7d9cddbfef40 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -277,8 +277,13 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 	struct dw_dma_slave *rx_param, *tx_param;
 	struct device *dev = port->port.dev;
 
-	if (!lpss->dma_param.dma_dev)
+	if (!lpss->dma_param.dma_dev) {
+		dma = port->dma;
+		if (dma)
+			goto out_configuration_only;
+
 		return 0;
+	}
 
 	rx_param = devm_kzalloc(dev, sizeof(*rx_param), GFP_KERNEL);
 	if (!rx_param)
@@ -289,16 +294,18 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
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
+out_configuration_only:
+	dma->rxconf.src_maxburst = lpss->dma_maxburst;
+	dma->txconf.dst_maxburst = lpss->dma_maxburst;
+
 	return 0;
 }
 
-- 
2.30.2

