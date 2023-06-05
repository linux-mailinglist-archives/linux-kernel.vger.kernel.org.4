Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB2722F00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFESzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFESzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535AEEC;
        Mon,  5 Jun 2023 11:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC0D960FE1;
        Mon,  5 Jun 2023 18:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2150AC433D2;
        Mon,  5 Jun 2023 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685991344;
        bh=q4xUFuJJJxtPlTsBcWLs26PnVvYd9oytoQvgbXmfY9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXd85FpyeBrPAOlpY4HFTqIB7ntYpRLJbbK6kmAn7qHGP+HdaHYYzmcZ30RDuBKGG
         SnSGDEMoNBj3OVrHmqwh7nh2oc05W9/AwVWeyR5l3QAhCSc1oGUDXNK/M6IzmX5lzp
         8FFH8Ok4uikTpGMxppDNuy0H4KifiGZxBkKJYjomIdePD6X8KGsPobYgQtKvEz4OCI
         zeUhOP6Vby8ZW8dLLLXPli05yeTS1jQk/+m5kKnAdqt9X0YyEiWKNc+a2KcLSVggOE
         wXqJ3XecRcphEQ3tgOvLb6uRDV80mXmVZ/Gfzz07YsiB95dxT7btkHHrY/MrRF2/Zc
         mwTgc9ilEgGjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 220A640692; Mon,  5 Jun 2023 15:55:42 -0300 (-03)
Date:   Mon, 5 Jun 2023 15:55:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Bring back vmlinux.h generation
Message-ID: <ZH4vru4zR8UlIdEN@kernel.org>
References: <20230522204047.800543-1-irogers@google.com>
 <CAEf4BzZ28xz=bUuFoaWRzKjxOEpv2SRJ08rOycDiX0OchGSQEA@mail.gmail.com>
 <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUj9eTGLDxEpc=Xp082O-mQ_4ALp=2VPFHCvAVq8gO-JQ@mail.gmail.com>
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

Em Mon, Jun 05, 2023 at 10:18:51AM -0700, Ian Rogers escreveu:
> On Mon, May 22, 2023 at 4:35 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, May 22, 2023 at 1:41 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> > > satisfy libbpf 'runqueue' type verification") inadvertently created a
> > > declaration of 'struct rq' that conflicted with a generated
> > > vmlinux.h's:
> > >
> > > ```
> > > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > > struct rq {};
> > >        ^
> > > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
> > > struct rq {
> > >        ^
> > > 1 error generated.
> > > ```
> > >
> > > Fix the issue by moving the declaration to vmlinux.h. So this can't
> > > happen again, bring back build support for generating vmlinux.h then
> > > add build tests.
> > >
> > > Ian Rogers (3):
> > >   perf build: Add ability to build with a generated vmlinux.h
> > >   perf bpf: Move the declaration of struct rq
> > >   perf test: Add build tests for BUILD_BPF_SKEL
> > >
> > >  tools/perf/Makefile.config                       |  4 ++++
> > >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> > >  tools/perf/tests/make                            |  4 ++++
> > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > >  tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
> > >  tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h | 10 ++++++++++
> > >  6 files changed, 34 insertions(+), 3 deletions(-)
> > >  rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)
> > >
> > > --
> > > 2.40.1.698.g37aff9b760-goog
> > >
> > >
> >
> > LGTM, for the series:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Arnaldo, could we take this set?

This one isn't applying right now on perf-tools-next.

- Arnaldo
