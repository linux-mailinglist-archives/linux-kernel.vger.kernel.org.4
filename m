Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061C66ABD7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 15:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjANOER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 09:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjANOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 09:04:14 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF867EC2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673705038; bh=kBGWBKHIIKQIpYxP0OzdkdWOafSEc8bDoiSabz6C4S8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Bu/P+uckxIILRoyNCCIE8VRlk2ynL7kwkt5QCnjI8E4VzpnbWqUcgqOZKpswfuiB8
         kOUpbmU41aiYEQLmTvpmUvOHUT3UU8nrCF4F+vYZUUp97ihVVKEm6mOjnrD09zU8QX
         AzjRnY9dHpRAAYvnXOBvwJFJWn9hKSQR6zRNwdM4=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 14 Jan 2023 15:03:58 +0100 (CET)
X-EA-Auth: 1SrSBt70RjsiUzKSXWkgrhGKybdJO3t+s2nn7krxM8MgIPE6VodeGCtCPIciVl4mp7id9IJhJBwpj6IDplEW3+KSCzFkV5SL
Date:   Sat, 14 Jan 2023 19:33:53 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] drm/i915/display: Convert i9xx_pipe_crc_auto_source to void
Message-ID: <Y8K2SS/zNiPAmLsS@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert function i9xx_pipe_crc_auto_source() to return void instead
of int since the current implementation always returns 0 to the caller.
Issue identified using returnvar Coccinelle semantic patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Please note: The change is compile tested only.


 drivers/gpu/drm/i915/display/intel_pipe_crc.c | 23 ++++++-------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
index e9774670e3f6..8d3ea8d7b737 100644
--- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
+++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
@@ -72,14 +72,13 @@ static int i8xx_pipe_crc_ctl_reg(enum intel_pipe_crc_source *source,
 	return 0;
 }
 
-static int i9xx_pipe_crc_auto_source(struct drm_i915_private *dev_priv,
-				     enum pipe pipe,
-				     enum intel_pipe_crc_source *source)
+static void i9xx_pipe_crc_auto_source(struct drm_i915_private *dev_priv,
+				      enum pipe pipe,
+				      enum intel_pipe_crc_source *source)
 {
 	struct intel_encoder *encoder;
 	struct intel_crtc *crtc;
 	struct intel_digital_port *dig_port;
-	int ret = 0;
 
 	*source = INTEL_PIPE_CRC_SOURCE_PIPE;
 
@@ -121,8 +120,6 @@ static int i9xx_pipe_crc_auto_source(struct drm_i915_private *dev_priv,
 		}
 	}
 	drm_modeset_unlock_all(&dev_priv->drm);
-
-	return ret;
 }
 
 static int vlv_pipe_crc_ctl_reg(struct drm_i915_private *dev_priv,
@@ -132,11 +129,8 @@ static int vlv_pipe_crc_ctl_reg(struct drm_i915_private *dev_priv,
 {
 	bool need_stable_symbols = false;
 
-	if (*source == INTEL_PIPE_CRC_SOURCE_AUTO) {
-		int ret = i9xx_pipe_crc_auto_source(dev_priv, pipe, source);
-		if (ret)
-			return ret;
-	}
+	if (*source == INTEL_PIPE_CRC_SOURCE_AUTO)
+		i9xx_pipe_crc_auto_source(dev_priv, pipe, source);
 
 	switch (*source) {
 	case INTEL_PIPE_CRC_SOURCE_PIPE:
@@ -200,11 +194,8 @@ static int i9xx_pipe_crc_ctl_reg(struct drm_i915_private *dev_priv,
 				 enum intel_pipe_crc_source *source,
 				 u32 *val)
 {
-	if (*source == INTEL_PIPE_CRC_SOURCE_AUTO) {
-		int ret = i9xx_pipe_crc_auto_source(dev_priv, pipe, source);
-		if (ret)
-			return ret;
-	}
+	if (*source == INTEL_PIPE_CRC_SOURCE_AUTO)
+		i9xx_pipe_crc_auto_source(dev_priv, pipe, source);
 
 	switch (*source) {
 	case INTEL_PIPE_CRC_SOURCE_PIPE:
-- 
2.34.1



