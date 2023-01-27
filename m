Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B440A67EBE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjA0RDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjA0RDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF027FA22;
        Fri, 27 Jan 2023 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838957; x=1706374957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDKkyRtHwSFPxVEw6hcGJuHrCfS3E8nNGIlQ35mRFSA=;
  b=Z1OdJydNRA3BzLN21R9NOXqb7oMR+IOQ0wCWw13bBjpRzZ8CIo1CrGaE
   0ASLkmvrPsdvTFP6slDb4vVtthbtPHC2OWZ5n2XuiD6ceSEMAEARe6YA9
   uB/nerLf5OGUSNxCFjg1Pj7RBdv5EpnFDMiKVWeWE0EYiX0Fqquvwf+QV
   g8s0OcGXXAXYGtZdjLoNXQ6HvZAj6+g+ahROaIejhyRQGmlSRZe9F0raa
   m61FH4ip5pW7GXqmHaIJt7V2GOQ4YREjUTk6S5K6d8OqS25zeOZKQ19yy
   eoN0xP8K+fJYlcCEedMbSMQb3RxASASpfUdBncUfPi6m2eqbVb7V0c2Nj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754112"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739166"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739166"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:34 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/9] perf symbols: Correct plt entry sizes for x86
Date:   Fri, 27 Jan 2023 19:02:14 +0200
Message-Id: <20230127170222.9895-2-adrian.hunter@intel.com>
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

In 32-bit executables the .plt entry size can be set to 4 when it is really
16. In fact the only sizes used for x86 (32 or 64 bit) are 8 or 16, so
check for those and, if not, use the alignment to choose which it is.

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
    $ gcc -m32 -Wall -Wextra -shared -o libtstpltlib32.so tstpltlib.c
    $ gcc -m32 -Wall -Wextra -o tstplt32 tstplt.c -L . -ltstpltlib32 -Wl,-rpath=$(pwd)
    $ perf record -e intel_pt//u --filter 'filter main @ ./tstplt32' ./tstplt32
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.011 MB perf.data ]
    $ readelf -SW tstplt32 | grep 'plt\|Name'
      [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
      [10] .rel.plt          REL             0000041c 00041c 000028 08  AI  5  22  4
      [12] .plt              PROGBITS        00001030 001030 000060 04  AX  0   0 16   <- ES is 0x04, should be 0x10
      [13] .plt.got          PROGBITS        00001090 001090 000008 08  AX  0   0  8
    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    17894.383903029:   tr strt                               0 [unknown] =>         565b81cd main+0x0
    17894.383903029:   tr end  call                   565b81d4 main+0x7 =>         565b80d0 __x86.get_pc_thunk.bx+0x0
    17894.383903031:   tr strt                               0 [unknown] =>         565b81d9 main+0xc
    17894.383903031:   tr end  call                   565b81df main+0x12 =>         565b8070 [unknown]
    17894.383903032:   tr strt                               0 [unknown] =>         565b81e4 main+0x17
    17894.383903032:   tr end  call                   565b81e4 main+0x17 =>         565b8050 [unknown]
    17894.383903033:   tr strt                               0 [unknown] =>         565b81e9 main+0x1c
    17894.383903033:   tr end  call                   565b81e9 main+0x1c =>         565b8080 [unknown]
    17894.383903033:   tr strt                               0 [unknown] =>         565b81ee main+0x21
    17894.383903033:   tr end  call                   565b81ee main+0x21 =>         565b8060 [unknown]
    17894.383903237:   tr strt                               0 [unknown] =>         565b81f3 main+0x26
    17894.383903237:   tr end  return                 565b81fc main+0x2f =>         f7c21519 [unknown]

  After:

    $ perf script --itrace=be --ns -F+flags,-event,+addr,-period,-comm,-tid,-cpu,-dso
    17894.383903029:   tr strt                               0 [unknown] =>         565b81cd main+0x0
    17894.383903029:   tr end  call                   565b81d4 main+0x7 =>         565b80d0 __x86.get_pc_thunk.bx+0x0
    17894.383903031:   tr strt                               0 [unknown] =>         565b81d9 main+0xc
    17894.383903031:   tr end  call                   565b81df main+0x12 =>         565b8070 fn4@plt+0x0
    17894.383903032:   tr strt                               0 [unknown] =>         565b81e4 main+0x17
    17894.383903032:   tr end  call                   565b81e4 main+0x17 =>         565b8050 fn1@plt+0x0
    17894.383903033:   tr strt                               0 [unknown] =>         565b81e9 main+0x1c
    17894.383903033:   tr end  call                   565b81e9 main+0x1c =>         565b8080 fn2@plt+0x0
    17894.383903033:   tr strt                               0 [unknown] =>         565b81ee main+0x21
    17894.383903033:   tr end  call                   565b81ee main+0x21 =>         565b8060 fn3@plt+0x0
    17894.383903237:   tr strt                               0 [unknown] =>         565b81f3 main+0x26
    17894.383903237:   tr end  return                 565b81fc main+0x2f =>         f7c21519 [unknown]

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index aa62735aea7b..9328c162d68f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -360,14 +360,23 @@ static bool get_plt_sizes(struct dso *dso, GElf_Ehdr *ehdr, GElf_Shdr *shdr_plt,
 		*plt_header_size = 128;
 		*plt_entry_size = 32;
 		return true;
+	case EM_386:
+	case EM_X86_64:
+		*plt_entry_size = shdr_plt->sh_entsize;
+		/* Size is 8 or 16, if not, assume alignment indicates size */
+		if (*plt_entry_size != 8 && *plt_entry_size != 16)
+			*plt_entry_size = shdr_plt->sh_addralign == 8 ? 8 : 16;
+		*plt_header_size = *plt_entry_size;
+		break;
 	default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 		*plt_header_size = shdr_plt->sh_entsize;
 		*plt_entry_size = shdr_plt->sh_entsize;
-		if (*plt_entry_size)
-			return true;
-		pr_debug("Missing PLT entry size for %s\n", dso->long_name);
-		return false;
+		break;
 	}
+	if (*plt_entry_size)
+		return true;
+	pr_debug("Missing PLT entry size for %s\n", dso->long_name);
+	return false;
 }
 
 /*
-- 
2.34.1

