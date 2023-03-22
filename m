Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A252B6C5389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCVSTF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 14:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:19:04 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C99B476;
        Wed, 22 Mar 2023 11:19:01 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id o14so8889776ioa.3;
        Wed, 22 Mar 2023 11:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509140;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xtlNayJq877PgHIz4rjDi+sIkC5iTw16ABJw2oyXYs=;
        b=mxRaRCgUfZ3bIuVnCzi+1LcTukgx2oQ2q5885YQmyHebxHKlFwRep+uf7HTkMTbQjz
         uuIdj237MI2BmI8P5npEo2Jyi8G0uA6isE5K09aa/cvbiQVgAOjh1+H3LMdFrAtibPOG
         H+X/HFK5s2VVnj3H8IDomYIs329M+P+XWRqZ3WFzeUVm0oKyUk2kJz9zf4ZR07dNtDDT
         mYrsQmwuwHGTt2Rlfxu1Y7cCb51oT5eTuOtCEO9kjSNoOFD3J6iRj90t59crnyQyNgVp
         N0YJ2TycSW0xDm1Iue1zL8KYxr+/9s/c7iAh0cK6lwgepkX8xbd1C3M1A+oHunrPkvRZ
         Z6qg==
X-Gm-Message-State: AO0yUKUErzFUZAMZwHtupvnmZfsGQu+HM/XYZAuOzPsDoOESv5LH5tlw
        BsYBGu8RGljoCOsMI0tn4IecjpXBrACTweyDzqQ=
X-Google-Smtp-Source: AK7set8QQ7FoQwXShxGXYywTqxF7CCBwLi5REnJTyBmAD6dtSDAt4fyHYa5zlEqbJJoK5iqA17fHzLpAklXAML9dH9M=
X-Received: by 2002:a5e:d801:0:b0:758:7798:2456 with SMTP id
 l1-20020a5ed801000000b0075877982456mr4149365iok.6.1679509140360; Wed, 22 Mar
 2023 11:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230316133557.868731-1-asavkov@redhat.com> <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
In-Reply-To: <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Mar 2023 11:18:49 -0700
Message-ID: <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
>
> On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
> > >
> > > In an email to Arnaldo Andrii Nakryiko suggested that perf can get
> > > information about inlined functions from dwarf when available and then
> > > add it to userspace stacktraces even in framepointer or lbr mode.
> > > Looking closer at perf it turned out all required bits and pieces are
> > > already there and inline information can be easily added to both
> > > framepointer and lbr callchains by adding an append_inlines() call to
> > > add_callchain_ip().
> >
> > Looks great!  Have you checked it with perf report -g callee ?
> > I'm not sure the ordering of inlined functions is maintained
> > properly.  Maybe you can use --no-children too to simplify
> > the output.
>
> Thanks for the suggestion. I actually have another test program with
> functions being numbered rather than (creatively) named, so it might be
> easier to use it to figure out ordering. Here's the code:

Yep, looks good.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> ======
> #include <stdio.h>
> #include <stdint.h>
>
> static __attribute__((noinline)) uint32_t func5(uint32_t i)
> {
>         return i + 10;
> }
>
> static uint32_t func4(uint32_t i)
> {
>         return func5(i + 5);
> }
>
> static inline uint32_t func3(uint32_t i)
> {
>         return func4(i + 4);
> }
>
> static __attribute__((noinline)) uint32_t func2(uint32_t i)
> {
>         return func3(i + 3);
> }
>
> static uint32_t func1(uint32_t i)
> {
>         return func2(i + 2);
> }
>
> __attribute__((noinline)) uint64_t entry(void)
> {
>         uint64_t ret = 0;
>         uint32_t i = 0;
>         for (i = 0; i < 1000000; i++) {
>                 ret += func1(i);
>                 ret -= func2(i);
>                 ret += func3(i);
>                 ret += func4(i);
>                 ret -= func5(i);
>         }
>         return ret;
> }
>
> int main(int argc, char **argv)
> {
>         printf("%s\n", __func__);
>         return entry();
> }
> ======
>
> Here is the output I get with '--call-graph callee --no-children'
> ======
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 250  of event 'cycles:u'
> # Event count (approx.): 26819859
> #
> # Overhead  Command  Shared Object         Symbol
> # ........  .......  ....................  .....................................
> #
>     43.58%  a.out    a.out                 [.] func5
>             |
>             |--28.93%--entry
>             |          main
>             |          __libc_start_call_main
>             |
>              --14.65%--func4 (inlined)
>                        |
>                        |--10.45%--entry
>                        |          main
>                        |          __libc_start_call_main
>                        |
>                         --4.20%--func3 (inlined)
>                                   entry
>                                   main
>                                   __libc_start_call_main
>
>     38.80%  a.out    a.out                 [.] entry
>             |
>             |--23.27%--func4 (inlined)
>             |          |
>             |          |--20.28%--func3 (inlined)
>             |          |          func2
>             |          |          main
>             |          |          __libc_start_call_main
>             |          |
>             |           --2.99%--entry
>             |                     main
>             |                     __libc_start_call_main
>             |
>             |--8.17%--func5
>             |          main
>             |          __libc_start_call_main
>             |
>             |--3.89%--func1 (inlined)
>             |          entry
>             |          main
>             |          __libc_start_call_main
>             |
>              --3.48%--entry
>                        main
>                        __libc_start_call_main
>
>     13.07%  a.out    a.out                 [.] func2
>             |
>             ---func5
>                main
>                __libc_start_call_main
>
>      1.54%  a.out    [unknown]             [k] 0xffffffff81e011b7
>      1.16%  a.out    [unknown]             [k] 0xffffffff81e00193
>             |
>              --0.57%--__mmap64 (inlined)
>                        __mmap64 (inlined)
>
>      0.34%  a.out    ld-linux-x86-64.so.2  [.] __tunable_get_val
>      0.34%  a.out    ld-linux-x86-64.so.2  [.] strcmp
>      0.32%  a.out    libc.so.6             [.] strchr
>      0.31%  a.out    ld-linux-x86-64.so.2  [.] _dl_relocate_object
>      0.22%  a.out    ld-linux-x86-64.so.2  [.] _dl_init_paths
>      0.18%  a.out    ld-linux-x86-64.so.2  [.] get_common_cache_info.constprop.0
>      0.14%  a.out    ld-linux-x86-64.so.2  [.] __GI___tunables_init
>
>
> #
> # (Tip: Show individual samples with: perf script)
> #
> ======
>
> It does not seem to be out of order, or at least it is consistent with
> what I get with dwarf unwinders.
>
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > I used the following small program for testing:
> > >
> > > ======
> > > #include <stdio.h>
> > > #include <stdint.h>
> > >
> > > static __attribute__((noinline)) uint32_t func_noinline2(uint32_t i)
> > > {
> > >         return i + 10;
> > > }
> > >
> > > static inline uint32_t func_declared_inlined(uint32_t i)
> > > {
> > >         return func_noinline2(i + 4);
> > > }
> > >
> > > static __attribute__((noinline)) uint32_t func_noinline(uint32_t i)
> > > {
> > >         return func_declared_inlined(i + 3);
> > > }
> > >
> > > static uint32_t func_inlined(uint32_t i)
> > > {
> > >         return func_noinline(i + 2);
> > > }
> > >
> > > int main(int argc, char **argv)
> > > {
> > >         uint64_t ret = 0;
> > >         uint32_t i = 0;
> > >
> > >         for (i = 0; i < 10000000; i++) {
> > >                 ret += func_inlined(i);
> > >                 ret -= func_noinline(i);
> > >                 ret -= func_noinline2(i);
> > >                 ret += func_declared_inlined(i);
> > >         }
> > >
> > >         printf("%s: %ld\n", __func__, ret);
> > >         return ret;
> > > }
> > > ======
> > >
> > > When built with "gcc -Wall -fno-omit-frame-pointer -O2 -g" (gcc
> > > version 12.2.1 20221121 (Red Hat 12.2.1-4) (GCC)) it results in
> > > func_inlined() and func_declared_inlined() being inlined into main()
> > > and func_declared_inlined() also being inlined into func_noinline().
> > >
> > > Here are the diffs for 'perf report --call-graph --stdio' output before
> > > and after the patch:
> > >
> > > Frame-pointer mode recorded with 'perf record --call-graph=fp --freq=max -- ./a.out'
> > > ======
> > > --- unpatched.fp        2023-03-16 13:27:22.724017900 +0100
> > > +++ patched.fp  2023-03-16 13:27:28.608857921 +0100
> > > @@ -14,18 +14,24 @@
> > >              ---__libc_start_call_main
> > >                 |
> > >                 |--46.31%--main
> > > +               |          |
> > > +               |           --11.16%--func_declared_inlined (inlined)
> > >                 |
> > >                 |--27.41%--func_noinline
> > > +               |          func_declared_inlined (inlined)
> > >                 |
> > >                  --25.68%--func_noinline2
> > >
> > >      85.71%    39.64%  a.out    a.out                 [.] main
> > >              |
> > >              |--46.07%--main
> > > +            |          |
> > > +            |           --11.16%--func_declared_inlined (inlined)
> > >              |
> > >               --39.64%--__libc_start_call_main
> > >                         |
> > >                         |--27.17%--func_noinline
> > > +                       |          func_declared_inlined (inlined)
> > >                         |
> > >                          --12.23%--func_noinline2
> > >
> > > @@ -34,31 +40,47 @@
> > >              |--46.31%--__libc_start_call_main
> > >              |          |
> > >              |           --46.07%--main
> > > +            |                     |
> > > +            |                      --11.16%--func_declared_inlined (inlined)
> > >              |
> > >               --25.44%--func_noinline2
> > >
> > >      40.56%    13.39%  a.out    a.out                 [.] func_noinline
> > >              |
> > >              |--27.17%--func_noinline
> > > +            |          func_declared_inlined (inlined)
> > >              |
> > >               --13.39%--__libc_start_call_main
> > >                         |
> > >                          --13.15%--func_noinline2
> > >
> > > +    27.41%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
> > > +            |
> > > +            ---func_declared_inlined (inlined)
> > > +
> > > +    11.16%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
> > > +            |
> > > +            ---func_declared_inlined (inlined)
> > > +
> > >       0.30%     0.30%  a.out    [unknown]             [k] 0xffffffff81e011b7
> > >       0.27%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start_user
> > >       0.25%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_sysdep_start
> > >       0.20%     0.00%  a.out    ld-linux-x86-64.so.2  [.] dl_main
> > >       0.19%     0.19%  a.out    [unknown]             [k] 0xffffffff81e00193
> > > +     0.18%     0.00%  a.out    a.out                 [.] func_inlined (inlined)
> > >       0.10%     0.05%  a.out    ld-linux-x86-64.so.2  [.] _dl_relocate_object
> > >       0.09%     0.00%  a.out    [unknown]             [k] 0x00007fef811be880
> > >       0.09%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_map_object
> > >       0.06%     0.00%  a.out    libc.so.6             [.] sysmalloc
> > >       0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] munmap
> > > -     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] mprotect
> > > +     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] rtld_timer_accum (inlined)
> > > +     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] rtld_timer_stop (inlined)
> > > +     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] __mprotect (inlined)
> > >       0.05%     0.00%  a.out    libc.so.6             [.] __x86_cacheinfo_ifunc
> > > +     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] elf_dynamic_do_Rela (inlined)
> > >       0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_map_object_from_fd
> > > -     0.04%     0.00%  a.out    ld-linux-x86-64.so.2  [.] mmap64
> > > +     0.05%     0.00%  a.out    ld-linux-x86-64.so.2  [.] elf_get_dynamic_info (inlined)
> > > +     0.04%     0.00%  a.out    ld-linux-x86-64.so.2  [.] __mmap64 (inlined)
> > >       0.04%     0.04%  a.out    ld-linux-x86-64.so.2  [.] _dl_cache_libcmp
> > >       0.04%     0.00%  a.out    [unknown]             [.] 0x000000000001b19a
> > >       0.04%     0.00%  a.out    [unknown]             [k] 0000000000000000
> > > @@ -66,13 +88,15 @@
> > >       0.04%     0.04%  a.out    ld-linux-x86-64.so.2  [.] do_lookup_x
> > >       0.03%     0.03%  a.out    ld-linux-x86-64.so.2  [.] intel_check_word.constprop.0
> > >       0.03%     0.00%  a.out    [unknown]             [.] 0x0000000004000000
> > > +     0.03%     0.00%  a.out    ld-linux-x86-64.so.2  [.] intel_check_word (inlined)
> > >       0.02%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start
> > >       0.02%     0.02%  a.out    ld-linux-x86-64.so.2  [.] __GI___tunables_init
> > >       0.02%     0.00%  a.out    [unknown]             [.] 0x722f3d4b434f535f
> > >       0.02%     0.00%  a.out    [unknown]             [.] 0x00007ffebdd69f59
> > > +     0.02%     0.00%  a.out    ld-linux-x86-64.so.2  [.] tunable_is_name (inlined)
> > >       0.01%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _start
> > > ======
> > >
> > > LBR mode recorded with 'perf record --call-graph=lbr -- ./a.out'
> > > ======
> > > --- unpatched.lbr       2023-03-16 13:27:50.853253211 +0100
> > > +++ patched.lbr 2023-03-16 13:27:56.312104813 +0100
> > > @@ -6,58 +6,95 @@
> > >  # Samples: 238  of event 'cycles:u'
> > >  # Event count (approx.): 193485873
> > >  #
> > > -# Children      Self  Command  Shared Object         Symbol
> > > -# ........  ........  .......  ....................  .................................
> > > +# Children      Self  Command  Shared Object         Symbol
> > > +# ........  ........  .......  ....................  .............................
> > >  #
> > >      99.11%    36.87%  a.out    a.out                 [.] main
> > >              |
> > >              |--62.24%--main
> > >              |          |
> > > -            |           --17.47%--func_noinline
> > > +            |          |--11.05%--func_inlined (inlined)
> > > +            |          |          func_noinline
> > > +            |          |          func_declared_inlined (inlined)
> > > +            |          |
> > > +            |           --6.42%--func_noinline
> > > +            |                     func_declared_inlined (inlined)
> > >              |
> > >               --36.87%--_start
> > > -                       __libc_start_main@@GLIBC_2.34
> > > +                       __libc_start_main_alias_2 (inlined)
> > >                         __libc_start_call_main
> > >                         main
> > >                         |
> > > -                       |--24.52%--func_noinline
> > > +                       |--17.51%--func_inlined (inlined)
> > > +                       |          func_noinline
> > > +                       |          func_declared_inlined (inlined)
> > > +                       |
> > > +                       |--8.45%--func_noinline2
> > >                         |
> > > -                        --10.01%--func_noinline2
> > > +                       |--7.01%--func_noinline
> > > +                       |          func_declared_inlined (inlined)
> > > +                       |
> > > +                        --1.57%--func_declared_inlined (inlined)
> > > +                                  func_noinline2
> > >
> > >      99.11%     0.00%  a.out    a.out                 [.] _start
> > >              |
> > >              ---_start
> > > -               __libc_start_main@@GLIBC_2.34
> > > +               __libc_start_main_alias_2 (inlined)
> > >                 __libc_start_call_main
> > >                 main
> > >                 |
> > > -               |--41.99%--func_noinline
> > > +               |--28.55%--func_inlined (inlined)
> > > +               |          func_noinline
> > > +               |          func_declared_inlined (inlined)
> > > +               |
> > > +               |--13.43%--func_noinline
> > > +               |          func_declared_inlined (inlined)
> > >                 |
> > > -                --10.37%--func_noinline2
> > > +               |--8.81%--func_noinline2
> > > +               |
> > > +                --1.57%--func_declared_inlined (inlined)
> > > +                          func_noinline2
> > >
> > > -    99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_main@@GLIBC_2.34
> > > +    99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_main_alias_2 (inlined)
> > >              |
> > > -            ---__libc_start_main@@GLIBC_2.34
> > > +            ---__libc_start_main_alias_2 (inlined)
> > >                 __libc_start_call_main
> > >                 main
> > >                 |
> > > -               |--41.99%--func_noinline
> > > +               |--28.55%--func_inlined (inlined)
> > > +               |          func_noinline
> > > +               |          func_declared_inlined (inlined)
> > > +               |
> > > +               |--13.43%--func_noinline
> > > +               |          func_declared_inlined (inlined)
> > > +               |
> > > +               |--8.81%--func_noinline2
> > >                 |
> > > -                --10.37%--func_noinline2
> > > +                --1.57%--func_declared_inlined (inlined)
> > > +                          func_noinline2
> > >
> > >      99.11%     0.00%  a.out    libc.so.6             [.] __libc_start_call_main
> > >              |
> > >              ---__libc_start_call_main
> > >                 main
> > >                 |
> > > -               |--41.99%--func_noinline
> > > +               |--28.55%--func_inlined (inlined)
> > > +               |          func_noinline
> > > +               |          func_declared_inlined (inlined)
> > >                 |
> > > -                --10.37%--func_noinline2
> > > +               |--13.43%--func_noinline
> > > +               |          func_declared_inlined (inlined)
> > > +               |
> > > +               |--8.81%--func_noinline2
> > > +               |
> > > +                --1.57%--func_declared_inlined (inlined)
> > > +                          func_noinline2
> > >
> > >      54.44%    44.43%  a.out    a.out                 [.] func_noinline2
> > >              |
> > >              |--44.43%--_start
> > > -            |          __libc_start_main@@GLIBC_2.34
> > > +            |          __libc_start_main_alias_2 (inlined)
> > >              |          __libc_start_call_main
> > >              |          main
> > >              |
> > > @@ -66,19 +103,42 @@
> > >      41.99%    17.47%  a.out    a.out                 [.] func_noinline
> > >              |
> > >              |--24.52%--func_noinline
> > > +            |          func_declared_inlined (inlined)
> > >              |
> > >               --17.47%--_start
> > > -                       __libc_start_main@@GLIBC_2.34
> > > +                       __libc_start_main_alias_2 (inlined)
> > >                         __libc_start_call_main
> > >                         main
> > > -                       func_noinline
> > > +                       |
> > > +                       |--11.05%--func_inlined (inlined)
> > > +                       |          func_noinline
> > > +                       |          func_declared_inlined (inlined)
> > > +                       |
> > > +                        --6.42%--func_noinline
> > > +                                  func_declared_inlined (inlined)
> > > +
> > > +    41.99%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
> > > +            |
> > > +            ---func_declared_inlined (inlined)
> > > +
> > > +    28.55%     0.00%  a.out    a.out                 [.] func_inlined (inlined)
> > > +            |
> > > +            ---func_inlined (inlined)
> > > +               func_noinline
> > > +               func_declared_inlined (inlined)
> > > +
> > > +     1.57%     0.00%  a.out    a.out                 [.] func_declared_inlined (inlined)
> > > +            |
> > > +            ---func_declared_inlined (inlined)
> > > +               func_noinline2
> > >
> > >       0.88%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _start
> > >              |
> > >              ---_start
> > >                 _dl_start
> > >                 |
> > > -                --0.71%--_dl_sysdep_start
> > > +                --0.71%--_dl_start_final (inlined)
> > > +                          _dl_sysdep_start
> > >                            dl_main
> > >                            _dl_map_object_deps
> > >                            _dl_catch_exception
> > > @@ -92,7 +152,8 @@
> > >              |
> > >              ---_dl_start
> > >                 |
> > > -                --0.71%--_dl_sysdep_start
> > > +                --0.71%--_dl_start_final (inlined)
> > > +                          _dl_sysdep_start
> > >                            dl_main
> > >                            _dl_map_object_deps
> > >                            _dl_catch_exception
> > > @@ -106,6 +167,20 @@
> > >              |
> > >              ---_start
> > >                 _dl_start
> > > +               _dl_start_final (inlined)
> > > +               _dl_sysdep_start
> > > +               dl_main
> > > +               _dl_map_object_deps
> > > +               _dl_catch_exception
> > > +               openaux
> > > +               _dl_map_object
> > > +               _dl_map_object_from_fd
> > > +               _dl_new_object
> > > +               strlen
> > > +
> > > +     0.71%     0.00%  a.out    ld-linux-x86-64.so.2  [.] _dl_start_final (inlined)
> > > +            |
> > > +            ---_dl_start_final (inlined)
> > >                 _dl_sysdep_start
> > >                 dl_main
> > >                 _dl_map_object_deps
> > > ======
> > >
> > > No meaningful differences in output with callchains in dwarf mode or when
> > > tracing a binary that was compiled with no dwarf debuginfo.
> > >
> > > Artem Savkov (1):
> > >   perf report: append inlines to non-dwarf callchains
> > >
> > >  tools/perf/util/machine.c | 82 ++++++++++++++++++++-------------------
> > >  1 file changed, 43 insertions(+), 39 deletions(-)
> > >
> > > --
> > > 2.39.2
> > >
> >
>
> --
>  Artem
>
