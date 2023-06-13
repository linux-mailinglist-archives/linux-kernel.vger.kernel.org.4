Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66472DB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbjFMHqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbjFMHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:46:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804119AE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:45:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC4A1FD76;
        Tue, 13 Jun 2023 07:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686642324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dJgC7IJsRwZThDR+MXRBPyItHeIWZPAve8xzVWCL4AA=;
        b=nofkgr7WVYo44MkQhB5D/5stT35GW4ushSOXVFwIwRQcDHwKvjAOuUQeVnwN4aB7FNo8+n
        zOn8MnM+pC6eMxX+nkc0xNi0t3jMwdfDOihU1P9QlzvPGy5IkfcziFXOJb5jTAyg6Kpp7u
        EiuRwJQScu78OWYcvozCSSkg8+vkoqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686642324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dJgC7IJsRwZThDR+MXRBPyItHeIWZPAve8xzVWCL4AA=;
        b=jQdDjp3X+OOoVnKP18S7Wq7otNDIDcV8t+BCIpB9v7+Y6rDausZKiY3Pw2z0q5wUi576Gk
        pXKHhtoTm8imgxAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC58C13345;
        Tue, 13 Jun 2023 07:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j2niMJMeiGTbHAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 13 Jun 2023 07:45:23 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH] regmap: maple: Don't sync read-only registers
Date:   Tue, 13 Jun 2023 09:45:11 +0200
Message-Id: <20230613074511.4476-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

regcache_maple_sync() tries to sync all cached values no matter
whether it's writable or not.  OTOH, regache_sync_val() does care the
wrtability and returns -EIO for a read-only register.  This results in
an error message like:
  snd_hda_codec_realtek hdaudioC0D0: Unable to sync register 0x2f0009. -5
and the sync loop is aborted incompletely.

This patch adds the writable register check in the loop for addressing
the bug.

Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Link: https://lore.kernel.org/r/877cs7g6f1.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/regmap/regcache-maple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index c2e3a0f6c218..d2dad32dd399 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -203,6 +203,8 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 
 	mas_for_each(&mas, entry, max) {
 		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
+			if (!regmap_writeable(map, r))
+				continue;
 			mas_pause(&mas);
 			rcu_read_unlock();
 			ret = regcache_sync_val(map, r, entry[r - mas.index]);
-- 
2.35.3

