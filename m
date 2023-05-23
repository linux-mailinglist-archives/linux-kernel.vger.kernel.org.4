Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1070D646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjEWH5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjEWH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0EE72
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC19320419;
        Tue, 23 May 2023 07:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykdvugQv+oZ0dN/zBeueH0+m1vWwSeY55CmWxWBpKkQ=;
        b=ARpDM/TBwSXQiycNQBz8hKHuHb92rcfPQ4LmW+XtGPLMju2hHKZuerq0ArzUEu/wkH0On6
        kg0adST4gJ+1PzNanwaofF2Y2HPNlWZDT4O2hWS551F62QNIKdqqqi0xKq/r81t/XuWjeW
        xiN//PdNRobBDYCxiOKLPA69fV8KMmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828451;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykdvugQv+oZ0dN/zBeueH0+m1vWwSeY55CmWxWBpKkQ=;
        b=VZSR6WqSRhuVMani4T+Nwr2jKD1+MrUL4TfAdpfEk7EwgZvcgCg7DVFnuXh1FIhoTYh1y4
        KGBqetoVcO670CDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F85213588;
        Tue, 23 May 2023 07:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8LniHSNxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:11 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/37] ALSA: seq: Allow suppressing UMP conversions
Date:   Tue, 23 May 2023 09:53:52 +0200
Message-Id: <20230523075358.9672-32-tiwai@suse.de>
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

A sequencer client like seq_dummy rather doesn't want to convert UMP
events but receives / sends as is.  Add a new event filter flag to
suppress the automatic UMP conversion and applies accordingly.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h |  1 +
 sound/core/seq/seq_clientmgr.c  | 18 ++++++++++--------
 sound/core/seq/seq_dummy.c      |  8 ++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 2470eaa5edc5..c4632bd9d3a0 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -347,6 +347,7 @@ typedef int __bitwise snd_seq_client_type_t;
 #define SNDRV_SEQ_FILTER_BROADCAST	(1U<<0)	/* accept broadcast messages */
 #define SNDRV_SEQ_FILTER_MULTICAST	(1U<<1)	/* accept multicast messages */
 #define SNDRV_SEQ_FILTER_BOUNCE		(1U<<2)	/* accept bounce event in error */
+#define SNDRV_SEQ_FILTER_NO_CONVERT	(1U<<30) /* don't convert UMP events */
 #define SNDRV_SEQ_FILTER_USE_EVENT	(1U<<31)	/* use event filter */
 
 struct snd_seq_client_info {
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 07b090f76b5f..3b1adcb1ccdd 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -671,14 +671,16 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
 					  dest_port->time_real);
 
 #if IS_ENABLED(CONFIG_SND_SEQ_UMP)
-	if (snd_seq_ev_is_ump(event)) {
-		result = snd_seq_deliver_from_ump(client, dest, dest_port,
-						  event, atomic, hop);
-		goto __skip;
-	} else if (snd_seq_client_is_ump(dest)) {
-		result = snd_seq_deliver_to_ump(client, dest, dest_port,
-						event, atomic, hop);
-		goto __skip;
+	if (!(dest->filter & SNDRV_SEQ_FILTER_NO_CONVERT)) {
+		if (snd_seq_ev_is_ump(event)) {
+			result = snd_seq_deliver_from_ump(client, dest, dest_port,
+							  event, atomic, hop);
+			goto __skip;
+		} else if (snd_seq_client_is_ump(dest)) {
+			result = snd_seq_deliver_to_ump(client, dest, dest_port,
+							event, atomic, hop);
+			goto __skip;
+		}
 	}
 #endif /* CONFIG_SND_SEQ_UMP */
 
diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index 2e8844ee32ed..9308194b2d9a 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -152,6 +152,7 @@ static int __init
 register_client(void)
 {
 	struct snd_seq_dummy_port *rec1, *rec2;
+	struct snd_seq_client *client;
 	int i;
 
 	if (ports < 1) {
@@ -165,6 +166,13 @@ register_client(void)
 	if (my_client < 0)
 		return my_client;
 
+	/* don't convert events but just pass-through */
+	client = snd_seq_kernel_client_get(my_client);
+	if (!client)
+		return -EINVAL;
+	client->filter = SNDRV_SEQ_FILTER_NO_CONVERT;
+	snd_seq_kernel_client_put(client);
+
 	/* create ports */
 	for (i = 0; i < ports; i++) {
 		rec1 = create_port(i, 0);
-- 
2.35.3

