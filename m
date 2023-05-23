Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C094A70D628
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEWHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjEWHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B110D1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB467219EE;
        Tue, 23 May 2023 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duuZwN1C9IUQLQQEAFsw/JZ4JxAL3kzU5sIEEpm2/Z8=;
        b=EUqXzLC0QgGY2mNYInw54Hs0O9Ti2wyrYx1zPwp5ZJnHqF7bq+RQGr7r0NWYKth1JsXRlD
        Wmtn2Z/18DlKT50ZVuq0ujLJUSnIhKh/49QV6wy0BDW3yFy9hM6ny2TUPXp9H5VszRR15o
        jDSAAdpo2ZeNse13KJMYTKQLbcpIVnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duuZwN1C9IUQLQQEAFsw/JZ4JxAL3kzU5sIEEpm2/Z8=;
        b=aUmxVBbexQ+QEfvys+3GiVCD2BcAxLFBuvh/IvWCESBt9h97lPmuHSZGjM9gPOTWbmhYsD
        Pyh6xWc+EdLd5QAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FF0913588;
        Tue, 23 May 2023 07:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6AueHSBxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:08 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/37] ALSA: seq: Drop dead code for the old broadcast support
Date:   Tue, 23 May 2023 09:53:41 +0200
Message-Id: <20230523075358.9672-21-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broadcast and multicast supports have been never enabled.
Let's drop the dead code.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 105 +--------------------------------
 1 file changed, 1 insertion(+), 104 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 98e8032a32e2..019af1343325 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -711,93 +711,6 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 	return (result < 0) ? result : num_ev;
 }
 
-
-#ifdef SUPPORT_BROADCAST 
-/*
- * broadcast to all ports:
- */
-static int port_broadcast_event(struct snd_seq_client *client,
-				struct snd_seq_event *event,
-				int atomic, int hop)
-{
-	int num_ev = 0, err, result = 0;
-	struct snd_seq_client *dest_client;
-	struct snd_seq_client_port *port;
-
-	dest_client = get_event_dest_client(event, SNDRV_SEQ_FILTER_BROADCAST);
-	if (dest_client == NULL)
-		return 0; /* no matching destination */
-
-	read_lock(&dest_client->ports_lock);
-	list_for_each_entry(port, &dest_client->ports_list_head, list) {
-		event->dest.port = port->addr.port;
-		/* pass NULL as source client to avoid error bounce */
-		err = snd_seq_deliver_single_event(NULL, event,
-						   SNDRV_SEQ_FILTER_BROADCAST,
-						   atomic, hop);
-		if (err < 0) {
-			/* save first error that occurs and continue */
-			if (!result)
-				result = err;
-			continue;
-		}
-		num_ev++;
-	}
-	read_unlock(&dest_client->ports_lock);
-	snd_seq_client_unlock(dest_client);
-	event->dest.port = SNDRV_SEQ_ADDRESS_BROADCAST; /* restore */
-	return (result < 0) ? result : num_ev;
-}
-
-/*
- * send the event to all clients:
- * if destination port is also ADDRESS_BROADCAST, deliver to all ports.
- */
-static int broadcast_event(struct snd_seq_client *client,
-			   struct snd_seq_event *event, int atomic, int hop)
-{
-	int err, result = 0, num_ev = 0;
-	int dest;
-	struct snd_seq_addr addr;
-
-	addr = event->dest; /* save */
-
-	for (dest = 0; dest < SNDRV_SEQ_MAX_CLIENTS; dest++) {
-		/* don't send to itself */
-		if (dest == client->number)
-			continue;
-		event->dest.client = dest;
-		event->dest.port = addr.port;
-		if (addr.port == SNDRV_SEQ_ADDRESS_BROADCAST)
-			err = port_broadcast_event(client, event, atomic, hop);
-		else
-			/* pass NULL as source client to avoid error bounce */
-			err = snd_seq_deliver_single_event(NULL, event,
-							   SNDRV_SEQ_FILTER_BROADCAST,
-							   atomic, hop);
-		if (err < 0) {
-			/* save first error that occurs and continue */
-			if (!result)
-				result = err;
-			continue;
-		}
-		num_ev += err;
-	}
-	event->dest = addr; /* restore */
-	return (result < 0) ? result : num_ev;
-}
-
-
-/* multicast - not supported yet */
-static int multicast_event(struct snd_seq_client *client, struct snd_seq_event *event,
-			   int atomic, int hop)
-{
-	pr_debug("ALSA: seq: multicast not supported yet.\n");
-	return 0; /* ignored */
-}
-#endif /* SUPPORT_BROADCAST */
-
-
 /* deliver an event to the destination port(s).
  * if the event is to subscribers or broadcast, the event is dispatched
  * to multiple targets.
@@ -826,15 +739,6 @@ static int snd_seq_deliver_event(struct snd_seq_client *client, struct snd_seq_e
 	if (event->queue == SNDRV_SEQ_ADDRESS_SUBSCRIBERS ||
 	    event->dest.client == SNDRV_SEQ_ADDRESS_SUBSCRIBERS)
 		result = deliver_to_subscribers(client, event, atomic, hop);
-#ifdef SUPPORT_BROADCAST
-	else if (event->queue == SNDRV_SEQ_ADDRESS_BROADCAST ||
-		 event->dest.client == SNDRV_SEQ_ADDRESS_BROADCAST)
-		result = broadcast_event(client, event, atomic, hop);
-	else if (event->dest.client >= SNDRV_SEQ_MAX_CLIENTS)
-		result = multicast_event(client, event, atomic, hop);
-	else if (event->dest.port == SNDRV_SEQ_ADDRESS_BROADCAST)
-		result = port_broadcast_event(client, event, atomic, hop);
-#endif
 	else
 		result = snd_seq_deliver_single_event(client, event, 0, atomic, hop);
 
@@ -936,14 +840,7 @@ static int snd_seq_client_enqueue_event(struct snd_seq_client *client,
 	if (event->queue == SNDRV_SEQ_ADDRESS_SUBSCRIBERS) {
 		event->dest.client = SNDRV_SEQ_ADDRESS_SUBSCRIBERS;
 		event->queue = SNDRV_SEQ_QUEUE_DIRECT;
-	} else
-#ifdef SUPPORT_BROADCAST
-		if (event->queue == SNDRV_SEQ_ADDRESS_BROADCAST) {
-			event->dest.client = SNDRV_SEQ_ADDRESS_BROADCAST;
-			event->queue = SNDRV_SEQ_QUEUE_DIRECT;
-		}
-#endif
-	if (event->dest.client == SNDRV_SEQ_ADDRESS_SUBSCRIBERS) {
+	} else if (event->dest.client == SNDRV_SEQ_ADDRESS_SUBSCRIBERS) {
 		/* check presence of source port */
 		struct snd_seq_client_port *src_port = snd_seq_port_use_ptr(client, event->source.port);
 		if (src_port == NULL)
-- 
2.35.3

