Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574B165C11E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjACNtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbjACNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:48:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D54F00F;
        Tue,  3 Jan 2023 05:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFCE3B80EBE;
        Tue,  3 Jan 2023 13:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E16C433D2;
        Tue,  3 Jan 2023 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672753729;
        bh=KyR6DPegudHz977V+4FBWvRSq2ZOg4wp4RgYsuFf0rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cY/8agWeWlbuQOTaTrYfOy+EQSpRlI+BB2SmbyzqLeED+z5L4q83wia5m2tjISaqB
         gkBOrTBMhFaUBOG+rWWsaP5iqgVqgB0NWjibzQGJsdW4ccR+Af7RuR3Wo2r5Rs5Vpp
         jCHlWQHPIf+7Yf9gU4IugdCtd9ULU8km7AhZv4zn+hAb/tCrDh4gIEfjKzJqzcL6QZ
         ywNRAV/dfMLQfCLtCcNWC1/GjIEwIG5s9J0tOsB3SEH8ZK5nwdd1q2jdGgHIxNf8RC
         sinYBXf1QBEV0l+HNlAEJsA7dt1zFKCOLBZWo5nlX+W+/+UzyLk598wPLUpCvHLH5i
         cEmZMpg+kENWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B8FBF40468; Tue,  3 Jan 2023 10:48:46 -0300 (-03)
Date:   Tue, 3 Jan 2023 10:48:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <richter@de.ibm.com>
Subject: Re: [PATCH v2 2/2] perf/test: Fix test case 89 for x86
Message-ID: <Y7QyPkPlDYip3cZH@kernel.org>
References: <20221228145704.2702487-1-tmricht@linux.ibm.com>
 <20221228145704.2702487-2-tmricht@linux.ibm.com>
 <Y7QrqshCjRocRlWP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7QrqshCjRocRlWP@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 03, 2023 at 10:20:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> It works for me on Fedora 36, glibc 2.35-20.fc36, where it was failing,
> I'll now try on a arm64 machine, thanks.

Works as well there, see the full commit log so far:


From e697ea1f4c481fbb87bbcd27ed1be8e1b7616046 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 3 Jan 2023 10:21:01 -0300
Subject: [PATCH 1/1] perf test record_probe_libc_inet_pton: Fix failure due to
 extra inet_pton() backtrace in glibc >= 2.35

Starting with glibc 2.35 there are extra inet_pton() calls when doing a
IPv6 ping as in one of the 'perf test' entry, which makes it fail:

  # perf test inet_pton
  89: probe libc's inet_pton & backtrace it with ping   : FAILED!
  #

If we look at what this script is expecting (commenting out the removal
of the temporary files in it):

  # cat /tmp/expected.aT6
  ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
  .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$
  getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6\)$
  .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
  #

And looking at what we are getting out of 'perf script', to match with
the above:

  # cat /tmp/perf.script.IUC
  ping 623883 [006] 265438.471610: probe_libc:inet_pton: (7f32bcf314c0)
                    1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
                     29510 __libc_start_call_main+0x80 (/usr/lib64/libc.so.6)

  ping 623883 [006] 265438.471664: probe_libc:inet_pton: (7f32bcf314c0)
                    1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
                     fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
                      491e [unknown] (/usr/bin/ping)
  #

We see that its just the first call to inet_pton() that didn't came thru
getaddrinfo(), so if we ignore the first the script matches what it
expects, testing that using 'perf probe' + 'perf record' + 'perf script'
with callchains on userspace targets is producing the expected results.

Since we don't have a 'perf script --skip' to help us here, use tac +
grep to do that, resulting in a one liner that makes this script work on
both older glibc versions as well as with 2.35.

With it, on fedora 36, x86, glibc 2.35:

  # perf test inet_pton
   90: probe libc's inet_pton & backtrace it with ping                 : Ok
  # perf test -v inet_pton
   90: probe libc's inet_pton & backtrace it with ping                 :
  --- start ---
  test child forked, pid 627197
  ping 627220 1 267956.962402: probe_libc:inet_pton_1: (7f488bf314c0)
  1314c0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
  fa6c6 getaddrinfo+0x126 (/usr/lib64/libc.so.6)
  491e n (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok
  #

And on Ubuntu on a Libre Computer ROC-RK3399-PC arm64 system:

Before this patch it works (see that the script used has no 'tac' to
remove the first event):

  root@roc-rk3399-pc:~# dpkg -l | grep libc-bin
  ii  libc-bin                                2.35-0ubuntu3.1                         arm64        GNU C Library: Binaries
  root@roc-rk3399-pc:~# grep -w tac ~acme/libexec/perf-core/tests/shell/record+probe_libc_inet_pton.sh
  root@roc-rk3399-pc:~# perf test inet_pton
   86: probe libc's inet_pton & backtrace it with ping                 : Ok
  root@roc-rk3399-pc:~# perf test -v inet_pton
   86: probe libc's inet_pton & backtrace it with ping                 :
  --- start ---
  test child forked, pid 1375
  ping 1399 [000] 4114.417450: probe_libc:inet_pton: (ffffb3e26120)
  106120 inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  d18bc getaddrinfo+0xec (/usr/lib/aarch64-linux-gnu/libc.so.6)
  2b68 [unknown] (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok
  root@roc-rk3399-pc:~#

And after it continues to work:

  root@roc-rk3399-pc:~# grep -w tac ~acme/libexec/perf-core/tests/shell/record+probe_libc_inet_pton.sh
  	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
  root@roc-rk3399-pc:~# perf test inet_pton
   86: probe libc's inet_pton & backtrace it with ping                 : Ok
  root@roc-rk3399-pc:~# perf test -v inet_pton
   86: probe libc's inet_pton & backtrace it with ping                 :
  --- start ---
  test child forked, pid 6995
  ping 7019 [005] 4832.160741: probe_libc:inet_pton: (ffffa62e6120)
  106120 inet_pton+0x0 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  d18bc getaddrinfo+0xec (/usr/lib/aarch64-linux-gnu/libc.so.6)
  2b68 [unknown] (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok
  root@roc-rk3399-pc:~#

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 34c400ccbe046b59..216b6b64caa3011e 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -57,7 +57,7 @@ trace_libc_inet_pton_backtrace() {
 	perf_data=`mktemp -u /tmp/perf.data.XXX`
 	perf_script=`mktemp -u /tmp/perf.script.XXX`
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
-	perf script -i $perf_data > $perf_script
+	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
 
 	exec 3<$perf_script
 	exec 4<$expected
-- 
2.39.0

