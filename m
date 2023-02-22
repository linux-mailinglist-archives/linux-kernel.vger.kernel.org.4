Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0604569F64F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjBVOSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:18:06 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5607EE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:18:03 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 6E47FC800A5;
        Wed, 22 Feb 2023 15:18:02 +0100 (CET)
Authentication-Results: srv6.fidu.org (amavisd-new); dkim=pass (1024-bit key)
        reason="pass (just generated, assumed good)"
        header.d=tuxedocomputers.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from; s=default; t=1677075482; x=1678889883; bh=D3
        I1kLODPKL0LKI3DL3UiMVU0H7ABoanUSeYpcT2TB0=; b=uIVQqKBZ0WTwd+JgUn
        hbLFIMfmYcW350S5ujyXLx7UXgYpiohWMvru4OYsEERBgaU8i8CS8bTrIC3VWnwY
        0OJh1NZiF7IehCRlIuplrrWx53E0Fk/FiqMJ2isDtJ8yJ8Ufh3UtAN5aXdR08ieW
        NjidBTFHMAf+WGz5SgDLImv5w=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id eif2nOs781h2; Wed, 22 Feb 2023 15:18:02 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 73504C800A2;
        Wed, 22 Feb 2023 15:18:01 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, mika.kahola@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        Diego.SantaCruz@spinetix.com, wse@tuxedocomputers.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Apply quirk to disable PSR 2 on Tongfang PHxTxX1 and PHxTQx1
Date:   Wed, 22 Feb 2023 15:17:55 +0100
Message-Id: <20230222141755.1060162-3-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222141755.1060162-1-wse@tuxedocomputers.com>
References: <20230222141755.1060162-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On these Barebones PSR 2 is recognized as supported but is very buggy:
- Upper third of screen does sometimes not updated, resulting in
disappearing cursors or ghosts of already closed Windows saying behind.
- Approximately 40 px from the bottom edge a 3 pixel wide strip of randomly
colored pixels is flickering.

PSR 1 is working fine however.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index ce6d0fe6448f5..eeb32d3189f5c 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -65,6 +65,10 @@ static void quirk_no_pps_backlight_power_hook(struct drm_i915_private *i915)
 	drm_info(&i915->drm, "Applying no pps backlight power quirk\n");
 }
 
+/*
+ * Tongfang PHxTxX1 and PHxTQx1 devices have support for PSR 2 but it is broken
+ * on Linux. PSR 1 however works just fine.
+ */
 static void quirk_no_psr2(struct drm_i915_private *i915)
 {
 	intel_set_quirk(i915, QUIRK_NO_PSR2);
@@ -205,6 +209,10 @@ static struct intel_quirk intel_quirks[] = {
 	/* ECS Liva Q2 */
 	{ 0x3185, 0x1019, 0xa94d, quirk_increase_ddi_disabled_time },
 	{ 0x3184, 0x1019, 0xa94d, quirk_increase_ddi_disabled_time },
+
+	/* Tongfang PHxTxX1 and PHxTQx1/TUXEDO InfinityBook 14 Gen6 */
+	{ 0x9a49, 0x1d05, 0x1105, quirk_no_psr2 },
+	{ 0x9a49, 0x1d05, 0x114c, quirk_no_psr2 },
 };
 
 void intel_init_quirks(struct drm_i915_private *i915)
-- 
2.34.1

