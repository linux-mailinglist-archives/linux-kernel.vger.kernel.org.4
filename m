Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723496B3BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjCJKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCJKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:05:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6DD108C19;
        Fri, 10 Mar 2023 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678442705; x=1709978705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQwh0qZU4TAZ+z99KsgG//ut2821Ahj0nz8hE5A6nek=;
  b=DY6gnc4MtissJFkioEUWe9mIbhpqhJSo6XGxxNLv+dCcTxgLQ2NNOI3v
   2AyORrYQGP0KYzmJefzACDAE5lPaxYm3hm4TDlHT5h94Q4jvbtqoCBe5P
   fuVyAfJfoMOuG0a7uhA5SqmXlxX04OK0ugV8f1cuVDLXNtW9ct3W9Uhkk
   lp4HbuurOHp+ChI6p2o9XJwJaVgaWYG+7b4Da0s/dNryYNagxNhDf19XG
   OkkofgngikDLknD8EMPgFzn/xFffPQFCm19GfzI68Ui3FfAZImxEJVUvd
   lvLxjv+20GOB/vMnKlXfqtXNdeO+1bjo2+NT7R5hgBGO7uQYByBy5Ky/n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="399294167"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399294167"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="923609300"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="923609300"
Received: from fliu-mobl.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.32.249])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:05:02 -0800
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 1/2] trace/hwlat: Do not wipe the contents of per-cpu thread data
Date:   Fri, 10 Mar 2023 12:04:50 +0200
Message-Id: <20230310100451.3948583-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
References: <20230310100451.3948583-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not wipe the contents of the per-cpu kthread data when starting the
tracer, as this will completely forget about already running instances
and can later start new additional per-cpu threads.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
v2:
  * split into separate patch

 kernel/trace/trace_hwlat.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d440ddd5fd8b..edc26dc22c3f 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -584,9 +584,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 
-	for_each_online_cpu(cpu)
-		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
-
 	for_each_cpu(cpu, current_mask) {
 		retval = start_cpu_kthread(cpu);
 		if (retval)
-- 
2.25.1

