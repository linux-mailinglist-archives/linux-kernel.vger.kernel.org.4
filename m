Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A3E70D630
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjEWH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjEWHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105F0E6F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CDBE20416;
        Tue, 23 May 2023 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NG2CvvqkfyXT6KfR2ATsi6VihNF6lLcBKYgL/VMEh8=;
        b=nZQ1c9za7bZvHM3ojokmBGGkAx79Wlsn4hvIc4CL61945nKhjL4sw5enlW3hJUh2AbyAt/
        IK9grQyg+CDqTWmP7gv12+fPCJwdnvxk5ljNhsZvXuKEteVSHVqhgG3S7ygh6xzFGokoD5
        DW+equGc4bkdDpdlnFbFu2wo6VoEL38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NG2CvvqkfyXT6KfR2ATsi6VihNF6lLcBKYgL/VMEh8=;
        b=ylM3LZYZ4pgUG57abvlCVyDVD11frO9a6tpJLQF6kanJDUug/kGIuZqJed0KxnvXGUqhBJ
        Ob6yWgeFJD9QsYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 420BF13588;
        Tue, 23 May 2023 07:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFVDDyJxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:10 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/37] ALSA: seq: Support MIDI 2.0 UMP Endpoint port
Date:   Tue, 23 May 2023 09:53:48 +0200
Message-Id: <20230523075358.9672-28-tiwai@suse.de>
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

This is an extension to ALSA sequencer infrastructure to support the
MIDI 2.0 UMP Endpoint port.  It's a "catch-all" port that is supposed
to be present for each UMP Endpoint.  When this port is read via
subscription, it sends any events from all ports (UMP Groups) found in
the same client.

A UMP Endpoint port can be created with the new capability bit
SNDRV_SEQ_PORT_CAP_UMP_ENDPOINT.  Although the port assignment isn't
strictly defined, it should be the port number 0.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h |  1 +
 sound/core/seq/seq_clientmgr.c  | 47 +++++++++++++++++++++++++++------
 sound/core/seq/seq_clientmgr.h  |  1 +
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index c6ca6609790b..67532c46b115 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -428,6 +428,7 @@ struct snd_seq_remove_events {
 #define SNDRV_SEQ_PORT_CAP_SUBS_WRITE	(1<<6)	/* allow write subscription */
 #define SNDRV_SEQ_PORT_CAP_NO_EXPORT	(1<<7)	/* routing not allowed */
 #define SNDRV_SEQ_PORT_CAP_INACTIVE	(1<<8)	/* inactive port */
+#define SNDRV_SEQ_PORT_CAP_UMP_ENDPOINT	(1<<9)	/* MIDI 2.0 UMP Endpoint port */
 
 	/* port type */
 #define SNDRV_SEQ_PORT_TYPE_SPECIFIC	(1<<0)	/* hardware specific */
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6508ce63f761..061b3e2bece1 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -239,6 +239,7 @@ static struct snd_seq_client *seq_create_client1(int client_index, int poolsize)
 	mutex_init(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
 	mutex_init(&client->ioctl_mutex);
+	client->ump_endpoint_port = -1;
 
 	/* find free slot in the client table */
 	spin_lock_irq(&clients_lock);
@@ -680,20 +681,17 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
 /*
  * send the event to all subscribers:
  */
-static int deliver_to_subscribers(struct snd_seq_client *client,
-				  struct snd_seq_event *event,
-				  int atomic, int hop)
+static int __deliver_to_subscribers(struct snd_seq_client *client,
+				    struct snd_seq_event *event,
+				    struct snd_seq_client_port *src_port,
+				    int atomic, int hop)
 {
 	struct snd_seq_subscribers *subs;
 	int err, result = 0, num_ev = 0;
-	struct snd_seq_client_port *src_port;
 	union __snd_seq_event event_saved;
 	size_t saved_size;
 	struct snd_seq_port_subs_info *grp;
 
-	src_port = snd_seq_port_use_ptr(client, event->source.port);
-	if (src_port == NULL)
-		return -EINVAL; /* invalid source port */
 	/* save original event record */
 	saved_size = snd_seq_event_packet_size(event);
 	memcpy(&event_saved, event, saved_size);
@@ -733,6 +731,31 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 	return (result < 0) ? result : num_ev;
 }
 
+static int deliver_to_subscribers(struct snd_seq_client *client,
+				  struct snd_seq_event *event,
+				  int atomic, int hop)
+{
+	struct snd_seq_client_port *src_port;
+	int ret = 0, ret2;
+
+	src_port = snd_seq_port_use_ptr(client, event->source.port);
+	if (src_port) {
+		ret = __deliver_to_subscribers(client, event, src_port, atomic, hop);
+		snd_seq_port_unlock(src_port);
+	}
+
+	if (client->ump_endpoint_port < 0 ||
+	    event->source.port == client->ump_endpoint_port)
+		return ret;
+
+	src_port = snd_seq_port_use_ptr(client, client->ump_endpoint_port);
+	if (!src_port)
+		return ret;
+	ret2 = __deliver_to_subscribers(client, event, src_port, atomic, hop);
+	snd_seq_port_unlock(src_port);
+	return ret2 < 0 ? ret2 : ret;
+}
+
 /* deliver an event to the destination port(s).
  * if the event is to subscribers or broadcast, the event is dispatched
  * to multiple targets.
@@ -1257,6 +1280,9 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 		return -EPERM;
 	if (client->type == USER_CLIENT && info->kernel)
 		return -EINVAL;
+	if ((info->capability & SNDRV_SEQ_PORT_CAP_UMP_ENDPOINT) &&
+	    client->ump_endpoint_port >= 0)
+		return -EBUSY;
 
 	if (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT)
 		port_idx = info->addr.port;
@@ -1286,6 +1312,8 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 	info->addr = port->addr;
 
 	snd_seq_set_port_info(port, info);
+	if (info->capability & SNDRV_SEQ_PORT_CAP_UMP_ENDPOINT)
+		client->ump_endpoint_port = port->addr.port;
 	snd_seq_system_client_ev_port_start(port->addr.client, port->addr.port);
 	snd_seq_port_unlock(port);
 
@@ -1305,8 +1333,11 @@ static int snd_seq_ioctl_delete_port(struct snd_seq_client *client, void *arg)
 		return -EPERM;
 
 	err = snd_seq_delete_port(client, info->addr.port);
-	if (err >= 0)
+	if (err >= 0) {
+		if (client->ump_endpoint_port == info->addr.port)
+			client->ump_endpoint_port = -1;
 		snd_seq_system_client_ev_port_exit(client->number, info->addr.port);
+	}
 	return err;
 }
 
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 5657f8091835..bb973d36ce78 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -50,6 +50,7 @@ struct snd_seq_client {
 	struct mutex ports_mutex;
 	struct mutex ioctl_mutex;
 	int convert32;		/* convert 32->64bit */
+	int ump_endpoint_port;
 
 	/* output pool */
 	struct snd_seq_pool *pool;		/* memory pool for this client */
-- 
2.35.3

