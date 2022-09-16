Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6634E5BAF99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiIPOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:49:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A7B26E2;
        Fri, 16 Sep 2022 07:49:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q21so31844990edc.9;
        Fri, 16 Sep 2022 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Udhk4Q2S/+kZ/4kuQfb/Q3gnhZBJAS7E9brlINKWaBA=;
        b=mM2JRZPp+c5UJqx940V5iM59hJC0QcbIOAt3KcNOuW+DqYVp6zTlXPFaiwEMcWIrlE
         cK6B7yUmmJsaL0yNjfRkGHWWoaCEcNaBdcFp8zMmEnBpAHV7s621GO00GvS0waLllgyH
         nJXdVde/QH0u5+bLwgxWCRo/fp2jyn8l91o0zwVmlShXeoeToeEEjFKJvjXaQUs0sa/f
         ET9Du3muo4NojEp2iOBQU0GBR0aKqAm8y3Y7X6TA6HMpPC0BYG/i8/HeAUUIOY2K+klG
         1MivcFhQigyzuZ4B3fHD7NSiF5cfY4aMDFStsb4VjnArVCLEe3aTsYcMNHCKJ4trpoHn
         d6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Udhk4Q2S/+kZ/4kuQfb/Q3gnhZBJAS7E9brlINKWaBA=;
        b=PzFI8LzwIP2B3RqdAdH9CYKlpdZqbSsp3dU6u0VgO+KkQgK6ilVLhwDK5CZmE613y4
         YbXrzOdLfrei1vM52H6n9JzTldDjryHyKbWHvZ7YfSoDPk0aDExUmzesCXFOZoc3sUgw
         7KcMiUNRLP1pLYHfMgZP42AGX+JkiXeM1BBVNhsHPwcvxdWZUw0VSwX4bA9Lrw050kuF
         u/uIeV/zTwKN2s/iA///0sdr3to8igCi+VeGHZ0KZb6Nh0WT5gjcTlf7wtFKcEVuaRLv
         8W4Y2bTyhXRKenRPRTGxiBclVqGUid5BT17q8Uax70o6EXq/mIPyGmrC+YaN5lwHr7Kf
         iwKg==
X-Gm-Message-State: ACrzQf1tNV065IlTUFjK556iJn4robIy1J9Z/FnGFAgq/IbvBe/Ub2Us
        G/BGnsDsZ42IK77Xb+ZIyjY=
X-Google-Smtp-Source: AMsMyM4wosS/9EUN4XPzsd9E3cF+/d3pcXKnlIvOr72RSZ9iMIfHqeHq0GM7ZSII6npMLsrAq3roHA==
X-Received: by 2002:a05:6402:161a:b0:451:ea13:572e with SMTP id f26-20020a056402161a00b00451ea13572emr4293402edv.41.1663339769879;
        Fri, 16 Sep 2022 07:49:29 -0700 (PDT)
Received: from felia.fritz.box (200116b82618570059b736ec202ba767.dip.versatel-1u1.de. [2001:16b8:2618:5700:59b7:36ec:202b:a767])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7cb19000000b004531b137e4bsm2735103edt.67.2022.09.16.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:49:28 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] drm: make DRM_DEBUG_MODESET_LOCK depend on DRM
Date:   Fri, 16 Sep 2022 16:49:05 +0200
Message-Id: <20220916144905.18253-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DEBUG_KERNEL is selected with a kernel build without DRM, Kconfig still
asks if DRM_DEBUG_MODESET_LOCK is to be selected or not, although this has
no influence on the kernel without DRM.

Make DRM_DEBUG_MODESET_LOCK depend on DRM to avoid needless questions
during kernel build configuration.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/gpu/drm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 198ba846d34b..393d6da0d0f7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -96,6 +96,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 
 config DRM_DEBUG_MODESET_LOCK
 	bool "Enable backtrace history for lock contention"
+	depends on DRM
 	depends on STACKTRACE_SUPPORT
 	depends on DEBUG_KERNEL
 	depends on EXPERT
-- 
2.17.1

