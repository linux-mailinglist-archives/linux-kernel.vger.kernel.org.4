Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04970D645
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjEWH5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjEWH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E71AE
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59C2E2041A;
        Tue, 23 May 2023 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOTcZ9DIk5No118bn2nnkWGzCS2/GY1r2cgjHjJmqlU=;
        b=pGb4yt/1Unx5AMGYBOE6YXbBkoRHdWIXYyGy5gTMsXXt6p+0pt3f7LcGD1tUzhFV2lwTKJ
        Ir4tsTFsrNKR5TEHpbGBlf6YGnV7X7wVWzo5QP3wOTZfljys5H3wpRd3LGKRfslm46yqBg
        lTFiyfasqQE21Hr/uwkTHh6EoOJ+PTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOTcZ9DIk5No118bn2nnkWGzCS2/GY1r2cgjHjJmqlU=;
        b=HyphhFOpNX++GJhHbWTtU77kQFyGUMgeYvmXoMBxx/rfGH255jbRnJPtdc9jki/G0z3//Y
        +gIWqgtcW7QvS7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A12813588;
        Tue, 23 May 2023 07:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gHgCBSRxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:12 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/37] ALSA: seq: ump: Create UMP Endpoint port for broadcast
Date:   Tue, 23 May 2023 09:53:54 +0200
Message-Id: <20230523075358.9672-34-tiwai@suse.de>
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

Create a sequencer port for broadcasting the all group inputs at the
port number 0.  This corresponds to a UMP Endpoint connection;
application can read all UMP events from this port no matter which
group the UMP packet belongs to.

Unlike seq ports for other UMP groups, a UMP Endpoint port has no
SND_SEQ_PORT_TYPE_MIDI_GENERIC bit, so that it won't be treated as a
normal MIDI 1.0 device from legacy applications.

The port is named as "MIDI 2.0" to align with representations on other
operation systems.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_ump_client.c | 60 +++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index 8d360655ff5d..600b061ac8c3 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -290,6 +290,62 @@ static void update_group_attrs(struct seq_ump_client *client)
 	}
 }
 
+/* create a UMP Endpoint port */
+static int create_ump_endpoint_port(struct seq_ump_client *client)
+{
+	struct snd_seq_port_info *port;
+	struct snd_seq_port_callback pcallbacks;
+	unsigned int rawmidi_info = client->ump->core.info_flags;
+	int err;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->addr.client = client->seq_client;
+	port->addr.port = 0; /* fixed */
+	port->flags = SNDRV_SEQ_PORT_FLG_GIVEN_PORT;
+	port->capability = SNDRV_SEQ_PORT_CAP_UMP_ENDPOINT;
+	if (rawmidi_info & SNDRV_RAWMIDI_INFO_INPUT) {
+		port->capability |= SNDRV_SEQ_PORT_CAP_READ |
+			SNDRV_SEQ_PORT_CAP_SYNC_READ |
+			SNDRV_SEQ_PORT_CAP_SUBS_READ;
+		port->direction |= SNDRV_SEQ_PORT_DIR_INPUT;
+	}
+	if (rawmidi_info & SNDRV_RAWMIDI_INFO_OUTPUT) {
+		port->capability |= SNDRV_SEQ_PORT_CAP_WRITE |
+			SNDRV_SEQ_PORT_CAP_SYNC_WRITE |
+			SNDRV_SEQ_PORT_CAP_SUBS_WRITE;
+		port->direction |= SNDRV_SEQ_PORT_DIR_OUTPUT;
+	}
+	if (rawmidi_info & SNDRV_RAWMIDI_INFO_DUPLEX)
+		port->capability |= SNDRV_SEQ_PORT_CAP_DUPLEX;
+	port->ump_group = 0; /* no associated group, no conversion */
+	port->type = SNDRV_SEQ_PORT_TYPE_MIDI_UMP |
+		SNDRV_SEQ_PORT_TYPE_HARDWARE |
+		SNDRV_SEQ_PORT_TYPE_PORT;
+	port->midi_channels = 16;
+	strcpy(port->name, "MIDI 2.0");
+	memset(&pcallbacks, 0, sizeof(pcallbacks));
+	pcallbacks.owner = THIS_MODULE;
+	pcallbacks.private_data = client;
+	if (rawmidi_info & SNDRV_RAWMIDI_INFO_INPUT) {
+		pcallbacks.subscribe = seq_ump_subscribe;
+		pcallbacks.unsubscribe = seq_ump_unsubscribe;
+	}
+	if (rawmidi_info & SNDRV_RAWMIDI_INFO_OUTPUT) {
+		pcallbacks.use = seq_ump_use;
+		pcallbacks.unuse = seq_ump_unuse;
+		pcallbacks.event_input = seq_ump_process_event;
+	}
+	port->kernel = &pcallbacks;
+	err = snd_seq_kernel_client_ctl(client->seq_client,
+					SNDRV_SEQ_IOCTL_CREATE_PORT,
+					port);
+	kfree(port);
+	return err;
+}
+
 /* release the client resources */
 static void seq_ump_client_free(struct seq_ump_client *client)
 {
@@ -353,6 +409,10 @@ static int snd_seq_ump_probe(struct device *_dev)
 			goto error;
 	}
 
+	err = create_ump_endpoint_port(client);
+	if (err < 0)
+		goto error;
+
 	ump->seq_client = client;
 	ump->seq_ops = &seq_ump_ops;
 	return 0;
-- 
2.35.3

