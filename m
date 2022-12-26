Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901565649E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiLZS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiLZS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:28:04 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55A25FA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672079247; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Tbf4i+xtNFsBRw+cfKAjWfXVrR0ZG+YlBVLUpu04P2WxhjZC8k0NEz6ZDmrm/1JkwN7pfAHTvBNB21LOxhTcrJJNy8GTmg1HcIahbITOhVa2q9Oue+BsefYjjTKJh9CH7QGuS6hz5AJCsivXY8JL7U7ZlWVjZnTpn9fS5WSPnuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1672079247; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=h/5Cu+VhXSzus7GxdYaHXFk9hnevD1WHx6MfM430I2Q=; 
        b=OyQNZOsZ+T44bzIJeBKl3pHVxSq+mxBsPT247xKnkxqCjWUqTJ5EGn/mFdxVc7StywiyTmstj4mqaZiOs5RLob5z2iojkz0kNgRmk85yj2Aj+ychOhNxR6e2krIXJb0u0Adtzg7m5HaXF1vhZxcMCW84PzB4teBtcPx44j1KkJU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672079247;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=h/5Cu+VhXSzus7GxdYaHXFk9hnevD1WHx6MfM430I2Q=;
        b=Z3YE2HOxoAXxHOuRIUn76ym3dpha97SjLSXsAbsOx1xeMtqCJ9yTmaQaIqrebgox
        w+2x+beNYvNorTtHj56sXxef6U/tXjB9d4yC1a9Nb1tsMGkULvRs7pFXMOpyODhlyo/
        4N+UpcChDHhuKtQbDe59XfThHFEpLnE2yL9cW7II=
Received: from kampyooter.. (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1672079246684840.1226846566159; Mon, 26 Dec 2022 23:57:26 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <76fa37315d4f333d9ab749e52ba37a4a3e1c0fe3.1672078853.git.code@siddh.me>
Subject: [PATCH v3 01/10] drm/print: Fix and add support for NULL as first argument in drm_* macros
Date:   Mon, 26 Dec 2022 23:57:13 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1672078853.git.code@siddh.me>
References: <cover.1672078853.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments say macros DRM_DEBUG_* are deprecated in favor of
drm_dbg_*(NULL, ...), but they have broken support for it,
as the macro will result in `(NULL) ? (NULL)->dev : NULL`.

Thus, fix them by separating logic to get dev ptr in a new
function, which will return the dev ptr if arg is not NULL.
Use it in drm_dbg_*, and also in __DRM_DEFINE_DBG_RATELIMITED,
where a similar (but correct) NULL check was in place.

Also, add support for NULL in __drm_printk, so that all the
drm_* macros will hence support NULL as the first argument.
This also means that deprecation comments mentioning pr_()*
can now be changed to the drm equivalents.

There is a need to support device pointers in __drm_printk,
as in some contexts, we may not have drm_device but just the
device ptr, such as when dealing with struct mipi_dsi_host.
Before this change, passing just host would have worked as
due to preprocessing, __drm_printk resulted in host->dev, but
now due to NULL check that cannot happen.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/drm/drm_print.h | 95 +++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 28 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a44fb7ef257f..ae7f5e29adfd 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -34,6 +34,7 @@
 #include <linux/dynamic_debug.h>
=20
 #include <drm/drm.h>
+#include <drm/drm_device.h>
=20
 /* Do *not* use outside of drm_print.[ch]! */
 extern unsigned long __drm_debug;
@@ -451,9 +452,46 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct =
device *dev,
  * Prefer drm_device based logging over device or prink based logging.
  */
=20
-/* Helper for struct drm_device based logging. */
+/**
+ * __drm_get_dev_ptr - Helper function to get device type pointer even if =
NULL
+ *=09=09       is passed. Primarily for use in print macros, since they
+ *=09=09       need to handle NULL as the first argument passed.
+ * @drm: struct drm_device pointer, struct device pointer, or NULL.
+ * @is_drm: True implies @drm is drm_device pointer, else device pointer.
+ *
+ * RETURNS:
+ * The device pointer (NULL if @drm is NULL).
+ */
+static inline struct device *__drm_get_dev_ptr(const void *ptr, bool is_dr=
m)
+{
+=09if (!ptr)
+=09=09return NULL;
+
+=09if (is_drm)
+=09=09return ((struct drm_device *)ptr)->dev;
+
+=09return (struct device *)ptr;
+}
+
+/**
+ * Helper for struct drm_device based logging (prefer this over struct dev=
ice).
+ * Also supports struct device ptr as an argument for edge cases.
+ */
 #define __drm_printk(drm, level, type, fmt, ...)=09=09=09\
-=09dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
+({=09=09=09=09=09=09=09=09=09\
+=09struct device *__dev_ =3D _Generic((drm),=09=09=09=09\
+=09=09struct drm_device * :=09=09=09=09=09\
+=09=09=09__drm_get_dev_ptr((drm), true),=09=09=09\
+=09=09struct device * :=09=09=09=09=09\
+=09=09=09__drm_get_dev_ptr((drm), false),=09=09\
+=09=09default :=09=09=09=09=09=09\
+=09=09=09NULL=09=09=09=09=09=09\
+=09);=09=09=09=09=09=09=09=09\
+=09if (__dev_)=09=09=09=09=09=09=09\
+=09=09dev_##level##type(__dev_, "[drm] " fmt, ##__VA_ARGS__);=09\
+=09else=09=09=09=09=09=09=09=09\
+=09=09pr_##level##type("[drm] " fmt, ##__VA_ARGS__);=09=09\
+})
=20
=20
 #define drm_info(drm, fmt, ...)=09=09=09=09=09\
@@ -487,25 +525,25 @@ void __drm_dev_dbg(struct _ddebug *desc, const struct=
 device *dev,
=20
=20
 #define drm_dbg_core(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
-#define drm_dbg_driver(drm, fmt, ...)=09=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS_=
_)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_CORE, fmt, ##__VA_AR=
GS__)
+#define drm_dbg_driver(drm, fmt, ...)=09=09=09=09=09\
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_DRIVER, fmt, ##__VA_=
ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_KMS, fmt, ##__VA_ARG=
S__)
 #define drm_dbg_prime(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_PRIME, fmt, ##__VA_ARGS__=
)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_PRIME, fmt, ##__VA_A=
RGS__)
 #define drm_dbg_atomic(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_ATOMIC, fmt, ##__VA_ARGS_=
_)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_ATOMIC, fmt, ##__VA_=
ARGS__)
 #define drm_dbg_vbl(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_VBL, fmt, ##__VA_ARGS__)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_VBL, fmt, ##__VA_ARG=
S__)
 #define drm_dbg_state(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_STATE, fmt, ##__VA_ARGS__=
)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_STATE, fmt, ##__VA_A=
RGS__)
 #define drm_dbg_lease(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_LEASE, fmt, ##__VA_ARGS__=
)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_LEASE, fmt, ##__VA_A=
RGS__)
 #define drm_dbg_dp(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DP, fmt, ##__VA_ARGS__)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_DP, fmt, ##__VA_ARGS=
__)
 #define drm_dbg_drmres(drm, fmt, ...)=09=09=09=09=09\
-=09drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS_=
_)
+=09drm_dev_dbg(__drm_get_dev_ptr((drm), true), DRM_UT_DRMRES, fmt, ##__VA_=
ARGS__)
=20
 #define drm_dbg(drm, fmt, ...)=09drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
=20
@@ -533,31 +571,31 @@ void __drm_err(const char *format, ...);
 #define _DRM_PRINTK(once, level, fmt, ...)=09=09=09=09\
 =09printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
=20
-/* NOTE: this is deprecated in favor of pr_info(). */
+/* NOTE: this is deprecated in favor of drm_info(NULL, ...). */
 #define DRM_INFO(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
-/* NOTE: this is deprecated in favor of pr_notice(). */
+/* NOTE: this is deprecated in favor of drm_notice(NULL, ...). */
 #define DRM_NOTE(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
-/* NOTE: this is deprecated in favor of pr_warn(). */
+/* NOTE: this is deprecated in favor of drm_warn(NULL, ...). */
 #define DRM_WARN(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
=20
-/* NOTE: this is deprecated in favor of pr_info_once(). */
+/* NOTE: this is deprecated in favor of drm_info_once(NULL, ...). */
 #define DRM_INFO_ONCE(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
-/* NOTE: this is deprecated in favor of pr_notice_once(). */
+/* NOTE: this is deprecated in favor of drm_notice_once(NULL, ...). */
 #define DRM_NOTE_ONCE(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
-/* NOTE: this is deprecated in favor of pr_warn_once(). */
+/* NOTE: this is deprecated in favor of drm_warn_once(NULL, ...). */
 #define DRM_WARN_ONCE(fmt, ...)=09=09=09=09=09=09\
 =09_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
=20
-/* NOTE: this is deprecated in favor of pr_err(). */
+/* NOTE: this is deprecated in favor of drm_err(NULL, ...). */
 #define DRM_ERROR(fmt, ...)=09=09=09=09=09=09\
 =09__drm_err(fmt, ##__VA_ARGS__)
=20
-/* NOTE: this is deprecated in favor of pr_err_ratelimited(). */
+/* NOTE: this is deprecated in favor of drm_err_ratelimited(NULL, ...). */
 #define DRM_ERROR_RATELIMITED(fmt, ...)=09=09=09=09=09\
 =09DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
=20
@@ -593,13 +631,14 @@ void __drm_err(const char *format, ...);
 #define DRM_DEBUG_DP(fmt, ...)=09=09=09=09=09=09\
 =09__drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
=20
-#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)=09=09=09=09=
=09\
-({=09=09=09=09=09=09=09=09=09=09=09=09\
-=09static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_=
RATELIMIT_BURST);\
-=09const struct drm_device *drm_ =3D (drm);=09=09=09=09=09=09=09\
-=09=09=09=09=09=09=09=09=09=09=09=09\
-=09if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))=09=09=
=09\
-=09=09drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARG=
S__);=09\
+#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL,=09\
+=09=09=09=09      DEFAULT_RATELIMIT_BURST);=09=09\
+=09=09=09=09=09=09=09=09=09\
+=09if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))\
+=09=09drm_dev_printk(__drm_get_dev_ptr((drm), true),=09=09\
+=09=09=09=09KERN_DEBUG, fmt, ## __VA_ARGS__);=09\
 })
=20
 #define drm_dbg_kms_ratelimited(drm, fmt, ...) \
--=20
2.35.1


