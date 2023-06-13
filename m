Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE772E15F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjFMLYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbjFMLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:23:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E01FC3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:23:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9611F1FD8F;
        Tue, 13 Jun 2023 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686655362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sO60fsV+XdP0/uve4cp5yDDKZqVuceLf/J7QE90gvx4=;
        b=ejablnhwvL4lTGlWKUz3ffv4cDRlSuI9FS31tOH+oWSfCENaycQFl4IN5rPjKR0KWtl2zf
        Qikby3IYbqxRff4+pFPs+hSL0eLCPHC1E0sdMQXoQJ9Os38jX8xHJS4n8mzQ74A+J9Q2QN
        sYQafm6AO/SkpgIm1drAKldyAmshZwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686655362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sO60fsV+XdP0/uve4cp5yDDKZqVuceLf/J7QE90gvx4=;
        b=XjSaphVlBL6b0B4XsnfWafGKd/gGG/alhSDI7S2B9X0E+Jwai6Pwq7wfPwxH1/hBtxsgTG
        HBZ9YplLhokcUeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7109013483;
        Tue, 13 Jun 2023 11:22:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lb22GoJRiGS5EAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 13 Jun 2023 11:22:42 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2] regmap: regcache: Don't sync read-only registers
Date:   Tue, 13 Jun 2023 13:22:40 +0200
Message-Id: <20230613112240.3361-1-tiwai@suse.de>
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

This patch adds the writable register check to regcache_sync_val() for
addressing the bug above.

Note that, although we may add the check in the caller side
(regcache_maple_sync()), here we put in regcache_sync_val(), so that a
similar case like this can be avoided in future.

Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Link: https://lore.kernel.org/r/877cs7g6f1.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/regmap/regcache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 029564695dbb..97c681fcf9f6 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -284,6 +284,9 @@ static bool regcache_reg_needs_sync(struct regmap *map, unsigned int reg,
 {
 	int ret;
 
+	if (!regmap_writeable(map, reg))
+		return false;
+
 	/* If we don't know the chip just got reset, then sync everything. */
 	if (!map->no_sync_defaults)
 		return true;
-- 
2.35.3

