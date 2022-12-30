Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFAD6597DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiL3Lqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiL3LqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:46:25 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545B101CD;
        Fri, 30 Dec 2022 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672400784; x=1703936784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qkr8VlMp1FCP45ObtIhRsGdRw0bmPjZ8QjRvKFCk7e0=;
  b=Xa0KgrGSugxiXwQtstjFsb5OoS/9NgbTCxE2pO/M/JXKjMuOD8ERG1dL
   +mBc2LKFcppO7F597APoMdkgpk0R7DHiEaZOuk35MCU00/SH/UK+MKbsS
   xZTVGxHp+89T5EDBUUfkwO1GqxE5XB7inaKY5Iqu2hn/AV9vlsLY1Sp4W
   1Z3b6eWNoxoLQFRRufkAYIlxb79GrAajqj9I3QtMJ1iQfrxmg7in3x1q9
   1XMsiZkk7ZdA3gfgoBLk79wJD18bHRmZRzzidnn3MkbjDVktbAYWVzUze
   t1rvduEIP1/G4Milv0SEoqsrwLGMGyrroaTHTFw4RZTyZ9ssp0awrXnTw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="301568014"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="301568014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="653865361"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="653865361"
Received: from vsemouch-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.102])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 03:46:21 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     inux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED
Date:   Fri, 30 Dec 2022 13:46:03 +0200
Message-Id: <20221230114603.16946-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
References: <20221230114603.16946-1-ilpo.jarvinen@linux.intel.com>
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

As unmapped registers are at the tail of the array, the ARRAY_SIZE()
condition will catch them just fine. No need to define special
value for them.

Also, let the compiler to calculate the size of the array instead of
providing it manually.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_rt288x.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index 3015afb99722..da8be9a802c1 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -14,10 +14,8 @@
 
 #define RT288X_DL	0x28
 
-#define UART_REG_UNMAPPED	-1
-
 /* Au1x00/RT288x UART hardware has a weird register layout */
-static const s8 au_io_in_map[8] = {
+static const s8 au_io_in_map[] = {
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
+static const s8 au_io_out_map[] = {
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

