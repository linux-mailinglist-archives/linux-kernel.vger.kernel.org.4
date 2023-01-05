Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2B65F724
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjAEW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjAEW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:57:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910EC671A9;
        Thu,  5 Jan 2023 14:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E1BB81C0D;
        Thu,  5 Jan 2023 22:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E39C433F0;
        Thu,  5 Jan 2023 22:57:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d3U57LHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672959449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INhUx6/3Xhk2/xGcSTChC+f55M0MZlL+ygV3JkGy+qw=;
        b=d3U57LHDK5/g5g3S5DBYHkQoCwcYk8ZV6a0oM3Z6SewXdvSOqXsdHHaQbe31rTK2/sDwM8
        uMa3NJfzLzSkKnpUMBkGoQwKDNdqTWO6cQbSV8C+gyuenY/YH3A7RWhDB0eL4EaO20uqvQ
        CziJ/xm7YuUGNCJojapunpRX30XKVzA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8daf678c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Jan 2023 22:57:29 +0000 (UTC)
Date:   Thu, 5 Jan 2023 23:57:26 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7dV1lVUYjqs8fh0@zx2c4.com>
References: <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 10:57:48PM +0100, Yann Droneaud wrote:
> Hi,
> 
> Le 03/01/2023 à 21:44, Jason A. Donenfeld a écrit :
> > On Tue, Jan 03, 2023 at 12:15:57PM -0800, Linus Torvalds wrote:
> >> On Tue, Jan 3, 2023 at 12:03 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>> That buffering cannot be done safely currently
> >> .. again, this is "your semantics" (the (b) in my humbug list), not
> >> necessarily reality for anybody else.
> > Yea that's fair. Except, of course, I maintain that my semantics are
> > important ones. :)
> 
> 
> I concur.
> 
> To hold secret material, we need MADV_WIPEONFORK | MADV_DONTDUMP and the side effect of mlock() (pages' content never written to swap), inherited across fork().
> And I want mlock() without paying the price.
> 
> Jason's proposed semantics, which I call MADV_WIPEONSWAP, provide a mean to hold /unlimited/ amount secrets in userspace memory (not limited by RLIMIT_MEMLOCK).
> The only constraint for userspace is to handle the case pages are wiped, which is already the case of userspace arc4random()'s implementation.

If you're actually serious about wanting a generic mechanism for
userspace, I think the moral of yesterday's poo-poo'ing all over this
cool new idea is that the Linux innercircle doesn't really care for
"security things" as a motivator and just takes the shortest and easiest
route toward swatting it away like a gadfly, assuming that the concerns
are unreal or niche or paranoid or whatever. This is obviously nothing
new - it's an old complaint beaten to death for years, with people who
are diehard it about eventually getting burnt out and leaving. So,
practically speaking, if you want this to exist, I think you have to
find some other cool use cases. Like, see if the database cache people
would actually love this. Or if it could be used as an opportunistic
renderer cache in Chrome that wouldn't result in OOMing with lots of
tabs. Or if shared process compiler servers could benefit from it.
"Droppable cache" is likely useful lots of places. So just find
SOMETHING that doesn't mean having to convince folks of a new security
model that justifies tickling mm/ innards in uncomfortable ways.

Jason
