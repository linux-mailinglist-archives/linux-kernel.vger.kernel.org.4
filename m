Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028146203F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 00:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiKGXsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 18:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKGXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 18:47:59 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1294D1C91F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 15:47:59 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f8so8218888qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2nUGmNm82TyRLx97jZms1dOOGi76NwVe8JFuVeWiOQg=;
        b=My5uqWQwXOffTiWXNHqYQhulwxGxYGEm7K9+0FNU7iSCJTiHIpLKcqjmRdDQF+ZBkb
         Pg1ba84w3LhFXgshAIEFlqw202AajwYhP3vp8snD7MElUpy1fGUKi0JL4ot9xEL1OZHD
         srxGnutg7uHNcTHztzXfNg/I2NN1QnphRTqmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nUGmNm82TyRLx97jZms1dOOGi76NwVe8JFuVeWiOQg=;
        b=PWd30J+MdyM8UEneOjhFJ9r3bpshdMBh5DENCkkCjdWYZxwUz6gWVUJdXxDKcAqccX
         WDV5Zkt/KOBLEj5WelD35+mLsoZgKQBimL72oReRQtktXySifRMwpp3H1LMR48GlwcRw
         cizTRCi31yAo2dXUZdPW9t8Xyv40CN9M2BGobBnuiFIXguxS4LlmZpV2Tq0/CD7A8gTP
         wD8LHMjvA7ojCMruXpTcFRrtDejyF6LO0Ua2GRNKGxMuS01N6KZCpC30WcihXU2iNEHo
         r8Q4bvGRCjWHJxD2DDJP6Pqy+xt1EvGsTDQmF+XMZ7l7lAB49oKyn27WdR9gKokHjWjz
         9tLw==
X-Gm-Message-State: ACrzQf29ATInoFxCF1JjbM2z5ouBPNf8KEZpLuZ24wDjdHf/vp5SbFx7
        Lt7VKm269YyB/k0ZKGdU/eiUEeT/Zoh5Sw==
X-Google-Smtp-Source: AMsMyM4NBXtuUM/spIc9bl+Tof/EE9I8vVpVsTcwMCS9aqyHF/RhcAmWzU7J4mUJAl139S75jWySPw==
X-Received: by 2002:a05:620a:12ca:b0:6fa:24c3:bb17 with SMTP id e10-20020a05620a12ca00b006fa24c3bb17mr33246039qkl.393.1667864878010;
        Mon, 07 Nov 2022 15:47:58 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id cj25-20020a05622a259900b003a4c3c4d2d4sm7004428qtb.49.2022.11.07.15.47.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 15:47:56 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-370547b8ca0so120016447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 15:47:55 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr51708860ywr.58.1667864875345; Mon, 07
 Nov 2022 15:47:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
 <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
In-Reply-To: <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 15:47:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
Message-ID: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
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

On Mon, Nov 7, 2022 at 12:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, if always doing the rmap removal under the page table lock
> means that that memcg lock can just be deleted in that whole path, I
> will certainly bow to _that_ simplification instead, and just handle
> the dirty pages after the TLB flush but before the page table drop.

Ok, so I think I have a fairly clean way to do this.

Let me try to make that series look reasonable, although it might be
until tomorrow. I'll need to massage my mess into not just prettier
code, but a sane history.

               Linus
