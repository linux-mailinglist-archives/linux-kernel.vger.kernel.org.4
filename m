Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679FE6E456B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjDQKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjDQKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:40:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C48D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so1408385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681727942; x=1684319942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkh5X1oOnHmMtPThd/Ogb+Ei0/Iy+LdjudYL5nRHiA8=;
        b=XO/vfE0ttxJFtb+z+zDWyoXcM09x8Zs78N3GfyVo9gwDIuuHa3a1Gya8goc4sNmMJV
         vJR78/+//6TCZvI30CK/mDXRtQDDAPsnAizkwB7SubAmmPETo39N1bcxXg1o3cKdtQmJ
         iCoD6j4lKCLRHYwJI1MFIYJlEvuRAjgVkoOTZ/uX15pf4L+VkS92fyBzWSrLwGYY50At
         OR7OTpSJgtuz6ZDgg4F9K6kpnJv0D1ptjteBC4ZP3XgKXT3gyKF4/aYye3QW/JCfu8DK
         jN3oOf3Qkl4Z3pTExiIhOq34ri6WOzWaj3YJ2LKW9OBRVj7+1BrJHbhm4NXNHFDfBeZ8
         h7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681727942; x=1684319942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkh5X1oOnHmMtPThd/Ogb+Ei0/Iy+LdjudYL5nRHiA8=;
        b=U1m7L5ORZDI5hB55r9iQECY4mBCGYXp8RaI4L1l4hLr+00qhJKfuOx3IZuNlVPkzYh
         oE+q6qHNwU7JHO9F5a5fIvZxTZGbP5zcOSDrEr4PE2W1WcK+5enGGTBYo/+HgqYlhYzD
         CQ4J4PmF1ElBK3Oiq4TiZrCiYH7ohuZuCyV87/nIGXIaAlDK1EpdE3sFejwfUC5/qurB
         FN6TNl0RYo3wFiwL2y2RYDP/R4I53yNJpY/4ayPa+AOvfW/IpeLu/KLY0ftSJWlCV715
         d8dCAr90N6Jfj6q6KhdfYNen0v6AEDDR5j6NmgDeIuV8lxpTTV29Aqs7dX6DjuDNOwRc
         0Acw==
X-Gm-Message-State: AAQBX9cYMHV1TmjcTKrUz0s9Rk0UQsBjjE5avWrYR/5z7sktACVg5SCm
        gIId/ZFGX9i/Hy3bxPW6vAAOKChGPyc=
X-Google-Smtp-Source: AKy350ZWcTYKgg1QBjpNgdR9wjl3y2FJYThqP4aJuL8PsgT/C8+4jSADpdmdsMu3nAzGfM6xeTh5vg==
X-Received: by 2002:a5d:6606:0:b0:2f8:dd25:f96e with SMTP id n6-20020a5d6606000000b002f8dd25f96emr4345092wru.6.1681727942023;
        Mon, 17 Apr 2023 03:39:02 -0700 (PDT)
Received: from localhost.localdomain (host-87-19-108-254.retail.telecomitalia.it. [87.19.108.254])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002c70ce264bfsm10238018wrq.76.2023.04.17.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 03:39:01 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drm/i915: Replace kmap() with kmap_local_page()
Date:   Mon, 17 Apr 2023 12:38:52 +0200
Message-Id: <20230417103854.23333-2-fmdefrancesco@gmail.com>
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

kmap() has been deprecated in favor of kmap_local_page().

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

Obviously, thread locality implies that the kernel voirtual addresses
are valid only in the context of the callers. kmap_local_page() use in
i915_gem.c doesn't break the above-mentioned constraint, so it should be
preferred to kmap().

Therefore, replace kmap() with kmap_local_page() in i915_gem.c

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 35950fa91406..c35248555e42 100644
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
@@ -643,7 +643,7 @@ shmem_pwrite(struct page *page, int offset, int len, char __user *user_data,
 	char *vaddr;
 	int ret;

-	vaddr = kmap(page);
+	vaddr = kmap_local_page(page);

 	if (needs_clflush_before)
 		drm_clflush_virt_range(vaddr + offset, len);
@@ -652,7 +652,7 @@ shmem_pwrite(struct page *page, int offset, int len, char __user *user_data,
 	if (!ret && needs_clflush_after)
 		drm_clflush_virt_range(vaddr + offset, len);

-	kunmap(page);
+	kunmap_local(vaddr);

 	return ret ? -EFAULT : 0;
 }
--
2.40.0

