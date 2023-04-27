Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEE6F06B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243821AbjD0NeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjD0Nd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F0E6E;
        Thu, 27 Apr 2023 06:33:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A5D31FE32;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLzP9SAcTfx667WVdFvH1a9kYppCuDAPQTrilwO0dss=;
        b=g45f2GdvxtklIh7pQH298lcsK4S7ATQibFWKbU94QqmzuTHX2+r+dbrvC6anYRZaAVKMdw
        a1ARvWUWWOsSaJ6/t9QqsccoCgpLpmdzMD5Jue5nukNjXz6KS8pmPBoSquLCOdPbXNQdqk
        V9K4I/IJPsGdY9zpVWWPL5pKWtrIWUY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56C9F138F9;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OEV0E8N5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:55 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6/8] pcwd_usb: memory ordering of interrupt and waiter
Date:   Thu, 27 Apr 2023 15:33:48 +0200
Message-Id: <20230427133350.31064-7-oneukum@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427133350.31064-1-oneukum@suse.com>
References: <20230427133350.31064-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver manually waits in a loop for an atomic flag.
Hence memory ordering must be constrained, so that
the waiters read what the interrupt handler writes
before it touches the flag.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index b99b8fee2873..50ba88019ed6 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -193,6 +193,7 @@ static void usb_pcwd_intr_done(struct urb *urb)
 	usb_pcwd->cmd_command  = data[0];
 	usb_pcwd->cmd_data_msb = data[1];
 	usb_pcwd->cmd_data_lsb = data[2];
+	smp_wmb(); /* make sure waiters read them */
 
 	/* notify anyone waiting that the cmd has finished */
 	atomic_set(&usb_pcwd->cmd_received, 1);
@@ -250,6 +251,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 			got_response = 1;
 	}
 
+	smp_rmb(); /* ordering with respect to interrupt handler */
 	if ((got_response) && (cmd == usb_pcwd->cmd_command)) {
 		/* read back response */
 		*msb = usb_pcwd->cmd_data_msb;
-- 
2.40.0

