Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECE6FC526
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjEILjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjEILjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:39:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC930F5;
        Tue,  9 May 2023 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683632382; x=1715168382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgSo5iUE5tQb+4UxGhuvzVjJhZnju7Zh1OoucPsBSwE=;
  b=Y67raeDrpcyhp8udNx7m1FT5aq4f1oWZFoO/RcMDHSlWxmHy/5KpndK/
   nEu1vOT0B2lagSWUZY52QyMpnx0MrQ1QHLSI8EHq7qc6XePPJpg3dOG1d
   T8cKsJOFYzDC2Bhnwg2xxiBnUW9j4tauziWDQhtknKoavu6NdnU+8L+lA
   anc/mhWFH17oHYbD/wmqx9qZ1t/ELgZE+sF1xvLTlJ/n5TakH5rYnmk2g
   0n/h1nHLlkV+L+1+PoT7vhIIjlV4SgNaOx/pqBZBmtP1AEE5UDndK18DF
   pNBuNIv0RqDNDw6IsTDl5qCD7yhRNk0O3C6K9+AedxNxbXS4a/yotGV1g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347362072"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347362072"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="763805936"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="763805936"
Received: from mbrdon-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.219.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 04:39:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/6] serial: 8250: Document uart_8250_port's ->dl_read/write()
Date:   Tue,  9 May 2023 14:39:20 +0300
Message-Id: <20230509113924.19540-3-ilpo.jarvinen@linux.intel.com>
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

Add documentation for the struct uart_8250_port divisor latch function
pointers. Documentation is in kernel doc format but don't enable kernel
doc yet as many other fields remain undocumented.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/serial_8250.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 7b5d558e4e0c..d64e7bbe1f2f 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -90,8 +90,17 @@ struct uart_8250_em485 {
  * their own 8250 ports without registering their own
  * platform device.  Using these will make your driver
  * dependent on the 8250 driver.
+ *
+ * @dl_read: ``u32 ()(struct uart_8250_port *port)``
+ *
+ *	UART divisor latch read.
+ *
+ * @dl_write: ``void ()(struct uart_8250_port *port, u32 value)``
+ *
+ *	Write @value into UART divisor latch.
+ *
+ *	Locking: Caller holds port's lock.
  */
-
 struct uart_8250_port {
 	struct uart_port	port;
 	struct timer_list	timer;		/* "no irq" timer */
-- 
2.30.2

