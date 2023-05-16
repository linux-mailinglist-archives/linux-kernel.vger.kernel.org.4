Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D97055DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjEPSTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjEPSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D88A26F;
        Tue, 16 May 2023 11:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879DF635B4;
        Tue, 16 May 2023 18:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F90C433EF;
        Tue, 16 May 2023 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684261157;
        bh=wRq8nQddeWhoPivNXCSKifiwZm67mGPCeR+slQWnKYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfCxHSDieDNxrfVV0mGa5eMSQigfMaUOUC33zftz9AsqM4jo4HALm5pqZxDqL3RK8
         GXZ2NTV1KigA9XiTwNK88zlF2CkhSmeWQVZbxa5K3u5fYhx9BnPngVQdHVGXhKSOd6
         tphoG36oIHhQrssSSABIbEaNR9UeU4hPZw8md/g2X/2C+N2WR+vlUzeN0tyQZtsPyJ
         rgaFtyDBXCCCWDaKOS+HEvR8da199/ZKIOqCIeKea5t4Fshz6M++vkoNNff9oS+eMj
         6M8Jg8eRN05uRrfgSskM7mLUJG3rURroVJEqCdOTGgKeAJMljmTmfRCFLgY864wuBG
         hbpfawLigkLLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0785F403B5; Tue, 16 May 2023 15:19:15 -0300 (-03)
Date:   Tue, 16 May 2023 15:19:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/44] Fix perf on Intel hybrid CPUs
Message-ID: <ZGPJIjKby9EqrdJF@kernel.org>
References: <20230502223851.2234828-1-irogers@google.com>
 <b8f03c40-d238-2ce9-5b50-bd9e1465be23@linux.intel.com>
 <ZF6GkU6Le8bxex2O@kernel.org>
 <b1fb8f09-17d7-45c2-6f8d-0756cd09fe77@linux.intel.com>
 <CAP-5=fUc7mcEurwCBxZ_Dx=1pARynyra5Psi3J_OVk9JCXYMcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUc7mcEurwCBxZ_Dx=1pARynyra5Psi3J_OVk9JCXYMcA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 03:49:45PM -0700, Ian Rogers escreveu:
> On Sun, May 14, 2023 at 5:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > - Segmentation fault with perf stat --topdown on ADL (hybrid) and
> > Cascade Lake.
> >   It looks like a legacy issue, may not be introduced by this patch set.
> >   Here is the backtrace. It looks like there is a NULL metric_group.
> >
> > (gdb) backtrace
> > #0  0x00007ffff73035d1 in __strstr_sse2_unaligned () from /lib64/libc.so.6
> > #1  0x00000000004f9019 in metricgroup__topdown_max_level_callback
> > (pm=<optimized out>, table=<optimized out>,
> >     data=0x7fffffff92f4) at util/metricgroup.c:1722
> > #2  0x00000000005e8a31 in pmu_metrics_table_for_each_metric
> > (table=0xcb74d0 <pmu_events_map+368>,
> >     fn=fn@entry=0x4f8ff0 <metricgroup__topdown_max_level_callback>,
> > data=data@entry=0x7fffffff92f4)
> >     at pmu-events/pmu-events.c:61123
> > #3  0x00000000004fbc3b in metricgroups__topdown_max_level () at
> > util/metricgroup.c:1742
> > #4  0x000000000042c135 in add_default_attributes () at builtin-stat.c:1845
> > #5  cmd_stat (argc=0, argv=0x7fffffffe3e0) at builtin-stat.c:2446
> > #6  0x00000000004b922b in run_builtin (p=p@entry=0xd5c530
> > <commands+336>, argc=argc@entry=2,
> >     argv=argv@entry=0x7fffffffe3e0) at perf.c:323
> > #7  0x000000000040e373 in handle_internal_command (argv=0x7fffffffe3e0,
> > argc=2) at perf.c:377
> > #8  run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at
> > perf.c:421
> > #9  main (argc=2, argv=0x7fffffffe3e0) at perf.c:537
> > (gdb)
> 
> Thanks, there's a 1-liner for the segv:
> https://lore.kernel.org/lkml/20230515224530.671331-1-irogers@google.com/
> Arnaldo, can we make sure this goes toward the next 6.4 release candidate?

Sure.

- Arnaldo
