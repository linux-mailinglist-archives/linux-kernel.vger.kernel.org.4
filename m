Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41996604301
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiJSLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiJSLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:13:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800301849A0;
        Wed, 19 Oct 2022 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666176077; x=1697712077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AaVgzWGPVmfu4N/bcNYFUky+Hw6vtDYUDcFc/orZuk=;
  b=RjxB5fZPXqY6VJTy8/QT2MtTiy9iqY5zlxEd+6bpGwt3YTewUIHV/MTY
   xlVy1MWAfY6nln06ES9Wb5kv7l19ASkoXQnB/28Ub2oCUqqmBD5oHuciC
   q7qTXsJ1Y1HxeuEwHKxeW3PT7GS0P79yWwgscwv7RyE9tReoCdp8ugUd4
   aZAqfXcmkOEFvDXyo5Mx4PR+YKMCtjohy/7PBjBDRCBWQ0yw4ipqgJ1d2
   8dBKU4H8phm7CpEAJnnpZ/1nrjKtC5FCNScOUtqOjZ7q8/pWRxzmEv9Y4
   YUIQOV/wcG1eQpv5PxWY0E41joIqqK/pkCseyIuJR7WhtQj5NzADj63hq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370573991"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="370573991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119431"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119431"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 44/44] serial: zs: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:51 +0300
Message-Id: <20221019091151.6692-45-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/zs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 688db7d8b748..730c648e32ff 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -623,8 +623,7 @@ static void zs_raw_transmit_chars(struct zs_port *zport)
 
 	/* Send char.  */
 	write_zsdata(zport, xmit->buf[xmit->tail]);
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	zport->port.icount.tx++;
+	uart_xmit_advance(&zport->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&zport->port);
-- 
2.30.2

