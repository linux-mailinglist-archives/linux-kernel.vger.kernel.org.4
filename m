Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C3642C95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiLEQKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiLEQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:10:28 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52B1D0DE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:10:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 3so1582570iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8QffJLp3kw2N4r3vK4klTqQs8lga3DqRCR8wU17sc8=;
        b=oS4APd20UudCaozy0ge/CvTILvoX4Znvcg3LNw/GRV5Fp7HKZbMQ0E4UEUwQHB6Qwc
         TphBbuArSM654WXtLgtD2zWRBNVykIknWMMlurj4Gk0ue3eWL+chjQFvkUWbPdtcSAc7
         Wf//nqV7IzshKpInzV5x/VYb6SIUWyt4X3eGdIFN4aO57hSCLkMhCNMC3u0HBon3HwsH
         /wDOqR4Did+T7TiW4/odGvX8lYf7ifdrpFJ4nxv32VHVjoz0g4Zi32vPafaE4kqe23gG
         gx3hxqtUJoorfbd8kzF+ssrHqa/01JDUhO8RvXqoSP+rfSdxgE4qulm/kSjeUuBkqYMa
         J9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8QffJLp3kw2N4r3vK4klTqQs8lga3DqRCR8wU17sc8=;
        b=m9+veKVpPkME838tthAg/WBm0njin8re/TKEwjYAz19qGWgrcA2A+DepIbLOeq8NqA
         EE8S2UcXB5o8rLM/pW2HM2Kq0JMNoFOFFTLJsOUl/0WYOBu1eE/EF+49ngbLSRew82DM
         saUwjcE56mdbOp252uZ9GyL4qDrfhh7fgH2yr9ueyAUsRhV2LUgpn8UVzHK19ijyxrT5
         ukPQ2Vz2UfQlBMhOwBhC7tdY9137AoM8r4qbV7upyBBmqigiN2X4E6j82yfQMdFU+s8s
         AmxzLJjhhzAqOHbMUFT+0Y8Qe+DzwWkNhieqUCGpACwkYeafABxfUQHr0TaLNgNu0lEt
         y1rQ==
X-Gm-Message-State: ANoB5pnTMq/thGYhe/v19zbFSZqhNUVmyhlKk2RIiLpbWkuLYXdf/c1f
        epIGVPAXq8+1PpdxveHkSK//BsB2u0Y=
X-Google-Smtp-Source: AA0mqf5hdNHOAynaLAX+tie/6leL82DPkOYfZDoVTQ+aWlnNebYdjzKQS8cNdh9TzJZaO6Rs/Ys2hQ==
X-Received: by 2002:a05:6638:2594:b0:387:cd46:4607 with SMTP id s20-20020a056638259400b00387cd464607mr25372349jat.225.1670256621877;
        Mon, 05 Dec 2022 08:10:21 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id g19-20020a05660226d300b006bcd45fe42bsm6017753ioo.29.2022.12.05.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:10:21 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] drm: mark CONFIG_DRM_USE_DYNAMIC_DEBUG as BROKEN for now
Date:   Mon,  5 Dec 2022 09:10:04 -0700
Message-Id: <20221205161005.222274-2-jim.cromie@gmail.com>
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

CONFIG_DRM_USE_DYNAMIC_DEBUG=y has a regression, due to a chicken-egg
initialization problem:

1- modprobe i915
   i915 needs drm.ko, which is loaded 1st

2- "modprobe drm drm.debug=0x1ff" (virtual/implied)
   drm.debug is set post-initialization, from boot-args etc

3- `modprobe i915` finishes

W/O drm.debug-on-dyndbg that just works, because drm_dbg* does
drm_debug_enabled() to check __drm_debug & DRM_UT_<CAT> before
printing.

But the whole point of CONFIG_DRM_USE_DYNAMIC_DEBUG is to avoid that
runtime test, by enabling (at end/after module_init) a static-key at
selected callsites in the just-loaded module.

And since drm.ko is loaded before all dependent modules, no other
modules are "just-loaded", and their drm.debug callsites are not
present yet, just those in drm.ko itself.

CC: <ville.syrjala@linux.intel.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
.v2 - default=N, cuz CI tests BROKEN stuff too. @ville.syrjala
---
 drivers/gpu/drm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 34f5a092c99e..5adc8d5b6a40 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -53,7 +53,8 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default y
+	default n
+	depends on BROKEN	# chicken-egg initial enable problem
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.38.1

