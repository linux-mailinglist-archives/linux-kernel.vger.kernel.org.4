Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C66CB003
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjC0UcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjC0UcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:32:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA31FD6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:32:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3e392e10cc4so802561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679949120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8buFQZRwGFYWuvgXw7mTs6dL6p4jwzsNfT9CCqkkZA=;
        b=XQ+WGNLz3dJeMw66PPqfzOvsE2XAhks+3i8XyV2k43cBtb7EdczGg64gF39vCO6tg2
         N0FKgvlJSIa6iY9815LbySCwLB93QMseqUMarU4VqpG0EsbOQus3yedenTauDQ1s38Wp
         osPBUnfiloCadZNqVaxFRRhfEfH19L5/YqknYY3596IPRsCsUDsUXcqtbmKtED59FmKU
         0GAbtgqVMKFKIky9FuPzBfAJQ/Oiiggsp81ctaCkyOxQFDQ2F79hmGWY39Vba96CqEeu
         VfTUKp8WPgHDLYljPTftYHtNB7NP90OMrwcxMjkwVs9kvUUY7XkTWfnRSfur01wqwxki
         0HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679949120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8buFQZRwGFYWuvgXw7mTs6dL6p4jwzsNfT9CCqkkZA=;
        b=OFdarC+rVfu0nXYoZIQW6adS9CdAHrWL1qT1fiXJecyvxTGIMtrFeoZjIriRzMI4LE
         vLWc4yCIN6kazNurWKY9qAvreljle9E3LJVC4eTjOTv91+WSEx/aKYPvVxVbZBZTUjN6
         +pSYfDMC5rNzlwleSTrOJIjX8OM99Zt58aoliW+3CHNsQ47fxTMz7dZO7RNmCSRMtUhs
         bKiizwk7u0cDUlQXNky7DnuwWg1BFCcwaKvTJzwdjrnbc0E2cWbBJR/tyyuJc0UZFCpo
         sxeaQsQKi1waLfzZmCXQk7Fz/RnFPbvot3YI75og/vCL2CHGDLhTsMctUecDv7IbCV9q
         bNRQ==
X-Gm-Message-State: AAQBX9c8mthGSLfQadsHL7KAXKhnJfe78qQbdQISe4Xt6m1AHt7o2FTD
        EC+YoBA77Mxkl6pOo/N98Gfb1MZnPjkd1AbR3O4vVw==
X-Google-Smtp-Source: AKy350YZO8lsOPSUs+lk54v79nIqLBR/D8f0TspIw1KHdh/9jUq0GjTwwuRjEz1NHyU9Pz7L+CfuNdmxNQPnCoi1kBE=
X-Received: by 2002:ac8:7fc3:0:b0:3e2:3de:3732 with SMTP id
 b3-20020ac87fc3000000b003e203de3732mr70271qtk.7.1679949119939; Mon, 27 Mar
 2023 13:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230317095025.49aa34f9@canb.auug.org.au> <20230322083956.5c051777@canb.auug.org.au>
 <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
 <20230323095437.1ecccec1@canb.auug.org.au> <ZBxTyLqkIaoVhIXU@kernel.org>
In-Reply-To: <ZBxTyLqkIaoVhIXU@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Mar 2023 13:31:48 -0700
Message-ID: <CAP-5=fXx=xRfmQFk-MbkdO9SYd3ZgCDfUscO2srfAQU0aThk_A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 6:27=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Mar 23, 2023 at 09:54:37AM +1100, Stephen Rothwell escreveu:
> > Hi Ian,
> >
> > On Wed, 22 Mar 2023 11:37:31 -0700 Ian Rogers <irogers@google.com> wrot=
e:
> > >
> > > On Tue, Mar 21, 2023 at 2:40=E2=80=AFPM Stephen Rothwell <sfr@canb.au=
ug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > On Fri, 17 Mar 2023 09:50:25 +1100 Stephen Rothwell <sfr@canb.auug.=
org.au> wrote:
> > > > >
> > > > > After merging the perf tree, today's linux-next build (native per=
f)
> > > > > failed like this:
> > > > >
> > > > > Auto-detecting system features:
> > > > > ...                         clang-bpf-co-re: [  [32mon [m  ]
> > > > > ...                                    llvm: [  [31mOFF [m ]
> > > > > ...                                  libcap: [  [32mon [m  ]
> > > > > ...                                  libbfd: [  [32mon [m  ]
> > > > >
> > > > > make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vml=
inux.h'
> > > > > libbpf: failed to find '.BTF' ELF section in /boot/vmlinux-6.0.0-=
5-powerpc64le
> > > > > Error: failed to load BTF from /boot/vmlinux-6.0.0-5-powerpc64le:=
 No data available
> > > > > make[1]: *** [Makefile.perf:1075: /home/sfr/next/perf/util/bpf_sk=
el/vmlinux.h] Error 195
> > > > > make[1]: *** Waiting for unfinished jobs....
> > > > > make: *** [Makefile.perf:236: sub-make] Error 2
> > > > > Command exited with non-zero status 2
> > > > >
> > > > > To be clear this is a native build of perf on a PPC64le host usin=
g this
> > > > > command line:
> > > > >
> > > > > make -C tools/perf -f Makefile.perf -s -O -j60 O=3D../perf EXTRA_=
CFLAGS=3D-Wno-psabi
> > > > >
> > > > > (I could probably remove the EXTRA_CLFAGS now that I am building =
with
> > > > > gcc 12.2)
> > > > >
> > > > > I don't know which commit caused this.
> > > > >
> > > > > I have used the perf tree from next-20230316 for today.
> > > >
> > > > I am still getting this build failure.
>
> > > The build failure is intentional as not having BPF skeleton support i=
n
> > > the perf tool will remove features. I've just sent:
> > > https://lore.kernel.org/lkml/20230322183108.1380882-1-irogers@google.=
com/
> > > Which will recommend adding NO_BPF_SKEL=3D1 to your build options whe=
n
> > > this failure occurs. I didn't think a features test was appropriate
> > > for this as the feature test would basically replicate the vmlinux.h
> > > generation and I didn't want to move that support through the build
> > > system.
>
> > I was trying to understand why this step fails, but from the error
> > messages, it seems to require something to be present in the distro
> > supplied kernel image?  Is there something missing from the ppc
> > build process?  Or toolchain?  Why is it looking at the installed
> > kernel and not the built kernel?  Does the perf build now depend on the
> > kernel being built first?
> >
> > I will add NO_BPF_SKEL=3D1 to my build from tomorrow, but surely that
> > means that we miss some perf build testing :-(
>
> Before this BUILD_BPF_SKEL wasn't on by default, so you're back testing
> as much as before.
>
> Having said that, we need to improve the warning and I processed a patch
> from Ian to that extent:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=
=3Dtmp.perf-tools-next&id=3D12a83df53444165d39d3e09fcd9627e7bec7828e
>
>  $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>  ifeq ($(VMLINUX_H),)
> -       $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> +       $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || \
> +       (echo "Failure to generate vmlinux.h needed for the recommended B=
PF skeleton support." && \
> +       echo "To disable this use the build option NO_BPF_SKEL=3D1." && \
> +       echo "Alternatively point at a pre-generated vmlinux.h with VMLIN=
UX_H=3D<path>." && \
> +       false)
>  else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
>
>  Which improves a bit the situation.
>
> We could check if bpftool is available and if not, suggest installing
> it.
>
> If it is available, we could check if /sys/kernel/bpf/ is available, if
> not suggest using a kernel with CONFIG_DEBUG_INFO_BTF=3Dy, as most distro=
s
> have by now.
>
> As to the features this enables:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ ls -la tools/perf/util/bpf_skel/=
*.c
> -rw-r--r--. 1 acme acme 5581 Oct 17 09:07 tools/perf/util/bpf_skel/bperf_=
cgroup.bpf.c
> -rw-r--r--. 1 acme acme 1764 May  5  2022 tools/perf/util/bpf_skel/bperf_=
follower.bpf.c
> -rw-r--r--. 1 acme acme 1438 May  5  2022 tools/perf/util/bpf_skel/bperf_=
leader.bpf.c
> -rw-r--r--. 1 acme acme 2290 May  5  2022 tools/perf/util/bpf_skel/bpf_pr=
og_profiler.bpf.c
> -rw-r--r--. 1 acme acme 2164 May  5  2022 tools/perf/util/bpf_skel/func_l=
atency.bpf.c
> -rw-r--r--. 1 acme acme 9017 Aug 26  2022 tools/perf/util/bpf_skel/kwork_=
trace.bpf.c
> -rw-r--r--. 1 acme acme 9251 Mar 14 08:33 tools/perf/util/bpf_skel/lock_c=
ontention.bpf.c
> -rw-r--r--. 1 acme acme 6109 Feb 27 17:47 tools/perf/util/bpf_skel/off_cp=
u.bpf.c
> -rw-r--r--. 1 acme acme 4310 Mar 15 11:08 tools/perf/util/bpf_skel/sample=
_filter.bpf.c
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> For instance, take a look at these csets:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/uti=
l/bpf_skel/lock_contention.bpf.c
> d24c0144b1dde00f perf lock contention: Show per-cpu rq_lock with address
> 1811e82767dcc6eb perf lock contention: Track and show siglock with addres=
s
> 3ace2435bb93445e perf lock contention: Track and show mmap_lock with addr=
ess
> 17535a33a9c1e4fb perf lock contention: Fix compiler builtin detection
> 1bece1351c653c3d perf lock contention: Support old rw_semaphore type
> 3477f079fe70b3c9 perf lock contention: Add -o/--lock-owner option
> ebab291641bed48f perf lock contention: Support filters for different aggr=
egation
> 5e3febe7b7b99f94 perf lock contention: Support lock addr/name filtering f=
or BPF
> 529772c4df286159 perf lock contention: Support lock type filtering for BP=
F
> 688d2e8de231c54e perf lock contention: Add -l/--lock-addr option
> eca949b2b4addd94 perf lock contention: Implement -t/--threads option for =
BPF
> fd507d3e359c7e06 perf lock contention: Add lock_data.h for common data
> c66a36af7ba3a628 perf lock contention: Do not use BPF task local storage
> 433b31fa00797a2a perf lock contention: Fix a build error on 32-bit
> c1da8dd5c11dabd5 perf lock contention: Skip stack trace from BPF
> 6d499a6b3d90277d perf lock: Print the number of lost entries for BPF
> 6fda2405f414b24a perf lock: Implement cpu and task filters for BPF
> 407b36f69efbdccf perf lock: Use BPF for lock contention analysis
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
>
> or:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline tools/perf/uti=
l/bpf_skel/kwork_trace.bpf.c
> acfb65fe1d11a97f perf kwork: Add workqueue trace BPF support
> 5a81927a407c050a perf kwork: Add softirq trace BPF support
> 420298aefe94840f perf kwork: Add IRQ trace BPF support
> daf07d220710a3c8 perf kwork: Implement BPF trace
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> So we need to fine tune this detection of needed components to build
> these features, in time for the v6.4 merge window, that is why we
> decided  to make this opt-out to hammer out problems.
>
> Other arches probably will hit some of these problems, lets try to
> encourage others to try what is in linux-next.

Just to throw out, perhaps we could ship a vmlinux.h in the perf
source tree. We could also validate it with something similar to the
header file checking. This would remove the bpftool and properly built
kernel issues. It may make a package maintainer's life easier.

Thanks,
Ian

> - Arnaldo
