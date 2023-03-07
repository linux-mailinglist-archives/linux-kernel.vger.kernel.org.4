Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD776AF755
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjCGVPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCGVOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:14:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B196611
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:14:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a25so58054149edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678223688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htYShvi2AdwpLoEtnEoYaPRYtP4Z0z3zxKkxUWERHwg=;
        b=TJB5g+Lep368AO82pfHRpk8dUCXbJ07FsrYQWVz45eMN2xyowOtjjKs4k2mbg0KabQ
         xnUfLXFxyAkuJrn071yGDyWB8S5BW94UP7drBqmLRT65NRP2FCtBvBfqnY5eD5+Ft2d1
         va+syMy286E3lUuF6Si4ElSH8tk7ygcB46Vmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htYShvi2AdwpLoEtnEoYaPRYtP4Z0z3zxKkxUWERHwg=;
        b=LFmlYMFaciCA3HbZDST95wpKoHjcFAObYyezpQTAX5/G2tjBEgTbYYPVa2uSLtthnO
         rPIDRP2s0zo/OnxWmkffRDMZ1S5lM/1Gdeooh9FadX1TMD/aEBtdRKAJL5Afy+GP4jpy
         KIRPXUGAyEQ3YXKmdrdf4OgexCpVMj6ooGJlxom7b2BiAmp3t2A8RPj/5Ebdj56Uwkd8
         dKbaJn2m2TrXooFxW+wyVaXnZzy/B0FJxDcR9RfdptLO0NoD+F81cBvn0Kfc8F0+OmAW
         og2LDsHWb3jclPpylcvgnimprbE//+QrwVftQ1V2BXZQ4JB4zETIxP4C8TEla/41SZmY
         8zZQ==
X-Gm-Message-State: AO0yUKVtgxgJkKpxsR8/RkIRdIt7DVzOXHDADo6t5pnnZviG60NplXip
        EBjlug15wQeVWMTcIAj5ErTaGj6/9pPBSuEYNJwAdWnh
X-Google-Smtp-Source: AK7set+FAzA/hcPfl2YYqP01SkQioVaN4M/lPb5Qe5yikQyAor6dnL7LT42jtRm5ul04bwyEUBzcmQ==
X-Received: by 2002:a05:6402:383:b0:4ad:7056:23a5 with SMTP id o3-20020a056402038300b004ad705623a5mr16264250edv.14.1678223687737;
        Tue, 07 Mar 2023 13:14:47 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b008dceec0fd4csm6561888ejc.73.2023.03.07.13.14.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 13:14:47 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id o12so57781128edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:14:46 -0800 (PST)
X-Received: by 2002:a17:906:a01a:b0:8f5:2e0e:6dc5 with SMTP id
 p26-20020a170906a01a00b008f52e0e6dc5mr8126466ejy.0.1678223686605; Tue, 07 Mar
 2023 13:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20230303231133.1486085-1-eranian@google.com> <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org> <ZAeh8g0nr3IFRSVI@tucnak>
 <CAHk-=whOLcy=oz=gHyoSSEnqc3M-APKFKTtTvA_3wYYPV8L+oA@mail.gmail.com> <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CADB2B6E859915D456F7FCB79@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2023 13:14:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzzd53rW5Uk0oK7bXVXS_X6sJiisnhrqaz+MkutO7qug@mail.gmail.com>
Message-ID: <CAHk-=whzzd53rW5Uk0oK7bXVXS_X6sJiisnhrqaz+MkutO7qug@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in __resctrl_sched_in
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Mar 7, 2023 at 1:11=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> Can you expand about part "a" ... Linux has zillions of static inline fun=
ctions
> in header files to handle CONFIG options. One version is the real McCoy
> while the other is just a stub for the CONFIG=3Dn case.
>
> What's different about this one?

See the patch I just sent out.

Linux has a lot of "static inline" functions. But that's not at all
what that function was. It was literally just

  static void __resctrl_sched_in(..)

which is disgusting and very wrong.

I hope that compilers then just ignored it ("It's static and not used,
so I'm not generating that code"), and that header file isn't included
in very many places, but it's still very wrong.

               Linus
