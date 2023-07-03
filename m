Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B420745389
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGCB1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGCB1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 21:27:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CB21B7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 18:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40E860C02
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF8AC433CB;
        Mon,  3 Jul 2023 01:27:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iRY8hJR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1688347666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vU3RCfgpG3KdwhpqFpp02kiLPLFZCp7TDcMNE+j7so=;
        b=iRY8hJR8i2eVuexomX9EezsGevM7ROEItROH313UlYQR+njzqHIHTkZoDeK4YyRD74+XsD
        NFlskBYmOugnyGJPbyVVd7fMFe3llY7hUFbKOIgJdIspDRVygjp0D0mBNnibkufui1zmlN
        wK8I305qCAyIVbrP08Zc6sRg+gYFC+w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6c37c271 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 3 Jul 2023 01:27:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 3/3] wireguard: timers: move to using timer_delete_sync
Date:   Mon,  3 Jul 2023 03:27:06 +0200
Message-ID: <20230703012723.800199-4-Jason@zx2c4.com>
In-Reply-To: <20230703012723.800199-1-Jason@zx2c4.com>
References: <20230703012723.800199-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says that del_timer_sync is obsolete, and code should
use the equivalent timer_delete_sync instead, so switch to it.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index 53d8a57a0dfa..968bdb4df0b3 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -234,10 +234,10 @@ void wg_timers_init(struct wg_peer *peer)
 
 void wg_timers_stop(struct wg_peer *peer)
 {
-	del_timer_sync(&peer->timer_retransmit_handshake);
-	del_timer_sync(&peer->timer_send_keepalive);
-	del_timer_sync(&peer->timer_new_handshake);
-	del_timer_sync(&peer->timer_zero_key_material);
-	del_timer_sync(&peer->timer_persistent_keepalive);
+	timer_delete_sync(&peer->timer_retransmit_handshake);
+	timer_delete_sync(&peer->timer_send_keepalive);
+	timer_delete_sync(&peer->timer_new_handshake);
+	timer_delete_sync(&peer->timer_zero_key_material);
+	timer_delete_sync(&peer->timer_persistent_keepalive);
 	flush_work(&peer->clear_peer_work);
 }
-- 
2.41.0

