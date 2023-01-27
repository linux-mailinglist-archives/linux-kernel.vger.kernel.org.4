Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465E67EBE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjA0RDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjA0RDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF77FA35;
        Fri, 27 Jan 2023 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838961; x=1706374961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=djN+DaiLKdmHNtBi7i7A/82f34FiMzl4e3xwGKBci1s=;
  b=Jt20okou5d6RmZ/HOKZqyVoyd1JNopMXDSmFZfGqcSFPgpcjSaNmjb/l
   F7IhWjU5jaVNScsPBcfjjJ/b6YLU6/EAwJp179k7iLsIMY/wWhXXQU6Jk
   sKgcLYasDOhGs/Hike82mt8RCEJ3UpPoLfXemJFe10YUfar8T9qcjJKD1
   9UKrnkIEW/B/lHLJZKHT1qcQLD79sph9b/FfaKyXmp5RVwHx3/+GbK9xS
   IAVLmzu+IcZfkgAcIyI7IWqUwv04bQuTWTBFUfFlDgUA1TotS6Z/FluiQ
   KdVhs5Dd6IlW4WZpt/JqES4f1XmjYOIir35Ii1uwQqTnij48IDmp5aCMf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754123"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754123"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739180"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739180"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:37 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/9] perf symbols: Add support for x86 .plt.sec
Date:   Fri, 27 Jan 2023 19:02:15 +0200
Message-Id: <20230127170222.9895-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127170222.9895-1-adrian.hunter@intel.com>
References: <20230127170222.9895-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URI_NOVOWEL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section .plt.sec was originally added for MPX and was first called
.plt.bnd. While MPX has been deprecated, .plt.sec is now also used for IBT.
On x86_64, IBT seems to be enabled by default, but can be switched off
using gcc option -fcf-protection=none. On 32-bit, option -z ibt will
enable IBT.

With .plt.sec, calls are made into .plt.sec instead of .plt, so it
makes more sense to put the symbols there instead of .plt. A notable
difference is that .plt.sec does not have a header entry.

For x86, when synthesizing symbols for plt, use offset and entry size of
.plt.sec instead of .plt when there is a .plt.sec section.

Example on Ubuntu 22.04 gcc 11.3:

  Before:

    $ cat tstpltlib.c
    void fn1(void) {}
    void fn2(void) {}
    void fn3(void) {}
    void fn4(void) {}
    $ cat tstplt.c
    void fn1(void);
    void fn2(void);
    void fn3(void);
    void fn4(void);

    int main()
    {
            fn4();
            fn1();
            fn2();
            fn3();
            return 0;
    }
    $ gcc --version
    gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
    Copyright (C) 2021 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    $ gcc -Wall -Wextra -shared -o libtstpltlib.so tstpltlib.c
    $ gcc -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)
    $ readelf -SW tstplt | grep 'plt\|Name'
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [11] .rela.plt         RELA            0000000000000698 000698 000060 18  AI  6  24  8
      [13] .plt              PROGBITS        0000000000001020 001020 000050 10  AX  0   0 16
      [14] .plt.got          PROGBITS        0000000000001070 001070 000010 10  AX  0   0 16
      [15] .plt.sec          PROGBITS        0000000000001080 001080 000040 10  AX  0   0 16
    $ perf record -e intel_pt//u --filter 'filter main @ ./tstplt' ./tstplt
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.015 MB perf.data ]
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    38970.522546686:   tr strt                               0 [unknown] =>     55fc222a81a9 main+0x0
    38970.522546686:   tr end  call               55fc222a81b1 main+0x8 =>     55fc222a80a0 [unknown]
    38970.522546687:   tr strt                               0 [unknown] =>     55fc222a81b6 main+0xd
    38970.522546687:   tr end  call               55fc222a81b6 main+0xd =>     55fc222a8080 [unknown]
    38970.522546688:   tr strt                               0 [unknown] =>     55fc222a81bb main+0x12
    38970.522546688:   tr end  call               55fc222a81bb main+0x12 =>     55fc222a80b0 [unknown]
    38970.522546688:   tr strt                               0 [unknown] =>     55fc222a81c0 main+0x17
    38970.522546688:   tr end  call               55fc222a81c0 main+0x17 =>     55fc222a8090 [unknown]
    38970.522546689:   tr strt                               0 [unknown] =>     55fc222a81c5 main+0x1c
    38970.522546894:   tr end  return             55fc222a81cb main+0x22 =>     7f3a4dc29d90 __libc_start_call_main+0x80

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    38970.522546686:   tr strt                               0 [unknown] =>     55fc222a81a9 main+0x0
    38970.522546686:   tr end  call               55fc222a81b1 main+0x8 =>     55fc222a80a0 fn4@plt+0x0
    38970.522546687:   tr strt                               0 [unknown] =>     55fc222a81b6 main+0xd
    38970.522546687:   tr end  call               55fc222a81b6 main+0xd =>     55fc222a8080 fn1@plt+0x0
    38970.522546688:   tr strt                               0 [unknown] =>     55fc222a81bb main+0x12
    38970.522546688:   tr end  call               55fc222a81bb main+0x12 =>     55fc222a80b0 fn2@plt+0x0
    38970.522546688:   tr strt                               0 [unknown] =>     55fc222a81c0 main+0x17
    38970.522546688:   tr end  call               55fc222a81c0 main+0x17 =>     55fc222a8090 fn3@plt+0x0
    38970.522546689:   tr strt                               0 [unknown] =>     55fc222a81c5 main+0x1c
    38970.522546894:   tr end  return             55fc222a81cb main+0x22 =>     7f3a4dc29d90 __libc_start_call_main+0x80

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9328c162d68f..bb1b5cb3ff12 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -379,6 +379,11 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 	return false;
 }
 
+static bool machine_is_x86(GElf_Half e_machine)
+{
+	return e_machine == EM_386 || e_machine == EM_X86_64;
+}
+
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
@@ -391,8 +396,8 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	uint32_t nr_rel_entries, idx;
 	GElf_Sym sym;
 	u64 plt_offset, plt_header_size, plt_entry_size;
-	GElf_Shdr shdr_plt;
-	struct symbol *f;
+	GElf_Shdr shdr_plt, plt_sec_shdr;
+	struct symbol *f, *plt_sym;
 	GElf_Shdr shdr_rel_plt, shdr_dynsym;
 	Elf_Data *syms, *symstrs;
 	Elf_Scn *scn_plt_rel, *scn_symstrs, *scn_dynsym;
@@ -422,10 +427,23 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		return 0;
 
 	/* Add a symbol for .plt header */
-	f = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
-	if (!f)
+	plt_sym = symbol__new(shdr_plt.sh_offset, plt_header_size, STB_GLOBAL, STT_FUNC, ".plt");
+	if (!plt_sym)
 		goto out_elf_end;
-	symbols__insert(&dso->symbols, f);
+	symbols__insert(&dso->symbols, plt_sym);
+
+	/* Only x86 has .plt.sec */
+	if (machine_is_x86(ehdr.e_machine) &&
+	    elf_section_by_name(elf, &ehdr, &plt_sec_shdr, ".plt.sec", NULL)) {
+		if (!get_plt_sizes(dso, &ehdr, &plt_sec_shdr, &plt_header_size, &plt_entry_size))
+			return 0;
+		/* Extend .plt symbol to entire .plt */
+		plt_sym->end = plt_sym->start + shdr_plt.sh_size;
+		/* Use .plt.sec offset */
+		plt_offset = plt_sec_shdr.sh_offset;
+	} else {
+		plt_offset = shdr_plt.sh_offset + plt_header_size;
+	}
 
 	scn_dynsym = ss->dynsym;
 	shdr_dynsym = ss->dynshdr;
@@ -474,8 +492,6 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		goto out_elf_end;
 
 	nr_rel_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
-	plt_offset = shdr_plt.sh_offset;
-	plt_offset += plt_header_size;
 
 	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
-- 
2.34.1

