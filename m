Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B95613C35
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJaRdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJaRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:33:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD6611179
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:33:11 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id o8so8779849qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wO1aXGez9nOhy2a+Zn5RD+RAHyQUNPFJqnfXakKdh28=;
        b=f5ptxWlLLcXdghefXYE0GvwEBlSe2liMn3DrOmZMCY7LFSlAbtO0iLErEaZVfejg/Y
         Kx/GBuhsRS3JG5bobpj9w6WcYfAH9TsouB6zoEn9T6kaOeTfZxIHJB9lag9lVgkmsAN2
         M/FvOPQtTrbDWHeQVYWxfpFrLN57Pme71gDxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wO1aXGez9nOhy2a+Zn5RD+RAHyQUNPFJqnfXakKdh28=;
        b=7dqFzjddaenf8N2T0EWbbtpZ/7EDwAE+c3MN3tH/r6JSNj8WDxStuBSYUYpdA4cKJZ
         4GHGNaRZsZSgC0oQ7j2CQOBSZ9Seh1OZlzQwSzgl1cex+3ChwjEwQSFNH8ySCfJ8PAZL
         IM4dZDtthe9/eT+a0j8vxGFSJbkqmsFEmwnehNBF1kbjPvvFoNUsbsK7oh7EY2h9ZzMK
         wFV3mBgVutLzhOZPPSOyEt4kSTINUReloh5ycj4wlsWpiaSd+zMPNtTaSLY6Vd9R2C5d
         31PYXRe1mCUkMbVLHgy/h2aGbXugrk1HU+QR9chwU3SgIWMNhWycaukzmjV9/vORnO8g
         6cAw==
X-Gm-Message-State: ACrzQf1Cw0lLcUoW9XM4VxdkdnarRyedZd8UWbTZCdmE8wJMlhZLLpKy
        mL9mm6dIxf9CFjCXg7j1gRGDgtGRdiq+xg==
X-Google-Smtp-Source: AMsMyM6N7PBbCY7teQy/ElTbFYdKvlxm7BhnTh02+8XqXUYF4iANrx19NaygW834eWkBFaV2Se0Pig==
X-Received: by 2002:a05:6214:2689:b0:4b7:235b:b607 with SMTP id gm9-20020a056214268900b004b7235bb607mr12127421qvb.108.1667237590087;
        Mon, 31 Oct 2022 10:33:10 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006f1187ca494sm4683845qkp.28.2022.10.31.10.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:33:09 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id f205so14544417yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:33:09 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr14959950ybu.310.1667237588682; Mon, 31
 Oct 2022 10:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com> <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net> <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net> <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net> <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com> <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com> <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com> <CAHk-=wjZnVURfhWMmWiDX3D0kuqnJ0PLM_Na-U7ufzqPMxucjw@mail.gmail.com>
 <0E3DDDE4-FD20-40ED-A418-222AAA546596@gmail.com>
In-Reply-To: <0E3DDDE4-FD20-40ED-A418-222AAA546596@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:32:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFYaJ2XyWHH1UjXUS58wMi9M069E9f_5wbU=w2_fcD2Q@mail.gmail.com>
Message-ID: <CAHk-=wgFYaJ2XyWHH1UjXUS58wMi9M069E9f_5wbU=w2_fcD2Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 8:43 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> On Oct 30, 2022, at 10:00 PM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>
> > So the current ordering rules are basically that we need to do
> > set_page_dirty() *and* we need to flush the TLB's before dropping the
> > page table lock. That's what gets us serialized with "mkclean=E2=80=9D.
>
> I understand. I am still not sure whether ordering the set_page_dirty() a=
nd
> dropping the mapcount reference cannot suffice for the reclaim logic not =
to
> free the buffers if the page is dirtied.

Ahh, ok.

> According to the code, shrink_page_list() first checks for folio_mapped()
> and then for folio_test_dirty() to check whether pageout() is necessary.
> IIUC, the buffers are not dropped up to this point and set_page_dirty()
> would always set the page-struct dirty bit.
>
> IOW: In shrink_page_list(), when we decide on whether to pageout(), we
> should see whether the page is dirty (give or take smp_rmb()).
>
> But this is an optimization and I do not know all the cases in which buff=
ers
> might be dropped. My intuition says that they cannot be dropped while
> mapcount !=3D 0, but I need to further explore it.

Yes, the above sounds like one fairly good way out of the whole forced
TLB flushing for dirty pages, while still keeping the filesystem code
happy.

But at this point it's an independent issue.

And I really would like any fix like that to also fix the whole issue
with GUP too, which seems related.

           Linus
