Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12E6754A5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjATMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjATMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:54 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE5BC883;
        Fri, 20 Jan 2023 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218132; x=1705754132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WY7A8kXmLodxsZZKsPIN5lstuixMq8OdTgkIL+AMf/o=;
  b=kh+4gDkOrkk+Rz0WY67KcFbHEjP7x253k/J9OZdBTnwG0rkuUAmJ6HB6
   Px3FkqIo1Qfua92JCpr31Fs9m5a3o3j+2P6tl6XLcz1gunfvqdOg/eghx
   pwLatkM2Ori+EJ5Ca2tCxZksfOgeddv+LJZ0Vw2jCs7vPbdAu88cTQwRH
   XEJqwpyCGuwVicSlJkU0GSHuWNrF5YCg29Y0Ag14Mc0oU7xv0qACpDBK6
   iRmCMX8krnHRh37YSK6V6vqBGtwJTXCuLfKb4c+hMT732ieM7hLvGckD1
   jpCQoUapvvtPKuk/IBxvRV8zRToDovhle34zqCXN8AWWiNujmqdjhXa+D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935260"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935260"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847446"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847446"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:29 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 07/10] perf symbols: Add symbol for .plt header
Date:   Fri, 20 Jan 2023 14:34:53 +0200
Message-Id: <20230120123456.12449-8-adrian.hunter@intel.com>
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

perf expands the _init symbol over .plt because there are no PLT symbols
at that point, but then dso__synthesize_plt_symbols() creates them.

Fix by truncating the previous symbol and inserting a symbol for .plt
header.

Example:

 Before:

   $ perf test --dso `which uname` -v Symbols
    74: Symbols                                                         :
   --- start ---
   test child forked, pid 191028
   Problems creating module maps, continuing anyway...
   Testing /usr/bin/uname
   Overlapping symbols:
    2000-25f0 g _init
    2040-2050 g free@plt
   test child finished with -1
   ---- end ----
   Symbols: FAILED!
   $ perf test --dso `which uname` -vv Symbols 2>/tmp/cmp1.txt

 After:

   $ perf test --dso `which uname` -v Symbols
    74: Symbols                                                         :
   --- start ---
   test child forked, pid 194291
   Testing /usr/bin/uname
   test child finished with 0
   ---- end ----
   Symbols: Ok
   $ perf test --dso `which uname` -vv Symbols 2>/tmp/cmp2.txt
   $ diff /tmp/cmp1.txt /tmp/cmp2.txt
   4,5c4
   < test child forked, pid 191031
   < Problems creating module maps, continuing anyway...
   ---
   > test child forked, pid 194296
   9c8,9
   <  2000-25f0 g _init
   ---
   >  2000-2030 g _init
   >  2030-2040 g .plt
   100,103c100
   < Overlapping symbols:
   <  2000-25f0 g _init
   <  2040-2050 g free@plt
   < test child finished with -1
   ---
   > test child finished with 0
   105c102
   < Symbols: FAILED!
   ---
   > Symbols: Ok
   $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 87b82507c205..a8b7c3860b2d 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -389,6 +389,27 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	elf = ss->elf;
 	ehdr = ss->ehdr;
 
+	if (!elf_section_by_name(elf, &ehdr, &shdr_plt, ".plt", NULL))
+		return 0;
+
+	/*
+	 * A symbol from a previous section (e.g. .init) can have been expanded
+	 * by symbols__fixup_end() to overlap .plt. Truncate it before adding
+	 * a symbol for .plt header.
+	 */
+	f = dso__find_symbol_nocache(dso, shdr_plt.sh_offset);
+	if (f && f->start < shdr_plt.sh_offset && f->end > shdr_plt.sh_offset)
+		f->end = shdr_plt.sh_offset;
+
+	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
+		return 0;
+
+	/* Add a symbol for .plt header */
+	f = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
+	if (!f)
+		goto out_elf_end;
+	symbols__insert(&dso->symbols, f);
+
 	scn_dynsym = ss->dynsym;
 	shdr_dynsym = ss->dynshdr;
 	dynsym_idx = ss->dynsym_idx;
@@ -408,9 +429,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	if (shdr_rel_plt.sh_link != dynsym_idx)
 		goto out_elf_end;
 
-	if (elf_section_by_name(elf, &ehdr, &shdr_plt, ".plt", NULL) == NULL)
-		goto out_elf_end;
-
 	/*
 	 * Fetch the relocation section to find the idxes to the GOT
 	 * and the symbols in the .dynsym they refer to.
@@ -436,8 +454,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	nr_rel_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
 	plt_offset = shdr_plt.sh_offset;
-	if (!get_plt_sizes(dso, &ehdr, &shdr_plt, &plt_header_size, &plt_entry_size))
-		return 0;
 	plt_offset += plt_header_size;
 
 	if (shdr_rel_plt.sh_type == SHT_RELA) {
-- 
2.34.1

