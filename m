Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B567EBED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjA0RD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjA0RDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DFE80147;
        Fri, 27 Jan 2023 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838996; x=1706374996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3NgJAtWb7jXyeV9uKKrkT8nXL2hEwhW5ncNONVpuSY=;
  b=TjVij/8tVuf78Wh+Uv0AyGR61gQAn4d/KoE/tMfhKKi4KoXNrnrNudw6
   pzSWM4RgoITNn7SJpoBKc2OQK9gjKtP2D7T3zCNA05vu8Z8WFx2SyXr5H
   pCczra5eDlPpI/jcEz5rxRoO6JfOC9nyACrUEC0kbg5oNjQimMhrwzQx9
   S4upOh/INk5sg2q6pV5+Gc9TIdOvpX1MrABFZwS9V2wak7usREp4HzgSw
   FcI8mfPRljA7k5iC5QqvW7oxOylKD1T59oo6fdvb9V4FZA9e/ZZxMyqIV
   marhCTG55ILwNOCAv8WW8x4nhRCZ8PUuG2OuLyzsKLISOm7CorsxbO0+d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754196"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739253"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739253"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/9] perf symbols: Allow for static executables with .plt
Date:   Fri, 27 Jan 2023 19:02:20 +0200
Message-Id: <20230127170222.9895-8-adrian.hunter@intel.com>
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

A statically linked executable can have a .plt due to IFUNCs, in which
case .symtab is used not .dynsym. Check the section header link to see
if that is the case, and then use symtab instead.

Example:

  Before:

    $ cat tstifunc.c
    #include <stdio.h>

    void thing1(void)
    {
            printf("thing1\n");
    }

    void thing2(void)
    {
            printf("thing2\n");
    }

    typedef void (*thing_fn_t)(void);

    thing_fn_t thing_ifunc(void)
    {
            int x;

            if (x & 1)
                    return thing2;
            return thing1;
    }

    void thing(void) __attribute__ ((ifunc ("thing_ifunc")));

    int main()
    {
            thing();
            return 0;
    }
    $ gcc --version
    gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
    Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    $ gcc -static -Wall -Wextra -Wno-uninitialized -o tstifuncstatic tstifunc.c
    $ readelf -SW tstifuncstatic | grep 'Name\|plt\|dyn'
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [ 4] .rela.plt         RELA            00000000004002e8 0002e8 000258 18  AI 29  20  8
      [ 6] .plt              PROGBITS        0000000000401020 001020 000190 00  AX  0   0 16
      [20] .got.plt          PROGBITS        00000000004c5000 0c4000 0000e0 08  WA  0   0  8
    $ perf record -e intel_pt//u --filter 'filter main @ ./tstifuncstatic' ./tstifuncstatic
    thing1
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.008 MB perf.data ]
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    15786.690189535:   tr strt                               0 [unknown] =>           4017cd main+0x0
    15786.690189535:   tr end  call                     4017d5 main+0x8 =>           401170 [unknown]
    15786.690197660:   tr strt                               0 [unknown] =>           4017da main+0xd
    15786.690197660:   tr end  return                   4017e0 main+0x13 =>           401c1a __libc_start_call_main+0x6a

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    15786.690189535:   tr strt                               0 [unknown] =>           4017cd main+0x0
    15786.690189535:   tr end  call                     4017d5 main+0x8 =>           401170 thing_ifunc@plt+0x0
    15786.690197660:   tr strt                               0 [unknown] =>           4017da main+0xd
    15786.690197660:   tr end  return                   4017e0 main+0x13 =>           401c1a __libc_start_call_main+0x6a

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 30 ++++++++++++++++++++----------
 tools/perf/util/symsrc.h     |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8f7802097c72..9e265a726418 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -483,7 +483,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	GElf_Shdr shdr_rel_plt, shdr_dynsym;
 	Elf_Data *syms, *symstrs;
 	Elf_Scn *scn_plt_rel, *scn_symstrs, *scn_dynsym;
-	size_t dynsym_idx;
 	GElf_Ehdr ehdr;
 	char sympltname[1024];
 	Elf *elf;
@@ -530,13 +529,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		lazy_plt = true;
 	}
 
-	scn_dynsym = ss->dynsym;
-	shdr_dynsym = ss->dynshdr;
-	dynsym_idx = ss->dynsym_idx;
-
-	if (scn_dynsym == NULL)
-		return 0;
-
 	scn_plt_rel = elf_section_by_name(elf, &ehdr, &shdr_rel_plt,
 					  ".rela.plt", NULL);
 	if (scn_plt_rel == NULL) {
@@ -550,8 +542,25 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	    shdr_rel_plt.sh_type != SHT_REL)
 		return 0;
 
-	if (shdr_rel_plt.sh_link != dynsym_idx)
+	if (!shdr_rel_plt.sh_link)
+		return 0;
+
+	if (shdr_rel_plt.sh_link == ss->dynsym_idx) {
+		scn_dynsym = ss->dynsym;
+		shdr_dynsym = ss->dynshdr;
+	} else if (shdr_rel_plt.sh_link == ss->symtab_idx) {
+		/*
+		 * A static executable can have a .plt due to IFUNCs, in which
+		 * case .symtab is used not .dynsym.
+		 */
+		scn_dynsym = ss->symtab;
+		shdr_dynsym = ss->symshdr;
+	} else {
 		goto out_elf_end;
+	}
+
+	if (!scn_dynsym)
+		return 0;
 
 	/*
 	 * Fetch the relocation section to find the idxes to the GOT
@@ -1077,8 +1086,9 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 
 	ss->is_64_bit = (gelf_getclass(elf) == ELFCLASS64);
 
+	ss->symtab_idx = 0;
 	ss->symtab = elf_section_by_name(elf, &ehdr, &ss->symshdr, ".symtab",
-			NULL);
+			&ss->symtab_idx);
 	if (ss->symshdr.sh_type != SHT_SYMTAB)
 		ss->symtab = NULL;
 
diff --git a/tools/perf/util/symsrc.h b/tools/perf/util/symsrc.h
index 2665b4bde751..edf82028c9e6 100644
--- a/tools/perf/util/symsrc.h
+++ b/tools/perf/util/symsrc.h
@@ -26,6 +26,7 @@ struct symsrc {
 	GElf_Shdr	     opdshdr;
 
 	Elf_Scn		     *symtab;
+	size_t		     symtab_idx;
 	GElf_Shdr	     symshdr;
 
 	Elf_Scn		     *dynsym;
-- 
2.34.1

