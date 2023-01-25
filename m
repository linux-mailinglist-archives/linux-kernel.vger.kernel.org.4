Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B367BD11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjAYUjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbjAYUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:38:29 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D417CF1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:13 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m8so8722ili.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbXnJe4SwHWreda4y6VYBVk5VMF1Xs4ho+xFcctOhbY=;
        b=mR33HGxaM6bUMu7S35LzQkGJTcQjq0lvhxxT2aG81KmMjpbT2xjVYoeIWCg0dQuevQ
         r/KgAsntbni/1hh9esQVBplBflw/8FF/NJeLCTzNOoO6Sex1+b4bwyL8heJMrKQygZ5q
         S2XiyVnYPuv1PlOI4mwdT0EVUqgW34IgL2xBZXj+xvBcfJFwk9QG+7pQ34vZwGlYBe2g
         4Mpz5a4okYGtB1oE9FgILiZF081RaiZzmd4DihhnYgNFwIaZ8N3D4LCVywlVovrs7RGK
         HIy99zte576mcRau4jL+XZj90LgrOlGWXNJRVnPjEbmfyDNGcf2YWsq4W0zkW77aWftw
         sQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbXnJe4SwHWreda4y6VYBVk5VMF1Xs4ho+xFcctOhbY=;
        b=KhrUb38xser3urXEY2UtBcmwEPqyV6lOHYTEE+8wAyyPLLN6QrAQj64JFSRUTAbH/F
         JAXqllLrhG2Hm0HpGH0xVmtBUqfZzd6Jjs6gWROqS6N0IPnBsLrwQNsJrObocdwU48Eb
         I/e5q0UtmiARCfl8lZ8Q4E1rgFghrUA+Y16mfauYuVsGiVuW7oIBM4XKKlY1M3cvfQSU
         PIApj8S0+L06u7fxSd70XaSZ6S+8XSyjfCZklMxWZnT5S4/RUScjycKYnQNFRdF07Kuf
         Jna/Edn7ngzHs/qMXtupZQnBjgSB8J10Eta2H3ykHa6/y4aBUvLjxoM3R1tJ0rcv9LVG
         yDtg==
X-Gm-Message-State: AO0yUKWL/fW9MtszLEMW0QdyrleT8Xf8oYbUI0yzqNGceaWiLT2BgAU6
        ydNPbGuUM1JOVl1UalGuewMF9g5FVIc=
X-Google-Smtp-Source: AK7set9ABQ8erawx9YyTx46zZ4uRp27C6Q7K2v1b/MHVNahl9s9L/HEYA3KWWdjqBuga/NGYLb5emg==
X-Received: by 2002:a05:6e02:1c82:b0:30f:8aed:d4c9 with SMTP id w2-20020a056e021c8200b0030f8aedd4c9mr7650141ill.19.1674679092225;
        Wed, 25 Jan 2023 12:38:12 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a056e02128b00b00310a599fd43sm665104ilq.46.2023.01.25.12.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:38:11 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 14/19] drm_print: fix stale macro-name in comment
Date:   Wed, 25 Jan 2023 13:37:38 -0700
Message-Id: <20230125203743.564009-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125203743.564009-1-jim.cromie@gmail.com>
References: <20230125203743.564009-1-jim.cromie@gmail.com>
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
2.39.1

