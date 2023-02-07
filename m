Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5B68D92F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjBGNUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBGNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:20:47 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F6138
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:20:43 -0800 (PST)
Received: from artemii.localdomain (unknown [46.146.167.102])
        by mail.ispras.ru (Postfix) with ESMTPSA id 90DC140737C3;
        Tue,  7 Feb 2023 13:20:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 90DC140737C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675776041;
        bh=ZZK1zQWHczBYTfcHWVmTRFklrhOXXMWQ9Ao2foZ4w2w=;
        h=From:To:Cc:Subject:Date:From;
        b=mbDorNk/lQUxN4kpiq2AajppHx9MML+u36vBGGDm+GAk+tPOlVWuZmKwxMx3OrzMy
         xEeow1W+zdDhH06CPVdvP5QY6HdKJhVzclR5vNmNXkL58ihS+iDr207+0WbSaAaQ7p
         GgPe53riffi/3W4HhW8HfAye+x3miHebz7QLNll8=
From:   Artemii Karasev <karasev@ispras.ru>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Artemii Karasev <karasev@ispras.ru>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] ALSA: emux: Avoid potential array out-of-bound in snd_emux_xg_control()
Date:   Tue,  7 Feb 2023 18:20:26 +0500
Message-Id: <20230207132026.2870-1-karasev@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_emux_xg_control() can be called with an argument 'param' greater
than size of 'control' array. It may lead to accessing 'control'
array at a wrong index.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artemii Karasev <karasev@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 sound/synth/emux/emux_nrpn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/synth/emux/emux_nrpn.c b/sound/synth/emux/emux_nrpn.c
index 8056422ed7c5..9e6414f78e4b 100644
--- a/sound/synth/emux/emux_nrpn.c
+++ b/sound/synth/emux/emux_nrpn.c
@@ -349,6 +349,9 @@ int
 snd_emux_xg_control(struct snd_emux_port *port, struct snd_midi_channel *chan,
 		    int param)
 {
+	if (param >= ARRAY_SIZE(chan->control))
+		return -EINVAL;
+
 	return send_converted_effect(xg_effects, ARRAY_SIZE(xg_effects),
 				     port, chan, param,
 				     chan->control[param],
-- 
2.34.1

