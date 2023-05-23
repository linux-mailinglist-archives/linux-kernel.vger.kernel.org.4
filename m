Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745F70D64A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjEWH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjEWHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814918D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FFBD2040A;
        Tue, 23 May 2023 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVKMfmKZD+HwascEjydzIHk2mo8oo1vs9MeGSXjDJ5A=;
        b=c+GvQ5bhnqvqd1Rmub7KpN893zt17bAwZReyt2r3o78J0tHEAh/JQtAHFna7M9p7DmLH0w
        UtQw8x4aKR9eCqvQEmtO4Q9YWymswUzwXurWSn78/k5IGf424rS2Zi0vcjnHvpteGxSZsi
        vf6tiEeEYKQQ/i0Ce7J5vH8wAYVgyzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVKMfmKZD+HwascEjydzIHk2mo8oo1vs9MeGSXjDJ5A=;
        b=iq20Bz5jE44WbLBxUdE3iXKccn+VduVi1q1srrt8z65FH3j0mZhdlZP2E+S7TFyxteznrx
        u8hXBtLi0CpjdJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC60E13A1A;
        Tue, 23 May 2023 07:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4AGvLR1xbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:05 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/37] ALSA: usb-audio: Trim superfluous "MIDI" suffix from UMP EP name
Date:   Tue, 23 May 2023 09:53:32 +0200
Message-Id: <20230523075358.9672-12-tiwai@suse.de>
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

A single USB audio device may have multiple interfaces for different
purposes (e.g. audio, MIDI and HID), where the iInterface descriptor
of each interface may contain an own suffix, e.g. "MIDI" for a MIDI
interface.  as such a suffix is superfluous as a rawmidi and UMP
Endpoint name, this patch trims the superfluous "MIDI" suffix from the
name string.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
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

