Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF04A709331
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjESJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjESJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D410F9
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F02D2222C0;
        Fri, 19 May 2023 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asADGQrckU3mOGi94QuYAt/bgLuAwUWDYqi0ci8KrMs=;
        b=u9szvi6tsh8sGSKf7fv1dTDPVidUrngjiSf+T0kYt5tYz8VlMpxhJa+TEptmbMVcxcn87V
        +UkdHNqrQtGSjlZIaAyBoGDn+mA8lh7pvynBz52PNSvj9XSo4fyqbQUQvILQt3tfPvcM2D
        0dn6uKHMxQ8ZhFpiFso3nWUis5/7uL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asADGQrckU3mOGi94QuYAt/bgLuAwUWDYqi0ci8KrMs=;
        b=/ncDqhV1spkY7V8mrScJjXn9ZpI7Xk/OL3z/j7JANPmLVrfaAa4Ii1u49g+ge7msbwI/tN
        LHmvTQ33VLriJNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF31E13A12;
        Fri, 19 May 2023 09:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eOzNMf1BZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:41 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 20/36] ALSA: seq: Check the conflicting port at port creation
Date:   Fri, 19 May 2023 11:30:58 +0200
Message-Id: <20230519093114.28813-21-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230519093114.28813-1-tiwai@suse.de>
References: <20230519093114.28813-1-tiwai@suse.de>
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

We didn't check if a port with the given port number has been already
present at creating a new port.  Check it and return -EBUSY properly
if the port number conflicts.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 12 ++++++++----
 sound/core/seq/seq_ports.c     | 24 ++++++++++++++++--------
 sound/core/seq/seq_ports.h     |  5 +++--
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 019af1343325..06743114cabf 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1194,15 +1194,19 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 	struct snd_seq_port_info *info = arg;
 	struct snd_seq_client_port *port;
 	struct snd_seq_port_callback *callback;
-	int port_idx;
+	int port_idx, err;
 
 	/* it is not allowed to create the port for an another client */
 	if (info->addr.client != client->number)
 		return -EPERM;
 
-	port = snd_seq_create_port(client, (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT) ? info->addr.port : -1);
-	if (port == NULL)
-		return -ENOMEM;
+	if (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT)
+		port_idx = info->addr.port;
+	else
+		port_idx = -1;
+	err = snd_seq_create_port(client, port_idx, &port);
+	if (err < 0)
+		return err;
 
 	if (client->type == USER_CLIENT && info->kernel) {
 		port_idx = port->addr.port;
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 25fcf5a2c71c..188262b04b72 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -107,28 +107,30 @@ static void port_subs_info_init(struct snd_seq_port_subs_info *grp)
 }
 
 
-/* create a port, port number is returned (-1 on failure);
+/* create a port, port number or a negative error code is returned
  * the caller needs to unref the port via snd_seq_port_unlock() appropriately
  */
-struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
-						int port)
+int snd_seq_create_port(struct snd_seq_client *client, int port,
+			struct snd_seq_client_port **port_ret)
 {
 	struct snd_seq_client_port *new_port, *p;
-	int num = -1;
+	int num;
 	
+	*port_ret = NULL;
+
 	/* sanity check */
 	if (snd_BUG_ON(!client))
-		return NULL;
+		return -EINVAL;
 
 	if (client->num_ports >= SNDRV_SEQ_MAX_PORTS) {
 		pr_warn("ALSA: seq: too many ports for client %d\n", client->number);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* create a new port */
 	new_port = kzalloc(sizeof(*new_port), GFP_KERNEL);
 	if (!new_port)
-		return NULL;	/* failure, out of memory */
+		return -ENOMEM;	/* failure, out of memory */
 	/* init port data */
 	new_port->addr.client = client->number;
 	new_port->addr.port = -1;
@@ -143,6 +145,10 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 	mutex_lock(&client->ports_mutex);
 	write_lock_irq(&client->ports_lock);
 	list_for_each_entry(p, &client->ports_list_head, list) {
+		if (p->addr.port == port) {
+			num = -EBUSY;
+			goto unlock;
+		}
 		if (p->addr.port > num)
 			break;
 		if (port < 0) /* auto-probe mode */
@@ -153,10 +159,12 @@ struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client,
 	client->num_ports++;
 	new_port->addr.port = num;	/* store the port number in the port */
 	sprintf(new_port->name, "port-%d", num);
+	*port_ret = new_port;
+ unlock:
 	write_unlock_irq(&client->ports_lock);
 	mutex_unlock(&client->ports_mutex);
 
-	return new_port;
+	return num;
 }
 
 /* */
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index b1f2c4943174..44f0e9e96bbf 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -86,8 +86,9 @@ struct snd_seq_client_port *snd_seq_port_query_nearest(struct snd_seq_client *cl
 /* unlock the port */
 #define snd_seq_port_unlock(port) snd_use_lock_free(&(port)->use_lock)
 
-/* create a port, port number is returned (-1 on failure) */
-struct snd_seq_client_port *snd_seq_create_port(struct snd_seq_client *client, int port_index);
+/* create a port, port number or a negative error code is returned */
+int snd_seq_create_port(struct snd_seq_client *client, int port_index,
+			struct snd_seq_client_port **port_ret);
 
 /* delete a port */
 int snd_seq_delete_port(struct snd_seq_client *client, int port);
-- 
2.35.3

