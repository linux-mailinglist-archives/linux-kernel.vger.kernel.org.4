Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E370933E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjESJdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjESJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:32:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A101199A
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0F6E1FE4B;
        Fri, 19 May 2023 09:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1TEiSv0o3bNfukbYFt8AXhybPoVqwjpcYPyqBGQTlU=;
        b=t7lu+feEt5qu08v1HxYzhYtAgR26S8XfPKpBY9i2AbGehY1sFLM7RRq20VG586tX+M7K6U
        0dw6GDIbF3s1QmD1tt8+3FsAB4BVK8ykc9ETxp99WiA2/7qXhxZxXm9/oSydnzibrd+ria
        3nC8iJwCLZm+CwXBzK6KEaJZDlxo15Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l1TEiSv0o3bNfukbYFt8AXhybPoVqwjpcYPyqBGQTlU=;
        b=SiGNHPyoOJ4hegNpZQlBYziB2Db4EVTTfePySayMLHwHBrrnYtWgot+/fUzKsQ/R6Np+Jg
        UweSkC+GMZiO1ZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FC6E13A12;
        Fri, 19 May 2023 09:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6CDZHQJCZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:46 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 28/36] ALSA: seq: Add UMP group number to snd_seq_port_info
Date:   Fri, 19 May 2023 11:31:06 +0200
Message-Id: <20230519093114.28813-29-tiwai@suse.de>
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

Add yet more new filed "ump_group" to snd_seq_port_info for specifying
the associated UMP Group number for each sequencer port.  This will be
referred in the upcoming automatic UMP conversion in sequencer core.

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
index 3734e6352f5e..6926e14055f3 100644
--- a/sound/core/seq/seq_ports.c
+++ b/sound/core/seq/seq_ports.c
@@ -357,8 +357,12 @@ int snd_seq_set_port_info(struct snd_seq_client_port * port,
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
@@ -404,8 +408,9 @@ int snd_seq_get_port_info(struct snd_seq_client_port * port,
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

