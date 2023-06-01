Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEEA71F4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjFAVge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjFAVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56887184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E27AB64399
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DE6C433EF;
        Thu,  1 Jun 2023 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655391;
        bh=yOSVSaBHwx99uPQB7KLl4DIUi1SqOYChg3IttbqyV3s=;
        h=From:To:Cc:Subject:Date:From;
        b=Sljypvo10RdZDzMPSueWmMp22OytLYWcXo1+/y3i1x/uVunStdLlpLopvGA7c069d
         Fmf7lV8XkrHq9uO+wrtziKrSGRV+zmTmecN6elCyO1Li4eFR/mZj3Z1G7+nPBefPKT
         ZX1rd5xEYM0HffHF3CZiepUxJcV815NfhdF27u6VFZNEoF29vc2+vg4dssw+BjEcc5
         NiAV4B7ebvhRN3DtoXx8zd0fSVdUf0PlAx7aSm1SL2FMtETCBBMe9PdqYSy/2Tt+H3
         rDBZft6N4Z8a1w3LeOMTRofsdAJyKzmsPFeroG7mj6RNBENHvRXIAGhEXYOk9Camak
         9ydAGaZ2jSZtg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/pxp: use correct format string for size_t
Date:   Thu,  1 Jun 2023 23:36:10 +0200
Message-Id: <20230601213624.3510244-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

While 'unsigned long' needs the %ld format string, size_t needs the %z
modifier:

drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c: In function 'gsccs_send_message':
include/drm/drm_print.h:456:39: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  456 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)

Fixes: dc9ac125d81fa ("drm/i915/pxp: Add GSC-CS backend to send GSC fw messages")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c b/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c
index 8dc41de3f6f74..290ed5ac487de 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.c
@@ -143,7 +143,7 @@ gsccs_send_message(struct intel_pxp *pxp,
 
 	reply_size = header->message_size - sizeof(*header);
 	if (reply_size > msg_out_size_max) {
-		drm_warn(&i915->drm, "caller with insufficient PXP reply size %u (%ld)\n",
+		drm_warn(&i915->drm, "caller with insufficient PXP reply size %u (%zd)\n",
 			 reply_size, msg_out_size_max);
 		reply_size = msg_out_size_max;
 	}
-- 
2.39.2

