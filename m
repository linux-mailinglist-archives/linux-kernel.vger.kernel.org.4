Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06D615226
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKATUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKATUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:20:39 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D141C93C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:20:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b5so14261314pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+7m3bZypo6dhghlyAzOpNSDD/kv+tTj2Q4d+rYCS/og=;
        b=ZCVcPpLxiGzCICqw3qsqWg33Y++dpXuN77GfX3vWkEhCDU5vqhpIXjliRfiuue5vro
         BqKZR+64KSFiGrbOVGZPcAWQ1BHkna3Uu8lQju0w+tlHYTKgHh6rbxWnYoJhlPBNmX51
         /bXn+35ZP5AN3IcqSJBWJZLGqbnPjOS1aVchCpAkWL2CA4xeoDsXHzZBfsJGfwnKL/+M
         4ENbuBih5FOKtEUD06x+MprssH+AKyRGFdAMzbaNhSf4u4sPfwh0qvNcFHujwh5gDR4Q
         gi2CmCCdh13jB3OWtW2P76KrtaNrAlabjFLq02y9B6yW/wu8x4LuEdxwGfyV+ysnL1Si
         sfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7m3bZypo6dhghlyAzOpNSDD/kv+tTj2Q4d+rYCS/og=;
        b=wdwJJufTfZhCDrqZQX1Xr9M/ShMz3qLaZy8kERrC08zoekqksJLMnlc4fDNFHPBwl4
         U2UoBzFs0sIztKRgLI0oqjA5UB/DyhkA0kbOquVpw7KYKRqNBAbVLM6StHiB/cxCUZU8
         M7igqIr1xBlY17RCrUnBXQVrKlqrdWZbFv/+bu9UuPL3KSihjVlgQ40sckWA8XU7NWqM
         bUV6TtiID3zgTZtEKjRH8Jyyia2aRhjS1nWFm4JDeOviteZrgDTkl2gDARkz9ZSpZbC3
         1iHBZP6cccAfVWWu6yDWZB1CerGpXyCni1+8ExuDe4Jh51HcFx66hB2iHNjds1uY0R9I
         IkJg==
X-Gm-Message-State: ACrzQf3jDE/PXHTU7/KaQcgxa7OT9EXXLzXe28WH3rVY79HI80DiBY2X
        f6BG6r/VTWeJusj8TrsQtDI20A==
X-Google-Smtp-Source: AMsMyM4DSX5aQaSlSc9t3DRUmShOOGsQgE+GL4tPDpKnyhhuvMhiLZtjmwIZkOGD07wRIh2EnrXG2A==
X-Received: by 2002:a63:a555:0:b0:46f:f363:635d with SMTP id r21-20020a63a555000000b0046ff363635dmr3293752pgu.212.1667330436694;
        Tue, 01 Nov 2022 12:20:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a3fc100b0020dc318a43esm6337288pjm.25.2022.11.01.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 12:20:36 -0700 (PDT)
Date:   Tue, 1 Nov 2022 19:20:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] KVM: selftests: Add atoi_positive() and
 atoi_non_negative() for input validation
Message-ID: <Y2FxgNCw11tA7yDz@google.com>
References: <20221031173819.1035684-1-vipinsh@google.com>
 <20221031173819.1035684-5-vipinsh@google.com>
 <Y2AmgObslx57+uYt@google.com>
 <CAHVum0fhangxMp5ysYdyoKVY+CKWeBAadMFX1V8MgqryRGHQrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVum0fhangxMp5ysYdyoKVY+CKWeBAadMFX1V8MgqryRGHQrw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022, Vipin Sharma wrote:
> On Mon, Oct 31, 2022 at 12:48 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Oct 31, 2022, Vipin Sharma wrote:
> > > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > > index ec0f070a6f21..210e98a49a83 100644
> > > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > > @@ -353,3 +353,19 @@ int atoi_paranoid(const char *num_str)
> > >
> > >       return num;
> > >  }
> > > +
> > > +uint32_t atoi_positive(const char *num_str)
> >
> > I think it makes sense to inline atoi_positive() and atoi_non_negative() in
> > test_util.h.  Depending on developer's setups, it might be one less layer to jump
> > through to look at the implementation.
> >
> 
> I am not sure if this makes life much easier for developers, as
> "inline" can totally be ignored by the compiler. Also, not sure how
> much qualitative improvement it will add in the developer's code
> browsing journey. Anyways, I will add "inline" in the next version.

To be clear, it's not about adding "inline", it's about not having separate
declarations and definitions.  E.g. I've yet to achieve a setup that has 100%
accuracy when it comes to navigating to a definition versus a declaration.  And
when poking around code, seeing a "static inline" function provides a hint that
a function is likely a simple wrapper without even having to look at the
implementation.

These are all small things, but I can't think of a reason _not_ to inline these
trivial wrappers.

> > Last thought: my vote would be to ignore the 80 char soft limit when adding the
> > "name" to these calls, in every case except nr_memslot_modifications the overrun
> > is relatively minor and not worth wrapping.  See below for my thougts on that one.
> >
> > >                       break;
> > >               case 'm':
> > > -                     max_mem = atoi_paranoid(optarg) * size_1gb;
> > > +                     max_mem = atoi_positive(optarg) * size_1gb;
> > >                       TEST_ASSERT(max_mem > 0, "memory size must be >0");
> >
> > This assert can be dropped, max_mem is a uint64_t so wrapping to '0' is impossible.
> >
> 
> I intentionally kept it, as it is also protecting against having
> accidently making size_1gb to 0.

Heh, the test has far, far bigger problems if it screws up size_1gb.  And that's
an orthogonal concern as the test would be horrifically broken regardless of
whether or not the user specified '-m' and/or '-s'.

A better approach is to replace the homebrewed size_1gb with SZ_1G from
tools/include/linux/sizes.h.  I, and many others, completely overlooked size.h.
