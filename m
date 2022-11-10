Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253836242E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiKJNJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKJNJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:09:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4615BA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:09:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 751EA1F8F4;
        Thu, 10 Nov 2022 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668085772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hLX1Kf1YwFIN5rhfEBJFleCYcI9ShWd8l3DAEB7UhgM=;
        b=BSyUDVgZSRZDIRTLntV01gt7BRNsEDF1S1rVWBu934pcVKgai0d+h9xcz8/z+UUk2c9XBB
        6b5teQV4sLhE69UZYpUvMP2SURMGI8yFhzsr1GOLflTaXxoAICD2jZjEmB3M8OOuZfYPSX
        NdqEkedtPAQvqd6KGM0vSRDwO7quJa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668085772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hLX1Kf1YwFIN5rhfEBJFleCYcI9ShWd8l3DAEB7UhgM=;
        b=k9DZQTcYod/BQInLVlKPWzfMkW9nn5RpVcIbGDFUYwhrqGMVS3P5Yn1ZBD85JjrAuCkHTM
        aNi2Lmtnfz7TR9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5805913B58;
        Thu, 10 Nov 2022 13:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W8ANFQz4bGMcbwAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 10 Nov 2022 13:09:32 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: radeon: Fix audio get_eld callback
Date:   Thu, 10 Nov 2022 14:09:25 +0100
Message-Id: <20221110130925.26928-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the availability of the audio capability and mode config before
going to the loop for avoiding the access to an unusable state.  Also,
change the loop iterations over encoder instead of connector in order
to align with radeon_audio_enable().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2236
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Note: this is the additional fix on top of the previously submitted
audio component support for radeon.

 drivers/gpu/drm/radeon/radeon_audio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 71b67d4efe08..d6ccaf24ee0c 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -747,6 +747,7 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 					  unsigned char *buf, int max_bytes)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
+	struct radeon_device *rdev = dev->dev_private;
 	struct drm_encoder *encoder;
 	struct radeon_encoder *radeon_encoder;
 	struct radeon_encoder_atom_dig *dig;
@@ -754,19 +755,19 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 	int ret = 0;
 
 	*enabled = false;
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		const struct drm_connector_helper_funcs *connector_funcs =
-			connector->helper_private;
-		encoder = connector_funcs->best_encoder(connector);
+	if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
+		return 0;
 
-		if (!encoder)
-			continue;
+	list_for_each_entry(encoder, &rdev->ddev->mode_config.encoder_list, head) {
 		if (!radeon_encoder_is_digital(encoder))
 			continue;
 		radeon_encoder = to_radeon_encoder(encoder);
 		dig = radeon_encoder->enc_priv;
 		if (!dig->pin || dig->pin->id != port)
 			continue;
+		connector = radeon_get_connector_for_encoder(encoder);
+		if (!connector)
+			continue;
 		*enabled = true;
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));
-- 
2.35.3

