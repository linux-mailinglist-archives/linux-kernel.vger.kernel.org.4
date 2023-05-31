Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2ED71739B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjEaCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjEaCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:17:21 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E70EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:17:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VjvXEdn_1685499435;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VjvXEdn_1685499435)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 10:17:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/i915: remove unreachable code
Date:   Wed, 31 May 2023 10:17:14 +0800
Message-Id: <20230531021714.125078-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code after the return will not be executed, so remove them.

Eliminate the following warning:
drivers/gpu/drm/i915/display/intel_color.c:1808 intel_color_prepare_commit() warn: ignoring unreachable code.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5342
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 8966e6560516..0bfebac1e3e2 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -1804,11 +1804,6 @@ void intel_color_prepare_commit(struct intel_crtc_state *crtc_state)
 
 	/* FIXME DSB has issues loading LUTs, disable it for now */
 	return;
-
-	if (!crtc_state->pre_csc_lut && !crtc_state->post_csc_lut)
-		return;
-
-	crtc_state->dsb = intel_dsb_prepare(crtc, 1024);
 }
 
 void intel_color_cleanup_commit(struct intel_crtc_state *crtc_state)
-- 
2.20.1.7.g153144c

