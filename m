Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECD70931E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjESJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjESJbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66D1A6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE1941FE3D;
        Fri, 19 May 2023 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JM7aynpADpweyyiVqnN0EwV+i0ZMSlfggv+EXFiSh0=;
        b=T8751m1nsfPI5nGRskWjj24MWhECzBimiz4T1cRKqjFhfVXPWpniyI9UnwrOiRvxYnCfFs
        BSgjLpsS9Z81ux7uF9leYNUxG6o7GjMRIbYo3TB2Ze+0vtZUWzrH8XDimgbQeXlhIP78KX
        uz33mmVwU2BYkzHgkHeMhzuBp2llAuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JM7aynpADpweyyiVqnN0EwV+i0ZMSlfggv+EXFiSh0=;
        b=xapZetBDUHuRha0Mh7xJV0WGtOnVb5/2mzr9OIXzDHxiZ1VXKEq3zzJZBgaxQjeUlNMlFV
        +a31hyjSrGeBXSDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A057713A12;
        Fri, 19 May 2023 09:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ARuJPJBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:30 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/36] ALSA: rawmidi: Add ioctl callback to snd_rawmidi_global_ops
Date:   Fri, 19 May 2023 11:30:40 +0200
Message-Id: <20230519093114.28813-3-tiwai@suse.de>
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

A new callback, ioctl, is added to snd_rawmidi_global_ops for allowing
the driver to deal with the own ioctls.  This is another preparation
patch for the upcoming UMP support.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h | 3 +++
 sound/core/rawmidi.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 52b1cbfb2526..a53cd063412c 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -32,6 +32,7 @@
 
 struct snd_rawmidi;
 struct snd_rawmidi_substream;
+struct snd_rawmidi_file;
 struct snd_seq_port_info;
 struct pid;
 
@@ -47,6 +48,8 @@ struct snd_rawmidi_global_ops {
 	int (*dev_unregister) (struct snd_rawmidi * rmidi);
 	void (*get_port_info)(struct snd_rawmidi *rmidi, int number,
 			      struct snd_seq_port_info *info);
+	long (*ioctl)(struct snd_rawmidi_file *rfile, unsigned int cmd,
+		      void __user *argp);
 };
 
 struct snd_rawmidi_runtime {
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 589b75087d27..1415f559b5d0 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -984,6 +984,8 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 		}
 	}
 	default:
+		if (rfile->rmidi->ops && rfile->rmidi->ops->ioctl)
+			return rfile->rmidi->ops->ioctl(rfile, cmd, argp);
 		rmidi_dbg(rfile->rmidi,
 			  "rawmidi: unknown command = 0x%x\n", cmd);
 	}
-- 
2.35.3

