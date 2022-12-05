Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C904642C97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiLEQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiLEQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:10:28 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE071D0E8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:10:24 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z9so5278277ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9ZyX2rEEt8xF2wnMR144cVYnIHvQWhY/Asi+jCe8jQ=;
        b=BbF+/9gxLsIAvlzG5e99rniqZ8QtSEy3GUPRMo4iUlbF7n9TKdMzRkhwGZr0pZd83n
         BYSrKV8Z0spcFDmyZ5FkEKG78cH16hQo67px8xAk8O6oKXLKv1ko8/6J52VllQ/W4DM8
         pb84giAl7+/Am6D/aSKiqNwJGp/2XqSLKCiVmJNIM8GTRXqvc+mwZ5nRSYDp9HC4nOWV
         JvN8sK2Cb4S/uzfEx1kCXSOfMkuBWHLYSPDeGXEjJYS3iVhxhC9EVsKKcpIFRJk0lw8Z
         XNYraRQUc6f8ZuPEZWCWHcqDcihYp5aTyh3XOsSwLQrObF3DOFgig2vf83ntzXv4Skfw
         jPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9ZyX2rEEt8xF2wnMR144cVYnIHvQWhY/Asi+jCe8jQ=;
        b=wDC4RgI45uWaAfFA5h65ev48hcCVuIo6Gpc/zT1w8pxY0EkoG+ud2DnZRwBt8gPepz
         IH/yJj2Jpl5XF+vsj4otZBu6Wc0ibWC162ceQBlzSD0K+N1dkgH0nJKFzxVaqHnQCWH2
         j/aIY9MLvcsDhe7XTlejskqFeclgBUOJTEDDtsvbUUJzC5tSxAFFaUAp47Z6SJ/yJtgZ
         V6b9oSLCg5+ZddQgQl4bmUlwlysmo+HW4kds60aJIhB2uZfLNg0zGKcJlUBNBZ+Rla6v
         af+iGhl47ZWd5eQExQ45vcAHLGzfuuN9KngUAr0U+neslD+QQ/OGnfgIuF3Hno3PvK1M
         UYuA==
X-Gm-Message-State: ANoB5pldbkHqEg6sHnGaFYXnJqAwKGuVHpVr3HoYR+SJE3Y4uwPdqroV
        8TkmIM5eLqigKKTBhWeZdBhFwGGflUs=
X-Google-Smtp-Source: AA0mqf7gyM+3GXVNt+XxI7afuxs5bxazGf+dEtxuz9uSFRi6e0cSSJYTYUXq+1dhcZil9FTD4PvjiA==
X-Received: by 2002:a05:6e02:1e05:b0:302:cc74:920c with SMTP id g5-20020a056e021e0500b00302cc74920cmr31013025ila.262.1670256623097;
        Mon, 05 Dec 2022 08:10:23 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g19-20020a05660226d300b006bcd45fe42bsm6017753ioo.29.2022.12.05.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:10:22 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] drm_print: fix stale macro-name in comment
Date:   Mon,  5 Dec 2022 09:10:05 -0700
Message-Id: <20221205161005.222274-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205161005.222274-1-jim.cromie@gmail.com>
References: <20221205161005.222274-1-jim.cromie@gmail.com>
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
index a44fb7ef257f..e4c0c7e6d49d 100644
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
2.38.1

