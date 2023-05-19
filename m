Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD1709328
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjESJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjESJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E94E73
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FDCC222C0;
        Fri, 19 May 2023 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gu95+vhJb4byJpofgBTgCe0R4znWS6u9/iDDJxd97Mg=;
        b=wv5fTnm9Sgsw67b3MdtDQbjhsVodampP3SRcAV1fjIA6g+Da3oBP6PC/gssp9SZsRTIb2M
        sut8njPuzxCUp3JdbeYdeRy4tbQdG8SKayV1ueAvAMKpYW1EA27xjMbkUTXZZh9St0r0+S
        sqrgSsNq/wcFnAAatpfrIaSUdKyfKjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gu95+vhJb4byJpofgBTgCe0R4znWS6u9/iDDJxd97Mg=;
        b=BwY9MHgrZps6lvLzq6PhwD0IAgBlEzeLCvEFLVo0N169XYqlxCYSQ2B3nbuxoeMsTweZLM
        H7RvMBW8FCoRWTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A8FC13A12;
        Fri, 19 May 2023 09:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OOJREflBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:37 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/36] ALSA: ump: Redirect rawmidi substream access via own helpers
Date:   Fri, 19 May 2023 11:30:50 +0200
Message-Id: <20230519093114.28813-13-tiwai@suse.de>
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

This is a code refactoring for abstracting the rawmidi access to the
UMP's own helpers.  It's a preliminary work for the later code
refactoring of the UMP layer.

Until now, we access to the rawmidi substream directly from the
driver via rawmidi access helpers, but after this change, the driver
is supposed to access via the newly introduced snd_ump_ops and
receive/transmit via snd_ump_receive() and snd_ump_transmit() helpers.
As of this commit, those are merely wrappers for the rawmidi
substream, and no much function change is seen here.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ump.h |  14 ++++++
 sound/core/ump.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/midi2.c   |  71 ++++++++++------------------
 3 files changed, 149 insertions(+), 47 deletions(-)

diff --git a/include/sound/ump.h b/include/sound/ump.h
index 8a3ac97cd1d3..6f786b462f16 100644
--- a/include/sound/ump.h
+++ b/include/sound/ump.h
@@ -9,18 +9,30 @@
 
 struct snd_ump_endpoint;
 struct snd_ump_block;
+struct snd_ump_ops;
 
 struct snd_ump_endpoint {
 	struct snd_rawmidi core;	/* raw UMP access */
 
 	struct snd_ump_endpoint_info info;
 
+	const struct snd_ump_ops *ops;	/* UMP ops set by the driver */
+	struct snd_rawmidi_substream *substreams[2];	/* opened substreams */
+
 	void *private_data;
 	void (*private_free)(struct snd_ump_endpoint *ump);
 
 	struct list_head block_list;	/* list of snd_ump_block objects */
 };
 
+/* ops filled by UMP drivers */
+struct snd_ump_ops {
+	int (*open)(struct snd_ump_endpoint *ump, int dir);
+	void (*close)(struct snd_ump_endpoint *ump, int dir);
+	void (*trigger)(struct snd_ump_endpoint *ump, int dir, int up);
+	void (*drain)(struct snd_ump_endpoint *ump, int dir);
+};
+
 struct snd_ump_block {
 	struct snd_ump_block_info info;
 	struct snd_ump_endpoint *ump;
@@ -39,6 +51,8 @@ int snd_ump_endpoint_new(struct snd_card *card, char *id, int device,
 int snd_ump_block_new(struct snd_ump_endpoint *ump, unsigned int blk,
 		      unsigned int direction, unsigned int first_group,
 		      unsigned int num_groups, struct snd_ump_block **blk_ret);
+int snd_ump_receive(struct snd_ump_endpoint *ump, const u32 *buffer, int count);
+int snd_ump_transmit(struct snd_ump_endpoint *ump, u32 *buffer, int count);
 
 /*
  * Some definitions for UMP
diff --git a/sound/core/ump.c b/sound/core/ump.c
index 59cf564eb9fe..0d5ca95cd007 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -23,6 +23,11 @@ static long snd_ump_ioctl(struct snd_rawmidi_file *rfile, unsigned int cmd,
 			  void __user *argp);
 static void snd_ump_proc_read(struct snd_info_entry *entry,
 			      struct snd_info_buffer *buffer);
+static int snd_ump_rawmidi_open(struct snd_rawmidi_substream *substream);
+static int snd_ump_rawmidi_close(struct snd_rawmidi_substream *substream);
+static void snd_ump_rawmidi_trigger(struct snd_rawmidi_substream *substream,
+				    int up);
+static void snd_ump_rawmidi_drain(struct snd_rawmidi_substream *substream);
 
 static const struct snd_rawmidi_global_ops snd_ump_rawmidi_ops = {
 	.dev_register = snd_ump_dev_register,
@@ -31,6 +36,19 @@ static const struct snd_rawmidi_global_ops snd_ump_rawmidi_ops = {
 	.proc_read = snd_ump_proc_read,
 };
 
+static const struct snd_rawmidi_ops snd_ump_rawmidi_input_ops = {
+	.open = snd_ump_rawmidi_open,
+	.close = snd_ump_rawmidi_close,
+	.trigger = snd_ump_rawmidi_trigger,
+};
+
+static const struct snd_rawmidi_ops snd_ump_rawmidi_output_ops = {
+	.open = snd_ump_rawmidi_open,
+	.close = snd_ump_rawmidi_close,
+	.trigger = snd_ump_rawmidi_trigger,
+	.drain = snd_ump_rawmidi_drain,
+};
+
 static void snd_ump_endpoint_free(struct snd_rawmidi *rmidi)
 {
 	struct snd_ump_endpoint *ump = rawmidi_to_ump(rmidi);
@@ -104,6 +122,12 @@ int snd_ump_endpoint_new(struct snd_card *card, char *id, int device,
 
 	ump->core.private_free = snd_ump_endpoint_free;
 	ump->core.ops = &snd_ump_rawmidi_ops;
+	if (input)
+		snd_rawmidi_set_ops(&ump->core, SNDRV_RAWMIDI_STREAM_INPUT,
+				    &snd_ump_rawmidi_input_ops);
+	if (output)
+		snd_rawmidi_set_ops(&ump->core, SNDRV_RAWMIDI_STREAM_OUTPUT,
+				    &snd_ump_rawmidi_output_ops);
 
 	ump_dbg(ump, "Created a UMP EP #%d (%s)\n", device, id);
 	*ump_ret = ump;
@@ -137,6 +161,93 @@ snd_ump_get_block(struct snd_ump_endpoint *ump, unsigned char id)
 	return NULL;
 }
 
+/*
+ * rawmidi ops for UMP endpoint
+ */
+static int snd_ump_rawmidi_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_ump_endpoint *ump = rawmidi_to_ump(substream->rmidi);
+	int dir = substream->stream;
+	int err;
+
+	if (ump->substreams[dir])
+		return -EBUSY;
+	err = ump->ops->open(ump, dir);
+	if (err < 0)
+		return err;
+	ump->substreams[dir] = substream;
+	return 0;
+}
+
+static int snd_ump_rawmidi_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_ump_endpoint *ump = rawmidi_to_ump(substream->rmidi);
+	int dir = substream->stream;
+
+	ump->substreams[dir] = NULL;
+	ump->ops->close(ump, dir);
+	return 0;
+}
+
+static void snd_ump_rawmidi_trigger(struct snd_rawmidi_substream *substream,
+				    int up)
+{
+	struct snd_ump_endpoint *ump = rawmidi_to_ump(substream->rmidi);
+	int dir = substream->stream;
+
+	ump->ops->trigger(ump, dir, up);
+}
+
+static void snd_ump_rawmidi_drain(struct snd_rawmidi_substream *substream)
+{
+	struct snd_ump_endpoint *ump = rawmidi_to_ump(substream->rmidi);
+
+	if (ump->ops->drain)
+		ump->ops->drain(ump, SNDRV_RAWMIDI_STREAM_OUTPUT);
+}
+
+/**
+ * snd_ump_receive - transfer UMP packets from the device
+ * @ump: the UMP endpoint
+ * @buffer: the buffer pointer to transfer
+ * @count: byte size to transfer
+ *
+ * Called from the driver to submit the received UMP packets from the device
+ * to user-space.  It's essentially a wrapper of rawmidi_receive().
+ * The data to receive is in CPU-native endianness.
+ */
+int snd_ump_receive(struct snd_ump_endpoint *ump, const u32 *buffer, int count)
+{
+	struct snd_rawmidi_substream *substream =
+		ump->substreams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+	if (!substream)
+		return 0;
+	return snd_rawmidi_receive(substream, (const char *)buffer, count);
+}
+EXPORT_SYMBOL_GPL(snd_ump_receive);
+
+/**
+ * snd_ump_transmit - transmit UMP packets
+ * @ump: the UMP endpoint
+ * @buffer: the buffer pointer to transfer
+ * @count: byte size to transfer
+ *
+ * Called from the driver to obtain the UMP packets from user-space to the
+ * device.  It's essentially a wrapper of rawmidi_transmit().
+ * The data to transmit is in CPU-native endianness.
+ */
+int snd_ump_transmit(struct snd_ump_endpoint *ump, u32 *buffer, int count)
+{
+	struct snd_rawmidi_substream *substream =
+		ump->substreams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+	if (!substream)
+		return -ENODEV;
+	return snd_rawmidi_transmit(substream, (char *)buffer, count);
+}
+EXPORT_SYMBOL_GPL(snd_ump_transmit);
+
 /**
  * snd_ump_block_new - Create a UMP block
  * @ump: UMP object
diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 886fd85fcd80..3502a4b7fa41 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -52,7 +52,8 @@ struct snd_usb_midi2_endpoint {
 	struct usb_device *dev;
 	const struct usb_ms20_endpoint_descriptor *ms_ep; /* reference to EP descriptor */
 	struct snd_usb_midi2_endpoint *pair;	/* bidirectional pair EP */
-	struct snd_usb_midi2_ump *rmidi;	/* assigned UMP EP */
+	struct snd_usb_midi2_ump *rmidi;	/* assigned UMP EP pair */
+	struct snd_ump_endpoint *ump;		/* assigned UMP EP */
 	int direction;			/* direction (STR_IN/OUT) */
 	unsigned int endpoint;		/* EP number */
 	unsigned int pipe;		/* URB pipe */
@@ -133,12 +134,8 @@ static int prepare_output_urb(struct snd_usb_midi2_endpoint *ep,
 {
 	int count;
 
-	if (ep->substream)
-		count = snd_rawmidi_transmit(ep->substream,
-					     urb->transfer_buffer,
-					     ep->packets);
-	else
-		count = -ENODEV;
+	count = snd_ump_transmit(ep->ump, urb->transfer_buffer,
+				 ep->packets);
 	if (count < 0) {
 		dev_dbg(&ep->dev->dev, "rawmidi transmit error %d\n", count);
 		return count;
@@ -197,9 +194,9 @@ static void input_urb_complete(struct urb *urb)
 	len &= ~3; /* align UMP */
 	if (len > ep->packets)
 		len = ep->packets;
-	if (len > 0 && ep->substream) {
+	if (len > 0) {
 		le32_to_cpu_array((u32 *)urb->transfer_buffer, len >> 2);
-		snd_rawmidi_receive(ep->substream, urb->transfer_buffer, len);
+		snd_ump_receive(ep->ump, (u32 *)urb->transfer_buffer, len);
 	}
  dequeue:
 	set_bit(ctx->index, &ep->urb_free);
@@ -330,68 +327,58 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 }
 
 static struct snd_usb_midi2_endpoint *
-substream_to_endpoint(struct snd_rawmidi_substream *substream)
+ump_to_endpoint(struct snd_ump_endpoint *ump, int dir)
 {
-	struct snd_ump_endpoint *ump = rawmidi_to_ump(substream->rmidi);
 	struct snd_usb_midi2_ump *rmidi = ump->private_data;
 
-	return rmidi->eps[substream->stream];
+	return rmidi->eps[dir];
 }
 
-/* rawmidi open callback */
-static int snd_usb_midi_v2_open(struct snd_rawmidi_substream *substream)
+/* ump open callback */
+static int snd_usb_midi_v2_open(struct snd_ump_endpoint *ump, int dir)
 {
-	struct snd_usb_midi2_endpoint *ep = substream_to_endpoint(substream);
+	struct snd_usb_midi2_endpoint *ep = ump_to_endpoint(ump, dir);
 	int err = 0;
 
 	if (!ep || !ep->endpoint)
 		return -ENODEV;
 	if (ep->disconnected)
 		return -EIO;
-	if (ep->substream)
-		return -EBUSY;
 	if (ep->direction == STR_OUT) {
 		err = alloc_midi_urbs(ep);
 		if (err)
 			return err;
 	}
-	spin_lock_irq(&ep->lock);
-	ep->substream = substream;
-	spin_unlock_irq(&ep->lock);
 	return 0;
 }
 
-/* rawmidi close callback */
-static int snd_usb_midi_v2_close(struct snd_rawmidi_substream *substream)
+/* ump close callback */
+static void snd_usb_midi_v2_close(struct snd_ump_endpoint *ump, int dir)
 {
-	struct snd_usb_midi2_endpoint *ep = substream_to_endpoint(substream);
+	struct snd_usb_midi2_endpoint *ep = ump_to_endpoint(ump, dir);
 
-	spin_lock_irq(&ep->lock);
-	ep->substream = NULL;
-	spin_unlock_irq(&ep->lock);
 	if (ep->direction == STR_OUT) {
 		kill_midi_urbs(ep, false);
 		drain_urb_queue(ep);
 		free_midi_urbs(ep);
 	}
-	return 0;
 }
 
-/* rawmidi trigger callback */
-static void snd_usb_midi_v2_trigger(struct snd_rawmidi_substream *substream,
+/* ump trigger callback */
+static void snd_usb_midi_v2_trigger(struct snd_ump_endpoint *ump, int dir,
 				    int up)
 {
-	struct snd_usb_midi2_endpoint *ep = substream_to_endpoint(substream);
+	struct snd_usb_midi2_endpoint *ep = ump_to_endpoint(ump, dir);
 
 	atomic_set(&ep->running, up);
 	if (up && ep->direction == STR_OUT && !ep->disconnected)
 		submit_io_urbs(ep);
 }
 
-/* rawmidi drain callback */
-static void snd_usb_midi_v2_drain(struct snd_rawmidi_substream *substream)
+/* ump drain callback */
+static void snd_usb_midi_v2_drain(struct snd_ump_endpoint *ump, int dir)
 {
-	struct snd_usb_midi2_endpoint *ep = substream_to_endpoint(substream);
+	struct snd_usb_midi2_endpoint *ep = ump_to_endpoint(ump, dir);
 
 	drain_urb_queue(ep);
 }
@@ -426,19 +413,13 @@ static int start_input_streams(struct snd_usb_midi2_interface *umidi)
 	return err;
 }
 
-static const struct snd_rawmidi_ops output_ops = {
+static const struct snd_ump_ops snd_usb_midi_v2_ump_ops = {
 	.open = snd_usb_midi_v2_open,
 	.close = snd_usb_midi_v2_close,
 	.trigger = snd_usb_midi_v2_trigger,
 	.drain = snd_usb_midi_v2_drain,
 };
 
-static const struct snd_rawmidi_ops input_ops = {
-	.open = snd_usb_midi_v2_open,
-	.close = snd_usb_midi_v2_close,
-	.trigger = snd_usb_midi_v2_trigger,
-};
-
 /* create a USB MIDI 2.0 endpoint object */
 static int create_midi2_endpoint(struct snd_usb_midi2_interface *umidi,
 				 struct usb_host_endpoint *hostep,
@@ -729,23 +710,19 @@ static int create_midi2_ump(struct snd_usb_midi2_interface *umidi,
 	umidi->chip->num_rawmidis++;
 
 	ump->private_data = rmidi;
-
-	if (input)
-		snd_rawmidi_set_ops(&ump->core, SNDRV_RAWMIDI_STREAM_INPUT,
-				    &input_ops);
-	if (output)
-		snd_rawmidi_set_ops(&ump->core, SNDRV_RAWMIDI_STREAM_OUTPUT,
-				    &output_ops);
+	ump->ops = &snd_usb_midi_v2_ump_ops;
 
 	rmidi->eps[STR_IN] = ep_in;
 	rmidi->eps[STR_OUT] = ep_out;
 	if (ep_in) {
 		ep_in->pair = ep_out;
 		ep_in->rmidi = rmidi;
+		ep_in->ump = ump;
 	}
 	if (ep_out) {
 		ep_out->pair = ep_in;
 		ep_out->rmidi = rmidi;
+		ep_out->ump = ump;
 	}
 
 	list_add_tail(&rmidi->list, &umidi->rawmidi_list);
-- 
2.35.3

