Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5C70D632
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbjEWH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjEWHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4110D2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F30D021976;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMzBP59J7x7TxGFaxuEDckjn0BZosp/WXU2Nz5BQgbk=;
        b=MxFbxoWdt43CnWdWmOn3iq6Bc3CSpCRFqENLliyU0THhGtYaOK8XYj+J5LjqHUUe/ChdSl
        KUUH2pIBQYaMRwo26/j3MBL7ODQIZnSqVCzteVe6vaXTE0tlFPcNzPIWuqgojhgPPgB2jY
        TDyP8ld4FFcxud1cV1BpznNXMZODPsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMzBP59J7x7TxGFaxuEDckjn0BZosp/WXU2Nz5BQgbk=;
        b=QLtWeTZE8e4awLgLDbzJ8+2XjVLrtRiXEdyEnSMUpcDqXTUTMjCS7X73C1oRFh51qPstpZ
        ttNfnL/Y//C0hZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2F2613A1A;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AyuJx9xbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:07 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/37] ALSA: seq: Clear padded bytes at expanding events
Date:   Tue, 23 May 2023 09:53:38 +0200
Message-Id: <20230523075358.9672-18-tiwai@suse.de>
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

There can be a small memory hole that may not be cleared at expanding
an event with the variable length type.  Make sure to clear it.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_memory.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 47ef6bc30c0e..c8d26bce69ff 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -152,12 +152,16 @@ int snd_seq_expand_var_event(const struct snd_seq_event *event, int count, char
 			return -EINVAL;
 		if (copy_from_user(buf, (void __force __user *)event->data.ext.ptr, len))
 			return -EFAULT;
-		return newlen;
+	} else {
+		err = snd_seq_dump_var_event(event,
+					     in_kernel ? seq_copy_in_kernel : seq_copy_in_user,
+					     &buf);
+		if (err < 0)
+			return err;
 	}
-	err = snd_seq_dump_var_event(event,
-				     in_kernel ? seq_copy_in_kernel : seq_copy_in_user,
-				     &buf);
-	return err < 0 ? err : newlen;
+	if (len != newlen)
+		memset(buf + len, 0, newlen - len);
+	return newlen;
 }
 EXPORT_SYMBOL(snd_seq_expand_var_event);
 
-- 
2.35.3

