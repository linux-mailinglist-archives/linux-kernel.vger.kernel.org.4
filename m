Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D060D200
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiJYQxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJYQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:53:46 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78AFC1E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:53:45 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j6so4614955qvn.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKWudjAq2n8ifAHtOAntYjFOTUyuiPnc8NGjNr9VGOM=;
        b=hEo/9PFOjh2FSEYpRZZLBmFbfS5Eq4CQIT2oHxOkT3LP/9cNGdU7IGIpVGzGql7Qs9
         uvm9oNvaQtvZ+ADlTtDAGzYwpapAQK78on+MJkJqRa9fYjMMnrvGnvPR1BEdKvBjaeLs
         x5YTTp1VOCOT1DA3sOouo8HkO2S/HgQhniRjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKWudjAq2n8ifAHtOAntYjFOTUyuiPnc8NGjNr9VGOM=;
        b=vVQ9n2TsHiYnsxiZmBXsgXwwg656FJ+B/gdzFdEhGGL5Gb3faDj86W+ialAocCnNFY
         l0+5Y+xZ27WaP3vumSI9MTFfpVTDozDciwXakSetTG5LPtYAcz6U6RQ8fwB14/+2JIpH
         2QbWmg4jBCTJujUrJIHpNAxZ3ExvawEjnxQ6zfl20uPmxCRQ+C0u0t8flV3coslzMx1c
         uz9kG2jvcibN6T1MzVciCHRcSUIj7LnejsY8o5LyhW4B9j2ZqqXWWColz+2iFLlnh/WI
         +2Iug06dNGkZjwl88gPmAFCTm3WE5D7qwt42c3HPMOeZERk/Nob4Sb02rX6KngWByvPG
         UJsg==
X-Gm-Message-State: ACrzQf33jp/n0LK+jxEE9RkjVcELday/rYFyi6/BZqioh4RD40KxAML8
        x27NVOX8KnbuUZ7heSvq4axJ7GFaHZybdQ==
X-Google-Smtp-Source: AMsMyM7T9F+kfZot1kGBdnq70olxnnfI7Ne3+yBAIM/GKIUBR5pAGG1D4laBsWMdjLC6QPvdK6ddZw==
X-Received: by 2002:a05:6214:2389:b0:4bb:59ec:c5b1 with SMTP id fw9-20020a056214238900b004bb59ecc5b1mr17865093qvb.48.1666716823975;
        Tue, 25 Oct 2022 09:53:43 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id j22-20020a05620a411600b006eef13ef4c8sm2360337qko.94.2022.10.25.09.53.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:53:43 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-36cbcda2157so62764057b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:53:43 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr35019201ywl.112.1666716822972; Tue, 25
 Oct 2022 09:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221024114536.44686c83@gandalf.local.home> <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home> <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
 <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net> <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 09:53:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com>
Message-ID: <CAHk-=wjwjWAhPD=C7sW7804eOTSQRnpSrrQh44PFYpVjn8SjKg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 3:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> This seems to boot...

This looks much better, thanks.

But this:

> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> @@ -801,8 +803,9 @@ void __init poking_init(void)
>         spinlock_t *ptl;
>         pte_t *ptep;
>
> -       poking_mm = copy_init_mm();
> -       BUG_ON(!poking_mm);
> +       __poking_mm = init_mm;
> +       mm_init(&__poking_mm, NULL, __poking_mm.user_ns);
> +       poking_mm = &__poking_mm;

Should probably be just

        poking_mm = mm_alloc();

because we shouldn't be messing with 'mm_init()' in places like this,
and we shouldn't be exporting it either:

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1104,7 +1104,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
>  #endif
>  }
>
> -static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
> +struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,

since "mm_alloc()" would seem to be exactly what we need, and it's
what execve() already uses. It creates a new VM with nothing attached,
ready to be populated.

Or is there some reason why mm_alloc() doesn't work? It does require
"current" and "current->user_ns" to be set up, but that should be true
even during _very_ early boot.

                Linus
