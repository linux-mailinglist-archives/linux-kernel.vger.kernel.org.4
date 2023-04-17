Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAE6E3F13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDQFl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQFlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:41:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4B10D2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 22:41:52 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oHcbphe3Z7JnhoHcbpmzfe; Mon, 17 Apr 2023 07:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681710110;
        bh=sEYIqrDOhNyLMdiTxKCtoht7+kSYTCD6ktbTcZil0+w=;
        h=From:To:Cc:Subject:Date;
        b=h2icvuNGfnX0QFaJHHSig4FFCB1cMfbshNi5NVWSETKCWjW7O0rhH0azthFF/3hkw
         axbW6bIUYO+SF1H2FyEhzrK++EBFeXGh6U1SQOD/dY3EqdS6+CxIwDJJEgg9Di0mN2
         nGGnN7Sa4doqgnfNtRe1bFDO0odjWP3mAgWSoUdLPLh4bwW+tHW3uOXcHiwtnsgHkD
         sh4ll6TNiyPjV7s47pFc7seP9HdZvUEhQCZcO01FjlB8gOL4AmMUfxNEFqN7ua3ILT
         aGp5uz3PPjwfl+aUdL12Mpm7C15qj5BGbINA33NSqMprWi4kabhMLhTQALl7vbqdai
         xKGyt5f0R1GVA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 07:41:50 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda/hdmi: Remove some dead code
Date:   Mon, 17 Apr 2023 07:41:48 +0200
Message-Id: <91a31341f32d493bcc6c4515178ce0755ac1aa70.1681710069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These snd_BUG_ON() can never trigger, so just remove them to save a few
LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative. Maybe the other "if"s should be removed and the
error code returned instead.

I chose to remove these ones and the corresponding error code, because it
seems that it is already handled this way in hdmi_pcm_open().

I don't know the code enough, so it is only my guess.

Review with care :)
---
 sound/pci/hda/patch_hdmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5c6980394dce..ee051bdfaff6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2104,10 +2104,6 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 		goto unlock;
 	}
 
-	if (snd_BUG_ON(pin_idx < 0)) {
-		err = -EINVAL;
-		goto unlock;
-	}
 	per_pin = get_pin(spec, pin_idx);
 
 	/* Verify pin:cvt selections to avoid silent audio after S3.
@@ -2199,13 +2195,13 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 		clear_bit(pcm_idx, &spec->pcm_in_use);
 		pin_idx = hinfo_to_pin_index(codec, hinfo);
+		/*
+		 * In such a case, return 0 to match the behavior in
+		 * hdmi_pcm_open()
+		 */
 		if (pin_idx < 0)
 			goto unlock;
 
-		if (snd_BUG_ON(pin_idx < 0)) {
-			err = -EINVAL;
-			goto unlock;
-		}
 		per_pin = get_pin(spec, pin_idx);
 
 		if (spec->dyn_pin_out) {
-- 
2.34.1

