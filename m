Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBC7342DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjFQSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:04:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB31736
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:04:29 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so1016407a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687025068; x=1689617068;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAXkLrzOYTyQH4veg/Dt+9+g8a33rt2RkO+aGzgEOIA=;
        b=EPj4hELLQ/zwqn/azC16NEZei2+FnhMoui6L4UfP+pc7OUzilqwcpT1vzX2af90O5L
         NzyKK+UoT7FhGRFHmi87jGoNKutjag5SCA3fzfFi0kAirpG3LuMPgbv/SbozPR4RCb6f
         1wyueZswBpStzhmO18cUEcxC3+SrmyfDEopp20ZR4TNwF/+t/MfNjJrBfrsBB0y6hxPg
         3slnv6LFNDUU4qfge+mCv9MCICKRB49EUpT3oqU0zgcxA84rO3qwJH3K1Hgk+rGIAZOr
         zlWXF9fZUx7rZAnrFsscVQ3eNluXuE+qJpH6/Trli8TwQKjxAiBnOOx98qS3alCdopfK
         9V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025068; x=1689617068;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAXkLrzOYTyQH4veg/Dt+9+g8a33rt2RkO+aGzgEOIA=;
        b=bxU5wvCAIJN42ync95GNAQp2nB6jWjasu66Cbx+CwL75AC4gaao38lhHlSWPoGAZP7
         f/HKDozSpdsXsRMJ1P3kZ42rn8bGn3wQ26m5JpiKOFOgchavPOyon/Wjvthm8ztVL+VJ
         Zmfknl4JuZAkG0mdvMoQKB7H3tUcZMM5fVD0N1ZRjNC5bnsu2cmjlVPXAceS6MLf8sbW
         +Jha80i2DWB3GmTBNiq26E/W5OLh46l76Kp9WPxRoS5V77zHDIyOqluuoOUnoIwpGqzB
         FtNHJOiKFxSFF+Bx84epQtydR+UxwGO29jKiY2+VJuYctbuqrAFCh8InggObe2sfmJf+
         sqRQ==
X-Gm-Message-State: AC+VfDy+6uq9R9L9NP8jFGW38Au+UZFd6HuMvMARP4oBcHZ496Asg7O9
        VL7mHvrzUuzTmBojYMn87ZkdHgI8UCZJsigd
X-Google-Smtp-Source: ACHHUZ6PvHQ/Ekv32QbsmQuxA6xm6VWsWXZcW5Y38eZX3M54/kRRT71RSXLM/IMiHAuIDJSvQx6pZA==
X-Received: by 2002:a05:6a20:5483:b0:11f:9124:ab1a with SMTP id i3-20020a056a20548300b0011f9124ab1amr1335789pzk.6.1687025068298;
        Sat, 17 Jun 2023 11:04:28 -0700 (PDT)
Received: from sumitra.com ([117.199.158.52])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78698000000b0065fd8075ba0sm853873pfo.212.2023.06.17.11.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:04:27 -0700 (PDT)
Date:   Sat, 17 Jun 2023 11:04:20 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Message-ID: <20230617180420.GA410966@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() has been deprecated in favor of the kmap_local_page()
due to high cost, restricted mapping space, the overhead of a
global lock for synchronization, and making the process sleep
in the absence of free slots.

kmap_local_page() is faster than kmap() and offers thread-local
and CPU-local mappings, take pagefaults in a local kmap region
and preserves preemption by saving the mappings of outgoing tasks
and restoring those of the incoming one during a context switch.

The mapping is kept thread local in the function
“i915_vma_coredump_create” in i915_gpu_error.c

Therefore, replace kmap() with kmap_local_page().

Suggested-by: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---

Changes in v2:
	- Replace kmap() with kmap_local_page().
	- Change commit subject and message.

 drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index f020c0086fbc..bc41500eedf5 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1164,9 +1164,9 @@ i915_vma_coredump_create(const struct intel_gt *gt,
 
 			drm_clflush_pages(&page, 1);
 
-			s = kmap(page);
+			s = kmap_local_page(page);
 			ret = compress_page(compress, s, dst, false);
-			kunmap(page);
+			kunmap_local(s);
 
 			drm_clflush_pages(&page, 1);
 
-- 
2.25.1

