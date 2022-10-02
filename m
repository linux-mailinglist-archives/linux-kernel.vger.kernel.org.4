Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE75F25F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJBWZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:25:19 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BE2F036
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 15:25:17 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1327ba38599so509904fac.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dR/X9l0lxZzftkXi0hIc+Z30CqHGBUwODF6JHMoE75I=;
        b=MSpfgdmNrHP6zveBI9mWR68eGv0BRvGksivODMJJpfETfN24A1neVDT12oNaYpaSgn
         GhqGS53NmLxOdHlQNljW83ANFBeiEPL66uZcaahVbUBtF6FtQ6FCmrOvC6rEzc13AWEr
         a08avLaoXQRjngX9jCDLM5Pa4IfHWjmq4rUOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dR/X9l0lxZzftkXi0hIc+Z30CqHGBUwODF6JHMoE75I=;
        b=b9+LLnFxT2vrznAPoBJyYM8C2X6hy6xR23amRhir4p+Eo3q8e/8HcAm7d4eIqSPpKh
         p8n9ONtJRu+N2xgKLqhwXEE5ZNVZoM8wiX7kVwpLYDAErXRVBRjN6/1ex43AlE48PbwU
         FKmscBuwGojmRTyHKJOFBH6Dbv9ChFA+pjoOXgBOpAcUsjcYQOmJOWbGNWgIzKezjTpb
         bkRISCKtcjRUNssvOdzO+0AruMsg7I7UQzCK+sKfQoSJQkUv/IKNinZXFYk1CuNZ0K+l
         irPyvEBVGO0Il/xaD/LNXBVKJmi9Ex7skQZNT9MSva9fPo8Okd1dzQM4Y+hlQhwhK9XW
         JIbw==
X-Gm-Message-State: ACrzQf1GkubXE/IyaL1cfsMmEAarO7UbUnip/Pc+hgPDL4CMMVh3KqEb
        BoXtdJ8LKTdLJnJ9KB7R8D8L0C1ZHCRH1Q==
X-Google-Smtp-Source: AMsMyM4+kL9VH8xajrJtSor5XjExKZqVwpZLpiABvcoW4rKsYqUXPDmyKNY04Tz/OZPvMKx4NYMMAA==
X-Received: by 2002:a05:6870:b40f:b0:12d:1f91:3e2f with SMTP id x15-20020a056870b40f00b0012d1f913e2fmr3808571oap.220.1664749514964;
        Sun, 02 Oct 2022 15:25:14 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id l13-20020a056870218d00b0010bf07976c9sm2449585oae.41.2022.10.02.15.25.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 15:25:14 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so5716073oop.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 15:25:13 -0700 (PDT)
X-Received: by 2002:a05:6830:11c6:b0:65f:913:ff93 with SMTP id
 v6-20020a05683011c600b0065f0913ff93mr2678421otq.69.1664749513629; Sun, 02 Oct
 2022 15:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <YlvLqkIdrCp/rOsG@gondor.apana.org.au> <YlvSEHul1Rv3Ap34@arm.com>
 <YlvTNQGh+MfZFWKW@gondor.apana.org.au> <YlxATW56ZoNtmxlk@arm.com>
 <YtHo3Xu33jovwpFt@google.com> <YtIvr7t8A/OlIXrT@gondor.apana.org.au>
 <YtWeJ12GI7LxQ4IK@arm.com> <YypfJQqj8PeOp8A4@google.com> <Yzc2UrX7ndWw1vKI@arm.com>
 <CAHk-=wgPqauyKD9CoQg2AAtV=ygpS_fAahhgzPAe99k5Kush6A@mail.gmail.com>
 <Yzi/X12rQTuT9Uqk@arm.com> <CAHk-=wgNkCSQ4d6KG0Spv13rNkoF+VxaGkqLxgG3ft6j=jpA+A@mail.gmail.com>
 <CAMj1kXHQH_Z+_HKOOd8LkzwPpbMahihT89qCDkB=ofCkicoYdA@mail.gmail.com>
In-Reply-To: <CAMj1kXHQH_Z+_HKOOd8LkzwPpbMahihT89qCDkB=ofCkicoYdA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 Oct 2022 15:24:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSYF=qCbzO25U+7NzysW94655FdMq9OBgY+91a60hjgg@mail.gmail.com>
Message-ID: <CAHk-=wjSYF=qCbzO25U+7NzysW94655FdMq9OBgY+91a60hjgg@mail.gmail.com>
Subject: Re: [PATCH 07/10] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
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

On Sun, Oct 2, 2022 at 3:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Non-coherent DMA for networking is going to be fun, though.

I agree that networking is likely the main performance issue, but I
suspect 99% of the cases would come from __alloc_skb().

You might want to have help from the network drivers for the "allocate
for RX vs TX", since it ends up having very different DMA coherence
issues, as you point out.

The code actually already has a SKB_ALLOC_RX flag, but despite the
name it doesn't really mean what you'd think it means.

Similarly, that code already has magic stuff to try to be
cacheline-aligned for accesses, but it's not really for DMA coherency
reasons, just purely for performance reasons (trying to make sure that
the header accesses stay in one cacheline etc).

And to be honest, it's been years and years since I did any networking, so...

                  Linus
