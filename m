Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1F6887C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjBBTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjBBTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:50:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57C712DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:50:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x7so3230058edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1fO/hIqmJopkgUvbt7bySSxbzKni1x3M08W8IjYrXvw=;
        b=Nk/tlhkDi2nPmK20+FASBstHtUCa++2jP1YPu64tTbp3j3pqbJ0FhZNMd9W6O/a32w
         2702aGUveoLKKYg4Wz9BBaBDf+NJvysDeNqSAGSWSJ07P4eTbzKo0Rwa3aMkhAQxY2+F
         1MuOUCWx7KFKSAxwyJYJAmxNuTnreiHihc2IInKMdOcgOjXALj9XEv21FC1ge+kANhkp
         YEEkEqeNhqvTe3dq5QierAgpSoUa51Hyi7bCyLj44tPdPbuo9VtEHsO2i1Ftg5i1QJVN
         obIu5YHE2PQ51xkm6b0MUmS1UxP5e6gvzREiYWGXo1d+ToD6tUPwm1BGGZXzJhsQxr53
         pGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fO/hIqmJopkgUvbt7bySSxbzKni1x3M08W8IjYrXvw=;
        b=woGrOgqaKJZZIJP0b40v6wuvqx+1YXmLbfPVTrt/DMkKFVBeAoJV8MiXp9JP5tJeXY
         SnuAUksFWi2w07AD8wvRGSvzDElLyk81SF8bZUdgXccHLsPRIJnDdKR2/dFPAXu444GK
         FLjYN7pAvpj4/1LEJeaKTedFTLxa992Q5PQy0a778gUqhyN6cMcod3s1F9+AWTpTQs7T
         wsix8mmHYp+cIfarynqwyUiEuZ7K/3jn2NNbfJFM3ZFqq2Qs7ds3F4g2PPa4+k2F6Dyv
         e8yFKYoDPhoomHrohps29pCx8cJwBeyFnEWxrNtt6sLNiaeU2u3Q8XPmcuSrhxWt8PZE
         hBrg==
X-Gm-Message-State: AO0yUKXrmGn0J7KUHHPDbDScH+KlELo4Wpr4zHU535oaRhg7XakK37Rx
        Yl1OgSLli7ZJ+RPP/M80mCnhOjG4QSAfPVPZ9g1Mug==
X-Google-Smtp-Source: AK7set/lkyA3ZhhrgMGS/eLjMhSHYMmy+wZ9RvJpPhhZSHTl/p53byYoaa18x/kaSuurcJlXmSo8kQp6GRUsvPNR/yQ=
X-Received: by 2002:a05:6402:2489:b0:4a0:f071:3656 with SMTP id
 q9-20020a056402248900b004a0f0713656mr2440374eda.81.1675367419383; Thu, 02 Feb
 2023 11:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com>
 <63dbf04a.630a0220.2608a.0149@mx.google.com> <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
 <63dc0a89.170a0220.49507.0091@mx.google.com> <CAMj1kXHTwFH-OADZ5nZXfZyuH-x7XJL3DMyiz2Tr_nCuup+xFA@mail.gmail.com>
 <CAKwvOd=cuDb2NNK4uoUTYTLryFig47hvDQ08ta5XhjHsEhAG4A@mail.gmail.com>
In-Reply-To: <CAKwvOd=cuDb2NNK4uoUTYTLryFig47hvDQ08ta5XhjHsEhAG4A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 2 Feb 2023 11:49:42 -0800
Message-ID: <CABCJKuc+GvTHXu-CVedZs6CvPKJ8ySrVztkP2V3dsWn70xf7hA@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
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

On Thu, Feb 2, 2023 at 11:31 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Feb 2, 2023 at 11:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 2 Feb 2023 at 20:10, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Feb 02, 2023 at 10:56:29AM -0800, John Stultz wrote:
> > > > That said, making sense of the error message isn't completely trivial
> > > > either. I've been seeing a few cases recently of some of the new
> > > > compiler tooling (I pinged you earlier on a CFI one) causing errors
> > > > that developers aren't really sure how to address.  I know sometimes
> > > > it's not easy to surface the errors with context to what was wrong,
> > > > but at the risk of intense bike shedding, is there some way to provide
> > > > something like "Likely array bounds error" instead of just "BRK
> > > > handler: Fatal exception"?
> > >
> > > Yeah, this is a result of the size trade-off that resulted in config
> > > CONFIG_UBSAN_TRAP -- there ends up being no message about what went
> > > wrong. I'd really like to have cleaner handling of this -- perhaps what
> > > was done for KCFI could be applied to UBSAN as well, though this is an
> > > area I don't know well myself. (i.e. encoding "this was a UBSAN trap"
> > > in the trap itself.)
> > >
> > > Sami or Ard, is this something that could be improved for arm64?
> > >
> >
> > -ENOCONTEXT, so I am going to assume this is about runtime
> > instrumentation that needs some kind of 'panic' function which it will
> > invoke if some condition is met that should never occur?
> >
> > We already use brk with different immediate values in the opcode, so
> > the arch layer already has what we need. Is this a limitation in the
> > compiler, perhaps, where it always emits the same brk opcode?
>
> Yeah, we'd need to update both the compiler to produce the encoding,
> and the kernel to recognize the encoding and do something special.

A quick look at Clang's source code suggests that Intrinsic::ubsantrap
already accepts the handler ID (from the SanitizerHandler enum) as an
argument and the arm64 LLVM back-end appears to encode the value as an
immediate for the brk instruction. I didn't confirm that this actually
works, but perhaps we just need to teach the kernel about the possible
values?

Sami
