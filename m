Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A4611A93
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ1TB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ1TBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:01:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE57C1CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:01:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n18so4658330qvt.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIwwzQ52IEhNmyzDAzU0ih5As/W0jQ4hNeXK+64Ku7o=;
        b=dAaQfzFs+SdCLAPkoyqFQIxIHJaSfBF9EyPjoJYiYLJIYncHJPDC1AWNbmW4uKEyDH
         9NxhKwER2hWbwLcAf0VUSfJp2GSfcFGTXkdOf+Ad5p5A2iJpb+zT0GT02cDaxmuZb7YM
         3hKQMYYTEs6dzVW4pUbdS5zLhKBT2QivIHTcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIwwzQ52IEhNmyzDAzU0ih5As/W0jQ4hNeXK+64Ku7o=;
        b=KugSwvJEBOTlt1XEgYnL2Vlsx91cSTp7lx0sXm2CKaKcqp8gHAStZKBswZoKGI9u9K
         hyVvMppbDUa/iWJuWiUUG/bVs+ExqmgBRRlBvH4Az4idCwFmihLOKOaZb6BudqOua39x
         TRt7a1k6P2J41Xj0tJCCWKxcTT+fAE51eRpImeqZ1CUriNqrNLaaBpHu3HVPjoj2HCAN
         ZL9Kn8U5Jx9Xa0zmSIjNaKThh/M/hLNclmmtOXMQO1erADAEY/QusbGMo7hECLPDEt3t
         aCSn+22DtwW8xClfYLM1Z7bpDTF3iEiJu9GwjpaAi6mc6RcMgiVwsx69RK3qQOpg/Z0G
         z6Lg==
X-Gm-Message-State: ACrzQf0dSbyx8ylPx39aKMg+b8hqlagaw88MsxJxt8Jg08RIdXR5SWBw
        cPlYbhtWKO9J4QXw0lRSRybUcnfltHXSFA==
X-Google-Smtp-Source: AMsMyM5eKNjeZpiUkqGMZkTi/BhjLkwcUjGTXvU5xDsc/UaLLpSPKS3z3eIvgLP7amj9MX0k7dge6g==
X-Received: by 2002:ad4:5bee:0:b0:4bb:a365:2da8 with SMTP id k14-20020ad45bee000000b004bba3652da8mr817205qvc.81.1666983677849;
        Fri, 28 Oct 2022 12:01:17 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a401000b006aedb35d8a1sm3554644qko.74.2022.10.28.12.01.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:01:17 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-369426664f9so55215017b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:01:16 -0700 (PDT)
X-Received: by 2002:a81:1902:0:b0:36b:2578:f6e2 with SMTP id
 2-20020a811902000000b0036b2578f6e2mr887557ywz.352.1666983676543; Fri, 28 Oct
 2022 12:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk> <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com> <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
In-Reply-To: <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 12:01:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
Message-ID: <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:45 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> For the _find_first_bit, there isn't much difference in the number
> of instructions or really what is going on, only the organisation
> and flow of the code is more inline - but that shouldn't make much
> of a difference. Yet, there is a definite repeatable measurable
> difference between the two:

Hmm. Interestingly, your _find_first_zero_bit_le() (which
find_next_bit ends up using except for the first byte) ends up doing
an optimization that is technically not valid.

In particular, the *generic* code does

                        sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);

for the final result.

In contrast, the arm code doesn't do the "min()" at all, and if there
are bits after the bitmap (in a partial byte), it will just return
those bits.

So the arm code ends up avoiding some operations. Which works most of
the time, because

 (a) usually bitmaps are byte-aligned anyway

 (b) most users do "find_first_bit(.., size) >= size" as the "found no
bits" test

but it actually looks to me like your handcoded arm code is simply
wrong. At least going by our docbook comments for find_first_bit:

 * Returns the bit number of the first set bit.
 * If no bits are set, returns @size.

And look here: bitmap_empty() does

        return find_first_bit(src, nbits) == nbits;

and now imagine that 'nbits' is not a small constant value (which we
handle separately) and is also not byte aligned.

Maybe I'm mis-reading your assembly (I "know" arm assembly, but I
can't read it fluently like x86). But I don't think so.

So I think your code is actually buggy, but probably the bug is quite
hard to trigger in practice due to (a)/(b) above.

We do have bitmaps that aren't byte-aligned. The cpumask ones are the
most common ones. But in the cpumask_first() implementation (which is
just a wrapper for find_first_bit()), our documentation actually says

 * Returns >= nr_cpu_ids if no cpus set.

and I think that may have been what we historically did elsewhere too,
and may be the source of the arm situation.

Anyway, this can be fixed by either

 (a) fixing the arm code

 (b) changing the docs and making that ">= size" be the right thing to do

but I do think this is a very strong example of why having
architecture-specific code like this is very very dangerous. Because
as it stands now, that arm code really looks like it's actively buggy
to me.

         Linus
