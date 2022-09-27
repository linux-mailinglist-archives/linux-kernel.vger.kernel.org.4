Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C45EC0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiI0LSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiI0LSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:18:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FD26556C;
        Tue, 27 Sep 2022 04:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E85211FD03;
        Tue, 27 Sep 2022 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664277500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebZ+Xt1ViSUC8CvP1VzU95P9RjvQ+iLziR5QfBILndI=;
        b=BzNIk4raZcbpTqhIz4si9t/uWIw12kdMHmV3EHr/Fwq0u2/Z0mXxNXFKUGKscX+13ZqOH+
        UpLFbPVxNT9y2n1nbw5obX3/We0TxiMB2OjDo+pIciQanUadmBpCFZ5oyLlbisQdJKlD/J
        L8r61CH9lfCOggZXB8JecF6Z1CS1Qkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664277500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebZ+Xt1ViSUC8CvP1VzU95P9RjvQ+iLziR5QfBILndI=;
        b=yHwBHopYSYyf48o0iaNjFnKa2D+uQM8Pgne9ia99DQuGvZShjGBrliysCO/0H5Uwz8XjRH
        tVj3/7K/f2mwPlAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE70A2C165;
        Tue, 27 Sep 2022 11:18:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/4] tty: serial: use FIELD_GET() in lqasc_tx_ready()
Date:   Tue, 27 Sep 2022 13:18:17 +0200
Message-Id: <20220927111819.18516-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111819.18516-1-jslaby@suse.cz>
References: <20220927111819.18516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIELD_GET() can do the job smarter and more readable. We don't even need
ASCFSTAT_TXFREEOFF. So switch to the former and remove the latter.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/lantiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index ba9739af30ed..c892f3c7d1ab 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/device.h>
@@ -93,7 +94,6 @@
 #define ASCFSTAT_RXFFLMASK	0x003F
 #define ASCFSTAT_TXFFLMASK	0x3F00
 #define ASCFSTAT_TXFREEMASK	0x3F000000
-#define ASCFSTAT_TXFREEOFF	24
 
 static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
@@ -143,7 +143,7 @@ static bool lqasc_tx_ready(struct uart_port *port)
 {
 	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
 
-	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
+	return FIELD_GET(ASCFSTAT_TXFREEMASK, fstat);
 }
 
 static void
-- 
2.37.3

