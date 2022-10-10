Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62E5FA365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJJScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJJScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:32:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B676562
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C550B81057
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D167DC433C1;
        Mon, 10 Oct 2022 18:32:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mey1ND0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665426757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1a+bxLm+ve527cB16nyu9GqAzFTm5QbaoCevS+rdKI=;
        b=mey1ND0e996NxZqTdSJDrQB0VAxqJxurq0ekZmnkCpn9XiBQAt+RYPKjnKwJXRVWGieHvs
        Ny1fu1x+oTfCegAVrjzPuO3ECo0XRxiblXiYLIR4322vf2QhDAWN7lhCaOksNrNFrx+Cng
        gQUwk7Q4MV/J3P1hP/1jHtXXoRQjp/4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e72dd8db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 18:32:36 +0000 (UTC)
Date:   Mon, 10 Oct 2022 12:32:34 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, sultan@kerneltoast.com
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1
Message-ID: <Y0RlQi/72JrfW3df@zx2c4.com>
References: <20221003174431.1189919-1-Jason@zx2c4.com>
 <CAHk-=wgGc7MYRW=vXyY-m_r9c7-_i8k1nsHM0RuJw_9qZWWP9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGc7MYRW=vXyY-m_r9c7-_i8k1nsHM0RuJw_9qZWWP9g@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Mon, Oct 10, 2022 at 10:48:42AM -0700, Linus Torvalds wrote:
> On Mon, Oct 3, 2022 at 10:45 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > - The original jitter algorithm intended (I believe) to schedule the timer for
> >   the next jiffy, not the next-next jiffy, yet it used mod_timer(jiffies + 1),
> >   which will fire on the next-next jiffy, instead of what I believe was
> >   intended, mod_timer(jiffies), which will fire on the next jiffy. So fix
> >   that. (If you did actually intend the next-next jiffy for this voodoo, let
> >   me know and I'll happily send you a new pull.)
> 
> Just as long as you verified that yes, it will actually do the next timer.
> 
> At some point we had timer logic that went "trigger timer callback
> immediately if it was in the past". I didn't want to have to worry
> about that, this the "jiffies + 1".
> 
> I suspect we long ago got rid of that "trigger immediately" because of
> deadlocks, and that I was just being a worry-wart about behavior that
> we haven't had for decades, so your patch looks fine. But you might
> want to make sure.

I checked this and it works. Sultan and I jumped pretty far down the
timers rabbit hole in the process of investigating 748bc4dd9e66
("random: use expired timer rather than wq for mixing fast pool"). If
you grep the kernel, expiring at "jiffies" is a fairly common pattern
too.

Jason
