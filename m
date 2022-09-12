Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3865B538E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiILF3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiILF3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA883240B1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s11so3993279ilt.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hvW6/T6Cu72NQNfFfc0LhYHeClJNDYHLK7XVJp6RWjY=;
        b=eppAjAsuUmGBxIeOj6rGT5Zzj4kd14EFQg7EeefJa06tgwqgcjL7pCtXjIqpTgMxTu
         IWg9xEhhX2cRxVmomkNo5CVf8pUgpx8USZA+YnIwiOD3whjJ11U6bebniALvADonx8Wb
         jKfs6HSmgUBSuF8noAcfkvEAqXRd+zKU/jMwZahue/n+QMxo6WK5q3ddpkwVDT1hLzJo
         XOrNKwsJQXSMFEDsDF1lC37OceslIDiHLe4MBDdzp0L/VCEQyqLyKOKSkDDmETPXA6Ql
         F2+VVER5RKWQ6VwhtRdejFqwE2dBTM6gpZ9/y9lGJ70Yu/CoL7S/H07XF9of86iaf9He
         sh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hvW6/T6Cu72NQNfFfc0LhYHeClJNDYHLK7XVJp6RWjY=;
        b=IxOMt4pROrh+/cnif631asaq5L+AeiZdxQWCzwg7VPtBpAoQq6ibNWE066lzcj2rcI
         On/hVr4HWgJGGFOC6s+Q8XY784dD0Atvl9/Pm0ZSaOS17/mWEmQ5zK3xssE1p8RuBDPJ
         NdiO5901qEy6sK2Euyhia1dmyO3r61CceWk4Xr2M7WhHWWuGaUxtCpYdkSPSWDyNcbIZ
         fbQSY8LUq7KWrkCaT9SnRGrJ2Ij+oJpBRGI5Uxc4xCDeKmWle462Ab/SFWKZPmk/PWpN
         bJZOc3Q89Ip9ukHlK3L0/4oewju0kHZ/Hw4sDR4WYNjNvAPqSrDYq7cS7ZICIVdGoH4I
         gW5Q==
X-Gm-Message-State: ACgBeo1cOHfoVbjlHZTLJ2Jq2Pzx29MUquNNqGEPHiqAojwlwNeLwKSf
        rKa4UM8YdpjTI/FR4IusgCI=
X-Google-Smtp-Source: AA6agR4VJPaBwHPf7er126QoRWoFsAbD2ztO278tK6mflIQcNK3updSOLOr20syBs+uCTsSAZ5nxdQ==
X-Received: by 2002:a05:6e02:1524:b0:2ec:71c6:7b85 with SMTP id i4-20020a056e02152400b002ec71c67b85mr9839711ilu.237.1662960549182;
        Sun, 11 Sep 2022 22:29:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:08 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 4/9] drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro
Date:   Sun, 11 Sep 2022 23:28:47 -0600
Message-Id: <20220912052852.1123868-5-jim.cromie@gmail.com>
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

For CONFIG_DRM_USE_DYNAMIC_DEBUG=y, wrap __drm_dbg() & __drm_dev_dbg()
in one of dyndbg's Factory macros: _dynamic_func_call_no_desc().

This adds the callsite descriptor into the code, and an entry for each
into /proc/dynamic_debug/control.

  #> echo class DRM_UT_ATOMIC +p > /proc/dynamic_debug/control

CONFIG_DRM_USE_DYNAMIC_DEBUG=y/n is configurable because of the .data
footprint cost of per-callsite control; 56 bytes/site * ~2k for i915,
~4k callsites for amdgpu.  This is large enough that a kernel builder
might not want it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig  | 12 ++++++++++++
 drivers/gpu/drm/Makefile |  2 ++
 include/drm/drm_print.h  | 12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6c2256e8474b..2438e0dccfa1 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -50,6 +50,18 @@ config DRM_DEBUG_MM
 
 	  If in doubt, say "N".
 
+config DRM_USE_DYNAMIC_DEBUG
+	bool "use dynamic debug to implement drm.debug"
+	default y
+	depends on DRM
+	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
+	depends on JUMP_LABEL
+	help
+	  Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
+	  Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
+	  bytes per callsite, the .data costs can be substantial, and
+	  are therefore configurable.
+
 config DRM_DEBUG_SELFTEST
 	tristate "kselftests for DRM"
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e7af358e6dda..6828197967a6 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+
 drm-y       :=	drm_aperture.o drm_auth.o drm_cache.o \
 		drm_file.o drm_gem.o drm_ioctl.o \
 		drm_drv.o \
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index c429c258c957..2d2cef76b5c1 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -384,8 +384,14 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
 	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+#else
+#define drm_dev_dbg(dev, cat, fmt, ...)				\
+	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
+				   dev, cat, fmt, ##__VA_ARGS__)
+#endif
 
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
@@ -492,7 +498,13 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#else
+#define __drm_dbg(cat, fmt, ...)					\
+	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
+				   cat, fmt, ##__VA_ARGS__)
+#endif
 
 /* Macros to make printk easier */
 
-- 
2.37.3

