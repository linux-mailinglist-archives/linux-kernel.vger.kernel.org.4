Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002146FF13F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjEKMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbjEKMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:12:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2243AD33;
        Thu, 11 May 2023 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683807125; x=1715343125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6LAY9JWX/aRhNzybSamq3VVrNZJvYyTc9TrazjZTyNY=;
  b=lvsOK4SbDlia5GEcpanpi11wth8keW+KeFbuOcVwYU+3uVb4glxp6G3u
   XhM8j3Bu+kNODyYb2psNU5WeNaCC70PT86vpsZv22zIhLluORklj0gCjr
   EI3tHKj++SMSSWWfAZbRi6b9CTTfpFgyzQ4drqQzoM5eVMTtUWEy/ORZx
   5f7Ae/oD4qQyIYI2POzosoMzbnk8kcsN8DQ4J2p6hBf8LWEPXfrly904k
   lU/IHHBMtZWbio5b7gD3RwgZ/aHG/g0JiBsk8x9arhmY6CNpaDg6PZsky
   c01b8KDvqCiRW94yFY9vHFM64JPP2MCVgcWqExalN87UH5ps9Zm/vN6Fa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330839428"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="330839428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="843921377"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="843921377"
Received: from jsanche3-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 05:11:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 6/6] serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED
Date:   Thu, 11 May 2023 15:10:29 +0300
Message-Id: <20230511121029.13128-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
References: <20230511121029.13128-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

