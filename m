Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB01470D642
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEWH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjEWHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4FB1B4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30F8921A67;
        Tue, 23 May 2023 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa3pwc1C5HhGxbLR03Hm6eyUQzwJ+yyOfNOAHUZ83fg=;
        b=y1cY/y9BBnkXdpqA9huOH9Pk87lfjP2H1VdxMtHiahqPP3DdE2zkn43/JVpxy4UIRZgFxJ
        G4HgsF9r9jHl6oSeTvNWd6BTeyPwFowKWPrgM2v59cCdylobh6mtWJgK1UoJBG9zdCmRz3
        jMtoVOsGNZjsPQROogmcLfS6+FlbHLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa3pwc1C5HhGxbLR03Hm6eyUQzwJ+yyOfNOAHUZ83fg=;
        b=f4gFMx00Sm+Md8jzCk7Ggm5hQtj3eNjq6UkQcF5hJ2hy7VNTa5zXernYeQ9HfssNmiJUGl
        hYc7kWT8RYOOQkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3F3C13588;
        Tue, 23 May 2023 07:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SFO7NSJxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:10 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/37] ALSA: seq: Add UMP group number to snd_seq_port_info
Date:   Tue, 23 May 2023 09:53:50 +0200
Message-Id: <20230523075358.9672-30-tiwai@suse.de>
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

Add yet more new filed "ump_group" to snd_seq_port_info for specifying
the associated UMP Group number for each sequencer port.  This will be
referred in the upcoming automatic UMP conversion in sequencer core.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h | 3 ++-
 sound/core/seq/seq_ports.c      | 9 +++++++--
 sound/core/seq/seq_ports.h      | 3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index eae1e0b0bf37..2470eaa5edc5 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -478,7 +478,8 @@ struct snd_seq_port_info {
 	unsigned int flags;		/* misc. conditioning */
 	unsigned char time_queue;	/* queue # for timestamping */
 	unsigned char direction;	/* port usage direction (r/w/bidir) */
-	char reserved[58];		/* for future use */
+	unsigned char ump_group;	/* 0 = UMP EP (no conversion), 1-16 = UMP group number */
+	char reserved[57];		/* for future use */
 };
 
 
diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
index 5574341f49eb..9b80f8275026 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -356,8 +356,12 @@ int snd_seq_set_port_info(struct snd_seq_client_port * port,
 	port->time_real = (info->flags & SNDRV_SEQ_PORT_FLG_TIME_REAL) ? 1 : 0;
 	port->time_queue = info->time_queue;
 
-	/* direction */
+	/* UMP direction and group */
 	port->direction = info->direction;
+	port->ump_group = info->ump_group;
+	if (port->ump_group > SNDRV_UMP_MAX_GROUPS)
+		port->ump_group = 0;
+
 	/* fill default port direction */
 	if (!port->direction) {
 		if (info->capability & SNDRV_SEQ_PORT_CAP_READ)
@@ -403,8 +407,9 @@ int snd_seq_get_port_info(struct snd_seq_client_port * port,
 		info->time_queue = port->time_queue;
 	}
 
-	/* direction */
+	/* UMP direction and group */
 	info->direction = port->direction;
+	info->ump_group = port->ump_group;
 
 	return 0;
 }
diff --git a/sound/core/seq/seq_ports.h b/sound/core/seq/seq_ports.h
index dce733ab2398..c6c138edceab 100644
--- a/sound/core/seq/seq_ports.h
+++ b/sound/core/seq/seq_ports.h
@@ -72,8 +72,9 @@ struct snd_seq_client_port {
 	int midi_voices;
 	int synth_voices;
 		
-	/* direction */
+	/* UMP direction and group */
 	unsigned char direction;
+	unsigned char ump_group;
 };
 
 struct snd_seq_client;
-- 
2.35.3

