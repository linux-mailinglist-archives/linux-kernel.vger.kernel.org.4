Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896215B538B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiILFaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110228E35
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:15 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y15so3995966ilq.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mSClBv+YMHjCelLo1EhsewE6hP3wTbgC0DRNv0VPhHs=;
        b=StDGxERICaNtO/MWOKOgGPpN0K/uy13ONokxOkqYAaZjX4KHAFnRfhTBCc8bQhit2y
         gZ3Ur1wskb70k9V1X9Ri0sdLVe5gMaVvXggpW/8GLtLDasXI3SwKAh9hsDCAiGf9etTX
         VKoftvlSsWhFNzRgf6bemRyfW4xndlHtY2NeTaav7UHg/DS296GlPC+y9dgRFppIDy2N
         S4ica+O5t6X0MzR0pVGPNyA6AHxlFkKlLWnTV0d+xhCXTrQPCy2KtUCPBkLDFGGvxXBi
         4hYd5j6zidurXvxchTCxDDr/jsVm2aDJvfe8y6mB3bozzLYGhNkpdaRhdFxmcwDcfocy
         cjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mSClBv+YMHjCelLo1EhsewE6hP3wTbgC0DRNv0VPhHs=;
        b=bvZVe1CRXjJL+JzW2G1GEVDJ51xJmJSQOT1Ww7Lr1FIu5sIKtel5MalhSwVIGLbJCk
         SlUDo0ZSjae8lHODZvxXVod1kLWqdmlZvY2VFncSy55z/0LvEo7TEjpVtyQ+vRNi+G4R
         rKXPcYp4NZmcJ52YEwTMGoMh2qaNLvYBgSq7yQa2A+qxOSX2CRhF2tubO3z7N1NtSc82
         5MNUD1Bp9fQM2jWANlY6CVUtrl47NfKL5aaa8DV5C22euk3rxOiED5zMcPWhNvHEcQOL
         KaTuhveOZDovKvTBXc/xTs+jZxNzvCT7fyDz5CbEATbWaUJmopBQjsKxC4pOV0cc3EKW
         KwUQ==
X-Gm-Message-State: ACgBeo2D1yEH8OKyuXb5Uhn349KYP0CcFkX9zJKiOtQZS3USXHGsERJZ
        2IsHkyFk0COuKLHKioBnqCg=
X-Google-Smtp-Source: AA6agR6WOElTbvZcWBDLNgRT1L6h9WJGhihQJW5zGPjIJBCSEhK0r/DX6Fq17h9F3h/cF/FQ/QryDw==
X-Received: by 2002:a05:6e02:214f:b0:2f1:87fb:783b with SMTP id d15-20020a056e02214f00b002f187fb783bmr9708111ilv.161.1662960554820;
        Sun, 11 Sep 2022 22:29:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:14 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 9/9] drm_print: add _ddebug descriptor to drm_*dbg prototypes
Date:   Sun, 11 Sep 2022 23:28:52 -0600
Message-Id: <20220912052852.1123868-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220912052852.1123868-1-jim.cromie@gmail.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

upgrade the callchain to drm_dbg() and drm_dev_dbg(); add a struct
_ddebug ptr parameter to them, and supply that additional param by
replacing the '_no_desc' flavor of dyndbg Factory macro currently used
with the flavor that supplies the descriptor.

NOTES:

The descriptor gives these fns access to the decorator flags, but they
do none of the dynamic-prefixing done by dynamic_emit_prefix(), which
is currently static.

DRM already has conventions for logging/messaging; just tossing
optional decorations on top probably wouldn't help.  Instead, existing
flags (or new ones, perhaps 'sd' ala lspci) can be used to make
current message conventions optional.  This suggests a new
drmdbg_prefix_emit() to handle prefixing locally.

For CONFIG_DRM_USE_DYNAMIC_DEBUG=N, just pass null descriptor.

desc->class_id is redundant with category parameter, but its
availability is dependent on desc.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c |  8 +++++---
 include/drm/drm_print.h     | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ec477c44a784..5b93c11895bb 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -29,6 +29,7 @@
 #include <linux/moduleparam.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 #include <drm/drm_drv.h>
@@ -278,8 +279,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		   const char *format, ...)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -287,6 +288,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	if (!__drm_debug_enabled(category))
 		return;
 
+	/* we know we are printing for either syslog, tracefs, or both */
 	va_start(args, format);
 	vaf.fmt = format;
 	vaf.va = &args;
@@ -302,7 +304,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 }
 EXPORT_SYMBOL(__drm_dev_dbg);
 
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 9af57d3df259..a44fb7ef257f 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -354,9 +354,10 @@ static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
 __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
-__printf(3, 4)
-void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...);
+struct _ddebug;
+__printf(4, 5)
+void __drm_dev_dbg(struct _ddebug *desc, const struct device *dev,
+		   enum drm_debug_category category, const char *format, ...);
 
 /**
  * DRM_DEV_ERROR() - Error output.
@@ -406,11 +407,11 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
-	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+	__drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
 #else
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
-	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
-				   dev, cat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(cat, fmt, __drm_dev_dbg,		\
+			       dev, cat, fmt, ##__VA_ARGS__)
 #endif
 
 /**
@@ -514,17 +515,17 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
  * Prefer drm_device based logging over device or prink based logging.
  */
 
-__printf(2, 3)
-void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
+__printf(3, 4)
+void ___drm_dbg(struct _ddebug *desc, enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-#define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#define __drm_dbg(fmt, ...)		___drm_dbg(NULL, fmt, ##__VA_ARGS__)
 #else
 #define __drm_dbg(cat, fmt, ...)					\
-	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
-				   cat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_cls(cat, fmt, ___drm_dbg,			\
+			       cat, fmt, ##__VA_ARGS__)
 #endif
 
 /* Macros to make printk easier */
-- 
2.37.3

