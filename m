Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184B05F5A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJES6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJES6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:58:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2F7FE5C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:58:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso2688229pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5lRLQjvDio5EOkrqoip0FTDNOjHM4Cx4SYb9YTyKaX4=;
        b=MWctiTAQLk6GBX9GhntKEUzDN0XW7N8Vf6a4V9xz+VCcvpoTzWEwOktUTcD8oAMd3D
         WMDx3cxF6FPE1dOiJms35ueUDcyTwz+lCOg2b8TExVUHiVc5YZ6xxQ7LNn6nKR/kvDVT
         ShOlD09VIbUJ2knsVDEmv6e7X4xbX6z8dE/l/cnOPSTm7T5LG8MEwp/hvMzLiTrLqIab
         Dp/YRtIsu8ych+Tt/5fRkAJXPQgteF8HHSUW3zThiET0Q+ouoFUmdM5wNxL40F0kprxk
         tjz+ldcFp+XxeewtNQNIVRpGedpWl2kTCXa/gHTz6YOewDXdw1vogbnbaVZYFBozcA7n
         Z1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5lRLQjvDio5EOkrqoip0FTDNOjHM4Cx4SYb9YTyKaX4=;
        b=n8Cn6YbJDKu94YlffsD9l8boEiG435c869UkzHUODszLoK7rk4b1pe0PKSDdOVCA7P
         HgG3xAEl++2fewbXFUm9N7PDB76OV3REn5heeEfqh5xFWlDUgu7DD795bAXRXQKbr61e
         YStWHjFhEWjsGFe4BUusBwrXB3kwPVYUODXk5hhcTcrmjEgY0zmR7gUeDPsHUb678nam
         blEQBZgCm5SL9YSO+qaKmCxlDc5rKcwUSPYa0Xv+KMgvH/m6P6+O+9r4HzMYT0qHNj3h
         gFIE12L7WYqEmnWNM694qt/49FFPsAKS3HejuelIVpvO4HEdDiSfB+SM535noeeg3eAp
         Eyfw==
X-Gm-Message-State: ACrzQf2fhl3Yv/A/LJ8f0FHhAMlxYfMFwrs12A4xXZJ9CNIVLnsVxMSh
        y7XJSaBPqoyhS/e6OqNDOaoAVwmLL+9ZMOJ/2XWrkg==
X-Google-Smtp-Source: AMsMyM7HC3HuABomZoUlr48QRG7ZAI9++PlTjSjUXNGJeN9GJ7uqCkMeoFo8QPWsxpumuEjocG7uu7RNfHo0ptaiGlw=
X-Received: by 2002:a17:902:7404:b0:17f:7fe6:7197 with SMTP id
 g4-20020a170902740400b0017f7fe67197mr775095pll.94.1664996286624; Wed, 05 Oct
 2022 11:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220927153338.4177854-1-me@inclyc.cn> <20221005072913.982634-1-me@inclyc.cn>
 <CAKwvOdm6wSgG-_HrRR_9+mLnksbK4qNA8-F--bAVTjwY1C4brA@mail.gmail.com> <CAKwvOdnDKSdw4fh+FQWNgPNMnLuD=YBhKQHaxtkXJO7DWK_zpA@mail.gmail.com>
In-Reply-To: <CAKwvOdnDKSdw4fh+FQWNgPNMnLuD=YBhKQHaxtkXJO7DWK_zpA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 11:57:55 -0700
Message-ID: <CAKwvOd=H5kB=nsParYME2KoQxj-eDC_DAN09y1T2E7yqS43H4Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fpu: use _Alignof to avoid UB in TYPE_ALIGN
To:     YingChi Long <me@inclyc.cn>
Cc:     bp@alien8.de, chang.seok.bae@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        peterz@infradead.org, david.laight@aculab.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 5, 2022 at 11:38 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 11:30 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Oct 5, 2022 at 12:29 AM YingChi Long <me@inclyc.cn> wrote:
> > >
> > > Kindly ping :)
> >
> > Hi YingChi,
> > Sorry for the delay in review.
> >
> > I think https://godbolt.org/z/sPs1GEhbT has convinced me that
> > TYPE_ALIGN is analogous to _Alignof and not __alignof__; so your patch
> > is correct to use _Alignof rather than __alignof__.  I think that test
> > case demonstrates this clearer than the other links in the commit
> > message.  Please consider replacing the existing godbolt links with
> > that one if you agree.
> >
> > Please reword the paragraphs in the commit message from:
> > ```
> > In PATCH v1 "TYPE_ALIGN" was substituted with "__alignof__" which is a
> > GCC extension, which returns the *preferred alignment*, that is
> > different from C11 "_Alignof" returning *ABI alignment*. For example, on
> > i386 __alignof__(long long) evaluates to 8 but _Alignof(long long)
> > evaluates to 4. See godbolt links below.
> >
> > In this patch, I'd like to use "__alignof__" to "_Alignof" to preserve
> > the behavior here.
> > ```
> > to:
> > ```
> > ISO C11 _Alignof is subtly different from the GNU C extension
> > __alignof__. _Alignof expressions evaluate to a multiple of the object
> > size, while __alignof__ expressions evaluate to the alignment dictated
> > by the target machine's ABI.  In the case of long long on i386,
> > _Alignof (long long) is 8 while __alignof__ (long long) is 4.
>
> Oops, and I had that backwards.
>
> In the case of long long on i386, _Alignof (long long) is 4 while
> __alignof__ (long long) is 8.
>
> So I guess my commentary on "multiple of the object size" is
> wrong...hmm...this wording can probably be improved further still...

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf
Section 6.2.8 "Alignment of objects" refers to "fundamental alignment"
and "extended alignment."

I wonder if it would be precise to say that "_Alignof evaluates to the
fundamental alignment while __alignof__ evaluates to the extended
alignment (which is implementation defined, typically by the machine
specific ABI)." Though even that seems imprecise since it sounds like
a fundamental alignment could be less than or equal to what alignof
evaluates to.

Grepping for `alignment requirement` turns up perhaps relevant
portions of the spec.

>
> >
> > The macro TYPE_ALIGN we're replacing has behavior that matches
> > _Alignof rather than __alignof__.
> > ```
> > In particular, I think it's best to avoid language like "returns" in
> > favor of "evaluates to" since these are expressions, not function
> > calls.  I think it's also good to avoid the term "preferred alignment"
> > since that isn't meaningful; it looks like it was pulled from one of
> > the GCC bug reports rather than the GCC docs or latest ISO C standard
> > (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf).  I'm not
> > sure that the links to the GCC bug tracker add anything meaningful
> > here; I think those can get dropped, too.  It's also perhaps confusing
> > to refer to earlier versions of the patch.  One thing you can do is
> > include comments like that "below the fold" in a commit message as a
> > meta comment to reviewers.  See
> > https://lore.kernel.org/llvm/20220512205545.992288-1-twd2.me@gmail.com/
> > as an example of commentary "below the fold" on differences between
> > patch versions.  Text in that area is discarded by git when a patch is
> > applied.
> >
> > With those changes to the commit message in a v3, I'd be happy to sign
> > off on the change.  Thanks for your work on this!
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
