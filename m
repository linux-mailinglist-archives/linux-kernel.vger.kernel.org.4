Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5184C624388
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiKJNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiKJNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:48:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCB61745
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:48:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k8so2357100wrh.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLY2eEQFguZMIlY74s69pwkJXEOkjmvxBO7cb3VXH9s=;
        b=fhAPyBkyxhDKeTqg+JqZWQsY4umNf4sYfDnF8USCVvvFTZSNZHUo+JQvef272pkr1c
         8I8aqC079tWCHZA/lNHvCzVqIvMVo51wS49wNbWWVRx9uR2UOaewRAcumne6bktPlaIL
         xez1MlDj8nAsglT7znRsVL3Il1ow8jY3Qxtv7oC1U3Emru5vkfr8gpyjcIGPPnAZ1Lac
         TB7xf61siUjU2WBFyXwRvlKoCO1ji6PdXb8xsSsjhGIuIMZ1bWfsKbYmjvZGHu5y2fe9
         LI0JVeHIloPW2F/9uBZKAeupKYCh33DPq67V+ryoKT5YLPqFM1z6e3hKyjia1x8gVtk+
         uvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLY2eEQFguZMIlY74s69pwkJXEOkjmvxBO7cb3VXH9s=;
        b=3ywfdC95kMM6FJU5L5qTWsvf3IVunTC4Np2x5wurCuzd3NHwZoB7oI8ZcbpJuZv6qD
         jO7bhCMTfK5OKU+40NwGTLCU1v2SoPM+M/i6qRp2pKRWnU3YSnOy4Yq3WK26wDNIECcE
         UI5cI66MthKkW4PTY23ovpyd78HgR/EJCPAYKQe4FCc1gwIbksDHSSaZFT2KRcCF+jBo
         kuAXF0raIORARikJiiyZ6agy37b0RPGiRjXzRIwd6rM0clP3JesZSkjFOL0SzEAxbR8t
         qx1X+r0NJ6j8379V5+hy5h5NyRyVxwLhalxZWwDvpG+SgWnRO340IB5PuB2UyKZfykck
         REtg==
X-Gm-Message-State: ACrzQf1uHYJ2EJO5oAkl7ekhFSp8Jho9a1h5tJGpxqgKQtJ5+5qrom7M
        KTMMqV6SK48Gcc+DO5+Ni18=
X-Google-Smtp-Source: AMsMyM6FTHfjKzU1+iMHW0JdWPMGdz7hTtjxHSpuh1O2USH3Dn1AglaEQKe2BBL0wK+BEiQTwrEwbw==
X-Received: by 2002:a5d:5a17:0:b0:238:589f:e610 with SMTP id bq23-20020a5d5a17000000b00238589fe610mr885821wrb.42.1668088079216;
        Thu, 10 Nov 2022 05:47:59 -0800 (PST)
Received: from localhost.localdomain ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0022ae0965a8asm15717060wrq.24.2022.11.10.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:47:58 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     mripard@kernel.org
Cc:     emma@anholt.net, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/2] drm/vc4: hdmi: Pass vc4_hdmi to vc4_hdmi_supports_scrambling()
Date:   Thu, 10 Nov 2022 14:47:51 +0100
Message-Id: <20221110134752.238820-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110134752.238820-1-jose.exposito89@gmail.com>
References: <20221110134752.238820-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify vc4_hdmi_supports_scrambling() by changing its first parameter
from struct drm_encoder to struct vc4_hdmi.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 0d78c800ed51..a49f88e5d2b9 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -124,9 +124,8 @@ static unsigned long long
 vc4_hdmi_encoder_compute_mode_clock(const struct drm_display_mode *mode,
 				    unsigned int bpc, enum vc4_hdmi_output_format fmt);
 
-static bool vc4_hdmi_supports_scrambling(struct drm_encoder *encoder)
+static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
 {
-	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
 	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
 
 	lockdep_assert_held(&vc4_hdmi->mutex);
@@ -321,7 +320,6 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 {
 	struct drm_device *drm = connector->dev;
 	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
@@ -349,7 +347,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	if (!crtc_state->active)
 		return 0;
 
-	if (!vc4_hdmi_supports_scrambling(encoder))
+	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
 		return 0;
 
 	scrambling_needed = vc4_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
@@ -867,7 +865,7 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
 
 	lockdep_assert_held(&vc4_hdmi->mutex);
 
-	if (!vc4_hdmi_supports_scrambling(encoder))
+	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
 		return;
 
 	if (!vc4_hdmi_mode_needs_scrambling(mode,
-- 
2.25.1

