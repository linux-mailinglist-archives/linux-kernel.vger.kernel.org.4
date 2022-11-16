Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0F62BC76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiKPLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiKPLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:48:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29A6409;
        Wed, 16 Nov 2022 03:35:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BAC61D25;
        Wed, 16 Nov 2022 11:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E93C433C1;
        Wed, 16 Nov 2022 11:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668598530;
        bh=nVdab/Eivh7ObAbZwVi5SWh6snazZRP/DXRO5cq4ATE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mk+iBuGRcBxXIIsX6u2WGRkycNx5kU3FWIodAdeyyGGRFcNmomt6fnLoqBAZveDJv
         8COXy8sSnPy63r/zvZ0dl15MQV9QaBbjb+i+C27xxzdTCi6A12vrzZ/Crn9mb+vImO
         scZ39TcJKQif2HpJcq+Rn8RMjQW+Xb/gQKMmyBjS/55NAi/CSx9puOhjGQuttb4FXP
         FY9+hkzD5HYX5f4KLVSMdF8HEzAvbmFveS9kqGhW/+18FYm8uOlyTQs12+FOMQwKWX
         rS1uOp+Lmz/CUelf+zbvBTWLPoiCsWa7kj0pW3penIMlo6t8EppSkxS7WJX/gUbs4S
         TVY41MoYBQuuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 062774034E; Wed, 16 Nov 2022 08:35:27 -0300 (-03)
Date:   Wed, 16 Nov 2022 08:35:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 10/10] perf list: Add json output option
Message-ID: <Y3TK/6bBFsHxduPc@kernel.org>
References: <20221114210723.2749751-1-irogers@google.com>
 <20221114210723.2749751-11-irogers@google.com>
 <Y3OX1pcclKCgbpeT@kernel.org>
 <Y3TIG7BIzltgvCPw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y3TIG7BIzltgvCPw@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 16, 2022 at 08:23:07AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 15, 2022 at 10:44:54AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Nov 14, 2022 at 01:07:23PM -0800, Ian Rogers escreveu:
> > > Output events and metrics in a json format by overriding the print
> > > callbacks. Currently other command line options aren't supported and
> > > metrics are repeated once per metric group.
> >=20
> > Applied the patch with a few fixes and added this to the last cset:
>=20
> There is a problem, detected using 'perf test', the last one:
>=20
> [root@quaco ~]# perf test "trace + vfs_getname"
> 112: Check open filename arg using perf trace + vfs_getname          : FA=
ILED!
> [root@quaco ~]# perf test -v "trace + vfs_getname"
> 112: Check open filename arg using perf trace + vfs_getname          :
> --- start ---
> test child forked, pid 611667
> test child finished with -1
> ---- end ----
> Check open filename arg using perf trace + vfs_getname: FAILED!
> [root@quaco ~]#
>=20
> Verbose didn't help, so I looked at the shell script for that test and
> the problem is here:
>=20
> [root@quaco ~]# perf list syscalls:sys_enter_open*
> Segmentation fault (core dumped)
> ^C
> [root@quaco ~]#
> [root@quaco ~]#
> [root@quaco ~]# gdb perf
> GNU gdb (GDB) Fedora 12.1-2.fc36
> (gdb) run list syscalls:sys_enter_open*
> Starting program: /root/bin/perf list syscalls:sys_enter_open*
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> [Detaching after fork from child process 611757]
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004e742b in __match_glob (str=3D0x0, pat=3D0xe44900 "syscalls",=
 ignore_space=3Dignore_space@entry=3Dfalse, case_ins=3Dcase_ins@entry=3Dfal=
se) at util/string.c:113
> 113		while (*str && *pat && *pat !=3D '*') {
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-=
11.fc36.x86_64 cyrus-sasl-lib-2.1.27-18.fc36.x86_64 elfutils-debuginfod-cli=
ent-0.187-4.fc36.x86_64 elfutils-libelf-0.187-4.fc36.x86_64 elfutils-libs-0=
=2E187-4.fc36.x86_64 glib2-2.72.3-1.fc36.x86_64 glibc-2.35-20.fc36.x86_64 k=
eyutils-libs-1.6.1-4.fc36.x86_64 krb5-libs-1.19.2-11.fc36.x86_64 libbabeltr=
ace-1.5.8-9.fc36.x86_64 libbrotli-1.0.9-7.fc36.x86_64 libcap-2.48-4.fc36.x8=
6_64 libcom_err-1.46.5-2.fc36.x86_64 libcurl-7.82.0-8.fc36.x86_64 libevent-=
2.1.12-6.fc36.x86_64 libgcc-12.2.1-2.fc36.x86_64 libidn2-2.3.4-1.fc36.x86_6=
4 libnghttp2-1.46.0-2.fc36.x86_64 libpsl-0.21.1-5.fc36.x86_64 libselinux-3.=
3-4.fc36.x86_64 libssh-0.9.6-4.fc36.x86_64 libunistring-1.0-1.fc36.x86_64 l=
ibunwind-1.6.2-2.fc36.x86_64 libuuid-2.38-1.fc36.x86_64 libxcrypt-4.4.28-1.=
fc36.x86_64 libzstd-1.5.2-2.fc36.x86_64 numactl-libs-2.0.14-5.fc36.x86_64 o=
penldap-2.6.3-1.fc36.x86_64 openssl-libs-3.0.5-1.fc36.x86_64 pcre-8.45-1.fc=
36.1.x86_64 perl-libs-5.34.1-486.fc36.x86_64 popt-1.18-7.fc36.x86_64 python=
3-libs-3.10.7-1.fc36.x86_64 slang-2.3.2-11.fc36.x86_64 xz-libs-5.2.5-9.fc36=
=2Ex86_64 zlib-1.2.11-33.fc36.x86_64
> (gdb) bt
> #0  0x00000000004e742b in __match_glob (str=3D0x0, pat=3D0xe44900 "syscal=
ls", ignore_space=3Dignore_space@entry=3Dfalse, case_ins=3Dcase_ins@entry=
=3Dfalse) at util/string.c:113
> #1  0x00000000004e7830 in strglobmatch (str=3D<optimized out>, pat=3D<opt=
imized out>) at util/string.c:172
> #2  0x00000000004241ea in default_print_event (ps=3D0x7fffffffd370, pmu_n=
ame=3D<optimized out>, topic=3D0x0, event_name=3D0x7fffffffc2d0 "alarmtimer=
:alarmtimer_cancel", event_alias=3D0x0, scale_unit=3D<optimized out>, depre=
cated=3D<optimized out>, event_type_desc=3D<optimized out>,
>     desc=3D<optimized out>, long_desc=3D<optimized out>, encoding_desc=3D=
<optimized out>, metric_name=3D<optimized out>, metric_expr=3D<optimized ou=
t>) at builtin-list.c:107
> #3  0x00000000004e3224 in print_tracepoint_events (print_cb=3Dprint_cb@en=
try=3D0x7fffffffd350, print_state=3D0x7fffffffd370) at util/print-events.c:=
94
> #4  0x0000000000425342 in cmd_list (argc=3D<optimized out>, argv=3D<optim=
ized out>) at builtin-list.c:521
> #5  0x00000000004b4579 in run_builtin (p=3Dp@entry=3D0xdb0490 <commands+2=
40>, argc=3Dargc@entry=3D2, argv=3Dargv@entry=3D0x7fffffffdbb0) at perf.c:3=
22
> #6  0x000000000040f506 in handle_internal_command (argv=3D<optimized out>=
, argc=3D<optimized out>) at perf.c:376
> #7  run_argv (argv=3D<optimized out>, argcp=3D<optimized out>) at perf.c:=
420
> #8  main (argc=3D2, argv=3D0x7fffffffdbb0) at perf.c:550
> (gdb)
>=20
> Trying to fix this now.
>=20
> Please always run 'perf test' before and after your patches and before
> sending it upstream.

Running as !root on a different machine I get some other interesting
info:

=E2=AC=A2[acme@toolbox perf]$  perf list syscalls:sys_enter_open*
double free or corruption (fasttop)
Aborted (core dumped)
=E2=AC=A2[acme@toolbox perf]$

That is:

        free(ps.pmu_glob);


at the end of cmd_list().

- Arnaldo
