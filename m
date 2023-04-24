Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2156EC5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDXF4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDXFzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:55:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7C49E4;
        Sun, 23 Apr 2023 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682315699; x=1713851699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxJxWo7sT3H6f3IRpTxjOsEbwQQ+lUcjOow4n1ItELU=;
  b=XPhRYumlYnFOB+QGvFIcaTsbWt/g/R8a7pahkgjxFnNsOiRgKxCXGRxU
   mgmZ11Pt5oOJkM+fsTYcfC4zz6ZAZBGjsmc/TzleH60Fg7l/fUAoiOCM3
   ZNV8hfNWOMiAe6GMLYBQnLCklhk74twrDk1UZIf6XCN3P/LCbmEsGGM7w
   J2uFZKD9ST3JvigUlbiNbM84HQ+UNclugRIOSqse6/X893Ty9ov+MbqfG
   jpKVdBlCP4tK5q/Ya7h2/drHcc171/wsTkQDt8wuCR1J4RxLWWTTOl7WQ
   O/D/bJg8eHG4htYxVCCmKMK5335Ncwzc5VFe3150GfoxKn0if6v2T9alA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325972506"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="325972506"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686669259"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="686669259"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.217])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:31 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 1/2] perf dso: Declare dso const as needed
Date:   Mon, 24 Apr 2023 08:51:06 +0300
Message-Id: <20230424055107.12105-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424055107.12105-1-adrian.hunter@intel.com>
References: <20230424055107.12105-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare dso const, so that functions can be called with const struct *dso.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/dso.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 0b7c7633b9f6..dfc4cf3de7a8 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -379,19 +379,19 @@ void dso__reset_find_symbol_cache(struct dso *dso);
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
-static inline bool dso__is_vmlinux(struct dso *dso)
+static inline bool dso__is_vmlinux(const struct dso *dso)
 {
 	return dso->binary_type == DSO_BINARY_TYPE__VMLINUX ||
 	       dso->binary_type == DSO_BINARY_TYPE__GUEST_VMLINUX;
 }
 
-static inline bool dso__is_kcore(struct dso *dso)
+static inline bool dso__is_kcore(const struct dso *dso)
 {
 	return dso->binary_type == DSO_BINARY_TYPE__KCORE ||
 	       dso->binary_type == DSO_BINARY_TYPE__GUEST_KCORE;
 }
 
-static inline bool dso__is_kallsyms(struct dso *dso)
+static inline bool dso__is_kallsyms(const struct dso *dso)
 {
 	return dso->kernel && dso->long_name[0] != '/';
 }
-- 
2.34.1

