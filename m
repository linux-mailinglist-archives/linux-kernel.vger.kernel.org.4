Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D85EC0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiI0LSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiI0LSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:18:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCDDFD4;
        Tue, 27 Sep 2022 04:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A53E421CF7;
        Tue, 27 Sep 2022 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664277500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gauer3q/6k/4Xyqww0eSr4tTUC9z7vKer7hN1rUB1yk=;
        b=DCnqFTEYl6CGA/Fm6EpN3TNE8dZlBeTOe83SbYxQZOz1zJrOLmVq9NU94NfcGhNpxFf/0L
        YACS/wO9Ww77XQU0oNbJu8xsLF02RKjTxVTugv/VrJb8CjwXcgefmkT50V/uHozdWJp2zD
        HBxOEP1Y90/aXHAIaalVTJDg8RKFqRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664277500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gauer3q/6k/4Xyqww0eSr4tTUC9z7vKer7hN1rUB1yk=;
        b=+/egnLgHcsNlsuC1XvG75HXSYdE5bs5Xk4YYODqMLoS+HyhGaXKKLh6C4tdoHfUob7/PGv
        XCbr+5ZfhtEyJRCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 40B482C162;
        Tue, 27 Sep 2022 11:18:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] tty: serial: extend lqasc_tx_ready() to lqasc_console_putchar()
Date:   Tue, 27 Sep 2022 13:18:16 +0200
Message-Id: <20220927111819.18516-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one more place where lqasc_tx_ready() can be used now:
lqasc_console_putchar(). So replace the open-coded variant by the
helper.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/lantiq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 6da1b7496c6c..ba9739af30ed 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -606,15 +606,12 @@ static const struct uart_ops lqasc_pops = {
 static void
 lqasc_console_putchar(struct uart_port *port, unsigned char ch)
 {
-	int fifofree;
-
 	if (!port->membase)
 		return;
 
-	do {
-		fifofree = (__raw_readl(port->membase + LTQ_ASC_FSTAT)
-			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
-	} while (fifofree == 0);
+	while (!lqasc_tx_ready(port))
+		;
+
 	writeb(ch, port->membase + LTQ_ASC_TBUF);
 }
 
-- 
2.37.3

