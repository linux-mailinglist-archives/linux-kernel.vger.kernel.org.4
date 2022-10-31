Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929CE613C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiJaRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:22:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A3CF58F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:22:28 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so8756327qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3GM39Y/a0Zu/maiuHadjgqBz1XJPD+6WNcGDdRcKy3U=;
        b=f+HMKJV04LvzsxQjIozO7/pRF6Pe9w1rYNd9CbH0ULVTs1nlba3vK/8dpmdXqmb5S/
         qs3LOxAp/QFScrOQuwubce7qGKUy0Obi8eFZEDa0CgB5lS0c4CPA79R08BEse78v5WCi
         ruV9q9q9SPyAdrjJXjM//VavgQGu83SOrYaEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GM39Y/a0Zu/maiuHadjgqBz1XJPD+6WNcGDdRcKy3U=;
        b=mWqQF3M8sPmM2Klfw2ksdQctLvbbr+RFCQTZUPJo71MGgyEJm4kJ/tAnvORGVkcHL8
         T73YfTkR7tk3eHTdcShfWXBSYAxBznHyziHWE3cB2AK1ht72EuQFvXjPl2qHWWsLR9S4
         cLLmbgHAzHtp5BB2+v5mFAAsSA3lBlcCZuTpepw8+qdVq99W+s/o0k/TfeBzX47N79lT
         eFFi9BEKutTOZ5A0kAXN6fnA67Lc0Lj3RiPWTaEKAvQWPKvO9S0J8ZdNYJNR9jcHsbo0
         6woVw5Em+hoKZ4u19ZWTG0nMf/k/2yosajj6nCigp/nrB+PDPfe+/zN4xxI3qzNA6As9
         N22Q==
X-Gm-Message-State: ACrzQf1lVaEi/faj/MpwBL8fqLYeGiORuHJ6WD9ujHKPOrnmG04WSNK/
        DkuFPjvM48/fFuLLHg2YzbvXOfxCXVh4Cg==
X-Google-Smtp-Source: AMsMyM7YYbD1oEu3cQrpIN5ba0aBCLQ7322Dz598MFU6KsN5vkl7skwrx+R9joXwJsC/Qxkb1Tn/5Q==
X-Received: by 2002:a05:6214:5292:b0:4bb:634d:6505 with SMTP id kj18-20020a056214529200b004bb634d6505mr12069730qvb.61.1667236947850;
        Mon, 31 Oct 2022 10:22:27 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006f474e6a715sm4987630qkp.131.2022.10.31.10.22.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:22:25 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-333a4a5d495so113974437b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:22:25 -0700 (PDT)
X-Received: by 2002:a81:a50c:0:b0:370:3982:4fda with SMTP id
 u12-20020a81a50c000000b0037039824fdamr11641701ywg.401.1667236944953; Mon, 31
 Oct 2022 10:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com> <Y1+X0apcRv0dKyDc@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1+X0apcRv0dKyDc@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 10:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5AByhMt4uvQsxotTfN19+m1CEedpyXPPnWK1x2dikFA@mail.gmail.com>
Message-ID: <CAHk-=wj5AByhMt4uvQsxotTfN19+m1CEedpyXPPnWK1x2dikFA@mail.gmail.com>
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

On Mon, Oct 31, 2022 at 2:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> You're making up new words ;-)
>
>   s/compund/compound/g

Oops.

Fixed. Thanks,

              Linus
