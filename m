Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139770D63F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjEWH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjEWHzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A9BCD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7CD8720410;
        Tue, 23 May 2023 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4DZ5woY6gmacraFwH4PrBR7nOGakjNJMIBScTlvDFE=;
        b=HkjeYC0QuYOlGB79i3zWQ/9nWZoV0V00HmPoZjX8OD3mqJf/3zUTw9Eb//H552FIYpcm9x
        R9FfayH9I+Xn4sSfIE6He1cX/yhBeKa/6S8syoOB8VSzThoY1S86tUrGg7Yfora7TmCj6O
        K08n5j33ogHA3gs0vajGR/5etm9bJEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4DZ5woY6gmacraFwH4PrBR7nOGakjNJMIBScTlvDFE=;
        b=XpHHji8S3+L9y7x/IwkdgDVaipr1QtJ8kmLMfx6sxcg2inXZ1uZQA0V1yFFRsC+ChRksAm
        v6YIzmrwfWxOM0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4291D13A1A;
        Tue, 23 May 2023 07:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wN89DiBxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:08 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/37] ALSA: seq: Treat snd_seq_client object directly in client drivers
Date:   Tue, 23 May 2023 09:53:40 +0200
Message-Id: <20230523075358.9672-20-tiwai@suse.de>
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

Introduce the new helpers, snd_seq_kernel_client_get() and _put() for
kernel client drivers to treat the snd_seq_client more directly.
This allows us to reduce the exported symbols and APIs at each time we
need to access some field in future.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 15 +++++++++++++++
 sound/core/seq/seq_clientmgr.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2d707afa1ef1..98e8032a32e2 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2390,6 +2390,21 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 }
 EXPORT_SYMBOL(snd_seq_kernel_client_write_poll);
 
+/* get a sequencer client object; for internal use from a kernel client */
+struct snd_seq_client *snd_seq_kernel_client_get(int id)
+{
+	return snd_seq_client_use_ptr(id);
+}
+EXPORT_SYMBOL_GPL(snd_seq_kernel_client_get);
+
+/* put a sequencer client object; for internal use from a kernel client */
+void snd_seq_kernel_client_put(struct snd_seq_client *cptr)
+{
+	if (cptr)
+		snd_seq_client_unlock(cptr);
+}
+EXPORT_SYMBOL_GPL(snd_seq_kernel_client_put);
+
 /*---------------------------------------------------------------------------*/
 
 #ifdef CONFIG_SND_PROC_FS
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 8cdd0ee53fb1..f05704e45ab4 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -88,4 +88,8 @@ void snd_seq_client_ioctl_unlock(int clientid);
 
 extern int seq_client_load[15];
 
+/* for internal use between kernel sequencer clients */
+struct snd_seq_client *snd_seq_kernel_client_get(int client);
+void snd_seq_kernel_client_put(struct snd_seq_client *cptr);
+
 #endif
-- 
2.35.3

