Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC63661084
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjAGR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjAGR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:28:30 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C0197
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 09:28:29 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v14so4735546qtq.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb8/dxYTtsWxSA5bIXEU6Yf2xXp3cdFqGFZ23l+BPuA=;
        b=g9FwzkzAehlnWAOKCySz2K2WnFa5ScpJcrvi2qmP1p5u4XUjoRjjC6RF59+c+NW+t6
         3q4hlcvFEY5Q0fm6YiXIfsPtmSam1MHRnpzx3hE/MeakleM6RJyrs5Iq5MX/RJ0SsPtn
         7WlsbwTS50T6CNpXuIOfIXnt3taNaOKbe+my0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qb8/dxYTtsWxSA5bIXEU6Yf2xXp3cdFqGFZ23l+BPuA=;
        b=BGrF48RzTN5Am9SyAIwpU59Q+agZNaW8wWkXrbl76Y9nWsWYZmJ0F/mICyw3t/eIgm
         ui011bcqaJ2GfueaNkuHrA+as+WvAU45Kv6CF6WMAMsPzB4K3RYzlgQaho7NoAUooK2D
         P9Z3pi9czNVMTN8PIgKujDHRp4wLDsk6V0uSdhiP0+uSbhwt8RylD+BRUjdnchm+vhPw
         7c4PIKf/sc2AEHgPvpZrN7lRGWMMQRELORoGw5aq8D5iSOI3RwVhwRb2RlsHsINrRcWc
         iySjJpTxytW1t64xy73tSxzKjl2wnZD9tfRqCAPlqRqq6wxXnLTnxb13FYQGfyn3LMUf
         fnNA==
X-Gm-Message-State: AFqh2kr6bNQlzYe+zak9Z1Pchr+xJYODyocO9F+4HEhVKcLj/2oG2VKe
        ddgopixNnc8a2hPc4QLabOKkXqUuKADkgVLL
X-Google-Smtp-Source: AMrXdXtLnTlkkVIvH4lMte5yIajTZrOreQ3zmmoeUvTyqzRcFvE6WFQ8bBedlAPWrFFLsNVRhXeDLw==
X-Received: by 2002:ac8:73d5:0:b0:3ab:503f:2b47 with SMTP id v21-20020ac873d5000000b003ab503f2b47mr81917078qtp.43.1673112508316;
        Sat, 07 Jan 2023 09:28:28 -0800 (PST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8724d000000b00399fe4aac3esm2131375qtp.50.2023.01.07.09.28.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 09:28:26 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id h8so2221912qkk.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 09:28:26 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr2972740qkh.72.1673112506080; Sat, 07
 Jan 2023 09:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20221227030829.12508-1-kirill.shutemov@linux.intel.com>
 <20221227030829.12508-6-kirill.shutemov@linux.intel.com> <CAHk-=wgKTcOx1hhWAGJ-g9_9o7xiGJ9v9n2RskBSCkaUMBxDkw@mail.gmail.com>
 <20221231001029.5nckrhtmwahb65jo@box> <CAHk-=wgmGqwDD0kvjZxekU6uYR2x6+QgRHeMKy3snL2XYEzwEw@mail.gmail.com>
 <20230107091027.xbikgiizkeegofdd@box.shutemov.name>
In-Reply-To: <20230107091027.xbikgiizkeegofdd@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Jan 2023 09:28:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUcjPboro_P5qeFuuwAyqPEDRH8BvX0UFU1hNRfx+6Kw@mail.gmail.com>
Message-ID: <CAHk-=wjUcjPboro_P5qeFuuwAyqPEDRH8BvX0UFU1hNRfx+6Kw@mail.gmail.com>
Subject: Re: [PATCHv13 05/16] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Sat, Jan 7, 2023 at 1:10 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Dec 30, 2022 at 04:42:05PM -0800, Linus Torvalds wrote:
> > in ex_handler_uaccess() for the GP trap that users can now cause by
> > giving a non-canonical address with the high bit clear. So we'd
> > probably just want a new EX_TYPE_* for these cases, but that still
> > looks fairly straightforward.
>
> Plain _ASM_EXTABLE() seems does the trick.

Ack, for some reason I stupidly thought we'd have to change the
_ASM_EXTABLE_UA logic.

Thanks for setting me straight.

> Here's what I've come up with:

This looks good to me. And I like how you've used assembler macros
instead of the C preprocessor, it makes things more readable.

I'm personally so unused to asm macros that I never use them (and the
same is obviously true of Christoph who did that previous task size
thing), but I can appreciate others doing a better job at it.

So ack on this from me (I assume you tested it - hopefully even with
LAM), but maybe the x86 maintainers disagree violently?

The one possible downside is that *if* somebody passes non-valid user
addresses to get/put_user() intentionally (expecting an EFAULT), we
will now handle that much more slowly with a fault. But it would have
to be some really crazy use-case, and the normal case should be
simpler and faster.

But honestly, to me the upside is mainly "no need to worry about LAM
masking in asm code".

               Linus
