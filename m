Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022A165EAF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjAEMsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjAEMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:48:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E14C72E;
        Thu,  5 Jan 2023 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672922885; x=1704458885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gBllpDNVCKeKdbc9yaBSuxUO7hrUZrjNNGgoCldFUrw=;
  b=l9P96e6gF93vZvgD5HcKqA0WXMAMQEW6IgGikPfTlkMKas4V8DtppbgN
   RAW3D+QuRWLuZ32SB059n3l53+norS5I4KKzhgS5mDts77JFre0xRm+2X
   bBxW5SKPfX+KTGOJ3rhO9qiC6IC7RccJ68qhA9oN/ifYxQR74kzy8jwWK
   VHR1+mAtPpZoNjy4ENqIlpHPFSD6Ob7ByTqYS+7RCMfg0WWWBoGtTFSor
   5e8g5zhKRIAXimXPeMgXKZ5SD5gJSTRSCxuFguR+0CkcMNkW9lcn2k6jq
   u/SRKxiF6LAQGoNSKnKZnspOr/7Vo2gqS1477Jbm1cNNtRJUDTU+Cf4Ye
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301889842"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301889842"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:48:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984287804"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="984287804"
Received: from khaunx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.35.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:48:03 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/3] serial: 8250_rt288x: Remove unnecessary UART_REG_UNMAPPED
Date:   Thu,  5 Jan 2023 14:47:44 +0200
Message-Id: <20230105124744.105950-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105124744.105950-1-ilpo.jarvinen@linux.intel.com>
References: <20230105124744.105950-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As unmapped registers are at the tail of the array, the ARRAY_SIZE()
condition will catch them just fine. No need to define special
value for them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_rt288x.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index 3015afb99722..7399fea6dfc1 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -14,10 +14,8 @@
 
 #define RT288X_DL	0x28
 
-#define UART_REG_UNMAPPED	-1
-
 /* Au1x00/RT288x UART hardware has a weird register layout */
-static const s8 au_io_in_map[8] = {
+static const s8 au_io_in_map[7] = {
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
+static const s8 au_io_out_map[5] = {
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

