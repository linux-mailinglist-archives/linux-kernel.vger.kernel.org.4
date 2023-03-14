Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C66B9B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCNQ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCNQZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC0211F3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7836182E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FAEC433D2;
        Tue, 14 Mar 2023 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678811130;
        bh=8ETbXH3HFRhnrmoJeOc1AT/DX/Eah23kheU2y3YZMo0=;
        h=From:To:Cc:Subject:Date:From;
        b=PECFkUwV2Ep2p0qVUg63V6DKWrMXMyZlGOZv4TaWkdfT4K32sstERsij1UHwLjkVH
         0VNeQJKLBEO6nD5AbKWHZAPz7uQ3dVIFdXDzbXixTovR6+6jXvqp3RNSuPiDqpqHCg
         nfvmOH0guBqmee0MqDPz6JPHy7vTlLqs19yvq7aQJDuZu/uLYwZMug8A01zoq2555L
         Ild06qHasXF534xPGGZSXSwaY+uTIpuYYRM4tDMtnHStlKCMap5Od4vUeBKBi1fXwD
         tWEKJN3pCGX/RGg/pYQ1lL3UOYg35CK1gOvOQnxvpvyk7gD0q0WbfatJ68KZasBFeL
         Rd9ioyHIfpyBQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/opregion: add missing intel_opregion_cleanup() dummy
Date:   Tue, 14 Mar 2023 17:25:18 +0100
Message-Id: <20230314162523.631652-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When ACPI is disabled, i915 fails to build because of a missing
declaration:

drivers/gpu/drm/i915/i915_driver.c: In function 'i915_driver_hw_probe':
drivers/gpu/drm/i915/i915_driver.c:556:9: error: implicit declaration of function 'intel_opregion_cleanup'; did you mean 'intel_opregion_setup'? [-Werror=implicit-function-declaration]
  556 |         intel_opregion_cleanup(dev_priv);

Add another empty dummy helper next to intel_opregion_setup().

Fixes: 3e226e4a2180 ("drm/i915/opregion: Cleanup opregion after errors during driver loading")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/display/intel_opregion.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_opregion.h b/drivers/gpu/drm/i915/display/intel_opregion.h
index 181eb3e9abbf..fd2ea8ef0fa2 100644
--- a/drivers/gpu/drm/i915/display/intel_opregion.h
+++ b/drivers/gpu/drm/i915/display/intel_opregion.h
@@ -86,6 +86,10 @@ static inline int intel_opregion_setup(struct drm_i915_private *dev_priv)
 	return 0;
 }
 
+static inline void intel_opregion_cleanup(struct drm_i915_private *i915)
+{
+}
+
 static inline void intel_opregion_register(struct drm_i915_private *dev_priv)
 {
 }
-- 
2.39.2

