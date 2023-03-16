Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F0E6BD0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCPNg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCPNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BFF95BF8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678973765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P7rCgUnUAv8ykJTgwwgCJOYtcv+0Nqou84Ca6XiSyf4=;
        b=U5oXGLV7vyZ587LDQb75y3QHh2YSv3rzGq97vaKswTBhAC7cwEzoFpSxh/3nmv5maHaMZZ
        qmzwms5DbeI1TKoarXZ3Qmx6yxiFF+mJxpaSbZzofCN/v2T+smJYAmkcckfL8EHGJgou5a
        gj7yeJYy1f0tq2G+qQpbTEOfBrPetxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-_ksvoD9RP_msPxf5DVgg8A-1; Thu, 16 Mar 2023 09:36:01 -0400
X-MC-Unique: _ksvoD9RP_msPxf5DVgg8A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C999101A54F;
        Thu, 16 Mar 2023 13:36:00 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B17540D1C5;
        Thu, 16 Mar 2023 13:36:00 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id EB3351C0401; Thu, 16 Mar 2023 14:35:58 +0100 (CET)
From:   Artem Savkov <asavkov@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
Date:   Thu, 16 Mar 2023 14:35:56 +0100
Message-Id: <20230316133557.868731-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an email to Arnaldo Andrii Nakryiko suggested that perf can get
information about inlined functions from dwarf when available and then
add it to userspace stacktraces even in framepointer or lbr mode.
Looking closer at perf it turned out all required bits and pieces are
already there and inline information can be easily added to both
framepointer and lbr callchains by adding an append_inlines() call to
add_callchain_ip().

I used the following small program for testing:

======
#include <stdio.h>
#include <stdint.h>

static __attribute__((noinline)) uint32_t func_noinline2(uint32_t i)
{
        return i + 10;
}

static inline uint32_t func_declared_inlined(uint32_t i)
{
        return func_noinline2(i + 4);
}

static __attribute__((noinline)) uint32_t func_noinline(uint32_t i)
{
        return func_declared_inlined(i + 3);
}

static uint32_t func_inlined(uint32_t i)
{
        return func_noinline(i + 2);
}

int main(int argc, char **argv)
{
        uint64_t ret = 0;
        uint32_t i = 0;

        for (i = 0; i < 10000000; i++) {
                ret += func_inlined(i);
                ret -= func_noinline(i);
                ret -= func_noinline2(i);
                ret += func_declared_inlined(i);
        }

        printf("%s: %ld\n", __func__, ret);
        return ret;
}
======

When built with "gcc -Wall -fno-omit-frame-pointer -O2 -g" (gcc
version 12.2.1 20221121 (Red Hat 12.2.1-4) (GCC)) it results in
func_inlined() and func_declared_inlined() being inlined into main()
and func_declared_inlined() also being inlined into func_noinline().

Here are the diffs for 'perf report --call-graph --stdio' output before
and after the patch:

Frame-pointer mode recorded with 'perf record --call-graph=fp --freq=max -- ./a.out'
======
--- unpatched.fp	2023-03-16 13:27:22.724017900 +0100
+++ patched.fp	2023-03-16 13:27:28.608857921 +0100
@@ -14,18 +14,24 @@
             ---__libc_start_call_main
                |          
                |--46.31%--main
+               |          |          
+               |           --11.16%--func_declared_inlined (inlined)
                |          
                |--27.41%--func_noinline
+               |          func_declared_inlined (inlined)
                |          
                 --25.68%--func_noinline2
 
     85.71%    39.64%  a.out    a.out                 [.] main
             |          
             |--46.07%--main
+            |          |          
+            |           --11.16%--func_declared_inlined (inlined)
             |          
              --39.64%--__libc_start_call_main
                        |          
                        |--27.17%--func_noinline
+                       |          func_declared_inlined (inlined)
                        |          
                         --12.23%--func_noinline2
 
@@ -34,31 +40,47 @@
             |--46.31%--__libc_start_call_main
             |          |          
             |           --46.07%--main
+            |                     |          
+            |                      --11.16%--func_declared_inlined (inlined)
             |          
              --25.44%--func_noinline2
 
     40.56%    13.39%  a.out    a.out                 [.] func_noinline
             |          
             |--27.17%--func_noinline
+            |          func_declared_inlined (inlined)
             |          
              --13.39%--__libc_start_call_main
                        |          
                         --13.15%--func_noinline2
 
+    27.41%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
+            |
+            ---func_declared_inlined (inlined)
+
+    11.16%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
+            |
+            ---func_declared_inlined (inlined)
+
      0.30%     0.30%  a.out    [unknown]             [k] 0xffffffff81e011b7
      0.27%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start_user
      0.25%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_sysdep_start
      0.20%     0.00%  a.out    ld-linux-x86-64.so.2  [.] dl_main
      0.19%     0.19%  a.out    [unknown]             [k] 0xffffffff81e00193
+     0.18%     0.00%  a.out    a.out                 [.] func_inlined (inlined)
      0.10%     0.05%  a.out    ld-linux-x86-64.so.2  [.] _dl_relocate_object
      0.09%     0.00%  a.out    [unknown]             [k] 0x00007fef811be880
      0.09%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_map_object
      0.06%     0.00%  a.out    libc.so.6             [.] sysmalloc
      0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] munmap
-     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] mprotect
+     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] rtld_timer_accum (inlined)
+     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] rtld_timer_stop (inlined)
+     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] __mprotect (inlined)
      0.05%     0.00%  a.out    libc.so.6             [.] __x86_cacheinfo_ifunc
+     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] elf_dynamic_do_Rela (inlined)
      0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_map_object_from_fd
-     0.04%     0.00%  a.out    ld-linux-x86-64.so.2  [.] mmap64
+     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] elf_get_dynamic_info (inlined)
+     0.04%     0.00%  a.out    ld-linux-x86-64.so.2  [.] __mmap64 (inlined)
      0.04%     0.04%  a.out    ld-linux-x86-64.so.2  [.] _dl_cache_libcmp
      0.04%     0.00%  a.out    [unknown]             [.] 0x000000000001b19a
      0.04%     0.00%  a.out    [unknown]             [k] 0000000000000000
@@ -66,13 +88,15 @@
      0.04%     0.04%  a.out    ld-linux-x86-64.so.2  [.] do_lookup_x
      0.03%     0.03%  a.out    ld-linux-x86-64.so.2  [.] intel_check_word.constprop.0
      0.03%     0.00%  a.out    [unknown]             [.] 0x0000000004000000
+     0.03%     0.00%  a.out    ld-linux-x86-64.so.2  [.] intel_check_word (inlined)
      0.02%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start
      0.02%     0.02%  a.out    ld-linux-x86-64.so.2  [.] __GI___tunables_init
      0.02%     0.00%  a.out    [unknown]             [.] 0x722f3d4b434f535f
      0.02%     0.00%  a.out    [unknown]             [.] 0x00007ffebdd69f59
+     0.02%     0.00%  a.out    ld-linux-x86-64.so.2  [.] tunable_is_name (inlined)
      0.01%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _start
======

LBR mode recorded with 'perf record --call-graph=lbr -- ./a.out'
======
--- unpatched.lbr	2023-03-16 13:27:50.853253211 +0100
+++ patched.lbr	2023-03-16 13:27:56.312104813 +0100
@@ -6,58 +6,95 @@
 # Samples: 238  of event 'cycles:u'
 # Event count (approx.): 193485873
 #
-# Children      Self  Command  Shared Object         Symbol                           
-# ........  ........  .......  ....................  .................................
+# Children      Self  Command  Shared Object         Symbol                       
+# ........  ........  .......  ....................  .............................
 #
     99.11%    36.87%  a.out    a.out                 [.] main
             |          
             |--62.24%--main
             |          |          
-            |           --17.47%--func_noinline
+            |          |--11.05%--func_inlined (inlined)
+            |          |          func_noinline
+            |          |          func_declared_inlined (inlined)
+            |          |          
+            |           --6.42%--func_noinline
+            |                     func_declared_inlined (inlined)
             |          
              --36.87%--_start
-                       __libc_start_main@@GLIBC_2.34
+                       __libc_start_main_alias_2 (inlined)
                        __libc_start_call_main
                        main
                        |          
-                       |--24.52%--func_noinline
+                       |--17.51%--func_inlined (inlined)
+                       |          func_noinline
+                       |          func_declared_inlined (inlined)
+                       |          
+                       |--8.45%--func_noinline2
                        |          
-                        --10.01%--func_noinline2
+                       |--7.01%--func_noinline
+                       |          func_declared_inlined (inlined)
+                       |          
+                        --1.57%--func_declared_inlined (inlined)
+                                  func_noinline2
 
     99.11%     0.00%  a.out    a.out                 [.] _start
             |
             ---_start
-               __libc_start_main@@GLIBC_2.34
+               __libc_start_main_alias_2 (inlined)
                __libc_start_call_main
                main
                |          
-               |--41.99%--func_noinline
+               |--28.55%--func_inlined (inlined)
+               |          func_noinline
+               |          func_declared_inlined (inlined)
+               |          
+               |--13.43%--func_noinline
+               |          func_declared_inlined (inlined)
                |          
-                --10.37%--func_noinline2
+               |--8.81%--func_noinline2
+               |          
+                --1.57%--func_declared_inlined (inlined)
+                          func_noinline2
 
-    99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_main@@GLIBC_2.34
+    99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_main_alias_2 (inlined)
             |
-            ---__libc_start_main@@GLIBC_2.34
+            ---__libc_start_main_alias_2 (inlined)
                __libc_start_call_main
                main
                |          
-               |--41.99%--func_noinline
+               |--28.55%--func_inlined (inlined)
+               |          func_noinline
+               |          func_declared_inlined (inlined)
+               |          
+               |--13.43%--func_noinline
+               |          func_declared_inlined (inlined)
+               |          
+               |--8.81%--func_noinline2
                |          
-                --10.37%--func_noinline2
+                --1.57%--func_declared_inlined (inlined)
+                          func_noinline2
 
     99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_call_main
             |
             ---__libc_start_call_main
                main
                |          
-               |--41.99%--func_noinline
+               |--28.55%--func_inlined (inlined)
+               |          func_noinline
+               |          func_declared_inlined (inlined)
                |          
-                --10.37%--func_noinline2
+               |--13.43%--func_noinline
+               |          func_declared_inlined (inlined)
+               |          
+               |--8.81%--func_noinline2
+               |          
+                --1.57%--func_declared_inlined (inlined)
+                          func_noinline2
 
     54.44%    44.43%  a.out    a.out                 [.] func_noinline2
             |          
             |--44.43%--_start
-            |          __libc_start_main@@GLIBC_2.34
+            |          __libc_start_main_alias_2 (inlined)
             |          __libc_start_call_main
             |          main
             |          
@@ -66,19 +103,42 @@
     41.99%    17.47%  a.out    a.out                 [.] func_noinline
             |          
             |--24.52%--func_noinline
+            |          func_declared_inlined (inlined)
             |          
              --17.47%--_start
-                       __libc_start_main@@GLIBC_2.34
+                       __libc_start_main_alias_2 (inlined)
                        __libc_start_call_main
                        main
-                       func_noinline
+                       |          
+                       |--11.05%--func_inlined (inlined)
+                       |          func_noinline
+                       |          func_declared_inlined (inlined)
+                       |          
+                        --6.42%--func_noinline
+                                  func_declared_inlined (inlined)
+
+    41.99%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
+            |
+            ---func_declared_inlined (inlined)
+
+    28.55%     0.00%  a.out    a.out                 [.] func_inlined (inlined)
+            |
+            ---func_inlined (inlined)
+               func_noinline
+               func_declared_inlined (inlined)
+
+     1.57%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
+            |
+            ---func_declared_inlined (inlined)
+               func_noinline2
 
      0.88%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _start
             |
             ---_start
                _dl_start
                |          
-                --0.71%--_dl_sysdep_start
+                --0.71%--_dl_start_final (inlined)
+                          _dl_sysdep_start
                           dl_main
                           _dl_map_object_deps
                           _dl_catch_exception
@@ -92,7 +152,8 @@
             |
             ---_dl_start
                |          
-                --0.71%--_dl_sysdep_start
+                --0.71%--_dl_start_final (inlined)
+                          _dl_sysdep_start
                           dl_main
                           _dl_map_object_deps
                           _dl_catch_exception
@@ -106,6 +167,20 @@
             |
             ---_start
                _dl_start
+               _dl_start_final (inlined)
+               _dl_sysdep_start
+               dl_main
+               _dl_map_object_deps
+               _dl_catch_exception
+               openaux
+               _dl_map_object
+               _dl_map_object_from_fd
+               _dl_new_object
+               strlen
+
+     0.71%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start_final (inlined)
+            |
+            ---_dl_start_final (inlined)
                _dl_sysdep_start
                dl_main
                _dl_map_object_deps
======

No meaningful differences in output with callchains in dwarf mode or when
tracing a binary that was compiled with no dwarf debuginfo.

Artem Savkov (1):
  perf report: append inlines to non-dwarf callchains

 tools/perf/util/machine.c | 82 ++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

-- 
2.39.2

