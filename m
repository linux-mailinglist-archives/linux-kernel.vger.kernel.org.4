Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE45F59F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiJESi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiJESih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:38:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CE80F5B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:38:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso2611635pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9yw5zhxkaazQ2OZ9zMHsPcnVAHQqs8G8gkNugiQLHgA=;
        b=egkobgiIDtYinGUEotYJKa+17VFVUWid4wik7ycJTDaD9ygcGzBx4JLsDIaZAgbqDE
         KprKjUZ88ZhrvXxhrdRaOa0rJHztThM3rQkdFL1gLpwqpLGkuELhaVIIeMPzDPLSSJyU
         RcARLj6q2RXkVFr/PGvXT9E6DktoTp8MYOTeUyBPmPR1CRrhbmx8UTCCERqDDZGJoKtl
         rinHXJkZLecY3pmxRuvWoZkhGhNpfKgmReEHF13gWcQ1nh6DSWnjfXijkIYhiSzabBUF
         RMIXcRMaHM0xalp/nsSrOgwoYmLYqLLR0p6RMq+rs/A8X2yaR3uBNdZPDQhkShRi+hut
         5tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9yw5zhxkaazQ2OZ9zMHsPcnVAHQqs8G8gkNugiQLHgA=;
        b=UrAkgmy8ytfcEEN5ug6tYAMl3hJDjvKESugqhMIkklrs+mmL2hI52geyDrykgfoQAF
         2btpaVhCpxJf7RJidvlxeJainveE0KcQpohrHWzM61nJQ8k2MDB6SjqEz+WtsSg6KTfY
         +2y0wAPXJfChE2J0TwY/IFR6JRmDuk7O0IIu8d/3KcfbG/kaHR++tO/xn8N5Vc25yGsm
         zA6lTkBm2RGz52kSmxJDDQZjUsbHCc+4a7a78bsZkw2ggiQjDawejhGaGQK+7X1vObmT
         oe8qpZgr1BeeTRPr8EoIuetTRATUklcXupIdoAO5S46/ba3RhlXSZY9hfoVbu0T5aNgr
         zLnw==
X-Gm-Message-State: ACrzQf1FoTaWbijBeaVKwetTo8FlsfmAhOBFojh9xTKT6Y9wbf5q5nVc
        7C3AlEwBsWzoLvPXvs2ThBO/WrdFD2x2BSSy/B4rCg==
X-Google-Smtp-Source: AMsMyM4HKUJAdrsZfdBKjrkVUTUHNyB4zKF6wJ0L75bWymlfyl82L731AlBfDp6pvsBrNN+44CkmmUUhQj18szaw7gc=
X-Received: by 2002:a17:902:7404:b0:17f:7fe6:7197 with SMTP id
 g4-20020a170902740400b0017f7fe67197mr706264pll.94.1664995096044; Wed, 05 Oct
 2022 11:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220927153338.4177854-1-me@inclyc.cn> <20221005072913.982634-1-me@inclyc.cn>
 <CAKwvOdm6wSgG-_HrRR_9+mLnksbK4qNA8-F--bAVTjwY1C4brA@mail.gmail.com>
In-Reply-To: <CAKwvOdm6wSgG-_HrRR_9+mLnksbK4qNA8-F--bAVTjwY1C4brA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 11:38:04 -0700
Message-ID: <CAKwvOdnDKSdw4fh+FQWNgPNMnLuD=YBhKQHaxtkXJO7DWK_zpA@mail.gmail.com>
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

On Wed, Oct 5, 2022 at 11:30 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 5, 2022 at 12:29 AM YingChi Long <me@inclyc.cn> wrote:
> >
> > Kindly ping :)
>
> Hi YingChi,
> Sorry for the delay in review.
>
> I think https://godbolt.org/z/sPs1GEhbT has convinced me that
> TYPE_ALIGN is analogous to _Alignof and not __alignof__; so your patch
> is correct to use _Alignof rather than __alignof__.  I think that test
> case demonstrates this clearer than the other links in the commit
> message.  Please consider replacing the existing godbolt links with
> that one if you agree.
>
> Please reword the paragraphs in the commit message from:
> ```
> In PATCH v1 "TYPE_ALIGN" was substituted with "__alignof__" which is a
> GCC extension, which returns the *preferred alignment*, that is
> different from C11 "_Alignof" returning *ABI alignment*. For example, on
> i386 __alignof__(long long) evaluates to 8 but _Alignof(long long)
> evaluates to 4. See godbolt links below.
>
> In this patch, I'd like to use "__alignof__" to "_Alignof" to preserve
> the behavior here.
> ```
> to:
> ```
> ISO C11 _Alignof is subtly different from the GNU C extension
> __alignof__. _Alignof expressions evaluate to a multiple of the object
> size, while __alignof__ expressions evaluate to the alignment dictated
> by the target machine's ABI.  In the case of long long on i386,
> _Alignof (long long) is 8 while __alignof__ (long long) is 4.

Oops, and I had that backwards.

In the case of long long on i386, _Alignof (long long) is 4 while
__alignof__ (long long) is 8.

So I guess my commentary on "multiple of the object size" is
wrong...hmm...this wording can probably be improved further still...

>
> The macro TYPE_ALIGN we're replacing has behavior that matches
> _Alignof rather than __alignof__.
> ```
> In particular, I think it's best to avoid language like "returns" in
> favor of "evaluates to" since these are expressions, not function
> calls.  I think it's also good to avoid the term "preferred alignment"
> since that isn't meaningful; it looks like it was pulled from one of
> the GCC bug reports rather than the GCC docs or latest ISO C standard
> (https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3054.pdf).  I'm not
> sure that the links to the GCC bug tracker add anything meaningful
> here; I think those can get dropped, too.  It's also perhaps confusing
> to refer to earlier versions of the patch.  One thing you can do is
> include comments like that "below the fold" in a commit message as a
> meta comment to reviewers.  See
> https://lore.kernel.org/llvm/20220512205545.992288-1-twd2.me@gmail.com/
> as an example of commentary "below the fold" on differences between
> patch versions.  Text in that area is discarded by git when a patch is
> applied.
>
> With those changes to the commit message in a v3, I'd be happy to sign
> off on the change.  Thanks for your work on this!
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
