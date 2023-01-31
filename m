Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12223682D90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjAaNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjAaNQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14670442EE;
        Tue, 31 Jan 2023 05:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171011; x=1706707011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buNnSEAE01t7rtwc1PFmnTIysYUAolAqo25T7Ol7MAM=;
  b=lwLEejvtrg4vLcqc2PrdZiEWiFZ3wyst1LRkGE3YeXCPUjXEGgxwr0Do
   YJiG1LtqZaf1eBkdZGMF/l7drdg2lFgQp8U+IZuyemFnNVF4bSUQMSXG0
   gYabLir51Cls0y4WDiw9Vb5kmVa74y+hscS+eiYCbw4sGbdaV+PBXdkI0
   88V3tc0mOostwgIs8esvlWlM5BD/IT8By8xAz4QRbgjdnolrri7+idIxW
   Rj3s28Ea04riNUpX7hYq+TGM1kL/QdT2k4KcGfZu4z6WxXjpb5YAg1GAz
   THSBQf/PzTR0u3w1FqX+f13z2dXhi9tNDx5/8EhwTQGyYQTxJUY9wHAna
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534180"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534180"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864820"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864820"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:48 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 5/9] perf symbols: Add support for IFUNC symbols for x86_64
Date:   Tue, 31 Jan 2023 15:16:21 +0200
Message-Id: <20230131131625.6964-6-adrian.hunter@intel.com>
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

For x86_64, the GNU linker is putting IFUNC information in the relocation
addend, so use it to try to find a symbol for plt entries that refer to
IFUNCs.

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
    [ perf record: Captured and wrote 0.016 MB perf.data ]
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    21860.073683659:   tr strt                               0 [unknown] =>     561e212c42be main+0x0
    21860.073683659:   tr end  call               561e212c42c6 main+0x8 =>     561e212c4110 fn4@plt+0x0
    21860.073683661:   tr strt                               0 [unknown] =>     561e212c42cb main+0xd
    21860.073683661:   tr end  call               561e212c42cb main+0xd =>     561e212c40f0 fn1@plt+0x0
    21860.073683661:   tr strt                               0 [unknown] =>     561e212c42d0 main+0x12
    21860.073683661:   tr end  call               561e212c42d0 main+0x12 =>     561e212c40d0 offset_0x10d0@plt+0x0
    21860.073698451:   tr strt                               0 [unknown] =>     561e212c42d5 main+0x17
    21860.073698451:   tr end  call               561e212c42d5 main+0x17 =>     561e212c4120 fn2@plt+0x0
    21860.073698451:   tr strt                               0 [unknown] =>     561e212c42da main+0x1c
    21860.073698451:   tr end  call               561e212c42da main+0x1c =>     561e212c4100 fn3@plt+0x0
    21860.073698452:   tr strt                               0 [unknown] =>     561e212c42df main+0x21
    21860.073698452:   tr end  return             561e212c42e5 main+0x27 =>     7fb51cc29d90 __libc_start_call_main+0x80

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    21860.073683659:   tr strt                               0 [unknown] =>     561e212c42be main+0x0
    21860.073683659:   tr end  call               561e212c42c6 main+0x8 =>     561e212c4110 fn4@plt+0x0
    21860.073683661:   tr strt                               0 [unknown] =>     561e212c42cb main+0xd
    21860.073683661:   tr end  call               561e212c42cb main+0xd =>     561e212c40f0 fn1@plt+0x0
    21860.073683661:   tr strt                               0 [unknown] =>     561e212c42d0 main+0x12
    21860.073683661:   tr end  call               561e212c42d0 main+0x12 =>     561e212c40d0 thing_ifunc@plt+0x0
    21860.073698451:   tr strt                               0 [unknown] =>     561e212c42d5 main+0x17
    21860.073698451:   tr end  call               561e212c42d5 main+0x17 =>     561e212c4120 fn2@plt+0x0
    21860.073698451:   tr strt                               0 [unknown] =>     561e212c42da main+0x1c
    21860.073698451:   tr end  call               561e212c42da main+0x1c =>     561e212c4100 fn3@plt+0x0
    21860.073698452:   tr strt                               0 [unknown] =>     561e212c42df main+0x21
    21860.073698452:   tr end  return             561e212c42e5 main+0x27 =>     7fb51cc29d90 __libc_start_call_main+0x80

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 38 +++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 07cfcf8f40e3..a002fc0bea03 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -381,6 +381,42 @@ static int sort_rel(struct rel_info *ri)
 	return 0;
 }
 
+/*
+ * For x86_64, the GNU linker is putting IFUNC information in the relocation
+ * addend.
+ */
+static bool addend_may_be_ifunc(GElf_Ehdr *ehdr, struct rel_info *ri)
+{
+	return ehdr->e_machine == EM_X86_64 && ri->is_rela &&
+	       GELF_R_TYPE(ri->rela.r_info) == R_X86_64_IRELATIVE;
+}
+
+static bool get_ifunc_name(Elf *elf, struct dso *dso, GElf_Ehdr *ehdr,
+			   struct rel_info *ri, char *buf, size_t buf_sz)
+{
+	u64 addr = ri->rela.r_addend;
+	struct symbol *sym;
+	GElf_Phdr phdr;
+
+	if (!addend_may_be_ifunc(ehdr, ri))
+		return false;
+
+	if (elf_read_program_header(elf, addr, &phdr))
+		return false;
+
+	addr -= phdr.p_vaddr - phdr.p_offset;
+
+	sym = dso__find_symbol_nocache(dso, addr);
+
+	/* Expecting the address to be an IFUNC or IFUNC alias */
+	if (!sym || sym->start != addr || (sym->type != STT_GNU_IFUNC && !sym->ifunc_alias))
+		return false;
+
+	snprintf(buf, buf_sz, "%s@plt", sym->name);
+
+	return true;
+}
+
 static void exit_rel(struct rel_info *ri)
 {
 	free(ri->sorted);
@@ -560,7 +596,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			elf_name = demangled;
 		if (*elf_name)
 			snprintf(sympltname, sizeof(sympltname), "%s@plt", elf_name);
-		else
+		else if (!get_ifunc_name(elf, dso, &ehdr, &ri, sympltname, sizeof(sympltname)))
 			snprintf(sympltname, sizeof(sympltname),
 				 "offset_%#" PRIx64 "@plt", plt_offset);
 		free(demangled);
-- 
2.34.1

