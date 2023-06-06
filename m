Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3688C724AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbjFFSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjFFSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29678D3;
        Tue,  6 Jun 2023 11:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E6B763072;
        Tue,  6 Jun 2023 18:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F07CC433D2;
        Tue,  6 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686074810;
        bh=5Gv8bpl9Smv7f4Wf/gNDeL5qb+2Vhal7veaGzxxW9h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG+S7N4W92JgGrjQPV20tZXJwqkKGvE12l/vxcYJr5F3byHRofOt40Z0xZ4WUd7vs
         Ybd3CBWKXuhJL7Fk6cv8lrtyNEzc9wGBiVSV0ZEcCelCzSAftmWi0An/bWYqMQx2bZ
         XN14vIY7U61l3V9j1TknTIwF76tMfjHF8OFKWOxGa4yYqQNok5saFHGZWBr4A+MVd5
         RULiciD/ghcvvkcRhrmPyDEIT9MYIODUtIiuje/B6XgD6W+kv4L0STkSamrZZ+eyRS
         Z6b6yo7w5cpSS4Gj2f5n2PItG2DIciZGzDNImvCKr6nL+1QNvrGC+iLE/7XIxacoTN
         JbYl6CPdMFtuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B478440692; Tue,  6 Jun 2023 15:06:16 -0300 (-03)
Date:   Tue, 6 Jun 2023 15:06:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2 1/4] perf build: Add ability to build with a generated
 vmlinux.h
Message-ID: <ZH91mGxFpDPcCFKY@kernel.org>
References: <20230605202712.1690876-1-irogers@google.com>
 <20230605202712.1690876-2-irogers@google.com>
 <ZH6gZgcwAbDrEiqX@krava>
 <CAP-5=fWgQDrgDJ_UFuo_G5NaCzR5vWrRyvQ-_qpvFP0p0q18+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWgQDrgDJ_UFuo_G5NaCzR5vWrRyvQ-_qpvFP0p0q18+w@mail.gmail.com>
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

Em Mon, Jun 05, 2023 at 09:25:54PM -0700, Ian Rogers escreveu:
> On Mon, Jun 5, 2023 at 7:57 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Jun 05, 2023 at 01:27:09PM -0700, Ian Rogers wrote:
> > > Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generated
> > > from BTF, use subset of used structs + CO-RE") made it so that
> > > vmlinux.h was uncondtionally included from
> > > tools/perf/util/vmlinux.h. This change reverts part of that change (so
> > > that vmlinux.h is once again generated) and makes it so that the
> > > vmlinux.h used at build time is selected from the VMLINUX_H
> > > variable. By default the VMLINUX_H variable is set to the vmlinux.h
> > > added in change a887466562b4, but if GEN_VMLINUX_H=1 is passed on the
> > > build command line then the previous generation behavior kicks in.
> > >
> > > The build with GEN_VMLINUX_H=1 currently fails with:
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
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  tools/perf/Makefile.config                       |  4 ++++
> > >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> > >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> > >  tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h |  0
> > >  4 files changed, 20 insertions(+), 1 deletion(-)
> > >  rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (100%)
> >
> > looks good, but I don't understand why you moved the vmlinux.h
> >
> > jirka
> 
> Dumb reason, as headers in the same directory take priority, I had to
> move the vmlinux.h out of the directory with the C code for skeletons
> so that it could be selected via a -I.

Can this be in a separate patch, i.e. moving vmlinux to a separate
directory? I was going to cherry pick the 'struct rq' fix but then it
touches the vmlinux/vmlinux.h file that is in this first patch that has
review comments.

- Arnaldo
 
> Thanks,
> Ian
> 
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index a794d9eca93d..08d4e7eaa721 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
> > >    CFLAGS += -DHAVE_BPF_SKEL
> > >  endif
> > >
> > > +ifndef GEN_VMLINUX_H
> > > +  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
> > > +endif
> > > +
> > >  dwarf-post-unwind := 1
> > >  dwarf-post-unwind-text := BUG
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index f48794816d82..f1840af195c0 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -1080,7 +1080,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
> > >       $(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
> > >               OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
> > >
> > > -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OUT)
> > > +VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                         \
> > > +                  $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > > +                  ../../vmlinux                                      \
> > > +                  /sys/kernel/btf/vmlinux                            \
> > > +                  /boot/vmlinux-$(shell uname -r)
> > > +VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> > > +
> > > +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> > > +ifeq ($(VMLINUX_H),)
> > > +     $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> > > +else
> > > +     $(Q)cp "$(VMLINUX_H)" $@
> > > +endif
> > > +
> > > +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h | $(SKEL_TMP_OUT)
> > >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> > >         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> > >
> > > diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
> > > index 7a1c832825de..cd01455e1b53 100644
> > > --- a/tools/perf/util/bpf_skel/.gitignore
> > > +++ b/tools/perf/util/bpf_skel/.gitignore
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  .tmp
> > >  *.skel.h
> > > +vmlinux.h
> > > diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > similarity index 100%
> > > rename from tools/perf/util/bpf_skel/vmlinux.h
> > > rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > --
> > > 2.41.0.rc0.172.g3f132b7071-goog
> > >

-- 

- Arnaldo
