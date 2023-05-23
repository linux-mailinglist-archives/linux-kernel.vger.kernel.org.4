Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B332B70D653
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjEWH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjEWH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46110E4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFCE220417;
        Tue, 23 May 2023 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA/KjUgcKuQxtHZTF3e6fCvm4X7bDeBEar63HAq3Wsc=;
        b=0LmK8Q4Uc/4K5xXvH6ARxg+LNLB4oQ4miCSzVS0JSIfRHLDFmZbBpoWwRi7emDf7UW0Vyh
        Bl4+un7AFnRLsR6b+3BbKcu5F0vOe1MXqDs/CNow80CBjQwI5c66OQpT3kADM8QIEsBlte
        /R4iOl2qDQn4V4l6Fs8rtdJjT5wVAzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA/KjUgcKuQxtHZTF3e6fCvm4X7bDeBEar63HAq3Wsc=;
        b=gz4Z+ioDjfb4E3UfAvko5dFPqCEljOGRJTrRlsDsdiwJdKnIoJK/NHdb9LQ+ZX7RZrnHxE
        Lduv12PS0ZBCgQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7595F13A1A;
        Tue, 23 May 2023 07:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uBmpGyJxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:10 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/37] ALSA: seq: Add port direction to snd_seq_port_info
Date:   Tue, 23 May 2023 09:53:49 +0200
Message-Id: <20230523075358.9672-29-tiwai@suse.de>
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

Add a new field "direction" to snd_seq_port_info for allowing a client
to tell the expected direction of the port access.  A port might still
allow subscriptions for read/write (e.g. for MIDI-CI) even if the
primary usage of the port is a single direction (either input or
output only).  This new "direction" field can help to indicate such
cases.

When the direction is unspecified at creating a port and the port has
either read or write capability, the corresponding direction bits are
set automatically as default.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h |  9 ++++++++-
 sound/core/seq/seq_clientmgr.c  | 16 ++++++++++++++--
 sound/core/seq/seq_dummy.c      |  1 +
 sound/core/seq/seq_midi.c       |  4 ++++
 sound/core/seq/seq_ports.c      | 13 +++++++++++++
 sound/core/seq/seq_ports.h      |  2 ++
 sound/core/seq/seq_virmidi.c    |  1 +
 7 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 67532c46b115..eae1e0b0bf37 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -455,6 +455,12 @@ struct snd_seq_remove_events {
 #define SNDRV_SEQ_PORT_FLG_TIMESTAMP	(1<<1)
 #define SNDRV_SEQ_PORT_FLG_TIME_REAL	(1<<2)
 
+/* port direction */
+#define SNDRV_SEQ_PORT_DIR_UNKNOWN	0
+#define SNDRV_SEQ_PORT_DIR_INPUT	1
+#define SNDRV_SEQ_PORT_DIR_OUTPUT	2
+#define SNDRV_SEQ_PORT_DIR_BIDIRECTION	3
+
 struct snd_seq_port_info {
 	struct snd_seq_addr addr;	/* client/port numbers */
 	char name[64];			/* port name */
@@ -471,7 +477,8 @@ struct snd_seq_port_info {
 	void *kernel;			/* reserved for kernel use (must be NULL) */
 	unsigned int flags;		/* misc. conditioning */
 	unsigned char time_queue;	/* queue # for timestamping */
-	char reserved[59];		/* for future use */
+	unsigned char direction;	/* port usage direction (r/w/bidir) */
+	char reserved[58];		/* for future use */
 };
 
 
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 061b3e2bece1..33aa6c5c5c9e 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2440,6 +2440,17 @@ static void snd_seq_info_dump_subscribers(struct snd_info_buffer *buffer,
 
 #define FLAG_PERM_DUPLEX(perm) ((perm) & SNDRV_SEQ_PORT_CAP_DUPLEX ? 'X' : '-')
 
+static const char *port_direction_name(unsigned char dir)
+{
+	static const char *names[4] = {
+		"-", "In", "Out", "In/Out"
+	};
+
+	if (dir > SNDRV_SEQ_PORT_DIR_BIDIRECTION)
+		return "Invalid";
+	return names[dir];
+}
+
 static void snd_seq_info_dump_ports(struct snd_info_buffer *buffer,
 				    struct snd_seq_client *client)
 {
@@ -2449,12 +2460,13 @@ static void snd_seq_info_dump_ports(struct snd_info_buffer *buffer,
 	list_for_each_entry(p, &client->ports_list_head, list) {
 		if (p->capability & SNDRV_SEQ_PORT_CAP_INACTIVE)
 			continue;
-		snd_iprintf(buffer, "  Port %3d : \"%s\" (%c%c%c%c)\n",
+		snd_iprintf(buffer, "  Port %3d : \"%s\" (%c%c%c%c) [%s]\n",
 			    p->addr.port, p->name,
 			    FLAG_PERM_RD(p->capability),
 			    FLAG_PERM_WR(p->capability),
 			    FLAG_PERM_EX(p->capability),
-			    FLAG_PERM_DUPLEX(p->capability));
+			    FLAG_PERM_DUPLEX(p->capability),
+			    port_direction_name(p->direction));
 		snd_seq_info_dump_subscribers(buffer, &p->c_src, 1, "    Connecting To: ");
 		snd_seq_info_dump_subscribers(buffer, &p->c_dest, 0, "    Connected From: ");
 	}
diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index 8c18d8c4177e..2e8844ee32ed 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -127,6 +127,7 @@ create_port(int idx, int type)
 	pinfo.capability |= SNDRV_SEQ_PORT_CAP_WRITE | SNDRV_SEQ_PORT_CAP_SUBS_WRITE;
 	if (duplex)
 		pinfo.capability |= SNDRV_SEQ_PORT_CAP_DUPLEX;
+	pinfo.direction = SNDRV_SEQ_PORT_DIR_BIDIRECTION;
 	pinfo.type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC
 		| SNDRV_SEQ_PORT_TYPE_SOFTWARE
 		| SNDRV_SEQ_PORT_TYPE_PORT;
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 2b5fff80de58..44302d98950e 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -367,6 +367,10 @@ snd_seq_midisynth_probe(struct device *_dev)
 		if ((port->capability & (SNDRV_SEQ_PORT_CAP_WRITE|SNDRV_SEQ_PORT_CAP_READ)) == (SNDRV_SEQ_PORT_CAP_WRITE|SNDRV_SEQ_PORT_CAP_READ) &&
 		    info->flags & SNDRV_RAWMIDI_INFO_DUPLEX)
 			port->capability |= SNDRV_SEQ_PORT_CAP_DUPLEX;
+		if (port->capability & SNDRV_SEQ_PORT_CAP_READ)
+			port->direction |= SNDRV_SEQ_PORT_DIR_INPUT;
+		if (port->capability & SNDRV_SEQ_PORT_CAP_WRITE)
+			port->direction |= SNDRV_SEQ_PORT_DIR_OUTPUT;
 		port->type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC
 			| SNDRV_SEQ_PORT_TYPE_HARDWARE
 			| SNDRV_SEQ_PORT_TYPE_PORT;
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 42f4172d4766..5574341f49eb 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -356,6 +356,16 @@ int snd_seq_set_port_info(struct snd_seq_client_port * port,
 	port->time_real = (info->flags & SNDRV_SEQ_PORT_FLG_TIME_REAL) ? 1 : 0;
 	port->time_queue = info->time_queue;
 
+	/* direction */
+	port->direction = info->direction;
+	/* fill default port direction */
+	if (!port->direction) {
+		if (info->capability & SNDRV_SEQ_PORT_CAP_READ)
+			port->direction |= SNDRV_SEQ_PORT_DIR_INPUT;
+		if (info->capability & SNDRV_SEQ_PORT_CAP_WRITE)
+			port->direction |= SNDRV_SEQ_PORT_DIR_OUTPUT;
+	}
+
 	return 0;
 }
 
@@ -393,6 +403,9 @@ int snd_seq_get_port_info(struct snd_seq_client_port * port,
 		info->time_queue = port->time_queue;
 	}
 
+	/* direction */
+	info->direction = port->direction;
+
 	return 0;
 }
 
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index 44f0e9e96bbf..dce733ab2398 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -72,6 +72,8 @@ struct snd_seq_client_port {
 	int midi_voices;
 	int synth_voices;
 		
+	/* direction */
+	unsigned char direction;
 };
 
 struct snd_seq_client;
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index f5cae49500c8..1b9260108e48 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -385,6 +385,7 @@ static int snd_virmidi_dev_attach_seq(struct snd_virmidi_dev *rdev)
 	pinfo->capability |= SNDRV_SEQ_PORT_CAP_WRITE | SNDRV_SEQ_PORT_CAP_SYNC_WRITE | SNDRV_SEQ_PORT_CAP_SUBS_WRITE;
 	pinfo->capability |= SNDRV_SEQ_PORT_CAP_READ | SNDRV_SEQ_PORT_CAP_SYNC_READ | SNDRV_SEQ_PORT_CAP_SUBS_READ;
 	pinfo->capability |= SNDRV_SEQ_PORT_CAP_DUPLEX;
+	pinfo->direction = SNDRV_SEQ_PORT_DIR_BIDIRECTION;
 	pinfo->type = SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC
 		| SNDRV_SEQ_PORT_TYPE_SOFTWARE
 		| SNDRV_SEQ_PORT_TYPE_PORT;
-- 
2.35.3

