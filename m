Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826E6069CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJTUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJTUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:47:38 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5521F96D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:47:26 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olcRE-0007V3-Jm; Thu, 20 Oct 2022 22:46:48 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ALSA: hda/realtek: Use snd_ctl_rename() to rename a control
Date:   Thu, 20 Oct 2022 22:46:23 +0200
Message-Id: <37496bd80f91f373268148f877fd735917d97287.1666296963.git.maciej.szmigiero@oracle.com>
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

Fixes: c27e1efb61c5 ("ALSA: control: Use xarray for faster lookups")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 79acd2a2caf20..9945861f02efa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2142,7 +2142,7 @@ static void rename_ctl(struct hda_codec *codec, const char *oldname,
 
 	kctl = snd_hda_find_mixer_ctl(codec, oldname);
 	if (kctl)
-		strcpy(kctl->id.name, newname);
+		snd_ctl_rename(codec->card, kctl, newname);
 }
 
 static void alc1220_fixup_gb_dual_codecs(struct hda_codec *codec,
