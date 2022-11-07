Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA461F2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKGMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:19:30 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB118C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:19:29 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id b29so10405685pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AgfJ6TUZlzQk5d03gKr3+MdElNVPRZXFFQ9at+rsns=;
        b=3iIQ//Gs/4s4m1JBtg61FPf+kOoND80SNbW4fBUt+DUl5k8WeQmPyhH6pAXbW0boaP
         q3SthyetfDcxFYpI5l36j8A45n9QF5PaehpTpNT3qB3xDTQWFf1HbIhQXRSzK/0Uwfhp
         0ZfzhGQEFAWjPQUN3U+0+Gx+/yN7MNicn/Vfxcdunb8EyUsDlxX2FZBiC/TO2EtwfAbc
         kOt2WOK454FL+hzdML9Sy4RHRR7wQlBvPt6LfJlK2KBOpFJ9ouVjgP68nHzjccmn7pRa
         K2YfCIeQEr9FXyIaz2QeoILY9qadozaA9VYLuT+A8E8EuDiniACmXf+2loyyFJTBGyKM
         ZJCg==
X-Gm-Message-State: ACrzQf2tlvWwq/U7gTRsHrLTH9iUvGD86QFcfPlsaf8AEReqaXTpSGTG
        g9KYwSOojqN9oKdpJ66f+elzRsSdo5ZYIs+mPFw=
X-Google-Smtp-Source: AMsMyM5h/BPmN+HKzf3ZxgzirDseIUYmunAECaTkA6cYcdWefwCTJtocyTu8wrFF6oQqgsCos80qSD83q8+mKLOkzsc=
X-Received: by 2002:a05:6a00:1792:b0:56c:c9aa:95ce with SMTP id
 s18-20020a056a00179200b0056cc9aa95cemr50037513pfg.69.1667823568683; Mon, 07
 Nov 2022 04:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221106095106.849154-2-mailhol.vincent@wanadoo.fr> <Y2jSMz4GtXGJk6rS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y2jSMz4GtXGJk6rS@hirez.programming.kicks-ass.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 7 Nov 2022 21:19:17 +0900
Message-ID: <CAMZ6Rq+Fo=-D5So=KQCvbfaD0XmcFooi9aUV=uhVAe-UfDa9aQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] x86/asm/bitops: Replace __fls() by its generic
 builtin implementation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon. 7 Nov. 2022 at 18:38, Peter Zijlstra <peterz@infradead.org> wrote:
> On Sun, Nov 06, 2022 at 06:51:05PM +0900, Vincent Mailhol wrote:
> > The builtin implementation is better for two reasons:
> >
> >   1/ it saves two instructions on clang (a push and a stack pointer
> >      decrement) because of a useless tentative to save rax.
>
> I'm thinking this is the same old clang-sucks-at-"rm" constraints and
> *really* should not be a reason to change things. Clang should get fixed
> already.
>
> >   2/ when used on constant expressions, the compiler is only able to
> >      fold the builtin version (c.f. [2]).
> >
> > For those two reasons, replace the assembly implementation by its
> > builtin counterpart.
> >
> > [1] https://elixir.bootlin.com/linux/v6.0/source/include/asm-generic/bitops/builtin-__fls.h
> >
> > [2] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions")
>
> I would much prefer consistently with 146034fed6ee.

There is one big difference between 146034fed6ee and this patch. For
the ffs() functions, the x86 asm produces *better* code so there is a
reason to keep the x86 asm.
The clang missed optimization is not the core reason for me to send
this patch. The purpose of the x86 asm code is to be more performant
than the generic implementation, isn't it? Let's imagine for a moment
that the x86 asm and the builtin produced exactly the same output,
then what would be the reason for keeping the x86 asm version?

My point is not that x86 asm is worse, but that x86 asm isn't better.
The clang missed optimization is one additional reason for this patch,
not the main one.

Yours sincerely,
Vincent Mailhol
