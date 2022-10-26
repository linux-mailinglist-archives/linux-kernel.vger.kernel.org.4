Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250A60E14E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiJZM6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiJZM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D1F63C2;
        Wed, 26 Oct 2022 05:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD4F61EBB;
        Wed, 26 Oct 2022 12:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CFFC433C1;
        Wed, 26 Oct 2022 12:58:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gkw7X8XF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666789117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCEjyF4eeUdu2SGiHo/u6gxWDuuFvR0oywxSo4xTaE4=;
        b=Gkw7X8XFs5wZwIyVAA/OlHPNfvcvma8qpkZTuOrtLdOtLXEREYRyEbP7TT4Oe8qi1TT5s1
        DyaTa94c8ILXgCb40n4ePKMo5zfm+BoHmDM7CbTubM/SBhoFGTI+8uUQ40dJ6DDtUSxUpV
        /MU/yosRl5pfdP0cTO20yH1XVE9BOTE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ebb8279 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Oct 2022 12:58:37 +0000 (UTC)
Date:   Wed, 26 Oct 2022 14:58:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>, cocci@inria.fr
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Message-ID: <Y1ku+jfRAyezq6Nz@zx2c4.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1iSYddi3BpP8gvf@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> The traditional objdump comparison does work, though. It produces a good

Another thing that appears to work well is just using Coccinelle
scripts. I've had some success just scrolling through the results of:

    @@
    char c;
    expression E;
    @@
    (
    * E > c
    |
    * E >= c
    |
    * E < c
    |
    * E <= c
    )

That also triggers on explicitly signed chars, and examining those
reveals that quite a bit of code in the tree already does do the right
thing, which is good.

From looking at this and objdump output, it looks like most naked-char
usage that isn't for strings is actually already assuming it's unsigned,
using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
things here and there, but all and all, I don't think this is looking as
terrible as I initially feared.

I'm CC'ing the Coccinelle people to see if they have any nice ideas on
improvements. Specifically, the thing we're trying to identify is:

  - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
    where:
  - It's not being used for characters; and
  - It's doing something that assumes it is signed, such as various
    types of comparisons or decrements.

LWN wrote a summary of the general problem, in case that helps describe
what would be useful: https://lwn.net/SubscriberLink/911914/f90c2ed1af23cbc4/

Any nice Cocci tricks for this?

Jason
