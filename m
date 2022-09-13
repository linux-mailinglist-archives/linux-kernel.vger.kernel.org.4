Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0635B7C60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIMU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIMU4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:56:01 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350555FF4C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:59 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id n8-20020a9f3148000000b0039f22c5b291so3833330uab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=uR2BlBWxNwDXVN8KePRFZ054d83TeFIdqVCYAABhYhE=;
        b=KNxgHGMC5WX5o28iqf/s0dskwm5mmsxJ0wZRSSxynx4xdtWEgEz4Flo8Cw99zS5s5s
         KAgUjuccBs2bLOd+3qcCyeG9WsVLDIBdnmLU4P4jHYoMtXT6Phl4Z4EUd4Dvui5ye1K7
         XDHlIbQoqA3IcdUsiiZKKxznchTLyYiYmaH5m2Vpp0C5T47szsZiVlY0XKyreM127+RP
         vUY8sBQZx279lJcP8CQYOAXLV3rSP1srdtBWVGET+LZpJPkv0Mg+V7WNt997ptz2QJLh
         9kDaguBL6H0iTkRLN4T0gz+ptaMbOH5YcxaupcZmV+Vox7o6ANx6jw7gZsCWJSBZ4lMQ
         ZFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=uR2BlBWxNwDXVN8KePRFZ054d83TeFIdqVCYAABhYhE=;
        b=frvtk7/V95LMWAN4sExppz3KbiJk27m5+mDagVBupfkXb6m9d/6PMH6eQXQATDuAuu
         LzmO5bw2X40pkbJbC44qNFk8Vb1yGllum9TXbIAh30OHxxiQUTbkqv8NgnjK4AZcK3h6
         4Ao5BiiNsMaKsGpvF9p2YEqh3RzECI6j8I6d0BACAAVhOE0SjrHQV40CDzPXTycceA0g
         mjJpavH5ZmY1DcKIjPd8DPXPeX0LLiK3TdukYJBa6QwBA1XE1CYuRdEw/HSLCE0R1I6e
         lB8iNpxqvXlEsAyXZwF9GtqONy+RdRVEmHc4459K94+V6yEoDh3Fh1UjUnHkx7MTE7MT
         /wfA==
X-Gm-Message-State: ACgBeo3ZgQzyz9eHRuxMjuPqB4T7bOnMOTM040u5j2MTVVrRgRb44IYs
        JqN2HVLO3VUtSv2CVGIZl7tR0ZLDhg==
X-Google-Smtp-Source: AA6agR6BKp9O4/iCA7qsoXlt+ctid4gFcnrvB+lLTtzXiws1cBAzJPZ8bBFJc6NV4pZunK7Q1bkvTIRxbQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a1f:b40a:0:b0:3a2:5af2:4750 with SMTP id
 d10-20020a1fb40a000000b003a25af24750mr3582947vkf.0.1663102558921; Tue, 13 Sep
 2022 13:55:58 -0700 (PDT)
Date:   Tue, 13 Sep 2022 13:55:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913205555.155149-1-nhuck@google.com>
Subject: [PATCH] drm/rockchip: Fix return type of cdn_dp_connector_mode_valid
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Sandy Huang <hjc@rock-chips.com>,
        "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

The mode_valid field in drm_connector_helper_funcs is expected to be of
type:
enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
				     struct drm_display_mode *mode);

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of cdn_dp_connector_mode_valid should be changed from
int to enum drm_mode_status.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index c204e9b95c1f..518ee13b1d6f 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -283,8 +283,9 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
-				       struct drm_display_mode *mode)
+static enum drm_mode_status
+cdn_dp_connector_mode_valid(struct drm_connector *connector,
+			    struct drm_display_mode *mode)
 {
 	struct cdn_dp_device *dp = connector_to_dp(connector);
 	struct drm_display_info *display_info = &dp->connector.display_info;
-- 
2.37.2.789.g6183377224-goog

