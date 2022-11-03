Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75857617EED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKCOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKCOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:07:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40F300;
        Thu,  3 Nov 2022 07:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F869B826F3;
        Thu,  3 Nov 2022 14:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F92C433D6;
        Thu,  3 Nov 2022 14:07:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="plmrmS6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667484461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFg3TXoQvAE5JZJs4RqceEdy9J4w29ijlQhEeAO7+1I=;
        b=plmrmS6mFbWQiE0NyZ0HMok373WIZ3CruzIEfIh8gO0QP3wz/TJCbtjGaQjCrdkraYmURU
        Ra5LTXGZHAKhKST9PeC4htWjqPDOdR+PQNaJw5pYeCZXrFzA/Q4yny4W2ks8HUR4Lul/nO
        650VepRnSG5fgGZOE1H/cNEEw1L6Aok=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7db6b5a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Nov 2022 14:07:40 +0000 (UTC)
Date:   Thu, 3 Nov 2022 15:07:37 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <keescook@chromium.org>, cocci@inria.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y2PLKc1yeUTV4YFL@zx2c4.com>
References: <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com>
 <b72d866d-1dce-7260-7f1e-54be9fd25e97@inria.fr>
 <Y2MGlTwh9aB+4z4l@zx2c4.com>
 <d930b8af-7cb-c652-c3a4-cf8e9bdd610@inria.fr>
 <CAHmME9o3BDe+s2QaT4X8jg+9cc9A-3iHWnL0WnFyqKcGuhahXQ@mail.gmail.com>
 <8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e7bcf3-2d39-a9f2-f818-ec627e5d5c4e@inria.fr>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:57:26PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 3 Nov 2022, Jason A. Donenfeld wrote:
> 
> > Hi Julia,
> >
> > On Thu, Nov 3, 2022 at 1:45 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > It should work now.
> >
> > Thanks!
> >
> > > However, without disable optional_qualifier, char is
> > > still matching signed char.  If you think that should be changed, I can do
> > > that.
> >
> > Does `optional_qualifier` disable other things that might be
> > interesting to have? If so, maybe this is less than ideal? If not,
> > maybe it doesn't matter?
> 
> Optional qualifier only allows a metavariable declared to have a certain
> type to match an expression that has the same type with signed, const, or
> verbatim in front of it.  Disabling it forces you to write our signed,
> const etc explicitly when you want them.  So rules may becomes more
> verbose.

Oh, huh. Maybe best to treat it as a different type then so that's not
required? I was also thinking that it doesn't totally make sense the way
it is now, in that `char` is *NOT* signed on many platforms, such as
arm. In 6.2, it'll be unsigned everywhere, for kernel code. So in the
general case, for coccinelle, it's a bit of a heisentype and so maybe
should be treated as distinct from `signed char` or `unsigned char`.

Jason
