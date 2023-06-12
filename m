Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4572B9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFLILz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjFLILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646F170B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84E5F20488;
        Mon, 12 Jun 2023 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wy55YqLCeSe3EZduBTyhl4afgk45rbKUhrCZNvDKi10=;
        b=BvQvCPJkbnJzqa/L7vHEK5tbiraToFmmOqK73lyrB05HXQZRg74dd6/7xh4m010xazDL5S
        ZHZ81p4x3OF5PBaafD5tqi7GzXaNmWRjZbB7PrE8P3yV/yRAuqoI4Bdyy76RVIB88W0O9u
        8NpVISUcK4aMn1+2Qfq+bWSOWGjm54s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wy55YqLCeSe3EZduBTyhl4afgk45rbKUhrCZNvDKi10=;
        b=TpuiVNktfQB5h/primn0ugsehUY7Satk4q+BC3reLGS3Sn4sC/Jv1HLJDDzUMN6zsMweC7
        d/lqnH+yu+d0ilBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 620BF138EC;
        Mon, 12 Jun 2023 08:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uJggFhrThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:06 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ALSA: usb-audio: Add midi2_ump_probe option
Date:   Mon, 12 Jun 2023 10:10:48 +0200
Message-Id: <20230612081054.17200-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612081054.17200-1-tiwai@suse.de>
References: <20230612081054.17200-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new option to enable/disable the UMP Endpoint probing.
Some firmware seems screwed up when such a new command issued, and
this option allows user to suppress it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index fad094e15999..13fa1978267a 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -27,6 +27,10 @@ static bool midi2_enable = true;
 module_param(midi2_enable, bool, 0444);
 MODULE_PARM_DESC(midi2_enable, "Enable MIDI 2.0 support.");
 
+static bool midi2_ump_probe = true;
+module_param(midi2_ump_probe, bool, 0444);
+MODULE_PARM_DESC(midi2_ump_probe, "Probe UMP v1.1 support at first.");
+
 /* stream direction; just shorter names */
 enum {
 	STR_OUT = SNDRV_RAWMIDI_STREAM_OUTPUT,
@@ -1136,10 +1140,12 @@ int snd_usb_midi_v2_create(struct snd_usb_audio *chip,
 		goto error;
 	}
 
-	err = parse_ump_endpoints(umidi);
-	if (err < 0) {
-		usb_audio_err(chip, "Failed to parse UMP endpoint\n");
-		goto error;
+	if (midi2_ump_probe) {
+		err = parse_ump_endpoints(umidi);
+		if (err < 0) {
+			usb_audio_err(chip, "Failed to parse UMP endpoint\n");
+			goto error;
+		}
 	}
 
 	err = create_blocks_from_gtb(umidi);
-- 
2.35.3

