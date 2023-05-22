Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060C70BBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjEVLbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjEVLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:31:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4555F9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755060; x=1716291060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UbeQmBAHRioVJIl/LEdjqpc4KZUNiSUTMwnWy/W3vOw=;
  b=g3n1EfO43c5MXZZHKlNF0DeiwhkUWqVtZiIZpOxLCcGLmbGIZhKjTxuU
   hIUCRXms0PVhLj4W1odWc5DjTZ637eRLgY9oax/lJWQnta4pnoxW87Q4R
   NwkbEXU0i7Ho38TJWmEwNLP4K2+obc6RaBKD+RsDSCd4VbVSbm/7VGOde
   Jkcnv0Ym5x4RyQl4k+50FAjzrWMehndxYSZpXZipqAxtrsH8ngivYFuVE
   IXy1JGffL19bKg5ymop5RpwVXqSRGTkqYBthNSy8kyS9YDpPNHj5FkQjN
   ig/WC9IsllwSJfeZLXg6q3SXWyP1tdScThCKCSNLsipvXX0GY+wKMVaeO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416356755"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416356755"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703468258"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703468258"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:30:59 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/6] perf: Support branch events
Date:   Mon, 22 May 2023 04:30:37 -0700
Message-Id: <20230522113040.2329924-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the cycle time information between branches, stalls can be easily
observed. But it's difficult to explain what causes the long delay.

Add a new branch sample type to indicate whether include occurrences of
events in branch info. The information will be stored in the branch
stack extension space.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Rename to PERF_SAMPLE_BRANCH_EVT_CNTRS
- Drop the event ID sample type

 include/linux/perf_event.h      | 4 ++++
 include/uapi/linux/perf_event.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e2e04dc39199..823c6779a96d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1137,6 +1137,10 @@ static inline bool branch_sample_priv(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
 }
 
+static inline bool branch_sample_evt_cntrs(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
+}
 
 struct perf_sample_data {
 	/*
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b3b90965b6b..3911cf000e8a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -204,6 +204,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT	= 19, /* save occurrences of events on a branch */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +237,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_EVT_CNTRS	= 1U << PERF_SAMPLE_BRANCH_EVT_CNTRS_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
-- 
2.35.1

