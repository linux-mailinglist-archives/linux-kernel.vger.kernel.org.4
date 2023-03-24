Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479136C85D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjCXTVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCXTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:21:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F8B136EA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:21:09 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p15so3493786ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679685669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exj6+hryfx7clb9QaiGo28Nm0qDVjYvxkFoG4ObE4LU=;
        b=HiFhAennZ7QDfcVFoB2hqG5Q8Bxnn/Hndx9rv0x/8+PyhUbXqyAnJd+LGeNTjt9Y/T
         CnYABaW5l979X3mAv7mhqHmtN2XMYN3chJdJPx0r9VpfmqNxAHZ/RcqEKllQbYbXNCwJ
         4/hladp//G9rn7GyJPpV1mjKT/ivLugKUTHf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Exj6+hryfx7clb9QaiGo28Nm0qDVjYvxkFoG4ObE4LU=;
        b=Xj4ztUnVlGDhXrGNNIJjJVJaeMcSeKwTJb4+SBBw6/vIte+eAc5UAi6Ow89wE4cnza
         Q7Hh787N6SMQh4WzKPS1umMaWuo26+opeHvvyIeRL24O7Okpp3Zek9I7o9a+OfTgNo9S
         mn7Pf1wOPugtMOA5Flc9xOzMm5ehkiv4ciTvI2OYlRHcuTFZXHHObe/K2cACGf3++UHv
         xD0zjLfV+gW81obhwD+XKmApl1UVGw5S4TA0aotNwAyUeMZE81Ri2j4LU3hsALy7/g6w
         z18lz2qM06eZ3QVbJGY9hvFCWmMsQKh2Vme4FXpmkSacdZdAYZ2SasW63IILjewxGbgd
         LLNg==
X-Gm-Message-State: AAQBX9c5yenagEK5PunOhUXkv6TGDdad00tgOkz0XU8bXbAyooy8uygZ
        NnV1VD8WOE9ITt8MGscgPbxi4w==
X-Google-Smtp-Source: AKy350bVA0+T/s+nSUNlpc8gjsNcBtRABTJCpffLYB5sapm3gUOcXk1iwPa0qUZwmi/K12Lchc1Erg==
X-Received: by 2002:a25:10d4:0:b0:b6c:5b2f:ca61 with SMTP id 203-20020a2510d4000000b00b6c5b2fca61mr2646401ybq.26.1679685668745;
        Fri, 24 Mar 2023 12:21:08 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:5509:ec45:2b32:b39f])
        by smtp.gmail.com with UTF8SMTPSA id i11-20020a25220b000000b00b7767ca7488sm625068ybi.37.2023.03.24.12.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:21:08 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/10] drm/hdcp: Update property value on content type and user changes
Date:   Fri, 24 Mar 2023 15:20:50 -0400
Message-Id: <20230324192058.3916571-4-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230324192058.3916571-1-markyacoub@google.com>
References: <20230324192058.3916571-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Update the connector's property value in 2 cases which were
previously missed:

1- Content type changes. The value should revert back to DESIRED from
   ENABLED in case the driver must re-authenticate the link due to the
   new content type.

2- Userspace sets value to DESIRED while ENABLED. In this case, the
   value should be reset immediately to ENABLED since the link is
   actively being encrypted.

To accommodate these changes, I've split up the conditionals to make
things a bit more clear (as much as one can with this mess of state).

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromium.org>

---
Changes in v2:
-None
Changes in v3:
-Fixed indentation issue identified by 0-day
Changes in v4:
-None
Changes in v5:
-None
Changes in v6:
-Rebased: modifications in drm_hdcp_helper.c instead of drm_hdcp.c
Changes in v7:
-Rebased as function name has changed.

 drivers/gpu/drm/display/drm_hdcp_helper.c | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdcp_helper.c b/drivers/gpu/drm/display/drm_hdcp_helper.c
index 34baf2b97cd87..3ee1a6ae26c53 100644
--- a/drivers/gpu/drm/display/drm_hdcp_helper.c
+++ b/drivers/gpu/drm/display/drm_hdcp_helper.c
@@ -480,21 +480,30 @@ bool drm_hdcp_has_changed(struct drm_connector *connector,
 		return true;
 
 	/*
-	 * Nothing to do if content type is unchanged and one of:
-	 *  - state didn't change
-	 *  - HDCP was activated since the last commit
-	 *  - attempting to set to desired while already enabled
+	 * Content type changes require an HDCP disable/enable cycle.
 	 */
-	if (old_hdcp == new_hdcp ||
-	    (old_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	if (new_conn_state->hdcp_content_type !=
+	    old_conn_state->hdcp_content_type) {
+		new_conn_state->content_protection =
+			DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		return true;
+	}
+
+	/*
+	 * Ignore meaningless state changes:
+ 	 *  - HDCP was activated since the last commit
+	 *  - Attempting to set to desired while already enabled
+ 	 */
+	if ((old_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
 	     new_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED) ||
 	    (old_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
 	     new_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED)) {
-		if (old_conn_state->hdcp_content_type ==
-		    new_conn_state->hdcp_content_type)
-			return false;
+		new_conn_state->content_protection =
+			DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		return false;
 	}
 
-	return true;
+	/* Finally, if state changes, we need action */
+	return old_hdcp != new_hdcp;
 }
 EXPORT_SYMBOL(drm_hdcp_has_changed);
-- 
2.40.0.348.gf938b09366-goog

