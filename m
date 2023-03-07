Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FE6AF81F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjCGV6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCGV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:58:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A9A838F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:58:51 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id i3so15666989plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678226331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iOhf16yBRlTqpgU2xhQ0C0E2y1FmHsBFKjMtFiPcqY=;
        b=jyPFABP0iq67dhiNelpg0gcKI68C81QtJN99IxQNCdbDw1Dl3mR6UglI4waySu+AaA
         R9rYlKxcqmRFIXfVdWuH69JglgjnH/RHmZJQjtAT2ZUBCrzNQ5ZbYTLL5q3UxxYvWRBs
         nq27YbkXIh9vZeARLzKdgy9kbQnpl58dz+rlcxQ79ZMIhNFikAnOIcVLU0hK1qClrwYT
         Ukjy251AvVgXfN2YUpnGH5/o31KDq6yvlnqiryouGYrYlAlQt9YR0PfKj2cbQXdaFhDv
         8XOkhsyoSUEyEtaTR8at7D3TdQ0MSdxuOrFDVNA2UXD2VzZ35GmKxxLLTFeuP8TDwxF9
         an3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iOhf16yBRlTqpgU2xhQ0C0E2y1FmHsBFKjMtFiPcqY=;
        b=gUqx6ZQ9jXvTPgpw/5GommIc7jedItUibo745P4rkVyxKYmgqSiwHDFh/Pk9tOsckZ
         nWlrmjeblIEshqe0Omukn+gtZ4J0Bn5WW88kzXEr5NyLU0jaBZDTtxFPsADZWAUgDQj+
         4mvPtQdiYtNakYjAVrfblQANc8TQD+lsLOrKp2Dv9klTMZvnQUzAmbMEif2+O5c9wQYo
         wTZMc/y7gjAKm1rBTgGvOxtonQtnFWHrGh+/M6z9AgB/IEzgqdC4Fla6g56JbgNUvGNU
         6o+k34TiE0ztQuhAmAPSxSDlMDFtkjBUhAOSS01m7gOFhGnvZTeByEct7gaOXLW5Dslj
         Kvkw==
X-Gm-Message-State: AO0yUKXIzOEuMRMBsfjRuVyVk1Dt8fJ8ZA3ozTjZYmuHN/aWq8CjhRni
        XsCMY70hNfXJupu27YBbLc6HBRpvPO4jwy3IwDyG2A==
X-Google-Smtp-Source: AK7set+x/KTztFG24s7NOV/+Lsi388WnW3JQ8NmFTLQhBS7lZJKThP/yskEKi/aK81KfU8aOgZTY1nUa9FYCxuYANCg=
X-Received: by 2002:a17:90a:f10b:b0:23a:6ed6:7817 with SMTP id
 cc11-20020a17090af10b00b0023a6ed67817mr6026857pjb.5.1678226331109; Tue, 07
 Mar 2023 13:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com> <SJ1PR11MB60835681E8FE389EC0A1825DFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60835681E8FE389EC0A1825DFCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Mar 2023 13:58:39 -0800
Message-ID: <CAKwvOdn9cWJO96mpWAAUh4i37+ED=S5CFKPGP7jO0SdaRumgfA@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 1:35=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> > Ok, so here's a *ttoally* untested and mindless patch to maybe fix
> > what I dislike about that resctl code.
> >
> > Does it fix the code generation issue? I have no idea. But this is
> > what I would suggest is the right answer, without actually knowing the
> > code any better, and just going on a mindless rampage.
> >
> > It seems to compile for me, fwiw.
>
> Beyond compiling it boots and passes the tools/testing/selftests/resctrl =
test suite.
>
> Tested-by: Tony Luck <tony.luck@intel.com>

LGTM; reloading of current becomes irrelevant now that we're reusing
the existing variable `next_p`.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Might be nice to tag this for stable.

Cc: <stable@vger.kernel.org>

And credit Stephane who did a nice job tracking this down and having a
concise reproducer.

Reported-by: Stephane Eranian <eranian@google.com>

Perhaps relevant links

Link: https://lore.kernel.org/lkml/20230303231133.1486085-1-eranian@google.=
com/
Link: https://lore.kernel.org/lkml/alpine.LFD.2.01.0908011214330.3304@local=
host.localdomain/

Consider reusing parts of Stephane's message from the initial Link above?

Thanks for the patch.

---

While this issue was specific to the usage of `current` (implemented
as a macro that uses `this_cpu_read_stable`, I wonder if we might hit
issues again in the future (at least on x86 using the "p" constraint)
in code that:
1. uses this_cpu_read_stable to access a per cpu variable
2. updates that per cpu variable
3. uses this_cpu_read_stable to access the variable hoping to get the
new value rather than the old.

I guess that this_cpu_read should be used rather than
this_cpu_read_stable? Maybe we can beef up the comment in
arch/x86/include/asm/percpu.h to warn about this? The sentence about
get_thread_info() being a user of this_cpu_read_stable() seems
outdated/due for a refresh?

Is __switch_to the only place that should be updating current?  Are
there other variables other than current that might be afflicted by
that 1,2,3 pattern I mention above?

current_top_of_stack() uses this_cpu_read_stable() for instance.
Perhaps there could be a caller that measures the stack depth, grows
the stack, then rereads the wrong value?
--=20
Thanks,
~Nick Desaulniers
