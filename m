Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C6A616C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKBS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBS2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:28:20 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D591EEC8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:28:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v8so5852587qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkh6E9H5or1YlWc4iLnwjF2u8GuATub7/RIB4RZroEI=;
        b=PUV2oYskmBz3NBHQa4xg86wO3U87o5XqjQwsvV7oSoiTe/piGIP5nBJpJ45viq+R2Z
         bAj40imTzIsGbqe0Q7TSsJdMOqjUHrqbe1jzVK5k0jJ0wCIP4faAmk2wQnUzpuSnBsj1
         Y3Q9jDnJzlfkaTRvkFbL51E9vliot00WDNmm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tkh6E9H5or1YlWc4iLnwjF2u8GuATub7/RIB4RZroEI=;
        b=JudKP1Tr69jW5AfSfn0E+hXFfgrEk8oW0y5jgYDJI0vA5Odq9glYWo6yiX3815UHyf
         VF+9EFGjJCuafmHyYSolfCGuv8PrMkC6BQx+d1hV5vpa6rN3xGbwM2GW3qrXCDIanThS
         YQQnGEmwP7iPNrml0HUqH+lw4ADHc9o0Vl+TO8C4O8mkwk9cuspr3oQsyEZaFfwvC74W
         WLERBtKFhOqN3YkPZ+1Cbe4IkYbbxCFWZSuXGoV5S2UIM6QcqI9A0mPz3tVJMCJX9R2d
         VTV68sXYEuYM3fJ3TsYlTGsXS0K9iMDZCD1yvMW27/Zp24eO5xBc/2cIikfm0uXEVP6I
         H3Qw==
X-Gm-Message-State: ACrzQf1Z5NHcr4f9mCNFzA1aMoRCHabe9MARmPF4xZsMhb0a26MV7OR4
        zvF01qWUTeZ7DDRT61bnfA/A/LxCIjvStg==
X-Google-Smtp-Source: AMsMyM5yuoOGp9tQ7TAUtjJfndkpg73kgaCxm4KRuG/6CKVhfssKYNSLHdqfgSeR+3QIuZBIK99dKw==
X-Received: by 2002:a37:af06:0:b0:6f9:9485:fb11 with SMTP id y6-20020a37af06000000b006f99485fb11mr18392527qke.387.1667413698551;
        Wed, 02 Nov 2022 11:28:18 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id l10-20020a37f90a000000b006b9c9b7db8bsm9000696qkj.82.2022.11.02.11.28.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 11:28:17 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-333a4a5d495so174286477b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:28:17 -0700 (PDT)
X-Received: by 2002:a81:8241:0:b0:370:5fad:47f0 with SMTP id
 s62-20020a818241000000b003705fad47f0mr16875068ywf.441.1667413697206; Wed, 02
 Nov 2022 11:28:17 -0700 (PDT)
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
 <50458458-9b57-aa5a-0d67-692cc4dbf2ad@linux.ibm.com> <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
In-Reply-To: <CAHk-=wja5+tuvbV6vzJSbLBWSR8--WUq-ss0j0K-JQXe_EsqhQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Nov 2022 11:28:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikAVbx6OUUGXpgVZNzTKK_dHhn6HyNvcf5eRKC+LkF9g@mail.gmail.com>
Message-ID: <CAHk-=wikAVbx6OUUGXpgVZNzTKK_dHhn6HyNvcf5eRKC+LkF9g@mail.gmail.com>
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

On Wed, Nov 2, 2022 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I'll do that minimal fix and update that branch, but if s390 people
> end up having a better fix, please holler.

I've updated the branch with that, so hopefully s390 builds now.

I also fixed a typo in the commit message and added Peter's ack. Other
than that it's all the same it was before.

                 Linus
