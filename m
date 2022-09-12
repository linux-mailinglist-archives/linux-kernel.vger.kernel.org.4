Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF35B5391
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiILF3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILF3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:09 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F1B24096
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b17so4016554ilh.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BxsNyjaSCN3M5RS6ZFNO6kAmQm4emaU2OKjak3iFgTE=;
        b=StO/GsB8hj9YkNNltx4lvRbnjAHnbJxchSfOXJVSs2L/Oxd8JlcfwqNENxoWBghF4I
         n2P058InrElqYFUqnE9tzBt8jzivZqs1vK+FW1qEma1mlNIEsVDWJY10NmDhSq/GjEg9
         AuqKnPkag4XdKpkjIDqz0sOX9Ee/SZ1v7Aq/A7104ww+9jhQA/N+f5QF0fj6I+KAb52A
         xLDo0BarRly1Z4gPy4L2/NXPyzyN8TK/b/EASu7S0BQamzTBFYvMuJJE1gMzUIBmV9dt
         XhfZoiYZp7cQE6ouChfRE4o9/mF3n9q+35CRfvZwJEVW9QJslK2xKWUtVf1VCJs9ZrL+
         L95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BxsNyjaSCN3M5RS6ZFNO6kAmQm4emaU2OKjak3iFgTE=;
        b=VEWPYP+QyGQ4JtFk6+uJtFFweKpzjeIDbJ59tuM13/PghtbGzcAobM3XiRV7hmW9hp
         FAGXbaY/rpwCNOaVqGjRkVt1bztuflBcijkFlU6YE0tSVg34htsKf/djxth9sWYZhFxy
         KNf8VTAn+m62MUA44YMDmqXFJygwXeuchGTax+IePJ6cGULp7UsXp1R2OravNbiZvTFg
         l0FV4L+2oIAVh7Ti2xToWnz2dsn9Rc3RS9HhG7qFQxOSSeF5F7L7dV9F6cDz4Se/SWqw
         giUWNL35BFfL8aNBrso/IQWybtDjQbnzyMpMfslBn9GHb6BHFYsF7x69gOryrdPhBszT
         ah5A==
X-Gm-Message-State: ACgBeo0TLfox1XjbPfuwuIzZvokO3cz+IRoxHG/ZpinZCZuY2R87JtXT
        BUcEaqH6suPj/8HP5TJeHq0=
X-Google-Smtp-Source: AA6agR5PpeOBEgwIfMHJVxjeUmdiR5b1EQ0cGcYYHCLwaJWcVgjcrpm0vTlSxZcBxEaguf1eteqxig==
X-Received: by 2002:a05:6e02:1a04:b0:2f2:d2f7:a6db with SMTP id s4-20020a056e021a0400b002f2d2f7a6dbmr9591568ild.74.1662960548169;
        Sun, 11 Sep 2022 22:29:08 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:07 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 3/9] drm_print: interpose drm_*dbg with forwarding macros
Date:   Sun, 11 Sep 2022 23:28:46 -0600
Message-Id: <20220912052852.1123868-4-jim.cromie@gmail.com>
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

change drm_dev_dbg & drm_dbg to macros, which forward to the renamed
functions (with __ prefix added).

Those functions sit below the categorized layer of macros implementing
the DRM debug.category API, and implement most of it.  These are good
places to insert dynamic-debug jump-label mechanics, which will allow
DRM to avoid the runtime cost of drm_debug_enabled().

no functional changes.

memory cost baseline: (unchanged)
bash-5.1# drms_load
[    9.220389] dyndbg:   1 debug prints in module drm
[    9.224426] ACPI: bus type drm_connector registered
[    9.302192] dyndbg:   2 debug prints in module ttm
[    9.305033] dyndbg:   8 debug prints in module video
[    9.627563] dyndbg: 127 debug prints in module i915
[    9.721505] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   10.091345] dyndbg: 2196 debug prints in module amdgpu
[   10.106589] [drm] amdgpu kernel modesetting enabled.
[   10.107270] amdgpu: CRAT table not found
[   10.107926] amdgpu: Virtual CRAT table created for CPU
[   10.108398] amdgpu: Topology: Add CPU node
[   10.168507] dyndbg:   3 debug prints in module wmi
[   10.329587] dyndbg:   3 debug prints in module nouveau

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 10 +++++-----
 include/drm/drm_print.h     |  9 +++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ec32df35a3e3..29a29949ad0b 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -279,8 +279,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...)
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+		   const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -301,9 +301,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 	va_end(args);
 }
-EXPORT_SYMBOL(drm_dev_dbg);
+EXPORT_SYMBOL(__drm_dev_dbg);
 
-void __drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -320,7 +320,7 @@ void __drm_dbg(enum drm_debug_category category, const char *format, ...)
 
 	va_end(args);
 }
-EXPORT_SYMBOL(__drm_dbg);
+EXPORT_SYMBOL(___drm_dbg);
 
 void __drm_err(const char *format, ...)
 {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 668273e36c2c..c429c258c957 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -335,7 +335,7 @@ __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
 __printf(3, 4)
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 		 const char *format, ...);
 
 /**
@@ -384,6 +384,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#define drm_dev_dbg(dev, cat, fmt, ...)				\
+	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
  *
@@ -485,10 +488,12 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
  */
 
 __printf(2, 3)
-void __drm_dbg(enum drm_debug_category category, const char *format, ...);
+void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
+#define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+
 /* Macros to make printk easier */
 
 #define _DRM_PRINTK(once, level, fmt, ...)				\
-- 
2.37.3

