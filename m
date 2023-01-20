Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D346754A3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjATMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjATMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6CBF5EB;
        Fri, 20 Jan 2023 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218129; x=1705754129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JH3uowZm2/EOmx74lVqvydtWQ0K9xGM+P+gA7PXly5g=;
  b=HYSip1CFyvJ3Ob6Md91EkTc8u2dj9IfnC7PUrHcByJUwA6dd5vOAax32
   1DYVFicwa/S808ZrHAIbXlNA8p9mJF0dsEdNDbQPEyJAfGcD8rF415VcK
   xVGmJas1ly1P4MHBaOEUQXhIe/KXxBjKQGB+1fEGxa0qaR5ywbIvbeJpt
   pSFLEm+tpjsykvS2hR+vLsXD41oA72LsRqnPnlbx+m4aIA11Oi8o1lYEH
   9k6V+5HzaGJf+0FW3zoUluJK3CXgvURkYlc0RxKwSdR3AIWBj4oXrtHXH
   ZwH4Pdg60b6mf49awK8YbBZ1wizAKq7bHsaM31UsXfFqjx2RPYd2EM+rL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935241"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847442"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847442"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:26 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 06/10] perf symbols: Do not check ss->dynsym twice
Date:   Fri, 20 Jan 2023 14:34:52 +0200
Message-Id: <20230120123456.12449-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ss->dynsym is checked to be not NULL twice. Remove the first check
because, in fact, there can be a plt with no dynsym, which is something
that will be dealt with later.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 990a2c6037bb..87b82507c205 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -386,9 +386,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	Elf *elf;
 	int nr = 0, symidx, err = -1;
 
-	if (!ss->dynsym)
-		return 0;
-
 	elf = ss->elf;
 	ehdr = ss->ehdr;
 
-- 
2.34.1

