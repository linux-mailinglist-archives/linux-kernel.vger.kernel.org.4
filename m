Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85058603FED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiJSJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiJSJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:31:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758EDE098;
        Wed, 19 Oct 2022 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170880; x=1697706880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=boa0UFxdlZFq3YZjregu92/OfkuX7qn3ZD0BhYS89oI=;
  b=cdriaEoSvH3E4d8z6orgBeB5s9woJHnGoabGOxoWjv/+90WkZOVIHmd7
   dRIEN09PLcVUvNN7vT4SPWiJ9SIL8oCEGEwkmlwxrNxYMZesvbwd+vUK9
   KWfgltg0ulWCubQwcyoriSyY9EhHKGgbIkQ/cOkiMkiYc8peJrUe2kVLm
   aOUwgwqJFExvnmEt/OV4gX7zqXHVHcqiSwmwuGhocZ/+QQVeeZb3rJ7au
   o2l3dtBAuss+nw0WDtKU5lhP5yPzmdrCgxJt3ykbJIGxJOXVtfFTpM0zz
   +iS+rta/BRkeZipcdFedAPVRyfAXAqaPVS9Q6vOfVLu4pFynRSsm8xtft
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911005"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911005"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118830"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118830"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/44] serial: liteuart: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:26 +0300
Message-Id: <20221019091151.6692-20-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 4c0604325ee9..062812fe1b09 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -136,8 +136,7 @@ static void liteuart_start_tx(struct uart_port *port)
 	} else if (!uart_circ_empty(xmit)) {
 		while (xmit->head != xmit->tail) {
 			ch = xmit->buf[xmit->tail];
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-			port->icount.tx++;
+			uart_xmit_advance(port, 1);
 			liteuart_putchar(port, ch);
 		}
 	}
-- 
2.30.2

