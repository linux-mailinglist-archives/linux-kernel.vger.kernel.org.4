Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4770932B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjESJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjESJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1010C6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B53F31FE3F;
        Fri, 19 May 2023 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcafucgcxTqZeZeiPExPE8Xrdw3TdNFdLqfYPg++GvE=;
        b=oxtSs/ALtpLVgWEWNJuz2y20qkf0gtOtYz7XyvX3qPIIpPP3AOfGyL1+s0PKmKZcTFKrKk
        yqGtk5N9sW2qKKpAZ+1KYTINr4sSY1oOiZwCLVcKTVl+aD3baa9ORRGT47ItXTgk022Pyl
        +WI3vjzfgYprHuGdpcu50HpnvOaycUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcafucgcxTqZeZeiPExPE8Xrdw3TdNFdLqfYPg++GvE=;
        b=cIMkAkUHAE0x/CPu6ovTjm4Z2Q9mv6qQEw/bLMwiPzgnuuU+hck8W+P74ITEqoo2UjxaO7
        PkM6owc0jQY6VUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 956B213A12;
        Fri, 19 May 2023 09:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ELyhI/tBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:39 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/36] ALSA: seq: Clear padded bytes at expanding events
Date:   Fri, 19 May 2023 11:30:54 +0200
Message-Id: <20230519093114.28813-17-tiwai@suse.de>
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

There can be a small memory hole that may not be cleared at expanding
an event with the variable length type.  Make sure to clear it.

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

