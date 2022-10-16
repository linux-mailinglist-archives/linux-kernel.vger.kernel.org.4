Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E36002B4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJPSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:09:51 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71A18373
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so10760649wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy/r1oKj6pjC6tDTxJAus+AvI8wYjcvPrvVlllaZosE=;
        b=jhVs03HebeLgK4gCknqUY7zv32A2/tNizCdKRVC+Q6gLrPJmkHF6T9sARRl7aB23ra
         O2u9fU1whvzvVevdGJpVJTYAtNQOcDGdC3z5DY/K6CYxWWPXGKscf/pjyAAJkRE7b/vv
         GsTtSKxCBPcDfFc+elHGDSGL9vf/LS+MOqJLie2gptXM9g45FnH2PrErpKYdC5tSasI4
         9QHfevd/9k42Lm8ENnU+sq+wnFs7TlF6Zvp9XjHlRURgVDJDgvGCh9sfStyA/9m8rAI/
         RjO5gmt8MoTRO4c1I5o24kM88Wd8OAyo5WFs8qt4WIVVS4VQyq8Sgn89xzmgJunZgrqd
         sUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy/r1oKj6pjC6tDTxJAus+AvI8wYjcvPrvVlllaZosE=;
        b=GiUYZwt42ebGlXnnQSGYjp7m2nxAgtCfYFt2U1/FAb89DqA52cEC3EpnSgipq3YPP4
         gM463ZO1wDKW97J4KCiwOmC4Frtd0qWKQEE5Nny4J/ZEzkV2D7eInoCiR62EZi37R7vL
         FVPuP9j+gq53bsyii/zY7Uw1NUwJTStwaEh54BNroe4T+9S7G1DdGxEXyAyKiKYNNfBW
         TA2ArxpeqJIdKwW0G54P3e6PnKhHKor5Hm7kc3guPLUhQ79Yo4GH3TYFSX0Ckk82m+Ig
         wh5PpQuDYgtyo4gWO16wdYMFLFLXruUJfqVMEY3NCbH01K79ns3AcZ+vwXHXtM7seYDz
         irKA==
X-Gm-Message-State: ACrzQf2Lt2tg5e1SBbRwP/xefqOIaS7uK7ZhbZCBVDC38iaBD9Pm961U
        Bda+lVDdBelTDLp53ERUoNE=
X-Google-Smtp-Source: AMsMyM429gVcrmq2vVmbF0aisu9csZqLaMboh6B4truVw62DWDKu+Ln262TAG0cL+qGqSPwRs+/Zcg==
X-Received: by 2002:a05:600c:5490:b0:3c6:d8f2:6e1a with SMTP id iv16-20020a05600c549000b003c6d8f26e1amr4989604wmb.90.1665943788240;
        Sun, 16 Oct 2022 11:09:48 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003c6f8d30e40sm156225wmn.31.2022.10.16.11.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:09:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH 1/3] drm/i915: Replace kmap() with kmap_local_page()
Date:   Sun, 16 Oct 2022 20:09:36 +0200
Message-Id: <20221016180938.17403-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016180938.17403-1-fmdefrancesco@gmail.com>
References: <20221016180938.17403-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and are still valid.

Since its use in i915_gem.c is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in i915_gem.c

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 702e5b89be22..43effce60e1b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -212,14 +212,14 @@ shmem_pread(struct page *page, int offset, int len, char __user *user_data,
 	char *vaddr;
 	int ret;
 
-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);
 
 	if (needs_clflush)
 		drm_clflush_virt_range(vaddr + offset, len);
 
 	ret = __copy_to_user(user_data, vaddr + offset, len);
 
-	kunmap(page);
+	kunmap_local(vaddr);
 
 	return ret ? -EFAULT : 0;
 }
@@ -634,7 +634,7 @@ shmem_pwrite(struct page *page, int offset, int len, char __user *user_data,
 	char *vaddr;
 	int ret;
 
-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);
 
 	if (needs_clflush_before)
 		drm_clflush_virt_range(vaddr + offset, len);
@@ -643,7 +643,7 @@ shmem_pwrite(struct page *page, int offset, int len, char __user *user_data,
 	if (!ret && needs_clflush_after)
 		drm_clflush_virt_range(vaddr + offset, len);
 
-	kunmap(page);
+	kunmap_local(vaddr);
 
 	return ret ? -EFAULT : 0;
 }
-- 
2.37.1

