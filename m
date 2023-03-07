Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D706AF770
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjCGVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCGVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:22:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B13773D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:22:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s17so8450068pgv.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678224176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67EAjS6OmcGVxbTP0Fh6bz0JB0dwnl7kfC5zuHtq9rU=;
        b=iBGugF4Y1PFbTwiaL4V7YFcnD/gnmu+YDPZKoeiYCz1/zmDS06H69//j+KGTvJfKBy
         OcOw1FDGiy16Qt6jOmKfjg/RHsxctVnKfCnHy462Y7thrWinNX1/oBhpMUJhEccllpmE
         DMVtfFKJpHfI67Ntlf5jgPW7DqJHiXpDJxAMDg41e4fKR0bPTZiqGNFQMsubLICWbIcJ
         haOxBSGcdvL0zzEuL0NTV7hgfcyIhJdlWGwb46z0c/S5HgZ28fpcYn82Kzz2ZlXP+rCa
         JJIGQXb8xihxwWUY12p1JoJQbi8+OpGvR4LXshBcujAxbkDrB9KrLlJaL6pNxkZgRFjG
         l0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678224176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67EAjS6OmcGVxbTP0Fh6bz0JB0dwnl7kfC5zuHtq9rU=;
        b=vC53iIPrXIrPuyK5Sm0iNI1kapl/d11MF9s4i11OThKsrHBV1A6Tkaf7q79Z9Mvkk3
         5j/N85rj5lCTdNbA+6f2CAWYkYiLUgSdp62mwlTGJmCPAKpLsxjam0qmfzozZ8LNjepV
         blB3nc7Kr3G9n4dpZbfQ0xm+e/JR7p1HXLD5k37Fn902F8cRyR19RHqg8+O5V4bO7LR/
         1hWbazMdBLLt7MmxDaBlUZWznZQ5+u95SQrfety3fBaTz2vb26RocGX8FeIjMrBcOZSD
         OB7zP6nuMgfaikIJ3fzED/jSniav1QsyXGQYT6AU5+nrDVRae4n496bOgk+eQTgRsfSq
         nTRQ==
X-Gm-Message-State: AO0yUKWoJ3YcEh05uvDd1OT+/RVsT+TFNf4BtuxHIBHYByDhHFB6eBYC
        2CErBCY8ntpHD3Y++zJMhSwnhnaMFpcN3zztifMRGA==
X-Google-Smtp-Source: AK7set9uvx8ttF6ieYsBsI1zZDQOyhN7yS7IciKF4MD1fsN1gODyh1DdeG6lFiyweJw2iC+Ipfs3zd2zAh0J4ZzEsdo=
X-Received: by 2002:a62:ce4c:0:b0:606:63cd:506c with SMTP id
 y73-20020a62ce4c000000b0060663cd506cmr6797543pfg.1.1678224176420; Tue, 07 Mar
 2023 13:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAKwvOdna5NZ0ZTv0pXVVz15=4FLkw7pfFgr6KsRtXRmi2o1uEw@mail.gmail.com> <CAHk-=wiVP8ezgCyBTq3GV-1ebiOf03Qo_iHnVAR08NJO0jOocg@mail.gmail.com>
In-Reply-To: <CAHk-=wiVP8ezgCyBTq3GV-1ebiOf03Qo_iHnVAR08NJO0jOocg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Mar 2023 13:22:45 -0800
Message-ID: <CAKwvOdk1n2v5Sym14BR0jGWKX8nNP1VL4Z1vXtAOWvQETOCSmQ@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Jakub Jelinek <jakub@redhat.com>,
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
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 1:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 7, 2023 at 1:16=E2=80=AFPM Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> >
> > >
> > > Can you expand about part "a" ... Linux has zillions of static inline=
 functions
> > > in header files to handle CONFIG options. One version is the real McC=
oy
> > > while the other is just a stub for the CONFIG=3Dn case.
> >
> > Right, I had the same question.
> >
> > Perhaps it's more so that no one calls __resctrl_sched_in, only
> > resctrl_sched_in, therefor they should be folded into one function?
>
> If you think it should be inlined, it should be marked as such.

Yep, sorry, I missed that `inline` was missing from that definition!

>
> And if you *don't* think it should be inlined - quite possibly the
> right answer here - the definition of that function damn well
> shouldn't be in a header file.
>
> So either way, that __resctrl_sched_in() was wrong, wrong, wrong.
>
>            Linus
>


--=20
Thanks,
~Nick Desaulniers
