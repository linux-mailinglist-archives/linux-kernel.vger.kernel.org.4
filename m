Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29846754B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjATMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjATMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:36:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B164BC895;
        Fri, 20 Jan 2023 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218154; x=1705754154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usKQ9P+Ke/475dpAvzHSLqve+rQfd02M1v4DhbzDTsE=;
  b=YMWiOHr2oT+n4EWDUwhX/9KeSFE9aZCWIiS+TBci4MYorF03v1fd8Ycx
   GAFvJJD5RibI2H/5X58h1mFB5tHvSEev+3aRnSxwjiCJw6YBzgp7V7TbN
   fPvVp1OWM1J7oh+KaYEosWh7QBMLhWjb5O3GBp3i3Fqukwj8lm58CEumF
   zTMGgpHtmESF7OuO26nVQaliQs+hUqyc3hoqp0VRnENXUIAOMpTwVKmfu
   2B5+V4ThnyXQr7mWCEM9h7rJu4fOEH2BmouBgmSGdw0ZbajZSC4AXoR7V
   ivV8B4EEPpUPwMNcJf5DuwkBs9pXgILdsDEvmkqdQhNNcie3tPhYeOH9i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935315"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935315"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847463"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847463"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:36 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 10/10] perf symbols: Check SHT_RELA and SHT_REL type earlier
Date:   Fri, 20 Jan 2023 14:34:56 +0200
Message-Id: <20230120123456.12449-11-adrian.hunter@intel.com>
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

Make the code more readable by checking for SHT_RELA and SHT_REL type
earlier.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 54 ++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e274f646ac32..aa62735aea7b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -434,6 +434,10 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			return 0;
 	}
 
+	if (shdr_rel_plt.sh_type != SHT_RELA &&
+	    shdr_rel_plt.sh_type != SHT_REL)
+		return 0;
+
 	if (shdr_rel_plt.sh_link != dynsym_idx)
 		goto out_elf_end;
 
@@ -466,34 +470,30 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
-	if (shdr_rel_plt.sh_type == SHT_RELA ||
-	    shdr_rel_plt.sh_type == SHT_REL) {
-		for (idx = 0; idx < nr_rel_entries; idx++) {
-			const char *elf_name = NULL;
-			char *demangled = NULL;
-
-			gelf_getsym(syms, get_rel_symidx(&ri, idx), &sym);
-
-			elf_name = elf_sym__name(&sym, symstrs);
-			demangled = demangle_sym(dso, 0, elf_name);
-			if (demangled != NULL)
-				elf_name = demangled;
-			if (*elf_name)
-				snprintf(sympltname, sizeof(sympltname), "%s@plt", elf_name);
-			else
-				snprintf(sympltname, sizeof(sympltname),
-					 "offset_%#" PRIx64 "@plt", plt_offset);
-			free(demangled);
-
-			f = symbol__new(plt_offset, plt_entry_size,
-					STB_GLOBAL, STT_FUNC, sympltname);
-			if (!f)
-				goto out_elf_end;
+	for (idx = 0; idx < nr_rel_entries; idx++) {
+		const char *elf_name = NULL;
+		char *demangled = NULL;
 
-			plt_offset += plt_entry_size;
-			symbols__insert(&dso->symbols, f);
-			++nr;
-		}
+		gelf_getsym(syms, get_rel_symidx(&ri, idx), &sym);
+
+		elf_name = elf_sym__name(&sym, symstrs);
+		demangled = demangle_sym(dso, 0, elf_name);
+		if (demangled)
+			elf_name = demangled;
+		if (*elf_name)
+			snprintf(sympltname, sizeof(sympltname), "%s@plt", elf_name);
+		else
+			snprintf(sympltname, sizeof(sympltname),
+				 "offset_%#" PRIx64 "@plt", plt_offset);
+		free(demangled);
+
+		f = symbol__new(plt_offset, plt_entry_size, STB_GLOBAL, STT_FUNC, sympltname);
+		if (!f)
+			goto out_elf_end;
+
+		plt_offset += plt_entry_size;
+		symbols__insert(&dso->symbols, f);
+		++nr;
 	}
 
 	err = 0;
-- 
2.34.1

