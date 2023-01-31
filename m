Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1E6682D95
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjAaNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjAaNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66482CC60;
        Tue, 31 Jan 2023 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171015; x=1706707015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3NgJAtWb7jXyeV9uKKrkT8nXL2hEwhW5ncNONVpuSY=;
  b=WNKtOIUCtc2VlDs+m4l43nzpq9bWZ6A+VXf/D89m5UVnCzTBU7YyNw3e
   0fBB0cOX8jLg/8jJ7u1JKvwQwvuy5qfnu24p9cIzNZsVLwqPe8ir+ruy8
   GX8kJS5T2nutgjFiJYFZ+1ydBUU2itKQUrA10zU8qOJUChjQnW6d5VRl8
   jp1BAlkXg3Upg3tGoF4QKDzwFYOl3i00znJU52BkqoHhV6UgsI42vC/W/
   qk3887ZicYX/hrRcsI5f1gVBVlfU/R4GlcFzOYdD+9ZL8zize9q8860xg
   Kn6W83pifb5EP/FoDLmAsP8T+CuI/6u49KwewcSIX7UlgE1nRvoq8aRD5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534199"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534199"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864849"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864849"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:52 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 7/9] perf symbols: Allow for static executables with .plt
Date:   Tue, 31 Jan 2023 15:16:23 +0200
Message-Id: <20230131131625.6964-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131131625.6964-1-adrian.hunter@intel.com>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
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

