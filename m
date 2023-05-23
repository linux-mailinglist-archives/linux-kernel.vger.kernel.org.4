Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4621470E558
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbjEWT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjEWT26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:28:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C9120;
        Tue, 23 May 2023 12:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F52634BD;
        Tue, 23 May 2023 19:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AEFC433D2;
        Tue, 23 May 2023 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870135;
        bh=19vYgYezmHEDZ503Xw35qJKsgZ6/tuxVbeCBHpyJVOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hC0f+DtDPENFGPWZCn5GdySYR3D5mGOCeHdSI35gK2uIWsWVjF99/N0VqdgdGYsrR
         1OUT+kBEfL2VG3OUQxdLA+RXPuLrQeQQGoZynp/g7S2+OPgqPhjn5o0CcS1uSQ765W
         lmHdZ0RZ8TcqI/AN9T+h1YKCyC3CeeH9BSUmzevesc20YsGrJuDwHVbbjKzF7lpzH7
         YyPlsmTtBjA4zy3yWlY23TzOWU5GE8YI3xOHOCCYkXMfX0ZUtFzRQUL/nXYZslW04q
         CfJhdN+fPY8vkDzKRyn01JzRqPYC7lsQEwt5U78CwaUpoDDe0/P7FwZkyhEir1G/O7
         EzACWpP4m/DaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4B45403B5; Tue, 23 May 2023 16:28:52 -0300 (-03)
Date:   Tue, 23 May 2023 16:28:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 14/15] perf jevents: Add support for metricgroup
 descriptions
Message-ID: <ZG0T9P8WPBPQiYOm@kernel.org>
References: <20230517173805.602113-1-irogers@google.com>
 <20230517173805.602113-15-irogers@google.com>
 <ZGzYroXZUsPTNZVE@kernel.org>
 <CAP-5=fXKvhqySuomqHU5FMh17N=R-TVoJgLEWU=UgM+HVhSdLQ@mail.gmail.com>
 <ZG0RgAjiqQHoVXQR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZG0RgAjiqQHoVXQR@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 23, 2023 at 04:18:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, May 23, 2023 at 08:58:25AM -0700, Ian Rogers escreveu:
> > Thanks, there's a missing (int) cast on ARRAY_SIZE. It doesn't make
> > sense to resend the entire series so I'll wait to rebase, add the cast
> > and then resend in v2 - that's unless you beat me to it ;-)
 
> I made the amendment below, now lets see why it is not building after
> the next patch is applied...

⬢[acme@toolbox perf-tools-next]$ m
make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
  PERF_VERSION = 6.4.rc1.g11c3a28bd719
  GEN     perf-archive
  GEN     perf-iostat
  GEN     /tmp/build/perf-tools-next/pmu-events/pmu-events.c
  CC      /tmp/build/perf-tools-next/util/header.o
  LD      /tmp/build/perf-tools-next/util/perf-in.o
  LD      /tmp/build/perf-tools-next/perf-in.o
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:23808:39: error: ‘pmu_metrics__amdzen4’ defined but not used [-Werror=unused-const-variable=]
23808 | static const struct compact_pmu_event pmu_metrics__amdzen4[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:23316:39: error: ‘pmu_events__amdzen4’ defined but not used [-Werror=unused-const-variable=]
23316 | static const struct compact_pmu_event pmu_events__amdzen4[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:23300:39: error: ‘pmu_metrics__amdzen3’ defined but not used [-Werror=unused-const-variable=]
23300 | static const struct compact_pmu_event pmu_metrics__amdzen3[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:23054:39: error: ‘pmu_events__amdzen3’ defined but not used [-Werror=unused-const-variable=]
23054 | static const struct compact_pmu_event pmu_events__amdzen3[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:23040:39: error: ‘pmu_metrics__amdzen2’ defined but not used [-Werror=unused-const-variable=]
23040 | static const struct compact_pmu_event pmu_metrics__amdzen2[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:22818:39: error: ‘pmu_events__amdzen2’ defined but not used [-Werror=unused-const-variable=]
22818 | static const struct compact_pmu_event pmu_events__amdzen2[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:22804:39: error: ‘pmu_metrics__amdzen1’ defined but not used [-Werror=unused-const-variable=]
22804 | static const struct compact_pmu_event pmu_metrics__amdzen1[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:22618:39: error: ‘pmu_events__amdzen1’ defined but not used [-Werror=unused-const-variable=]
22618 | static const struct compact_pmu_event pmu_events__amdzen1[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:22061:39: error: ‘pmu_metrics__alderlake’ defined but not used [-Werror=unused-const-variable=]
22061 | static const struct compact_pmu_event pmu_metrics__alderlake[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:21598:39: error: ‘pmu_events__alderlake’ defined but not used [-Werror=unused-const-variable=]
21598 | static const struct compact_pmu_event pmu_events__alderlake[] = {
      |                                       ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:679: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

       22718940299      cycles:u
       55319106422      instructions:u                   #    2.43  insn per cycle

       5.035881599 seconds time elapsed

       5.226416000 seconds user
       1.483357000 seconds sys


⬢[acme@toolbox perf-tools-next]$

Tried cleaning all up and rebuilding, same thing.

Removed the part that touches amd and it gets back building:

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8b03d246bc3b3d0e..6543a68d4a170940 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,3 +1,4 @@
+Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
 GenuineIntel-6-BE,v1.21,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
@@ -32,3 +33,7 @@ GenuineIntel-6-8[CD],v1.12,tigerlake,core
 GenuineIntel-6-2C,v4,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
+AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
+AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
+AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
