Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378FE745F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGCPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjGCPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:01:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E8AD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:01:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso5691724e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688396509; x=1690988509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ACAehRo9Teq7otTL7t1DkhIRrNmVdicT9iRzjgjAX4=;
        b=QY3WsCZGQOiafSVgFytHNVwB+PNMpe4yuH/ejzZdUhvt3pV6/5gfBrvHh5Uf+MrXLr
         LGp0o4oh3Y6gcImedl6Bpr+A4WNjPq5z4EgXDOyNtjfiYKZlTQ6JpqlRkqd5QPbErWDq
         fkcot1hoh9WTuaAlTGEMdgycbmc2C1OVtSvDRNFC+55PoMXFpm1Rwe1KCRaw5Fnr154Z
         lYDXQnL5HmIsTcwpDW6zlSWsM6KGy4JucuxUtcwpvYDUg1yCXQ/IncW4qZQsxPs92RL3
         eLN3efPGi8DOaNn8ZtGVR2KuI7OuMIVo9C3rh0vBOHkNcy5mBN0eDEaK6MKYqY3Pfveh
         hzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396509; x=1690988509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ACAehRo9Teq7otTL7t1DkhIRrNmVdicT9iRzjgjAX4=;
        b=KbIHq6iAv/q/rykWOgMRhCjBf7vvdjgcta4OA8w/cEhFJg4ciPdCKAgRNBMSMZ/pYf
         y0nH3PvZByktk7jXyQUcV3kCU3WOfaWuywYPWkT1osfmrnGsFNwfit252S0KE2dVcBRg
         /KNxEgNzyAXC0WbA5lMaKB9Dkk4QRAOjchGETFYNqTYScK8laDKVpZY/PGkV9ecACevO
         RqI7BIMGO+o62xkMhMWTCB/LMnkfsbsdx6SIsbWRfvR8bqOogJ8C4iZ7nuah5fVbqkpB
         pvsagiUX5W2NiJeLExslK4QPJNkNjBabnNV+Ixm9CKIRlqJJYIg+5X5gFIPehDFmeAG1
         F9DA==
X-Gm-Message-State: ABy/qLZ+5mX+A/gFI7VaS8VZ5qRTLN0k2umM70xeQJDNI9XTIae32MZU
        An/g9OQLEjOaUel+ZjNHaCc=
X-Google-Smtp-Source: APBJJlEy07zEOHrJaTz7psAlLEzG3iQ1RXU/ezZ16Gu7PUkEO1A6MG/Olvbvbk+csfjrYJudmx71uw==
X-Received: by 2002:a05:6512:3da5:b0:4f8:6e6e:3f42 with SMTP id k37-20020a0565123da500b004f86e6e3f42mr11621655lfv.14.1688396508639;
        Mon, 03 Jul 2023 08:01:48 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id q7-20020aa7d447000000b005183ce42da9sm10477109edr.18.2023.07.03.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:01:48 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/amdgpu: Use local64_try_cmpxchg in amdgpu_perf_read
Date:   Mon,  3 Jul 2023 17:00:59 +0200
Message-ID: <20230703150135.5784-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
in amdgpu_perf_read.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 71ee361d0972..6e91ea1de5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -276,9 +276,8 @@ static void amdgpu_perf_read(struct perf_event *event)
 	    (!pe->adev->df.funcs->pmc_get_count))
 		return;
 
+	prev = local64_read(&hwc->prev_count);
 	do {
-		prev = local64_read(&hwc->prev_count);
-
 		switch (hwc->config_base) {
 		case AMDGPU_PMU_EVENT_CONFIG_TYPE_DF:
 		case AMDGPU_PMU_EVENT_CONFIG_TYPE_XGMI:
@@ -289,7 +288,7 @@ static void amdgpu_perf_read(struct perf_event *event)
 			count = 0;
 			break;
 		}
-	} while (local64_cmpxchg(&hwc->prev_count, prev, count) != prev);
+	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, count));
 
 	local64_add(count - prev, &event->count);
 }
-- 
2.41.0

