Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3E688733
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjBBS4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBBS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:56:51 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4FD7D99D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:56:41 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-520dad0a7d2so39031837b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNgvCo2oTHEiKopp90V0O7XCGsFhK/RxZsHKCR63ks=;
        b=LrK+WfLmKwdRQHt/LiBQdJnHysNiaPCxZlA7JNmEHd4luIwC2Whh9/6MbF7mlsYTPB
         Jp8rqYjfebQyi24GQKpUvOKei59glITHDUgkAMGHhYhruzxkLCpR45y6fwUBziuJ0VL+
         maFIYp2sQZ9dPkfrCO8Ht83u3RjyIHVTiakAODC4zhCWY3nB+nOD1OWx5rHUfcP5rFad
         WZ1Wp4gsFLmUbhkmtu0qb+jDWKNnejZkucuGqlu+yUO5HTHiXKSU/owrE/ENWvD6krcu
         Yas6UOaq4YmJnkr4sBt9taPWvDWTEeusQezaLsW8Ffld+TLhuSpgczdR0xEit/12dZUx
         Ywlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtNgvCo2oTHEiKopp90V0O7XCGsFhK/RxZsHKCR63ks=;
        b=e27IzJv/wpwwm1AvheHyxns8PSSaXkAepmyajujgJFPabn1dXOPR8bIZhrEa41Grig
         bLYWq8PrtPyqadW3bBksxmkS4GOL/TgtFR9vxyH1BHjx1RvI/YvCptN5+vb4snFCO4fD
         wYtdtGonw8Gs/SdBUtgIJTICWKlF9SwBJAGFD9Sy0BKz/pJhiiB0gXiOtfoA2W8bAO5k
         GG+EEmEOsGqH6iUtdYVKGhcT+CntNVmAbzpxwhmvUksWtzGS3zxkTc9Pgphpr796Diqb
         te0Sg+dPcuOOykIqkq17Kq+mb0v4wIRiFb4ir3VA/IDJrDwC49B7zWCo9kHKlAf9ul89
         adYA==
X-Gm-Message-State: AO0yUKV4qhVWi979JlrOtK3izAB3s8pfPEGsaUNp5hM6G9pDvlKlcju7
        z99R5EWGBMff1sXs+gJI3URzaeEIAAKtYQV0Sv8l
X-Google-Smtp-Source: AK7set+OUDqGn8Z+7j+Ty2VVT8mhQmN6lNPvR4vFF+dIe6K2N8c9ihLcTibuzT6TLRDAmatY0gIn7AIA6gKd2v9lV6U=
X-Received: by 2002:a05:690c:82c:b0:500:81cf:8017 with SMTP id
 by12-20020a05690c082c00b0050081cf8017mr811909ywb.212.1675364200573; Thu, 02
 Feb 2023 10:56:40 -0800 (PST)
MIME-Version: 1.0
References: <20221101222520.never.109-kees@kernel.org> <20221101223321.1326815-5-keescook@chromium.org>
 <CAMSo37W3gRkP02tSCxGX71ZDAt3WgPZrkTRTM6J1iQ4gvUS9vg@mail.gmail.com>
 <CANDhNCogJrvt=yEXFK-xVmGjkcRxSNGZUqUeNw2MV9bFRrwPdQ@mail.gmail.com> <63dbf04a.630a0220.2608a.0149@mx.google.com>
In-Reply-To: <63dbf04a.630a0220.2608a.0149@mx.google.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 2 Feb 2023 10:56:29 -0800
Message-ID: <CANDhNCoJJs_jSAdr6uved=cK=-6+nzSJq3e_E3HgtiXHZXkVww@mail.gmail.com>
Subject: Re: [PATCH 5/6] driver core: Add __alloc_size hint to devm allocators
To:     Kees Cook <keescook@chromium.org>
Cc:     Yongqin Liu <yongqin.liu@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Nishanth Menon <nm@ti.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>,
        David Gow <davidgow@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 9:18 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 01, 2023 at 12:11:41AM -0800, John Stultz wrote:
> > On Tue, Jan 31, 2023 at 11:36 PM Yongqin Liu <yongqin.liu@linaro.org> wrote:
> > > This change causes "Kernel panic - not syncing: BRK handler: Fatal exception"
> > > for the android-mainline based hikey960 build, with this commit reverted,
> > > there is no problem for the build to boot to the homescreen.
> > > Not sure if you have any idea about it and give some suggestions.
> > >
> > > Here is part of the kernel panic log:
...
> > Here as nr_sensors=1, we allocate only one structure for the array.
> > But then below that, we modify two entries, writing past the valid
> > array, and corrupting data when writing the second sensor values.
> >
> > data->sensor[0].id = HI3660_BIG_SENSOR;
> > data->sensor[0].irq_name = "tsensor_a73";
> > data->sensor[0].data = data;
> >
> > data->sensor[1].id = HI3660_LITTLE_SENSOR;
> > data->sensor[1].irq_name = "tsensor_a53";
> > data->sensor[1].data = data;
> >
> > I suspect nr_sensors needs to be set to 2.
> >
> > Nice work, Kees!
>
> Yay for compilers! :)

Well, I know it's not trivial to make the compilers catch these
things, so yay for you and others putting in all the effort on this as
well.

That said, making sense of the error message isn't completely trivial
either. I've been seeing a few cases recently of some of the new
compiler tooling (I pinged you earlier on a CFI one) causing errors
that developers aren't really sure how to address.  I know sometimes
it's not easy to surface the errors with context to what was wrong,
but at the risk of intense bike shedding, is there some way to provide
something like "Likely array bounds error" instead of just "BRK
handler: Fatal exception"?

> Was a patch sent to fix this driver?

I think YongQin is looking into it (either setting the nr_sensors
value to 2 or dropping the second sensor access).

thanks
-john
