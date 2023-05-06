Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A636F93D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEFTfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 15:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 15:35:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D2150CB
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 12:35:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so3090692a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683401712; x=1685993712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Bt+lLwGV/jHjdmZshGXn94cRDllqEXa12GkeEe4Dfk=;
        b=TDzEgGFajZaz3kxsx4jCXX2lSrt5ZN0q0vS+SvVrSrIS0KoxpehlqH9Mq07/FSa9mX
         mABtd55rXO64CqG2SfZcPff2tMMK8npaG2HZI4e25oiRX5rrwy8Ra5lmkEDm0Cye/clH
         c/W5jPfHBlZYHRbr8Cd5aaxc5bEcZFZH6bqSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683401712; x=1685993712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Bt+lLwGV/jHjdmZshGXn94cRDllqEXa12GkeEe4Dfk=;
        b=KuE2jJAOStvBi3UypR5zBJCJ3blGnbZTL8z+rdGFLWVp3wPFOcQ8weFk/VPgfIG/ev
         LuXYePLIs6Y3Jh4Y/asLL948oFouFUF+izRjiV/Mc+sH3I6AYy5mqLOvbpQwmpTWVYRq
         vDomzetpKqn7UcGcvpZIjYp/MumshwNg44YQ/JPIxlafsRRx6nU/Z1fhbbg+zRIHAwa+
         P3smTvxiN9tZjAYdnp4fQuSWzUX4imEEHRbtP/Bq5rXEsN03Qaeb0GrLvuQxkSt9jtV1
         c65ByLL27yK1+DbZMWUeGIj78T8sps1mnJRuhea9tPsg1ErRALdiFdFOcH+LiLdpdFiY
         aajg==
X-Gm-Message-State: AC+VfDw0WMBKaiGDtsJNCP4LSiiio84L+FThaNkNNL12UuMr9bZyfayF
        p9rAIMiELqbkZ3JirLlbVINZqSp1C8STjUfQ04M4/g==
X-Google-Smtp-Source: ACHHUZ7sq7i5tr2ujChWV3qBJrbSl6b3f0YO+ZXJd1NiWi4O0kpjgBDxhb871ubIvP+CxetPbj0E+A==
X-Received: by 2002:a17:907:608c:b0:94e:6a24:9463 with SMTP id ht12-20020a170907608c00b0094e6a249463mr5135363ejc.28.1683401711629;
        Sat, 06 May 2023 12:35:11 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906560b00b009662b4230cesm666189ejq.148.2023.05.06.12.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 12:35:11 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9619095f479so481456266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 12:35:10 -0700 (PDT)
X-Received: by 2002:a17:907:3207:b0:957:48c8:b081 with SMTP id
 xg7-20020a170907320700b0095748c8b081mr3484007ejb.24.1683401710579; Sat, 06
 May 2023 12:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com> <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
In-Reply-To: <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 May 2023 12:34:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
Message-ID: <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 5:40=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> I'd be happy to prepare another pull request for the pile up to there if
> it sounds sane to everyone else.

So I'm going through the original pull request now - I was really
hoping to have been able to do that earlier, but there kept being all
these small pending other issues.

And I'm about a quarter in, haven't even gotten to the meat yet, and
I've already found a bug.

Commit 74fd30bd28e4 ("mm: Make pte_mkwrite() take a VMA") seems to be
just completely broken at least on arm 3-level page tables:

Spot the problem when I distill it down to just a few lines):

    -PMD_BIT_FUNC(mkwrite,   &=3D ~L_PMD_SECT_RDONLY);
    +static inline pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
    +{
    +       pmd_val(pmd) |=3D L_PMD_SECT_RDONLY;
    +       return pmd;
    +}

and I think this whole area was done entirely incorrectly - and that
incorrect approach is then why this bug happened.

I think the first patch should have just have completely mindlessly
renamed every architecture "pmd/pte_mkwrite()" function as
"pmd/pte_mkwrite_kernel()", and added a single

    #ifndef pte_mkwrite
    static inline pte_t pte_mkwrite(pte_t pte)
    { return pte_mkwrite_kernel(pte); }
    #endif

in <linux/pgtable.h>.

IOW, it should make it *completely* obvious that absolutely no
semantic changes happened, and all that happened that it added that
single wrapper layer. And all those architecture changes would be
trivial one-liners.

The only possibly subtle thing would be that some existing

   #include <asm/pgtable.h>

include might need to be changed to

   #include <linux/pgtable.h>

instead, because we do have a number of users that seem to include
just the bare asm version.

From some quick grepping, I don't think any of them use 'pte_dirty()'
or 'pmd_dirty()', but it needs *checking*.

Then, the "add vma" thing would change the above wrapper to literally
just have the 'vma', but to not use it, and still just call
'pte_mkwrite_kernel(pte)'.

Again, absolutely obvious that there are zero semantic changes to any
architectures that don't care.

And finally - for the only architecture that *does* care, ie x86, do
implement the new pte_mkwrite(vma,pte), and do a

  #define pte_mkwrite pte_mkwrite

to let the generic header know that there's now an
architecture-specific version for it, and it shouldn't do that wrapper
that just falls back on the "kernel" version.

End result: all those architectures that do *not* want the vma
argument don't need to do any extra work, and they just implement the
old version, and the only thing that happened was that it was renamed.

Because I really don't want to pull this series as-is, when I found
what looks like a "this broke an architecture that DOES NOT EVEN CARE"
bug in the series.

And yes, my bad for not getting to this earlier to notice this.

Or alternatively - your bad for not going through this with a fine
comb like I started doing.

             Linus
