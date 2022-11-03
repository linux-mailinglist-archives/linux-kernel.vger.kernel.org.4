Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69486185D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKCRLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiKCRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:10:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF11001
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:09:28 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x15so1621040qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxCfvbb+eoelACSav5gOVJGA8b7JZzX3u9t6lpOqhGc=;
        b=c21oKw15OEDs7jPQQCx5/Q6jAakEjh4QCyHrqDrHmt1tZB5JiHbbDJmM+26GNCOUuA
         n2GMHrJ6v80we2vb5tM+7RBrSn/OgbLvIvKDSypwoGrv+vFeYz+qEx5tgHNFD4SDuMUn
         DyCZcKZmr8k62mDFGein3IhVz7jo4hs0ekZoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxCfvbb+eoelACSav5gOVJGA8b7JZzX3u9t6lpOqhGc=;
        b=xs99gJIzTTVzl+h+lVLIMUrO24Lpg4eIUt4lRAZCC0QOiHDpvbe485nPRp+PL4HI05
         2kg5+Zl3vUlIRmDeYi5vT+zEQ3aXbISVOpYon1UhQzXLbqRQYxGSHR7zzeSpQUluYp4I
         asnoUQIu4tTuY5Zb5J2rhggjfCuRl6g2Ey/rHUP47QbbUoJrr7WhiiibfXWfjnQKabdF
         W21ipoBUh/zSPhetJGaozAKFUeYeyr0fuLbQiT3WcDgGNkG/dDM5/d67FLblMVYQyhu/
         +HEcmqjZ1XgmY1xACxfdGjPW9kwnlW/Q6N4p04vCzGSXgFmpdvX6MQeRrsfWa8W5F9pH
         zl2A==
X-Gm-Message-State: ACrzQf0+h35qP44e1EHt9pGsw4rTxx0r3fVo3aePFNy9ZI8B9t177Ccq
        FKBrin3V4SBtT9mG4tr/jpYdUS25RqTasA==
X-Google-Smtp-Source: AMsMyM4WFhKuXah0eQAh/vodnmRZIvQxQww3AWRoaRZp0jgZGQM6Xnrk3QwhG6OYflvGDGPVYEZLUQ==
X-Received: by 2002:ac8:4b46:0:b0:3a5:1d94:751f with SMTP id e6-20020ac84b46000000b003a51d94751fmr21338157qts.102.1667495368053;
        Thu, 03 Nov 2022 10:09:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id az18-20020a05620a171200b006bb87c4833asm1050203qkb.109.2022.11.03.10.09.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:09:27 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 187so3031327ybe.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:09:27 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr29702771ybb.184.1667495367212; Thu, 03
 Nov 2022 10:09:27 -0700 (PDT)
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
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com> <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
In-Reply-To: <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Nov 2022 10:09:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
Message-ID: <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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

On Thu, Nov 3, 2022 at 9:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But again, those changes would have made the patch bigger, which I
> didn't want at this point (and 'release_pages()' would need that
> clean-in-place anyway, unless we changed *that* too and made the whole
> page encoding be something widely available).

And just to clarify: this is not just me trying to expand the reach of my patch.

I'd suggest people look at mlock_pagevec(), and realize that LRU_PAGE
and NEW_PAGE are both *exactly* the same kind of "encoded_page" bits
that TLB_ZAP_RMAP is.

Except the mlock code does *not* show that in the type system, and
instead just passes a "struct page **" array around in pvec->pages,
and then you'd just better know that "oh, it's not *really* just a
page pointer".

So I really think that the "array of encoded page pointers" thing is a
generic notion that we *already* have.

It's just that we've done it disgustingly in the past, and I didn't
want to do that disgusting thing again.

So I would hope that the nasty things that the mlock code would some
day use the same page pointer encoding logic to actually make the
whole "this is not a page pointer that you can use directly, it has
low bits set for flags" very explicit.

I am *not* sure if then the actual encoded bits would be unified.
Probably not - you might have very different and distinct uses of the
encode_page() thing where the bits mean different things in different
contexts.

Anyway, this is me just explaining the thinking behind it all. The
page bit encoding is a very generic thing (well, "very generic" in
this case means "has at least one other independent user"), explaining
the very generic naming.

But at the same time, the particular _patch_ was meant to be very targeted.

So slightly schizophrenic name choices as a result.

             Linus
