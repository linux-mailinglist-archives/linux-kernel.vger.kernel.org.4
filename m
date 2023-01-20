Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04B67549A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjATMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjATMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336DEBC88A;
        Fri, 20 Jan 2023 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218124; x=1705754124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNQ8moBpynyS7kwekoi/lFg0Su2X2visRdfx5+bbhQc=;
  b=UjkGq5ENE3mNuNGOAA9xH4MGsf9TDKIRKo241TeLgm3vN5dOrRoOch/c
   1GkVpWnBe74zE6zjTorqXb7Pd7zYW6XjcfCiYYsdjKKe1mRO46ngIo05M
   otdF8jZsRrDxdD55DDPZQgKEDAjA5ryh4SjU4Icgc35pMJJnFSeVTb5Dt
   LIfvumoC5DTB/y7jbfe2fpgLnLTC+GJ+xv1rMgr6cQf6ZDL0TpM/gR1VW
   8Jdo4G+/8wC23LHAQSvwIdEkEVCctYiFy9w/WKIffMF/I04odkhJnk4hN
   YBnWtxSNRUsojTXNq6K2xL8bKt4IEgJWdrpJqoPaqybClwkROqF8maEDX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935204"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847434"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847434"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:21 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 04/10] perf symbols: Add dso__find_symbol_nocache()
Date:   Fri, 20 Jan 2023 14:34:50 +0200
Message-Id: <20230120123456.12449-5-adrian.hunter@intel.com>
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

Symbols should not be cached when there are more symbols still to add.
Add dso__find_symbol_nocache() to facilitate that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol.c | 5 +++++
 tools/perf/util/symbol.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..a024f06f75d8 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -556,6 +556,11 @@ struct symbol *dso__find_symbol(struct dso *dso, u64 addr)
 	return dso->last_find_result.symbol;
 }
 
+struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr)
+{
+	return symbols__find(&dso->symbols, addr);
+}
+
 struct symbol *dso__first_symbol(struct dso *dso)
 {
 	return symbols__first(&dso->symbols);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index f735108c4d4e..2fdeb22bd02f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -148,6 +148,7 @@ void dso__delete_symbol(struct dso *dso,
 			struct symbol *sym);
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
+struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
 struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
 
 struct symbol *symbol__next_by_name(struct symbol *sym);
-- 
2.34.1

