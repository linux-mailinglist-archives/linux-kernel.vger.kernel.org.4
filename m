Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2986696B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjAMMON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbjAMMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:13:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182EEE27
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:07:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D14825FF75;
        Fri, 13 Jan 2023 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673611675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xD16Js7PjyhlXXLl/CZgEDiokWkf0dZnCNfUVKSJtLY=;
        b=GCna90ZRCnwhxdBNWxy2C15XFOnifoMZ9zma2AOkoEQc1+a69Kyt18LltATNTTDA4aNy1X
        YUXugM4oGbtYR06Bu6EdAO1hKWNKi40byFT4LEe/bRI+vgczJvHTdiu+wVmzeNJzbh8GO7
        pXAFgsckrpmgAWUPbtMWTb5OlynthqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673611675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xD16Js7PjyhlXXLl/CZgEDiokWkf0dZnCNfUVKSJtLY=;
        b=yrzNNSZ/e976JOXfqS+shbPUtVh3IerCzWT5QJupYnKYO+OjVkYM9gVa5N9lAovAB8L3s7
        PsLyggucz77Zg3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE2CE1358A;
        Fri, 13 Jan 2023 12:07:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJ2nKZtJwWOBSgAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 13 Jan 2023 12:07:55 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Clement Lecigne <clecigne@google.com>
Subject: [PATCH] ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF
Date:   Fri, 13 Jan 2023 13:07:45 +0100
Message-Id: <20230113120745.25464-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Lecigne <clecigne@google.com>

Takes rwsem lock inside snd_ctl_elem_read instead of snd_ctl_elem_read_user
like it was done for write in commit 1fa4445f9adf1 ("ALSA: control - introduce
snd_ctl_notify_one() helper"). Doing this way we are also fixing the following
locking issue happening in the compat path which can be easily triggered and
turned into an use-after-free.

64-bits:
snd_ctl_ioctl
  snd_ctl_elem_read_user
    [takes controls_rwsem]
    snd_ctl_elem_read [lock properly held, all good]
    [drops controls_rwsem]

32-bits:
snd_ctl_ioctl_compat
  snd_ctl_elem_write_read_compat
    ctl_elem_write_read
      snd_ctl_elem_read [missing lock, not good]

CVE-2023-0266 was assigned for this issue.

Cc: stable@kernel.org # 5.13+
Signed-off-by: Clement Lecigne <clecigne@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Note: the fixes for older stable trees will be submitted in another patch

 sound/core/control.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 50e7ba66f187..82aa1af1d1d8 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1203,14 +1203,19 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	const u32 pattern = 0xdeadbeef;
 	int ret;
 
+	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL)
-		return -ENOENT;
+	if (kctl == NULL) {
+		ret = -ENOENT;
+		goto unlock;
+	}
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL)
-		return -EPERM;
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL) {
+		ret = -EPERM;
+		goto unlock;
+	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
 
@@ -1220,7 +1225,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	info.id = control->id;
 	ret = __snd_ctl_elem_info(card, kctl, &info, NULL);
 	if (ret < 0)
-		return ret;
+		goto unlock;
 #endif
 
 	if (!snd_ctl_skip_validation(&info))
@@ -1230,7 +1235,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 		ret = kctl->get(kctl, control);
 	snd_power_unref(card);
 	if (ret < 0)
-		return ret;
+		goto unlock;
 	if (!snd_ctl_skip_validation(&info) &&
 	    sanity_check_elem_value(card, control, &info, pattern) < 0) {
 		dev_err(card->dev,
@@ -1238,8 +1243,11 @@ static int snd_ctl_elem_read(struct snd_card *card,
 			control->id.iface, control->id.device,
 			control->id.subdevice, control->id.name,
 			control->id.index);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock;
 	}
+unlock:
+	up_read(&card->controls_rwsem);
 	return ret;
 }
 
@@ -1253,9 +1261,7 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(control);
 
-	down_read(&card->controls_rwsem);
 	result = snd_ctl_elem_read(card, control);
-	up_read(&card->controls_rwsem);
 	if (result < 0)
 		goto error;
 
-- 
2.35.3

