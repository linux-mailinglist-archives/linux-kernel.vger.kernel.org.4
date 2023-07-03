Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2118745F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGCPJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjGCPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:09:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4963EE69
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:09:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69ff54321so72813961fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396950; x=1690988950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM6qVqvWt1I2BgabBjdwqk9L05J50In8hCGZpzZU0J8=;
        b=b4xu7CCdz/dJ76lzYoo3GkzuOZXURVVPrZRgnBNDR+Vp8AONZQTt3U8J+xte9czkNV
         gVrmLYSs2/wJANfJ9wDikHfdTXUsCN4bVEIQg64fRiUC3pcbLZbs+nPYhgiCAVtMj508
         5NY9oA4bAj1zkyF8oGJH7mhrmBYeRDg8mVvo9uqIDPMqwAf6u3PV2t2g2GUlUM1PaLWo
         dH9mwjsKm18Ddzn0dAspR0LEyw65rwwdms7WffPGVLYqhSkRBepiTP8L1xqisnN7piAd
         gf5qYr4y3p813lvb53RhfzTDpyGym6xLpRPBEab25KVr44mZLgQyFaX3qtpoAJase4dc
         addw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396950; x=1690988950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM6qVqvWt1I2BgabBjdwqk9L05J50In8hCGZpzZU0J8=;
        b=WU+Szu5skHGAHlwt/pvtsfqS9GBQJcMoPYk+1XPgM5ynwsPkenkuIM5PB0fg9Me/LT
         ovOOwg503xaokHQvlPwWOPZRFyhZ9oJ9zUDO6N1elHNeAwstGLLMW7z10rhJyeAjrvmc
         CKequRR3EpOUSyJ7kR5TFOzl2y6IJaxnMFSSKTdrIn3HRm+bop0cAEVsCg9ZcWGYM2QF
         TCnKZUe1cgOsDHwRe5Aqk8QZbJ8/18+twoNrg1bO34oCFumNTRzDCo+099OEb5IajKGq
         3vQV7NWxBttYPQPwgWQxGMh/tSxHSDZY5vE07UAFwZK1wyf/+xjcoPV0OXUnNzb356fw
         QrFg==
X-Gm-Message-State: ABy/qLYfsRBkotBILMvw3zNUrQRh9lyjT72bmKMKJHAJqYVrBobB4VfS
        lmFh8jV8ac9q+nuZuyPUe+k=
X-Google-Smtp-Source: APBJJlE3KQ1SG6ccqPBqxmI7ZwNLWnW7syZsJMoLOXEaVktd3RA/EmCt+g+H/mifRRMLmWz9uB+jhQ==
X-Received: by 2002:ac2:58fb:0:b0:4fb:9772:6639 with SMTP id v27-20020ac258fb000000b004fb97726639mr6466708lfo.6.1688396950214;
        Mon, 03 Jul 2023 08:09:10 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b009786c8249d6sm12221211ejh.175.2023.07.03.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:09:09 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/i915/pmu: Use local64_try_cmpxchg in i915_pmu_event_read
Date:   Mon,  3 Jul 2023 17:08:18 +0200
Message-ID: <20230703150859.6176-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old
in i915_pmu_event_read.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d35973b41186..108b675088ba 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -696,12 +696,11 @@ static void i915_pmu_event_read(struct perf_event *event)
 		event->hw.state = PERF_HES_STOPPED;
 		return;
 	}
-again:
-	prev = local64_read(&hwc->prev_count);
-	new = __i915_pmu_event_read(event);
 
-	if (local64_cmpxchg(&hwc->prev_count, prev, new) != prev)
-		goto again;
+	prev = local64_read(&hwc->prev_count);
+	do {
+		new = __i915_pmu_event_read(event);
+	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
 
 	local64_add(new - prev, &event->count);
 }
-- 
2.41.0

