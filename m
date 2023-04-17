Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF8D6E456C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjDQKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjDQKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:40:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F565AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so11584086wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727944; x=1684319944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAW7sB6+Z5ZOltjkFBMt2NbhGjStc/CgCoci8oN9nks=;
        b=lk90wuKk7kR9IX6uMik68yOAyW5/zZmQWcphsp7dCp9z3gtp/owgQL9h2aAbLKBZl4
         fCT8G5zvkCrwE8UQwr3TI2qV7TEBSeuZSe9ChabtOXCucPLOySit4w+Ukcnt1MR6xcJD
         RBcU0cLyIawG1B8WldS9XwJKzvAn1uvF3XJQUQD4rxY6QsnOGA8yokADx7cMlcSkaxFs
         5+cWcTxbRQ//yFlyW01nwMQQHtlmblF6pwjWClW/urNU4TC+6JZnbE5L8Bg4kfHflzxL
         /4UrOEAQM7KKog1/7dO7jGRKmFaB5tY3maCKiDRQFq5G039Z4m4zDMRjCuuJMMI16nKs
         eHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727944; x=1684319944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAW7sB6+Z5ZOltjkFBMt2NbhGjStc/CgCoci8oN9nks=;
        b=GGX0GN/bbEvuTs/BQ+LgMJ85EP11rMfTyWvaZUJT3qgmx4IVE76/2oy+fl6nWPcVtn
         ApZoLmwCYC/IxkW4hPABVNun+c1VftqtyBIxT+wCuXonxzs4lDAgKMyfanAiMZn0/iUL
         IAU+BekX+9cx0YLM/zBrdaqDzCt6NhaGyjItRcAuSBvj5aBD/H0B3kNubIg6q1lH+2NE
         w1M8C8poejuFLOxhjIsMoBjEy2QT1Parf1BBQiOyF1zWOQiKieyO6VSO7pp2kc8PEzYF
         gf3cB2pzDV/ySIX5NaZiUcT1UPzgrUO7P3R58gMs7OaQjJyo7PzEICbfbKTLCFhKvFcj
         RwXg==
X-Gm-Message-State: AAQBX9d3UZlBbiKSBbCbJzujYk/hbk1ZUvt/V/90POeutcsUOwlIG8Cg
        3I68MSBXJUPEJrcDQ6WMypk=
X-Google-Smtp-Source: AKy350bqJ/bHsDjtLWvuVfbc6Uq/QInCoRKCm+KLyl/hHEccIaE3q+1++wO1znNLhcQOGVkqIM5BVw==
X-Received: by 2002:a05:600c:4f46:b0:3f1:7443:6d6e with SMTP id m6-20020a05600c4f4600b003f174436d6emr1590807wmq.19.1681727943960;
        Mon, 17 Apr 2023 03:39:03 -0700 (PDT)
Received: from localhost.localdomain (host-87-19-108-254.retail.telecomitalia.it. [87.19.108.254])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002c70ce264bfsm10238018wrq.76.2023.04.17.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:39:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 2/3] drm/i915/gt: Replace kmap() with kmap_local_page()
Date:   Mon, 17 Apr 2023 12:38:53 +0200
Message-Id: <20230417103854.23333-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417103854.23333-1-fmdefrancesco@gmail.com>
References: <20230417103854.23333-1-fmdefrancesco@gmail.com>
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

kmap() s been deprecated in favor of kmap_local_page().

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

Obviously, thread locality implies that the kernel virtual addresses are
only valid in the context of the callers. The use of kmap_local_page() in
i915/gt doesn't break the above-mentioned constraint, so it should be
preferred to kmap().

Therefore, replace kmap() with kmap_local_page() in i915/gt.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
index 37d0b0fe791d..89295c6921d6 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
@@ -749,7 +749,7 @@ static void swizzle_page(struct page *page)
 	char *vaddr;
 	int i;

-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);

 	for (i = 0; i < PAGE_SIZE; i += 128) {
 		memcpy(temp, &vaddr[i], 64);
@@ -757,7 +757,7 @@ static void swizzle_page(struct page *page)
 		memcpy(&vaddr[i + 64], temp, 64);
 	}

-	kunmap(page);
+	kunmap_local(vaddr);
 }

 /**
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 449c9ed44382..be809839a241 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -101,22 +101,19 @@ static int __shmem_rw(struct file *file, loff_t off,
 		unsigned int this =
 			min_t(size_t, PAGE_SIZE - offset_in_page(off), len);
 		struct page *page;
-		void *vaddr;

 		page = shmem_read_mapping_page_gfp(file->f_mapping, pfn,
 						   GFP_KERNEL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);

-		vaddr = kmap(page);
 		if (write) {
-			memcpy(vaddr + offset_in_page(off), ptr, this);
+			memcpy_to_page(page, offset_in_page(off), ptr, this);
 			set_page_dirty(page);
 		} else {
-			memcpy(ptr, vaddr + offset_in_page(off), this);
+			memcpy_from_page(ptr, page, offset_in_page(off), this);
 		}
 		mark_page_accessed(page);
-		kunmap(page);
 		put_page(page);

 		len -= this;
@@ -143,11 +140,11 @@ int shmem_read_to_iosys_map(struct file *file, loff_t off,
 		if (IS_ERR(page))
 			return PTR_ERR(page);

-		vaddr = kmap(page);
+		vaddr = kmap_local_page(page);
 		iosys_map_memcpy_to(map, map_off, vaddr + offset_in_page(off),
 				    this);
 		mark_page_accessed(page);
-		kunmap(page);
+		kunmap_local(vaddr);
 		put_page(page);

 		len -= this;
--
2.40.0

