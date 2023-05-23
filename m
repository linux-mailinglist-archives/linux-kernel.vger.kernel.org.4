Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5770D614
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjEWHy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjEWHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC394
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A06A227A4;
        Tue, 23 May 2023 07:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b27Ref8ImoJXjyPyFCsfRMw/pwLg1dpXQ6Knv5YaWzU=;
        b=PKJPHpLdfovv6Ped0GtzgzELQxM8mRsu3WqXvCdt8I/E58Qazm1Pm91iqalS7QJIcBIjA4
        I8mBnrm5/Vap0GtQFpj/lPlHM7X7qapDnWXhaKPFsA1kkxI0UuUn7KEf2q/9OmmYEsbSLE
        pktb1FHx9n7uhQysQbSOLiqAzuTgXdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b27Ref8ImoJXjyPyFCsfRMw/pwLg1dpXQ6Knv5YaWzU=;
        b=kz87lPoH4W2qwxgW5jaiQZ2noEOiUjbPXXNkot90FuBslb4W5kc6Q44UUk9yUm7j40oHE0
        HcOTRm88wckEGRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E34413588;
        Tue, 23 May 2023 07:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sL4kEhpxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:02 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/37] ALSA: rawmidi: Add ioctl callback to snd_rawmidi_global_ops
Date:   Tue, 23 May 2023 09:53:23 +0200
Message-Id: <20230523075358.9672-3-tiwai@suse.de>
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

A new callback, ioctl, is added to snd_rawmidi_global_ops for allowing
the driver to deal with the own ioctls.  This is another preparation
patch for the upcoming UMP support.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h | 2 ++
 sound/core/rawmidi.c    | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 52b1cbfb2526..84413cfcdcb5 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -47,6 +47,8 @@ struct snd_rawmidi_global_ops {
 	int (*dev_unregister) (struct snd_rawmidi * rmidi);
 	void (*get_port_info)(struct snd_rawmidi *rmidi, int number,
 			      struct snd_seq_port_info *info);
+	long (*ioctl)(struct snd_rawmidi *rmidi, unsigned int cmd,
+		      void __user *argp);
 };
 
 struct snd_rawmidi_runtime {
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 589b75087d27..ab28cfc1fac8 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -893,6 +893,7 @@ static int snd_rawmidi_ioctl_status64(struct snd_rawmidi_file *rfile,
 static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct snd_rawmidi_file *rfile;
+	struct snd_rawmidi *rmidi;
 	void __user *argp = (void __user *)arg;
 
 	rfile = file->private_data;
@@ -984,8 +985,10 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 		}
 	}
 	default:
-		rmidi_dbg(rfile->rmidi,
-			  "rawmidi: unknown command = 0x%x\n", cmd);
+		rmidi = rfile->rmidi;
+		if (rmidi->ops && rmidi->ops->ioctl)
+			return rmidi->ops->ioctl(rmidi, cmd, argp);
+		rmidi_dbg(rmidi, "rawmidi: unknown command = 0x%x\n", cmd);
 	}
 	return -ENOTTY;
 }
-- 
2.35.3

