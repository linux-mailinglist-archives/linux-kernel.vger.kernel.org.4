Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FCB63D725
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiK3NtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiK3NtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:49:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE3218BB;
        Wed, 30 Nov 2022 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669816150; x=1701352150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EyJFPG6PhV/AwdfzlcYIAHQ0QmtsikwhVNregiJywak=;
  b=W6k2S1Pgs1JtmKpFI2qJvzwzACxulY1RmXNqcm0O432WGIjGJiTwpTCm
   3qoKfHEdNRtiMMRQGecDTwMUvH5V5W5iamVmmwMwr5G2QW2J5g/hTe+0N
   My3LmaUn2/a0sLhNO0/KiyjXGYcshaYI4HMjDXdpvvXkl8sSMo2Ko9nAX
   q5v8u4IOJti8jGo8qwRy+7l9HT/P721xThXq5cVJVoA/9pAIetyt80oz3
   1GK+tcFM/n+QzSsKWh5he2UFdDVsnF2Veob2/hksuqbUpAX5yoHpozUrg
   lk806IluZOfM2L4iUMP/H9+h//MOf/EAr/B6YXLDCC0yfvFQ3WQUyl1sQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298769783"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="298769783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 05:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676825898"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="676825898"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 05:48:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 89D29179; Wed, 30 Nov 2022 15:48:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v5 1/4] i915: Move list_count() to list.h as list_count_nodes() for broader use
Date:   Wed, 30 Nov 2022 15:48:35 +0200
Message-Id: <20221130134838.23805-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the existing users, and definitely will be new ones, want to
count existing nodes in the list. Provide a generic API for that by
moving code from i915 to list.h.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: added tag (Lucas), renamed API to list_count_nodes() (LKP)
v4: fixed prototype when converting to static inline
v3: added tag (Jani), changed to be static inline (Mike)
v2: dropped the duplicate code in i915 (LKP)
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 15 ++-------------
 include/linux/list.h                      | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 1f7188129cd1..370164363b0d 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -2004,17 +2004,6 @@ static void print_request_ring(struct drm_printer *m, struct i915_request *rq)
 	}
 }
 
-static unsigned long list_count(struct list_head *list)
-{
-	struct list_head *pos;
-	unsigned long count = 0;
-
-	list_for_each(pos, list)
-		count++;
-
-	return count;
-}
-
 static unsigned long read_ul(void *p, size_t x)
 {
 	return *(unsigned long *)(p + x);
@@ -2189,8 +2178,8 @@ void intel_engine_dump(struct intel_engine_cs *engine,
 	spin_lock_irqsave(&engine->sched_engine->lock, flags);
 	engine_dump_active_requests(engine, m);
 
-	drm_printf(m, "\tOn hold?: %lu\n",
-		   list_count(&engine->sched_engine->hold));
+	drm_printf(m, "\tOn hold?: %zu\n",
+		   list_count_nodes(&engine->sched_engine->hold));
 	spin_unlock_irqrestore(&engine->sched_engine->lock, flags);
 
 	drm_printf(m, "\tMMIO base:  0x%08x\n", engine->mmio_base);
diff --git a/include/linux/list.h b/include/linux/list.h
index 61762054b4be..f10344dbad4d 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -655,6 +655,21 @@ static inline void list_splice_tail_init(struct list_head *list,
 	     !list_is_head(pos, (head)); \
 	     pos = n, n = pos->prev)
 
+/**
+ * list_count_nodes - count nodes in the list
+ * @head:	the head for your list.
+ */
+static inline size_t list_count_nodes(struct list_head *head)
+{
+	struct list_head *pos;
+	size_t count = 0;
+
+	list_for_each(pos, head)
+		count++;
+
+	return count;
+}
+
 /**
  * list_entry_is_head - test if the entry points to the head of the list
  * @pos:	the type * to cursor
-- 
2.35.1

