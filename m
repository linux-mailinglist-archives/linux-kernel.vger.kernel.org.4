Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12363A83C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiK1MZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiK1MZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:25:36 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F6186F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=RNWWEK+RDLZlOOb7mMVxwyBbEJGGGcgM7PpYCOsgTyc=; b=0f
        kMw+g7edeMTG1C7jJsRU1s2XGLSRTXyK0njwmb5WjFBRgpAqR8xAdnJ4k+Pf3i6DgJ5P1yADTZwOU
        GBHxR8muW8O1B/HxjGGk/otFKj23k4z/0iMi5wqxo0b5wzNfOx+L73D1RCTdh3IOycVqE7TZIkpKB
        K0A3BQLUvvPmirrih2jALVeM2zE1Sab8dwEHeLUz58ApnGbZodw/igvDWuHa51lnQO4YIZ2k+nSRJ
        5UJRZVUVL+yK+nfFhinMinckxdf/35fkys0SFbQwqTHXwJqyTGAn8BoIGlbhTSHC8+VwK3b4J99bB
        epnR+7T6dMcKzw8SDpjjCjN5KkI9r+Yg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ozdB3-0006Co-Da;
        Mon, 28 Nov 2022 12:24:02 +0000
From:   John Keeping <john@metanate.com>
To:     alsa-devel@alsa-project.org
Cc:     John Keeping <john@metanate.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add quirk for Tascam Model 12
Date:   Mon, 28 Nov 2022 12:23:52 +0000
Message-Id: <20221128122353.763696-1-john@metanate.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tascam's Model 12 is a mixer which can also operate as a USB audio
interface.  The audio interface uses explicit feedback but it seems that
it does not correctly handle missing isochronous frames.

When injecting an xrun (or doing anything else that pauses the playback
stream) the feedback rate climbs (for example, at 44,100Hz nominal, I
see a stable rate around 44,099 but xrun injection sees this peak at
around 44,135 in most cases) and glitches are heard in the audio stream
for several seconds - this is significantly worse than the single glitch
expected for an underrun.

While the stream does normally recover and the feedback rate returns to
a stable value, I have seen some occurrences where this does not happen
and the rate continues to increase while no audio is heard from the
output.  I have not found a solid reproduction for this.

This misbehaviour can be avoided by totally resetting the stream state
by switching the interface to alt 0 and back before restarting the
playback stream.

Add a new quirk flag which forces the endpoint and interface to be
reconfigured whenever the stream is stopped, and use this for the Tascam
Model 12.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/usb/endpoint.c | 7 +++++++
 sound/usb/quirks.c   | 2 ++
 sound/usb/usbaudio.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 310cd6fb0038..ab248d554774 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1673,6 +1673,13 @@ void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep, bool keep_pending)
 		stop_urbs(ep, false, keep_pending);
 		if (ep->clock_ref)
 			atomic_dec(&ep->clock_ref->locked);
+
+		if (ep->chip->quirk_flags & QUIRK_FLAG_FORCE_IFACE_RESET &&
+		    usb_pipeout(ep->pipe)) {
+			ep->need_setup = true;
+			if (ep->iface_ref)
+				ep->iface_ref->need_setup = true;
+		}
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0f4dd3503a6a..58b37bfc885c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2044,6 +2044,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0644, 0x804a, /* TEAC UD-301 */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_IFACE_DELAY),
+	DEVICE_FLG(0x0644, 0x805f, /* TEAC Model 12 */
+		   QUIRK_FLAG_FORCE_IFACE_RESET),
 	DEVICE_FLG(0x06f8, 0xb000, /* Hercules DJ Console (Windows Edition) */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x06f8, 0xd002, /* Hercules DJ Console (Macintosh Edition) */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index e97141ef730a..2aba508a4831 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -172,6 +172,9 @@ extern bool snd_usb_skip_validation;
  *  Don't apply implicit feedback sync mode
  * QUIRK_FLAG_IFACE_SKIP_CLOSE
  *  Don't closed interface during setting sample rate
+ * QUIRK_FLAG_FORCE_IFACE_RESET
+ *  Force an interface reset whenever stopping & restarting a stream
+ *  (e.g. after xrun)
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -194,5 +197,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_GENERIC_IMPLICIT_FB	(1U << 17)
 #define QUIRK_FLAG_SKIP_IMPLICIT_FB	(1U << 18)
 #define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
+#define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
 
 #endif /* __USBAUDIO_H */
-- 
2.38.1

