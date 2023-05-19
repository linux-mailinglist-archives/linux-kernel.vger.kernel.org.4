Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1941709325
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjESJcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjESJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AF1A6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CE2222245;
        Fri, 19 May 2023 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vFcVb0n9Ba9H2O0vv9VgnhDswKpE1tKkK+15sbcO5g=;
        b=jYSAPYfU5amkk6Ym73ZUerWEceuFVsVcQDcr4ldsl06BXKXjqa8pGfDTWdENxVbz+J7Nwo
        O7KC+ASVreEBTRMw0MrgcVJAErEaFfXBf+SGMk0pzqJV/CNudvsC11raS9DlGWJk27pSXB
        5vVDh9IzKJ2BV7rr554yR6XvPQh7IEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vFcVb0n9Ba9H2O0vv9VgnhDswKpE1tKkK+15sbcO5g=;
        b=dwGJw1/q1m548OOzy6hIb0bHt2zR2+QF+hxjZUHsRgyemliMSXvueL6NtAbHeoGhzrzExr
        CiEy1BlHtHXfcrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CE1213A12;
        Fri, 19 May 2023 09:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iAnpEfdBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:35 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/36] ALSA: usb-audio: Get UMP EP name string from USB interface
Date:   Fri, 19 May 2023 11:30:47 +0200
Message-Id: <20230519093114.28813-10-tiwai@suse.de>
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

USB descriptor may provide a nicer name for USB interface, and we may
take it as the UMP Endpoint name.  The UMP EP name is copied as the
rawmidi name, too.

Also, fill the UMP block product_id field from the iSerialNumber
string of the USB device descriptor as a recommended unique id, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 7b4cfbaf2ec0..2ac3f96216bc 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -892,15 +892,39 @@ static int set_altset(struct snd_usb_midi2_interface *umidi)
 				 umidi->hostif->desc.bAlternateSetting);
 }
 
+/* fill UMP Endpoint name string from USB descriptor */
+static void fill_ump_ep_name(struct snd_ump_endpoint *ump,
+			     struct usb_device *dev, int id)
+{
+	usb_string(dev, id, ump->info.name, sizeof(ump->info.name));
+}
+
 /* fill the fallback name string for each rawmidi instance */
 static void set_fallback_rawmidi_names(struct snd_usb_midi2_interface *umidi)
 {
+	struct usb_device *dev = umidi->chip->dev;
 	struct snd_usb_midi2_ump *rmidi;
+	struct snd_ump_endpoint *ump;
 
 	list_for_each_entry(rmidi, &umidi->rawmidi_list, list) {
-		if (!*rmidi->ump->core.name)
-			sprintf(rmidi->ump->core.name, "USB MIDI %d",
-				rmidi->index);
+		ump = rmidi->ump;
+		/* fill UMP EP name from USB descriptors */
+		if (!*ump->info.name && umidi->hostif->desc.iInterface)
+			fill_ump_ep_name(ump, dev, umidi->hostif->desc.iInterface);
+		else if (!*ump->info.name && dev->descriptor.iProduct)
+			fill_ump_ep_name(ump, dev, dev->descriptor.iProduct);
+		/* fill fallback name */
+		if (!*ump->info.name)
+			sprintf(ump->info.name, "USB MIDI %d", rmidi->index);
+		/* copy as rawmidi name if not set */
+		if (!*ump->core.name)
+			strscpy(ump->core.name, ump->info.name,
+				sizeof(ump->core.name));
+		/* use serial number string as unique UMP product id */
+		if (!*ump->info.product_id && dev->descriptor.iSerialNumber)
+			usb_string(dev, dev->descriptor.iSerialNumber,
+				   ump->info.product_id,
+				   sizeof(ump->info.product_id));
 	}
 }
 
-- 
2.35.3

