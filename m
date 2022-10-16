Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4312F6002B6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJPSKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJPSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:09:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8969718E13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so15116678wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI+p8PoHxDYC4LpvdrLHwtfP0NQYizXCNc6bGLJV3BM=;
        b=NnVxmZIwq0HoVdrIgrUbyS3p5zXE9BJbo8ZujVGSl8FDW8639FUEKRhADnwIlkJwUX
         Oc3+DKXK/svsnSR6l7GdTr7r7EwS6XvYmWNsLVwOCCOr+gx8PZhjjVY0cB5M0fDaOghA
         EI+nVpYZnvjctxeG7SNe3OJAL/JZ6fhHx3Y765y3s1qKGB9ccx2uCNS3Gn+wLkUhIkeS
         LigflbUgzTi3TwuMG7iMxTWODP0Fv8rZThmFyq3/kuY5LV1b6zo7yXUwvlaJp7oYt7ar
         X21qEp4n8U2s1t7lkTYLeRRQnklGmm58Lq2/S4tyA710drxhV/SwGb8h9/pqGf6E7q73
         Dm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI+p8PoHxDYC4LpvdrLHwtfP0NQYizXCNc6bGLJV3BM=;
        b=1nEdFUlWW+F2+LhEDrg9Mv7DHYx8Z+x3S+vc8VrmN1fokWU9KLAvNFLmwv2vZ1upPd
         r7uyyfawLBMF0kzr788fba5GD03Hxt54UFzKV9RNzb0ZEqDxAZPn5FiZ9UJO6dikRn2w
         +v6VgXq8BgYoH/tnqqjm+udk+ROu58C08Hx1mMXMv5wWLnw+wmQkrkRwiIbQogqGr3qs
         7mP/NoTTN7eNyAguBFonLEViqic8MezN3F0BAIt7vdxsP9vYOQ0HBYJWzvR/k4oLdrIv
         SKXl7hQqhg65hiIgOGD815+EGPjDF11nsqAX+KtOqzU2xQwVxObXlyAy8l08tAHWDp1D
         EVdQ==
X-Gm-Message-State: ACrzQf3DaCWOz+pYZWjLaZMDYTIYSwKXWcbwBtg2IApyVIXCvPhPmbYB
        KCyVSRl1zXy0WjCVjVFrzlc=
X-Google-Smtp-Source: AMsMyM4TFFYwfNI0jMueu6o2fvMAP77lkBkuySciaa99usWeed6HF2eiiDFXIWDZcKzwv6BDLn54xw==
X-Received: by 2002:a05:6000:178c:b0:231:ce45:7e00 with SMTP id e12-20020a056000178c00b00231ce457e00mr4224821wrg.598.1665943790733;
        Sun, 16 Oct 2022 11:09:50 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003c6f8d30e40sm156225wmn.31.2022.10.16.11.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:09:50 -0700 (PDT)
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
Subject: [RESEND PATCH 2/3] drm/i915/gt: Replace kmap() with kmap_local_page()
Date:   Sun, 16 Oct 2022 20:09:37 +0200
Message-Id: <20221016180938.17403-3-fmdefrancesco@gmail.com>
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

Since its use in i915/gt is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in i915/gt. Instead of
open-coding local mappings + memcpy() + local unmappings, use
the memcpy_{from,to}_page() helpers where these are better suited.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
index 6ebda3d65086..21d8ce40b897 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c
@@ -747,7 +747,7 @@ static void swizzle_page(struct page *page)
 	char *vaddr;
 	int i;
 
-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);
 
 	for (i = 0; i < PAGE_SIZE; i += 128) {
 		memcpy(temp, &vaddr[i], 64);
@@ -755,7 +755,7 @@ static void swizzle_page(struct page *page)
 		memcpy(&vaddr[i + 64], temp, 64);
 	}
 
-	kunmap(page);
+	kunmap_local(vaddr);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/gt/shmem_utils.c b/drivers/gpu/drm/i915/gt/shmem_utils.c
index 402f085f3a02..48edbb8a33e5 100644
--- a/drivers/gpu/drm/i915/gt/shmem_utils.c
+++ b/drivers/gpu/drm/i915/gt/shmem_utils.c
@@ -98,22 +98,19 @@ static int __shmem_rw(struct file *file, loff_t off,
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
@@ -140,11 +137,11 @@ int shmem_read_to_iosys_map(struct file *file, loff_t off,
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
2.37.1

