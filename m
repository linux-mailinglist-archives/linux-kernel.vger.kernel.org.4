Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A538D6F8A62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjEEUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjEEUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F28C2129;
        Fri,  5 May 2023 13:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1281F640A2;
        Fri,  5 May 2023 20:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39750C433EF;
        Fri,  5 May 2023 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683319778;
        bh=W59TR9E32Yah1dFs08dbWyLipmFb+psLrDFRxEQpgnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNMabUPhKyNss7GFEOqyfB6OMpKzdhW+nMaDUdTpEHltfzlk5hxr3llxJ/OfnmpOI
         ExgTNLC+SUY3gwxiXTJGCSGUHdjHcsRhsAaJ5dF9b5TmQwa1H9OYD1BKk8r2w2kGap
         T49SSvrJGIIoh1kokytEQ0IxTaOteXBy9oIXohVlslQKYNrdUngNOLKR5uzoxqz9c8
         BB6XGatN21KTLCr5v7WHgglG0OYwmKHHyR2y0pZAkQf55s37MLzK1zHBXsBdYSn5SI
         2yuizHDwQg0OyUhil5LU2WMBRtI+yZSZ7FKxRVXHUvx8UnGlrBeuhIhUl64a//ZLUG
         y+j65SzycWntg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B04B6403B5; Fri,  5 May 2023 17:49:35 -0300 (-03)
Date:   Fri, 5 May 2023 17:49:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH RFC/RFT] perf bpf skels: Stop using vmlinux.h generated
 from BTF, use subset of used structs + CO-RE. was Re: BPF skels in perf .Re:
 [GIT PULL] perf tools changes for v6.4
Message-ID: <ZFVr38MZLGpBFaUg@kernel.org>
References: <CAEf4BzaUU9vZU6R_020ru5ct0wh-p1M3ZFet-vYqcHvb9bW1Cw@mail.gmail.com>
 <ZFQCccsx6GK+gY0j@kernel.org>
 <ZFQoQjCNtyMIulp+@kernel.org>
 <CAP-5=fU8HQorW+7O6vfEKGs1mEFkjkzXZMVPACzurtcMcRhVzQ@mail.gmail.com>
 <ZFQ5sjjtfEYzvHNP@krava>
 <ZFUFmxDU/6Z/JEsi@kernel.org>
 <ZFU1PJrn8YtHIqno@kernel.org>
 <CAP-5=fWfmmMCRnEmzj_CXTKacp6gjrzmR49Ge_C5XRyfTegRjg@mail.gmail.com>
 <ZFVqeKLssg7uzxzI@krava>
 <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVgJdBvjV8S2xKswAFiSZvyCcUvZTO1bsLyUf-wQ0pBuw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 05, 2023 at 01:46:30PM -0700, Ian Rogers escreveu:
> On Fri, May 5, 2023 at 1:43 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Fri, May 05, 2023 at 10:04:47AM -0700, Ian Rogers wrote:
> > > On Fri, May 5, 2023 at 9:56 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > >
> > > > Em Fri, May 05, 2023 at 10:33:15AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Fri, May 05, 2023 at 01:03:14AM +0200, Jiri Olsa escreveu:
> > > > > That with the preserve_access_index isn't needed, we need just the
> > > > > fields that we access in the tools, right?
> > > >
> > > > I'm now doing build test this in many distro containers, without the two
> > > > reverts, i.e. BPF skels continue as opt-out as in my pull request, to
> > > > test build and also for the functionality tests on the tools using such
> > > > bpf skels, see below, no touching of vmlinux nor BTF data during the
> > > > build.
> > > >
> > > > - Arnaldo
> > > >
> > > > From 882adaee50bc27f85374aeb2fbaa5b76bef60d05 Mon Sep 17 00:00:00 2001
> > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > Date: Thu, 4 May 2023 19:03:51 -0300
> > > > Subject: [PATCH 1/1] perf bpf skels: Stop using vmlinux.h generated from BTF,
> > > >  use subset of used structs + CO-RE
> > > >
> > > > Linus reported a build break due to using a vmlinux without a BTF elf
> > > > section to generate the vmlinux.h header with bpftool for use in the BPF
> > > > tools in tools/perf/util/bpf_skel/*.bpf.c.
> > > >
> > > > Instead add a vmlinux.h file with the structs needed with the fields the
> > > > tools need, marking the structs with __attribute__((preserve_access_index)),
> > > > so that libbpf's CO-RE code can fixup the struct field offsets.
> > > >
> > > > In some cases the vmlinux.h file that was being generated by bpftool
> > > > from the kernel BTF information was not needed at all, just including
> > > > linux/bpf.h, sometimes linux/perf_event.h was enough as non-UAPI
> > > > types were not being used.
> > > >
> > > > To keep te patch small, include those UAPI headers from the trimmed down
> > > > vmlinux.h file, that then provides the tools with just the structs and
> > > > the subset of its fields needed for them.
> > > >
> > > > Testing it:
> > > >
> > > >   # perf lock contention -b find / > /dev/null
> >
> > I tested perf lock con -abv -L rcu_state sleep 1
> > and needed fix below
> >
> > jirka
> 
> I thought this was fixed by:
> https://lore.kernel.org/lkml/20230427234833.1576130-1-namhyung@kernel.org/
> but I think that is just in perf-tools-next.

Nope, we have it in perf-tools:

commit e53de7b65a3ca59af268c78df2d773f277f717fd
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Apr 27 16:48:32 2023 -0700

    perf lock contention: Fix struct rq lock access
