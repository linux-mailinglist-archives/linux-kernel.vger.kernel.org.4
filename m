Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE92A723636
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjFFE0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjFFE0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:26:10 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3E1B3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:26:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33dea7d5424so57395ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 21:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686025566; x=1688617566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ5KIiU+371VE+O6tbV23sC+HS9OsW9UQGsKTvKCpCQ=;
        b=HPjn5qRrsdsv/dZ+nEQLwU1R2JvpW1DqCq0woAZA893EcgFhCWI+Vm9z4DH6pk3C6A
         WyUC6Co0IEX61+Dp3n4/AFK0ozhxtlW96XFbuT+WqqXSZemLBQfhUphcvkokQd3y5cLn
         aKXkRVBZfm9z8GUybulk4eCo/IB25tiiokgclrXf5uqpSLGEc9VSaTlC0Sxj3TMJwdV4
         Ya6qA09PwtK4TDIIDM7cYyFGo/xaci1PY6AztcGznvBOtuORRkGh+gMERvhlsFph+ad8
         JEhJFmoFhKiZSVQowCq9uNdZYg9+MOv7JUdcO9YblLMumQcExSieV1l/jISCxjEUsfjC
         yS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686025566; x=1688617566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQ5KIiU+371VE+O6tbV23sC+HS9OsW9UQGsKTvKCpCQ=;
        b=QbmFMuwOB+32dQgyqO3UhCm+CqfgQ72wYx0VlCW7DJpl/Vrn6jIFh6OWsuZFrqKPp2
         3JEZPqaAR7zk1cAmQupGeFf305MP7fPXsQ6/Wfk4vZjaYs9z3qicEaVdujJOcZcyDxd/
         xxnbL8FsgsllqPKlGAnwjZLCp2o3fE60+dTGKuf73mcrQ5pbUNkEjhR40RHwc/OBS9aZ
         hloAMCPDLMicCXM4uyKYpcffAXDGpK8ABXW9q+YiDcdvn14NRYCEsCBpmlF2YDzLOoPC
         344CwHsHi4yV9EB9ystk5HJApst98W6T5c4fpAzt+RK1ZOqcPstq9/X9E8HZaTjFwmeJ
         /UeQ==
X-Gm-Message-State: AC+VfDyaeOmeIRfviG8Ln+7/sifMN+6G148qBc+vsAEywC9RWB/sdA1Q
        CkwSLNTGdlLf7RvaQhi9MA+rUNSrjytPQBmS04feBw==
X-Google-Smtp-Source: ACHHUZ4Db41GcOQrOCF8YXWvTqVG+NIItyIT/5OGHltHUPxTYHY2nmQSYwHki03XyrK8QlEjOqUDr10qoiYBHQFOq+k=
X-Received: by 2002:a05:6e02:20c5:b0:338:9f6a:d54a with SMTP id
 5-20020a056e0220c500b003389f6ad54amr117548ilq.24.1686025566021; Mon, 05 Jun
 2023 21:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com> <20230605202712.1690876-2-irogers@google.com>
 <ZH6gZgcwAbDrEiqX@krava>
In-Reply-To: <ZH6gZgcwAbDrEiqX@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 21:25:54 -0700
Message-ID: <CAP-5=fWgQDrgDJ_UFuo_G5NaCzR5vWrRyvQ-_qpvFP0p0q18+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf build: Add ability to build with a generated vmlinux.h
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 7:57=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Jun 05, 2023 at 01:27:09PM -0700, Ian Rogers wrote:
> > Commit a887466562b4 ("perf bpf skels: Stop using vmlinux.h generated
> > from BTF, use subset of used structs + CO-RE") made it so that
> > vmlinux.h was uncondtionally included from
> > tools/perf/util/vmlinux.h. This change reverts part of that change (so
> > that vmlinux.h is once again generated) and makes it so that the
> > vmlinux.h used at build time is selected from the VMLINUX_H
> > variable. By default the VMLINUX_H variable is set to the vmlinux.h
> > added in change a887466562b4, but if GEN_VMLINUX_H=3D1 is passed on the
> > build command line then the previous generation behavior kicks in.
> >
> > The build with GEN_VMLINUX_H=3D1 currently fails with:
> > ```
> > util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> > struct rq {};
> >        ^
> > /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous defin=
ition is here
> > struct rq {
> >        ^
> > 1 error generated.
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/perf/Makefile.config                       |  4 ++++
> >  tools/perf/Makefile.perf                         | 16 +++++++++++++++-
> >  tools/perf/util/bpf_skel/.gitignore              |  1 +
> >  tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h |  0
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >  rename tools/perf/util/bpf_skel/{ =3D> vmlinux}/vmlinux.h (100%)
>
> looks good, but I don't understand why you moved the vmlinux.h
>
> jirka

Dumb reason, as headers in the same directory take priority, I had to
move the vmlinux.h out of the directory with the C code for skeletons
so that it could be selected via a -I.

Thanks,
Ian

> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a794d9eca93d..08d4e7eaa721 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -680,6 +680,10 @@ ifdef BUILD_BPF_SKEL
> >    CFLAGS +=3D -DHAVE_BPF_SKEL
> >  endif
> >
> > +ifndef GEN_VMLINUX_H
> > +  VMLINUX_H=3D$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
> > +endif
> > +
> >  dwarf-post-unwind :=3D 1
> >  dwarf-post-unwind-text :=3D BUG
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f48794816d82..f1840af195c0 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1080,7 +1080,21 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
> >       $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
> >               OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
> >
> > -$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_=
OUT)
> > +VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                        =
 \
> > +                  $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> > +                  ../../vmlinux                                      \
> > +                  /sys/kernel/btf/vmlinux                            \
> > +                  /boot/vmlinux-$(shell uname -r)
> > +VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)=
)))
> > +
> > +$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> > +ifeq ($(VMLINUX_H),)
> > +     $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> > +else
> > +     $(Q)cp "$(VMLINUX_H)" $@
> > +endif
> > +
> > +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/v=
mlinux.h | $(SKEL_TMP_OUT)
> >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -Wall -Werror $(BPF_INC=
LUDE) $(TOOLS_UAPI_INCLUDE) \
> >         -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> >
> > diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_=
skel/.gitignore
> > index 7a1c832825de..cd01455e1b53 100644
> > --- a/tools/perf/util/bpf_skel/.gitignore
> > +++ b/tools/perf/util/bpf_skel/.gitignore
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  .tmp
> >  *.skel.h
> > +vmlinux.h
> > diff --git a/tools/perf/util/bpf_skel/vmlinux.h b/tools/perf/util/bpf_s=
kel/vmlinux/vmlinux.h
> > similarity index 100%
> > rename from tools/perf/util/bpf_skel/vmlinux.h
> > rename to tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
