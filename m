Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14F5BDC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiITFVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiITFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ABB4DF11;
        Mon, 19 Sep 2022 22:20:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 654AA1F8A6;
        Tue, 20 Sep 2022 05:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBb254ufDLViHW1psKMCbOT0ZEYgTcb/VpywoIn1+Pk=;
        b=JprHj6lqGzW/P7TP1CSeXgoLGRytYOf+MKeTqUmar/N8h/INk9kJc8ZdzZ8oloeAzTBGOe
        rCMhHBzMPpHkFlrmWUVy3TwD0S5O7L6N9Y7M2cniwUOdiedqdUEHhwSClxxG79xHXGzWzz
        FcsM+MCUVTK3wLT9tJl8mJtBzztjPZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBb254ufDLViHW1psKMCbOT0ZEYgTcb/VpywoIn1+Pk=;
        b=2eS108/4W2ZEiJdwrgU0c2YVtVlbK9qGheh98zt01LsFh9SxYeAoi6mdfk+rPrHP/gVyXm
        GTSNK4i+fmmTOsDg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37C282C141;
        Tue, 20 Sep 2022 05:20:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 04/10] tty: serial: extract lqasc_tx_ready() from lqasc_tx_chars()
Date:   Tue, 20 Sep 2022 07:20:44 +0200
Message-Id: <20220920052049.20507-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
References: <20220920052049.20507-1-jslaby@suse.cz>
MIME-Version: 1.0
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

The condition in lqasc_tx_chars()'s loop is barely readable. Extract it
to a separate function. This will make the cleanup in the next patches
easier too.

(Put it before lqasc_start_tx(), so that we can use it there later.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] this is new in v4 -- extracted as a separate change

 drivers/tty/serial/lantiq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 6637b3caa6b7..6da1b7496c6c 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -139,6 +139,13 @@ lqasc_stop_tx(struct uart_port *port)
 	return;
 }
 
+static bool lqasc_tx_ready(struct uart_port *port)
+{
+	u32 fstat = __raw_readl(port->membase + LTQ_ASC_FSTAT);
+
+	return (fstat & ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
+}
+
 static void
 lqasc_start_tx(struct uart_port *port)
 {
@@ -228,8 +235,7 @@ lqasc_tx_chars(struct uart_port *port)
 		return;
 	}
 
-	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
-		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
+	while (lqasc_tx_ready(port)) {
 		if (port->x_char) {
 			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
 			port->icount.tx++;
-- 
2.37.3

