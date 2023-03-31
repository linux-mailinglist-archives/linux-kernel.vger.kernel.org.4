Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA496D2AFA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjCaWMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjCaWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:12:23 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EF85279
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:22 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5463fa0c2bfso110509277b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680300742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41g0gNip8PYtsk9bkFs48ZdWfSIXcjOsD7LB6Xshlhc=;
        b=lHoMWIFJTuqI+8Cwf2cHlVcCn/m4jjolUFhI/WQbjtrqeI/y/RQdSMCUS5dRtKjPDb
         DlYjsOvV/xD5u3tQVGIShaYjyddVjs0gbX1g0+nKv3YfRrFw3cVlycus6fwJF0Zj8bWv
         hCFALCWenLouG3eC+5I+lZSlO9QWPFxR7oe+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680300742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41g0gNip8PYtsk9bkFs48ZdWfSIXcjOsD7LB6Xshlhc=;
        b=PA7zItyyPeoNbm64yPqXX16GPJF48KI47Me1Sy5L1CLYi8PFlZSEQef+XIdME6YyB6
         pvK0XbC/xnbdmZFIwIzzwzzt0wPP25acg84+NDUdPbBc4H9b1CyH82HhCXtooMV8odOb
         nv4MLhmb51TT1kwLEiiczxQGBsg91Tn94BcBjLIVBm9RBM+BLFLNCyeU71d7fU/OBj60
         fy/pQiMaNAPdKqVlOKciTlcQ7dNnwsiYp20yKFJHocaF3jAvJYX+Vqe0bseTZCAHxoyW
         Kb/xZ6ySoTgTcTG+B7kE516LebwUEOu5nqXgGq8XHOKk+YJe5xd63nnpVXuuA5RmmZH6
         pKYw==
X-Gm-Message-State: AAQBX9eHQjb7diNaGv8NG/NSi8eRjdHGj63WDcfRrl4FSheoYSB7Dcby
        PoCkq30fk3ny2r/T9Ea3zS4qhw==
X-Google-Smtp-Source: AKy350aWWLZitIc4NBmciDyuRlAlsMqjsbroWOg1uVcQuHufgHyzzdwjAPbP0Au4zEn/DHJnbrYMYw==
X-Received: by 2002:a81:7508:0:b0:544:e183:762d with SMTP id q8-20020a817508000000b00544e183762dmr29564744ywc.37.1680300742109;
        Fri, 31 Mar 2023 15:12:22 -0700 (PDT)
Received: from localhost ([2620:0:1035:15:a8f6:869a:3ef5:e1d])
        by smtp.gmail.com with UTF8SMTPSA id bj5-20020a05690c044500b00545a0818501sm763457ywb.145.2023.03.31.15.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 15:12:21 -0700 (PDT)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     seanpaul@chromium.org, suraj.kandpal@intel.com,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mark Yacoub <markyacoub@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] drm/hdcp: Update property value on content type and user changes
Date:   Fri, 31 Mar 2023 18:12:05 -0400
Message-Id: <20230331221213.1691997-4-markyacoub@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331221213.1691997-1-markyacoub@google.com>
References: <20230331221213.1691997-1-markyacoub@google.com>
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
Changes in v8:
-None

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

