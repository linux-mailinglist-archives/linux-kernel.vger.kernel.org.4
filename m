Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF88874EFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGKM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjGKM66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:58:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839E6199B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:58:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b00b0ab0daso4599675fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689080321; x=1691672321;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU8RjcxGHaSpkrCL2fsXpurNowL5PR34VSH3xLX8MPU=;
        b=W1FqicM/7RCFZKvgMAsxP9b+qji+BnA2i67pcCeEr1UEZcefwgCx3LnDB6khFygd1B
         I61lWZSZO0BjGYH1e2KvfhpKl+UFiGxLO109QlksXpPvPzTwLa6I0eZI5GIpyY/G2ue0
         p/ADGye/3BMAFkpGKCtYU2dWmp7a9sRxGLgelwDd/GzCAXZvh7ojiE0URaeiFKWrbW3O
         uZZGtM7MW4mXy4iocVPt/vizhzg4KoxtBJWxjfZBfmmlmc+PeZJI24B96EMdIHk6Xq7N
         HGoLYoLsOWxWDTnT5t9ZvFJ7wOVIcbJ2doRDeOttfohTyAbuErktCZ9DKDpB/UFFHRM0
         K6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080321; x=1691672321;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uU8RjcxGHaSpkrCL2fsXpurNowL5PR34VSH3xLX8MPU=;
        b=jUYNyH6pipE5uzUaik1i6cCcsRvXE1lXHYOrOUUAWZ/tpy1aO8LT8VT5KtpPb3fk/Z
         SHvRZb4udeq3gYLQW9bWz/ygqfZzhW20Skjd3+M76IU5iJdtKVuH/5riy5ZO+P0J8rB9
         w89VzaeD61JijoMhXRl7nI6WsIFuKUM5mJ87/A8HufmVHfnB0u942WO7+V8gZySFcYu0
         eDNFtpzZM9ZpFwV9Sc+Mh8jGWPIgD0AimSJByRHorjBPpS/1ASS8/O3AehQwiiTMQdlR
         IgpGkEaKggHK4VXFEgTGci1qaiqRAgz5q1E8d1qz+bV34qhnzI6Jo1XUvbiNiZs9XdHY
         TvEw==
X-Gm-Message-State: ABy/qLa0J7Yx30YxaCQyd2Z1DHJVZ/vnKfkJLGNn2l/usG3y4GFqVrLZ
        UgsrFcff/Ucnxv/s+4+PcKliHZ4hqb+Yz6NY
X-Google-Smtp-Source: APBJJlEsymi+G/LyqeqX1hXe3eIgL33jQ00cSUrq/eF6Ar5nURmqBFDPtRmBNKZO4onb4RWA0XkZ1A==
X-Received: by 2002:a05:6870:438f:b0:1b0:c99:fd1e with SMTP id r15-20020a056870438f00b001b00c99fd1emr13904626oah.4.1689080321422;
        Tue, 11 Jul 2023 05:58:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.173.165])
        by smtp.gmail.com with ESMTPSA id du9-20020a0568703a0900b001b3d67934e9sm969126oab.26.2023.07.11.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:58:40 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C479140516; Tue, 11 Jul 2023 09:58:36 -0300 (-03)
Date:   Tue, 11 Jul 2023 09:58:36 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Fei Yang <fei.yang@intel.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync drm/i915_drm.h with the
 kernel sources
Message-ID: <ZK1R/IyWcUKYQbQV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

  81b1b599dfd71c95 ("drm/i915: Allow user to set cache at BO creation")
  98d2722a85c4ad5f ("drm/i915/huc: differentiate the 2 steps of the MTL HuC auth flow")
  bc4be0a38b63b6d4 ("drm/i915/pmu: Prepare for multi-tile non-engine counters")
  d1da138f245d4fb4 ("drm/i915/uapi/pxp: Add a GET_PARAM for PXP")

That adds some ioctls but use the __I915_PMU_OTHER() macro, not
supported yet in the tools/perf/trace/beauty/drm_ioctl.sh conversion
script.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 95 ++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index dba7c5a5b25e9036..7000e5910a1d7453 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -280,7 +280,16 @@ enum drm_i915_pmu_engine_sample {
 #define I915_PMU_ENGINE_SEMA(class, instance) \
 	__I915_PMU_ENGINE(class, instance, I915_SAMPLE_SEMA)
 
-#define __I915_PMU_OTHER(x) (__I915_PMU_ENGINE(0xff, 0xff, 0xf) + 1 + (x))
+/*
+ * Top 4 bits of every non-engine counter are GT id.
+ */
+#define __I915_PMU_GT_SHIFT (60)
+
+#define ___I915_PMU_OTHER(gt, x) \
+	(((__u64)__I915_PMU_ENGINE(0xff, 0xff, 0xf) + 1 + (x)) | \
+	((__u64)(gt) << __I915_PMU_GT_SHIFT))
+
+#define __I915_PMU_OTHER(x) ___I915_PMU_OTHER(0, x)
 
 #define I915_PMU_ACTUAL_FREQUENCY	__I915_PMU_OTHER(0)
 #define I915_PMU_REQUESTED_FREQUENCY	__I915_PMU_OTHER(1)
@@ -290,6 +299,12 @@ enum drm_i915_pmu_engine_sample {
 
 #define I915_PMU_LAST /* Deprecated - do not use */ I915_PMU_RC6_RESIDENCY
 
+#define __I915_PMU_ACTUAL_FREQUENCY(gt)		___I915_PMU_OTHER(gt, 0)
+#define __I915_PMU_REQUESTED_FREQUENCY(gt)	___I915_PMU_OTHER(gt, 1)
+#define __I915_PMU_INTERRUPTS(gt)		___I915_PMU_OTHER(gt, 2)
+#define __I915_PMU_RC6_RESIDENCY(gt)		___I915_PMU_OTHER(gt, 3)
+#define __I915_PMU_SOFTWARE_GT_AWAKE_TIME(gt)	___I915_PMU_OTHER(gt, 4)
+
 /* Each region is a minimum of 16k, and there are at most 255 of them.
  */
 #define I915_NR_TEX_REGIONS 255	/* table size 2k - maximum due to use
@@ -659,7 +674,8 @@ typedef struct drm_i915_irq_wait {
  * If the IOCTL is successful, the returned parameter will be set to one of the
  * following values:
  *  * 0 if HuC firmware load is not complete,
- *  * 1 if HuC firmware is authenticated and running.
+ *  * 1 if HuC firmware is loaded and fully authenticated,
+ *  * 2 if HuC firmware is loaded and authenticated for clear media only
  */
 #define I915_PARAM_HUC_STATUS		 42
 
@@ -771,6 +787,25 @@ typedef struct drm_i915_irq_wait {
  */
 #define I915_PARAM_OA_TIMESTAMP_FREQUENCY 57
 
+/*
+ * Query the status of PXP support in i915.
+ *
+ * The query can fail in the following scenarios with the listed error codes:
+ *     -ENODEV = PXP support is not available on the GPU device or in the
+ *               kernel due to missing component drivers or kernel configs.
+ *
+ * If the IOCTL is successful, the returned parameter will be set to one of
+ * the following values:
+ *     1 = PXP feature is supported and is ready for use.
+ *     2 = PXP feature is supported but should be ready soon (pending
+ *         initialization of non-i915 system dependencies).
+ *
+ * NOTE: When param is supported (positive return values), user space should
+ *       still refer to the GEM PXP context-creation UAPI header specs to be
+ *       aware of possible failure due to system state machine at the time.
+ */
+#define I915_PARAM_PXP_STATUS		 58
+
 /* Must be kept compact -- no holes and well documented */
 
 /**
@@ -2096,6 +2131,21 @@ struct drm_i915_gem_context_param {
  *
  * -ENODEV: feature not available
  * -EPERM: trying to mark a recoverable or not bannable context as protected
+ * -ENXIO: A dependency such as a component driver or firmware is not yet
+ *         loaded so user space may need to attempt again. Depending on the
+ *         device, this error may be reported if protected context creation is
+ *         attempted very early after kernel start because the internal timeout
+ *         waiting for such dependencies is not guaranteed to be larger than
+ *         required (numbers differ depending on system and kernel config):
+ *            - ADL/RPL: dependencies may take up to 3 seconds from kernel start
+ *                       while context creation internal timeout is 250 milisecs
+ *            - MTL: dependencies may take up to 8 seconds from kernel start
+ *                   while context creation internal timeout is 250 milisecs
+ *         NOTE: such dependencies happen once, so a subsequent call to create a
+ *         protected context after a prior successful call will not experience
+ *         such timeouts and will not return -ENXIO (unless the driver is reloaded,
+ *         or, depending on the device, resumes from a suspended state).
+ * -EIO: The firmware did not succeed in creating the protected context.
  */
 #define I915_CONTEXT_PARAM_PROTECTED_CONTENT    0xd
 /* Must be kept compact -- no holes and well documented */
@@ -3630,9 +3680,13 @@ struct drm_i915_gem_create_ext {
 	 *
 	 * For I915_GEM_CREATE_EXT_PROTECTED_CONTENT usage see
 	 * struct drm_i915_gem_create_ext_protected_content.
+	 *
+	 * For I915_GEM_CREATE_EXT_SET_PAT usage see
+	 * struct drm_i915_gem_create_ext_set_pat.
 	 */
 #define I915_GEM_CREATE_EXT_MEMORY_REGIONS 0
 #define I915_GEM_CREATE_EXT_PROTECTED_CONTENT 1
+#define I915_GEM_CREATE_EXT_SET_PAT 2
 	__u64 extensions;
 };
 
@@ -3747,6 +3801,43 @@ struct drm_i915_gem_create_ext_protected_content {
 	__u32 flags;
 };
 
+/**
+ * struct drm_i915_gem_create_ext_set_pat - The
+ * I915_GEM_CREATE_EXT_SET_PAT extension.
+ *
+ * If this extension is provided, the specified caching policy (PAT index) is
+ * applied to the buffer object.
+ *
+ * Below is an example on how to create an object with specific caching policy:
+ *
+ * .. code-block:: C
+ *
+ *      struct drm_i915_gem_create_ext_set_pat set_pat_ext = {
+ *              .base = { .name = I915_GEM_CREATE_EXT_SET_PAT },
+ *              .pat_index = 0,
+ *      };
+ *      struct drm_i915_gem_create_ext create_ext = {
+ *              .size = PAGE_SIZE,
+ *              .extensions = (uintptr_t)&set_pat_ext,
+ *      };
+ *
+ *      int err = ioctl(fd, DRM_IOCTL_I915_GEM_CREATE_EXT, &create_ext);
+ *      if (err) ...
+ */
+struct drm_i915_gem_create_ext_set_pat {
+	/** @base: Extension link. See struct i915_user_extension. */
+	struct i915_user_extension base;
+	/**
+	 * @pat_index: PAT index to be set
+	 * PAT index is a bit field in Page Table Entry to control caching
+	 * behaviors for GPU accesses. The definition of PAT index is
+	 * platform dependent and can be found in hardware specifications,
+	 */
+	__u32 pat_index;
+	/** @rsvd: reserved for future use */
+	__u32 rsvd;
+};
+
 /* ID of the protected content session managed by i915 when PXP is active */
 #define I915_PROTECTED_CONTENT_DEFAULT_SESSION 0xf
 
-- 
2.37.1

