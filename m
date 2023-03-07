Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918C56AF769
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCGVTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCGVT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:19:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DD9C99D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:19:26 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so57990429eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678223964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRkOZ5wI6FwGaM4HgKKUX1s/pa2xIbKjX2uXD922yeA=;
        b=chSxj0mpjqI9ZSrsguW7U9GOdTy4KEDIvukMgkc4YnzALeW9HrqOIacWOobYTCh3EX
         B6wl1EmFC72B9L33/XjxCNazJTQ23/gG8du2/WtM6iUrzM170317QdCukLyDfdwZrDss
         Kt+vda2NA7yyoAbWwjWP+EqCS93q0CkexZJeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRkOZ5wI6FwGaM4HgKKUX1s/pa2xIbKjX2uXD922yeA=;
        b=JPfZir9zmsV1kEr5Z4V7AoWxesY6SHZXJF13ndH7nX5cMoicxPrQFYLq/nW5ZXYsAT
         PHiXnLZGfXJNmR9TnSUBpNpj7s3L8adnVEqm4xwM8dC1LJh9x5vrt3Rp/27DcmxE5l+I
         CWY09rEYKNkldXgvIHm7Rn9LaiIH2Ec8ZSgu39JyfbcDuIacGbD0GHG9KPpV3rCxQYM9
         wJai0mDa//Jk048a0zVJuJMu4dP3Ly0UZRrNwIJfokdK0AGclcBxTCE5VXKDJgtSEb1o
         TkGTXm60j2I5hcJRIPmiflutXNQIKT14zVy1uhrOUmxwEsZgrT8DEHO3WaR1PFpWRN9l
         DNSw==
X-Gm-Message-State: AO0yUKU4kUDeWrZzDre95HcIDOxlru+T/8ojRD5fRla00lNqLMj9gISO
        2suQuHX9VwQOIu8cnlxpvSRu9knwKYBo+jBOEGGBPYgn
X-Google-Smtp-Source: AK7set8sDsc4LMCWGZvQcF689VKR3NGschKEGiH5f3wI0gmLQKb+nRS/9ufdtSvlsoJM8oPE7kp1mg==
X-Received: by 2002:a17:907:3e0e:b0:8b2:a42:5c3a with SMTP id hp14-20020a1709073e0e00b008b20a425c3amr19223022ejc.70.1678223964332;
        Tue, 07 Mar 2023 13:19:24 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id g26-20020a17090613da00b008d044ede804sm6479323ejc.163.2023.03.07.13.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 13:19:23 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id a25so58097080edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:19:22 -0800 (PST)
X-Received: by 2002:a17:906:a01a:b0:8f5:2e0e:6dc5 with SMTP id
 p26-20020a170906a01a00b008f52e0e6dc5mr8132383ejy.0.1678223962342; Tue, 07 Mar
 2023 13:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com>
 <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAKwvOdna5NZ0ZTv0pXVVz15=4FLkw7pfFgr6KsRtXRmi2o1uEw@mail.gmail.com>
In-Reply-To: <CAKwvOdna5NZ0ZTv0pXVVz15=4FLkw7pfFgr6KsRtXRmi2o1uEw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2023 13:19:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVP8ezgCyBTq3GV-1ebiOf03Qo_iHnVAR08NJO0jOocg@mail.gmail.com>
Message-ID: <CAHk-=wiVP8ezgCyBTq3GV-1ebiOf03Qo_iHnVAR08NJO0jOocg@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     Nick Desaulniers <ndesaulniers@google.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 1:16=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> >
> > Can you expand about part "a" ... Linux has zillions of static inline f=
unctions
> > in header files to handle CONFIG options. One version is the real McCoy
> > while the other is just a stub for the CONFIG=3Dn case.
>
> Right, I had the same question.
>
> Perhaps it's more so that no one calls __resctrl_sched_in, only
> resctrl_sched_in, therefor they should be folded into one function?

If you think it should be inlined, it should be marked as such.

And if you *don't* think it should be inlined - quite possibly the
right answer here - the definition of that function damn well
shouldn't be in a header file.

So either way, that __resctrl_sched_in() was wrong, wrong, wrong.

           Linus
