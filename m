Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB3D62644C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiKKWRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiKKWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:17:29 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED84B997
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:26 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 11so4575696iou.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAqo2IY9qcxeeqd6VBniHfWVzxC9WIKztprXocMtHOo=;
        b=IHrxVqRzdOVlFgCJjcAHP7xGi6G+KpW9xsG8h0U1Eck/d76md+hJkTMGmQPz2h2Cm5
         0LG8PJmGr0zHtZJkP2Ru3CasZbedM7LDLdU2jm6+058/wEuiTf6vkifSJ7b54BSDUG+F
         8YpXArxd6M5DPYS+dvHgRKQciCwA+NrtuLzfmoI74XiBOUbhvg+y3bpH0bmWGXVd4BEj
         hcLANNGjawgGROMKx62vHjXJ/WRJ/X/XiDxiHHJIE2tWhdAdNd+RjlfjYdvcMqH35p4s
         z4x1jq6XHvn+Sz8V8sIh3bQ2ZlzJzejxLofs1WOCcfNkBIDOUCa1OOGr5GDdoHED1HUT
         6YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAqo2IY9qcxeeqd6VBniHfWVzxC9WIKztprXocMtHOo=;
        b=d+LNcZ/h1RATwjGSPya0bXf0Y0Dsrq4QelzwOdD+PlTAqDoG5YxLauohHxFbFso+Ff
         sCFm2M0WgbtRTVwMzjxEHMx4VTbr3Td92R6LcG0/hYlntCGbwmPHOs5619cjs2ioDzxh
         WhVzNifZgdMJE4Bggl/OQYnZyHT3OIIiZ4kJmQquKCnSS3fnmDQaGTVpI0LQDmTWet/Z
         Bu+I+6tyQfQAu0Zr0oneHaXSR5btkfsgJayjY/Zu7Nr2sjcEjSIIJn3G89p6R0EkZo0c
         suXgjluUphaeeReD2aEZfj0yNGrOiL8yesj0YDddb81fRqLOIXIHzRQO0H96XAgzI7Mc
         0vBA==
X-Gm-Message-State: ANoB5plsGWuJsZiv/RL/4X+d3d/ZEVu/I75OLJwn789YaSklCOx0uaMZ
        pBV0zp+fZL14LMetW5F4vOk=
X-Google-Smtp-Source: AA0mqf5Y4BJwj1yHUsxhbaxFIfRavIesvXu1ebRXuJGshO4Aa6jTAKpEkT88JgrZdvPOf0d+zkTISw==
X-Received: by 2002:a05:6638:1a87:b0:375:2ff:b633 with SMTP id ce7-20020a0566381a8700b0037502ffb633mr1692439jab.100.1668205046232;
        Fri, 11 Nov 2022 14:17:26 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id c5-20020a928e05000000b002f611806ae9sm1113457ild.60.2022.11.11.14.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:17:25 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/7] drm: mark drm.debug-on-dyndbg as BROKEN for now
Date:   Fri, 11 Nov 2022 15:17:09 -0700
Message-Id: <20221111221715.563020-2-jim.cromie@gmail.com>
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

drm.debug-on-dyndbg has a regression, due to a chicken-egg
initialization problem:

1- modprobe i915
   i915 needs drm.ko, which is loaded 1st

2- "modprobe drm drm.debug=0x1ff" (virtual/implied)
   drm.debug is set post-initialization, from boot-args etc

3- `modprobe i915` finishes

W/O drm.debug-on-dyndbg that just works, because all drm_dbg*
callsites use drm_debug_enabled() to check __drm_debug & DEM_UT_<CAT>
before printing.

But the whole point of drm.debug-on-dyndbg is to avoid that runtime
test, by enabling (at post-modinit) a static-key at each callsite in
the just-loaded module.

And since drm.ko is loaded before all dependent modules, none are
"just-loaded", and no drm.debug callsites are present yet, except
those in drm.ko itself.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 34f5a092c99e..0d1e59e6bb7e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -54,6 +54,7 @@ config DRM_DEBUG_MM
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
 	default y
+	depends on BROKEN	# chicken-egg initial enable problem
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.38.1

