Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFD16069D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJTUsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJTUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:47:53 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD6F1B2338
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:47:36 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olcRU-0007Vc-JN; Thu, 20 Oct 2022 22:47:04 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ALSA: ac97: Use snd_ctl_rename() to rename a control
Date:   Thu, 20 Oct 2022 22:46:26 +0200
Message-Id: <adb68bfa0885ba4a2583794b828f8e20d23f67c7.1666296963.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666296963.git.maciej.szmigiero@oracle.com>
References: <cover.1666296963.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

With the recent addition of hashed controls lookup it's not enough to just
update the control name field, the hash entries for the modified control
have to be updated too.

snd_ctl_rename() takes care of that, so use it instead of directly
modifying the control name.

While we are at it, check also that the new control name doesn't
accidentally overwrite the available buffer space.

Fixes: c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 sound/pci/ac97/ac97_codec.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index ceead55f13ab1..ff685321f1a11 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2656,11 +2656,18 @@ EXPORT_SYMBOL(snd_ac97_resume);
  */
 static void set_ctl_name(char *dst, const char *src, const char *suffix)
 {
-	if (suffix)
-		sprintf(dst, "%s %s", src, suffix);
-	else
-		strcpy(dst, src);
-}	
+	const size_t msize = SNDRV_CTL_ELEM_ID_NAME_MAXLEN;
+
+	if (suffix) {
+		if (snprintf(dst, msize, "%s %s", src, suffix) >= msize)
+			pr_warn("ALSA: AC97 control name '%s %s' truncated to '%s'\n",
+				src, suffix, dst);
+	} else {
+		if (strscpy(dst, src, msize) < 0)
+			pr_warn("ALSA: AC97 control name '%s' truncated to '%s'\n",
+				src, dst);
+	}
+}
 
 /* remove the control with the given name and optional suffix */
 static int snd_ac97_remove_ctl(struct snd_ac97 *ac97, const char *name,
@@ -2687,8 +2694,11 @@ static int snd_ac97_rename_ctl(struct snd_ac97 *ac97, const char *src,
 			       const char *dst, const char *suffix)
 {
 	struct snd_kcontrol *kctl = ctl_find(ac97, src, suffix);
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
 	if (kctl) {
-		set_ctl_name(kctl->id.name, dst, suffix);
+		set_ctl_name(name, dst, suffix);
+		snd_ctl_rename(ac97->bus->card, kctl, name);
 		return 0;
 	}
 	return -ENOENT;
@@ -2707,11 +2717,17 @@ static int snd_ac97_swap_ctl(struct snd_ac97 *ac97, const char *s1,
 			     const char *s2, const char *suffix)
 {
 	struct snd_kcontrol *kctl1, *kctl2;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
 	kctl1 = ctl_find(ac97, s1, suffix);
 	kctl2 = ctl_find(ac97, s2, suffix);
 	if (kctl1 && kctl2) {
-		set_ctl_name(kctl1->id.name, s2, suffix);
-		set_ctl_name(kctl2->id.name, s1, suffix);
+		set_ctl_name(name, s2, suffix);
+		snd_ctl_rename(ac97->bus->card, kctl1, name);
+
+		set_ctl_name(name, s1, suffix);
+		snd_ctl_rename(ac97->bus->card, kctl2, name);
+
 		return 0;
 	}
 	return -ENOENT;
