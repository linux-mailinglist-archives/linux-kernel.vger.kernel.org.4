Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE76603FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiJSJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiJSJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:32:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93A5259;
        Wed, 19 Oct 2022 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170882; x=1697706882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A3W1Z/a/wfh0NlVQBaAxeGrChj8cXJSxLfJmuWqzBDU=;
  b=bjwbNUsCrxF50uzZmmq6NQeKeaJy1S8Xwc+rOGZ/+QP5EQSL2PX2aYdO
   asVEd974TXPfbQ5wSzQS3uXPwQnrHD/sanpUGF5wxn2NAwK7dytjQ95YX
   VFMBHE13tlQVOKcHOt9K/IquPJEff0G+cN53QsdhhYsTBG83BvbQltovf
   vRIGgFFR1F8QjXTqMPsMAyAjwoM6VSD0X3LuESK+uyC+xPUPfJIiuo8Ve
   QFa6+qOA2D7YrRdUEgJwCr8m+65vHEfBzkexiN0vhhgBB7Kk4PuhloIp3
   V8rOBVqPoijQPnBmgFuy3SwO3W2Gjqtsj4tAUocf8/xrYYQhL4RkKCXbl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911025"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911025"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118847"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118847"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:13:24 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 20/44] serial: max3100: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:27 +0300
Message-Id: <20221019091151.6692-21-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/max3100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index c69602f356fd..bb74f23251fe 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -292,9 +292,7 @@ static void max3100_work(struct work_struct *w)
 			} else if (!uart_circ_empty(xmit) &&
 				   !uart_tx_stopped(&s->port)) {
 				tx = xmit->buf[xmit->tail];
-				xmit->tail = (xmit->tail + 1) &
-					(UART_XMIT_SIZE - 1);
-				s->port.icount.tx++;
+				uart_xmit_advance(&s->port, 1);
 			}
 			if (tx != 0xffff) {
 				max3100_calc_parity(s, &tx);
-- 
2.30.2

