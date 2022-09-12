Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419945B538A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 07:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiILF3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiILF3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 01:29:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831C248E6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:13 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id k9so3983801ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ITRLSs656UGwBL27WS4PAEu4z+TFhuXj9Pi0xXaA2Xg=;
        b=d7h6IZ2LL+KeqOCYEFWUbsFBPvMYig1ya0J6yk6hWgz6wtXs7P6zqZ6Xot9UX9tCrr
         GyEkWPYn/VaYlXHqjEeTgHVCkEQt72UzCC/ckoMkbFpajeedGN4cg8ApmR/cMRCBSBV5
         6AKLco4R4+Wg7M6AcVKIB7xnZblixRODxoBH0/LBbAhgH8rSmMvyM7Nudac0CBv2oyjR
         xR4U3Tq1LfiT3tkoN2mlsb/zyHjl+L/QP+A8+Xc+fnkJiz2vDoxLYp0N6xJSup/9RgCU
         I+Cx7YVC3+o0Ka+vYgjJunU3sQ1PaJjoGD6lVXJkqkGp/iAS5C/9y+D9q/IdQ/LLZ+Da
         NBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ITRLSs656UGwBL27WS4PAEu4z+TFhuXj9Pi0xXaA2Xg=;
        b=VqsMiARKPn2BxYssT/U1ho4gCnTKYLLYVcStZqLgj518YLhgmf1zSF3D4gLdBtiG8S
         agFdLM8kezNPi/bJ3tEg9lRQVNCqbf7uOc4OCWc1054NGoyS0uK33iZvsJf7oIHi8Cds
         vwR2bM9pYZDyiF6gNG3WtJnsq/0se+j/zuejrVjGj4pe4CrkfnowKtVi3cdreHsp7DJm
         Ip4AkiI6Q8c7BUE7nqimrHmr34ZMPtzI4+RzNw8M547Cwq62RAH7HSFQBs83WClyT0z6
         Z2IOp3yHyLie4dSpJRfjS+T5uUPOlhWFKq6EHarFQYWhilzZXniWwctI8PCXkaDT6DWI
         rh0g==
X-Gm-Message-State: ACgBeo0DKvVvUp+7ybCgWlgjvh+fKWvdg7PNuYHbXZMCGxkhRwRV1qbk
        bJ0Vahd2CAC+eRimtOZrpi0=
X-Google-Smtp-Source: AA6agR5rCdnktWACXOjdGxRE7qHq3+fz7tOLmcMPlmy2aCmo61R329L72SfNxKqfY0Lm57XE7rOiSA==
X-Received: by 2002:a05:6e02:1caf:b0:2f2:1639:63a0 with SMTP id x15-20020a056e021caf00b002f2163963a0mr9415574ill.5.1662960553105;
        Sun, 11 Sep 2022 22:29:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id q16-20020a056e02079000b002eb75fb01dbsm3006057ils.28.2022.09.11.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:29:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 8/9] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Sun, 11 Sep 2022 23:28:51 -0600
Message-Id: <20220912052852.1123868-9-jim.cromie@gmail.com>
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

drm_print.c calls pr_debug() just once, from __drm_printfn_debug(),
which is a generic/service fn.  The callsite is compile-time enabled
by DEBUG in both DYNAMIC_DEBUG=y/n builds.

For dyndbg builds, reverting this callsite back to bare printk is
correcting a few anti-features:

1- callsite is generic, serves multiple drm users.
   it is soft-wired on currently by #define DEBUG
   could accidentally: #> echo -p > /proc/dynamic_debug/control

2- optional "decorations" by dyndbg are unhelpful/misleading here,
   they describe only the generic site, not end users

IOW, 1,2 are unhelpful at best, and possibly confusing.

reverting yields a nominal data and text shrink:

   text    data     bss     dec     hex filename
 462583   36604   54592 553779   87333 /kernel/drivers/gpu/drm/drm.ko
 462515   36532   54592 553639   872a7 -dirty/kernel/drivers/gpu/drm/drm.ko

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index cb203d63b286..ec477c44a784 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -23,8 +23,6 @@
  * Rob Clark <robdclark@gmail.com>
  */
 
-#define DEBUG /* for pr_debug() */
-
 #include <linux/stdarg.h>
 
 #include <linux/io.h>
@@ -185,7 +183,8 @@ EXPORT_SYMBOL(__drm_printfn_info);
 
 void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
 {
-	pr_debug("%s %pV", p->prefix, vaf);
+	/* pr_debug callsite decorations are unhelpful here */
+	printk(KERN_DEBUG "%s %pV", p->prefix, vaf);
 }
 EXPORT_SYMBOL(__drm_printfn_debug);
 
-- 
2.37.3

