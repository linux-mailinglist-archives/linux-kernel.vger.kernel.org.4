Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016572C4AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjFLMoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjFLMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E7AA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:44:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA7A613CA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62198C433EF;
        Mon, 12 Jun 2023 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686573854;
        bh=gq5hRxWovnLtF31u4zc0XX1gnCt36dRWdFL6GhVRm1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=aNZ6vU+zqRHWZ7v5rU9caKOXoKFrLPpnXcJFL7SjBButK5TfSon8w7qd0ZGp3yPsX
         EI2aVc23QU7o5UMTofxC4fGvGweV9D6QVN3tE084zyRWCdedehtmIrGLbT0VoKpqdw
         BT5zR5FmOIvCn1GZl8eJESDk4BGo0K/dPVAQHhF3a0XxsP8kX962PEjdsRaf+Dn6S6
         syUv+UxCqUM8TTY2vYE8wjvhxTtSHo356wst1ETPwgdjxwxXSpbs8BzigsIqWGMteP
         dB4wSGS686NpkLtVIG7xL2SsTi2m3BtYsQxqmS+4eOCxf6HmMm0b6OSVoD/mQr+iS1
         WWdWTKzRDvpCQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gmch: avoid unused variable warning
Date:   Mon, 12 Jun 2023 14:43:59 +0200
Message-Id: <20230612124408.521325-1-arnd@kernel.org>
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

When CONFIG_PNP is disabled, the mchbar_addr variable is only written but
not read:

drivers/gpu/drm/i915/soc/intel_gmch.c: In function 'intel_alloc_mchbar_resource':
drivers/gpu/drm/i915/soc/intel_gmch.c:41:13: error: variable 'mchbar_addr' set but not used [-Werror=unused-but-set-variable]
   41 |         u64 mchbar_addr;
      |             ^~~~~~~~~~~

No idea why this showed up now, but it's easy to fix by changing the #ifdef to
an IS_ENABLED() check that the compiler can see through.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I saw this last week already, so it's likely that someone else already sent
a fix for it.

 drivers/gpu/drm/i915/soc/intel_gmch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/soc/intel_gmch.c b/drivers/gpu/drm/i915/soc/intel_gmch.c
index 6d0204942f7a5..49c7fb16e934f 100644
--- a/drivers/gpu/drm/i915/soc/intel_gmch.c
+++ b/drivers/gpu/drm/i915/soc/intel_gmch.c
@@ -47,11 +47,9 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 	mchbar_addr = ((u64)temp_hi << 32) | temp_lo;
 
 	/* If ACPI doesn't have it, assume we need to allocate it ourselves */
-#ifdef CONFIG_PNP
-	if (mchbar_addr &&
+	if (IS_ENABLED(CONFIG_PNP) && mchbar_addr &&
 	    pnp_range_reserved(mchbar_addr, mchbar_addr + MCHBAR_SIZE))
 		return 0;
-#endif
 
 	/* Get some space for it */
 	i915->gmch.mch_res.name = "i915 MCHBAR";
-- 
2.39.2

