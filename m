Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672FD6069CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJTUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJTUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:47:33 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01835170448
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:47:20 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olcR3-0007Ue-TS; Thu, 20 Oct 2022 22:46:37 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ALSA: control: add snd_ctl_rename()
Date:   Thu, 20 Oct 2022 22:46:21 +0200
Message-Id: <4170b71117ea81357a4f7eb8410f7cde20836c70.1666296963.git.maciej.szmigiero@oracle.com>
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

Add a snd_ctl_rename() function that takes care of updating the control
hash entries for callers that already have the relevant struct snd_kcontrol
at hand and hold the control write lock (or simply haven't registered the
card yet).

Fixes: c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 include/sound/control.h |  1 +
 sound/core/control.c    | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/control.h b/include/sound/control.h
index eae443ba79ba5..cc3dcc6cfb0f2 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -138,6 +138,7 @@ int snd_ctl_remove(struct snd_card * card, struct snd_kcontrol * kcontrol);
 int snd_ctl_replace(struct snd_card *card, struct snd_kcontrol *kcontrol, bool add_on_replace);
 int snd_ctl_remove_id(struct snd_card * card, struct snd_ctl_elem_id *id);
 int snd_ctl_rename_id(struct snd_card * card, struct snd_ctl_elem_id *src_id, struct snd_ctl_elem_id *dst_id);
+void snd_ctl_rename(struct snd_card *card, struct snd_kcontrol *kctl, const char *name);
 int snd_ctl_activate_id(struct snd_card *card, struct snd_ctl_elem_id *id, int active);
 struct snd_kcontrol *snd_ctl_find_numid(struct snd_card * card, unsigned int numid);
 struct snd_kcontrol *snd_ctl_find_id(struct snd_card * card, struct snd_ctl_elem_id *id);
diff --git a/sound/core/control.c b/sound/core/control.c
index a7271927d875f..50e7ba66f1876 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -753,6 +753,29 @@ int snd_ctl_rename_id(struct snd_card *card, struct snd_ctl_elem_id *src_id,
 }
 EXPORT_SYMBOL(snd_ctl_rename_id);
 
+/**
+ * snd_ctl_rename - rename the control on the card
+ * @card: the card instance
+ * @kctl: the control to rename
+ * @name: the new name
+ *
+ * Renames the specified control on the card to the new name.
+ *
+ * Make sure to take the control write lock - down_write(&card->controls_rwsem).
+ */
+void snd_ctl_rename(struct snd_card *card, struct snd_kcontrol *kctl,
+		    const char *name)
+{
+	remove_hash_entries(card, kctl);
+
+	if (strscpy(kctl->id.name, name, sizeof(kctl->id.name)) < 0)
+		pr_warn("ALSA: Renamed control new name '%s' truncated to '%s'\n",
+			name, kctl->id.name);
+
+	add_hash_entries(card, kctl);
+}
+EXPORT_SYMBOL(snd_ctl_rename);
+
 #ifndef CONFIG_SND_CTL_FAST_LOOKUP
 static struct snd_kcontrol *
 snd_ctl_find_numid_slow(struct snd_card *card, unsigned int numid)
