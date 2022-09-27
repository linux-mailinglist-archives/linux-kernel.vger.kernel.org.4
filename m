Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526095EC0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiI0LTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiI0LSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:18:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5426BCEB;
        Tue, 27 Sep 2022 04:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 83FF71FD07;
        Tue, 27 Sep 2022 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664277501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6ztBScsKSn32mkT2NhD08kHlXvqclyG0jMfeztB7nU=;
        b=2ygAvVOXTuAu2mtJF1vrPjUFilv97iBfRlK7wohSbSnUtDV+j4nE3WfxnQs0/5ctR/Ailh
        JvbrVp3snQu9JvGHaePH8tgzZUtyBiXEy5nCaVR37jU40pd49YG9rRuRIMm1g+iWBX2L55
        sN7w2SSz7fHUsrO2+iFKAA6u07MMNB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664277501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6ztBScsKSn32mkT2NhD08kHlXvqclyG0jMfeztB7nU=;
        b=HUxLzx87puN1Dd0I2gvbpmWCWVWr9xyK9ek1B6FNOlnSu/oxDhash4C95JEBTXk6YDPtE8
        fCySs6ZRtHgtPdBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C1622C162;
        Tue, 27 Sep 2022 11:18:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 4/4] tty: serial: do unlock on a common path in altera_jtaguart_console_putc()
Date:   Tue, 27 Sep 2022 13:18:19 +0200
Message-Id: <20220927111819.18516-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111819.18516-1-jslaby@suse.cz>
References: <20220927111819.18516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port->lock is unlocked in each branch in altera_jtaguart_console_putc(),
so do it before the "if". "status" needs not be under the lock, as the
register was already read.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/altera_jtaguart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index ac8ce418de36..c2d154d78e54 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -310,11 +310,12 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
 
 	spin_lock_irqsave(&port->lock, flags);
 	while (!altera_jtaguart_tx_space(port, &status)) {
+		spin_unlock_irqrestore(&port->lock, flags);
+
 		if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
-			spin_unlock_irqrestore(&port->lock, flags);
 			return;	/* no connection activity */
 		}
-		spin_unlock_irqrestore(&port->lock, flags);
+
 		cpu_relax();
 		spin_lock_irqsave(&port->lock, flags);
 	}
-- 
2.37.3

