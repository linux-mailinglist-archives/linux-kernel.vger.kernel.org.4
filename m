Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798F72B9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjFLIMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFLIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08637136
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0077D20489;
        Mon, 12 Jun 2023 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ6Jn+89eBIHgVAM96uOHKXFiJ5ayjFK1sJ6wbr/Oo8=;
        b=UF+soOXCKMaWmkwnHVwFhGBGmc7/TNQ/eh4oY2PJzdIbwl64uHr5UyLQyu+sG/yYh36PC0
        0Qc1zakcs171aHuMpfGFimcFnZnLy7eA1nbACAzpbidJgoiLO4wwyRrppX5pVPlJvb5nOo
        lv8Tb/DCoHoIfjsX11NoksJ1/EP5Mcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ6Jn+89eBIHgVAM96uOHKXFiJ5ayjFK1sJ6wbr/Oo8=;
        b=Qeg1nXCrcRUvYfb3XduhiuHuoXZHSoY4DNdYQtwSOu3kv3SFIVUaPy1LL0Cx3qZneGaVea
        l0WNGREebRkCi+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D369713A67;
        Mon, 12 Jun 2023 08:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2DGlMhrThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:06 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] ALSA: seq: ump: Notify port changes to system port
Date:   Mon, 12 Jun 2023 10:10:51 +0200
Message-Id: <20230612081054.17200-8-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230612081054.17200-1-tiwai@suse.de>
References: <20230612081054.17200-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For allowing applications to track the FB active changes, this patch
adds the notification from the system port at each time a FB change is
handled and the active flag or re-grouping happens.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_system.c     | 1 +
 sound/core/seq/seq_ump_client.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_system.c b/sound/core/seq/seq_system.c
index 32c2d9b57751..80267290190d 100644
--- a/sound/core/seq/seq_system.c
+++ b/sound/core/seq/seq_system.c
@@ -85,6 +85,7 @@ void snd_seq_system_broadcast(int client, int port, int type)
 	ev.type = type;
 	snd_seq_kernel_client_dispatch(sysclient, &ev, 0, 0);
 }
+EXPORT_SYMBOL_GPL(snd_seq_system_broadcast);
 
 /* entry points for broadcasting system events */
 int snd_seq_system_notify(int client, int port, struct snd_seq_event *ev)
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index 2f93d76b05ce..901a670dcb36 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -13,6 +13,7 @@
 #include <sound/seq_kernel.h>
 #include <sound/seq_device.h>
 #include "seq_clientmgr.h"
+#include "seq_system.h"
 
 struct seq_ump_client;
 struct seq_ump_group;
@@ -273,6 +274,8 @@ static void update_port_infos(struct seq_ump_client *client)
 						new);
 		if (err < 0)
 			goto error;
+		/* notify to system port */
+		snd_seq_system_client_ev_port_change(client->seq_client, i);
 	}
  error:
 	kfree(new);
-- 
2.35.3

