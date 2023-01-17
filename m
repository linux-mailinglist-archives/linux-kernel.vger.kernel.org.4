Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A213366D96C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjAQJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbjAQJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:11:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45AD305DD;
        Tue, 17 Jan 2023 01:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946329; x=1705482329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/abY3EvdT/9LBFynpim0jdmH9McxhRPFImaHI0+/DE=;
  b=Q+k3cNwl4cZ/6uTplWlpv/wyVhKrWFseL3Y6AmzCk+hv/POXb3PyatkP
   2PWnFfzev9qctTQeiX9Jk/or/80Wgzmb0wA4VQomgSqRfYJTZLApp3Bke
   FS1eFlFiR9U9G+RHOP6Vt2hoNAfCb+xGUEUw14LVfBXIq8jSRPoKJlHri
   xp2ndeHGG8x1L51ARacTUNtTFQih9gAiuWZ4OsBcD/uzm4ehQ6C9M+idA
   uNR7xoWtwdATnD7JfodUNs4ymMa6qtch0x27h/kN3Z1I+55eTrdNxbBsN
   BYneQH78nLufbfm6cHt4BeijZDJwLUqN4+6j1nIPQ7H62KfSPwCfPO3Z3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324700949"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324700949"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174062"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174062"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:04:34 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 02/12] tty: Cleamup tty_port_set_suspended() bool parameter
Date:   Tue, 17 Jan 2023 11:03:48 +0200
Message-Id: <20230117090358.4796-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
References: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make callers pass true/false consistently for bool val.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e049c760b738..f9564b1e3dfb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -312,7 +312,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
 	 * we don't try to resume a port that has been shutdown.
 	 */
-	tty_port_set_suspended(port, 0);
+	tty_port_set_suspended(port, false);
 
 	/*
 	 * Do not free() the transmit buffer page under the port lock since
@@ -1725,7 +1725,7 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
 	 * we don't try to resume a port that has been shutdown.
 	 */
-	tty_port_set_suspended(port, 0);
+	tty_port_set_suspended(port, false);
 
 	/*
 	 * Free the transmit buffer.
@@ -2346,7 +2346,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		int tries;
 		unsigned int mctrl;
 
-		tty_port_set_suspended(port, 1);
+		tty_port_set_suspended(port, true);
 		tty_port_set_initialized(port, false);
 
 		spin_lock_irq(&uport->lock);
@@ -2469,7 +2469,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			}
 		}
 
-		tty_port_set_suspended(port, 0);
+		tty_port_set_suspended(port, false);
 	}
 
 	mutex_unlock(&port->mutex);
-- 
2.30.2

