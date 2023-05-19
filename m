Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE0709332
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjESJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjESJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B111711
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7FF391FE3D;
        Fri, 19 May 2023 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MgnbPU5OxNR58kbXTDxnCalMNCAoR86IpQnF9YZNg4=;
        b=JQbHU5G+rVXX4eGX0w/eykC0meoBaVIsGgo47/Mcj8tcNQU33V2s1S9nmk4yvAl49bFCdo
        rHfOTmNDW1LM3NgjV6ek+4MQjIGPKEu1ogJZOW47mFnAjriZdPRj6nBjqnQORIolCafvu/
        HSzcNl8YMSc3iNgiddYSYmIKYyJd/yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MgnbPU5OxNR58kbXTDxnCalMNCAoR86IpQnF9YZNg4=;
        b=96UAUeALXMUPrN1d6Jb9j234WJCU/S1hHfsSziVYbn2j2Mc3KF3DGKWcThV8482jplLcTn
        XEfrqHY4GDKwCpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60D8113A12;
        Fri, 19 May 2023 09:31:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yJq4Fv5BZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:42 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 21/36] ALSA: seq: Check validity before creating a port object
Date:   Fri, 19 May 2023 11:30:59 +0200
Message-Id: <20230519093114.28813-22-tiwai@suse.de>
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

The client type and the port info validity check should be done before
actually creating a port, instead of unnecessary create-and-scratch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 06743114cabf..2dac8c3355fd 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1199,6 +1199,8 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 	/* it is not allowed to create the port for an another client */
 	if (info->addr.client != client->number)
 		return -EPERM;
+	if (client->type == USER_CLIENT && info->kernel)
+		return -EINVAL;
 
 	if (info->flags & SNDRV_SEQ_PORT_FLG_GIVEN_PORT)
 		port_idx = info->addr.port;
@@ -1208,12 +1210,6 @@ static int snd_seq_ioctl_create_port(struct snd_seq_client *client, void *arg)
 	if (err < 0)
 		return err;
 
-	if (client->type == USER_CLIENT && info->kernel) {
-		port_idx = port->addr.port;
-		snd_seq_port_unlock(port);
-		snd_seq_delete_port(client, port_idx);
-		return -EINVAL;
-	}
 	if (client->type == KERNEL_CLIENT) {
 		callback = info->kernel;
 		if (callback) {
-- 
2.35.3

