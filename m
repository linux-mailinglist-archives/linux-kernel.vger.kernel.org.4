Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D223709324
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjESJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjESJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF319A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 306C9222AD;
        Fri, 19 May 2023 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpltZXyn7IFUsWYubb3YXnbYdNZhgEiIMwEl6o8+pfI=;
        b=XHlsMepz9Ecz5V3B5jMYmkMAhmrpWcTfpzRCSnLhpsK52nMLN4v/exslyBR4xYO5WBZ1oa
        XYtp1dHj53CyNtaBWTSRUWu6I3E4B2sB78mqY2M5tL9/MXyIw7NwsgizZGTEAG2QkKNpx0
        rhFEXW/1l8YJZigqMFZShcRdIDIbzWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HpltZXyn7IFUsWYubb3YXnbYdNZhgEiIMwEl6o8+pfI=;
        b=fpkqDSsCF6U/EotfWEZ2rlrvzm2cr5QeZMRvJe2C5H4t5OH817O1OMas25Z0AgDEP65Te+
        j/os724xbF0dw3DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E93713A12;
        Fri, 19 May 2023 09:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFO6APhBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:36 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/36] ALSA: usb-audio: Trim superfluous "MIDI" suffix from UMP EP name
Date:   Fri, 19 May 2023 11:30:48 +0200
Message-Id: <20230519093114.28813-11-tiwai@suse.de>
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

A single USB audio device may have multiple interfaces for different
purposes (e.g. audio, MIDI and HID), where the iInterface descriptor
of each interface may contain an own suffix, e.g. "MIDI" for a MIDI
interface.  as such a suffix is superfluous as a rawmidi and UMP
Endpoint name, this patch trims the superfluous "MIDI" suffix from the
name string.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 2ac3f96216bc..790e4cd5d35c 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -896,7 +896,14 @@ static int set_altset(struct snd_usb_midi2_interface *umidi)
 static void fill_ump_ep_name(struct snd_ump_endpoint *ump,
 			     struct usb_device *dev, int id)
 {
+	int len;
+
 	usb_string(dev, id, ump->info.name, sizeof(ump->info.name));
+
+	/* trim superfluous "MIDI" suffix */
+	len = strlen(ump->info.name);
+	if (len > 5 && !strcmp(ump->info.name + len - 5, " MIDI"))
+		ump->info.name[len - 5] = 0;
 }
 
 /* fill the fallback name string for each rawmidi instance */
-- 
2.35.3

