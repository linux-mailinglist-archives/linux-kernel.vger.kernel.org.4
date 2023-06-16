Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821E0732BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbjFPJdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbjFPJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F73C2B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA04C633B4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C7BC433C0;
        Fri, 16 Jun 2023 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907925;
        bh=RyvbZ8xLNLVCEWUqE0qfmWc1Llk+X9g8qHjmNGYKLVM=;
        h=From:To:Cc:Subject:Date:From;
        b=aql41gS/+jx94TAWvh8KlZ36Fle4QLGqn4B5xNnEimBQx7Cd3FU9uPP7Q/YRQ12ot
         1AXM14STUqfR1eCiaTBhac+CKJXSwcBroJAVdoknmp5M2NHBhGE/SVVA7ykLMEGYHP
         HEyt50zxwBm8YNFGIcCJe+Mu26PCyZrRHm0spOjxcr3aOR1uLyy9tuh0nIJeCFlFIC
         NY1dTlUWtcNT9HZuKXS6xYKGaEqJedzVrRUWVtyo7M5EYvZAyYALT1vv+6UIp3g9gF
         7XP69Nce6j7JGcbwivO1adEkkUXZ/vkS5w3cylg65qOsU+V2Sfvb+3lNDOvDiMic2m
         gtSCeuughd6Hg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: make i915_drm_client_fdinfo() reference conditional again
Date:   Fri, 16 Jun 2023 11:31:47 +0200
Message-Id: <20230616093158.3568480-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function is only defined if CONFIG_PROC_FS is enabled:

ld.lld: error: undefined symbol: i915_drm_client_fdinfo
>>> referenced by i915_driver.c
>>>               drivers/gpu/drm/i915/i915_driver.o:(i915_drm_driver) in archive vmlinux.a

Use the PTR_IF() helper to make the reference NULL otherwise.

Fixes: e894b724c316d ("drm/i915: Use the fdinfo helper")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/i915_driver.c     | 2 +-
 drivers/gpu/drm/i915/i915_drm_client.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 75cbc43b326dd..0ad0c5885ec27 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1816,7 +1816,7 @@ static const struct drm_driver i915_drm_driver = {
 	.open = i915_driver_open,
 	.lastclose = i915_driver_lastclose,
 	.postclose = i915_driver_postclose,
-	.show_fdinfo = i915_drm_client_fdinfo,
+	.show_fdinfo = PTR_IF(IS_ENABLED(CONFIG_PROC_FS), i915_drm_client_fdinfo),
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 4c18b99e10a4e..67816c912bca1 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -47,8 +47,6 @@ static inline void i915_drm_client_put(struct i915_drm_client *client)
 
 struct i915_drm_client *i915_drm_client_alloc(void);
 
-#ifdef CONFIG_PROC_FS
 void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
-#endif
 
 #endif /* !__I915_DRM_CLIENT_H__ */
-- 
2.39.2

