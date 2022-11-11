Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173F624FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiKKB5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKKB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:57:31 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC594D5C0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:57:29 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6515339pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxqNahmA7zR1BB5f8m8SleanQkS8j2v98m1g/ifNOXk=;
        b=2Nwj0spzyrVmIyXdgqY6VarBJ4E3aEkmNDRR8AlTstMabtsmx9hL981RsQu81o+gtn
         ftRIvEhD+udpnqbAl+qE2GHljsnzP0JjCJRfhNvvYbDD3p5gELPCOQEdRqvKhnkhi2UI
         oGVcnGiDXedGQmFwWswwN8s/6eNG9hmg8YrplzdmDnOw6988/Rw4ELLrAZAfJe9j1hTt
         yrcCiDdKni+UauKPUFuUm56d4HD/a3P/kRJyZwgXlWdLW2Ua7AsTom8LA1FkGAs8L775
         3GRzH0WHnvJy41ogzYtGFq6U2V0ILugc3VDBkPYbdOCGZnA6X6MLN8mpjv+UVG9dDJKJ
         8Vxg==
X-Gm-Message-State: ANoB5pmfJWYfNKEjQGxiuxXG3Ql1PywKmf+nwGQBnUo5hA55XNRwEQhH
        qT6aDbFQxq2I6Du3a8hytY+KRmDin3cm/m69jqU=
X-Google-Smtp-Source: AA0mqf45/kd3A5ewb+eF/k00Mbe8V6JrPwSPcq8n3eHyKTYEs7Tk2nWNSVpsWyvRtf2Tb3gYLxAF2fSx22xuhICrxmA=
X-Received: by 2002:a17:902:f34c:b0:17f:6fee:3334 with SMTP id
 q12-20020a170902f34c00b0017f6fee3334mr445676ple.10.1668131849126; Thu, 10 Nov
 2022 17:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221106095106.849154-3-mailhol.vincent@wanadoo.fr> <CAKwvOdmN2==9tG0fxRO8K-eAJudeemaKUuhJEAuGHc=P8GpGwA@mail.gmail.com>
In-Reply-To: <CAKwvOdmN2==9tG0fxRO8K-eAJudeemaKUuhJEAuGHc=P8GpGwA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 11 Nov 2022 10:57:17 +0900
Message-ID: <CAMZ6RqKRP3cp=FhpA6DkKNKjgRV2ak18k=Ad-mnBPkT++gARCA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] x86/asm/bitops: Use __builtin_clz*() to evaluate
 constant expressions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 11 Nov. 2022 at 04:01, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Sun, Nov 6, 2022 at 1:51 AM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
> >  #ifdef CONFIG_X86_64
> > -static __always_inline int fls64(__u64 x)
> > +static __always_inline int constant_fls64(u64 x)
> > +{
> > +       BUILD_BUG_ON(sizeof(unsigned long long) != sizeof(x));
>
> Thanks for the patches! They LGTM; but why do we need this BUILD_BUG_ON here?

There is no absolute need for sure.

Call this a paranoiac check and you will be correct. My reasoning for still
using it is that:

  1/ It is a compile time check, so no runtime penalty.
  2/ Strictly speaking, the C standard doesn't guarantee 'u64' and
     'unsigned long long int' to be the same (and you can argue that in clang
     and gcc long long is always 64 bits on all platforms and one more time
     you will be correct).
  3/ It serves as a documentation to say: "hey I am using the clz long long
     version on a u64 and I know what I am doing."

If you want me to remove it, OK for me. Let me know.

> > +
> > +       if (!x)
> > +               return 0;
> > +
> > +       return BITS_PER_TYPE(x) - __builtin_clzll(x);
> > +}
