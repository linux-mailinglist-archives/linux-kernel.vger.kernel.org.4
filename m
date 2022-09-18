Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41BA5BC04A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 00:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIRWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:07:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D09140CD;
        Sun, 18 Sep 2022 15:07:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j12so26314400pfi.11;
        Sun, 18 Sep 2022 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oAZa73Ms9QVpxhmjRkhl/oIipHOwLafi4P86QyHcFa0=;
        b=JEqFXyJwbJqlQ1qM4Gt7ZjSBcNjtwpvDggFsPm5D4V0iTzm7x5O/OLEiX2y1gkvfi3
         gBzFqyPlL801WgcyDu9JWXbrzmemvUutUINjW0Lf7zTpYvCCJkMPbAptr0sIPbyRiVhW
         6wWxPRvSYQYYaIwdSvq/F4dgq26b9JUkye7k5mVBqwvUw1QtBcAZDDvH0lqRTHR/9pL9
         8ZvIeVAhaTi645806bbFpTPkjcvkk/KfuUDVGcXn3jIz96y2db72BkM1m3UrHWUaxqzJ
         Xq2vV+BtZfA+HIbcewUbkKwNz4mrhyYNdn/EvYUJVgO3lps7R5f4LZGWNTJIRfftXyd6
         ORjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oAZa73Ms9QVpxhmjRkhl/oIipHOwLafi4P86QyHcFa0=;
        b=hE5Fum/dzT3UGDG3H+fe38rtLDT2kgTW+IVlD6lwVjJ1XvAWL3IFSjpqadwbmti703
         5sGxbOJ/TyeLoyvoQRolx1lJxUaKJg8cNj7Lx6JxqQyaUx94Kxdi61lkiRPoA7vxkOX5
         NE0Soog8gH5PaSkMnwRfY6V+PtECndMzntyZVytAjybwz31/ZKySuZV4qXpLKtV62M1l
         pspPLd/KLLfxK/FPdjekG2H04wgjB2GoVeHj5qiE29WH1+86AJkF0k0so8FEVo05puqf
         klyQFKaQ+fzLP2/fzsG+C0J5IPjPkHKUZ7E2J0zdEpjT1OOD92vW72+6hqPBEOHvnvzC
         OHFg==
X-Gm-Message-State: ACrzQf2s0LrKIy03Hvtkt6SYP63Y7Y+NjAXwBMQIOkAYaTHze6/Sg37l
        es9fkOM9wwmSa+8z3eTMiAoEdbss/klKVQ==
X-Google-Smtp-Source: AMsMyM5OITmrhfBXTIMTtYY7kFUoTNgOex+iRyyFQjgfDBr5qfnfxKk5sWU8UnYONKmIlJmDfiU69A==
X-Received: by 2002:aa7:8759:0:b0:540:aad4:b13e with SMTP id g25-20020aa78759000000b00540aad4b13emr15687055pfo.13.1663538867560;
        Sun, 18 Sep 2022 15:07:47 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id u10-20020a170902e80a00b00176b63535ccsm19061232plg.193.2022.09.18.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 15:07:46 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     airlied@redhat.com, ville.syrjala@linux.intel.com,
        christian.koenig@amd.com, sumit.semwal@linaro.org, daniel@ffwll.ch,
        airlied@linux.ie, tvrtko.ursulin@linux.intel.com,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        jani.nikula@linux.intel.com, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/gpu/drm/i915/gt: Check the return value of i915_active_acquire()
Date:   Sun, 18 Sep 2022 15:07:31 -0700
Message-Id: <20220918220731.1026200-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

i915_active_acquire() could return error when the acquire fails. Check
and return the error code.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_timeline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_timeline.c b/drivers/gpu/drm/i915/gt/intel_timeline.c
index b9640212d659..d8333ab64574 100644
--- a/drivers/gpu/drm/i915/gt/intel_timeline.c
+++ b/drivers/gpu/drm/i915/gt/intel_timeline.c
@@ -211,7 +211,10 @@ int intel_timeline_pin(struct intel_timeline *tl, struct i915_gem_ww_ctx *ww)
 	GT_TRACE(tl->gt, "timeline:%llx using HWSP offset:%x\n",
 		 tl->fence_context, tl->hwsp_offset);
 
-	i915_active_acquire(&tl->active);
+	err = i915_active_acquire(&tl->active);
+	if (err)
+		return err;
+
 	if (atomic_fetch_inc(&tl->pin_count)) {
 		i915_active_release(&tl->active);
 		__i915_vma_unpin(tl->hwsp_ggtt);
-- 
2.25.1

