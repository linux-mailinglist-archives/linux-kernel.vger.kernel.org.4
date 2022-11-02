Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAC616B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKBRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiKBRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:55:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C02EF1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:55:27 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j6so12955756qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tfgl/2wz1H/8UpZUR1BGxO9QY8fMwSWN8ozNgnnwNo=;
        b=NeK0NeRjuTAZUtHhMjgNyr6bYudXXk6DWAHX3bTjmN4JSWdzL6JeZGWMcTF+HKB1jh
         MxgfTRp94CqtCSRHcGW+QimC0eY6cr+M+yV1ssIcn+3APuGyZYLufIf07JWzaUc4957/
         eUOIf2N32qzKN+9Hwta9aX6xiuqzbYaFCmZks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tfgl/2wz1H/8UpZUR1BGxO9QY8fMwSWN8ozNgnnwNo=;
        b=iZ6K/bEH88+6VjWaw/i153vuVG1CM3M+2xShy5kTGZaCeGWgqGJssVpB6TKKIl2rP2
         AS4UwAXJKlAbeoZ9eEfB45XFtW725QnpinmBmnD7lGKi7mrixQLonphJDV4/rGNP95BO
         Qa/KQTKcgP+1xJXmFeDW6fTnBwHtn3vpbMo6mHqdVa6rX2gnCxV65QQyu/SKByiA+aLL
         /+pB6VKoVWF6Sr1K5kuRcvjyCm7SsUMAayoFh1xeHy4ZEGDZxDw+6benGqtlqWpD0LwH
         z4wsEjaZTa/n9++DwpbDwcBNh/rIuXaL4EC/9VaT9D3jwofHVoisqovUYPAWsId0eAlI
         q/lw==
X-Gm-Message-State: ACrzQf3+AQYwLcayUwznrugrXirqBZdD4MI7Gw10ROuRY4JZdSiw+eYK
        IbPGMqwBQ/O3S1/65QMcY8gLtyBy1LJP/w==
X-Google-Smtp-Source: AMsMyM7NjgekpBMl3QVBN5F1YXh/SdrfP+q+VHI3Bc64HQiTUw/I4OdZw64aQ0oacPlpJGt8IuiSLw==
X-Received: by 2002:a05:6214:623:b0:4bb:91d1:53cb with SMTP id a3-20020a056214062300b004bb91d153cbmr22345277qvx.64.1667411726835;
        Wed, 02 Nov 2022 10:55:26 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id q68-20020a378e47000000b006b929a56a2bsm8802313qkd.3.2022.11.02.10.55.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:55:26 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-37063f855e5so87245687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:55:26 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr25201108ywr.58.1667411726040; Wed, 02
 Nov 2022 10:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
In-Reply-To: <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Nov 2022 10:55:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
Message-ID: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Nov 2, 2022 at 2:15 AM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> It certainly needs a build fix for s390:
>
> In file included from kernel/sched/core.c:78:
> ./arch/s390/include/asm/tlb.h: In function '__tlb_remove_page_size':
> ./arch/s390/include/asm/tlb.h:50:17: error: implicit declaration of function 'page_zap_pte_rmap' [-Werror=implicit-function-declaration]
>     50 |                 page_zap_pte_rmap(page);
>        |                 ^~~~~~~~~~~~~~~~~

Hmm. I'm not sure if I can add a

   #include <linux/rmap.h>

to that s390 asm header file without causing more issues.

The minimal damage would probably be to duplicate the declaration of
page_zap_pte_rmap() in the s390 asm/tlb.h header where it is used.

Not pretty to have two different declarations of that thing, but
anything that then includes both <asm/tlb.h> and <linux/rmap.h> (which
is much of mm) would then verify the consistency of  them.

So I'll do that minimal fix and update that branch, but if s390 people
end up having a better fix, please holler.

                Linus
