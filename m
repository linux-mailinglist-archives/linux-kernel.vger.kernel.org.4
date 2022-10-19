Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E16603FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiJSJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiJSJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:32:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81FA2675;
        Wed, 19 Oct 2022 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170863; x=1697706863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLDHMA32ywtkYZgvk228BKSnKFFrTIViAEXtm5kls74=;
  b=EzgS+/qZfY5VRQNwKtJfmvYmzVaOyMSkGpEthEP9cZFsYjB43mzsvI/E
   +XzaQ1+iYxwGmdxGAFF90Ierem/FYBDfpVMITajsjlf4+DRIqRXuBZd7a
   +8fLK23osM6MBklod1tTZA9vDVW/LwZprmAXPDfMQf9eXKNDS6rstEG6O
   LYkSZte2AuT0kNS+1qHEk7Cy0wfi5h0FRfMiT1ZvmpcXa4uc9CQ/WY5kt
   Dn3zB3BG81h/7I1tyYptFCNAzNcvseC2sB0rF2fx+6XZF3/C//Uabxssv
   xiixRakoUvqypLitjX/KfPYs4Sbxy/Ki6CuNGzEow5qbQSoK0B5ktbJ2j
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910947"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118762"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118762"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:07 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 15/44] serial: linflexuart: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:22 +0300
Message-Id: <20221019091151.6692-16-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/fsl_linflexuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 84e8153e5420..6fc21b6684e6 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -178,8 +178,7 @@ static inline void linflex_transmit_buffer(struct uart_port *sport)
 
 	while (!uart_circ_empty(xmit)) {
 		linflex_put_char(sport, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->icount.tx++;
+		uart_xmit_advance(sport, 1);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
2.30.2

