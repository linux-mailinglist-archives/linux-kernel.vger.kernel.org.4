Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B640D7049B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjEPJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjEPJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:51:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CD2D6B;
        Tue, 16 May 2023 02:51:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso9972608a91.1;
        Tue, 16 May 2023 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684230660; x=1686822660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcxyAPt39sn9GORzea7cnK15kWOq11c26JDT+pCH20w=;
        b=MZOFCHvAbw66oxWJYhjy0ltmzCyGDTlHc/oIX04/RZ8gn8jRjcYzSl+qNqFfaTI78q
         N5/dBMYsiwc79fuwBU+jNUPSYubcA7VB0JrvqOwy3xHmhM45xduBSXJypxCjpXdNQnyh
         MRuliixd07W4G8csFcnKkF19ker5mAqoFzkltPvfVzIx/Zujgi/qaL0DWU0dbBtwbqnS
         6/NQdn7qJhEhZDB66hYkAnX/Ozcjnb0btIoCtW9qQvy8iPw8ykm95X2fEK40d3fXlZte
         D7tQOLbFyCeeTldocO/P3ETr2Zy5A0Zx1G4oIjrCtTacitNiRhyfw4bpG8TOqU7O+SEO
         LWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230660; x=1686822660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcxyAPt39sn9GORzea7cnK15kWOq11c26JDT+pCH20w=;
        b=dq27EsOIryvOaP6GIcdmphTYF0n/jNr9yL0ONfwhgUaukYGfAa9kIJVtLoUySj+/6C
         iTV/PcX57XOYr6OKp7+42Ctc5XAGMQmE39Z7ODK8wBJ7G91DBSzTyObdenqvdxjMy/8/
         kWYKHXX8ObkmJoKY0Ja0G6ozPperjvYaVDD3N9MMFYlRTaP36GbXC0UVE7YpT02BU04T
         w6ey9vakooMDECMmt2x3UfPbXek2GBNTfVyDvydAM6iWFsAL6iD6NSFn3Izol95tUwKw
         iHzZ3/OKymeb6m9Mda/VR26AX1EISOGxzX8YMizcIy4Z4gAeqCcjZzqEiqRPuFIzwTbT
         3njw==
X-Gm-Message-State: AC+VfDz6Qi3PjMolBOwbX/QgPy/LZcZKwE8CI6PsdX+LSctiacbk5n5F
        esd/QpJkcGL467rn5TIhSwWzBakQXxb4jtKRvnQ=
X-Google-Smtp-Source: ACHHUZ5aOt/63nUiIejFy2YvLjIRbKfJiasgGbEFCs6EwdIX9j/zlKuSEoKtZOfU1zH/2yQk5605E03kehPlwG+WwF0=
X-Received: by 2002:a17:90a:290e:b0:23c:fef0:d441 with SMTP id
 g14-20020a17090a290e00b0023cfef0d441mr37344684pjd.33.1684230659607; Tue, 16
 May 2023 02:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
In-Reply-To: <20230511093234.3123181-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 16 May 2023 09:50:47 +0000
Message-ID: <CAAYs2=jWwpFzjNqMmyefy6-JEVswfba5MkhaCJ0gvH0bK6zuug@mail.gmail.com>
Subject: Re: [PATCH V10 0/4] riscv: Optimize function trace
To:     palmer@dabbelt.com
Cc:     mark.rutland@arm.com, bjorn@rivosinc.com, e.shatokhin@yadro.com,
        jszhang@kernel.org, suagrfillet@gmail.com, guoren@kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=9B=9B 09:32=E5=86=99=E9=81=93=EF=BC=9A

>
> Changes in v10:
>
> - add Acked-by from Bj=C3=B6rn T=C3=B6pel in patch 2 and patch 4
> - replace `move` with `mv` in patch3
> - prettify patch 2/4 with proper tabs
>
> You can directly try it with:
>
> https://github.com/sugarfillet/linux/tree/6.4-rc1-rv-ftrace-v10
>
>
Hi, plamer:
This series is ready for its acceptance, you can pick it up.

> This series optimizes function trace. The first 3 independent
> patches has been picked in the V7 version of this series, the
> subsequent version continues the following 4 patches:
>
> select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1] (patch 1)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
>
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
>
> Make function graph use ftrace directly [2] (patch 2)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> In RISC-V architecture, when we enable the ftrace_graph tracer on some
> functions, the function tracings on other functions will suffer extra
> graph tracing work. In essence, graph_ops isn't limited by its func_hash
> due to the global ftrace_graph_[regs]_call label. That should be
> corrected.
>
> What inspires me is the commit 0c0593b45c9b ("x86/ftrace: Make function
> graph use ftrace directly") that uses graph_ops::func function to
> install return_hooker and makes the function called against its
> func_hash.
>
> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
> SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
> here as the samples for testing DIRECT_CALLS related interface.
>
> First, select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide
> register_ftrace_direct[_multi] interfaces allowing user to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modify direct_caller.
>
> At the same time, the samples in ./samples/ftrace/ can be built
> as kerenl module for testing these interfaces with SAMPLE_FTRACE_DIRECT
> and SAMPLE_FTRACE_DIRECT_MULTI selected.
>
> Second, to make the direct_caller and the other ftrace hooks
> (eg. function/fgraph tracer, k[ret]probes) co-exist, a temporary
> register
> are nominated to store the address of direct_caller in
> ftrace_regs_caller.
> After the setting of the address direct_caller by direct_ops->func and
> the RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> The series's old changes related these patches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Changes in v9:
> https://lore.kernel.org/linux-riscv/20230510101857.2953955-1-suagrfillet@=
gmail.com/
>
> 1. add Acked-by from Bj=C3=B6rn T=C3=B6pel in patch 1
>
> 2. rebase patch2/patch3 on Linux v6.4-rc1
>
>   - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
>     modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
> entry: Consolidate general regs saving/restoring")
>
>   - patch 3: to pass the trace_selftest, add the implement of
>     `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
> selftest: remove broken trace_direct_tramp") ; and fixup the context
> conflict in Kconfig
>
> Changes in v8:
> https://lore.kernel.org/linux-riscv/20230324033342.3177979-1-suagrfillet@=
gmail.com/
>  - Fix incorrect address values in the 4nd patch
>  - Rebased on v6.3-rc2
>
> Changes in v7:
> https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@kerne=
l.org/
>  - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
>  - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1]
>  - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
>    HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>
> Changes in v6:
> https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kerne=
l.org/
>  - Replace 8 with MCOUNT_INSN_SIZE
>  - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
>  - Add Evgenii Shatokhin comment
>
> Changes in v5:
> https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel=
.org/
>  - Sort Kconfig entries in alphabetical order.
>
> Changes in v4:
> https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel=
.org/
>  - Include [3] for maintenance. [Song Shuai]
>
> Changes in V3:
> https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kerne=
l.org/
>  - Include [2] for maintenance. [Song Shuai]
>
> [1]: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh00rh=
8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> [2]: https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gma=
il.com/
> [3]: https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfi=
llet@gmail.com/
>
> Song Shuai (4):
>   riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>   riscv: ftrace: Add ftrace_graph_func
>   riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
>   samples: ftrace: Add riscv support for SAMPLE_FTRACE_DIRECT[_MULTI]
>
>  arch/riscv/Kconfig                          |   4 +
>  arch/riscv/include/asm/ftrace.h             |  19 +-
>  arch/riscv/kernel/ftrace.c                  |  30 ++-
>  arch/riscv/kernel/mcount-dyn.S              | 200 ++++++++++++++++----
>  samples/ftrace/ftrace-direct-modify.c       |  34 ++++
>  samples/ftrace/ftrace-direct-multi-modify.c |  40 ++++
>  samples/ftrace/ftrace-direct-multi.c        |  24 +++
>  samples/ftrace/ftrace-direct-too.c          |  27 +++
>  samples/ftrace/ftrace-direct.c              |  23 +++
>  9 files changed, 345 insertions(+), 56 deletions(-)
>
> --
> 2.20.1
>


--
Thanks,
Song
