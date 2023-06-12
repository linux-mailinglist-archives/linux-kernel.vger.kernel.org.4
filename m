Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4A72B9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjFLIMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjFLILo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E44B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:11:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26A4D2285C;
        Mon, 12 Jun 2023 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686557467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7nIBVYrXmw9VtWIn1VS8RRci0PTHOpfvkr5XIEPKwQ=;
        b=Ju2u7fHwy+/0LLEPoTgo35449ag8naF5swqvaMkFWQdqf7n5BMBeaxeqNwg/OoGjaizqcs
        WhEPHq+jP02icdDFjl+wdyf4UePQXUT3x8pVrBbW8AvkNDx0MiUjn7fYVh63VIVn285OTx
        x/EIPPV6d+2NWTAzC3YPrEizjg04p8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686557467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7nIBVYrXmw9VtWIn1VS8RRci0PTHOpfvkr5XIEPKwQ=;
        b=jnCp3iTP9WO8mM0CqVP+ad8idfMLMO2FFnp1cA4wjTZRdR3h9ZqFHpdRydpAklYCQpUyKH
        rsTjHvgUNbHPxKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04D10138EC;
        Mon, 12 Jun 2023 08:11:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KAMvABvThmSLcAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 12 Jun 2023 08:11:07 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] ALSA: seq: ump: Notify UMP protocol change to sequencer
Date:   Mon, 12 Jun 2023 10:10:52 +0200
Message-Id: <20230612081054.17200-9-tiwai@suse.de>
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

UMP v1.1 supports the protocol switch via a UMP Stream message.  When
it's received, we need to take care of the midi_version field in the
corresponding sequencer client, too.

This patch introduces a new ops to notify the protocol change to
snd_seq_ump_ops for handling it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/ump.h             |  1 +
 sound/core/seq/seq_ump_client.c | 10 ++++++++++
 sound/core/ump.c                | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/sound/ump.h b/include/sound/ump.h
index 0e9c048346fa..68478e7be3b4 100644
--- a/include/sound/ump.h
+++ b/include/sound/ump.h
@@ -72,6 +72,7 @@ struct snd_seq_ump_ops {
 			      const u32 *data, int words);
 	int (*notify_fb_change)(struct snd_ump_endpoint *ump,
 				struct snd_ump_block *fb);
+	int (*switch_protocol)(struct snd_ump_endpoint *ump);
 };
 
 struct snd_ump_block {
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index 901a670dcb36..fe21c801af74 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -439,9 +439,19 @@ static int seq_ump_notify_fb_change(struct snd_ump_endpoint *ump,
 	return 0;
 }
 
+/* UMP protocol change notification; just update the midi_version field */
+static int seq_ump_switch_protocol(struct snd_ump_endpoint *ump)
+{
+	if (!ump->seq_client)
+		return -ENODEV;
+	setup_client_midi_version(ump->seq_client);
+	return 0;
+}
+
 static const struct snd_seq_ump_ops seq_ump_ops = {
 	.input_receive = seq_ump_input_receive,
 	.notify_fb_change = seq_ump_notify_fb_change,
+	.switch_protocol = seq_ump_switch_protocol,
 };
 
 /* create a sequencer client and ports for the given UMP endpoint */
diff --git a/sound/core/ump.c b/sound/core/ump.c
index c0cda12bce10..f364bb290d3a 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -657,14 +657,27 @@ static int ump_handle_product_id_msg(struct snd_ump_endpoint *ump,
 				 buf->raw, 2);
 }
 
+/* notify the protocol change to sequencer */
+static void seq_notify_protocol(struct snd_ump_endpoint *ump)
+{
+#if IS_ENABLED(CONFIG_SND_SEQUENCER)
+	if (ump->seq_ops && ump->seq_ops->switch_protocol)
+		ump->seq_ops->switch_protocol(ump);
+#endif /* CONFIG_SND_SEQUENCER */
+}
+
 /* handle EP stream config message; update the UMP protocol */
 static int ump_handle_stream_cfg_msg(struct snd_ump_endpoint *ump,
 				     const union snd_ump_stream_msg *buf)
 {
+	unsigned int old_protocol = ump->info.protocol;
+
 	ump->info.protocol =
 		(buf->stream_cfg.protocol << 8) | buf->stream_cfg.jrts;
 	ump_dbg(ump, "Current protocol = %x (caps = %x)\n",
 		ump->info.protocol, ump->info.protocol_caps);
+	if (ump->parsed && ump->info.protocol != old_protocol)
+		seq_notify_protocol(ump);
 	return 1; /* finished */
 }
 
-- 
2.35.3

