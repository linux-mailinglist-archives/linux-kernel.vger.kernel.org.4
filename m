Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C267EBEF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjA0REJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjA0RD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93FB8497A;
        Fri, 27 Jan 2023 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674839006; x=1706375006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gSCQ96tg4l0FNHIgMJQtf3tGIwORYZgZx/efj/0fnbo=;
  b=ktZmv99/pwUgwWnQp/a6k+efdlRyhpS+qjN6A1U5VDZxBnSBAFnOdz1i
   hd6gY84Eh5DwdEe976S3r2iGsa/0ban2I1mVhYLAjBdhQzimQ0iu9jPtf
   +vTwOMYjad32NI7RKDqSRxl8MNLQrA/GEKVROrQOKUqg2EhOwYwQpnVNj
   /cJmNYSRkiKSIM88D/dERWfG9FgzDvr90ZDidYKpKwZiA2zvYnea7eQdc
   AtbMi4XwQ4Cm50HsRC3eK4UZZOD7w11Ohz88NpmMNQa8OhLvxEoCQLlTP
   TWkRI88uMO6vcGbJs1RszuIDcvWp2/vTK6uROithisCBiygS1wmW/7+Th
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754210"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739263"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739263"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:50 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 8/9] perf symbols: Start adding support for .plt.got for x86
Date:   Fri, 27 Jan 2023 19:02:21 +0200
Message-Id: <20230127170222.9895-9-adrian.hunter@intel.com>
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

For x86, .plt.got is used, for example, when the address is taken of a
dynamically linked function. Start adding support by synthesizing a
symbol for each entry. A subsequent patch will attempt to get a better
name for the symbol.

Example:

  Before:

    $ cat tstpltlib.c
    void fn1(void) {}
    void fn2(void) {}
    void fn3(void) {}
    void fn4(void) {}
    $ cat tstpltgot.c
    void fn1(void);
    void fn2(void);
    void fn3(void);
    void fn4(void);

    void callfn(void (*fn)(void))
    {
            fn();
    }

    int main()
    {
            fn4();
            fn1();
            callfn(fn3);
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
    $ gcc -Wall -Wextra -o tstpltgot tstpltgot.c -L . -ltstpltlib -Wl,-rpath="$(pwd)"
    $ readelf -SW tstpltgot | grep 'Name\|plt\|dyn'
      [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
      [ 6] .dynsym           DYNSYM          00000000000003d8 0003d8 0000f0 18   A  7   1  8
      [ 7] .dynstr           STRTAB          00000000000004c8 0004c8 0000c6 00   A  0   0  1
      [10] .rela.dyn         RELA            00000000000005d8 0005d8 0000d8 18   A  6   0  8
      [11] .rela.plt         RELA            00000000000006b0 0006b0 000048 18  AI  6  24  8
      [13] .plt              PROGBITS        0000000000001020 001020 000040 10  AX  0   0 16
      [14] .plt.got          PROGBITS        0000000000001060 001060 000020 10  AX  0   0 16
      [15] .plt.sec          PROGBITS        0000000000001080 001080 000030 10  AX  0   0 16
      [23] .dynamic          DYNAMIC         0000000000003d90 002d90 000210 10  WA  7   0  8
    $ perf record -e intel_pt//u --filter 'filter main @ ./tstpltgot , filter callfn @ ./tstpltgot' ./tstpltgot
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.011 MB perf.data ]
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    28393.810326915:   tr strt                               0 [unknown] =>     562350baa1b2 main+0x0
    28393.810326915:   tr end  call               562350baa1ba main+0x8 =>     562350baa090 fn4@plt+0x0
    28393.810326917:   tr strt                               0 [unknown] =>     562350baa1bf main+0xd
    28393.810326917:   tr end  call               562350baa1bf main+0xd =>     562350baa080 fn1@plt+0x0
    28393.810326917:   tr strt                               0 [unknown] =>     562350baa1c4 main+0x12
    28393.810326917:   call                       562350baa1ce main+0x1c =>     562350baa199 callfn+0x0
    28393.810326917:   tr end  call               562350baa1ad callfn+0x14 =>     7f607d36110f fn3+0x0
    28393.810326922:   tr strt                               0 [unknown] =>     562350baa1af callfn+0x16
    28393.810326922:   return                     562350baa1b1 callfn+0x18 =>     562350baa1d3 main+0x21
    28393.810326922:   tr end  call               562350baa1d3 main+0x21 =>     562350baa0a0 fn2@plt+0x0
    28393.810326924:   tr strt                               0 [unknown] =>     562350baa1d8 main+0x26
    28393.810326924:   tr end  call               562350baa1d8 main+0x26 =>     562350baa060 [unknown]  <- call to fn3 via .plt.got
    28393.810326925:   tr strt                               0 [unknown] =>     562350baa1dd main+0x2b
    28393.810326925:   tr end  return             562350baa1e3 main+0x31 =>     7f607d029d90 __libc_start_call_main+0x80

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    28393.810326915:   tr strt                               0 [unknown] =>     562350baa1b2 main+0x0
    28393.810326915:   tr end  call               562350baa1ba main+0x8 =>     562350baa090 fn4@plt+0x0
    28393.810326917:   tr strt                               0 [unknown] =>     562350baa1bf main+0xd
    28393.810326917:   tr end  call               562350baa1bf main+0xd =>     562350baa080 fn1@plt+0x0
    28393.810326917:   tr strt                               0 [unknown] =>     562350baa1c4 main+0x12
    28393.810326917:   call                       562350baa1ce main+0x1c =>     562350baa199 callfn+0x0
    28393.810326917:   tr end  call               562350baa1ad callfn+0x14 =>     7f607d36110f fn3+0x0
    28393.810326922:   tr strt                               0 [unknown] =>     562350baa1af callfn+0x16
    28393.810326922:   return                     562350baa1b1 callfn+0x18 =>     562350baa1d3 main+0x21
    28393.810326922:   tr end  call               562350baa1d3 main+0x21 =>     562350baa0a0 fn2@plt+0x0
    28393.810326924:   tr strt                               0 [unknown] =>     562350baa1d8 main+0x26
    28393.810326924:   tr end  call               562350baa1d8 main+0x26 =>     562350baa060 offset_0x1060@plt+0x0
    28393.810326925:   tr strt                               0 [unknown] =>     562350baa1dd main+0x2b
    28393.810326925:   tr end  return             562350baa1e3 main+0x31 =>     7f607d029d90 __libc_start_call_main+0x80

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9e265a726418..254116d40e59 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -466,6 +466,30 @@ static bool machine_is_x86(GElf_Half e_machine)
 	return e_machine == EM_386 || e_machine == EM_X86_64;
 }
 
+static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
+					   GElf_Ehdr *ehdr,
+					   char *buf, size_t buf_sz)
+{
+	struct symbol *sym;
+	GElf_Shdr shdr;
+	Elf_Scn *scn;
+	size_t i;
+
+	scn = elf_section_by_name(elf, ehdr, &shdr, ".plt.got", NULL);
+	if (!scn || !shdr.sh_entsize)
+		return 0;
+
+	for (i = 0; i < shdr.sh_size; i += shdr.sh_entsize) {
+		snprintf(buf, buf_sz, "offset_%#zx@plt", shdr.sh_offset + i);
+		sym = symbol__new(shdr.sh_offset + i, shdr.sh_entsize, STB_GLOBAL, STT_FUNC, buf);
+		if (!sym)
+			return -1;
+		symbols__insert(&dso->symbols, sym);
+	}
+
+	return 0;
+}
+
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
@@ -514,6 +538,11 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		goto out_elf_end;
 	symbols__insert(&dso->symbols, plt_sym);
 
+	/* Only x86 has .plt.got */
+	if (machine_is_x86(ehdr.e_machine) &&
+	    dso__synthesize_plt_got_symbols(dso, elf, &ehdr, sympltname, sizeof(sympltname)))
+		goto out_elf_end;
+
 	/* Only x86 has .plt.sec */
 	if (machine_is_x86(ehdr.e_machine) &&
 	    elf_section_by_name(elf, &ehdr, &plt_sec_shdr, ".plt.sec", NULL)) {
-- 
2.34.1

