Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948C6FC52E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjEILkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjEILkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:40:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09772AA;
        Tue,  9 May 2023 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683632395; x=1715168395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6LAY9JWX/aRhNzybSamq3VVrNZJvYyTc9TrazjZTyNY=;
  b=kNbEI2r37ckPaLBIh3py4wM92U4/tpBU8rrZUpE71OK/qew8DQbTZSl6
   cXBJVLt6LNRG0Kt6XfyCKUDKgUvKTZqu/Vu+OsFCuG6ibSkSoryeQm6YR
   bbVnRGTMnQl1mqPCf4tIjBykXIDOLVW4vx/CN0/v1HfLtSp3L4cBh1GGI
   2D2PzxXOt+OQypX7IR9mS+JGR/iaiMP763S9crb3/Mv8K1w50bEDyIL4o
   rpNtK3Hqisp3JlLVDbf+/Gt/SoObDxXA7YIk8AmTjhvfKt7ANg87i4XO/
   M6Wr97cMgmmjWilLlpSAh+Foy9FKNd6MbIFCkVr10r1wK9s54PeMAhugV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347362101"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347362101"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763805957"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="763805957"
Received: from mbrdon-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.219.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 6/6] serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED
Date:   Tue,  9 May 2023 14:39:24 +0300
Message-Id: <20230509113924.19540-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
References: <20230509113924.19540-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As unmapped registers are at the tail of the array, the ARRAY_SIZE()
condition will catch them just fine. No need to define special
value for them.

Convert the arrays to u8 as all entiries are now positive.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_rt288x.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index b091a1269bfa..6415ca8d3adf 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -14,10 +14,8 @@
 
 #define RT288X_DL	0x28
 
-#define UART_REG_UNMAPPED	-1
-
 /* Au1x00/RT288x UART hardware has a weird register layout */
-static const s8 au_io_in_map[8] = {
+static const u8 au_io_in_map[7] = {
 	[UART_RX]	= 0,
 	[UART_IER]	= 2,
 	[UART_IIR]	= 3,
@@ -25,18 +23,14 @@ static const s8 au_io_in_map[8] = {
 	[UART_MCR]	= 6,
 	[UART_LSR]	= 7,
 	[UART_MSR]	= 8,
-	[UART_SCR]	= UART_REG_UNMAPPED,
 };
 
-static const s8 au_io_out_map[8] = {
+static const u8 au_io_out_map[5] = {
 	[UART_TX]	= 1,
 	[UART_IER]	= 2,
 	[UART_FCR]	= 4,
 	[UART_LCR]	= 5,
 	[UART_MCR]	= 6,
-	[UART_LSR]	= UART_REG_UNMAPPED,
-	[UART_MSR]	= UART_REG_UNMAPPED,
-	[UART_SCR]	= UART_REG_UNMAPPED,
 };
 
 static unsigned int au_serial_in(struct uart_port *p, int offset)
@@ -44,8 +38,7 @@ static unsigned int au_serial_in(struct uart_port *p, int offset)
 	if (offset >= ARRAY_SIZE(au_io_in_map))
 		return UINT_MAX;
 	offset = au_io_in_map[offset];
-	if (offset == UART_REG_UNMAPPED)
-		return UINT_MAX;
+
 	return __raw_readl(p->membase + (offset << p->regshift));
 }
 
@@ -54,8 +47,7 @@ static void au_serial_out(struct uart_port *p, int offset, int value)
 	if (offset >= ARRAY_SIZE(au_io_out_map))
 		return;
 	offset = au_io_out_map[offset];
-	if (offset == UART_REG_UNMAPPED)
-		return;
+
 	__raw_writel(value, p->membase + (offset << p->regshift));
 }
 
-- 
2.30.2

