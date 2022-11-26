Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1763981D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKZTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKZTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:54 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F001C92C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:13:42 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 136so6514491pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPJu+jZjV0HF0T3O/nCnlgZiVdaWzUPqt5uvtlZaGzY=;
        b=dGPoELH6LYY/NsUqxEUPysiRcKM5+5tvV2nxV8r7QxSK5xrXtnkQzxIGbI9apCaMY2
         MpQ6pZoounyJeXG0FbPgepU72AUH29pZfio+7PM1letpGsxN2vhtjyK8/i74fcKOMR2I
         922bznRDlU+11wHr4T4H3TNPZbmc31eL+Vu7CfYsvf0E3Hw5kntFGrWBzS1bv9odmIqr
         6pejvL1GkvJOARDLAvJKqGsg6rqyuIqdDpXiCcfka8DF3/teIf+FzpmdLpiQaHMKA447
         IHylVwJwx6y7eUsHMW4ZfXyV8NCvU+YAuRJAceSpmr9AiSHLv0BfyaXUpDt9VHo+WsEf
         YLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPJu+jZjV0HF0T3O/nCnlgZiVdaWzUPqt5uvtlZaGzY=;
        b=y8K7x/KHU0rZPCHRJE/CX7wwu/7vnkqjtVl+0P2UUEoFGuJX5c3fke62ybNOTQc7Z+
         eFw2wE9L5GiRLCrQyZEzOga+jIXLKz1xhxixkozP2nUtkyh6Q9jvG/tVT5c082bVlkXw
         rB7S5M1ReIe5bc8fmQxRh/Y5zICdfElXxcwtgnqe+c/jLOiUzmkNVqzwGYTPzPmsP0tZ
         ei88NS7HqJYTM+j6rvQYKttes8H0PR+t9Gdwnj9TDl61TzvBssFPgqCgZW38H95uD79J
         mfEcn2oTE4RfHk3r5bUWWGNU6KCM3XsIPXIQBhaD0wNBLS4RllAoUXDxTp+wBZ7+Vz/5
         1bDA==
X-Gm-Message-State: ANoB5pnK8vFePcp9aI7tmvdJaapIw17M+YYxA/E0/9LWSFC/L8/HSvE6
        ZVGfz9105bBLCCD2oyo+uThx8ji1XZk1zltVQCU=
X-Google-Smtp-Source: AA0mqf7nfGi+HzFfofWXjZoc0oQtcKaZp0Gx2vHhUFS0/wlAGVRIzDXGXm+kG/SBkAdaS32NWnXtOtznaATukPjlPFg=
X-Received: by 2002:a63:f00e:0:b0:477:5e25:6d4c with SMTP id
 k14-20020a63f00e000000b004775e256d4cmr22089354pgh.159.1669490022359; Sat, 26
 Nov 2022 11:13:42 -0800 (PST)
MIME-Version: 1.0
References: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
 <Y13oij+hiJgQ9BXj@elver.google.com>
In-Reply-To: <Y13oij+hiJgQ9BXj@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Nov 2022 20:13:31 +0100
Message-ID: <CA+fCnZficLHbDpqjn-wiQhg9dTTO8HjLSwAOLGuPgd8O511F4A@mail.gmail.com>
Subject: Re: [PATCH] kasan: allow sampling page_alloc allocations for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 3:59 AM Marco Elver <elver@google.com> wrote:
>
> > +- ``kasan.page_alloc.sample=<sampling frequency>`` makes KASAN tag only
>
> Frequency is number of samples per frame (unit time, or if used
> non-temporally like here, population size).
>
> [1] https://en.wikipedia.org/wiki/Systematic_sampling
>
> You're using it as an interval, so I'd just replace uses of frequency
> with "interval" appropriately here and elsewhere.

Done in v2.

> > +static inline bool kasan_sample_page_alloc(void)
> > +{
> > +     unsigned long *count = this_cpu_ptr(&kasan_page_alloc_count);
>
> this_cpu_inc_return()
>
> without it, you need to ensure preemption is disabled around here.
>
> > +
> > +     return (*count)++ % kasan_page_alloc_sample == 0;
>
> Doing '%' is a potentially costly operation if called in a fast-path.
>
> We can generate better code with (rename 'count' -> 'skip'):
>
>         long skip_next = this_cpu_dec_return(kasan_page_alloc_skip);
>
>         if (skip_next < 0) {
>                 this_cpu_write(kasan_page_alloc_skip, kasan_page_alloc_sample - 1);
>                 return true;
>         }
>
>         return false;

Done in v2.

Thank you, Marco!
