Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2049675498
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjATMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjATMfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057FBC8B9;
        Fri, 20 Jan 2023 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218119; x=1705754119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAcMYB+GjPlCo4U+0MPqIgbgUDFTYLliCdjAF9kowCQ=;
  b=OOyQsNNu/VS+Yi5cftaFnpLGNsHcxAK3l0QnzYLrBEx94dveAsGqlm7A
   mALLQT4HpRz7rUWRRude/tf564MhUUPFk2DX+dYiN0SmlWrp0y/3T+BdY
   6wgb82z3HD78hsSCguqUv2+OewGk+dcHmThm3jIGsKWiKG+sF23i+r/He
   Y/1KrWNyEUJc7z6LesqjrDJFAGiKH1UozO/TQTfMPLs4OAkr0u3VPSxHv
   YiRW1/2fkHVm2l+CRB8r6rHEPbpMbzwgrh18E/UOUX/CrpGCZxRAwNqm9
   8WZEJbxBu+cK9hGcqQlF6r05x7LUqjCR9UsIppuCUEu0GiTY5kr0o6xK7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935170"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847420"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847420"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 02/10] perf symbols: Factor out get_plt_sizes()
Date:   Fri, 20 Jan 2023 14:34:48 +0200
Message-Id: <20230120123456.12449-3-adrian.hunter@intel.com>
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

Factor out get_plt_sizes() to make the code more readable and further
changes to dso__synthesize_plt_symbols() easier to follow.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 54 +++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 96767d1b3f1c..4605680a22a3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -323,6 +323,33 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	return demangled;
 }
 
+static void get_plt_sizes(GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
+			  u64 *plt_header_size, u64 *plt_entry_size)
+{
+	switch (ehdr->e_machine) {
+	case EM_ARM:
+		*plt_header_size = 20;
+		*plt_entry_size = 12;
+		return;
+	case EM_AARCH64:
+		*plt_header_size = 32;
+		*plt_entry_size = 16;
+		return;
+	case EM_SPARC:
+		*plt_header_size = 48;
+		*plt_entry_size = 12;
+		return;
+	case EM_SPARCV9:
+		*plt_header_size = 128;
+		*plt_entry_size = 32;
+		return;
+	default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
+		*plt_header_size = shdr_plt->sh_entsize;
+		*plt_entry_size = shdr_plt->sh_entsize;
+		return;
+	}
+}
+
 #define elf_section__for_each_rel(reldata, pos, pos_mem, idx, nr_entries) \
 	for (idx = 0, pos = gelf_getrel(reldata, 0, &pos_mem); \
 	     idx < nr_entries; \
@@ -411,32 +438,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	nr_rel_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
 	plt_offset = shdr_plt.sh_offset;
-	switch (ehdr.e_machine) {
-		case EM_ARM:
-			plt_header_size = 20;
-			plt_entry_size = 12;
-			break;
-
-		case EM_AARCH64:
-			plt_header_size = 32;
-			plt_entry_size = 16;
-			break;
-
-		case EM_SPARC:
-			plt_header_size = 48;
-			plt_entry_size = 12;
-			break;
-
-		case EM_SPARCV9:
-			plt_header_size = 128;
-			plt_entry_size = 32;
-			break;
-
-		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
-			plt_header_size = shdr_plt.sh_entsize;
-			plt_entry_size = shdr_plt.sh_entsize;
-			break;
-	}
+	get_plt_sizes(&ehdr, &shdr_plt, &plt_header_size, &plt_entry_size);
 	plt_offset += plt_header_size;
 
 	if (shdr_rel_plt.sh_type == SHT_RELA) {
-- 
2.34.1

