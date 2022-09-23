Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555755E7DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiIWPMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiIWPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E9133C82
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6935961B10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A4C433D7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:11:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iBNxcG1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663945915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mqpchkG8w7T6ltNCeGHYbnB/s1s4N/4q1MnrJjyfBjM=;
        b=iBNxcG1S2n/Hrq7q73eM0nvQUwJW+gRk4RqmFp+1l7v3C/bgHKoS+/9AEPTjwu66GztvgM
        Ku5cHQ+Bkj/Y4dmLqTCrSZNfcz7d6j7pc4noIuMiwi8anbzMUxU/FaYi6PIL/aQnPYJ1ft
        VI1CTOsWq4kptmGa9qrTu1eDalNrDhI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4f92339 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 15:11:55 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id b81so315592vkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:11:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf0rUvzUTqEokp6fPZLNTCOy76VTDXvtdiNPI+bVdxdslp/RlZ+y
        qvNnxDADyHEaaCkkx6GG77DKBv5SMefg2E5UGF4=
X-Google-Smtp-Source: AMsMyM6c7wfSShTnksH+d4ZhOpG46cIyZplH3mpbBk1FgDyi1YROuyC4lnJtP3Z32HAW1dLD+9XmriayUZuk6zBV2gE=
X-Received: by 2002:a05:6122:91e:b0:3a2:e497:2484 with SMTP id
 j30-20020a056122091e00b003a2e4972484mr3746710vka.41.1663945914330; Fri, 23
 Sep 2022 08:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220923100621.3888015-1-Jason@zx2c4.com> <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
 <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com> <Yy3MgMhYDFYnLAV/@smile.fi.intel.com>
In-Reply-To: <Yy3MgMhYDFYnLAV/@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 17:11:43 +0200
X-Gmail-Original-Message-ID: <CAHmME9oLbcX_FSY8ZodKBPOvYXQsqsjTwioD-6Y=46BZehGbPA@mail.gmail.com>
Message-ID: <CAHmME9oLbcX_FSY8ZodKBPOvYXQsqsjTwioD-6Y=46BZehGbPA@mail.gmail.com>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra comparison
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Sep 23, 2022 at 5:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 23, 2022 at 12:40:47PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Sep 23, 2022 at 12:36 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Sep 23, 2022 at 12:06:21PM +0200, Jason A. Donenfeld wrote:
> > > > Currently the clamp algorithm does:
> > > >
> > > >       if (val > hi)
> > > >               val = hi;
> > > >       if (val < lo)
> > > >               val = lo;
> > > >
> > > > But since hi > lo by definition, this can be made more efficient with:
> > >
> > > It's strongly speaking, but we have to proof that, right?
> > > So, while I haven't checked the code, this change should also
> > > include (does it?) the corresponding compile-time checks (for
> > > constant arguments) in similar way how it's done for GENMASK().
> > >
> > > Otherwise I have no objections.
> >
> > I think most cases are with compile time constants, but some cases are
> > with variables. What should we do in that case? Checking variables at
> > runtime incurs the same cost as the old code. I guess we could do this
> > fast thing for constants and the slower old thing for non-constants?
> > Or not do either, keep this commit as is, and just accept that if you
> > pass bogus bounds to clamp, you're going to end up with something
> > weird, which is already the case now so not a big deal?
>
> I'm talking only for the cases where we _can_ check. For variables it's
> probably tricky to do at compile time if possible at all.

Okay, sure, I'll add a check in the case where we can check.

Jason
