Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5215B91E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIOAqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiIOAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:46:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E656D9D8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:46:06 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b11-20020a170902d50b00b0017828988079so8456252plg.21
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=o0TKZg1V+iwVMAhcvK219IOXYb7az/U83DvEghII4Dw=;
        b=ixIlbiWjYVB7lleKcOS25U/195trOCFFYYTNY2ArRn6K/NXN4jKkbx8xqVv40XOYwc
         gzOAoHFIZ5nYNTfyaobW0eR/pRWG25686m9JNJWBrr+6XN1RIF81EpUMZ2WjcMFCwhSm
         8Gb5q+USrZHuvbc4jRv89+/+mSkgNgiHosn5pQFsAnbd1C2Dv7ogkJvH1mC5lGrL+dPr
         bnDcostykRNUl2cropFFiaYmIcz4a5CirfMwmfwgNqHM/EqMlJz/pmNv4Ugl2f1MNawE
         jIGBZhIlX4HrU621pf9P/4CGXhHLBZxK7w0Dp2p+dDVn1hB+Jl5575zzcLF/aRyRy4zu
         UhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=o0TKZg1V+iwVMAhcvK219IOXYb7az/U83DvEghII4Dw=;
        b=aInIiI0Rp/AMElN7KzvktQHcUVOm4l1pU2mhRBLt35R9/TDfMcqxXiD/DAN8ToHvKN
         wDOWkgkUobYxRu94Aecn2JpEs7146aHjojJTC7Osq7HWzD0iZaGX4PHu5Aw3iMUPNvZS
         3ujOx/RsWXQs1545i031MDXdFLu768WkCOhJF+D+MpM0MS/kOYw9Ro8NqZudlVwS9ZBU
         lBzVrV+iB/z9jCnmoDOrQFKTIajzYGLxV+wH/udp1anW7gkB7rjKhYjBLhTn9FoV8new
         Io/EBHVfGlkfEEXO0qk1qu8+o4hHR4LNLl5L0IVTY+MusNMa+vMNTmZBm+mP8CM0w4vK
         EfgA==
X-Gm-Message-State: ACrzQf3T8HDZyU+0WB4Ygf+EEEvmYAUsLDuBdiKNWrM5+cvUVBgjsDO0
        jltcEFI+5IG8oYIaJxVjJwwKxW0FRBUU22c=
X-Google-Smtp-Source: AMsMyM7cpjC0UvYeAkGaQWcCbIFCVaxS58PZrp3VQQ5nzbzNbiesGmVdHmcPLBDxn84TmNTXrfnoS9iOMdHYeok=
X-Received: from pceballos.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:128c])
 (user=pceballos job=sendgmr) by 2002:a17:90a:5aa2:b0:200:30aa:c773 with SMTP
 id n31-20020a17090a5aa200b0020030aac773mr7466200pji.182.1663202766080; Wed,
 14 Sep 2022 17:46:06 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:46:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915004601.320198-1-pceballos@google.com>
Subject: [PATCH] drm/i915/display/lspcon: Increase LSPCON mode settle timeout
From:   Pablo Ceballos <pceballos@google.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Pablo Ceballos <pceballos@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices the Parade PS175 takes more than 400ms to settle in PCON
mode.

Signed-off-by: Pablo Ceballos <pceballos@google.com>
---
 drivers/gpu/drm/i915/display/intel_lspcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index 15d59de8810e..b4cbade13ee5 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -166,7 +166,7 @@ static enum drm_lspcon_mode lspcon_wait_mode(struct intel_lspcon *lspcon,
 	drm_dbg_kms(&i915->drm, "Waiting for LSPCON mode %s to settle\n",
 		    lspcon_mode_name(mode));
 
-	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 400);
+	wait_for((current_mode = lspcon_get_current_mode(lspcon)) == mode, 800);
 	if (current_mode != mode)
 		drm_err(&i915->drm, "LSPCON mode hasn't settled\n");
 
-- 
2.37.2.789.g6183377224-goog

