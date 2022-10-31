Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0A613C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJaR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiJaR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:28:33 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE486DFA7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:28:31 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id n18so8752847qvt.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GiwfLGsYKGKqvxfaUpvxh0ddsH6A8EMDdI1AAfBFwR8=;
        b=RJNXAl4sM9GOrR3xZaI/kd+gZP5+ucsr4fxQ1xRHNzAZOEbQdWzufnFOZiVAuQVEvy
         AIf797KosLKauy7PMx7QOiM6NTVoi/1tH3GEgdYxHPu0xDEF215vvchzlmNUv5XdIXen
         b3pm08YtfvWylBjAPcC15K5d4vJdlZCZJygIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiwfLGsYKGKqvxfaUpvxh0ddsH6A8EMDdI1AAfBFwR8=;
        b=ukFFo7DcYRVchM1gKeMz+m0XtfusZjFxxK0SH9NCUrApG1GOBNGAFVnNQX4RUgOWni
         bP7DsICMTz9U7TvuMzNKqg3VfxtT2Fvrij+nXWuYX2uZg6zzgNSlrY72b/TlQAfLKzcs
         St57XPr79awUZ4i3ZTe95wuYWAGr7d2DobpH23TdAaqPP+G2KlZNReCQdpMYxKNoT0ZH
         SXbhrukmKnA1hCNeW5z1WzxOi0k3HbHiXg+l3swchmCGKnL3Agsa7MeebwlnROERVAaV
         TujW0RIdfCJidWBTm7USSN12yS3/xUWXJ12gHXFf9OnbVMiYF7alWFqPzyRCyjN+Nfgz
         p3Hg==
X-Gm-Message-State: ACrzQf1j8v7nVRNbKSJrboQD2FNfpJlVn3d29X3+T/E6zV25WV6zFdqf
        DPEEt9SnDoDIJTm2qZeohtBxF9xu/BviUQ==
X-Google-Smtp-Source: AMsMyM6i4XTiDDO1ZpzG7SL/0D8Ra187WfDEW52ptZdzbvjGbhpJDGoW3yEZFwXFu9I+VgvU+8KCZA==
X-Received: by 2002:a05:6214:226b:b0:4bb:6500:8f44 with SMTP id gs11-20020a056214226b00b004bb65008f44mr11987042qvb.109.1667237310855;
        Mon, 31 Oct 2022 10:28:30 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id j4-20020ac84c84000000b0039cc665d60fsm3913128qtv.64.2022.10.31.10.28.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:28:29 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o70so14494523yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:28:28 -0700 (PDT)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr12896451ybu.101.1667237307861; Mon, 31
 Oct 2022 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com> <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
Message-ID: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 2:36 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> >  (c) move it to clean_and_free_pages_and_swap_cache() that actually
> > does the page_zap_pte_rmap() now.
>
> I'm leaning towards (c); simply because the error case is so terrifying
> I feel we should check for it (and I do have vague memories of us
> actually hitting something like this in the very distant past).

Ok. At that point we no longer have the pte or the virtual address, so
it's not goign to be exactly the same debug output.

But I think it ends up being fairly natural to do

        VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);

instead, and I've fixed that last patch up to do that.

                      Linus
