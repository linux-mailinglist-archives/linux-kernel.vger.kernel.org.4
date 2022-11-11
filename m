Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03663626450
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKKWRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiKKWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:29 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974657B77
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:27 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id l6so3185828ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2uIhj+1kniLl98rxc2zGhFR3/ukaY2ppmVrEhlaB1M=;
        b=eplYE5X6uNXmUiYQeBqfuI/BDxP9+t/E/ns/FxNcmLmjgfFnpJuJkKQJ0UmFT3qrs/
         AwUE8VkjNjy9Vf85VXwHgfbS4fvL44x5SDItJFyqmnF5Jth0zUmgu2phi2/gQc2lQHG9
         s1KqgxBf3KkIEnrK9RsBlDhO3BR+LDp+Gycfa+/sha6Ox54KfOMMC8et3UBKuiREJL/E
         G9yvyErEP55T9w80uST+yv4ZdFV+waY/fCwV32PMwgxagO0HxDrsjzyVBuMZMFkuMUH+
         su4Z70L+aqjJ426bfG5pHPxpgaBp2fp25DIc7yaSctwfmKGXticmkvwuoQWbFfwKLZQt
         9liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2uIhj+1kniLl98rxc2zGhFR3/ukaY2ppmVrEhlaB1M=;
        b=heAuYskw60aP/6SUotlvwltxcIWwUL3ZZx58clJmH2FuBHVe771tf+9YoP3K58byuR
         sQG7Vmb4LEfYLXRpvviEvy6UkpQnQH9+aoOQtQvGPiz1EwoYUTa9mhWSbrhd/TLVASWC
         ZR2DvKl9Rnh5EDvZRWwLKiXpDJPgHUxz6xrrlVuKPNTBOygn9aHWUaJBjIpb5yqFCV4k
         XXSovv/IahifrYHSOn8pniCCGF9rI22tuXG0L03pcirGe0VgtKXsPCXnjvur7HUa+tji
         y8KVOgWPCWDQVTnjYsJQnpSKaU1cGD7C1PDAjPwLBYg95tYc5uM21TsBT+ySQuiJ6OlG
         FsxA==
X-Gm-Message-State: ANoB5plo7XSAkdN+JAe4EO3iUcIp5uEQJRs7PChxtLytfjZM2O5mKjdn
        k0qWibmsmx/f2FgVXBoTNtTFo2TFtmM7PJrY
X-Google-Smtp-Source: AA0mqf43Ej/2CvnoWy3aMeGYEZ2N6lV6eGpN+JDr5q1wxFnhlWtCr9BpR5BpvvdZgpLI0N+dBNEyBQ==
X-Received: by 2002:a05:6e02:1c03:b0:2fa:52cd:80eb with SMTP id l3-20020a056e021c0300b002fa52cd80ebmr1943790ilh.236.1668205047214;
        Fri, 11 Nov 2022 14:17:27 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:26 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/7] drm_print: fixup improve stale comment
Date:   Fri, 11 Nov 2022 15:17:10 -0700
Message-Id: <20221111221715.563020-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111221715.563020-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <20221111221715.563020-1-jim.cromie@gmail.com>
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

Cited commit uses stale macro name, fix this.  And improve the explanation.

When DRM_USE_DYNAMIC_DEBUG=y, DECLARE_DYNDBG_CLASSMAP() does the
mapping of DRM_UT_* onto BITs in drm.debug.  While this is still using
the drm_debug_category enum to do the mapping, its doing so somewhat
indirectly, with the ordered set of DRM_UT_* enum-vals.  This requires
that the macro args: DRM_UT_* list must be kept in sync.

fixes: f158936b60a7 (drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.)
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
. emphasize ABI non-change despite enum val change - Jani
---
 include/drm/drm_print.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a44fb7ef257f..06deb58d5af4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -276,7 +276,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *
  */
 enum drm_debug_category {
-	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
+	/*
+	 * Keep DECLARE_DYNDBG_CLASSMAP args in sync with changes
+	 * here, the values define BIT()s in drm.debug, so are ABI.
+	 */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
-- 
2.38.1

