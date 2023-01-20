Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59AC6754AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjATMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjATMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:36:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31061BF8BF;
        Fri, 20 Jan 2023 04:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218145; x=1705754145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+4JYvfJ/BZArt9A+5Y2h+61dVJ0kg1blPxurYa6kQaY=;
  b=OJU4Ygzq7YJHjJqskpX2HyqlMZofw8IMs7KGILuC/QzzW+PZCTe7lj9V
   iOHvDtlck2oX6O5nsyhY36fsqUg5YH7bHv4atn+6l7+racO3u66YXUbVs
   seDTCJXEFnGAlLSjjSfTXebnyo5bs7tmipSCPbGYiD+Gdka8faqMDVYEE
   WFfTU26zjZ5SGiqzGUqAnDjUKsVbna6ynTwu3IbkWtYe2z9I9GdAJ7YDm
   3PvPMkR/5NKA7mbV1JB+wcbuIPFStmcef+Hg935kEf926dkdUyFsi/7X8
   q+9U6L0UCQMgAg0qbFA9ktG654iuF4/wFc7E4q00JSZbwVr9wNC4R5lRj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935298"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935298"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847457"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847457"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 09/10] perf symbols: Combine handling for SHT_RELA and SHT_REL
Date:   Fri, 20 Jan 2023 14:34:55 +0200
Message-Id: <20230120123456.12449-10-adrian.hunter@intel.com>
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

SHT_REL and SHT_RELA are handled the same way. Simplify by combining the
handling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 75 +++++++++++++-----------------------
 1 file changed, 27 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6e4a22acefba..e274f646ac32 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -323,6 +323,23 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 	return demangled;
 }
 
+struct rel_info {
+	bool		is_rela;
+	Elf_Data	*reldata;
+	GElf_Rela	rela;
+	GElf_Rel	rel;
+};
+
+static u32 get_rel_symidx(struct rel_info *ri, u32 idx)
+{
+	if (ri->is_rela) {
+		gelf_getrela(ri->reldata, idx, &ri->rela);
+		return GELF_R_SYM(ri->rela.r_info);
+	}
+	gelf_getrel(ri->reldata, idx, &ri->rel);
+	return GELF_R_SYM(ri->rel.r_info);
+}
+
 static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 			  u64 *plt_header_size, u64 *plt_entry_size)
 {
@@ -353,16 +370,6 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 	}
 }
 
-#define elf_section__for_each_rel(reldata, pos, pos_mem, idx, nr_entries) \
-	for (idx = 0, pos = gelf_getrel(reldata, 0, &pos_mem); \
-	     idx < nr_entries; \
-	     ++idx, pos = gelf_getrel(reldata, idx, &pos_mem))
-
-#define elf_section__for_each_rela(reldata, pos, pos_mem, idx, nr_entries) \
-	for (idx = 0, pos = gelf_getrela(reldata, 0, &pos_mem); \
-	     idx < nr_entries; \
-	     ++idx, pos = gelf_getrela(reldata, idx, &pos_mem))
-
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
@@ -378,13 +385,14 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	GElf_Shdr shdr_plt;
 	struct symbol *f;
 	GElf_Shdr shdr_rel_plt, shdr_dynsym;
-	Elf_Data *reldata, *syms, *symstrs;
+	Elf_Data *syms, *symstrs;
 	Elf_Scn *scn_plt_rel, *scn_symstrs, *scn_dynsym;
 	size_t dynsym_idx;
 	GElf_Ehdr ehdr;
 	char sympltname[1024];
 	Elf *elf;
-	int nr = 0, symidx, err = -1;
+	int nr = 0, err = -1;
+	struct rel_info ri = { .is_rela = false };
 
 	elf = ss->elf;
 	ehdr = ss->ehdr;
@@ -433,8 +441,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	 * Fetch the relocation section to find the idxes to the GOT
 	 * and the symbols in the .dynsym they refer to.
 	 */
-	reldata = elf_getdata(scn_plt_rel, NULL);
-	if (reldata == NULL)
+	ri.reldata = elf_getdata(scn_plt_rel, NULL);
+	if (!ri.reldata)
 		goto out_elf_end;
 
 	syms = elf_getdata(scn_dynsym, NULL);
@@ -456,44 +464,15 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	plt_offset = shdr_plt.sh_offset;
 	plt_offset += plt_header_size;
 
-	if (shdr_rel_plt.sh_type == SHT_RELA) {
-		GElf_Rela pos_mem, *pos;
+	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
-		elf_section__for_each_rela(reldata, pos, pos_mem, idx,
-					   nr_rel_entries) {
+	if (shdr_rel_plt.sh_type == SHT_RELA ||
+	    shdr_rel_plt.sh_type == SHT_REL) {
+		for (idx = 0; idx < nr_rel_entries; idx++) {
 			const char *elf_name = NULL;
 			char *demangled = NULL;
-			symidx = GELF_R_SYM(pos->r_info);
-			gelf_getsym(syms, symidx, &sym);
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
 
-			f = symbol__new(plt_offset, plt_entry_size,
-					STB_GLOBAL, STT_FUNC, sympltname);
-			if (!f)
-				goto out_elf_end;
-
-			plt_offset += plt_entry_size;
-			symbols__insert(&dso->symbols, f);
-			++nr;
-		}
-	} else if (shdr_rel_plt.sh_type == SHT_REL) {
-		GElf_Rel pos_mem, *pos;
-		elf_section__for_each_rel(reldata, pos, pos_mem, idx,
-					  nr_rel_entries) {
-			const char *elf_name = NULL;
-			char *demangled = NULL;
-			symidx = GELF_R_SYM(pos->r_info);
-			gelf_getsym(syms, symidx, &sym);
+			gelf_getsym(syms, get_rel_symidx(&ri, idx), &sym);
 
 			elf_name = elf_sym__name(&sym, symstrs);
 			demangled = demangle_sym(dso, 0, elf_name);
-- 
2.34.1

