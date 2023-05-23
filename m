Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027DF70DD06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbjEWMwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjEWMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76162DB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684846284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bAprbvbicDzO/i64xE13RGPcGm8TJil9TJRhodKNwUQ=;
        b=F1qtZIMDOZZkatQIKL3MuCKBCZVaooEluI0rGSg5R9nPcjBKZdNmZxHkcxs1ZhWSYo01Yu
        14xcHnHtFaxVxfD3Mm8Cy4luNXS4+Higz+x6ZOp+cVCG4o9g09eRhCVdVB4MA8XE3sWKbW
        s2jv0EdSzOlIgDjFnwiGhZaOBn0btmg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-UPDLuN_7NDWgvRCUDKxBsQ-1; Tue, 23 May 2023 08:51:23 -0400
X-MC-Unique: UPDLuN_7NDWgvRCUDKxBsQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75935a16b8eso580620685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684846283; x=1687438283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAprbvbicDzO/i64xE13RGPcGm8TJil9TJRhodKNwUQ=;
        b=kxsHSaowRoKKCacaCHVrrlBNDT3BUuYMVRt/eRY1AqGijzutwKx7JY9T07i0fXjCWU
         kmuZ0SOgv0P/W3i/cd98Z58N9O+gFN7u6TXOIYOzE54bbhRVTPL8PGg7SMy5KEpGQQS5
         XLfOHCVryj/5z51sn0BO5Md5DzWV2F9YahkYn63gpx+WUAL4GD/f2+Prq6whWee/hM5b
         7mXbpYFGL9XXeycH8SayO6vdoU224CbE83QBZGy89ERMNy/ATSwlTNCno3a9EdiU2+py
         aPMdtymbUBA3mSeFsjX1P7TQN4zRqVzW8F2wwWy6BLG5WxOzJrZEhm89Jd/79iFrhgjA
         GMNA==
X-Gm-Message-State: AC+VfDzZPbS2CiJi7HQ5CnA3sG2llkCTJo8H1IwLB1Trj3tayYqgI4ZI
        R4HNFK+K9qU0KZ2eDNpNz3JV7RrWrKTtfol6cVtJQT9bRvI67hr5P6+7j7xEwWdapf/5EWbYX3X
        MKFvhynHGRPq1ZRmVCZdarq+h
X-Received: by 2002:a37:88f:0:b0:75b:23a0:e7ed with SMTP id 137-20020a37088f000000b0075b23a0e7edmr3850975qki.78.1684846282950;
        Tue, 23 May 2023 05:51:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GUZvQqUqL8jnjS5iId8YX67qOidNHrEO9Bxwn07WXAbE7b7d2NbJu1BrYJ46XQnyjQLxqgg==
X-Received: by 2002:a37:88f:0:b0:75b:23a0:e7ed with SMTP id 137-20020a37088f000000b0075b23a0e7edmr3850948qki.78.1684846282675;
        Tue, 23 May 2023 05:51:22 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c3-20020ae9e203000000b0075b35e72a21sm7626qkc.86.2023.05.23.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 05:51:21 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com, ville.syrjala@linux.intel.com,
        imre.deak@intel.com, arun.r.murthy@intel.com,
        lucas.demarchi@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/i915: simplify switch to if-elseif
Date:   Tue, 23 May 2023 08:51:16 -0400
Message-Id: <20230523125116.1669057-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/i915/display/intel_display.c:6012:3: error: unannotated
  fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
                case I915_FORMAT_MOD_X_TILED:
                ^

Only one case and the default does anything in this switch, so it should
be changed to an if-elseif.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 0490c6412ab5..1f852e49fc20 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -5994,8 +5994,7 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 		 * Need to verify this for all gen9 platforms to enable
 		 * this selectively if required.
 		 */
-		switch (new_plane_state->hw.fb->modifier) {
-		case DRM_FORMAT_MOD_LINEAR:
+		if (new_plane_state->hw.fb->modifier == DRM_FORMAT_MOD_LINEAR) {
 			/*
 			 * FIXME: Async on Linear buffer is supported on ICL as
 			 * but with additional alignment and fbc restrictions
@@ -6008,13 +6007,10 @@ static int intel_async_flip_check_hw(struct intel_atomic_state *state, struct in
 					    plane->base.base.id, plane->base.name);
 				return -EINVAL;
 			}
-
-		case I915_FORMAT_MOD_X_TILED:
-		case I915_FORMAT_MOD_Y_TILED:
-		case I915_FORMAT_MOD_Yf_TILED:
-		case I915_FORMAT_MOD_4_TILED:
-			break;
-		default:
+		} else if (!(new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_X_TILED ||
+			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_Y_TILED ||
+			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_Yf_TILED ||
+			     new_plane_state->hw.fb->modifier == I915_FORMAT_MOD_4_TILED)) {
 			drm_dbg_kms(&i915->drm,
 				    "[PLANE:%d:%s] Modifier does not support async flips\n",
 				    plane->base.base.id, plane->base.name);
-- 
2.27.0

