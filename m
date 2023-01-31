Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17745682D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAaNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAaNQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24691AF;
        Tue, 31 Jan 2023 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171005; x=1706707005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSYyxIYpIcGvKGW9ILNeoVixG2YK5UrzbYtuW8oYj7s=;
  b=HNE4221oBCciKgKpAxUxvevqE9wPdnVdKzaThSZwUduXSVMgBd+lTc6R
   va+ozpL/s58Q7hRP2dHhgGwBmZx1zGu8kt41Sb1vrdPP7qbkG429TU0jC
   v61LadzRlN+97FTTc/VE8NFHhcAJpnCdwRonoLHi3lFr59VIZ0ftBsTJb
   +KrXYKVyG6N8I1OM1nxX45Dy52B4APQEesSueyuw9ur8CWVEJnCIKVfXr
   P+tZivxTaKYZcuWte/EmDTMwkSWnItFzykeIktKVYfbm/Xoiwm7uDgtfZ
   j1l4kooHANTvm+WfWZ5AsS2d3Vhm0MWMMgZ6YDBvcM4eanrm77tLHGFe6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534157"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534157"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864807"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864807"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:43 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 3/9] perf symbols: Sort plt relocations for x86
Date:   Tue, 31 Jan 2023 15:16:19 +0200
Message-Id: <20230131131625.6964-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131131625.6964-1-adrian.hunter@intel.com>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URI_NOVOWEL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86, with the addition of IFUNCs, relocation information becomes
disordered with respect to plt. Correct that by sorting the relocations by
offset.

Example:

  Before:

    $ cat tstpltlib.c
    void fn1(void) {}
    void fn2(void) {}
    void fn3(void) {}
    void fn4(void) {}
    $ cat tstpltifunc.c
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

    void fn1(void);
    void fn2(void);
    void fn3(void);
    void fn4(void);

    int main()
    {
            fn4();
            fn1();
            thing();
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
    $ gcc -Wall -Wextra -Wno-uninitialized -o tstpltifunc tstpltifunc.c -L . -ltstpltlib -Wl,-rpath="$(pwd)"
    $ readelf -rW tstpltifunc | grep -A99 plt
    Relocation section '.rela.plt' at offset 0x738 contains 8 entries:
        Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
    0000000000003f98  0000000300000007 R_X86_64_JUMP_SLOT     0000000000000000 puts@GLIBC_2.2.5 + 0
    0000000000003fa8  0000000400000007 R_X86_64_JUMP_SLOT     0000000000000000 __stack_chk_fail@GLIBC_2.4 + 0
    0000000000003fb0  0000000500000007 R_X86_64_JUMP_SLOT     0000000000000000 fn1 + 0
    0000000000003fb8  0000000600000007 R_X86_64_JUMP_SLOT     0000000000000000 fn3 + 0
    0000000000003fc0  0000000800000007 R_X86_64_JUMP_SLOT     0000000000000000 fn4 + 0
    0000000000003fc8  0000000900000007 R_X86_64_JUMP_SLOT     0000000000000000 fn2 + 0
    0000000000003fd0  0000000b00000007 R_X86_64_JUMP_SLOT     0000000000000000 getrandom@GLIBC_2.25 + 0
    0000000000003fa0  0000000000000025 R_X86_64_IRELATIVE                        125d
    $ perf record -e intel_pt//u --filter 'filter main @ ./tstpltifunc' ./tstpltifunc
    thing2
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.029 MB perf.data ]
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    20417.302513948:   tr strt                               0 [unknown] =>     5629a74892be main+0x0
    20417.302513948:   tr end  call               5629a74892c6 main+0x8 =>     5629a7489110 fn2@plt+0x0
    20417.302513949:   tr strt                               0 [unknown] =>     5629a74892cb main+0xd
    20417.302513949:   tr end  call               5629a74892cb main+0xd =>     5629a74890f0 fn3@plt+0x0
    20417.302513950:   tr strt                               0 [unknown] =>     5629a74892d0 main+0x12
    20417.302513950:   tr end  call               5629a74892d0 main+0x12 =>     5629a74890d0 __stack_chk_fail@plt+0x0
    20417.302528114:   tr strt                               0 [unknown] =>     5629a74892d5 main+0x17
    20417.302528114:   tr end  call               5629a74892d5 main+0x17 =>     5629a7489120 getrandom@plt+0x0
    20417.302528115:   tr strt                               0 [unknown] =>     5629a74892da main+0x1c
    20417.302528115:   tr end  call               5629a74892da main+0x1c =>     5629a7489100 fn4@plt+0x0
    20417.302528115:   tr strt                               0 [unknown] =>     5629a74892df main+0x21
    20417.302528115:   tr end  return             5629a74892e5 main+0x27 =>     7ff14da29d90 __libc_start_call_main+0x80

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    20417.302513948:   tr strt                               0 [unknown] =>     5629a74892be main+0x0
    20417.302513948:   tr end  call               5629a74892c6 main+0x8 =>     5629a7489110 fn4@plt+0x0
    20417.302513949:   tr strt                               0 [unknown] =>     5629a74892cb main+0xd
    20417.302513949:   tr end  call               5629a74892cb main+0xd =>     5629a74890f0 fn1@plt+0x0
    20417.302513950:   tr strt                               0 [unknown] =>     5629a74892d0 main+0x12
    20417.302513950:   tr end  call               5629a74892d0 main+0x12 =>     5629a74890d0 offset_0x10d0@plt+0x0
    20417.302528114:   tr strt                               0 [unknown] =>     5629a74892d5 main+0x17
    20417.302528114:   tr end  call               5629a74892d5 main+0x17 =>     5629a7489120 fn2@plt+0x0
    20417.302528115:   tr strt                               0 [unknown] =>     5629a74892da main+0x1c
    20417.302528115:   tr end  call               5629a74892da main+0x1c =>     5629a7489100 fn3@plt+0x0
    20417.302528115:   tr strt                               0 [unknown] =>     5629a74892df main+0x21
    20417.302528115:   tr end  return             5629a74892e5 main+0x27 =>     7ff14da29d90 __libc_start_call_main+0x80

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index bb1b5cb3ff12..07cfcf8f40e3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -324,6 +324,8 @@ static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 }
 
 struct rel_info {
+	u32		nr_entries;
+	u32		*sorted;
 	bool		is_rela;
 	Elf_Data	*reldata;
 	GElf_Rela	rela;
@@ -332,6 +334,7 @@ struct rel_info {
 
 static u32 get_rel_symidx(struct rel_info *ri, u32 idx)
 {
+	idx = ri->sorted ? ri->sorted[idx] : idx;
 	if (ri->is_rela) {
 		gelf_getrela(ri->reldata, idx, &ri->rela);
 		return GELF_R_SYM(ri->rela.r_info);
@@ -340,6 +343,49 @@ static u32 get_rel_symidx(struct rel_info *ri, u32 idx)
 	return GELF_R_SYM(ri->rel.r_info);
 }
 
+static u64 get_rel_offset(struct rel_info *ri, u32 x)
+{
+	if (ri->is_rela) {
+		GElf_Rela rela;
+
+		gelf_getrela(ri->reldata, x, &rela);
+		return rela.r_offset;
+	} else {
+		GElf_Rel rel;
+
+		gelf_getrel(ri->reldata, x, &rel);
+		return rel.r_offset;
+	}
+}
+
+static int rel_cmp(const void *a, const void *b, void *r)
+{
+	struct rel_info *ri = r;
+	u64 a_offset = get_rel_offset(ri, *(const u32 *)a);
+	u64 b_offset = get_rel_offset(ri, *(const u32 *)b);
+
+	return a_offset < b_offset ? -1 : (a_offset > b_offset ? 1 : 0);
+}
+
+static int sort_rel(struct rel_info *ri)
+{
+	size_t sz = sizeof(ri->sorted[0]);
+	u32 i;
+
+	ri->sorted = calloc(ri->nr_entries, sz);
+	if (!ri->sorted)
+		return -1;
+	for (i = 0; i < ri->nr_entries; i++)
+		ri->sorted[i] = i;
+	qsort_r(ri->sorted, ri->nr_entries, sz, rel_cmp, ri);
+	return 0;
+}
+
+static void exit_rel(struct rel_info *ri)
+{
+	free(ri->sorted);
+}
+
 static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 			  u64 *plt_header_size, u64 *plt_entry_size)
 {
@@ -393,7 +439,7 @@ static bool machine_is_x86(GElf_Half e_machine)
  */
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 {
-	uint32_t nr_rel_entries, idx;
+	uint32_t idx;
 	GElf_Sym sym;
 	u64 plt_offset, plt_header_size, plt_entry_size;
 	GElf_Shdr shdr_plt, plt_sec_shdr;
@@ -491,11 +537,18 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	if (symstrs->d_size == 0)
 		goto out_elf_end;
 
-	nr_rel_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
+	ri.nr_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
 
 	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
-	for (idx = 0; idx < nr_rel_entries; idx++) {
+	/*
+	 * x86 doesn't insert IFUNC relocations in .plt order, so sort to get
+	 * back in order.
+	 */
+	if (machine_is_x86(ehdr.e_machine) && sort_rel(&ri))
+		goto out_elf_end;
+
+	for (idx = 0; idx < ri.nr_entries; idx++) {
 		const char *elf_name = NULL;
 		char *demangled = NULL;
 
@@ -523,6 +576,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	err = 0;
 out_elf_end:
+	exit_rel(&ri);
 	if (err == 0)
 		return nr;
 	pr_debug("%s: problems reading %s PLT info.\n",
-- 
2.34.1

