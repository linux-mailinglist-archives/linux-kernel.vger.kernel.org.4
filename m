Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF56B70D644
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjEWH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjEWHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:55:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DE1BC
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71D79219FA;
        Tue, 23 May 2023 07:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMJMbFQgcCvHbmJa9OEy6qWd09vQvN9bjPxXemze1cA=;
        b=AA5gc7cz0DvWTCGBMgX9haf4b2gLcvLjK4uWNrBGUIM1NXDEcLl01m5PZLHVebQ2rpYMX9
        ZFhzMFq4N/ZNMf0IIzQH1X4VEkFsIY65xh/nTspoK8/cuLJpNJ9vXZcg+tbHbaMQL6cU8v
        AmlghIcYjTq0nZ0Ak4Vt6L5z25npRmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMJMbFQgcCvHbmJa9OEy6qWd09vQvN9bjPxXemze1cA=;
        b=163DO29dg01bIQwP/HiNTgA9Z4aTnAageXRIpoW8BX4Goze2FFZRLP7y8q/FzDbKSKPqoQ
        ECaKfmzQLGctV8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EC2A13A1A;
        Tue, 23 May 2023 07:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oMt1CiFxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:09 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/37] ALSA: seq: Prohibit creating ports with special numbers
Date:   Tue, 23 May 2023 09:53:44 +0200
Message-Id: <20230523075358.9672-24-tiwai@suse.de>
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

Some port numbers are special, such as 254 for subscribers and 255 for
broadcast.  Return error if application tries to create such a port.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2dac8c3355fd..0f26f20596d7 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1206,6 +1206,8 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 		port_idx = info->addr.port;
 	else
 		port_idx = -1;
+	if (port_idx >= SNDRV_SEQ_ADDRESS_UNKNOWN)
+		return -EINVAL;
 	err = snd_seq_create_port(client, port_idx, &port);
 	if (err < 0)
 		return err;
-- 
2.35.3

