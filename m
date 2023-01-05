Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66EA65EAF7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjAEMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjAEMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:48:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3558F4C713;
        Thu,  5 Jan 2023 04:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672922882; x=1704458882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+pRn7tKtyQDsfv1krVYAXZzmvcjDEgr9X9ccC6JVXzQ=;
  b=gqHIEoFRLLtb4C0Kp/n6LkpWJCwcKLZETDVgcVekzXBQCbGFX9x6tcZF
   yMIkVGmgmGW76+dPoB4aXHOJmNDI+ytf7ymQHz9bK+ezVEUuUGqc3iLAv
   E4vdetykF8Aq3HmA/1utJYmNs1lyjpftLumWiE20/5FeVeofSr/SkzAly
   q2bMLYGOdduRQ9mHF4OmCubrSVOjBnc3aNrVIl03bp9ktsojONoLQa2Eg
   61V09aSl1DRmEX9sibmEKdTb11EK3Y8FEo66zVIwO1LRE6Q5ZkFearbd6
   Qjh6ZTGKE30WUDaXVg5ixLQaYHVyVhAFuwanASYpQs1ZWHIIy8zUKQZUm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301889830"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301889830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:48:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="984287791"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="984287791"
Received: from khaunx-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.35.181])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 04:48:00 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/3] serial: 8250_rt288x: Name non-standard divisor latch reg
Date:   Thu,  5 Jan 2023 14:47:43 +0200
Message-Id: <20230105124744.105950-3-ilpo.jarvinen@linux.intel.com>
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

Instead of a literal, add proper name for the non-standard divisor
latch register.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_rt288x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rt288x.c b/drivers/tty/serial/8250/8250_rt288x.c
index cb9a86bd3a07..3015afb99722 100644
--- a/drivers/tty/serial/8250/8250_rt288x.c
+++ b/drivers/tty/serial/8250/8250_rt288x.c
@@ -12,6 +12,8 @@
 
 #include "8250.h"
 
+#define RT288X_DL	0x28
+
 #define UART_REG_UNMAPPED	-1
 
 /* Au1x00/RT288x UART hardware has a weird register layout */
@@ -60,12 +62,12 @@ static void au_serial_out(struct uart_port *p, int offset, int value)
 /* Au1x00 haven't got a standard divisor latch */
 static int au_serial_dl_read(struct uart_8250_port *up)
 {
-	return __raw_readl(up->port.membase + 0x28);
+	return __raw_readl(up->port.membase + RT288X_DL);
 }
 
 static void au_serial_dl_write(struct uart_8250_port *up, int value)
 {
-	__raw_writel(value, up->port.membase + 0x28);
+	__raw_writel(value, up->port.membase + RT288X_DL);
 }
 
 int au_platform_setup(struct plat_serial8250_port *p)
-- 
2.30.2

