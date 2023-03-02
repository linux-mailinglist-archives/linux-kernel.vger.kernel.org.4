Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C26A84FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCBPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCBPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:13:50 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37055B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:13:49 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id f20so6377784uam.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2cHLqdllPliHQfcCj7lym6e5ewTgURvCIfBNx7SCko=;
        b=ikUsdVcNgtnIXHXltHp1Oq8CF97RiSySooyPoONAmpw3Y/PAua4f5xRjAU/L67FH2C
         Rs0IJEC8Wvw0AaHN4c5V37eSHjxmsHIl450kEJ/+BDmL9UfiPfmP/7p+3FPP1fmx717O
         CK3xF1sVVJmaHcWAp00OrWLkGrCxufREaVR4N9LyRHsIRjMmR7IUvJ3eTdRxGLr8K7v+
         5GvhrD/SoRBQRhZaQ+RoDXMnwgZ98ZH3TGduO3inFG7VoILhwGxhpHVR325ZfTjq6vre
         +2KkdcMinXy1Z76xwoxOfE5XZU3uWXIHFd8V6huUHEIIFg6XSqWokUInJNnW6lOOAXxV
         NMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2cHLqdllPliHQfcCj7lym6e5ewTgURvCIfBNx7SCko=;
        b=CIYBs1xjaGyoPAcxlJUVpgS4nKz8rKkH5GoECSRJrGY6lkQ382MdHQvZhxTLM8Q1mJ
         orFbuS7SU8uk0/3+W7N84/Qroz/FwnLeRE0yoLiGn2w8ccLB/WFXqpgL1LBqfrN7dkxT
         FpYYjuLMFaM/w/j7b0221gUGS6gjY0knNekdNNyfgrrCnWjLBJthuzmSjgODeNQyU0WB
         X1/IAtrutrtITjM93S1E3o6zC7yh/UnExY78uu47AnHeMaV0datxooyLyLdFi7DVDvtT
         6xBbDT6FtdIlljh8MpCH73IlTxs6njQB7oztngh6Hyv4SmJx/fajz9aygNqxypffzH9z
         VHBw==
X-Gm-Message-State: AO0yUKXR9JP9lTfAXzM0hQSAlVIf9A1NGXFsG3nCOiXGJ5APxzpYWNF7
        L1smEKy5BYBYSWeJuYXmSpU4gv1r/+zLlCgxn6rYWQ==
X-Google-Smtp-Source: AK7set/GcwBOjcTFsgk/DbmJ9D0TZt2yW0e3Oau6qlGq/CFy0t7Fp+vUEvcNwe2GpSTcIsPBMwawsaQE2J8JV/Vklf0=
X-Received: by 2002:ab0:5b59:0:b0:68b:9eed:1c7d with SMTP id
 v25-20020ab05b59000000b0068b9eed1c7dmr6233732uae.0.1677770028306; Thu, 02 Mar
 2023 07:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <CANpmjNMR5ExTdo+EiLs=_b0M=SpN_gKAZTbSZmyfWFpBh4kN-w@mail.gmail.com>
 <CAG_fn=U9H2bmUxkJA6vyD15j+=GJTkSgKuMRbd=CWVZsRwR7TQ@mail.gmail.com>
In-Reply-To: <CAG_fn=U9H2bmUxkJA6vyD15j+=GJTkSgKuMRbd=CWVZsRwR7TQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Mar 2023 16:13:12 +0100
Message-ID: <CANpmjNMtXudXbVy4cZDAUUVjHX+hQ0P+FY6La3bsp2zp4t-pZw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: kmsan: Don't rename memintrinsics in
 uninstrumented files
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com,
        Kees Cook <keescook@chromium.org>
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

On Thu, 2 Mar 2023 at 15:28, Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Mar 2, 2023 at 12:14=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > On Wed, 1 Mar 2023 at 15:39, Alexander Potapenko <glider@google.com> wr=
ote:
> > >
> > > KMSAN should be overriding calls to memset/memcpy/memmove and their
> >
> > You mean that the compiler will override calls?
> > All supported compilers that have fsanitize=3Dkernel-memory replace
> > memintrinsics with __msan_mem*() calls, right?
>
> Right. Changed to:
>
> KMSAN already replaces calls to to memset/memcpy/memmove and their
> __builtin_ versions with __msan_memset/__msan_memcpy/__msan_memmove in
> instrumented files, so there is no need to override them.

But it's not KMSAN - KMSAN is the combined end result of runtime and
compiler - in this case we need to be specific and point out it's the
compiler that's doing it. There is no code in the Linux kernel that
does this replacement.

>
> >
> > > __builtin_ versions in instrumented files, so there is no need to
> > > override them. In non-instrumented versions we are now required to
> > > leave memset() and friends intact, so we cannot replace them with
> > > __msan_XXX() functions.
> > >
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> >
> > Other than that,
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> Thanks!
