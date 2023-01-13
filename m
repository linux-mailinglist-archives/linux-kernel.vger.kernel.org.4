Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CA766A360
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAMTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjAMTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:31:01 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993587CBE9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x6so6615690ill.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRyUl1j2CeLT2msyDi6y9qIAncSGOoQz3PjuRO1TezA=;
        b=iziQWeBJgoiaMWnT+DGKeHRFoxOg8Y//x6gVDHTO/o/B4A2YM/jQhz7hOa75kni4T0
         mENNP100auhPgXQopX+LQvdAUY+0nOJ/rj9kM64uDIVIOpiPwFwEYZyZagsSNUKXoJoT
         8fUlesHV9DvTWZ6X031dT4qAHFMG1Rr80Q/mR9+vzpDC0++MWi6MKKM4zBwpTSNvAuVI
         9VUcAIV2UMhcADTgaUB2SqjfobS982vS5b/639ZvSEiS7/aAsWMM38zXDLuV7Yjmndjm
         q0WFuObgL8VxnpyJ+sHbRJRJXhPMARzB2VyhnINlSLyAwmXDUahnRjHIgV5sebJwH44a
         euBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRyUl1j2CeLT2msyDi6y9qIAncSGOoQz3PjuRO1TezA=;
        b=hazJ/Jl915lbqKYB9WzucLlGM4g2ABX43gsp/Jn0m4t1J9kHYchJid9pwNJxKwZd+4
         WOMVTBRvDFaWe+COvObsMbPFLO7hcREGJwQSoWyQKbRdlY+XjC2ySAY5FOwUPPeVWbyR
         RXg62jESHaI0vK33qCD0ts+FGiO/OYgQdb/Kz0dx+Bo1B0xz7nbRWucTAVtK8AybWrKY
         iQYIwtb40IRYbOvcTedCGPndwv+rF7lsfia3UC1JUFnbIMjEilX5UzK1c4UjkE0nyvus
         gS9eM6ePhWcHQxPn4v/2KrEmD/cD3aNOvjleEeFfjTety5J4ZWpvmUpiHK7fnPhn1XOb
         +Wgg==
X-Gm-Message-State: AFqh2koRFkEiMHBMPoiXsHzuEdnQMzm3fBPAoQOBnOke7NjIVAA/scDi
        RwyswghL4jNmfPxGYRH1BrAkEOoabnj1Cw==
X-Google-Smtp-Source: AMrXdXtwfdAQ6WeQoeGyy+hEpdL1j6Nxnj9lnlS5pzsW0VhG/1M2+Rzc92ciwmwipotWIf+SkViSfA==
X-Received: by 2002:a92:7f03:0:b0:30c:54a1:e5d8 with SMTP id a3-20020a927f03000000b0030c54a1e5d8mr30477229ild.30.1673638257652;
        Fri, 13 Jan 2023 11:30:57 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e32-20020a026d60000000b0039e583abceasm6497289jaf.68.2023.01.13.11.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:30:57 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 14/20] drm_print: fix stale macro-name in comment
Date:   Fri, 13 Jan 2023 12:30:10 -0700
Message-Id: <20230113193016.749791-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113193016.749791-1-jim.cromie@gmail.com>
References: <20230113193016.749791-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cited commit uses stale macro name, fix this, and explain better.

When DRM_USE_DYNAMIC_DEBUG=y, DYNDBG_CLASSMAP_DEFINE() maps DRM_UT_*
onto BITs in drm.debug.  This still uses enum drm_debug_category, but
it is somewhat indirect, with the ordered set of DRM_UT_* enum-vals.
This requires that the macro args: DRM_UT_* list must be kept in sync
and in order.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. emphasize ABI non-change despite enum val change - Jani Nikula
. reorder to back of patchset to follow API name changes.
---
 include/drm/drm_print.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 6a27e8f26770..7695ba31b3a4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *
  */
 enum drm_debug_category {
-	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
+	/*
+	 * Keep DYNDBG_CLASSMAP_DEFINE args in sync with changes here,
+	 * the enum-values define BIT()s in drm.debug, so are ABI.
+	 */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
-- 
2.39.0

