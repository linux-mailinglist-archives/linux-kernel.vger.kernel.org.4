Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1D70D631
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjEWH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjEWHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A28E79
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E323A218F6;
        Tue, 23 May 2023 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpcAAE3E4+YS/NXc11uNo67NAO9/YDf8hhSiZWIao78=;
        b=aPH7OmYKZu8BQQkdToCuu48NDoKzcKQjlgkw3HNaUK7AIxeKSliXjH9ehE1zUkm/o5pRek
        PlJQTagEc4URt3nlPdwV59STvRB4xeQ/tzIMQohGU1ZpM6SdbEHOo737PZAGFAm2Aq7Hfq
        wJB1s6cuOJ8m9CvFE0lJXTBGi3oI8Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828443;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpcAAE3E4+YS/NXc11uNo67NAO9/YDf8hhSiZWIao78=;
        b=c6k2oPCvgn3Eye7b7y7Caz/kTQVqr43clil4WgHn17wzsGG5Q0mqV/Ae3fFVHYi6MpWdxr
        occ8/bQsThCrkQCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8285113A24;
        Tue, 23 May 2023 07:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mLFHHhtxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:03 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/37] ALSA: ump: Add ioctls to inquiry UMP EP and Block info via control API
Date:   Tue, 23 May 2023 09:53:26 +0200
Message-Id: <20230523075358.9672-6-tiwai@suse.de>
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

It'd be convenient to have ioctls to inquiry the UMP Endpoint and UMP
Block information directly via the control API without opening the
rawmidi interface, just like SNDRV_CTL_IOCTL_RAWMIDI_INFO.

This patch extends the rawmidi ioctl handler to support those; new
ioctls, SNDRV_CTL_IOCTL_UMP_ENDPOINT_INFO and
SNDRV_CTL_IOCTL_UMP_BLOCK_INFO, return the snd_ump_endpoint and
snd_ump_block data that is specified by the device field,
respectively.

Suggested-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h |  2 ++
 sound/core/rawmidi.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1e4a21036109..5c5f41dd4001 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1178,6 +1178,8 @@ struct snd_ctl_tlv {
 #define SNDRV_CTL_IOCTL_RAWMIDI_INFO	_IOWR('U', 0x41, struct snd_rawmidi_info)
 #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
 #define SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE	_IOWR('U', 0x43, int)
+#define SNDRV_CTL_IOCTL_UMP_ENDPOINT_INFO _IOWR('U', 0x44, struct snd_ump_endpoint_info)
+#define SNDRV_CTL_IOCTL_UMP_BLOCK_INFO	_IOWR('U', 0x45, struct snd_ump_block_info)
 #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
 #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
 
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 9936ed282b85..ffb5b58105f4 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1043,6 +1043,28 @@ static int snd_rawmidi_next_device(struct snd_card *card, int __user *argp,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SND_UMP)
+/* inquiry of UMP endpoint and block info via control API */
+static int snd_rawmidi_call_ump_ioctl(struct snd_card *card, int cmd,
+				      void __user *argp)
+{
+	struct snd_ump_endpoint_info __user *info = argp;
+	struct snd_rawmidi *rmidi;
+	int device, ret;
+
+	if (get_user(device, &info->device))
+		return -EFAULT;
+	mutex_lock(&register_mutex);
+	rmidi = snd_rawmidi_search(card, device);
+	if (rmidi && rmidi->ops && rmidi->ops->ioctl)
+		ret = rmidi->ops->ioctl(rmidi, cmd, argp);
+	else
+		ret = -ENXIO;
+	mutex_unlock(&register_mutex);
+	return ret;
+}
+#endif
+
 static int snd_rawmidi_control_ioctl(struct snd_card *card,
 				     struct snd_ctl_file *control,
 				     unsigned int cmd,
@@ -1056,6 +1078,10 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 #if IS_ENABLED(CONFIG_SND_UMP)
 	case SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE:
 		return snd_rawmidi_next_device(card, argp, true);
+	case SNDRV_CTL_IOCTL_UMP_ENDPOINT_INFO:
+		return snd_rawmidi_call_ump_ioctl(card, SNDRV_UMP_IOCTL_ENDPOINT_INFO, argp);
+	case SNDRV_CTL_IOCTL_UMP_BLOCK_INFO:
+		return snd_rawmidi_call_ump_ioctl(card, SNDRV_UMP_IOCTL_BLOCK_INFO, argp);
 #endif
 	case SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE:
 	{
-- 
2.35.3

