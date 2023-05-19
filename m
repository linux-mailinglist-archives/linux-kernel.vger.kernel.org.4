Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8A70931D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjESJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjESJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7952A19A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A50E222CF;
        Fri, 19 May 2023 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrvZBp3duWzOF/YKdFpWaRkynnXU2qOujSPsuLV9yfY=;
        b=lqHWSIdl/8hQndJ+5qg94TmjWd5gN6NM+ArmNHBw0UHF1SSmqlp9BeUY6h2TJQqEUQzoF0
        NwL/nfm7fq/ZBYX2HTZlgw6HfxJ2XCD99PBF0f2U+aNlyaAuLhSXPHNlHZ5+kp+Zo8diB3
        WQhLj44eMwdbmUmE8dZ2xQNSy2ByR0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrvZBp3duWzOF/YKdFpWaRkynnXU2qOujSPsuLV9yfY=;
        b=chulj10akq9lW2XPP+dGPLfacHRdue/4BSCyNM7gXSoO43HyVw/MQCJWusChrDnmxu5Fz8
        jMH+nM7mUmw/XXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CBC813A12;
        Fri, 19 May 2023 09:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CGAtBvRBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:32 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/36] ALSA: rawmidi: Skip UMP devices at SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE
Date:   Fri, 19 May 2023 11:30:42 +0200
Message-Id: <20230519093114.28813-5-tiwai@suse.de>
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

Applications may look for rawmidi devices with the ioctl
SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE.  Returning a UMP device from this
ioctl may confuse the existing applications that support only the
legacy rawmidi.

This patch changes the code to skip the UMP devices from the lookup
for avoiding the confusion, and introduces a new ioctl to look for the
UMP devices instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h |  1 +
 sound/core/rawmidi.c        | 57 +++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index b001df4b335e..74bd2c297741 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1177,6 +1177,7 @@ struct snd_ctl_tlv {
 #define SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE _IOWR('U', 0x40, int)
 #define SNDRV_CTL_IOCTL_RAWMIDI_INFO	_IOWR('U', 0x41, struct snd_rawmidi_info)
 #define SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE _IOW('U', 0x42, int)
+#define SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE	_IOWR('U', 0x43, int)
 #define SNDRV_CTL_IOCTL_POWER		_IOWR('U', 0xd0, int)
 #define SNDRV_CTL_IOCTL_POWER_STATE	_IOR('U', 0xd1, int)
 
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index ef478fcacb42..88595f54be79 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1011,6 +1011,37 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 	return -ENOTTY;
 }
 
+/* ioctl to find the next device; either legacy or UMP depending on @find_ump */
+static int snd_rawmidi_next_device(struct snd_card *card, int __user *argp,
+				   bool find_ump)
+
+{
+	struct snd_rawmidi *rmidi;
+	int device;
+	bool is_ump;
+
+	if (get_user(device, argp))
+		return -EFAULT;
+	if (device >= SNDRV_RAWMIDI_DEVICES) /* next device is -1 */
+		device = SNDRV_RAWMIDI_DEVICES - 1;
+	mutex_lock(&register_mutex);
+	device = device < 0 ? 0 : device + 1;
+	for (; device < SNDRV_RAWMIDI_DEVICES; device++) {
+		rmidi = snd_rawmidi_search(card, device);
+		if (!rmidi)
+			continue;
+		is_ump = rawmidi_is_ump(rmidi);
+		if (find_ump == is_ump)
+			break;
+	}
+	if (device == SNDRV_RAWMIDI_DEVICES)
+		device = -1;
+	mutex_unlock(&register_mutex);
+	if (put_user(device, argp))
+		return -EFAULT;
+	return 0;
+}
+
 static int snd_rawmidi_control_ioctl(struct snd_card *card,
 				     struct snd_ctl_file *control,
 				     unsigned int cmd,
@@ -1020,27 +1051,11 @@ static int snd_rawmidi_control_ioctl(struct snd_card *card,
 
 	switch (cmd) {
 	case SNDRV_CTL_IOCTL_RAWMIDI_NEXT_DEVICE:
-	{
-		int device;
-
-		if (get_user(device, (int __user *)argp))
-			return -EFAULT;
-		if (device >= SNDRV_RAWMIDI_DEVICES) /* next device is -1 */
-			device = SNDRV_RAWMIDI_DEVICES - 1;
-		mutex_lock(&register_mutex);
-		device = device < 0 ? 0 : device + 1;
-		while (device < SNDRV_RAWMIDI_DEVICES) {
-			if (snd_rawmidi_search(card, device))
-				break;
-			device++;
-		}
-		if (device == SNDRV_RAWMIDI_DEVICES)
-			device = -1;
-		mutex_unlock(&register_mutex);
-		if (put_user(device, (int __user *)argp))
-			return -EFAULT;
-		return 0;
-	}
+		return snd_rawmidi_next_device(card, argp, false);
+#if IS_ENABLED(CONFIG_SND_UMP)
+	case SNDRV_CTL_IOCTL_UMP_NEXT_DEVICE:
+		return snd_rawmidi_next_device(card, argp, true);
+#endif
 	case SNDRV_CTL_IOCTL_RAWMIDI_PREFER_SUBDEVICE:
 	{
 		int val;
-- 
2.35.3

