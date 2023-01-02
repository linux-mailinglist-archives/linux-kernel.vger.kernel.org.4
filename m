Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECA65B4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjABQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbjABQQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:16:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5351AE68;
        Mon,  2 Jan 2023 08:16:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CD77B80D85;
        Mon,  2 Jan 2023 16:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC8C433D2;
        Mon,  2 Jan 2023 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672676210;
        bh=fLsGwxADOfpNVMEEgkG7geJ98HrY385l+MjA+VZHbNI=;
        h=Date:From:To:Cc:Subject:From;
        b=BbDBibU92AFaJ7mNA2Knkils1vKWf2nhn2dOBr8a/DYTv83bmYdSM6Y6tppIJwcma
         Y6FN+uu4t+c4nRbPkTCqo9hg2eFGsB6wsSPGQDdiOBd6OTnuH0hrcRq6nFQUl9qjgQ
         /l8TuZf4I0vyjpdiisahUWY8pmyzOHVrFVTX54tnY2aHfmCJ1Z0bW/dOOca5oEt0Mq
         3UC0Tli3BJRkvnQKTkiR8CCXtTudeut0q274bpOnvbkoxWKGc5xJeR8VF/WaP4L69o
         y+23AF9XyWPn0HWGX12UXFlckRE2Yg9+XXw7imJ6QCv9wBAA1nmSKnSkmq4xJS19AQ
         EaW+THmGW98VA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92D3440468; Mon,  2 Jan 2023 13:16:47 -0300 (-03)
Date:   Mon, 2 Jan 2023 13:16:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tools: Fix segfault when trying to process
 tracepoints in perf.data and not linked with libtraceevent
Message-ID: <Y7MDb7kRaHZB6APC@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have a perf.data file with tracepoints, such as:

  # perf evlist -f
  probe_perf:lzma_decompress_to_file
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint eve=
nts
  #

We end up segfaulting when using perf built with NO_LIBTRACEEVENT=3D1 by
trying to find an evsel with a NULL 'event_name' variable:

  (gdb) run report --stdio -f
  Starting program: /root/bin/perf report --stdio -f

  Program received signal SIGSEGV, Segmentation fault.
  0x000000000055219d in find_evsel (evlist=3D0xfda7b0, event_name=3D0x0) at=
 util/sort.c:2830
  warning: Source file is more recent than executable.
  2830		if (event_name[0] =3D=3D '%') {
  Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-=
11.fc36.x86_64 cyrus-sasl-lib-2.1.27-18.fc36.x86_64 elfutils-debuginfod-cli=
ent-0.188-3.fc36.x86_64 elfutils-libelf-0.188-3.fc36.x86_64 elfutils-libs-0=
=2E188-3.fc36.x86_64 glibc-2.35-20.fc36.x86_64 keyutils-libs-1.6.1-4.fc36.x=
86_64 krb5-libs-1.19.2-12.fc36.x86_64 libbrotli-1.0.9-7.fc36.x86_64 libcap-=
2.48-4.fc36.x86_64 libcom_err-1.46.5-2.fc36.x86_64 libcurl-7.82.0-12.fc36.x=
86_64 libevent-2.1.12-6.fc36.x86_64 libgcc-12.2.1-4.fc36.x86_64 libidn2-2.3=
=2E4-1.fc36.x86_64 libnghttp2-1.51.0-1.fc36.x86_64 libpsl-0.21.1-5.fc36.x86=
_64 libselinux-3.3-4.fc36.x86_64 libssh-0.9.6-4.fc36.x86_64 libstdc++-12.2.=
1-4.fc36.x86_64 libunistring-1.0-1.fc36.x86_64 libunwind-1.6.2-2.fc36.x86_6=
4 libxcrypt-4.4.33-4.fc36.x86_64 libzstd-1.5.2-2.fc36.x86_64 numactl-libs-2=
=2E0.14-5.fc36.x86_64 opencsd-1.2.0-1.fc36.x86_64 openldap-2.6.3-1.fc36.x86=
_64 openssl-libs-3.0.5-2.fc36.x86_64 slang-2.3.2-11.fc36.x86_64 xz-libs-5.2=
=2E5-9.fc36.x86_64 zlib-1.2.11-33.fc36.x86_64
  (gdb) bt
  #0  0x000000000055219d in find_evsel (evlist=3D0xfda7b0, event_name=3D0x0=
) at util/sort.c:2830
  #1  0x0000000000552416 in add_dynamic_entry (evlist=3D0xfda7b0, tok=3D0xf=
fb6eb "trace", level=3D2) at util/sort.c:2976
  #2  0x0000000000552d26 in sort_dimension__add (list=3D0xf93e00 <perf_hpp_=
list>, tok=3D0xffb6eb "trace", evlist=3D0xfda7b0, level=3D2) at util/sort.c=
:3193
  #3  0x0000000000552e1c in setup_sort_list (list=3D0xf93e00 <perf_hpp_list=
>, str=3D0xffb6eb "trace", evlist=3D0xfda7b0) at util/sort.c:3227
  #4  0x00000000005532fa in __setup_sorting (evlist=3D0xfda7b0) at util/sor=
t.c:3381
  #5  0x0000000000553cdc in setup_sorting (evlist=3D0xfda7b0) at util/sort.=
c:3608
  #6  0x000000000042eb9f in cmd_report (argc=3D0, argv=3D0x7fffffffe470) at=
 builtin-report.c:1596
  #7  0x00000000004aee7e in run_builtin (p=3D0xf64ca0 <commands+288>, argc=
=3D3, argv=3D0x7fffffffe470) at perf.c:330
  #8  0x00000000004af0f2 in handle_internal_command (argc=3D3, argv=3D0x7ff=
fffffe470) at perf.c:384
  #9  0x00000000004af241 in run_argv (argcp=3D0x7fffffffe29c, argv=3D0x7fff=
ffffe290) at perf.c:428
  #10 0x00000000004af5fc in main (argc=3D3, argv=3D0x7fffffffe470) at perf.=
c:562
  (gdb)

So check if we have tracepoint events in add_dynamic_entry() and bail
out instead:

  # perf report --stdio -f
  This perf binary isn't linked with libtraceevent, can't process probe_per=
f:lzma_decompress_to_file
  Error:
  Unknown --sort key: `trace'
  #

Fixes: 378ef0f5d9d7f465 ("perf build: Use libtraceevent from the system")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e188f74698dd310a..37662cdec5eefd18 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2971,6 +2971,18 @@ static int add_dynamic_entry(struct evlist *evlist, =
const char *tok,
 		ret =3D add_all_matching_fields(evlist, field_name, raw_trace, level);
 		goto out;
 	}
+#else
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
+			pr_err("%s %s", ret ? "," : "This perf binary isn't linked with libtrac=
eevent, can't process", evsel__name(evsel));
+			ret =3D -ENOTSUP;
+		}
+	}
+
+	if (ret) {
+		pr_err("\n");
+		goto out;
+	}
 #endif
=20
 	evsel =3D find_evsel(evlist, event_name);
--=20
2.39.0

