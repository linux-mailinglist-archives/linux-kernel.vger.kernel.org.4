Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169246D1C42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjCaJ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjCaJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:27:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040621EFC3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3219BB82DBA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8DDC4339C;
        Fri, 31 Mar 2023 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680254823;
        bh=XRTu35ZdFafbPJyWFWpW6/BJvUu4jTdjrS1uNGlsFd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCzBoIumvl2CYBRlyFq0DAw31z7YCmbHwo/1nXRhYpAR9r3721pGR3X8lSHIVlT+Q
         PlW/pCxm58t52C9YDeusnUX4HToQQJ7kJvpEBw32CSFfZWkNSXRj8rwzYYasASxQm1
         4BO2ZiwuRCUQokL+TPMUkXBR9s8K2NNZkGN61QKRxkR1niK09Q1ZF2BJTieRwQ7JMW
         EpJxnksA6/iaXiIoszEovLASYgnySjbS0tITJamYXbWno99Ikdhx1qK86kbpgtY/Rs
         YsJW6eZoxFn0o5KXVXXi9U5ESc4Z3jFz9wxWwuj1tRs+GQql8DXFNW0t4XtWVVH5Bl
         Mz+bXgqZB9tHA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 17/19] drm/i915/display/intel_display_power: Fix incorrectly documented function __intel_display_power_put_async()
Date:   Fri, 31 Mar 2023 10:26:05 +0100
Message-Id: <20230331092607.700644-18-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331092607.700644-1-lee@kernel.org>
References: <20230331092607.700644-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/i915/display/intel_display_power.c:712: warning: expecting prototype for intel_display_power_put_async(). Prototype was for __intel_display_power_put_async() instead

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index f86060195987c..7d1e492b6bfb5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -697,7 +697,7 @@ intel_display_power_put_async_work(struct work_struct *work)
 }
 
 /**
- * intel_display_power_put_async - release a power domain reference asynchronously
+ * __intel_display_power_put_async - release a power domain reference asynchronously
  * @i915: i915 device instance
  * @domain: power domain to reference
  * @wakeref: wakeref acquired for the reference that is being released
-- 
2.40.0.348.gf938b09366-goog

