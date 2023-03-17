Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BEB6BF1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCQTwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCQTwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:52:46 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37691714
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=WMRMW29s9nOaMfP2biYXwZDcUwXYbo2yYgouF2jc1Vo=; b=Bj
        fN6g0PhfTM4vzqmTfbkfbg7O0909IYYyF09Boh7IFtKJobke6zESAOEhA6gRjUiFH7S/8rbFCoWGh
        TCzSRlJBE0w24cuZ6M6KhIulMJ22fm9yn2vSCnouEci+r2Ugkp8YFH+1dlpPlobg6BDnomta6su5X
        z7TyexeNpIklJ/vXXbQLQ7CmTTGDFN2zSH3gTkFUjluvobjMmW5RV74QRcCWC77O2OHGNwuR6t6MA
        +lQ/SH10NAHsfnOWVFFGYYYYf52/499AiwqMcW/eKTgcrpKQvegvJ8cNB+b+caI+WxoOigmzItrGk
        xKle75lA8JZJetsHLviWyNjXQO+3rHWw==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pdG6u-00008O-4s;
        Fri, 17 Mar 2023 19:51:33 +0000
From:   John Keeping <john@metanate.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     John Keeping <john@metanate.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Fix recursive locking on XRUN
Date:   Fri, 17 Mar 2023 19:51:27 +0000
Message-Id: <20230317195128.3911155-1-john@metanate.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_usb_queue_pending_output_urbs() may be called from
snd_pcm_ops::ack() which means the PCM stream is locked.

For the normal case where the call back into the PCM core is via
prepare_output_urb() the "_under_stream_lock" variant of
snd_pcm_period_elapsed() is called, but when an error occurs and the
stream is stopped as XRUN then snd_pcm_xrun() tries to recursively lock
the stream which results in deadlock.

Follow the example of snd_pcm_period_elapsed() by adding
snd_pcm_xrun_under_stream_lock() and use this when the PCM substream
lock is already held.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/sound/pcm.h     |  1 +
 sound/core/pcm_native.c | 28 ++++++++++++++++++++++++----
 sound/usb/endpoint.c    | 18 +++++++++++-------
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 27040b472a4f..98551907453a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -571,6 +571,7 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
+int snd_pcm_stop_xrun_under_stream_lock(struct snd_pcm_substream *substream);
 int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
 #ifdef CONFIG_PM
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 331380c2438b..617f5dc74df0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1559,24 +1559,44 @@ int snd_pcm_drain_done(struct snd_pcm_substream *substream)
 				     SNDRV_PCM_STATE_SETUP);
 }
 
+/**
+ * snd_pcm_stop_xrun_under_stream_lock - stop the running stream as XRUN under the lock of
+ * 					 the PCM substream.
+ * @substream: the PCM substream instance
+ *
+ * This stops the given running substream (and all linked substreams) as XRUN.
+ * This function assumes that the substream lock is already held.
+ *
+ * Return: Zero if successful, or a negative error core.
+ */
+int snd_pcm_stop_xrun_under_stream_lock(struct snd_pcm_substream *substream)
+{
+	if (substream->runtime && snd_pcm_running(substream))
+		__snd_pcm_xrun(substream);
+
+	return 0;
+}
+
 /**
  * snd_pcm_stop_xrun - stop the running streams as XRUN
  * @substream: the PCM substream instance
  *
+ * This function is similar to ``snd_pcm_stop_xrun_under_stream_lock()`` except that it
+ * acquires the substream lock itself.
+ *
  * This stops the given running substream (and all linked substreams) as XRUN.
- * Unlike snd_pcm_stop(), this function takes the substream lock by itself.
  *
  * Return: Zero if successful, or a negative error code.
  */
 int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
 {
 	unsigned long flags;
+	int ret;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
-	if (substream->runtime && snd_pcm_running(substream))
-		__snd_pcm_xrun(substream);
+	ret = snd_pcm_stop_xrun_under_stream_lock(substream);
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stop_xrun);
 
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 1e0af1179ca8..83a6b6d41374 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -400,13 +400,17 @@ static int prepare_inbound_urb(struct snd_usb_endpoint *ep,
 }
 
 /* notify an error as XRUN to the assigned PCM data substream */
-static void notify_xrun(struct snd_usb_endpoint *ep)
+static void notify_xrun(struct snd_usb_endpoint *ep, bool in_stream_lock)
 {
 	struct snd_usb_substream *data_subs;
 
 	data_subs = READ_ONCE(ep->data_subs);
-	if (data_subs && data_subs->pcm_substream)
-		snd_pcm_stop_xrun(data_subs->pcm_substream);
+	if (data_subs && data_subs->pcm_substream) {
+		if (in_stream_lock)
+			snd_pcm_stop_xrun_under_stream_lock(data_subs->pcm_substream);
+		else
+			snd_pcm_stop_xrun(data_subs->pcm_substream);
+	}
 }
 
 static struct snd_usb_packet_info *
@@ -498,7 +502,7 @@ void snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			if (err == -EAGAIN)
 				push_back_to_ready_list(ep, ctx);
 			else
-				notify_xrun(ep);
+				notify_xrun(ep, in_stream_lock);
 			return;
 		}
 
@@ -507,7 +511,7 @@ void snd_usb_queue_pending_output_urbs(struct snd_usb_endpoint *ep,
 			usb_audio_err(ep->chip,
 				      "Unable to submit urb #%d: %d at %s\n",
 				      ctx->index, err, __func__);
-			notify_xrun(ep);
+			notify_xrun(ep, in_stream_lock);
 			return;
 		}
 
@@ -574,7 +578,7 @@ static void snd_complete_urb(struct urb *urb)
 		return;
 
 	usb_audio_err(ep->chip, "cannot submit urb (err = %d)\n", err);
-	notify_xrun(ep);
+	notify_xrun(ep, false);
 
 exit_clear:
 	clear_bit(ctx->index, &ep->active_mask);
@@ -1762,7 +1766,7 @@ static void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 			usb_audio_err(ep->chip,
 				      "next package FIFO overflow EP 0x%x\n",
 				      ep->ep_num);
-			notify_xrun(ep);
+			notify_xrun(ep, false);
 			return;
 		}
 
-- 
2.40.0

