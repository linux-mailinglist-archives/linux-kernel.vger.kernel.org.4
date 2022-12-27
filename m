Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEF1656769
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 06:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiL0Fxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 00:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiL0Fxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 00:53:35 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20F21A3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 21:53:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q190so6512362iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 21:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wARd1L8KoeksEpzilviu4ulCrJM4nCfjKCQtrReh+8=;
        b=KtWR1NWXObtv0A+S1nWRpm41eZaY26/OpoTg1WUZ0w96TGoaGxTskVlBy9RmAUg26I
         R50W5tkC5ZcQFkjLlDpE3K+Eebi3Ek2LtjejuCN1dyyzmdDotjvb03OKSHhHed9q3n1F
         scwRYzxgCR93T0aHENr/aJvGK684YPRaGbyzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wARd1L8KoeksEpzilviu4ulCrJM4nCfjKCQtrReh+8=;
        b=2NKxtNS/vIqpmyVVParmHy0uUOfWMb/VDu2RxDgtnmkPNKOY6U4NzNAsf73Tp4uHNf
         qCHMSKdOMalg4ZQroAo5N+vYk8j/0kI7aeLFbyqZ9h5muQKMM4Y/C63aQzmBAUuytFX3
         YL7CC+c4Fg5V84z0q0g5wn4uJpRCAf2sxlQpXekByyExqQBwlOCp/Iz/8vItxGKF+QVz
         jpMzCNdf0mNzXAAAoxIi9f4AJlFHEhCmCBBGr4sBFtwcsbLC9FXo3tAIlisBesgmIUqY
         xe9Yd/XtKdeBuDoCim+8MTbzfSTsYJJP8A6rOrT4RrySSh4i8Pzw8gpjbg7AWiN4M1A8
         rauA==
X-Gm-Message-State: AFqh2kpxy2Q0kORn3FSrjNby3YhlVNq+VRZKbl9nrDMpXngsub/3/+Ce
        gJadORIk0ThGpNdb0WW7xJ+1bA==
X-Google-Smtp-Source: AMrXdXte67TRl8MJY98BS/POkZrzxYuSwpJzPmANvIyiIz41oROqn94AbLwguwkLz3ZdO3qL9GeTXA==
X-Received: by 2002:a6b:da19:0:b0:6e4:e62c:38e3 with SMTP id x25-20020a6bda19000000b006e4e62c38e3mr15013786iob.5.1672120414631;
        Mon, 26 Dec 2022 21:53:34 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:2d44:773f:eb35:d838])
        by smtp.gmail.com with ESMTPSA id z11-20020a05660217cb00b006df2b3f17c3sm4678335iox.30.2022.12.26.21.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 21:53:34 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     intel-gfx@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        =?UTF-8?q?Juha-Pekka=20Heikkil=C3=A4?= 
        <juha-pekka.heikkila@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: Check source height is > 0
Date:   Mon, 26 Dec 2022 22:53:24 -0700
Message-Id: <20221226225246.1.I15dff7bb5a0e485c862eae61a69096caf12ef29f@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error message suggests that the height of the src rect must be at
least 1. Reject source with height of 0.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>

---
I was investigating some divide-by-zero crash reports on ChromeOS which
pointed to the intel_adjusted_rate function. Further prodding showed
that I could reproduce this in a simple test program if I made src_h
some value less than 1 but greater than 0.

This seemed to be a sensible place to check that the source height is at
least 1. I tried to repro this issue on an amd device I had on hand, and
the configuration was rejected.

Would it make sense to add a check that source dimensions are at least 1
somewhere in core, like in drm_atomic_plane_check? Or is that a valid
use case on some devices, and thus any such check should be done on a
per-driver basis?

Thanks.

 drivers/gpu/drm/i915/display/skl_universal_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 4b79c2d2d6177..9b172a1e90deb 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1627,7 +1627,7 @@ static int skl_check_main_surface(struct intel_plane_state *plane_state)
 	u32 offset;
 	int ret;
 
-	if (w > max_width || w < min_width || h > max_height) {
+	if (w > max_width || w < min_width || h > max_height || h < 1) {
 		drm_dbg_kms(&dev_priv->drm,
 			    "requested Y/RGB source size %dx%d outside limits (min: %dx1 max: %dx%d)\n",
 			    w, h, min_width, max_width, max_height);
-- 
2.39.0.314.g84b9a713c41-goog

