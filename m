Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE7675499
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjATMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjATMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:25 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1ECBC89B;
        Fri, 20 Jan 2023 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218121; x=1705754121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqHivyH65I+zqpnOfFxb+qPLJLaHYIND6bguoxV+hQg=;
  b=lhDrKApw185+HQTFm8vX/tWsbEQaC1oGaqnc3jOaUtnPt/CYJEgJ+QsE
   uaZWlDAt8CAxnZttKJ5j62s8afaLliUZaZcVenKd2IAEbbTnkAgqBcDnC
   6HT4s0D7FhUeX0UcIAaNiPIGjRjWWxRlf1bD5tg2b613U36mKV8xOVQaD
   xFFdkr6ZLMaz9dbk3WvyMdGlaPcnnmClPXcIWnG47cpMWBcljikIEKixN
   crXm+DY9MMKQuCCbUAJzrB/R+GAzqFhsUuyEbqqvkBOQTwKvNW/FXVwih
   /IRLGZVZeci35iHLmTpTq6cnzXvIMklL8eOFUQdLDfYtCBVHKmELURw7K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935186"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847425"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847425"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:18 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 03/10] perf symbols: Check plt_entry_size is not zero
Date:   Fri, 20 Jan 2023 14:34:49 +0200
Message-Id: <20230120123456.12449-4-adrian.hunter@intel.com>
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

The code expects non-zero plt_entry_size. Check it and add a debug
message to print if it is zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4605680a22a3..c6a4e6c73990 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -323,30 +323,33 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	return demangled;
 }
 
-static void get_plt_sizes(GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
+static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 			  u64 *plt_header_size, u64 *plt_entry_size)
 {
 	switch (ehdr->e_machine) {
 	case EM_ARM:
 		*plt_header_size = 20;
 		*plt_entry_size = 12;
-		return;
+		return true;
 	case EM_AARCH64:
 		*plt_header_size = 32;
 		*plt_entry_size = 16;
-		return;
+		return true;
 	case EM_SPARC:
 		*plt_header_size = 48;
 		*plt_entry_size = 12;
-		return;
+		return true;
 	case EM_SPARCV9:
 		*plt_header_size = 128;
 		*plt_entry_size = 32;
-		return;
+		return true;
 	default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 		*plt_header_size = shdr_plt->sh_entsize;
 		*plt_entry_size = shdr_plt->sh_entsize;
-		return;
+		if (*plt_entry_size)
+			return true;
+		pr_debug("Missing PLT entry size for %s\n", dso->long_name);
+		return false;
 	}
 }
 
@@ -438,7 +441,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	nr_rel_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
 	plt_offset = shdr_plt.sh_offset;
-	get_plt_sizes(&ehdr, &shdr_plt, &plt_header_size, &plt_entry_size);
+	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
+		return 0;
 	plt_offset += plt_header_size;
 
 	if (shdr_rel_plt.sh_type == SHT_RELA) {
-- 
2.34.1

