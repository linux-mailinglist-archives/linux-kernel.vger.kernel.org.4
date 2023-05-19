Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBBB709345
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjESJdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjESJcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:32:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D431BD0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C53022245;
        Fri, 19 May 2023 09:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pka+FAS5v3W+sCEaoavXmDKAfyes9oP7et2fJmTgVyc=;
        b=RJw3i3nguYq2ZWpS1a5C1XLsaXuWtqdYpWc9U4G2H/6TxhBoSRADqejNRNEEULbDJ0Mhq4
        vX7TFX5PkyOmKQpcdcDn9+kbLmw3xjptVGUj2NKf4jk7tlpb4QWJdUjt33BLfV2yxp2Lwe
        sKDlE/V1ZXBhRUbizM1gnjJKszbh8KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488710;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pka+FAS5v3W+sCEaoavXmDKAfyes9oP7et2fJmTgVyc=;
        b=htgSCeil8q+1iKaIdmhTa1K3nSNajUXJt+t9dGcAO8NyU7Ri5S7sz17YqY8FebLJn5J3gV
        oTJzsRZcfXqTlOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71CCD13A12;
        Fri, 19 May 2023 09:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +E3wGQZCZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 34/36] ALSA: seq: Print UMP Endpoint and Block information in proc outputs
Date:   Fri, 19 May 2023 11:31:12 +0200
Message-Id: <20230519093114.28813-35-tiwai@suse.de>
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

This patch enhances the /proc/asound/seq/clients output to show a few
more information about the assigned UMP Endpoint and Blocks.

The "Groups" are shown in 1-based group number to align with the
sequencer client name and port number.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 03ca78ea2cce..8f416f5d0b4d 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2120,6 +2120,33 @@ static void terminate_ump_info_strings(void *p, int type)
 	}
 }
 
+#ifdef CONFIG_SND_PROC_FS
+static void dump_ump_info(struct snd_info_buffer *buffer,
+			  struct snd_seq_client *client)
+{
+	struct snd_ump_endpoint_info *ep;
+	struct snd_ump_block_info *bp;
+	int i;
+
+	if (!client->ump_info)
+		return;
+	ep = client->ump_info[SNDRV_SEQ_CLIENT_UMP_INFO_ENDPOINT];
+	if (ep && ep->name)
+		snd_iprintf(buffer, "  UMP Endpoint: \"%s\"\n", ep->name);
+	for (i = 0; i < SNDRV_UMP_MAX_BLOCKS; i++) {
+		bp = client->ump_info[i + 1];
+		if (bp && bp->name) {
+			snd_iprintf(buffer, "  UMP Block %d: \"%s\" [%s]\n",
+				    i, bp->name,
+				    bp->active ? "Active" : "Inactive");
+			snd_iprintf(buffer, "    Groups: %d-%d\n",
+				    bp->first_group + 1,
+				    bp->first_group + bp->num_groups);
+		}
+	}
+}
+#endif
+
 /* UMP-specific ioctls -- called directly without data copy */
 static int snd_seq_ioctl_client_ump_info(struct snd_seq_client *caller,
 					 unsigned int cmd,
@@ -2654,6 +2681,9 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 			    c, client->name,
 			    client->type == USER_CLIENT ? "User" : "Kernel",
 			    midi_version_string(client->midi_version));
+#if IS_ENABLED(CONFIG_SND_SEQ_UMP)
+		dump_ump_info(buffer, client);
+#endif
 		snd_seq_info_dump_ports(buffer, client);
 		if (snd_seq_write_pool_allocated(client)) {
 			snd_iprintf(buffer, "  Output pool :\n");
-- 
2.35.3

