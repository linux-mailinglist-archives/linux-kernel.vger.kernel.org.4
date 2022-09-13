Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB095B7C56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiIMUz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIMUzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:55:18 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF41E3C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:16 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id p9-20020a9f3689000000b003b0197572fbso3848443uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=nJJJEPzYfSkXVdsCpO+dC++9rjlYO0nwzxMLu7tGL28=;
        b=kBuaNyAa7BFLRUEAj+HWAu4RAwHGJ9M57W9cIKk5MyobRXZOJfVdASqgAzWehpzyUn
         Y2IjOvlKDeODQuKbuNU3iikjsk79MNdjB7129WV6VfDSJNyYNNWrbljfwjvUPNHaboNr
         uiD84mx7PdI1dLViLrk1nug6KFyvMaOYA5/g2iznrnDGS9JbMdD4SWf2Db7rcUZGQLcG
         PMriKa3MzKAq1ZqqRh77D4TnN4zbttl85a6WpoJim5+T9nS0Gpmnk8hOc6Hgjloq/vak
         YyqkjUk+2SaZYQyLFnw2OgHqRIPyCfeeMNJtGxqxurWYcYuRL5J4RQfQpyzJPmHPv9zm
         QTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=nJJJEPzYfSkXVdsCpO+dC++9rjlYO0nwzxMLu7tGL28=;
        b=LlKFT3QZ2HxHGAMdnIkEaSgBZdSDXgUJobm2hXf30VLWAQM2lS4XpiYLvPAfV+cLKo
         K9c65BMSv7ktp4SX5x6YTAcInWIWsev3+Ly50RARHn0cElWz5ivyQE/y4wOhXZog/oUg
         7j6zo4QxSkj0nkeAoK6K9DkR+NKOD5XDCvoXuo25Y7C3QprWtMfOFKFUeyRJFVuJBGB1
         xakn3vqcyO5nIIjC5R+MEh1I392aPaxrdizp0Nbcnjej7Iek+4hIo4swuSBgPJoKv6Pm
         aPlZHNeFLDy9ow4sxEkPuxxRHvc5g0JWKKV33hRAfAwwHKgFVXHlTn4RS9lYf/bxnF4k
         Cx0Q==
X-Gm-Message-State: ACgBeo3XFCz5GtLNyDp4vExggX+K+38pxECrQoDz0BI/KWse1TwbAIw3
        6XIW4TOrw1kls50L1U6sjR4GU1T0Ug==
X-Google-Smtp-Source: AA6agR4lN1+7GX3YCJf/g+HqBAOkYjtAZV+sr5K0G3Nx6PLg9iKXtY/f1H3UDT4F3TWgC7ydjoSAksoqag==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6122:106e:b0:39e:e580:440 with SMTP id
 k14-20020a056122106e00b0039ee5800440mr10035328vko.37.1663102515183; Tue, 13
 Sep 2022 13:55:15 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:54:49 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205449.154966-1-nhuck@google.com>
Subject: [PATCH] drm/exynos: Fix return type for mixer_mode_valid and hdmi_mode_valid
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field mode_valid in exynos_drm_crtc_ops is expected to be of type
enum drm_mode_status (*mode_valid)(struct exynos_drm_crtc *crtc,
                                   const struct drm_display_mode *mode);

Likewise for mode_valid in drm_connector_helper_funcs.

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of mixer_mode_valid and hdmi_mode_valid should be
changed from int to enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c  | 4 ++--
 drivers/gpu/drm/exynos/exynos_mixer.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 10b0036f8a2e..8453359c92e8 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -922,8 +922,8 @@ static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
 	return -EINVAL;
 }
 
-static int hdmi_mode_valid(struct drm_connector *connector,
-			struct drm_display_mode *mode)
+static enum drm_mode_status hdmi_mode_valid(struct drm_connector *connector,
+					    struct drm_display_mode *mode)
 {
 	struct hdmi_context *hdata = connector_to_hdmi(connector);
 	int ret;
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 65260a658684..82f676e6d21b 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1045,8 +1045,9 @@ static void mixer_atomic_disable(struct exynos_drm_crtc *crtc)
 	clear_bit(MXR_BIT_POWERED, &ctx->flags);
 }
 
-static int mixer_mode_valid(struct exynos_drm_crtc *crtc,
-		const struct drm_display_mode *mode)
+static enum drm_mode_status
+mixer_mode_valid(struct exynos_drm_crtc *crtc,
+		 const struct drm_display_mode *mode)
 {
 	struct mixer_context *ctx = crtc->ctx;
 	u32 w = mode->hdisplay, h = mode->vdisplay;
-- 
2.37.2.789.g6183377224-goog

