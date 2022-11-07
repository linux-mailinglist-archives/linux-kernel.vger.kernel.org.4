Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F561F9AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiKGQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKGQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:28:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A621E2C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:25:55 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z17so1134922qki.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kS5Pd4xumBsprbId/IA6yh5RFHUTXxa1KEDWNlrvRnQ=;
        b=TSx33kRVgTxwulhwu2I6HxDcJEacmgp8MpGqnsCbyyj3XKkEiEz7XfhbF6iMISUiSf
         lWFxDCgHXjWD2RntcRxTwHA6kde5XD3KVptLM4Y1ds4p7N5lQHTV+2HCsAWLYVpjiqsn
         ynk+bNf25hjGJ9F9siieMFz9fyb/GECkwDR7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS5Pd4xumBsprbId/IA6yh5RFHUTXxa1KEDWNlrvRnQ=;
        b=stGPiGzFt7FonGo6nNFxML58rwlLyNMXBQ448LBSXsiOP1EGQzRkBG6O+jH67kZWox
         7vjr/2yiWgyPdfMdKhC3Wq4bvlnf3AU/BOM8rZdX3ny/TAPfqZaoskU2lFK0WjeT92Yi
         t3aNZRJlIJNTCIehK+dDrQEd/JEbWAJMirnI4WaDrfdMntHgED/Nr92WbJNq0tQjicqa
         /uc/Y+JW0jNYTZ2lpyEjcyV1QgjhhlnFrhg4xywKJC6GebWErJa4eKuTmPnT5ovCdRU4
         2jzZAEIZdO/hWL03RR//LO1kaul51JCd+vqs6bP5rjwqVf76xfSz19ckgaWIhjnWcYde
         MdxA==
X-Gm-Message-State: ACrzQf2PrDbF2UQhleWBkWEYk/CkZ/oAa9NoJyOziv3Mylb1xjft81wM
        OrDAQq4lzs/aAXPOwKCn4f6jcnxnyiPCzw==
X-Google-Smtp-Source: AMsMyM7uHXiPd6ScFucWzO5UnaK0ikjjYZkfyzndI2llx5o/4K8XpD6JagGIjo3FvcUGtuO/KjJ1Wg==
X-Received: by 2002:a05:620a:16da:b0:6fa:65:db52 with SMTP id a26-20020a05620a16da00b006fa0065db52mr35122101qkn.173.1667838354384;
        Mon, 07 Nov 2022 08:25:54 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006cbc00db595sm7265119qkp.23.2022.11.07.08.25.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:25:54 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3701a0681daso109485097b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 08:25:53 -0800 (PST)
X-Received: by 2002:a81:8485:0:b0:369:a331:c737 with SMTP id
 u127-20020a818485000000b00369a331c737mr760030ywf.401.1667837980584; Mon, 07
 Nov 2022 08:19:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
 <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
In-Reply-To: <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 08:19:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
Message-ID: <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
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

On Sun, Nov 6, 2022 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Yes, I've removed both serieses and shall push the tree out within half
> an hour from now.

Oh, can you please just put Hugh's series back in?

I don't love the mapcount changes, but I'm going to re-do my parts so
that there is no clash with them.

And while I'd much rather see the mapcounts done another way, that's a
completely separate issue.

                Linus
