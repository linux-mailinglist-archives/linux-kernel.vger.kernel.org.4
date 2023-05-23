Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9B70E031
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjEWPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjEWPQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED201B0;
        Tue, 23 May 2023 08:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7415B60AE7;
        Tue, 23 May 2023 15:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDFEC433D2;
        Tue, 23 May 2023 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684854960;
        bh=wTYbPYYFeklCoO9d6aa3rN/4GrvAtM3y6lLrAxut7Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hysE0ePBNGSAufB+1US8ANtTXFVCrllLsskMvwmssPsojOQY8rFJgpgjVFnjw0rF9
         cxGiRqDOF43y7nmC1qOjWh68Bd1TyCv8ruh5OwAAn/oMEoiuAM2sSt4kb81+NreZpO
         ajwzSTgXfieJTB2eT76sxptz3OdcDGx6fVYyA4bODUhXtsf3YVfQ0Xb9/jHFI3lkpV
         a3WSf7ZQBEuy3gCGNWbciduG1Eu+9QLnyscIqfOpTBXatmiXUpoxt8Kf+f81dNByEp
         3DbO/JDXt1dvOWRw197IVJexsj+3H1tYJJheqXciCOwQ5Txix8pdXssPhMcZB2RfzJ
         p0NF4yEAZhBjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22CB6403B5; Tue, 23 May 2023 12:15:58 -0300 (-03)
Date:   Tue, 23 May 2023 12:15:58 -0300
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
Message-ID: <ZGzYroXZUsPTNZVE@kernel.org>
References: <20230517173805.602113-1-irogers@google.com>
 <20230517173805.602113-15-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517173805.602113-15-irogers@google.com>
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

Em Wed, May 17, 2023 at 10:38:03AM -0700, Ian Rogers escreveu:
> Metrics have a field where the groups they belong to are listed like
> the following from
> tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json:
> 
>         "MetricGroup": "PGO;TmaL1;TopdownL1;tma_L1_group",
>         "MetricName": "tma_frontend_bound",

  LD      /tmp/build/perf-tools-next/util/perf-in.o
  LD      /tmp/build/perf-tools-next/perf-in.o
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
In file included from /var/home/acme/git/perf-tools-next/tools/include/linux/bitmap.h:9,
                 from /var/home/acme/git/perf-tools-next/tools/perf/util/header.h:10,
                 from /tmp/build/perf-tools-next/pmu-events/pmu-events.c:3:
/tmp/build/perf-tools-next/pmu-events/pmu-events.c: In function ‘describe_metricgroup’:
/var/home/acme/git/perf-tools-next/tools/include/linux/kernel.h:102:25: error: overflow in conversion from ‘long unsigned int’ to ‘int’ changes value from ‘18446744073709551615’ to ‘-1’ [-Werror=overflow]
  102 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      |                         ^
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:61603:29: note: in expansion of macro ‘ARRAY_SIZE’
61603 |         int low = 0, high = ARRAY_SIZE(metricgroups) - 1;
      |                             ^~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:679: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

      241752971879      cycles:u
      296060193784      instructions:u                   #    1.22  insn per cycle

       6.129451072 seconds time elapsed

      59.018259000 seconds user
      12.132871000 seconds sys


⬢[acme@toolbox perf-tools-next]$ fg
git rebase -i HEAD~15

[1]+  Stopped                 git rebase -i HEAD~15
⬢[acme@toolbox perf-tools-next]$ git log --oneline -1
995a2beaa64deb7b (HEAD) perf jevents: Add support for metricgroup descriptions
⬢[acme@toolbox perf-tools-next]$

Applied 1-13, pushing to tmp.perf-tools-next,

- Arnaldo
