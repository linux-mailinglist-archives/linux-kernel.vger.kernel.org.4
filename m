Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED696AFEC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCHGNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHGNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:13:42 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4740B8EA20
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 22:13:41 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536c02c9dfbso286846897b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 22:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678256020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiAc6iDNiFMAbN7UHWJQSh1sRq4ZHLyQcfVCvWd6xRw=;
        b=mep4iLM3eL4eFhiOCsS/C/HyLs4cXs6DifeXxcMOrrqxzXDttbjZu2izHtUGbdLycD
         hFA4+52CYusknxCEHXr2mloOTKwyu5QA8F3r9OvIswiOxosDQ4380j4kd+v63LSpZniQ
         1pT0iekZ7dxQQRXNs7gN4ZukO00mYjP/I4rsZq9mWxfdsv67AT5QUWANBSxZTK5lygkh
         gq7Dlt2hjG2JuTLfJMO++9lo3RMfbgTwzfhb7+p+CboPIzvnZJBIHkwLszTwNYdPDUPE
         eZxeVht1nkAUswvVLIApysmhwPgYj09UbTXAsQB3z3iWgNWYLg2Fgkpjf6T/H+6LD7Dr
         Kcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678256020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiAc6iDNiFMAbN7UHWJQSh1sRq4ZHLyQcfVCvWd6xRw=;
        b=dcLFJBYDhMiahw+NX4ct26jlpKv0QN5SMZDVhZQDRqssgKZOHuaEjuPyA3MnzJSy0x
         bU8FZKsIC+F9zbu5v2IkhKAHvpa9XdnFPgL38W+r6k5yFx/q9MvThNaqYe9b61EqPco9
         4Nk7HL6ohBmRsq5U38LL8TaCy6yU09bmpaPlzJyQK31ktechGp3jYfz8rD7lqodWb1rR
         cIfc/ZlhZdbyHYA0HOH656t+LtErtghoUJBJTtV6iSLd1aafVrA6Anb0/Wmbq32qPLe2
         ax2XyqyssJvan6NOaqA7vSYfDOxKADJNIb5CqyVnDlbLV2GYcr+l6GVgpKRomAbei0sp
         W7jA==
X-Gm-Message-State: AO0yUKVAmkxLVyaFWMYcGIKiWDPRXbjH1KwIlfvXcccudUgFg7CX9obr
        OLZ1HDQdGjub0PMR9PWHiSeOuZlg1lXw2eImUt47xw==
X-Google-Smtp-Source: AK7set9UbRfrxNxvgobWGUcgdwtDtWG8t/xs600BkL3DO9PrcoHUe3E4qN7u6XXOYIq6o2g3mGjHmvLGAGNz1IbbWf4=
X-Received: by 2002:a81:a9c8:0:b0:53c:6fda:835f with SMTP id
 g191-20020a81a9c8000000b0053c6fda835fmr10410255ywh.0.1678256019925; Tue, 07
 Mar 2023 22:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com> <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
In-Reply-To: <CAHk-=whCA4-uc5WV_-68Mpmu-TiSv6fxkSjZ19zzcW9jpSxDvA@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 7 Mar 2023 22:13:27 -0800
Message-ID: <CABPqkBR_U06L8skMsDXxSXfMptezequzRCxOTELAXxGDK+F+DA@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
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

On Tue, Mar 7, 2023 at 1:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 7, 2023 at 12:54=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think the problem is that the <asm/resctrl.h> code is disgusting and
> > horrible in multiple ways:
> >
> >  (a) it shouldn't define and declare a static function in a header file
> >
> >  (b) the resctrl_sched_in() inline function is misdesigned to begin wit=
h
>
> Ok, so here's a *ttoally* untested and mindless patch to maybe fix
> what I dislike about that resctl code.
>
> Does it fix the code generation issue? I have no idea. But this is
> what I would suggest is the right answer, without actually knowing the
> code any better, and just going on a mindless rampage.
>
> It seems to compile for me, fwiw.
>

On Tue, Mar 7, 2023 at 3:01=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Tue, Mar 7, 2023 at 2:56=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Mar 7, 2023 at 2:03=E2=80=AFPM Nick Desaulniers <ndesaulniers@g=
oogle.com> wrote:
> > >
> > > Sounds like Stephane is going to re-run the internal tests he used to
> > > discover the issue with your diff applied, if you don't mind holding
> > > out for another Tested-by tag. EOM
> >
> > Ack. I am in no hurry.
> >
> > In fact, I'd prefer to just get the patch sent back to me with a
> > commit message too, if somebody has the energy. I don't need the
> > credit for a trivial thing like that.
>
> Sure, then maybe Stephane you can supply a v2 with updated commit message=
 and a
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>
I verified Linus' patch on my test case on AMD Zen3 and it works as
 expected, i.e., the limit is enforced. I had tried a similar approach myse=
lf
as well and it worked.

I think passing the task pointer is the proper approach because we are
in a sched_in routine
and I would expect the task scheduled in to be passed as argument
instead of having the function
retrieve it from the current pointer.

Thanks.

Tested-by: Stephane Eranian <eranian@google.com>

>              Linus
