Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D79F70D639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjEWH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjEWHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBAE4F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD4132040E;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QYHzLsbn2lpr2akas3+UD3Ro0HbP/pTE0k8rJDQSZY=;
        b=XH6OPh1/8l601VL4QEe9KcM0UukyxU8GDgO8ThQPl9l/VilscRZCNqZtCl5sZVSV9yvpev
        lFGBxz9QlfOLqCGN2SEYRSWSI/w5Bry1lyJQBm7TAoZDC0queV2v7mna8MzEOk/SB04Vw5
        idfb09diPpFISDmZNjhoD6w1EMv+QgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QYHzLsbn2lpr2akas3+UD3Ro0HbP/pTE0k8rJDQSZY=;
        b=hqpuVHhamcbJEVopAg9z6Ffv5KticZFXHt8jsEawbZd9xTx2G4BPAAH33fQONl3T/1fBzI
        krjrybFsK5rWe2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66D0013588;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aAlBFh9xbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:07 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/37] ALSA: usb-audio: Inform inconsistent protocols in GTBs
Date:   Tue, 23 May 2023 09:53:37 +0200
Message-Id: <20230523075358.9672-17-tiwai@suse.de>
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

When parsing Group Terminal Blocks, we overwrote the preferred
protocol and the protocol capabilities silently from the last parsed
GTB.  This patch adds the information print indicating the unexpected
overrides instead of silent action.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index f3fba8b07cb3..341783418a6a 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -581,6 +581,7 @@ static int parse_group_terminal_block(struct snd_usb_midi2_ump *rmidi,
 				      const struct usb_ms20_gr_trm_block_descriptor *desc)
 {
 	struct snd_ump_endpoint *ump = rmidi->ump;
+	unsigned int protocol, protocol_caps;
 
 	/* set default protocol */
 	switch (desc->bMIDIProtocol) {
@@ -588,24 +589,40 @@ static int parse_group_terminal_block(struct snd_usb_midi2_ump *rmidi,
 	case USB_MS_MIDI_PROTO_1_0_64_JRTS:
 	case USB_MS_MIDI_PROTO_1_0_128:
 	case USB_MS_MIDI_PROTO_1_0_128_JRTS:
-		ump->info.protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI1;
+		protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI1;
 		break;
 	case USB_MS_MIDI_PROTO_2_0:
 	case USB_MS_MIDI_PROTO_2_0_JRTS:
-		ump->info.protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI2;
+		protocol = SNDRV_UMP_EP_INFO_PROTO_MIDI2;
 		break;
+	default:
+		return 0;
 	}
 
-	ump->info.protocol_caps = ump->info.protocol;
+	if (ump->info.protocol && ump->info.protocol != protocol)
+		usb_audio_info(rmidi->umidi->chip,
+			       "Overriding preferred MIDI protocol in GTB %d: %x -> %x\n",
+			       rmidi->usb_block_id, ump->info.protocol,
+			       protocol);
+	ump->info.protocol = protocol;
+
+	protocol_caps = protocol;
 	switch (desc->bMIDIProtocol) {
 	case USB_MS_MIDI_PROTO_1_0_64_JRTS:
 	case USB_MS_MIDI_PROTO_1_0_128_JRTS:
 	case USB_MS_MIDI_PROTO_2_0_JRTS:
-		ump->info.protocol_caps |= SNDRV_UMP_EP_INFO_PROTO_JRTS_TX |
+		protocol_caps |= SNDRV_UMP_EP_INFO_PROTO_JRTS_TX |
 			SNDRV_UMP_EP_INFO_PROTO_JRTS_RX;
 		break;
 	}
 
+	if (ump->info.protocol_caps && ump->info.protocol_caps != protocol_caps)
+		usb_audio_info(rmidi->umidi->chip,
+			       "Overriding MIDI protocol caps in GTB %d: %x -> %x\n",
+			       rmidi->usb_block_id, ump->info.protocol_caps,
+			       protocol_caps);
+	ump->info.protocol_caps = protocol_caps;
+
 	return 0;
 }
 
-- 
2.35.3

