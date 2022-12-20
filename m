Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23173652579
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:19:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6ABDB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:19:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26D60B811EF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EF5C433D2;
        Tue, 20 Dec 2022 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671556762;
        bh=PdmS9Z/Rh3HQKOTLCRGWIyWYwvPygQzGXzJl6v5Whgo=;
        h=Date:From:To:Cc:Subject:From;
        b=mBSoXzfasajkzLEflN1JxGniQ5mMCZI1Jhx55+YKoS7j0HkhqqA0NqzO4mkVZNAC1
         o2vfVfL1vGxWfC92auBbfttu6mh4RIbvhDL4d/H++W3P0q6lly0O+KG65b2ihhCAPz
         pi9bCEUJh2PCs9E26Yi2POUVp7+Cz+HQTGsw6Xnx2TbgGWmp+u3GmaDyAoqa8XNQNV
         ZNotYl6jkstviHEInDni5EVz5G8VKX+6kzyscN9eDi4cVBqw30ZYCtlKfRg7ENUWg+
         dnvi3celj0ffgAspM7+XfpsuoYSKe3ub0fJ9bN+Rtb5Hi2S76X2B80m+L4O6fvOiD4
         Zt+rDOMHkko0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2B5140367; Tue, 20 Dec 2022 14:19:14 -0300 (-03)
Date:   Tue, 20 Dec 2022 14:19:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync drm/i915_drm.h with the
 kernel sources
Message-ID: <Y6HukoRaZh2R4j5U@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To pick up the changes in:

  bc7ed4d30815bc43 ("drm/i915/perf: Apply Wa_18013179988")
  81d5f7d91492aa3a ("drm/i915/perf: Add 32-bit OAG and OAR formats for DG2")
  8133a6daad4e7274 ("drm/i915: enable PS64 support for DG2")
  b76c14c8fb2af1e4 ("drm/i915/huc: better define HuC status getparam possible return values.")
  94dfc73e7cf4a31d ("treewide: uapi: Replace zero-length arrays with flexible-array members")

That doesn't add any ioctl, so no changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 62 ++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 520ad2691a99d166..8df261c5ab9b1a22 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -645,6 +645,22 @@ typedef struct drm_i915_irq_wait {
  */
 #define   I915_SCHEDULER_CAP_STATIC_PRIORITY_MAP	(1ul << 5)
 
+/*
+ * Query the status of HuC load.
+ *
+ * The query can fail in the following scenarios with the listed error codes:
+ *  -ENODEV if HuC is not present on this platform,
+ *  -EOPNOTSUPP if HuC firmware usage is disabled,
+ *  -ENOPKG if HuC firmware fetch failed,
+ *  -ENOEXEC if HuC firmware is invalid or mismatched,
+ *  -ENOMEM if i915 failed to prepare the FW objects for transfer to the uC,
+ *  -EIO if the FW transfer or the FW authentication failed.
+ *
+ * If the IOCTL is successful, the returned parameter will be set to one of the
+ * following values:
+ *  * 0 if HuC firmware load is not complete,
+ *  * 1 if HuC firmware is authenticated and running.
+ */
 #define I915_PARAM_HUC_STATUS		 42
 
 /* Query whether DRM_I915_GEM_EXECBUFFER2 supports the ability to opt-out of
@@ -749,6 +765,12 @@ typedef struct drm_i915_irq_wait {
 /* Query if the kernel supports the I915_USERPTR_PROBE flag. */
 #define I915_PARAM_HAS_USERPTR_PROBE 56
 
+/*
+ * Frequency of the timestamps in OA reports. This used to be the same as the CS
+ * timestamp frequency, but differs on some platforms.
+ */
+#define I915_PARAM_OA_TIMESTAMP_FREQUENCY 57
+
 /* Must be kept compact -- no holes and well documented */
 
 /**
@@ -2650,6 +2672,10 @@ enum drm_i915_oa_format {
 	I915_OA_FORMAT_A12_B8_C8,
 	I915_OA_FORMAT_A32u40_A4u32_B8_C8,
 
+	/* DG2 */
+	I915_OAR_FORMAT_A32u40_A4u32_B8_C8,
+	I915_OA_FORMAT_A24u40_A14u32_B8_C8,
+
 	I915_OA_FORMAT_MAX	    /* non-ABI */
 };
 
@@ -3493,27 +3519,13 @@ struct drm_i915_gem_create_ext {
 	 *
 	 * The (page-aligned) allocated size for the object will be returned.
 	 *
-	 * DG2 64K min page size implications:
-	 *
-	 * On discrete platforms, starting from DG2, we have to contend with GTT
-	 * page size restrictions when dealing with I915_MEMORY_CLASS_DEVICE
-	 * objects.  Specifically the hardware only supports 64K or larger GTT
-	 * page sizes for such memory. The kernel will already ensure that all
-	 * I915_MEMORY_CLASS_DEVICE memory is allocated using 64K or larger page
-	 * sizes underneath.
-	 *
-	 * Note that the returned size here will always reflect any required
-	 * rounding up done by the kernel, i.e 4K will now become 64K on devices
-	 * such as DG2. The kernel will always select the largest minimum
-	 * page-size for the set of possible placements as the value to use when
-	 * rounding up the @size.
-	 *
-	 * Special DG2 GTT address alignment requirement:
-	 *
-	 * The GTT alignment will also need to be at least 2M for such objects.
+	 * On platforms like DG2/ATS the kernel will always use 64K or larger
+	 * pages for I915_MEMORY_CLASS_DEVICE. The kernel also requires a
+	 * minimum of 64K GTT alignment for such objects.
 	 *
-	 * Note that due to how the hardware implements 64K GTT page support, we
-	 * have some further complications:
+	 * NOTE: Previously the ABI here required a minimum GTT alignment of 2M
+	 * on DG2/ATS, due to how the hardware implemented 64K GTT page support,
+	 * where we had the following complications:
 	 *
 	 *   1) The entire PDE (which covers a 2MB virtual address range), must
 	 *   contain only 64K PTEs, i.e mixing 4K and 64K PTEs in the same
@@ -3522,12 +3534,10 @@ struct drm_i915_gem_create_ext {
 	 *   2) We still need to support 4K PTEs for I915_MEMORY_CLASS_SYSTEM
 	 *   objects.
 	 *
-	 * To keep things simple for userland, we mandate that any GTT mappings
-	 * must be aligned to and rounded up to 2MB. The kernel will internally
-	 * pad them out to the next 2MB boundary. As this only wastes virtual
-	 * address space and avoids userland having to copy any needlessly
-	 * complicated PDE sharing scheme (coloring) and only affects DG2, this
-	 * is deemed to be a good compromise.
+	 * However on actual production HW this was completely changed to now
+	 * allow setting a TLB hint at the PTE level (see PS64), which is a lot
+	 * more flexible than the above. With this the 2M restriction was
+	 * dropped where we now only require 64K.
 	 */
 	__u64 size;
 
-- 
2.38.1

