Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB96981B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBORP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBORPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:15:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7190625B81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:15:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq19so20774324edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeWRyuFleO3KJb/h2GJE0oBEJSU8MTaTLYVWy9KfUOo=;
        b=MA5jkvllzwLf/q9wufokoK6xLsdQdp99/0SfHl1GmEntzIlfg1JJuOR9hhkoQVxn8S
         G7JLLT6txnudsMQMxIzGGH6eR9vZ2vke1GF5hssjevc+jcFSIA3nNXj54W4waCikKup6
         DSKLvuov8en1c7C4fPA3bC0u/2sULBoz/XhclqO/fwcBTuFkcN/WHJRqezoXfCPKs5uw
         8A/0gEL6ld3k0KmBDvNRjMHLQBrf3zQ0B4xhmHbphtTEsdKdm0MsinDfLnEPsQDQ6526
         O9618T2u6mtgWWBHHc0rtzJuCh0mCd5V5C7Yx0PHk2hRWhR4wiq+5vwXmD6o6XwhldXx
         Gc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeWRyuFleO3KJb/h2GJE0oBEJSU8MTaTLYVWy9KfUOo=;
        b=pkmo2qSSRxh1jag2ZLatvyKG+ZiLkOfoZPm8DBh76WuuLypXq8hFSgpwElig4BECei
         WXV387jFPMoTEFnZlk1kdDNtyBdJiuilS1ma1zjKViJkUtyF/qEzKg7dnVY1Kg9Mysk+
         kVJYzTX2rD/hQNSKtn1RCn8MGish9LxAn0HrumtAkKlgGeektU1NHT2TZlz0zL/423+k
         ZMxJMDkkNYxfv8YP9dd01cUfJU46jBwwpjFzl3lzzpYd+LEw53yklnl0Aw4bu5bNiork
         fGVGNX3rdVd0UvilQkgL81ZhCSFmimaXy77mGTjpFSWtLUqm+YUZBRtlqRfhm4I9zHlt
         VKwg==
X-Gm-Message-State: AO0yUKXY8mZlC7TrbP5yC6hUoSVJh/LPaDaPEimlYZL70rPam4Guzju4
        1HbepF0D2Aqwxv4R9N0lCok=
X-Google-Smtp-Source: AK7set8S2sHQX/04ttSLge2J2bfBtu0qw81RTYOPWF+CDkB/jXDpM0eYORUQp25j6FguTj6Xh10pdg==
X-Received: by 2002:a17:907:9801:b0:8aa:c261:f2a5 with SMTP id ji1-20020a170907980100b008aac261f2a5mr180497ejc.12.1676481352918;
        Wed, 15 Feb 2023 09:15:52 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8bf8:8b00:45ad:97c9:5be5:8b8e])
        by smtp.googlemail.com with ESMTPSA id y25-20020a1709064b1900b008b05b21e8aesm7045063eju.172.2023.02.15.09.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:15:52 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Alexandr Sapozhnikov <alsp705@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] gpu-drm-tiny-cirrus: Add NULL check of pointer pipe->plane.state->fb in cirrus_pipe_update()
Date:   Wed, 15 Feb 2023 20:15:49 +0300
Message-Id: <20230215171549.16305-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to NULL value at cirrus.c:455, pointer 'pipe->plane.state->fb' is passed as
1st parameter in call to function 'cirrus_fb_blit_rect' at cirrus.c:461, where it is dereferenced at cirrus.c:316.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/tiny/cirrus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 678c2ef..ffa7e61 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -455,7 +455,7 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 	if (state->fb && cirrus->cpp != cirrus_cpp(state->fb))
 		cirrus_mode_set(cirrus, &crtc->mode, state->fb);
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (state->fb && drm_atomic_helper_damage_merged(old_state, state, &rect))
 		cirrus_fb_blit_rect(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-- 
2.5.3

