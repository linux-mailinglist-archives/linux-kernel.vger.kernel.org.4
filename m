Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2593709335
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjESJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjESJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A11730
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BDD7E222AD;
        Fri, 19 May 2023 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9zSH66PKLZSek1+f7HTHKq9RrcGGPrH4bCfODwVZUA=;
        b=puVqaIdpkndJ4oA4wXhPx+DOkqA8RV+EXSSWdoay/mdCcqlJeEuRKSNA1caza+fTvRgCRB
        vH4iXTYSYSQruGVuMLKvjxUYgcZLaFYP3UdrNI9KklvbYSBf52OfHSPi11AaERrweKTRDe
        C+Ef1vh8yFVDUNyz+/gp61uuyuth5Qo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9zSH66PKLZSek1+f7HTHKq9RrcGGPrH4bCfODwVZUA=;
        b=IAp+Cs3hGxBko9eYTQtT+Szcb6c5FYciTjzlMnvMueuHu9yNp1VLNrwZ1mpNsfWIU51s+r
        sRDCu9l0QZNF2ADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9928A13A12;
        Fri, 19 May 2023 09:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KGCAJP9BZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:43 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 23/36] ALSA: seq: Introduce SNDRV_SEQ_IOCTL_USER_PVERSION ioctl
Date:   Fri, 19 May 2023 11:31:01 +0200
Message-Id: <20230519093114.28813-24-tiwai@suse.de>
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

For the future extension of ALSA sequencer ABI, introduce a new ioctl
SNDRV_SEQ_IOCTL_USER_PVERSION.  This is similar like the ioctls used
in PCM and other interfaces, for an application to specify its
supporting ABI version.

The use of this ioctl will be mandatory for the upcoming UMP support.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asequencer.h | 1 +
 sound/core/seq/seq_clientmgr.c  | 8 ++++++++
 sound/core/seq/seq_clientmgr.h  | 1 +
 sound/core/seq/seq_compat.c     | 1 +
 4 files changed, 11 insertions(+)

diff --git a/include/uapi/sound/asequencer.h b/include/uapi/sound/asequencer.h
index 00d2703e8fca..4a3c5a718bae 100644
--- a/include/uapi/sound/asequencer.h
+++ b/include/uapi/sound/asequencer.h
@@ -561,6 +561,7 @@ struct snd_seq_query_subs {
 #define SNDRV_SEQ_IOCTL_CLIENT_ID	_IOR ('S', 0x01, int)
 #define SNDRV_SEQ_IOCTL_SYSTEM_INFO	_IOWR('S', 0x02, struct snd_seq_system_info)
 #define SNDRV_SEQ_IOCTL_RUNNING_MODE	_IOWR('S', 0x03, struct snd_seq_running_info)
+#define SNDRV_SEQ_IOCTL_USER_PVERSION	_IOW('S', 0x04, int)
 
 #define SNDRV_SEQ_IOCTL_GET_CLIENT_INFO	_IOWR('S', 0x10, struct snd_seq_client_info)
 #define SNDRV_SEQ_IOCTL_SET_CLIENT_INFO	_IOW ('S', 0x11, struct snd_seq_client_info)
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 0f26f20596d7..89a8d14df83b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1056,6 +1056,12 @@ static int snd_seq_ioctl_pversion(struct snd_seq_client *client, void *arg)
 	return 0;
 }
 
+static int snd_seq_ioctl_user_pversion(struct snd_seq_client *client, void *arg)
+{
+	client->user_pversion = *(unsigned int *)arg;
+	return 0;
+}
+
 static int snd_seq_ioctl_client_id(struct snd_seq_client *client, void *arg)
 {
 	int *client_id = arg;
@@ -1985,6 +1991,7 @@ static const struct ioctl_handler {
 	int (*func)(struct snd_seq_client *client, void *arg);
 } ioctl_handlers[] = {
 	{ SNDRV_SEQ_IOCTL_PVERSION, snd_seq_ioctl_pversion },
+	{ SNDRV_SEQ_IOCTL_USER_PVERSION, snd_seq_ioctl_user_pversion },
 	{ SNDRV_SEQ_IOCTL_CLIENT_ID, snd_seq_ioctl_client_id },
 	{ SNDRV_SEQ_IOCTL_SYSTEM_INFO, snd_seq_ioctl_system_info },
 	{ SNDRV_SEQ_IOCTL_RUNNING_MODE, snd_seq_ioctl_running_mode },
@@ -2125,6 +2132,7 @@ int snd_seq_create_kernel_client(struct snd_card *card, int client_index,
 	client->accept_input = 1;
 	client->accept_output = 1;
 	client->data.kernel.card = card;
+	client->user_pversion = SNDRV_SEQ_VERSION;
 		
 	va_start(args, name_fmt);
 	vsnprintf(client->name, sizeof(client->name), name_fmt, args);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index f05704e45ab4..abe0ceadf3da 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -35,6 +35,7 @@ struct snd_seq_client {
 	snd_seq_client_type_t type;
 	unsigned int accept_input: 1,
 		accept_output: 1;
+	unsigned int user_pversion;
 	char name[64];		/* client name */
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
diff --git a/sound/core/seq/seq_compat.c b/sound/core/seq/seq_compat.c
index 54723566ce24..c0ce6236dc7f 100644
--- a/sound/core/seq/seq_compat.c
+++ b/sound/core/seq/seq_compat.c
@@ -81,6 +81,7 @@ static long snd_seq_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
+	case SNDRV_SEQ_IOCTL_USER_PVERSION:
 	case SNDRV_SEQ_IOCTL_CLIENT_ID:
 	case SNDRV_SEQ_IOCTL_SYSTEM_INFO:
 	case SNDRV_SEQ_IOCTL_GET_CLIENT_INFO:
-- 
2.35.3

