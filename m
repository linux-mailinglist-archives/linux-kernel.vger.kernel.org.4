Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF635B3310
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiIIJMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiIIJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:12:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5A138809;
        Fri,  9 Sep 2022 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662714768; x=1694250768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qXXOa+xXwqEYuH85kDTyeoK1yXiB/wu6uXJB6DqF/YE=;
  b=hnMQh6Eps0kHw2PK6KrgpM8s7R24U6FhstKMy+KBoEWmsipUQYjv3FFT
   bs/sROoJsrHVXK8LPdqe0mrm760fMs5QfH9UOrRxJb3PIypXwEjvo7Dnu
   TD7+aczMiKAeXM45s+1W/FV9CBovRKUGCZG0HWreHiMCIYl9VbKCjI4ER
   sYWBsvK6+i40KKEyILKHcbNOOIDOF1f5U+Gs6bP3a73RWIz7yUYxfBkEQ
   NhcTYGGRMONK0slgbxuNKzX9XF3FAyIUwNDJayT/XJKVXh2edwSNmfUR0
   3h2tT9Jw9pkTDUkFerxtxk9uoA/ipyRWmYFuAuYP52ixqMwdSpa1nfcHK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298772589"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="298772589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 02:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="757537743"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2022 02:12:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DAD0238; Fri,  9 Sep 2022 12:13:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_omap: Convert to use uart_xmit_advance()
Date:   Fri,  9 Sep 2022 12:12:58 +0300
Message-Id: <20220909091258.68886-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_xmit_advance() provides a common way on how to advance
the Tx queue. Use it for the sake of unification and robustness.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b43894e15b07..4f4d878dc2fc 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -984,9 +984,7 @@ static void omap_8250_dma_tx_complete(void *param)
 
 	dma->tx_running = 0;
 
-	xmit->tail += dma->tx_size;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-	p->port.icount.tx += dma->tx_size;
+	uart_xmit_advance(&p->port, dma->tx_size);
 
 	if (priv->delayed_restore) {
 		priv->delayed_restore = 0;
-- 
2.35.1

