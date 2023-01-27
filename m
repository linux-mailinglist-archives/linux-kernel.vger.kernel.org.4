Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF72E67EBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjA0RD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjA0RDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7457328D2E;
        Fri, 27 Jan 2023 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838979; x=1706374979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PgoaMa5uG1on8jbmDVSgzzslCJYjltgwG8UjBjeDNrE=;
  b=bWepwiDh3CuushqqyzmcjzGFC8IUR+/g6fz6hZk+Lna/qWGc1+PQhlnA
   F3DOzpJgEEEcZ6lSvjszs3IIXS0MwD52Rrm+eGwTRA6bkuCb0mi1zfOVE
   4Yj0r9tr/8o7hll86Qw2XUznJOvUFbjmuCjQTBEFOzEspU2bnfupB03bM
   1EkW9wMaJAAKcn/zEFtAZRH5YJMEPDMZYyaMA66yoojhmAPmNb8dYLH86
   DYXX6198zVDmN69OsS+UkEHZMqhauNv6Dlw4hoPOL4aJio/5nutwNVznT
   ebSBltRSbU3m/L/hRm5GI/0xO02pEf6TnKCFtCLeEfJS8JDUi9icsiNlB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754151"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754151"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739218"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739218"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:41 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 4/9] perf symbols: Record whether a symbol is an alias for an IFUNC symbol
Date:   Fri, 27 Jan 2023 19:02:17 +0200
Message-Id: <20230127170222.9895-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127170222.9895-1-adrian.hunter@intel.com>
References: <20230127170222.9895-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To assist with synthesizing plt symbols for IFUNCs, record whether a
symbol is an alias of an IFUNC symbol.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol.c | 4 ++++
 tools/perf/util/symbol.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a024f06f75d8..d05727fcb30d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -201,10 +201,14 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 			continue;
 
 		if (choose_best_symbol(curr, next) == SYMBOL_A) {
+			if (next->type == STT_GNU_IFUNC)
+				curr->ifunc_alias = true;
 			rb_erase_cached(&next->rb_node, symbols);
 			symbol__delete(next);
 			goto again;
 		} else {
+			if (curr->type == STT_GNU_IFUNC)
+				next->ifunc_alias = true;
 			nd = rb_next(&curr->rb_node);
 			rb_erase_cached(&curr->rb_node, symbols);
 			symbol__delete(curr);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 2fdeb22bd02f..7558735543c2 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -64,6 +64,8 @@ struct symbol {
 	u8		inlined:1;
 	/** Has symbol__annotate2 been performed. */
 	u8		annotate2:1;
+	/** Symbol is an alias of an STT_GNU_IFUNC */
+	u8		ifunc_alias:1;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-- 
2.34.1

