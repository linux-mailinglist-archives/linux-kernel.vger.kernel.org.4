Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6174F74A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGKReh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGKRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:34:35 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E5E77;
        Tue, 11 Jul 2023 10:34:31 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-47e655e9a9aso2177108e0c.2;
        Tue, 11 Jul 2023 10:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689096870; x=1691688870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHveKtnhu8QuPi05Hn4gQQcWgqPxgrNd+FfX38wdmsE=;
        b=fv8MWKfX7UTLQ5REFdzFz4VtvyuY/qCUOemz8H/S+0X/r6qDGa4fl5/l7TAeS6xeGp
         cUbildRa3x9zZmAWxzr3tgvAgTgCjyRlCmcy4+E9yf3G+EJg6hSpvg1RZ3i9ge+7FP1j
         LN7Y0uOL8MCq6Z/q2JhdIW8tDmdtrM2OD3lzRXchHaIrmJpCZMSKUbsHOEikijX0hJi3
         OtFkAukrnkCHr+ZBohFWAu7kunr9U4DmOP6bR6LY1MDiQB8OYkadKXHbv+KhF8XgB3ZG
         +NUbW9efVbuslAjElzEvULqeNIF2BfLKcmQoUfy/Vnfvd6XmSqDX6S/FU1uNOgDcixqC
         nw5A==
X-Gm-Message-State: ABy/qLbXzkn3GQ4wUPCvhEZ9cCoHTuoThHK7HLbnoHcPJr2gVVpG/KBQ
        uL8V+f1yeaPsv10coH71EUgq5lCcVzkU9V9ayWg=
X-Google-Smtp-Source: APBJJlH4YXSG7vT8mncA1+8Qte/AHKUMyFUk3Kfo51QFm40p7bQ43fRnwDozC38Id8CDhRolTyjp1d6ok/ds8Fzv4/w=
X-Received: by 2002:a1f:d0c2:0:b0:46e:9f33:add1 with SMTP id
 h185-20020a1fd0c2000000b0046e9f33add1mr7825797vkg.6.1689096869880; Tue, 11
 Jul 2023 10:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230706063440.54189-1-sandipan.das@amd.com> <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
 <ZK1sb4tPizTzWq7q@kernel.org>
In-Reply-To: <ZK1sb4tPizTzWq7q@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Jul 2023 10:34:18 -0700
Message-ID: <CAM9d7ci5owtM9h_PjsLo6hNz=kZKDT8PcPFOWX41Vf9g+SnpEQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events amd: Fix large metrics
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, ayush.jain3@amd.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:51 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 06, 2023 at 06:49:29AM -0700, Ian Rogers escreveu:
> > On Wed, Jul 5, 2023 at 11:34 PM Sandipan Das <sandipan.das@amd.com> wrote:
> > >
> > > There are cases where a metric requires more events than the number of
> > > available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
> > > data fabric counters but the "nps1_die_to_dram" metric has eight events.
> > > By default, the constituent events are placed in a group and since the
> > > events cannot be scheduled at the same time, the metric is not computed.
> > > The "all metrics" test also fails because of this.
> > >
> > > Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
> > > the user to run perf with "--metric-no-group".
> > >
> > > E.g.
> > >
> > >   $ sudo perf test -v 101
> > >
> > > Before:
> > >
> > >   101: perf all metrics test                                           :
> > >   --- start ---
> > >   test child forked, pid 37131
> > >   Testing branch_misprediction_ratio
> > >   Testing all_remote_links_outbound
> > >   Testing nps1_die_to_dram
> > >   Metric 'nps1_die_to_dram' not printed in:
> > >   Error:
> > >   Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
> > >   Testing macro_ops_dispatched
> > >   Testing all_l2_cache_accesses
> > >   Testing all_l2_cache_hits
> > >   Testing all_l2_cache_misses
> > >   Testing ic_fetch_miss_ratio
> > >   Testing l2_cache_accesses_from_l2_hwpf
> > >   Testing l2_cache_misses_from_l2_hwpf
> > >   Testing op_cache_fetch_miss_ratio
> > >   Testing l3_read_miss_latency
> > >   Testing l1_itlb_misses
> > >   test child finished with -1
> > >   ---- end ----
> > >   perf all metrics test: FAILED!
> > >
> > > After:
> > >
> > >   101: perf all metrics test                                           :
> > >   --- start ---
> > >   test child forked, pid 43766
> > >   Testing branch_misprediction_ratio
> > >   Testing all_remote_links_outbound
> > >   Testing nps1_die_to_dram
> > >   Testing macro_ops_dispatched
> > >   Testing all_l2_cache_accesses
> > >   Testing all_l2_cache_hits
> > >   Testing all_l2_cache_misses
> > >   Testing ic_fetch_miss_ratio
> > >   Testing l2_cache_accesses_from_l2_hwpf
> > >   Testing l2_cache_misses_from_l2_hwpf
> > >   Testing op_cache_fetch_miss_ratio
> > >   Testing l3_read_miss_latency
> > >   Testing l1_itlb_misses
> > >   test child finished with 0
> > >   ---- end ----
> > >   perf all metrics test: Ok
> > >
> > > Reported-by: Ayush Jain <ayush.jain3@amd.com>
> > > Suggested-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
>
> Thanks, applied.

If I'm not too late..

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
