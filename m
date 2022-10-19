Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BFA603FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiJSJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiJSJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:29:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FEC1DB2;
        Wed, 19 Oct 2022 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170793; x=1697706793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICgkWh4UzIvOwjy10LsjhlqTKeelCAII67CPIN6cvH8=;
  b=GPbJIaIVnaqL8qtpub4X6agLDY/55drV56/iiNxWwZObH/qVHy+a3aFc
   SsAcDnBDwLkPypKMWONyRLGqjZU5vYX2jVAsEfQhU1ZAlGUOtus0lXntV
   n+Gq95mqrKExAGjrFVa/M2u3O11CRo80LePqzDikha8bbJLbfBUjx9mj3
   /lOUmbLobADHszWsnumiyXfXZO9OKc+Tgi57DXUzzrvSRV13kisoqgtWk
   CBXasuYzfrdu3osfELnXv86/Eg/ngmTE7To3umnLiizsWSdONoj1/X6v5
   k0xA+9U32Zn6eMP4RAqJuSrGY414V+2SV0YVr7SxkdnOc9vUqodLHhr+R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910807"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118473"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118473"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/44] serial: msm: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:10 +0300
Message-Id: <20221019091151.6692-4-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/msm_serial.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7dd19a281579..2b2e0f74b75a 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -464,12 +464,9 @@ static void msm_complete_tx_dma(void *args)
 	}
 
 	count = dma->count - state.residue;
-	port->icount.tx += count;
+	uart_xmit_advance(port, count);
 	dma->count = 0;
 
-	xmit->tail += count;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-
 	/* Restore "Tx FIFO below watermark" interrupt */
 	msm_port->imr |= MSM_UART_IMR_TXLEV;
 	msm_write(port, msm_port->imr, MSM_UART_IMR);
@@ -866,13 +863,11 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
 		else
 			num_chars = 1;
 
-		for (i = 0; i < num_chars; i++) {
+		for (i = 0; i < num_chars; i++)
 			buf[i] = xmit->buf[xmit->tail + i];
-			port->icount.tx++;
-		}
 
 		iowrite32_rep(tf, buf, 1);
-		xmit->tail = (xmit->tail + num_chars) & (UART_XMIT_SIZE - 1);
+		uart_xmit_advance(port, num_chars);
 		tf_pointer += num_chars;
 	}
 
-- 
2.30.2

