Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8D6C13FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCTNu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCTNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:50:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525C11EA3;
        Mon, 20 Mar 2023 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679320234; x=1710856234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QQ+SjdksOJWAuWK44Z6HdI5GTwVX3g7th7BVrPolWhM=;
  b=J49FKtQixpaPPAlOQaI07OW82KHrMqIbK9NiDdCo92Vli3z8yinrKJ7H
   DLUOwmWldY7iIMV/Kh69orrqXll6ZlGczopjQo3HPUw2ngtlWdnaLkHQR
   kv3oVVGs/dgvlhFKpe1eBc5Wps1srkV0RzaXkcl+7LvSXPlOesQR9Q4B4
   vz64IqeHRDumlfJE/92wfnQoqJ3s8enP+DgfrKp2sVy//jBdb9lmijUBM
   bhLwftNSlDKG4R0ohm11ICxFTnXvPUzNgFAz7PvLef7h6znk0UzwcMdh2
   j9fOYOy3mXz1tU0eznf5PT0J8iYuSZHnpf+USa0iJTwnEHUKNgr1qyEEh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336171337"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336171337"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 06:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674391801"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="674391801"
Received: from mbouhaou-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 06:50:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] serial: cpm_uart: Use uart_circ_empty()
Date:   Mon, 20 Mar 2023 15:50:09 +0200
Message-Id: <20230320135009.47170-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320135009.47170-1-ilpo.jarvinen@linux.intel.com>
References: <20230320135009.47170-1-ilpo.jarvinen@linux.intel.com>
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

Use uart_circ_empty() instead of open coding it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 5565f302cb21..349e7da643f0 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -678,15 +678,14 @@ static int cpm_uart_tx_pump(struct uart_port *port)
 	/* Pick next descriptor and fill from buffer */
 	bdp = pinfo->tx_cur;
 
-	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) &&
-	       xmit->tail != xmit->head) {
+	while (!(in_be16(&bdp->cbd_sc) & BD_SC_READY) && !uart_circ_empty(xmit)) {
 		count = 0;
 		p = cpm2cpu_addr(in_be32(&bdp->cbd_bufaddr), pinfo);
 		while (count < pinfo->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			uart_xmit_advance(port, 1);
 			count++;
-			if (xmit->head == xmit->tail)
+			if (uart_circ_empty(xmit))
 				break;
 		}
 		out_be16(&bdp->cbd_datlen, count);
-- 
2.30.2

