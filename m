Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869AF6F8A93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEEVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEEVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:15:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48B525D;
        Fri,  5 May 2023 14:15:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bdd7b229cso4424821a12.0;
        Fri, 05 May 2023 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321348; x=1685913348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkXl7THQTcSoWGAdjQDIdbhF6z1BfCF8i0FLGfTc968=;
        b=sRdmQuofItEEH82RKq9MBofo4Nh/ZIFNlsNcDcvk1mVnBErH+TV2IMzo3AzwX5dIZ4
         V+z2Bvj7iSpPPSE8bNCcBzbsm/ipq0/2lqo4V69eIJ9P9YjToAmwg5fj8inUxi0SfTJc
         KMzOx8oXFd7losmEa98OQMkZDE+CJuvVrWV/V+Eu7jd08AOEuHZra0ZMIdzxMz+/zpzu
         N98Jc89YFqH5grcpwsX0LDsq9Z0FOdUdCk6f9sV4YVVjzU8/Q6qqQcUAboY3AYnx+fEU
         Mpm+qxs4i64HWCgPvWLTnrYn6D+FPIazQKm9xA01Pwya9SlEHXwociXtjoxY+uvUsSew
         pn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321348; x=1685913348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkXl7THQTcSoWGAdjQDIdbhF6z1BfCF8i0FLGfTc968=;
        b=ABTQfD2I5ZdZszQNhlqLzyJ3D/gt/GP2bjLd8q5HQoO7HPCEj6KHbDr4mdYhYuWF0F
         ioO9ilXrSghze7Yy9C8x17QAohW4s1mNZTeihyUJ+aq/LFNB44qiAE1GlJeFX7BovBeC
         0C0YvYX73imrP0cZMew7UeA7Wd2xI8zLM5Bs0slolvv8e+ZNX0tqCtjSHS0KcNCnptWq
         iwATymSAw3yLtX5sQtyeHQVuX4HKgxco4wnf/F/J03Fy+sRdjFrVJvqG0yNbnNxgiUoo
         IEKYeyOLrzj40MHhazMmnKGJYqIeitPCmai2NICYrARX6RnoPZYB5HvRMcg4riePnaGA
         NhGg==
X-Gm-Message-State: AC+VfDy7yAIZxCSJAZSrWJaIpmuJ1PDjoVEf+6+UMEYjPo4blipZKM3s
        0af7GUSVXUb477XPyihFJME=
X-Google-Smtp-Source: ACHHUZ6NaJF61Quo7Z5bVO2KqKHPjo+7CAYzBkwf2kQcbGxNZr75jm/rkKTHmD3fgkCr5YL0zmSRGg==
X-Received: by 2002:a17:907:7d9f:b0:94f:7d45:4312 with SMTP id oz31-20020a1709077d9f00b0094f7d454312mr2471434ejc.29.1683321347955;
        Fri, 05 May 2023 14:15:47 -0700 (PDT)
Received: from krava ([83.240.60.209])
        by smtp.gmail.com with ESMTPSA id ss13-20020a170907038d00b009659fed3612sm1384758ejb.24.2023.05.05.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:15:47 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 5 May 2023 23:15:45 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <ZFVyAap3R9RZ+P6u@krava>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 01:46:30PM -0700, Ian Rogers wrote:
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

ah ok, missed that one

thanks,
jirka
